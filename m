Return-Path: <linux-fsdevel+bounces-54101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E94AFB355
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 14:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FBF6420450
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805D529B200;
	Mon,  7 Jul 2025 12:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXZjKW+i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D909229A31C;
	Mon,  7 Jul 2025 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751891565; cv=none; b=JGl55GcK2USJvtKsJhdz/wWVndeuB+RytIpg49CBZbvc6NdOM85A0HVVS9tvn6P8M2SsCrA5mtpXBk8tLD2hHme4nfqvdiIprIyTYQ38KeddNinnyAGRgcQqACmO7nkaxXFx7Sldo10Af2cafz1XGF+ohncKkX6EQn2iKI6GOWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751891565; c=relaxed/simple;
	bh=CfU0NV7kq+gD9EOLFf/qtz9VpGifBztVaVGA4/ZDusk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuXlmFvpRmlGgGPI7ao5tlLAQoirvf5rKrXf5LYydkUrxBeYjJAfmSjNVwuv4lhiG23uO3XiTSx635MYhXGwHoEY1dp/Oy9bgJJ64N5ysAJbt4b+mqsGePXV6+gdEcEmcFvJMitEPAKR0HVK13XH+YQ3ISwyN45a5dQLLD+Zb3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXZjKW+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15722C4CEE3;
	Mon,  7 Jul 2025 12:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751891565;
	bh=CfU0NV7kq+gD9EOLFf/qtz9VpGifBztVaVGA4/ZDusk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXZjKW+id2OFWIVfXHX4CHZNA7Md963dlYJJJ/M3grO58dvueHgO++FRbQLS3a2SR
	 Incfbq0yBHgO2PNlGeHafKXwUHMSpexmDIG9+K57+FColmw+wBeF+eNlYwzPtDNWzV
	 KywVyTYW+Efa/YKezvN3idKUF6rqZrUdp6Cfph3WvHeIWxhuv737A35QU57Y+SKJQP
	 m6VKPYzQ95s2bSTaq6mpmw7eh+vQL+8O4DhOBsk17B0W3OGJ+uMcfbiiafHhOf9Vke
	 kWc8n/hqSxNz+IUZ3IwqCTMEBQaasqIgBtF2oIBoyJfKPZSTpzlIA8tbt8tDJeSbna
	 dtB2rw9Qaf1Sw==
Date: Mon, 7 Jul 2025 15:32:38 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	syzbot <syzbot+3de83a9efcca3f0412ee@syzkaller.appspotmail.com>,
	jack@suse.cz, kees@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] secretmem: use SB_I_NOEXEC
Message-ID: <aGu-Zr4ltWloFuEf@kernel.org>
References: <20250707-tusche-umlaufen-6e96566552d6@brauner>
 <20250707-heimlaufen-hebamme-d6164bdc5f30@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707-heimlaufen-hebamme-d6164bdc5f30@brauner>

On Mon, Jul 07, 2025 at 02:10:36PM +0200, Christian Brauner wrote:
> Anonymous inodes may never ever be exectuable and the only way to
> enforce this is to raise SB_I_NOEXEC on the superblock which can never
> be unset. I've made the exec code yell at anyone who does not abide by
> this rule.
> 
> For good measure also kill any pretense that device nodes are supported
> on the secretmem filesystem.
> 
> > WARNING: fs/exec.c:119 at path_noexec+0x1af/0x200 fs/exec.c:118, CPU#1: syz-executor260/5835
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 5835 Comm: syz-executor260 Not tainted 6.16.0-rc4-next-20250703-syzkaller #0 PREEMPT(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> > RIP: 0010:path_noexec+0x1af/0x200 fs/exec.c:118
> > Code: 02 31 ff 48 89 de e8 f0 b1 89 ff d1 eb eb 07 e8 07 ad 89 ff b3 01 89 d8 5b 41 5e 41 5f 5d c3 cc cc cc cc cc e8 f2 ac 89 ff 90 <0f> 0b 90 e9 48 ff ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c a6
> > RSP: 0018:ffffc90003eefbd8 EFLAGS: 00010293
> > RAX: ffffffff8235f22e RBX: ffff888072be0940 RCX: ffff88807763bc00
> > RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> > RBP: 0000000000080000 R08: ffff88807763bc00 R09: 0000000000000003
> > R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000011
> > R13: 1ffff920007ddf90 R14: 0000000000000000 R15: dffffc0000000000
> > FS:  000055556832d380(0000) GS:ffff888125d1e000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f21e34810d0 CR3: 00000000718a8000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  do_mmap+0xa43/0x10d0 mm/mmap.c:472
> >  vm_mmap_pgoff+0x31b/0x4c0 mm/util.c:579
> >  ksys_mmap_pgoff+0x51f/0x760 mm/mmap.c:607
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f21e340a9f9
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffd23ca3468 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f21e340a9f9
> > RDX: 0000000000000000 RSI: 0000000000004000 RDI: 0000200000ff9000
> > RBP: 00007f21e347d5f0 R08: 0000000000000003 R09: 0000000000000000
> > R10: 0000000000000011 R11: 0000000000000246 R12: 0000000000000001
> > R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
> 
> Link: https://lore.kernel.org/686ba948.a00a0220.c7b3.0080.GAE@google.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/secretmem.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 9a11a38a6770..e042a4a0bc0c 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -261,7 +261,15 @@ SYSCALL_DEFINE1(memfd_secret, unsigned int, flags)
>  
>  static int secretmem_init_fs_context(struct fs_context *fc)
>  {
> -	return init_pseudo(fc, SECRETMEM_MAGIC) ? 0 : -ENOMEM;
> +	struct pseudo_fs_context *ctx;
> +
> +	ctx = init_pseudo(fc, SECRETMEM_MAGIC);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	fc->s_iflags |= SB_I_NOEXEC;
> +	fc->s_iflags |= SB_I_NODEV;
> +	return 0;
>  }
>  
>  static struct file_system_type secretmem_fs = {
> @@ -279,9 +287,6 @@ static int __init secretmem_init(void)
>  	if (IS_ERR(secretmem_mnt))
>  		return PTR_ERR(secretmem_mnt);
>  
> -	/* prevent secretmem mappings from ever getting PROT_EXEC */
> -	secretmem_mnt->mnt_flags |= MNT_NOEXEC;
> -
>  	return 0;
>  }
>  fs_initcall(secretmem_init);
> -- 
> 2.47.2
> 

-- 
Sincerely yours,
Mike.

