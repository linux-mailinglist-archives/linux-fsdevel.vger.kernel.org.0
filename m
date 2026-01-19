Return-Path: <linux-fsdevel+bounces-74520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEF8D3B630
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 19:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A2ED3001C94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jan 2026 18:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33D138F246;
	Mon, 19 Jan 2026 18:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WZjKvKup"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBFA288C20
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848661; cv=none; b=bo4xxzIpjQmV+bK2gBjJBwt3RoHf+Rk+06Govgqrzid28WFYu1XYpi56PiZ4TjngzA6GiNcv3JanrfTNUjE92jWMmXn4QBPzJF3T4cHXZNCuM4gE8fUK1NVc1MN2UegjnEn/n9B2kuMG94pAiozs31wkPQyVIDs/Aog2WPqS/GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848661; c=relaxed/simple;
	bh=GPBh2qWpyCXo1XUshP2C3TdOgUMqV76uDwXWffPXuuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNN8bfvr1UgVdE/0cZ/NaE2azhs5ugD2ZRI0Ohz/+UaYFLd91db4M1s+Z66hqpQeDmxvUpnFdW8i5aDsXegaqespkg9RDiMAaFjDMDV3oZOTMcriQl44Y2PWdglnf9sSusLIqeQ88hRp9wvDdMxEfccPld+qRRy7V0lq5ZzxW6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WZjKvKup; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a3e76d0f64so28139075ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 10:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768848660; x=1769453460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELu77MSHMdAJE1MG9u8LT8LbmE4aGm6DlWdwArp/Ogc=;
        b=WZjKvKup1JTHlU0is7A755AnqUDaFJnuJ7BlYKWTAK6s/3B5/VgzpQtbvuMlioFTEL
         a7VVI2sd3E7Pk+KxSqCVoRbvKPqZO7ATFU7BMk+nFTEYkF1AhyFprLpTfBjLQp2XyLTB
         y7CnBjFoJejdcSvQXhxoESKBI62eXIYN4zDM6xqV5eDMfJpVJ2fJkVlO09mmx4ylpru0
         RZ2Lc7B0NiEkVQgSNv/Fg6WCPmgtMFqpdavO7Y1347mL8/thW/fetKhh01WW3FZFjTtj
         fTIL+aQiEWp+SqCAJtD7sggHhq8iXPT95gMdsSHPO+XxOxfzNtTpwmdZmgzwcIQ+Dg2f
         UxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768848660; x=1769453460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELu77MSHMdAJE1MG9u8LT8LbmE4aGm6DlWdwArp/Ogc=;
        b=TyDzHPxZTlj4UqTSManSSafmaO6+oRZj3Sh2h890iAFbtfqQBMt2dUlCs3MChcDZXs
         l0O4KEBDkFQkLoxCmXU+DFVPV/5smUT2ZcY8b+HI/rLr4vJRp62z07loN5QUcT/My0Uw
         BWgcR5tgbR9Jp0h1O4F3lah2C0HHWMM/mpAQpM2heb7Q92ISl5jZnt/wkCgZZ1OWN0rY
         qxIyIwm/ZPHgBR4NclYGIt5VeAM2g/qOU+acEprnHCOlKqFykwThs7mz2IDceq4tMjBX
         011zr9oLwS0OLwCFy8HoQObNxHfDcCSsR5w7oX+0lKA0SDFxpkZy1FqcUuIRypYT/24N
         Nc8Q==
X-Forwarded-Encrypted: i=1; AJvYcCURdkqK3feMkfC06a8FO742a6CXqF2Ih3SyyaK6ywWWXmN1q25ALzDXr0fGJiP/Pn+6bRRQLGoDsgzjXj1D@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGEhgAq5e810LXecqvFBjwddIgA2rPWyHnwZ4U7g7avUIGlyu
	0hDEmBSjRRc6ajLH72Sw31dEbi7w3JDghDWFNHsRq6Gmsnhw2Xy1q0R2
X-Gm-Gg: AZuq6aL0nWg9b7rwCqD7GDz8k/v9ZnKywDyoCgJCPrM77vfRpUgIWE8YvCuiEhZ/vuq
	BtmonCg3dfN4l4NIy6xBKoBwny3XcQP8foSGbzboiSBnaNg3yxWE5YaL5A2FoqvlF6w3LxDUJXj
	jTOhZqCs5bCOrHoYYRHJYqTf1XeJzuBVpWEVY988tHXsO7Kk7lX58TlgcUbtcVnSTbU1nPren5Q
	I0vZmJwEXAdblOEmOCi9xOrOF4hNZ7OiyfrgHQTUV/Cxc0MMtqSvMgkJypmE06txuI9KFoRl6ph
	zFwylpAwrdw/31Gs3ZIrSWfq6RDCx27CryHh1up/zjxECK29s2Z8W1neYY+ub/PuyDsydSmdUWn
	JXDTNTRfQDN5OlQD564Ht1DbUm7FIQ3Ny4/5uud3Ypp26Crry7w1euWgxIkUFzYgOX6vTQJSHg0
	R2ctcNiB3q6Ks=
X-Received: by 2002:a17:902:ebc8:b0:2a0:9238:881d with SMTP id d9443c01a7336-2a700a1c29fmr150358455ad.15.1768848659415;
        Mon, 19 Jan 2026 10:50:59 -0800 (PST)
Received: from inspiron ([111.125.231.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a71941b915sm102107895ad.90.2026.01.19.10.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 10:50:59 -0800 (PST)
Date: Tue, 20 Jan 2026 00:20:49 +0530
From: Prithvi <activprithvi@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@lst.de, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] scsi: target: Fix recursive locking in
 __configfs_open_file()
Message-ID: <20260119185049.mvcjjntdkmtdk4je@inspiron>
References: <20260108191523.303114-1-activprithvi@gmail.com>
 <2f88aa9b-b1c2-4b02-81e8-1c43b982db1b@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f88aa9b-b1c2-4b02-81e8-1c43b982db1b@acm.org>

On Thu, Jan 15, 2026 at 08:57:28AM -0800, Bart Van Assche wrote:
> On 1/8/26 12:15 PM, Prithvi Tambewagh wrote:
> > This poses a possibility of recursive locking,
> > which triggers the lockdep warning.
> 
> Patches that fix a lockdep complaint should include the full lockdep
> complaint.
> 
> Since the fixed lockdep complaint didn't trigger a deadlock it must be
> a false positive complaint, isn't it? Such complaints should be fixed
> but without additional information we can't tell what the best way is to
> fix the complaint.
> 
> Thanks,
> 
> Bart.

Hello Bart,

Here is the full lockdep complaint, as per the syzkaller dashboard report
for the bug:

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.0.17/5999 is trying to acquire lock:
ffff888140413f78 (&p->frag_sem){.+.+}-{4:4}, at: __configfs_open_file+0xe8/0x9c0 fs/configfs/file.c:304

but task is already holding lock:
ffff888140413f78 (&p->frag_sem){.+.+}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
ffff888140413f78 (&p->frag_sem){.+.+}-{4:4}, at: configfs_write_iter+0x219/0x4e0 fs/configfs/file.c:229

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&p->frag_sem);
  lock(&p->frag_sem);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

4 locks held by syz.0.17/5999:
 #0: ffff888147ab0420 (sb_writers#12){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff888077d2d688 (&buffer->mutex){+.+.}-{4:4}, at: configfs_write_iter+0x75/0x4e0 fs/configfs/file.c:226
 #2: ffff888140413f78 (&p->frag_sem){.+.+}-{4:4}, at: flush_write_buffer fs/configfs/file.c:205 [inline]
 #2: ffff888140413f78 (&p->frag_sem){.+.+}-{4:4}, at: configfs_write_iter+0x219/0x4e0 fs/configfs/file.c:229
 #3: ffffffff8f4097e8 (target_devices_lock){+.+.}-{4:4}, at: target_core_item_dbroot_store+0x21/0x350 drivers/target/target_core_configfs.c:114

stack backtrace:
CPU: 0 UID: 0 PID: 5999 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_deadlock_bug+0x1e9/0x240 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain kernel/locking/lockdep.c:3895 [inline]
 __lock_acquire+0x1106/0x1c90 kernel/locking/lockdep.c:5237
 lock_acquire kernel/locking/lockdep.c:5868 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
 down_read+0x9b/0x480 kernel/locking/rwsem.c:1537
 __configfs_open_file+0xe8/0x9c0 fs/configfs/file.c:304
 do_dentry_open+0x982/0x1530 fs/open.c:965
 vfs_open+0x82/0x3f0 fs/open.c:1097
 do_open fs/namei.c:3975 [inline]
 path_openat+0x1de4/0x2cb0 fs/namei.c:4134
 do_filp_open+0x20b/0x470 fs/namei.c:4161
 file_open_name+0x2a3/0x450 fs/open.c:1381
 filp_open+0x4b/0x80 fs/open.c:1401
 target_core_item_dbroot_store+0x108/0x350 drivers/target/target_core_configfs.c:134
 flush_write_buffer fs/configfs/file.c:207 [inline]
 configfs_write_iter+0x306/0x4e0 fs/configfs/file.c:229
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x7d3/0x11d0 fs/read_write.c:686
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbf49d8eec9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd1d0ac1e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fbf49fe5fa0 RCX: 00007fbf49d8eec9
RDX: 0000000000000fff RSI: 0000200000000000 RDI: 0000000000000003
RBP: 00007fbf49e11f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fbf49fe5fa0 R14: 00007fbf49fe5fa0 R15: 0000000000000003
 </TASK>
db_root: not a directory: /sys/kernel/config/target/dbroot


Sorry, but I didn't get why this might be a false positive lockdep complaint,
can you please guide? 

From what I understood, in this case, the same rw_semaphore &p->frag_sem is used,
identified by the same addresses (ffff888140413f78), for both the lock held
as well as one being tried to be acquired. This occurs since 
flush_write_buffer() called in configfs_write_iter() first acquires the 
&p->frag_sem lock and then next flush_write_buffer() calls 
target_core_item_dbroot_store(), which attempts to open file with path stored
in db_root_stage using filp_open(). It ultimately calls __configfs_open_file() 
which again tries to acquire exactly the same lock, &p->frag_sem. 

A deadlock can arise, if a writer tries to acquire this lock after it was first
acquired by that thread in flush_write_buffer() and before acquiring it again in
__configfs_open_file(), trying to avoid writer starvation. After checking, I 
found out that down_write() is called for frag_sem, the rw_semaphore in struct 
configfs_fragment, at 3 places:

1. configfs_rmdir() - calls down_write_killable(&frag->frag_sem)
2. configfs_unregister_group() - calls down_write(&frag->frag_sem);
3. configfs_unregister_subsystem() - calls down_write(&frag->frag_sem);

I think any of these may result in a deadlock due to recursive locking, if
the lock is acquired by a writer after being acquired by a reader and then
again being tried to be acquired by a reader.

I attempt to solve this by replaing call to filp_open() in 
target_core_item_dbroot_store() with kern_path(), which just checks if a file 
path exists, as required in target_core_item_dbroot_store(), rather than 
actually opening the file and using the same frag_sem lock, which removes 
the possiblity of recursive deadlock on this path. What do you think of this 
approach?

Best Regards,
Prithvi 

