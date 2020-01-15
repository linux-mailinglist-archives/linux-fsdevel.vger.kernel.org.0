Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16CCD13C397
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 14:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbgAONuY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 08:50:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44537 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726085AbgAONuV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:50:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579096220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w+swK9osAIFZi3cI9plfEPgc0HcD0yrb1cBEuZ3PWuI=;
        b=CE5Gv8OjqLpwR9x9G/v76Xqsw0JqrzhccwgY88x6gdAN0WaRJQ1VdgeGQcXRwPWACULl2v
        oNtIL+FQwUKOArNC8LmAiGj4u4p8kQxT43j+P6eBP7asPoRTuO4vC+s1Ko0YZIUIE2nBNd
        pVVMWJeBj15pTcbdfH0lU2r3IJJoQjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-GOHqpJ9cNSinEYjPiomTzw-1; Wed, 15 Jan 2020 08:50:16 -0500
X-MC-Unique: GOHqpJ9cNSinEYjPiomTzw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 837421005502;
        Wed, 15 Jan 2020 13:50:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-52.rdu2.redhat.com [10.10.120.52])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 142CC19C5B;
        Wed, 15 Jan 2020 13:50:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200114224917.GA165687@mit.edu>
References: <20200114224917.GA165687@mit.edu> <4467.1579020509@warthog.procyon.org.uk>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, hch@lst.de, adilger.kernel@dilger.ca,
        darrick.wong@oracle.com, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Problems with determining data presence by examining extents?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <22055.1579096211.1@warthog.procyon.org.uk>
Date:   Wed, 15 Jan 2020 13:50:11 +0000
Message-ID: <22056.1579096211@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Theodore Y. Ts'o <tytso@mit.edu> wrote:

> but I'm not sure we would want to make any guarantees with respect to (b).

Um.  That would potentially make disconnected operation problematic.  Now,
it's unlikely that I'll want to store a 256KiB block of zeros, but not
impossible.

> I suspect I understand why you want this; I've fielded some requests
> for people wanting to do something very like this at $WORK, for what I
> assume to be for the same reason you're seeking to do this; to create
> do incremental caching of files and letting the file system track what
> has and hasn't been cached yet.

Exactly so.  If I can't tap in to the filesystem's own map of what data is
present in a file, then I have to do it myself in parallel.  Keeping my own
list or map has a number of issues:

 (1) It's redundant.  I have to maintain a second copy of what the filesystem
     already maintains.  This uses extra space.

 (2) My map may get out of step with the filesystem after a crash.  The
     filesystem has tools to deal with this in its own structures.

 (3) If the file is very large and sparse, then keeping a bit-per-block map in
     a single xattr may not suffice or may become unmanageable.  There's a
     limit of 64k, which for bit-per-256k limits the maximum mappable size to
     1TiB (I could use multiple xattrs, but some filesystems may have total
     xattr limits) and whatever the size, I need a single buffer big enough to
     hold it.

     I could use a second file as a metadata cache - but that has worse
     coherency properties.  (As I understand it, setxattr is synchronous and
     journalled.)

> If we were going to add such a facility, what we could perhaps do is
> to define a new flag indicating that a particular file should have no
> extent mapping optimization applied, such that FIEMAP would return a
> mapping if and only if userspace had written to a particular block, or
> had requested that a block be preallocated using fallocate().  The
> flag could only be set on a zero-length file, and this might disable
> certain advanced file system features, such as reflink, at the file
> system's discretion; and there might be unspecified performance
> impacts if this flag is set on a file.

That would be fine for cachefiles.

Also, I don't need to know *where* the data is, only that the first byte of my
block exists - if a DIO read returns short when it reaches a hole.

David

