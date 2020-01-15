Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 991FF13C4E1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 15:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgAOOFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 09:05:17 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50158 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728984AbgAOOFO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579097113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1n/T1HYTx3Wj9p4CFNGnVwbEfYR6X36ZeaddeQ07/js=;
        b=HMSZ20cjbwTc3rLRP+/78QaP53VNmf8ooFNZz4zPqut3OhtLBW/Xd8hvO58t1xDKY+J8zn
        Nb/OzM14jtOf9jdeNC7aTVkbVIgY7ghGv5XrFzYDXlSsVn7NH9XU3Pyb56nMz15tcSeFlC
        NCjpC2+x6uiPjKKUAgBGC64E44mFdfs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-d9xR5pR-NzCKmch7BK0_fA-1; Wed, 15 Jan 2020 09:05:09 -0500
X-MC-Unique: d9xR5pR-NzCKmch7BK0_fA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 867D010AF3DA;
        Wed, 15 Jan 2020 14:05:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF8221084200;
        Wed, 15 Jan 2020 14:05:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com>
References: <00fc7691-77d5-5947-5493-5c97f262da81@gmx.com> <4467.1579020509@warthog.procyon.org.uk>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, hch@lst.de, tytso@mit.edu,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Problems with determining data presence by examining extents?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <23357.1579097103.1@warthog.procyon.org.uk>
Date:   Wed, 15 Jan 2020 14:05:03 +0000
Message-ID: <23358.1579097103@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> At least for btrfs, only unaligned extents get padding zeros.

What is "unaligned" defined as?  The revised cachefiles reads and writes 256k
blocks, except for the last - which gets rounded up to the nearest page (which
I'm assuming will be some multiple of the direct-I/O granularity).  The actual
size of the data is noted in an xattr so I don't need to rely on the size of
the cachefile.

> (c): A multi-device fs (btrfs) can have their own logical address mapping.
> Meaning the bytenr returned makes no sense to end user, unless used for
> that fs specific address space.

For the purpose of cachefiles, I don't care where it is, only whether or not
it exists.  Further, if a DIO read will return a short read when it hits a
hole, then I only really care about detecting whether the first byte exists in
the block.

It might be cheaper, I suppose, to initiate the read and have it fail
immediately if no data at all is present in the block than to do a separate
ask of the filesystem.

> You won't like this case either.
> (d): Compressed extents
> One compressed extent can represents more data than its on-disk size.

Same answer as above.  Btw, since I'm using DIO reads and writes, would these
get compressed?

> And even more bad news:
> (e): write time dedupe
> Although no fs known has implemented it yet (btrfs used to try to
> support that, and I guess XFS could do it in theory too), you won't
> known when a fs could get such "awesome" feature.

I'm not sure this isn't the same answer as above either, except if this
results in parts of the file being "filled in" with blocks of zeros that I
haven't supplied.  Couldn't this be disabled on an inode-by-inode basis, say
with an ioctl?

> > Without being able to trust the filesystem to tell me accurately what I've
> > written into it, I have to use some other mechanism.  Currently, I've
> > switched to storing a map in an xattr with 1 bit per 256k block, but that
> > gets hard to use if the file grows particularly large and also has
> > integrity consequences - though those are hopefully limited as I'm now
> > using DIO to store data into the cache.
> 
> Would you like to explain why you want to know such fs internal info?

As Andreas pointed out, fscache+cachefiles is used to cache data locally for
network filesystems (9p, afs, ceph, cifs, nfs).  Cached files may be sparse,
with unreferenced blocks not currently stored in the cache.

I'm attempting to move to a model where I don't use bmap and don't monitor
bit-waitqueues to find out when page flags flip on backing files so that I can
copy data out, but rather use DIO directly to/from the network filesystem
inode pages.

Since the backing filesystem has to keep track of whether data is stored in a
file, it would seem a shame to have to maintain a parallel copy on the same
medium, with the coherency issues that entail.

David


