Return-Path: <linux-fsdevel+bounces-20215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2918CFD4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 11:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6572428105C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 09:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913F713AD14;
	Mon, 27 May 2024 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="pqc8Cl7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839C913AA54
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716802884; cv=none; b=Jvzx+OcpX6EId3n3YtmUrxIm0c7azSoVNR8A36ncV1Q/6BsytNWeRU2fc93B4IqNwzJA7tnveZH6yZX5Z1284RBZTfKlRgS3nTNFpHLAVwTgR3xfsBzyJjn+rnpR+bZVWB2ngCjPgJ/vOEbSbzPouDEhW9D+K8mmAJ3vniS4xUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716802884; c=relaxed/simple;
	bh=0Zrwzc6df6IFQfS1/XIBTBiqyVbeqBNE7NyQC1Nmtbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eD1oi+q6JW/slJ2/bzBsF09KyTMXy5PoQmfJmQ6z6D0Yg7ooI/uQbblEe2KTQ8eZw7oKPZavtoOwO4ebWzMXCTnifJDz+9PJ4QgpLxWDoYgJq2wkdtziwIDuIQ/NnOPQ9ApB7H5f+lar6Wiu9dl9Et48PpiDe27WxsFHjaGZy+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=pqc8Cl7u; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2bf5baa2773so2572413a91.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 02:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1716802882; x=1717407682; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+8gxNcVFWirZ31LoEEY20bp3YI5Zlkldggnnr1LW6VY=;
        b=pqc8Cl7u9mcbRrfAv666QmdhqvW+GXbF0ihS915tGrucQGTM6/yVEcLvnaUNV5U2bN
         B2h71jOX8Iooe+3zxj9kN3CZKXwtdNQbYSpRZK24YzUM7h/Q5WRBQhpcwODo6DmkT7Nj
         QwzANRLq9JZgEwGo4c7i+vQRIjVxE1qYBbf2l5guAuqnCeIn12Mu3LmMrk/jK9pXbasN
         8JC84OfszqP0kl8J481NQMUed2P9dh7jCVGZUYRUR1g4LrX6zGxncPACDRNLonci/xJJ
         BssSQvCbLKBz6vMi7m/Bz5Uu90VrQjrE/Jg/Qi7sLAY5OW63/OVhYXJ5wD0owgu66Wjg
         cIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716802882; x=1717407682;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+8gxNcVFWirZ31LoEEY20bp3YI5Zlkldggnnr1LW6VY=;
        b=WTTJElxXI17WaEQ0oRIqA7ISCXN5S28fN+gFf92cPkLNfA3nnuc8XRoFzBoRmpIujy
         16timPi0KscZx8unN9fpNm01Zhx9MA/DHM5DKiFhFpgymRzg5MLQpGMKW2rl4yZooSLk
         JAPh3setCQ/iyPhw4dT2irwjgP2GrJSKAyShgU+gSmJ2/NX8+KcpMP+PCuIGKAgwk0cC
         oqxEoim7tCvUr97BuQK9Mz4X0Z0IFyFahKIrOGaNZm0b6KKPu9DOTmjHC3E8sgNF/NnW
         PvCGAMcSuWnIOqFK1PK0Pti9FX4Ciex+a/6ltdOcjSKO1/qE5J1Wluotbgxfd0AUN/YA
         9Y9A==
X-Forwarded-Encrypted: i=1; AJvYcCU6JwI45FiwqiHoW7U4jzcgRTnoTp3WacD8JObOG6eACghbzBJulyvrOUtIBgfveQi/X67scBMCVfoTrc91azkuUJI0Z6ksOfyKkUsWpg==
X-Gm-Message-State: AOJu0YxLSeM0YbLxEn00FAnOA2Hk06XBXY/wC/wWhc9xIbzzJeNrL6Ek
	/3904f1ZynifA7B1ctF6UFvBIcj48Z7NI4wW6qZD1rFtepHqXyYWmQXuopSFa/8=
X-Google-Smtp-Source: AGHT+IHkHA9PGtS6NUdhkvlZxZe+UY2Tf4e1T+h4Oq0CH//KjXpVUiGmtak6tj35U98uNuBj6D/otg==
X-Received: by 2002:a17:90a:cb0c:b0:2bd:ed7e:b712 with SMTP id 98e67ed59e1d1-2bf5e84a967mr9703323a91.9.1716802881596;
        Mon, 27 May 2024 02:41:21 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bf5f613795sm6016723a91.31.2024.05.27.02.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 02:41:21 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sBWr0-00CAKw-2q;
	Mon, 27 May 2024 19:41:18 +1000
Date: Mon, 27 May 2024 19:41:18 +1000
From: Dave Chinner <david@fromorbit.com>
To: Ian Kent <raven@themaw.net>
Cc: Jinliang Zheng <alexjlzheng@gmail.com>, alexjlzheng@tencent.com,
	bfoster@redhat.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: About the conflict between XFS inode recycle and VFS rcu-walk
Message-ID: <ZlRVPv0EGIu5q7l9@dread.disaster.area>
References: <20240515155441.2788093-1-alexjlzheng@tencent.com>
 <20240516045655.40122-1-alexjlzheng@tencent.com>
 <7f744bf5-5f6d-4031-8a4f-91be2cd45147@themaw.net>
 <3545f78c-5e1c-4328-8ab0-19227005f4b7@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3545f78c-5e1c-4328-8ab0-19227005f4b7@themaw.net>

On Thu, May 16, 2024 at 03:23:40PM +0800, Ian Kent wrote:
> On 16/5/24 15:08, Ian Kent wrote:
> > On 16/5/24 12:56, Jinliang Zheng wrote:
> > > > I encountered the following calltrace:
> > > > 
> > > > [20213.578756] BUG: kernel NULL pointer dereference, address:
> > > > 0000000000000000
> > > > [20213.578785] #PF: supervisor instruction fetch in kernel mode
> > > > [20213.578799] #PF: error_code(0x0010) - not-present page
> > > > [20213.578812] PGD 3f01d64067 P4D 3f01d64067 PUD 3f01d65067 PMD 0
> > > > [20213.578828] Oops: 0010 [#1] SMP NOPTI
> > > > [20213.578839] CPU: 92 PID: 766 Comm: /usr/local/serv Kdump:
> > > > loaded Not tainted 5.4.241-1-tlinux4-0017.3 #1
> > > > [20213.578860] Hardware name: New H3C Technologies Co., Ltd.
> > > > UniServer R4900 G3/RS33M2C9SA, BIOS 2.00.38P02 04/14/2020
> > > > [20213.578884] RIP: 0010:0x0
> > > > [20213.578894] Code: Bad RIP value.
> > > > [20213.578903] RSP: 0018:ffffc90021ebfc38 EFLAGS: 00010246
> > > > [20213.578916] RAX: ffffffff82081f40 RBX: ffffc90021ebfce0 RCX:
> > > > 0000000000000000
> > > > [20213.578932] RDX: ffffc90021ebfd48 RSI: ffff88bfad8d3890 RDI:
> > > > 0000000000000000
> > > > [20213.578948] RBP: ffffc90021ebfc70 R08: 0000000000000001 R09:
> > > > ffff889b9eeae380
> > > > [20213.578965] R10: 302d343200000067 R11: 0000000000000001 R12:
> > > > 0000000000000000
> > > > [20213.578981] R13: ffff88bfad8d3890 R14: ffff889b9eeae380 R15:
> > > > ffffc90021ebfd48
> > > > [20213.578998] FS:  00007f89c534e740(0000)
> > > > GS:ffff88c07fd00000(0000) knlGS:0000000000000000
> > > > [20213.579016] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [20213.579030] CR2: ffffffffffffffd6 CR3: 0000003f01d90001 CR4:
> > > > 00000000007706e0
> > > > [20213.579046] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > > > 0000000000000000
> > > > [20213.579062] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > > > 0000000000000400
> > > > [20213.579079] PKRU: 55555554
> > > > [20213.579087] Call Trace:
> > > > [20213.579099]  trailing_symlink+0x1da/0x260
> > > > [20213.579112]  path_lookupat.isra.53+0x79/0x220
> > > > [20213.579125]  filename_lookup.part.69+0xa0/0x170
> > > > [20213.579138]  ? kmem_cache_alloc+0x3f/0x3f0
> > > > [20213.579151]  ? getname_flags+0x4f/0x1e0
> > > > [20213.579161]  user_path_at_empty+0x3e/0x50
> > > > [20213.579172]  vfs_statx+0x76/0xe0
> > > > [20213.579182]  __do_sys_newstat+0x3d/0x70
> > > > [20213.579194]  ? fput+0x13/0x20
> > > > [20213.579203]  ? ksys_ioctl+0xb0/0x300
> > > > [20213.579213]  ? generic_file_llseek+0x24/0x30
> > > > [20213.579225]  ? fput+0x13/0x20
> > > > [20213.579233]  ? ksys_lseek+0x8d/0xb0
> > > > [20213.579243]  __x64_sys_newstat+0x16/0x20
> > > > [20213.579256]  do_syscall_64+0x4d/0x140
> > > > [20213.579268]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
> > > > 
> > > > <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
> > > > 
> > > Please note that the kernel version I use is the one maintained by
> > > Tencent.Inc,
> > > and the baseline is v5.4. But in fact, in the latest upstream source
> > > tree,
> > > although the trailing_symlink() function has been removed, its logic
> > > has been
> > > moved to pick_link(), so the problem still exists.
> > > 
> > > Ian Kent pointed out that try_to_unlazy() was introduced in
> > > pick_link() in the
> > > latest upstream source tree, but I don't understand why this can
> > > solve the NULL
> > > ->get_link pointer dereference problem, because ->get_link pointer
> > > will be
> > > dereferenced before try_to_unlazy().
> > > 
> > > (I don't understand why Ian Kent's email didn't appear on the
> > > mailing list.)
> > 
> > It was something about html mail and I think my mail client was at fault.
> > 
> > In any case what you say is indeed correct, so the comment isn't
> > important.
> > 
> > 
> > Fact is it is still a race between the lockless path walk and inode
> > eviction
> > 
> > and xfs recycling. I believe that the xfs recycling code is very hard to
> > fix.

Not really for this case. This is simply concurrent pathwalk lookups
occurring just after the inode has been evicted from the VFS inode
cache. The first lookup hits the XFS inode cache, sees
XFS_IRECLAIMABLE, and it then enters xfs_reinit_inode() to
reinstantiate the VFS inode to an initial state. The Xfs inode
itself is still valid as it hasn't reached the XFS_IRECLAIM state
where it will be torn down and freed.

Whilst we are running xfs_reinit_inode(), a second RCU pathwalk has
been run and that it is trying to call ->get_link on that same
inode. Unfortunately, the first lookup has just set inode->f_ops =
&empty_fops as part of the VFS inode reinit, and that then triggers
the null pointer deref.

Once the first lookup has finished the inode_init_always(),
xfs_reinit_inode() resets inode->f_ops back to 
xfs_symlink_file_ops and get_link calls work again.

Fundamentally, the problem is that we are completely reinitialising
the VFS inode within the RCU grace period. i.e. while concurrent RCU
pathwalks can still be in progress and find the VFS inode whilst the
XFS inode cache is manipulating it.

What we should be doing here is a subset of inode_init_always(),
which only reinitialises the bits of the VFS inode we need to
initialise rather than the entire inode. The identity of the inode
is not changing and so we don't need to go through a transient state
where the VFS inode goes xfs symlink -> empty initialised inode ->
xfs symlink.

i.e. We need to re-initialise the non-identity related parts of the
VFS inode so the identity parts that the RCU pathwalks rely on never
change within the RCU grace period where lookups can find the VFS
inode after it has been evicted.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

