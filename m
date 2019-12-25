Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40C0812A885
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 17:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfLYQ1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 11:27:32 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33554 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfLYQ1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 11:27:32 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ik9VR-0008LK-GD; Wed, 25 Dec 2019 16:27:29 +0000
Date:   Wed, 25 Dec 2019 16:27:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miaoxie@huawei.com, zhangtianci1@huawei.com
Subject: Re: [QUESTION] question about the errno of rename the parent dir to
 a subdir of a specified directory
Message-ID: <20191225162729.GP4203@ZenIV.linux.org.uk>
References: <4c54c1f0-fe9a-6dea-1727-6898e8dd85ef@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c54c1f0-fe9a-6dea-1727-6898e8dd85ef@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 25, 2019 at 09:16:09PM +0800, zhangyi (F) wrote:
> Hi,
> 
> If we rename the parent-dir to a sub-dir of a specified directory, the
> rename() syscall return -EINVAL because lock_rename() in lock_rename()
> checks the relations of the sorece and dest dirs. But if the 'parent'
> dir is a mountpoint, the rename() syscall return -EXDEV instead because
> it checks the parent dir's mountpoint of the sorece and dest dirs.
> 
> For example:
> Case 1: rename() return -EINVAL
> # mkdir -p parent/dir
> # rename parent parent/dir/subdir parent
> rename: parent: rename to parent/dir/subdir failed: Invalid argument

That was rename("parent", "parent/dir/subdir") being told to sod off and
not try to create loops.

> Case 2: rename() return -EXDEV
> # mkdir parent
> # mount -t tmpfs test parent
> # mkdir parent/dir
> # rename parent parent/dir/subdir parent
> rename: parent: rename to parent/dir/subdir failed: Invalid cross-device link
> 
> In case 2, although 'parent' directory is a mountpoint, it acted as a root
> dir of the "test tmpfs", so it should belongs to the same mounted fs of
> 'dir' directoty, so I think it shall return -EINVAL.
> 
> Is it a bug or just designed as this ?

rename() operates on directory entries.  Pathnames can refer to files (including
directories) or they can refer to directory entries (links).  rename() and other
directory-modifying syscalls operate on the latter.  In the second test two
error conditions apply: in addition to attempted loop creation, we are asked to
move the link 'parent' from whatever it's in (your current directory) to 'subdir'
in the directory parent/dir, the latter being on a different filesystem.

It's not "take the file old pathname refers to, move it to new place"; that's
particularly obvious when you consider

echo foo >a	# create a file
ln a b		# now 'a' and 'b' both refer to it
mv a c		# or rename a c a, if you really want to touch util-linux rename(1)

Desired result is, of course, 'a' disappearing, 'b' left as is and 'c' now refering
to the same file.  If you did mv b c as the last step, 'a' would be left as is,
'b' would disappear and 'c' added, refering to the same file.  But the only
difference between mv a c and mv b c is the first argument of rename(2) and
in both cases it resolves to the same file.  In other words, rename(2) can't
operate on that level; to be of any use it has to interpret the pathnames
as refering to directory entries.

That, BTW, is the source of "the last component must not be . or .." - they
do refer to directories just fine, but rename("dir1/.", "dir2/foo") is not just
'make the directory refered to by "dir1/." show up as "dir2/foo"' - it's
'rip the entry "." from the directory "dir1" and move it into directory "dir2"
under the name "foo"'.

So your second testcase is a genuine cross-filesystem move; you want a link
to disappear from a directory on one filesystem and reappear in a directory
on another.  It doesn't matter what's mounted on top of that - directory
entry refers to the mountpoint, not the thing mounted on it.

And in cases when more than one error condition applies, portable userland
should be ready to cope with the operating system returning any of those.
Different Unices might return different applicable errors.  In this particular
case I would expect EXDEV to take precedence on the majority of implementations,
but that's not guaranteed.  Note, BTW, that there might be other errors
applicable here and it's a sufficiently dark corner to expect differences
(e.g. there might be a blanket ban on renaming mountpoints in general,
POSIX being quiet on that topic be damned).  

That actually might be a good way to get into given Unix VFS - figuring out
what happens in this implementation will tell you a lot about its pathname
resolution, related kernel data structures and locking involved.  Might
send you away screaming, though - rename(2) is usually the worst part
as it is, and bringing the mountpoint crossing into the game is likely
to expose all kinds of interesting corner cases.
