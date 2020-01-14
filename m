Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78BB913B57A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 23:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgANWvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 17:51:02 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33606 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728746AbgANWvB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 17:51:01 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-108.corp.google.com [104.133.0.108] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00EMnH2t015142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 17:49:18 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 441C34207DF; Tue, 14 Jan 2020 17:49:17 -0500 (EST)
Date:   Tue, 14 Jan 2020 17:49:17 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, hch@lst.de,
        adilger.kernel@dilger.ca, darrick.wong@oracle.com, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Problems with determining data presence by examining extents?
Message-ID: <20200114224917.GA165687@mit.edu>
References: <4467.1579020509@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4467.1579020509@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 14, 2020 at 04:48:29PM +0000, David Howells wrote:
> Again with regard to my rewrite of fscache and cachefiles:
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter
> 
> I've got rid of my use of bmap()!  Hooray!
> 
> However, I'm informed that I can't trust the extent map of a backing file to
> tell me accurately whether content exists in a file because:
> 
>  (a) Not-quite-contiguous extents may be joined by insertion of blocks of
>      zeros by the filesystem optimising itself.  This would give me a false
>      positive when trying to detect the presence of data.
> 
>  (b) Blocks of zeros that I write into the file may get punched out by
>      filesystem optimisation since a read back would be expected to read zeros
>      there anyway, provided it's below the EOF.  This would give me a false
>      negative.
> 
> Is there some setting I can use to prevent these scenarios on a file - or can
> one be added?

I don't think there's any way to do this in a portable way, at least
today.  There is a hack we could be use that would work for ext4
today, at least with respect to (a), but I'm not sure we would want to
make any guarantees with respect to (b).

I suspect I understand why you want this; I've fielded some requests
for people wanting to do something very like this at $WORK, for what I
assume to be for the same reason you're seeking to do this; to create
do incremental caching of files and letting the file system track what
has and hasn't been cached yet.

If we were going to add such a facility, what we could perhaps do is
to define a new flag indicating that a particular file should have no
extent mapping optimization applied, such that FIEMAP would return a
mapping if and only if userspace had written to a particular block, or
had requested that a block be preallocated using fallocate().  The
flag could only be set on a zero-length file, and this might disable
certain advanced file system features, such as reflink, at the file
system's discretion; and there might be unspecified performance
impacts if this flag is set on a file.

File systems which do not support this feature would not allow this
flag to be set.

				- Ted
