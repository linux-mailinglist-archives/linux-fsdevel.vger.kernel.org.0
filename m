Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74926F2E95
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 May 2023 07:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjEAFRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 May 2023 01:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEAFRJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 May 2023 01:17:09 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F3C1716;
        Sun, 30 Apr 2023 22:17:07 -0700 (PDT)
Received: from fsav311.sakura.ne.jp (fsav311.sakura.ne.jp [153.120.85.142])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3415GRo2034853;
        Mon, 1 May 2023 14:16:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav311.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp);
 Mon, 01 May 2023 14:16:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav311.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3415FvQL034733
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 1 May 2023 14:16:27 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bdb1fe2d-f904-78f0-d287-5e601f789862@I-love.SAKURA.ne.jp>
Date:   Mon, 1 May 2023 14:15:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [syzbot] [mm?] KCSAN: data-race in generic_fillattr / shmem_mknod
 (2)
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+702361cf7e3d95758761@syzkaller.appspotmail.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <0000000000007337c705fa1060e2@google.com>
 <CACT4Y+a=xWkNGw_iKibRp4ivSE8OJkWWT0VPQ4N4d1+vj0FMdg@mail.gmail.com>
Content-Language: en-US
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CACT4Y+a=xWkNGw_iKibRp4ivSE8OJkWWT0VPQ4N4d1+vj0FMdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/04/24 17:26, Dmitry Vyukov wrote:
>> HEAD commit:    457391b03803 Linux 6.3
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13226cf0280000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c81c9a3d360ebcf
>> dashboard link: https://syzkaller.appspot.com/bug?extid=702361cf7e3d95758761
>> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> I think shmem_mknod() needs to use i_size_write() to update the size.
> Writes to i_size are not assumed to be atomic throughout the kernel
> code.
> 

I don't think that using i_size_{read,write}() alone is sufficient,
for I think that i_size_{read,write}() needs data_race() annotation.

 include/linux/fs.h |   13 +++++++++++--
 mm/shmem.c         |   12 ++++++------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 21a981680856..0d067bbe3ee9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -860,6 +860,13 @@ void filemap_invalidate_unlock_two(struct address_space *mapping1,
  * the read or for example on x86 they can be still implemented as a
  * cmpxchg8b without the need of the lock prefix). For SMP compiles
  * and 64bit archs it makes no difference if preempt is enabled or not.
+ *
+ * However, when KCSAN is enabled, CPU being capable of reading/updating
+ * naturally aligned 8 bytes of memory atomically is not sufficient for
+ * avoiding KCSAN warning, for KCSAN checks whether value has changed between
+ * before and after of a read operation. But since we don't want to introduce
+ * seqcount overhead only for suppressing KCSAN warning, tell KCSAN that data
+ * race on accessing i_size field is acceptable.
  */
 static inline loff_t i_size_read(const struct inode *inode)
 {
@@ -880,7 +887,8 @@ static inline loff_t i_size_read(const struct inode *inode)
 	preempt_enable();
 	return i_size;
 #else
-	return inode->i_size;
+	/* See comment above. */
+	return data_race(inode->i_size);
 #endif
 }
 
@@ -902,7 +910,8 @@ static inline void i_size_write(struct inode *inode, loff_t i_size)
 	inode->i_size = i_size;
 	preempt_enable();
 #else
-	inode->i_size = i_size;
+	/* See comment above. */
+	data_race(inode->i_size = i_size);
 #endif
 }
 
diff --git a/mm/shmem.c b/mm/shmem.c
index e40a08c5c6d7..a2f20297fb59 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2951,7 +2951,7 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 			goto out_iput;
 
 		error = 0;
-		dir->i_size += BOGO_DIRENT_SIZE;
+		i_size_write(dir, i_size_read(dir) + BOGO_DIRENT_SIZE);
 		dir->i_ctime = dir->i_mtime = current_time(dir);
 		inode_inc_iversion(dir);
 		d_instantiate(dentry, inode);
@@ -3027,7 +3027,7 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 			goto out;
 	}
 
-	dir->i_size += BOGO_DIRENT_SIZE;
+	i_size_write(dir, i_size_read(dir) + BOGO_DIRENT_SIZE);
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 	inode_inc_iversion(dir);
 	inc_nlink(inode);
@@ -3045,7 +3045,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
 		shmem_free_inode(inode->i_sb);
 
-	dir->i_size -= BOGO_DIRENT_SIZE;
+	i_size_write(dir, i_size_read(dir) - BOGO_DIRENT_SIZE);
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 	inode_inc_iversion(dir);
 	drop_nlink(inode);
@@ -3132,8 +3132,8 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 		inc_nlink(new_dir);
 	}
 
-	old_dir->i_size -= BOGO_DIRENT_SIZE;
-	new_dir->i_size += BOGO_DIRENT_SIZE;
+	i_size_write(old_dir, i_size_read(old_dir) - BOGO_DIRENT_SIZE);
+	i_size_write(new_dir, i_size_read(new_dir) + BOGO_DIRENT_SIZE);
 	old_dir->i_ctime = old_dir->i_mtime =
 	new_dir->i_ctime = new_dir->i_mtime =
 	inode->i_ctime = current_time(old_dir);
@@ -3189,7 +3189,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		folio_unlock(folio);
 		folio_put(folio);
 	}
-	dir->i_size += BOGO_DIRENT_SIZE;
+	i_size_write(dir, i_size_read(dir) + BOGO_DIRENT_SIZE);
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	inode_inc_iversion(dir);
 	d_instantiate(dentry, inode);

Maybe we want i_size_add() ?

Also, there was a similar report on updating i_{ctime,mtime} to current_time()
which means that i_size is not the only field that is causing data race.
https://syzkaller.appspot.com/bug?id=067d40ab9ab23a6fa0a8156857ed54e295062a29

Hmm, where is the serialization that avoids concurrent
shmem_mknod()/shmem_mknod() or shmem_mknod()/shmem_unlink() ?
i_size_write() says "need locking around it (normally i_mutex)"...

