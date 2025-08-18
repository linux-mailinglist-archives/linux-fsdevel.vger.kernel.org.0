Return-Path: <linux-fsdevel+bounces-58199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABD0B2B042
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 20:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7CE41B606AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 18:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5043314BE;
	Mon, 18 Aug 2025 18:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X9diEnfv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A323314A2;
	Mon, 18 Aug 2025 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541585; cv=none; b=CEmekWpdkKH/TjPFxvmV/a/pGD5rdt8TARwiAlFRrqplZ8B59msOl14Mfkh/kKnyHOLP2T1pY5P1+fa+x3B9GKnj2vD0ZC8O58JBW9pCyozbE2CC0j4bjjUojd/wlEwAcU4z8ba4C4PWnHbLtozGk1tdZUudE1B5SrXlUKjkAq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541585; c=relaxed/simple;
	bh=EgalRbjYn9XvJ6vqxWwAZdqnhgYsrm33nDAWgv9wClU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akgzklxreDsuEEl7UmQpxY2weo0cVy4CwtrxMNRnM6YuO1uZozJol1FIvVYm6eEcGbnfbl2M4AKhc8F3yx7w3521EjP0IUyNI8HEtWX4cEl0b82Gs9rxLwM02FEgWCgks+DjAYPqJn7gV3tOJAVjtOUrW28K3vjpqnwD/fvyPUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=X9diEnfv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O75UIUPO5Nhi6baLItc5aorQTbl3aXRmvPV/kSs4z1U=; b=X9diEnfvb8vsZSK7H4Ybwyad7Z
	VGXrBAuw2mdZ8xiMQYV7DxC1p7tKM3M5WM/UjU+XMGlCrjrjI0Mq0M2JvEz6MXJ/BXJXw3nLzU4eB
	F31BmJj5GovtvGO5IMSUv5I5qPzczC99qT8PEQtKonLLVan26mNpujoOC6QIPU+yvJoFIl9SUOf76
	2hseD7EdBenfHkZApwqQFF0MXHvA3024HDtRdCoDNq+Ckj524lpzzRDJl5aRZcKllFh0tupl83bby
	fcgTywetRcz6pD8NZawdz1QNwugUBHj9I4e7ncdz+FXNc7WYaaBKRPGbtmb4pGRJIetez3cU3LH64
	+7DImIsA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo4Yi-000000078b6-0d8k;
	Mon, 18 Aug 2025 18:26:16 +0000
Date: Mon, 18 Aug 2025 19:26:16 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: syzbot <syzbot+1ec0f904ba50d06110b1@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bigeasy@linutronix.de,
	bpf@vger.kernel.org, brauner@kernel.org, daniel@iogearbox.net,
	davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com,
	haoluo@google.com, jack@suse.cz, jiri@resnulli.us,
	john.fastabend@gmail.com, jolsa@kernel.org,
	kerneljasonxing@gmail.com, kpsingh@kernel.org, kuba@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, martin.lau@linux.dev, netdev@vger.kernel.org,
	pabeni@redhat.com, sdf@fomichev.me, song@kernel.org,
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_umount (3)
Message-ID: <20250818182616.GB222315@ZenIV>
References: <67555b72.050a0220.2477f.0026.GAE@google.com>
 <68a2f584.050a0220.e29e5.009d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a2f584.050a0220.e29e5.009d.GAE@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 18, 2025 at 02:42:28AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=1321eba2580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
> dashboard link: https://syzkaller.appspot.com/bug?extid=1ec0f904ba50d06110b1
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10cba442580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10a1eba2580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/43186d9e448c/mount_0.gz
>   fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=174ba442580000)
> 
> The issue was bisected to:
> 
> commit d15121be7485655129101f3960ae6add40204463
> Author: Paolo Abeni <pabeni@redhat.com>
> Date:   Mon May 8 06:17:44 2023 +0000
> 
>     Revert "softirq: Let ksoftirqd do its job"

Would be interesting to see how it behaves on 

git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #fixes (cda250b0fc83)

