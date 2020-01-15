Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05F2513BB45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 09:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgAOIi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 03:38:58 -0500
Received: from verein.lst.de ([213.95.11.211]:49605 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgAOIi6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:38:58 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9E17968B05; Wed, 15 Jan 2020 09:38:54 +0100 (CET)
Date:   Wed, 15 Jan 2020 09:38:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, hch@lst.de,
        tytso@mit.edu, adilger.kernel@dilger.ca, darrick.wong@oracle.com,
        clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Problems with determining data presence by examining extents?
Message-ID: <20200115083854.GB23039@lst.de>
References: <4467.1579020509@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4467.1579020509@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
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

The whole idea of an out of band interface is going to be racy and suffer
from implementation loss.  I think what you want is something similar to
the NFSv4.2 READ_PLUS operation - give me that if there is any and
otherwise tell me that there is a hole.  I think this could be a new
RWF_NOHOLE or similar flag, just how to return the hole size would be
a little awkward.  Maybe return a specific negative error code (ENODATA?)
and advance the iov anyway.
