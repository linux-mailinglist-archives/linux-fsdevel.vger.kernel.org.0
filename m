Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83136DF694
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Apr 2023 15:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDLNLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Apr 2023 09:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDLNLt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:11:49 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17A97AA3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Apr 2023 06:11:15 -0700 (PDT)
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 33CDB8lO071949;
        Wed, 12 Apr 2023 22:11:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Wed, 12 Apr 2023 22:11:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 33CDB8sg071944
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 12 Apr 2023 22:11:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f649c9c0-6c0c-dd0d-e3c9-f0c580a11cd9@I-love.SAKURA.ne.jp>
Date:   Wed, 12 Apr 2023 22:11:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: [PATCH] fs/ntfs3: disable page fault during ntfs_fiemap()
Content-Language: en-US
To:     syzbot <syzbot+96cee7d33ca3f87eee86@syzkaller.appspotmail.com>,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
References: <000000000000e2102c05eeaf9113@google.com>
 <00000000000031b80705ef5d33d1@google.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, trix@redhat.com,
        ndesaulniers@google.com, nathan@kernel.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <00000000000031b80705ef5d33d1@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot is reporting circular locking dependency between ntfs_file_mmap()
(which has mm->mmap_lock => ni->ni_lock dependency) and ntfs_fiemap()
(which has ni->ni_lock => mm->mmap_lock dependency).

Since ni_fiemap() is called by ioctl(FS_IOC_FIEMAP) via optional
"struct inode_operations"->fiemap callback, I assume that importance of
ni_fiemap() is lower than ntfs_file_mmap().

Also, since Documentation/filesystems/fiemap.rst says that "If an error
is encountered while copying the extent to user memory, -EFAULT will be
returned.", I assume that ioctl(FS_IOC_FIEMAP) users can handle -EFAULT
error.

Therefore, in order to eliminate possibility of deadlock, until

  Assumed ni_lock.
  TODO: Less aggressive locks.

comment in ni_fiemap() is removed, use ni_fiemap() with best-effort basis
(i.e. fail with -EFAULT when a page fault is inevitable).

Reported-by: syzbot <syzbot+96cee7d33ca3f87eee86@syzkaller.appspotmail.com>
Link: https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86
Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 fs/ntfs3/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index e9bdc1ff08c9..a9e7204e1579 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -1146,9 +1146,11 @@ int ntfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		return err;
 
 	ni_lock(ni);
+	pagefault_disable();
 
 	err = ni_fiemap(ni, fieinfo, start, len);
 
+	pagefault_enable();
 	ni_unlock(ni);
 
 	return err;
-- 
2.34.1

