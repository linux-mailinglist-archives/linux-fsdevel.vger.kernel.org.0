Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC26F2C481F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 20:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgKYTTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 14:19:49 -0500
Received: from sandeen.net ([63.231.237.45]:59480 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgKYTTt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:19:49 -0500
Received: from liberator.sandeen.net (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 2C83D323C1C;
        Wed, 25 Nov 2020 13:19:42 -0600 (CST)
To:     linux-fsdevel@vger.kernel.org
From:   Eric Sandeen <sandeen@sandeen.net>
Cc:     David Howells <dhowells@redhat.com>
Subject: Clarification of statx->attributes_mask meaning?
Message-ID: <33d38621-b65c-b825-b053-eda8870281d1@sandeen.net>
Date:   Wed, 25 Nov 2020 13:19:48 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The way attributes_mask is used in various filesystems seems a bit
inconsistent.

Most filesystems set only the bits for features that are possible to enable
on that filesystem, i.e. XFS:

        if (ip->i_d.di_flags & XFS_DIFLAG_IMMUTABLE)
                stat->attributes |= STATX_ATTR_IMMUTABLE;
        if (ip->i_d.di_flags & XFS_DIFLAG_APPEND)
                stat->attributes |= STATX_ATTR_APPEND;
        if (ip->i_d.di_flags & XFS_DIFLAG_NODUMP)
                stat->attributes |= STATX_ATTR_NODUMP;

        stat->attributes_mask |= (STATX_ATTR_IMMUTABLE |
                                  STATX_ATTR_APPEND |
                                  STATX_ATTR_NODUMP);

btrfs, cifs, erofs, ext4, f2fs, hfsplus, orangefs and ubifs are similar.

But others seem to set the mask to everything it can definitively answer,
i.e. "Encryption and compression are off, and we really mean it" even though
it will never be set to one in ->attributes, i.e. on gfs2:

        if (gfsflags & GFS2_DIF_APPENDONLY)
                stat->attributes |= STATX_ATTR_APPEND;
        if (gfsflags & GFS2_DIF_IMMUTABLE)
                stat->attributes |= STATX_ATTR_IMMUTABLE;

        stat->attributes_mask |= (STATX_ATTR_APPEND |
                                  STATX_ATTR_COMPRESSED |
                                  STATX_ATTR_ENCRYPTED |
                                  STATX_ATTR_IMMUTABLE |
                                  STATX_ATTR_NODUMP);

ext2 is similar (it adds STATX_ATTR_ENCRYPTED to the mask but will never set
it in attributes)

The commit 3209f68b3ca4 which added attributes_mask says:

"Include a mask in struct stat to indicate which bits of stx_attributes the
filesystem actually supports."

The manpage says:

"A mask indicating which bits in stx_attributes are supported by the VFS and
the filesystem."

-and-

"Note that any attribute that is not indicated as supported by stx_attributes_mask
has no usable value here."

So is this intended to indicate which bits of statx->attributes are valid, whether
they are 1 or 0, or which bits could possibly be set to 1 by the filesystem?

If the former, then we should move attributes_mask into the VFS to set all flags
known by the kernel, but David's original commit did not do that so I'm left
wondering...

Thanks,
-Eric
