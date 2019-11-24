Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BFA1084CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2019 20:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKXTtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Nov 2019 14:49:41 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51540 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfKXTtk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Nov 2019 14:49:40 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYxt0-0005eu-Q9; Sun, 24 Nov 2019 19:49:34 +0000
Date:   Sun, 24 Nov 2019 19:49:34 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, y2038@lists.linaro.org
Subject: Re: [PATCH] utimes: Clamp the timestamps in notify_change()
Message-ID: <20191124194934.GB4203@ZenIV.linux.org.uk>
References: <20191124193145.22945-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191124193145.22945-1-amir73il@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Nov 24, 2019 at 09:31:45PM +0200, Amir Goldstein wrote:
> Push clamping timestamps down the call stack into notify_change(), so
> in-kernel callers like nfsd and overlayfs will get similar timestamp
> set behavior as utimes.
 
Makes sense; said that, shouldn't we go through ->setattr() instances and
get rid of that there, now that notify_change() is made to do it?

I mean,
        if (ia_valid & ATTR_ATIME)
                sd_iattr->ia_atime = timestamp_truncate(iattr->ia_atime,
                                                      inode);
in configfs_setattr() looks like it should be reverted to
        if (ia_valid & ATTR_ATIME)
                sd_iattr->ia_atime = iattr->ia_atime;
with that, etc.

Moreover, does that leave any valid callers of timestamp_truncate()
outside of notify_change() and current_time()?  IOW, is there any
point having it exported?  Look:
fs/attr.c:187:          inode->i_atime = timestamp_truncate(attr->ia_atime,
fs/attr.c:191:          inode->i_mtime = timestamp_truncate(attr->ia_mtime,
fs/attr.c:195:          inode->i_ctime = timestamp_truncate(attr->ia_ctime,
	setattr_copy(), called downstream of your changes.
fs/configfs/inode.c:79:         sd_iattr->ia_atime = timestamp_truncate(iattr->ia_atime,
fs/configfs/inode.c:82:         sd_iattr->ia_mtime = timestamp_truncate(iattr->ia_mtime,
fs/configfs/inode.c:85:         sd_iattr->ia_ctime = timestamp_truncate(iattr->ia_ctime,
	configfs_setattr(); ditto.
fs/f2fs/file.c:755:             inode->i_atime = timestamp_truncate(attr->ia_atime,
fs/f2fs/file.c:759:             inode->i_mtime = timestamp_truncate(attr->ia_mtime,
fs/f2fs/file.c:763:             inode->i_ctime = timestamp_truncate(attr->ia_ctime,
	__setattr_copy() from f2fs_setattr(); ditto.
fs/inode.c:2224:        return timestamp_truncate(now, inode);
	current_time()
fs/kernfs/inode.c:163:  inode->i_atime = timestamp_truncate(attrs->ia_atime, inode);
fs/kernfs/inode.c:164:  inode->i_mtime = timestamp_truncate(attrs->ia_mtime, inode);
fs/kernfs/inode.c:165:  inode->i_ctime = timestamp_truncate(attrs->ia_ctime, inode);
	->s_time_max and ->s_time_min are left TIME64_MAX and TIME64_MIN resp., so
timestamp_truncate() should be a no-op there.
fs/ntfs/inode.c:2903:           vi->i_atime = timestamp_truncate(attr->ia_atime,
fs/ntfs/inode.c:2907:           vi->i_mtime = timestamp_truncate(attr->ia_mtime,
fs/ntfs/inode.c:2911:           vi->i_ctime = timestamp_truncate(attr->ia_ctime,
	ntfs_setattr(); downstream from your changes
fs/ubifs/file.c:1082:           inode->i_atime = timestamp_truncate(attr->ia_atime,
fs/ubifs/file.c:1086:           inode->i_mtime = timestamp_truncate(attr->ia_mtime,
fs/ubifs/file.c:1090:           inode->i_ctime = timestamp_truncate(attr->ia_ctime,
	do_attr_changes(), from do_truncation() or do_setattr(), both from ubifs_setattr();
ditto.
fs/utimes.c:39:                 newattrs.ia_atime = timestamp_truncate(times[0], inode);
fs/utimes.c:46:                 newattrs.ia_mtime = timestamp_truncate(times[1], inode);
	disappears in your patch.
