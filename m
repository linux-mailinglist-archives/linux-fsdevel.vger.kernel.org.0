Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5734F2C4A36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 22:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbgKYVmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 16:42:49 -0500
Received: from sandeen.net ([63.231.237.45]:38150 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728642AbgKYVms (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 16:42:48 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 28EB6324E60;
        Wed, 25 Nov 2020 15:42:41 -0600 (CST)
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
References: <33d38621-b65c-b825-b053-eda8870281d1@sandeen.net>
 <20201125212523.GB14534@magnolia>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: Clarification of statx->attributes_mask meaning?
Message-ID: <03781aa8-67f4-f131-cb27-2cd25c32e1b4@sandeen.net>
Date:   Wed, 25 Nov 2020 15:42:47 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201125212523.GB14534@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/25/20 3:25 PM, Darrick J. Wong wrote:
> On Wed, Nov 25, 2020 at 01:19:48PM -0600, Eric Sandeen wrote:
>> The way attributes_mask is used in various filesystems seems a bit
>> inconsistent.
>>
>> Most filesystems set only the bits for features that are possible to enable
>> on that filesystem, i.e. XFS:
>>
>>         if (ip->i_d.di_flags & XFS_DIFLAG_IMMUTABLE)
>>                 stat->attributes |= STATX_ATTR_IMMUTABLE;
>>         if (ip->i_d.di_flags & XFS_DIFLAG_APPEND)
>>                 stat->attributes |= STATX_ATTR_APPEND;
>>         if (ip->i_d.di_flags & XFS_DIFLAG_NODUMP)
>>                 stat->attributes |= STATX_ATTR_NODUMP;
>>
>>         stat->attributes_mask |= (STATX_ATTR_IMMUTABLE |
>>                                   STATX_ATTR_APPEND |
>>                                   STATX_ATTR_NODUMP);
>>
>> btrfs, cifs, erofs, ext4, f2fs, hfsplus, orangefs and ubifs are similar.
>>
>> But others seem to set the mask to everything it can definitively answer,
>> i.e. "Encryption and compression are off, and we really mean it" even though
>> it will never be set to one in ->attributes, i.e. on gfs2:
>>
>>         if (gfsflags & GFS2_DIF_APPENDONLY)
>>                 stat->attributes |= STATX_ATTR_APPEND;
>>         if (gfsflags & GFS2_DIF_IMMUTABLE)
>>                 stat->attributes |= STATX_ATTR_IMMUTABLE;
>>
>>         stat->attributes_mask |= (STATX_ATTR_APPEND |
>>                                   STATX_ATTR_COMPRESSED |
>>                                   STATX_ATTR_ENCRYPTED |
>>                                   STATX_ATTR_IMMUTABLE |
>>                                   STATX_ATTR_NODUMP);
>>
>> ext2 is similar (it adds STATX_ATTR_ENCRYPTED to the mask but will never set
>> it in attributes)
>>
>> The commit 3209f68b3ca4 which added attributes_mask says:
>>
>> "Include a mask in struct stat to indicate which bits of stx_attributes the
>> filesystem actually supports."
>>
>> The manpage says:
>>
>> "A mask indicating which bits in stx_attributes are supported by the VFS and
>> the filesystem."
>>
>> -and-
>>
>> "Note that any attribute that is not indicated as supported by stx_attributes_mask
>> has no usable value here."
>>
>> So is this intended to indicate which bits of statx->attributes are valid, whether
>> they are 1 or 0, or which bits could possibly be set to 1 by the filesystem?
>>
>> If the former, then we should move attributes_mask into the VFS to set all flags
>> known by the kernel, but David's original commit did not do that so I'm left
>> wondering...
> 
> Personally I thought that attributes_mask tells you which bits actually
> make any sense for the given filesystem, which means:
> 
> mask=1 bit=0: "attribute not set on this file"
> mask=1 bit=1: "attribute is set on this file"
> mask=0 bit=0: "attribute doesn't fit into the design of this fs"
> mask=0 bit=1: "filesystem is lying snake"
> 
> It's up to the fs driver and not the vfs to set attributes_mask, and
> therefore (as I keep pointing out to XiaoLi Feng) xfs_vn_getattr should
> be setting the mask.

That's what the original commit did, and that's what /most/ of the filesystems do.
And I agree with you on the dax flag there.

So I think ext2 & gfs2 are inconsistent and wrong, and should probably be changed
to remove flags from the mask which are unsupported by the filesystem.

-Eric
