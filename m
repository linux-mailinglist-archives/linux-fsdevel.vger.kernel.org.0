Return-Path: <linux-fsdevel+bounces-20241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC638D0242
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22FDDB27039
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AADA15EFAF;
	Mon, 27 May 2024 13:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QKm0YyE4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409961640B;
	Mon, 27 May 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716818188; cv=none; b=Sbsn0cC6uM83Wq2c4VV/3dNDfIaFPCpUAmyPqUt+vCoeRhajkzcx6X5LHQYHjDouYO3B+byzBO9VKFEuqVItsIGsfFhBNlaT/tIiGDvGyQA07Q/hLrehaX1cuRwR7/pMqJTD1RYFiQZM5Le9wAfm/IX1+UBzouWfO4thWW2DF6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716818188; c=relaxed/simple;
	bh=NgOcCSGHTbzpnvl9Mq6Om5C2Z9Lk+2YXyn4VKP6Rd2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QhgKSH/BsNDhT3N6Cb1CRWAROTkqX7OF2IwY6AJ+6L/fBL31DWRXbiaiv6Av4pljsssCHH2dEo38/m5zYzjuO0CQK8j1/z/qrPVmYByv72UCoCaXH3nHzvzoRkXDEaTiB0EWf03dRMKrdAoWsp4D8O2iPLNagWWEYg8XcAZhsQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QKm0YyE4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6fdfee2734aso1308576b3a.0;
        Mon, 27 May 2024 06:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716818186; x=1717422986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsenHvk4IovIHHC5dnWr0r84fdaChyIxj7I5Rp7B2Ho=;
        b=QKm0YyE41+++ghsaw1kRiOwofZYeYOC1opKNPiwq6wfDT3gvMzgANcjnNAcpx0a09D
         Cy36/6GbqI6zdfPxOvA7dosn8P92ybXplj/7wKbglbIZPbTFXOTJNflWjDFvO/OrXMLD
         J/dwJTc7bcM0WXFR5hJJm2p8eU+i5Qdcyg/vBEKxKjFx788Ggi5bEITpUBxyjtQL2Ou/
         q8RMeATbj6upOXVDJeP406gCcdbpzhxdoBYs/lPxb8CRyu/AU/W00rWDdyFd2jr6DKuy
         HHjDoZhu4vHRk7dkB9Elz0Bqu/eb/G8hMJZo9yWnGZRcrFre7E8r7TpRtUGPpxU/27HI
         Ui+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716818186; x=1717422986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsenHvk4IovIHHC5dnWr0r84fdaChyIxj7I5Rp7B2Ho=;
        b=BrS1tAKK694Ohhrt2IDGUtgJkanZcwYEtXrsnwAwULRxdjvFYgINws5K+AVSHr7lNw
         GBeqdR+WxmVRQcvvPkiuJ9F/mPf5MzZbEynqrsvbsOL5dckr97IARiIUxhEhdsm+gtNY
         E4MD0tInUO2zoX+8NE4RSowZx9P1WOLoasPuHKoPDoYQxQ9/OOcJXsFyZRFi3LXZQgxz
         OU64xexXgP5x6RxNNMMBCrLXodnS97yGCQlItvRgepO9pr+/x/hQ1XqYcprl3olW5f5G
         Dd37aUHC49nksvcPEvBLxPaNIGrLY7Ho4/+gy+/72C+zWONtGULbieYxZV+1fcdtcyjJ
         om/A==
X-Forwarded-Encrypted: i=1; AJvYcCXt3gh82f3VFSTJXUj+8JY2lahJluNt7CLUqF4FG2e688m4EB27bEF4ugdwKuCbLxemot0IJneKT3XC0EL4UgUYUmWPrD3GpvHzXIIUKbiKIih8TBrLZpxRZbfwUWx5UxifJHER/DlnyBLE2nnxAW3Y1hKPFeGOGCJd6NQwtg==
X-Gm-Message-State: AOJu0YxpKxOcMQeaViBwoCwABwDDdd2gLrfK8vyGPC6THde2avks65kp
	9W+t9PJzxzRIARQ4hUYcyhAB+lUlbTB+ypPJMK+NS9Na7NE0reIb
X-Google-Smtp-Source: AGHT+IGGsI8QxA/ax0FtzuuOY3wCa0fKExkQy2Thg9FQKwyXs0zsdMWc9yTMXpokXOq9FgnHauwnIw==
X-Received: by 2002:a05:6a21:99a5:b0:1b2:487f:bb0d with SMTP id adf61e73a8af0-1b2487fc282mr560507637.49.1716818186351;
        Mon, 27 May 2024 06:56:26 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fd4e27adsm4896119b3a.213.2024.05.27.06.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:56:25 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: david@fromorbit.com
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	bfoster@redhat.com,
	djwong@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	raven@themaw.net,
	rcu@vger.kernel.org
Subject: Re: About the conflict between XFS inode recycle and VFS rcu-walk
Date: Mon, 27 May 2024 21:56:15 +0800
Message-Id: <20240527135615.2633248-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <ZlRVPv0EGIu5q7l9@dread.disaster.area>
References: <ZlRVPv0EGIu5q7l9@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 27 May 2024 at 19:41:18 +1000, Dave Chinner wrote:
> On Thu, May 16, 2024 at 03:23:40PM +0800, Ian Kent wrote:
> > On 16/5/24 15:08, Ian Kent wrote:
> > > On 16/5/24 12:56, Jinliang Zheng wrote:
> > > > > I encountered the following calltrace:
> > > > > 
> > > > > [20213.578756] BUG: kernel NULL pointer dereference, address:
> > > > > 0000000000000000
> > > > > [20213.578785] #PF: supervisor instruction fetch in kernel mode
> > > > > [20213.578799] #PF: error_code(0x0010) - not-present page
> > > > > [20213.578812] PGD 3f01d64067 P4D 3f01d64067 PUD 3f01d65067 PMD 0
> > > > > [20213.578828] Oops: 0010 [#1] SMP NOPTI
> > > > > [20213.578839] CPU: 92 PID: 766 Comm: /usr/local/serv Kdump:
> > > > > loaded Not tainted 5.4.241-1-tlinux4-0017.3 #1
> > > > > [20213.578860] Hardware name: New H3C Technologies Co., Ltd.
> > > > > UniServer R4900 G3/RS33M2C9SA, BIOS 2.00.38P02 04/14/2020
> > > > > [20213.578884] RIP: 0010:0x0
> > > > > [20213.578894] Code: Bad RIP value.
> > > > > [20213.578903] RSP: 0018:ffffc90021ebfc38 EFLAGS: 00010246
> > > > > [20213.578916] RAX: ffffffff82081f40 RBX: ffffc90021ebfce0 RCX:
> > > > > 0000000000000000
> > > > > [20213.578932] RDX: ffffc90021ebfd48 RSI: ffff88bfad8d3890 RDI:
> > > > > 0000000000000000
> > > > > [20213.578948] RBP: ffffc90021ebfc70 R08: 0000000000000001 R09:
> > > > > ffff889b9eeae380
> > > > > [20213.578965] R10: 302d343200000067 R11: 0000000000000001 R12:
> > > > > 0000000000000000
> > > > > [20213.578981] R13: ffff88bfad8d3890 R14: ffff889b9eeae380 R15:
> > > > > ffffc90021ebfd48
> > > > > [20213.578998] FS:  00007f89c534e740(0000)
> > > > > GS:ffff88c07fd00000(0000) knlGS:0000000000000000
> > > > > [20213.579016] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > [20213.579030] CR2: ffffffffffffffd6 CR3: 0000003f01d90001 CR4:
> > > > > 00000000007706e0
> > > > > [20213.579046] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > > > > 0000000000000000
> > > > > [20213.579062] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > > > > 0000000000000400
> > > > > [20213.579079] PKRU: 55555554
> > > > > [20213.579087] Call Trace:
> > > > > [20213.579099]  trailing_symlink+0x1da/0x260
> > > > > [20213.579112]  path_lookupat.isra.53+0x79/0x220
> > > > > [20213.579125]  filename_lookup.part.69+0xa0/0x170
> > > > > [20213.579138]  ? kmem_cache_alloc+0x3f/0x3f0
> > > > > [20213.579151]  ? getname_flags+0x4f/0x1e0
> > > > > [20213.579161]  user_path_at_empty+0x3e/0x50
> > > > > [20213.579172]  vfs_statx+0x76/0xe0
> > > > > [20213.579182]  __do_sys_newstat+0x3d/0x70
> > > > > [20213.579194]  ? fput+0x13/0x20
> > > > > [20213.579203]  ? ksys_ioctl+0xb0/0x300
> > > > > [20213.579213]  ? generic_file_llseek+0x24/0x30
> > > > > [20213.579225]  ? fput+0x13/0x20
> > > > > [20213.579233]  ? ksys_lseek+0x8d/0xb0
> > > > > [20213.579243]  __x64_sys_newstat+0x16/0x20
> > > > > [20213.579256]  do_syscall_64+0x4d/0x140
> > > > > [20213.579268]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
> > > > > 
> > > > > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> > > > > 
> > > > Please note that the kernel version I use is the one maintained by
> > > > Tencent.Inc,
> > > > and the baseline is v5.4. But in fact, in the latest upstream source
> > > > tree,
> > > > although the trailing_symlink() function has been removed, its logic
> > > > has been
> > > > moved to pick_link(), so the problem still exists.
> > > > 
> > > > Ian Kent pointed out that try_to_unlazy() was introduced in
> > > > pick_link() in the
> > > > latest upstream source tree, but I don't understand why this can
> > > > solve the NULL
> > > > ->get_link pointer dereference problem, because ->get_link pointer
> > > > will be
> > > > dereferenced before try_to_unlazy().
> > > > 
> > > > (I don't understand why Ian Kent's email didn't appear on the
> > > > mailing list.)
> > > 
> > > It was something about html mail and I think my mail client was at fault.
> > > 
> > > In any case what you say is indeed correct, so the comment isn't
> > > important.
> > > 
> > > 
> > > Fact is it is still a race between the lockless path walk and inode
> > > eviction
> > > 
> > > and xfs recycling. I believe that the xfs recycling code is very hard to
> > > fix.
> 
> Not really for this case. This is simply concurrent pathwalk lookups
> occurring just after the inode has been evicted from the VFS inode
> cache. The first lookup hits the XFS inode cache, sees
> XFS_IRECLAIMABLE, and it then enters xfs_reinit_inode() to
> reinstantiate the VFS inode to an initial state. The Xfs inode
> itself is still valid as it hasn't reached the XFS_IRECLAIM state
> where it will be torn down and freed.
> 
> Whilst we are running xfs_reinit_inode(), a second RCU pathwalk has
> been run and that it is trying to call ->get_link on that same
> inode. Unfortunately, the first lookup has just set inode->f_ops =
> &empty_fops as part of the VFS inode reinit, and that then triggers
> the null pointer deref.

The RCU pathwalk must occur before xfs_reinit_inode(), and must obtain the
target inode before xfs_reinit_inode(). Because the target inode of
xfs_reinit_inode() must NOT be associated with any dentry, which is necessary
conditions for iput() -> iput_final() -> evict(), and the RCU pathwalk cannot
obtain any inode without a dentry.

> 
> Once the first lookup has finished the inode_init_always(),
> xfs_reinit_inode() resets inode->f_ops back to 
> xfs_symlink_file_ops and get_link calls work again.
> 
> Fundamentally, the problem is that we are completely reinitialising
> the VFS inode within the RCU grace period. i.e. while concurrent RCU
> pathwalks can still be in progress and find the VFS inode whilst the
> XFS inode cache is manipulating it.
> 
> What we should be doing here is a subset of inode_init_always(),
> which only reinitialises the bits of the VFS inode we need to
> initialise rather than the entire inode. The identity of the inode
> is not changing and so we don't need to go through a transient state
> where the VFS inode goes xfs symlink -> empty initialised inode ->
> xfs symlink.

Sorry, I think this question is wrong in more ways than just inode_operations.
After the target inode has been reinited by xfs_reinit_inode(), its semantics
is no longer the inode required by RCU walkpath. The meanings of many fields
have changed, such as mode, i_mtime, i_atime, i_ctime and so on.

> 
> i.e. We need to re-initialise the non-identity related parts of the
> VFS inode so the identity parts that the RCU pathwalks rely on never
> change within the RCU grace period where lookups can find the VFS
> inode after it has been evicted.
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

