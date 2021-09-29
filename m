Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46F841C8AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 17:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245486AbhI2PrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 11:47:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57780 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245674AbhI2Pqx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 11:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632930311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YD/JzDwhuk7rGKkEzFS8gH/oiqrA2eu324rL5fdp0h4=;
        b=Oun1CS/awVfg5ooEQX8a82Sz96Surv5GuqROnHLCervpckLhNEpw639+2pC1zsn7FbNy7Z
        P0mcuAlsE59Zmvww2LvDZ27kbquU8v4XejBOmda42KJxvc5Coq2rsaSJpuk+vU+6hNYUT6
        8MtF3x0wf5OHLjjRqQ7YfWpSNZtV/O8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-RydRWjxQMwK58uTqWu6Ekw-1; Wed, 29 Sep 2021 11:45:08 -0400
X-MC-Unique: RydRWjxQMwK58uTqWu6Ekw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00CAB1006AA3;
        Wed, 29 Sep 2021 15:45:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51DD86A900;
        Wed, 29 Sep 2021 15:45:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20210927200708.GI9286@twin.jikos.cz>
References: <20210927200708.GI9286@twin.jikos.cz> <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
To:     dsterba@suse.cz
Cc:     dhowells@redhat.com
Cc:     willy@infradead.org, Chris Mason <clm@fb.com>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        Ilya Dryomov <idryomov@gmail.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v3 0/9] mm: Use DIO for swap and fix NFS swapfiles
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4005661.1632930302.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 29 Sep 2021 16:45:02 +0100
Message-ID: <4005662.1632930302@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Sterba <dsterba@suse.cz> wrote:

> > There are additional patches to get rid of noop_direct_IO and replace =
it
> > with a feature bitmask, to make btrfs, ext4, xfs and raw blockdevs use=
 the
> > new ->swap_rw method and thence remove the direct BIO submission paths=
 from
> > swap.
> > =

> > I kept the IOCB_SWAP flag, using it to enable REQ_SWAP.  I'm not sure =
if
> > that's necessary, but it seems accounting related.
>
> There was probably some step missing. The file must not have holes, so
> either do 'dd' to the right size or use fallocate (which is recommended
> in manual page btrfs(5) SWAPFILE SUPPORT). There are some fstests
> exercising swapfile (grep -l _format_swapfile tests/generic/*) so you
> could try that without having to set up the swapfile manually.

Yeah.  As advised elsewhere, I removed the file and recreated it, doing th=
e
chattr before extending the file.  At that point swapon worked.  It didn't
work though, and various userspace programs started dying.  I'm guessing m=
y
btrfs_swap_rw() is wrong somehow.

David

