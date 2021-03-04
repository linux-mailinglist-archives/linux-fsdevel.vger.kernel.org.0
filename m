Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A404F32D485
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 14:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241527AbhCDNtH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 08:49:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33525 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241480AbhCDNsl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 08:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614865635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hNSJeU6DHgk1JDrXPc6wXwBH7UNAGKwi0d2+igWtU6Y=;
        b=SnjAsjpErilPN7UqsfPvyID4eHUhI97DdfqH6C27rpzEgZ4XX8+k3y8fOv/jX8xdlEVTbe
        hYBBWHINrJpRx05l7CyqMnaOS/tsL2HMjhtWd7IuXrGtkYGtwFANUXhWvvI9JFrF/u5YFJ
        e7ketTp5CzVunoohCB7NSRKFsjcTMvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-hcFeYL5qNHGg6spmwsZ5Zw-1; Thu, 04 Mar 2021 08:47:13 -0500
X-MC-Unique: hcFeYL5qNHGg6spmwsZ5Zw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76E8BEC1A3;
        Thu,  4 Mar 2021 13:47:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-66.rdu2.redhat.com [10.10.112.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D08AD5C1A1;
        Thu,  4 Mar 2021 13:47:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <2653261.1614813611@warthog.procyon.org.uk>
References: <2653261.1614813611@warthog.procyon.org.uk>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: fscache: Redesigning the on-disk cache - LRU handling
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2973222.1614865624.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 04 Mar 2021 13:47:04 +0000
Message-ID: <2973223.1614865624@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> =

>  (3) OpenAFS-style format.  One index file to look up {file_key,block#} =
and an
>      array of data files, each holding one block (e.g. a 256KiB-aligned =
chunk
>      of a file).  Each index entry has valid start/end offsets for easy
>      truncation.
> =

>      The index has a hash to facilitate the lookup and an LRU that allow=
s a
>      block to be recycled at any time.

The LRU would probably have to be a doubly-linked list so that entries can=
 be
removed from it easily.  This means typically touching two other entries,
which might not be in the same page; further, if the entry is being freed,
we'd need to excise it from the hash chain also, necessitating touching ma=
ybe
two more entries - which might also be in different pages.

Maybe the LRU idea plus a free block bitmap could be combined, however.

 (1) Say that there's a bit-pair map, with one bit pair per block.  The pa=
ir
     is set to 0 when the block is free.  When the block is accessed, the =
pair
     is set to 3.

 (2) When we run out of free blocks (ie. pairs that are zero), we decremen=
t
     all the pairs and then look again.

 (3) Excision from the old hash chain would need to be done at allocation,
     though it does give a block whose usage has been reduced to 0 the cha=
nce
     to be resurrected.

Possible variations on the theme could be:

 (*) Set the pair to 2, not 3 when accessed.  Set the block to 3 to pin it=
;
     the process of decrementing all the pairs would leave it at 3.

 (*) Rather than decrementing all pairs at once, have a rotating window th=
at
     does a part of the map at once.

 (*) If a round of decrementing doesn't reduce any pairs to zero, reject a
     request for space.

This would also work for a file index.

David

