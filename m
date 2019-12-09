Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5EA116E66
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 15:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfLIOA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 09:00:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35013 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726687AbfLIOA3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:00:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575900027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VQdYChUYPRwBtiwoaKfcOJXruVCbc28umUKlhLFhzOc=;
        b=DFGBNiwZL4BPRYZNvUmi2oWpg++36S5vZ6hG7o01gcgjmPz3cxCfx40Oxyzephvo1unVGx
        MINWvVJmEYzDG6u141YzNxfOaDknweu1TZpo+9kOtr4J/KHWVZocBaU1dHyi+6mN05AasN
        sCIXSTaR8WVNUOgasovWm7oyCgvMVZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-FziZ82VkOq-scynChaHufQ-1; Mon, 09 Dec 2019 09:00:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 741EC96BF1;
        Mon,  9 Dec 2019 14:00:21 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 809D45DA2C;
        Mon,  9 Dec 2019 14:00:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     lsf-pc@lists.linux-foundation.org
cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [LSF/MM/BPF TOPIC] How to make fscache/cachefiles read shaping play nicely with the VM?
MIME-Version: 1.0
Content-ID: <9607.1575900019.1@warthog.procyon.org.uk>
Date:   Mon, 09 Dec 2019 14:00:19 +0000
Message-ID: <9608.1575900019@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: FziZ82VkOq-scynChaHufQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I've been rewriting fscache and cachefiles to massively simplify it and mak=
e
use of the kiocb interface to do direct-I/O to/from the netfs's pages which
didn't exist when I first did this.  Instead it has been attempting to moni=
tor
the page bit waitqueues to see when the backing filesystem's pages become u=
p
to date.

=09https://lore.kernel.org/lkml/24942.1573667720@warthog.procyon.org.uk/
=09https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/lo=
g/?h=3Dfscache-iter

To make it more efficient, following other network filesystems implementati=
ons
outside of the Linux kernel, I'm attempting to move to requiring reads and
writes to the cache in much bigger granules (fixed at 256KiB initially), wh=
ich
means that I can represent the presence of a granule of that much data with=
 a
single bit.

So far, I've done this for ->readpages(), ->readpage() and ->write_begin() =
by
taking the requested page or pages and expanding/contracting the set of pag=
es
as necessary so that the first (or only) actually requested page is in ther=
e
and both ends of the sequence are appropriate aligned.

This, however, is at odds with the VM and *its* idea of how to do things -
particularly for ->readpages().  The logic of my fscache_read_helper()[*] i=
s
applied after the VM's readahead logic, and the two don't necessarily see e=
ye
to eye at present.

[*] This is in the patch named "fscache: Add read helper" in the
    above-mentioned git tree and "afs: Use new fscache I/O API" which has
    examples of using it.

There are some things that need to be taken into consideration:

 (1) I might want to make the granule size variable both by file and over t=
he
     length of a file.  So for a file that's, say, <=3D512MiB in size, I mi=
ght
     want 1 bit per 256KiB granule, but over 512MiB I might want to switch =
to
     1 bit per 1MiB granule.  Or for files that large, just use 1MiB granul=
es
     all the way through.

 (2) The granule size might also need vary by cache.

 (3) Some files I want to treat as monolithic.  The file is either all ther=
e
     or none of it is.  Examples might be non-regular files such as symlink=
s
     or directories.

 (4) These parameters might be tunable by the admin.

So how best to make the VM deal with this?  Is it better to integrate such
logic into the VM or leave it on top?

David

