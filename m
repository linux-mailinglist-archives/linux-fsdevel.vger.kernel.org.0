Return-Path: <linux-fsdevel+bounces-32286-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A2D9A3184
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 01:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F2E284A21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 23:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5EF200B90;
	Thu, 17 Oct 2024 23:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLSvQ/8x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9211420E30A;
	Thu, 17 Oct 2024 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729209535; cv=none; b=RzjWga+wYLi32m6oUGK263EmNBQ9nwMFCZTQgRd6pFajuxTvJ1LghMDOe2iMRBkmIAikx0MFIScvlWTn1vgHWbFGXL6EUrhvokXC13T7s6uIXLDwRZwLtfPEpa+KOvjZCd1LEw5A6tt8hnoKzWWHNrNHyAqZIy4mD82pufUSziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729209535; c=relaxed/simple;
	bh=FYIIlPb1Dzj703pBn3uPCwFDnxavblLqM/DI9g0ZGHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djWfK/JmC11aMP6Gz1JOgvH2zO1KJnU46f4eO1xbs12n1meilQJxO+7dUUrucOQ5zPehhjTdMk9epT8Bwo/SGUxwdbcGnHFl6D0WLtp/o//D4W/llIiKCWhtHtaSNQrFj/h3My9dmeXW2klpkCl903E7hf4Be3lgfz4taLqk1Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLSvQ/8x; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b1389b6949so127690385a.1;
        Thu, 17 Oct 2024 16:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729209532; x=1729814332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHFZbO13u8KxCTroaS9tqg7RizOHDbUedk4itPhWsaU=;
        b=MLSvQ/8xHyRbyOdjs83VG1ko6cH+cKUyaen/TACeTWEVT6lFoU1qT8Q+2qz5tAEcNS
         x4cswj6HrV9/2P4Kctwxs6VyJUltmYirW1nBTqirV/rHVhPWTrgJeTwcnKkYenQ93IA+
         cVWhvFY3GlXGdrgK6n7l+9Y+jHTOwsg5qL+JGAXspUeP5QgkodBjiwuzHe6jxki8QnzR
         5dHGkrAtDa1ZhG9UKzt5aSS/8z69N5u1dtKlEbYFRQK1DnTniQn5XhnNqgsmt8n73mdj
         0bpywRGPdTr+ryz+F1ohDgUTU9z71K7IvqlFa15IZHAsKIi/F6H96KQJZVHt+mVO/T11
         fcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729209532; x=1729814332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHFZbO13u8KxCTroaS9tqg7RizOHDbUedk4itPhWsaU=;
        b=jktxluzDvqdHzIfga+QiAk+xgwEuz970dQT5gjMDkVq8vzcbSHJkcIhsUMebhIJiZk
         FjmA0ZWOrP59QbAwtO1lKKVFSvCZB2Yzi1JPYv5oWRp//77ccGDLWWsnn7VYXK4lNHO9
         fqV4RE8WRVQG57M7DoyJWDu0bq7yfd0KLN4cMeO2bxPJAw8c5hkb27q/G3jYcch3RWIu
         3bVARvuq4hG7DFoygiQnqmB+JwtEQUQe+wSYRw34n87W7kS8vdeGdrjq45zB7y6prz/k
         DEwfvCbvQbkP7az8F0ANAakPTGrWrUPPcocXivWyWspVTjk+E9dVOS8RTsDHmj5RcUhz
         povw==
X-Forwarded-Encrypted: i=1; AJvYcCVkImb2x1kusTBFx7O1SEJASg23ItuTw2ZiJNuOz+KNzInIa4CDv0dUEYTepg32u/sFPGeCIQHrAFW0SKbf@vger.kernel.org, AJvYcCWpfx4VoUnwYVaUqs5uMUydav6rYAugkjCgVDtYKUOPD3tKHvjQ2t9gCPj7bid95C6QVJXVl4rNqd0z@vger.kernel.org, AJvYcCXtZDVfJoZKXgQ6hfQMcHLcnaG3Qk5gGNLkVR0tIsxyFf8ocf8I8hcjnpRQCPZPRzd8G9hTZ1+kCsxB89wHSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWhGVvPnSxvmdzQ+Q2MZfad4XiMjnqZf0UMEAs2kUv3ZfUbkDz
	aREQCeJNZtFhkTQaxCvc5kgkn2gxjDCRdoAt0bh5fVAe20KzYTCM
X-Google-Smtp-Source: AGHT+IHqBKpArcJ/GKlEZYFLScAvSQLMhZ4lAJ+aY47B3ClwqT9DIJ8UzhI/SJhE8R1s18/6V6m0/A==
X-Received: by 2002:a05:620a:2681:b0:7b1:50ba:76e8 with SMTP id af79cd13be357-7b157b5d7dfmr62724085a.23.1729209532305;
        Thu, 17 Oct 2024 16:58:52 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b156feef8bsm19345385a.105.2024.10.17.16.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 16:58:51 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 56A1E1200043;
	Thu, 17 Oct 2024 19:58:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 17 Oct 2024 19:58:51 -0400
X-ME-Sender: <xms:u6QRZ3WcOIuezSd8KTPV6sqc0kuchEVuEy14FShAerfceiTgBja-AA>
    <xme:u6QRZ_nXfR2wQ5haoayOH7fiGs-fngnY9W2-n_KXhrFZqgqS29JpPQhL9QJZmOTGE
    GLnRqy8QVNGUItfNw>
X-ME-Received: <xmr:u6QRZzYDi50VmEHAnGqNDUO4zKvborAl-XOAX7dpeDGBnRDMWCwy2I-zyKs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehvddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgoufhushhpvggtthffoh
    hmrghinhculdegledmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeggeehieejkeevjeejjedvhfejfeduudeiveet
    teefueevjedvvefhheeiueekheenucffohhmrghinhepshihiihkrghllhgvrhdrrghpph
    hsphhothdrtghomhdpghhoohhglhgvrghpihhsrdgtohhmpdhgohhordhglhdpkhgvrhhn
    vghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeg
    hedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomh
    esfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehshiiisghothdojehfgegriehfjehfjedthedugeejgegvgedtrg
    gusehshiiikhgrlhhlvghrrdgrphhpshhpohhtmhgrihhlrdgtohhmpdhrtghpthhtohep
    rgguihhlghgvrhdrkhgvrhhnvghlseguihhlghgvrhdrtggrpdhrtghpthhtoheplhhinh
    hugidqvgigthegsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlih
    hnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    hiiikhgrlhhlvghrqdgsuhhgshesghhoohhglhgvghhrohhuphhsrdgtohhmpdhrtghpth
    htohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopegsohhquhhnsehfihigmhgv
    rdhnrghmvg
X-ME-Proxy: <xmx:u6QRZyVOvgfeU92TIsXCFDvlc_VL7MdemwKpaptzlIWPxBIXB7wajA>
    <xmx:u6QRZxlInKKJRvOmblSW-GE9vHBFD-DQLGz2ExItEblpXCSZEPZ89w>
    <xmx:u6QRZ_fEQ0sQ_iFo6Qb02dNwhcpQa7t2sCyotPKI1o2TOzrGFqiGLA>
    <xmx:u6QRZ7FYIidECG5AkcFO8eWwIc4MHar-5QwpH_Bk6vllqkzAR6Zmgg>
    <xmx:u6QRZzmWK892-9Qt2jzuu35YuXourm7HGtDBTZBRRklvZDVbr9_yABHQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 19:58:50 -0400 (EDT)
Date: Thu, 17 Oct 2024 16:58:49 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: syzbot <syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Subject: Re: [syzbot] [ext4?] WARNING: locking bug in ext4_move_extents
Message-ID: <ZxGkuaVUl8KRPAxO@Boquns-Mac-mini.local>
References: <000000000000e55d2005fd59d6c9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e55d2005fd59d6c9@google.com>

On Sun, Jun 04, 2023 at 08:53:02PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    9561de3a55be Linux 6.4-rc5
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14df9d7d280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
> dashboard link: https://syzkaller.appspot.com/bug?extid=7f4a6f7f7051474e40ad
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/661f38eebc53/disk-9561de3a.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d6c5afef083c/vmlinux-9561de3a.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7506eac4fc9d/bzImage-9561de3a.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7f4a6f7f7051474e40ad@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> Looking for class "&ei->i_data_sem" with key init_once.__key.780, but found a different class "&ei->i_data_sem" with the same key
> WARNING: CPU: 0 PID: 15140 at kernel/locking/lockdep.c:941 look_up_lock_class+0xc2/0x140 kernel/locking/lockdep.c:938
> Modules linked in:
> CPU: 0 PID: 15140 Comm: syz-executor.2 Not tainted 6.4.0-rc5-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
> RIP: 0010:look_up_lock_class+0xc2/0x140 kernel/locking/lockdep.c:938
> Code: 8b 16 48 c7 c0 60 91 1e 90 48 39 c2 74 46 f6 05 5d 02 92 03 01 75 3d c6 05 54 02 92 03 01 48 c7 c7 a0 ae ea 8a e8 de 8a a3 f6 <0f> 0b eb 26 e8 f5 d0 80 f9 48 c7 c7 e0 ad ea 8a 89 de e8 37 ca fd
> RSP: 0018:ffffc9000356f410 EFLAGS: 00010046
> RAX: 9c96f62a5d44cf00 RBX: ffffffff9009a460 RCX: 0000000000040000
> RDX: ffffc9000cf9f000 RSI: 0000000000004e87 RDI: 0000000000004e88
> RBP: ffffc9000356f518 R08: ffffffff81530142 R09: ffffed1017305163
> R10: 0000000000000000 R11: dffffc0000000001 R12: 0000000000000001
> R13: 1ffff920006ade90 R14: ffff888074763488 R15: ffffffff91cac681
> FS:  00007fe07ba3e700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2d523000 CR3: 0000000021c7c000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  register_lock_class+0x104/0x990 kernel/locking/lockdep.c:1290
>  __lock_acquire+0xd3/0x2070 kernel/locking/lockdep.c:4965
>  lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5705
>  down_write_nested+0x3d/0x50 kernel/locking/rwsem.c:1689
>  ext4_move_extents+0x37d/0xe40 fs/ext4/move_extent.c:621
>  __ext4_ioctl fs/ext4/ioctl.c:1352 [inline]
>  ext4_ioctl+0x3870/0x5b60 fs/ext4/ioctl.c:1608
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:870 [inline]
>  __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:856
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7fe07ac8c169
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fe07ba3e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fe07adac120 RCX: 00007fe07ac8c169
> RDX: 0000000020000280 RSI: 00000000c028660f RDI: 0000000000000007
> RBP: 00007fe07ace7ca1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffe5c49953f R14: 00007fe07ba3e300 R15: 0000000000022000
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the bug is already fixed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to change bug's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the bug is a duplicate of another bug, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git lockdep-for-tip

