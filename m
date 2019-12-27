Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 103C312B49A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Dec 2019 13:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfL0MsJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 07:48:09 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726562AbfL0MsJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 07:48:09 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 243DD999849C7532FF57;
        Fri, 27 Dec 2019 20:48:06 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.179) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 27 Dec 2019
 20:48:00 +0800
Subject: Re: [QUESTION] question about the errno of rename the parent dir to a
 subdir of a specified directory
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "miaoxie (A)" <miaoxie@huawei.com>,
        zhangtianci <zhangtianci1@huawei.com>
References: <4c54c1f0-fe9a-6dea-1727-6898e8dd85ef@huawei.com>
 <20191225162729.GP4203@ZenIV.linux.org.uk>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <62e4c112-afc2-eb33-acc1-21c84aa528fa@huawei.com>
Date:   Fri, 27 Dec 2019 20:47:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191225162729.GP4203@ZenIV.linux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.179]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Thanks for your detailed explanation, I will also check the freeBSD.

Thanks,
Yi.

On 2019/12/26 0:27, Al Viro wrote:
> On Wed, Dec 25, 2019 at 09:16:09PM +0800, zhangyi (F) wrote:
>> Hi,
>>
>> If we rename the parent-dir to a sub-dir of a specified directory, the
>> rename() syscall return -EINVAL because lock_rename() in lock_rename()
>> checks the relations of the sorece and dest dirs. But if the 'parent'
>> dir is a mountpoint, the rename() syscall return -EXDEV instead because
>> it checks the parent dir's mountpoint of the sorece and dest dirs.
>>
>> For example:
>> Case 1: rename() return -EINVAL
>> # mkdir -p parent/dir
>> # rename parent parent/dir/subdir parent
>> rename: parent: rename to parent/dir/subdir failed: Invalid argument
> 
> That was rename("parent", "parent/dir/subdir") being told to sod off and
> not try to create loops.
> 
>> Case 2: rename() return -EXDEV
>> # mkdir parent
>> # mount -t tmpfs test parent
>> # mkdir parent/dir
>> # rename parent parent/dir/subdir parent
>> rename: parent: rename to parent/dir/subdir failed: Invalid cross-device link
>>
>> In case 2, although 'parent' directory is a mountpoint, it acted as a root
>> dir of the "test tmpfs", so it should belongs to the same mounted fs of
>> 'dir' directoty, so I think it shall return -EINVAL.
>>
>> Is it a bug or just designed as this ?
> 
> rename() operates on directory entries.  Pathnames can refer to files (including
> directories) or they can refer to directory entries (links).  rename() and other
> directory-modifying syscalls operate on the latter.  In the second test two
> error conditions apply: in addition to attempted loop creation, we are asked to
> move the link 'parent' from whatever it's in (your current directory) to 'subdir'
> in the directory parent/dir, the latter being on a different filesystem.
> 
> It's not "take the file old pathname refers to, move it to new place"; that's
> particularly obvious when you consider
> 
> echo foo >a	# create a file
> ln a b		# now 'a' and 'b' both refer to it
> mv a c		# or rename a c a, if you really want to touch util-linux rename(1)
> 
> Desired result is, of course, 'a' disappearing, 'b' left as is and 'c' now refering
> to the same file.  If you did mv b c as the last step, 'a' would be left as is,
> 'b' would disappear and 'c' added, refering to the same file.  But the only
> difference between mv a c and mv b c is the first argument of rename(2) and
> in both cases it resolves to the same file.  In other words, rename(2) can't
> operate on that level; to be of any use it has to interpret the pathnames
> as refering to directory entries.
> 
> That, BTW, is the source of "the last component must not be . or .." - they
> do refer to directories just fine, but rename("dir1/.", "dir2/foo") is not just
> 'make the directory refered to by "dir1/." show up as "dir2/foo"' - it's
> 'rip the entry "." from the directory "dir1" and move it into directory "dir2"
> under the name "foo"'.
> 
> So your second testcase is a genuine cross-filesystem move; you want a link
> to disappear from a directory on one filesystem and reappear in a directory
> on another.  It doesn't matter what's mounted on top of that - directory
> entry refers to the mountpoint, not the thing mounted on it.
> 
> And in cases when more than one error condition applies, portable userland
> should be ready to cope with the operating system returning any of those.
> Different Unices might return different applicable errors.  In this particular
> case I would expect EXDEV to take precedence on the majority of implementations,
> but that's not guaranteed.  Note, BTW, that there might be other errors
> applicable here and it's a sufficiently dark corner to expect differences
> (e.g. there might be a blanket ban on renaming mountpoints in general,
> POSIX being quiet on that topic be damned).  
> 
> That actually might be a good way to get into given Unix VFS - figuring out
> what happens in this implementation will tell you a lot about its pathname
> resolution, related kernel data structures and locking involved.  Might
> send you away screaming, though - rename(2) is usually the worst part
> as it is, and bringing the mountpoint crossing into the game is likely
> to expose all kinds of interesting corner cases.
> 
> .
> 

