Return-Path: <linux-fsdevel+bounces-20025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C8C8CC863
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 23:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1699282F2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 21:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4607A146A78;
	Wed, 22 May 2024 21:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="tmWdNIZY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qdWHR70i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D159145B20
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716415190; cv=none; b=pum3mcycsE2tgA3cE9qHqSM6ONEGXRU+2S4rf4zN1mEY16yiNLI+eR3UMETlY9cQKYQjknsNt3HtPQmz/FiGJYLPEGH9JhxPJl8c15JFWBqWlnYk/n5hnnQMjY7jkS6ldrMlG/Wk/z2KqkqcCqyoaBC666T4qhhKle0j21Knmtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716415190; c=relaxed/simple;
	bh=gq1A8d5eBf357QcMbRbWqL8YODs4QvV0F9uQ8OdPBmE=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=jHc60vhHHlSflijr2fcIgx+1Vu948+o6oo9s66S4x3tYXb+zAtIr5UcPYpi3Gez/pRswKjzrSj2+h9tm4xi1qpkT0nQdcMU/MPyzAWp50N1PPIKpVS6VacTBl1gBLypeWeHU4nh5W5wnGUgtTMubLYlyYndPm7Tk7Beib6hjwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=tmWdNIZY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qdWHR70i; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3F79A1140128;
	Wed, 22 May 2024 17:59:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 22 May 2024 17:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1716415187; x=1716501587; bh=Tux6MrkJCq
	mNXGYRDHbdVgEPUfyHv/r1MQhwU64ywow=; b=tmWdNIZYqeJuz0WjSuU0J2Qo6W
	B9lmTbAxRiNxGypCbhWjeoHDOQ73oYIAjIwBugSbY/gCx+pETpDIrGXIPnaY/EGx
	z5gDyk/Jq5HwIbxV77msTv0iROiYQajfhscnAvt/jA/FA27R2SwRbxjBP4LV+Ziq
	KBA3MUAg0EUdpqPyagLyU6jOMuXYZ02r+yIfD+xBOZtKYhFuN43+S0wm1VuXerGE
	NIZZA2r6G67/c1o4R24deAuEa3rHuuHGuxf+5wle/vJn/oMfyFBPtK43I9BWGgI6
	ZtOtyel/qJ+Oyvi0wMPGhvWf54BXtL+wK27qfPsuWLtgXe3wt/Odoa+jUEsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716415187; x=1716501587; bh=Tux6MrkJCqmNXGYRDHbdVgEPUfyH
	v/r1MQhwU64ywow=; b=qdWHR70iuTDAJbIXGQbz4ORQCOUUpURcBeW2ufebYgf6
	YwMEkQpaIyqOcRZz80h/nwDjkn6BfiJygbJXlOMe3kcaZpdnUYAsWbGzTD/aknGq
	l0grUbuvqDd/paGdRzBkJ1YUgwpoLgfrC1GiaJqP/D8Al5nyEND7tZ308hyMVDPh
	DJvbmNTF7as4tyy41I7zvr61ttb41bLzZOJfJVFoYQC25Sk5wFTnpeQ6mrBwHG2y
	27uLjVE+mEuxY2OWK/yC0p0UJWtamWshWOhmHc13ZgfA6l5zBOJaR+i9m3393aYU
	iBLXU1Ey9OEVYjPnoHQ1cRhtoXlnBRMRGjSjT2NUSw==
X-ME-Sender: <xms:0mpOZm3rHe88dQHLV9wiUf2pmAxZGTkw3hdMoUmDqsMZuFwkq0QXRw>
    <xme:0mpOZpFHs4dh-dCygiSLQZKyTQ49tDghs7a-alLjo1ME_qtnfNdCdvIV4gY1azKfn
    FEAqdbedaT-bpEs>
X-ME-Received: <xmr:0mpOZu4WrojVuItCDQFNZ7iKZErccR2FQjh3GnJsbAL8IIEMmoy6EjdALYEIpk7d476a8mysnJ9aj_dNsaQ2PLirewGoQKYU5Ugpyi9VPts2zNfinbHf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeihedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfhffvufgtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrghilhdrfh
    hmqeenucggtffrrghtthgvrhhnpefhtefgfeeuledtvdeuhfeivdelkedvvdfhueetffej
    geettedvgeetueeiveejfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:0mpOZn0DBWdgtmMNd4vjY1Xn4DXClp-504eUUDBWuJZew1cDWkZCPw>
    <xmx:0mpOZpGOxDfIzRcyFIwhHHldP5-RnGrKwxXzi5OVM7pebUfeXRUWNg>
    <xmx:0mpOZg-WWQOkbwJaQ9jqrSF6PIJ337D6uixxwxA8pzzlK0rM5ylV2A>
    <xmx:0mpOZunvZ7Q5aBtXMoUjtimHw8ynsiIFEYLuEtjWKMewD0SjfzVHbw>
    <xmx:02pOZpAOk_lhg3rxcTAsQ8UVM_neLGdelkq3lxiSlKysWdz_bQ-K6YcW>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 May 2024 17:59:46 -0400 (EDT)
Message-ID: <e67b7351-1739-437c-bea4-bb9373463339@fastmail.fm>
Date: Wed, 22 May 2024 23:59:44 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: fuse passthrough related circular locking dependency
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Amir, Miklos,

I'm preparing fuse-over-io-uring RFC2 and running xfstests on 
6.9. First run is without io-uring (patches applied, though) and 
generic/095 reports a circular lock dependency.

(I probably should disable passthrough in my uring patches
or add an iteration without it).

iter_file_splice_write
    pipe_lock(pipe)                    --> pipe first
    ...
    call_write_iter / fuse_file_write_iter
    fuse_file_write_iter
        fuse_direct_write_iter
           fuse_dio_lock
              inode_lock_shared        --> then inode lock


and
 
do_splice
   fuse_passthrough_splice_write       --> inode lock first
       backing_file_splice_write
           iter_file_splice_write
               pipe_lock(pipe);        --> then pipe lock
    

This looks a bit like we need to add another waitq to
avoid competing passthrough and dio. (Though very late here
and I might miss another solution.)


[ 6861.901629] run fstests generic/094 at 2024-05-22 21:32:10
[ 6865.327849] run fstests generic/095 at 2024-05-22 21:32:13

[ 6872.044270] ======================================================
[ 6872.045974] WARNING: possible circular locking dependency detected
[ 6872.047561] 6.9.0-rc7+ #5 Tainted: G           O      
[ 6872.049052] ------------------------------------------------------
[ 6872.050138] fio/48194 is trying to acquire lock:
[ 6872.051032] ffff888152f6a1d8 (&sb->s_type->i_mutex_key#16){++++}-{3:3}, at: fuse_file_write_iter+0x4c2/0x760 [fuse]
[ 6872.053213] 
               but task is already holding lock:
[ 6872.054309] ffff888155ed7a70 (&pipe->mutex){+.+.}-{3:3}, at: iter_file_splice_write+0x1e0/0xa00
[ 6872.055901] 
               which lock already depends on the new lock.

[ 6872.057435] 
               the existing dependency chain (in reverse order) is:
[ 6872.058789] 
               -> #2 (&pipe->mutex){+.+.}-{3:3}:
[ 6872.059905]        __mutex_lock+0xcb/0x790
[ 6872.060747]        iter_file_splice_write+0x1e0/0xa00
[ 6872.061691]        backing_file_splice_write+0x15a/0x230
[ 6872.062689]        fuse_passthrough_splice_write+0x14a/0x1e0 [fuse]
[ 6872.065117]        do_splice+0x6f3/0xbf0
[ 6872.065882]        __x64_sys_splice+0x204/0x2c0
[ 6872.066755]        do_syscall_64+0x7f/0x120
[ 6872.067574]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 6872.068621] 
               -> #1 (sb_writers#7){.+.+}-{0:0}:
[ 6872.069750]        sb_start_write+0x2f/0xc0
[ 6872.070587]        vfs_iter_write+0x10b/0x2a0
[ 6872.071412]        backing_file_write_iter+0x293/0x330
[ 6872.072378]        fuse_passthrough_write_iter+0x15f/0x1e0 [fuse]
[ 6872.073505]        fuse_file_write_iter+0x11b/0x760 [fuse]
[ 6872.074550]        vfs_write+0x553/0x5e0
[ 6872.075317]        ksys_write+0xd2/0x160
[ 6872.076078]        do_syscall_64+0x7f/0x120
[ 6872.076910]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 6872.077923] 
               -> #0 (&sb->s_type->i_mutex_key#16){++++}-{3:3}:
[ 6872.079252]        __lock_acquire+0x1ef5/0x41e0
[ 6872.080125]        lock_acquire+0x1fa/0x330
[ 6872.080950]        down_read+0x91/0x6f0
[ 6872.081718]        fuse_file_write_iter+0x4c2/0x760 [fuse]
[ 6872.082761]        iter_file_splice_write+0x6df/0xa00
[ 6872.083683]        do_splice+0x6f3/0xbf0
[ 6872.084478]        __x64_sys_splice+0x204/0x2c0
[ 6872.085338]        do_syscall_64+0x7f/0x120
[ 6872.086142]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 6872.087160] 
               other info that might help us debug this:

[ 6872.088653] Chain exists of:
                 &sb->s_type->i_mutex_key#16 --> sb_writers#7 --> &pipe->mutex

[ 6872.095520]  Possible unsafe locking scenario:

[ 6872.096673]        CPU0                    CPU1
[ 6872.097510]        ----                    ----
[ 6872.098350]   lock(&pipe->mutex);
[ 6872.099050]                                lock(sb_writers#7);
[ 6872.100091]                                lock(&pipe->mutex);
[ 6872.101165]   rlock(&sb->s_type->i_mutex_key#16);
[ 6872.102039] 
                *** DEADLOCK ***

[ 6872.103223] 2 locks held by fio/48194:
[ 6872.103951]  #0: ffff88816ca14430 (sb_writers#13){.+.+}-{0:0}, at: do_splice+0x6a6/0xbf0
[ 6872.105431]  #1: ffff888155ed7a70 (&pipe->mutex){+.+.}-{3:3}, at: iter_file_splice_write+0x1e0/0xa00
[ 6872.107057] 
               stack backtrace:
[ 6872.107945] CPU: 0 PID: 48194 Comm: fio Tainted: G           O       6.9.0-rc7+ #5
[ 6872.109329] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 6872.110957] Call Trace:
[ 6872.111508]  <TASK>
[ 6872.112000]  dump_stack_lvl+0xcc/0x100
[ 6872.112794]  ? tcp_gro_dev_warn+0x160/0x160
[ 6872.113595]  ? lockdep_print_held_locks+0xfb/0x130
[ 6872.114475]  ? print_circular_bug+0xfe/0x110
[ 6872.115312]  check_noncircular+0x24c/0x270
[ 6872.116093]  ? print_deadlock_bug+0x3c0/0x3c0
[ 6872.116946]  ? lockdep_lock+0xc9/0x180
[ 6872.117690]  ? is_ftrace_trampoline+0x73/0xa0
[ 6872.118556]  ? mark_lock+0xb8/0x240
[ 6872.119258]  ? add_chain_block+0x2fa/0x470
[ 6872.120044]  __lock_acquire+0x1ef5/0x41e0
[ 6872.120848]  ? print_deadlock_bug+0x3c0/0x3c0
[ 6872.121686]  ? lockdep_lock+0xc9/0x180
[ 6872.122416]  ? verify_lock_unused+0xb0/0xb0
[ 6872.123235]  ? save_trace+0x3f2/0x460
[ 6872.123957]  ? lockdep_unlock+0x94/0x160
[ 6872.125454]  ? lockdep_lock+0x180/0x180
[ 6872.126219]  ? __lock_acquire+0x1209/0x41e0
[ 6872.127044]  ? stack_depot_save_flags+0x247/0x7e0
[ 6872.127948]  lock_acquire+0x1fa/0x330
[ 6872.128711]  ? fuse_file_write_iter+0x4c2/0x760 [fuse]
[ 6872.129690]  ? read_lock_is_recursive+0x10/0x10
[ 6872.130557]  ? _raw_spin_unlock_irqrestore+0x31/0x40
[ 6872.131485]  ? stack_depot_save_flags+0x61e/0x7e0
[ 6872.132393]  ? fuse_file_write_iter+0x4c2/0x760 [fuse]
[ 6872.133386]  down_read+0x91/0x6f0
[ 6872.134063]  ? fuse_file_write_iter+0x4c2/0x760 [fuse]
[ 6872.135066]  ? kasan_save_track+0x2b/0x60
[ 6872.135857]  ? __kasan_kmalloc+0x89/0xa0
[ 6872.136650]  ? __kmalloc+0x259/0x500
[ 6872.137373]  ? iter_file_splice_write+0x1b0/0xa00
[ 6872.138257]  ? __down_common+0x450/0x450
[ 6872.139038]  ? iter_file_splice_write+0x1e0/0xa00
[ 6872.139914]  ? lock_acquired+0x594/0x6d0
[ 6872.140707]  fuse_file_write_iter+0x4c2/0x760 [fuse]
[ 6872.141668]  ? __x64_sys_splice+0x204/0x2c0
[ 6872.142470]  ? trace_contention_end+0xa2/0xd0
[ 6872.143327]  ? fuse_file_read_iter+0x310/0x310 [fuse]
[ 6872.144319]  ? __mutex_lock+0x1fa/0x790
[ 6872.145080]  ? splice_from_pipe_next+0x281/0x330
[ 6872.145953]  ? rcu_is_watching+0x1c/0x40
[ 6872.146748]  iter_file_splice_write+0x6df/0xa00
[ 6872.147606]  ? splice_from_pipe+0x160/0x160
[ 6872.148437]  ? read_lock_is_recursive+0x10/0x10
[ 6872.149299]  ? reacquire_held_locks+0x29d/0x3b0
[ 6872.150152]  ? vma_end_read+0x14/0xf0
[ 6872.150918]  ? fuse_splice_write+0x51/0xa0 [fuse]
[ 6872.151842]  do_splice+0x6f3/0xbf0
[ 6872.152571]  ? print_unlock_imbalance_bug+0x1f0/0x1f0
[ 6872.153508]  ? pipe_clear_nowait+0xa3/0xe0
[ 6872.154293]  ? wait_for_space+0x140/0x140
[ 6872.155864]  __x64_sys_splice+0x204/0x2c0
[ 6872.156697]  ? __x64_sys_vmsplice+0xa90/0xa90
[ 6872.157539]  do_syscall_64+0x7f/0x120
[ 6872.158264]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[ 6872.159224] RIP: 0033:0x7fabafaabfbb
[ 6872.159953] Code: e8 6a 4a f8 ff 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 4c 8b 54 24 18 8b 54 24 28 b8 13 01 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 35 89 ef 48 89 44 24 08 e8 91 4a f8 ff 48 8b
[ 6872.163051] RSP: 002b:00007fff2118afe0 EFLAGS: 00000293 ORIG_RAX: 0000000000000113
[ 6872.164448] RAX: ffffffffffffffda RBX: 00007fff2118b060 RCX: 00007fabafaabfbb
[ 6872.165670] RDX: 0000000000000009 RSI: 0000000000000000 RDI: 0000000000000007
[ 6872.166907] RBP: 0000000000000000 R08: 0000000000002000 R09: 0000000000000000
[ 6872.168124] R10: 00007fff2118b050 R11: 0000000000000293 R12: 0000564c4430a8b0
[ 6872.169378] R13: 00007fff2118b050 R14: 00007faba4f61490 R15: 00007fff2118b058
[ 6872.170618]  </TASK>

