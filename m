Return-Path: <linux-fsdevel+bounces-72028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB237CDB874
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 07:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A5803040A6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 06:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B67313268;
	Wed, 24 Dec 2025 06:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp2f1Zbb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073431E2858
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766558294; cv=none; b=a9dZoEET9R+guZXRNTk2gMiQr0EHb1Q0dItaYFmFa1u/XE2s2Pszrn3EEFtiNgsiHDOa6Q/Ly8ER5neN1sxId/0LaQNS+rxQjmYxmJWKzMK1LVQzNGycdoHaKx7FaDo7YPc/h0Pkco2jj3DFGGW/Mw/X9Z/kImao5WxKwngvqDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766558294; c=relaxed/simple;
	bh=yxFQYxNYe4wRZ4nMF3gMmIZhnl3qpuscxMR8SC5TmDA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgWW6BQ1UWHGosb8A3dAtiCXYPd6idcgLEfE53nlcxckn63h5aiJxzPrRIA53zct0NVqb/OSAUfsdboMA4OkWXQOE+GJDI+E9iRIScxYlnJlujFaCHuN6NHbV3EcvGj3n7rropdbIyb97lrDgZ/ftAGGelNBrj4WkUyQ8Jbio9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp2f1Zbb; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so6646286a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 22:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766558291; x=1767163091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZCtYDgO+ptezuLFJJFBLJEC5kcPG0Y9Xq0rzFqNSww=;
        b=Xp2f1Zbbd4rIh9vPCBkfe6+MSmr8TBEkmX+2KA66B2nsZiMrCT+IjQfjY4kD4pDGoV
         9twsNe2N6clxH7z6DBr4f8rR0GIzpxDGFGi861XgEDxem5wlVC4q+etP9BOCHidqWtRl
         bg6blBDiEu6G96WnxEWEO2BZy/E8ijihsDcn0pXJ4qS4fUzFPKiQhh0lHt2q48EfBvHk
         VEVn0rixh/WtVQGyQwq0wS9hxInLMOAtpRebQYBEoZGC8JXNOfW5uV9w3hp5Z8DBeA+Y
         QA8NAB8YUJIpDe3wehZl2/b4NhHyHSSx+Eod2SA1TT2ErKOGAJfbxTyJqEHlFKafCQZP
         NpIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766558291; x=1767163091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yZCtYDgO+ptezuLFJJFBLJEC5kcPG0Y9Xq0rzFqNSww=;
        b=uDroguPKGHeUYO2uk2XsvMJmyqMKDjk3y21bL+01KHdHxn7Cmj7pXOVPL+XZ0zetn5
         UyIDm95tgIAwpH7YY2pafGqeVP7AfjyXK/fmDjngrLVWxBFPbeGormVuguj96U3MOVkd
         SRak2cZQz4bGPAOvkndo2PTZ/aZCXVpcr1kBx+klXeBS1zUvVLkbklbEzHBKcANvq18h
         DnS3FjJMuZcWzGFFGTUSDiRdDGsg8U2ko+AMjF6+lhcAQORNPEzPMlDz6Qnsg5+7PhdS
         mXRmn6cK6yZYxHGtGwHmQcuNjMoIv9viHaNVUZ120OO8efckVvfwNs1DbQu0hGKJ+Ndl
         GmvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmB8buGS4SYZJzjazqSghzsUVN6UvyqYNmlWjnwQ+xJX61TaGaIrFruAlUMMogM5uPTdQN0X5MsrwwILzK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0yjXW1lAIcQUUgkQeJAP9I8Ko5cgLeXT8JedZ2yfXw/AAxgBb
	I5hFgyM44Qo5UGCv78ELLKqpaTCLT4uqF+FSj8l3HPrUOSGBLENLIBSYed/K9Ne4gsqaTdp2MPX
	P0v/ELL+6mWzSiNKhhL1d9cWADMjZJyM=
X-Gm-Gg: AY/fxX6Mt/jmLzN1mGMheNZ4k1GLhmHHsion3ygDO4UyoTCPKy2iOoYAANTr4VsXUVo
	k+WA1+EeIrdj1p+Agw3xBdsfkZkHK8++LxtQVk8vH8nkGZ90bZaR5GnwmXWBHjHRlT4CXUyG8WT
	IELcVoC4MTMJ6M0xFTuqru0k6hpXVRRDil1TUL8tfbxA76k/8ygVwzwFAok4pEiZJu3vp4V+Njt
	Dt7OqKkfjyDwjFob54J/ejWAH1BfjWRclcF0bu7q+euq0vQ720D3tdxLfFrQwaZtlCVwYLJLdKD
	NYzXChgsVEeyoiI913C/YBM0mI16gg==
X-Google-Smtp-Source: AGHT+IGa1UXVF4cR2X1C4IspY/mLmlKZb+NRUq0Ld0aPyy4JFEzxy0EFYtEMJe3m/wJRFPbQLz/xqwasDHiZA0hpSoE=
X-Received: by 2002:a05:6402:2356:b0:64d:4f75:aa28 with SMTP id
 4fb4d7f45d1cf-64d4f75adb0mr9833167a12.18.1766558291049; Tue, 23 Dec 2025
 22:38:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223194153.2818445-1-code@tyhicks.com> <20251223194153.2818445-3-code@tyhicks.com>
In-Reply-To: <20251223194153.2818445-3-code@tyhicks.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 24 Dec 2025 07:37:59 +0100
X-Gm-Features: AQt7F2qFovOJnFyxDQ1XHiaVvTtLPDhKLtuehq3ayY23c5tE5OF9oRe7BvgPhzs
Message-ID: <CAOQ4uxhrrj0n+YntJVSZsHRSX=FPZoiHx0sywUQw1G8=mXgm0g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ecryptfs: Release lower parent dentry after creating dir
To: Tyler Hicks <code@tyhicks.com>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2025 at 9:42=E2=80=AFPM Tyler Hicks <code@tyhicks.com> wrot=
e:
>
> Fix a mkdir-induced usage count imbalance that tripped a umount_check()
> BUG while unmounting the lower filesystem. Commit f046fbb4d81d
> ("ecryptfs: use new start_creating/start_removing APIs") added a new
> dget() of the lower parent dir, in ecryptfs_mkdir(), but did not dput()
> the dentry before returning from that function.
>
> The BUG output as seen while running the eCryptfs test suite:
>
> $ ./run_tests.sh -b 131072 -c safe,destructive -f ext4 -K -t lp-926292.sh
> ...
> Running eCryptfs filesystem tests on ext4
> lp-926292
> ------------[ cut here ]------------
> BUG: Dentry ffff8e6692d11988{i=3Dc,n=3DECRYPTFS_FNEK_ENCRYPTED.FXZuRGZL7Q=
AFtER.JeA46DtdKqkkQx9H2Vpmv234J5CU8YSsrUwZJK4AbXbrN5WkZ348wnqstovKKxA-}  st=
ill in use (1) [unmount of ext4 loop0]
> WARNING: CPU: 7 PID: 950 at fs/dcache.c:1590 umount_check+0x5e/0x80
> Modules linked in: md5 libmd5 ecryptfs encrypted_keys ext4 crc16 mbcache =
jbd2
> CPU: 7 UID: 0 PID: 950 Comm: umount Not tainted 6.18.0-rc1-00013-gf046fbb=
4d81d #17 PREEMPT(full)
> Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> RIP: 0010:umount_check+0x5e/0x80
> Code: 88 38 06 00 00 48 8b 40 28 4c 8b 08 48 8b 46 68 48 85 c0 74 04 48 8=
b 50 38 51 48 c7 c7 60 32 9c b5 48 89 f1 e8 43 5e ca ff 90 <0f> 0b 90 90 58=
 31 c0 e9 46 9d 6c 00 41 83 f8 01 75 b8 eb a3 66 66
> RSP: 0018:ffffa19940c4bdd0 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffff8e6692fad4c0 RCX: 0000000000000000
> RDX: 0000000000000004 RSI: ffffa19940c4bc70 RDI: 00000000ffffffff
> RBP: ffffffffb4eb5930 R08: 00000000ffffdfff R09: 0000000000000001
> R10: 00000000ffffdfff R11: ffffffffb5c8a9e0 R12: ffff8e6692fad4c0
> R13: ffff8e6692fad4c0 R14: ffff8e6692d11a40 R15: ffff8e6692d11988
> FS:  00007f6b4b491800(0000) GS:ffff8e670506e000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f6b4b5f8d40 CR3: 0000000114eb7001 CR4: 0000000000772ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  d_walk+0xfd/0x370
>  shrink_dcache_for_umount+0x4d/0x140
>  generic_shutdown_super+0x20/0x160
>  kill_block_super+0x1a/0x40
>  ext4_kill_sb+0x22/0x40 [ext4]
>  deactivate_locked_super+0x33/0xa0
>  cleanup_mnt+0xba/0x150
>  task_work_run+0x5c/0xa0
>  exit_to_user_mode_loop+0xac/0xb0
>  do_syscall_64+0x2ab/0xfa0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f6b4b6c2a2b
> Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 31 f6 e9 0=
5 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 05 c3 0f 1f 40 00 48 8b 15 b9 83 0d 00 f7 d8
> RSP: 002b:00007ffcd5b8b498 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 000055b84af0b9e0 RCX: 00007f6b4b6c2a2b
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000055b84af0bdf0
> RBP: 00007ffcd5b8b570 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000103 R11: 0000000000000246 R12: 000055b84af0bae0
> R13: 0000000000000000 R14: 000055b84af0bdf0 R15: 0000000000000000
>  </TASK>
> ---[ end trace 0000000000000000 ]---
> EXT4-fs (loop0): unmounting filesystem 00d9ea41-f61e-43d0-a449-6be03e7e84=
28.
> EXT4-fs (loop0): sb orphan head is 12
> sb_info orphan list:
>   inode loop0:12 at ffff8e66950e1df0: mode 40700, nlink 0, next 0
> Assertion failure in ext4_put_super() at fs/ext4/super.c:1345: 'list_empt=
y(&sbi->s_orphan)'
>
> Fixes: f046fbb4d81d ("ecryptfs: use new start_creating/start_removing API=
s")
> Signed-off-by: Tyler Hicks <code@tyhicks.com>
> ---
>  fs/ecryptfs/inode.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index e73d9de676a6..8ab014db3e03 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -533,6 +533,7 @@ static struct dentry *ecryptfs_mkdir(struct mnt_idmap=
 *idmap, struct inode *dir,
>         fsstack_copy_inode_size(dir, lower_dir);
>         set_nlink(dir, lower_dir->i_nlink);
>  out:
> +       dput(lower_dir_dentry);
>         end_creating(lower_dentry);
>         if (d_really_is_negative(dentry))
>                 d_drop(dentry);
> --
> 2.43.0
>

Damn! I doubt that these bugs would have gone unnoticed by
LLM reviews... :-/

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

