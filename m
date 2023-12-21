Return-Path: <linux-fsdevel+bounces-6744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7279F81B91A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 15:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5DAD1C25FD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA8E77F39;
	Thu, 21 Dec 2023 13:53:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671FA7765B;
	Thu, 21 Dec 2023 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav414.sakura.ne.jp (fsav414.sakura.ne.jp [133.242.250.113])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 3BLDqPBm014091;
	Thu, 21 Dec 2023 22:52:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav414.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp);
 Thu, 21 Dec 2023 22:52:25 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav414.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 3BLDqONe014083
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 21 Dec 2023 22:52:25 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <f2fefbfd-0ec9-4d4a-b065-bf68ad8e1641@I-love.SAKURA.ne.jp>
Date: Thu, 21 Dec 2023 22:52:20 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [fs?] INFO: trying to register non-static key in
 debugfs_file_get
Content-Language: en-US
To: syzbot <syzbot+fb20af23d0671a82c9a2@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes.berg@intel.com>,
        syzkaller-bugs@googlegroups.com
References: <000000000000fc306f060d052b5f@google.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        rafael@kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <000000000000fc306f060d052b5f@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

#syz fix: Revert "debugfs: annotate debugfs handlers vs. removal with lockdep"

By the way, use of cmpxchg() implies that this path might run in parallel?
If yes, I think you need to finish lockdep_init_map() before cmpxchg(), or
concurrently running threads might reach lock_map_acquire_read() before
lockdep_init_map() completes...

        d_fsd = READ_ONCE(dentry->d_fsdata);
        if (!((unsigned long)d_fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)) {
                fsd = d_fsd;
        } else {
                fsd = kmalloc(sizeof(*fsd), GFP_KERNEL);
                if (!fsd)
                        return -ENOMEM;

                fsd->real_fops = (void *)((unsigned long)d_fsd &
                                        ~DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
                refcount_set(&fsd->active_users, 1);
                init_completion(&fsd->active_users_drained);
                if (cmpxchg(&dentry->d_fsdata, d_fsd, fsd) != d_fsd) {
                        kfree(fsd);
                        fsd = READ_ONCE(dentry->d_fsdata);
                }
+#ifdef CONFIG_LOCKDEP
+               fsd->lock_name = kasprintf(GFP_KERNEL, "debugfs:%pd", dentry);
+               lockdep_register_key(&fsd->key);
+               lockdep_init_map(&fsd->lockdep_map, fsd->lock_name ?: "debugfs",
+                                &fsd->key, 0);
+#endif
        }

        /*
         * In case of a successful cmpxchg() above, this check is
         * strictly necessary and must follow it, see the comment in
         * __debugfs_remove_file().
         * OTOH, if the cmpxchg() hasn't been executed or wasn't
         * successful, this serves the purpose of not starving
         * removers.
         */
        if (d_unlinked(dentry))
                return -EIO;

        if (!refcount_inc_not_zero(&fsd->active_users))
                return -EIO;

+       lock_map_acquire_read(&fsd->lockdep_map);


On 2023/12/21 22:35, syzbot wrote:
> HEAD commit:    b10a3ccaf6e3 Merge tag 'loongarch-fixes-6.7-2' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1278f06ce80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=70dcde26e6b912e5
> dashboard link: https://syzkaller.appspot.com/bug?extid=fb20af23d0671a82c9a2
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40


