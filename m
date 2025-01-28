Return-Path: <linux-fsdevel+bounces-40249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E99FA211FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 20:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D94F17A4456
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 19:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE8D1DED78;
	Tue, 28 Jan 2025 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DVWx3TJs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E8B1DE8AD
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 19:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091480; cv=none; b=ojXUKTGtvD57kG42jUpCNXd3hEDs+K/ZmLmPz4jDbOpPU94tzHmZ3nvxZSWl/YunRDjADv/QmaaTNAbciXiDpM0Oc5uWVLm64UwsOgccXT2+ocQmRxmVij0+9OpvXnipOOxGiu3kZKwn19Jeh4aBPyuDabnDzjmC07WLUj1E0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091480; c=relaxed/simple;
	bh=+hzuBfFg7K6TqkJXl//PSTrUF4nd/QIbA4vDwZ41wOU=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=DnQAU50kMI9+OtUakaPo4+SLNWoeCdDjF6sQvP8ABue9720TrnLfRluoYmR4Xj3Rc+6GMvumtfM/PCWkV8VPWVd6mgKHp0SAeFo9sJ2KyFvSj+RDWVkGt1Y36shTbkrnSnAv8MtquT3r1GUKGiqGyKWmG6crITl+ehcm39dvV/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DVWx3TJs; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738091466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmZT8PaXoi/HunjOtQbjefqQfnCV71OuFQe94XCRs20=;
	b=DVWx3TJs2soTZpBNemucvFacnryUUHga12rgZBxAaTOhcYj1iFJyC/YOMue+8tUTZF7bxa
	t4RNum65n2ZPreOB+DqRztoXAr33zSlnnqYrfOL0nikI8PmfwlpZ0Cq3wJB8yH9ucFBPnz
	ezKiXyQ+O4wSq08poCTOcU41RlpGK5o=
Date: Tue, 28 Jan 2025 19:11:04 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Message-ID: <335ad811ae2cf5ebdfc494c185b9f02e9ca40c3e@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] netfs: Add retry stat counters
To: "David Howells" <dhowells@redhat.com>, "Marc Dionne"
 <marc.dionne@auristor.com>, "Steve French" <stfrench@microsoft.com>
Cc: dhowells@redhat.com, "Eric Van Hensbergen" <ericvh@kernel.org>,
 "Latchesar Ionkov" <lucho@ionkov.net>, "Dominique Martinet"
 <asmadeus@codewreck.org>, "Christian Schoenebeck"
 <linux_oss@crudebyte.com>, "Paulo Alcantara" <pc@manguebit.com>, "Jeff
 Layton" <jlayton@kernel.org>, "Christian Brauner" <brauner@kernel.org>,
 v9fs@lists.linux.dev, linux-cifs@vger.kernel.org, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 ast@kernel.org, bpf@vger.kernel.org
In-Reply-To: <3187377.1738056789@warthog.procyon.org.uk>
References: <3173328.1738024385@warthog.procyon.org.uk>
 <3187377.1738056789@warthog.procyon.org.uk>
X-Migadu-Flow: FLOW_OUT

January 28, 2025 at 1:33 AM, "David Howells" <dhowells@redhat.com> wrote:

>=20
>=20Here's an additional patch to allow stats on the number of retries to=
 be
>=20
>=20obtained. This isn't a fix per se.
>=20
>=20David
>
> [...]

Hi David, Marc.

I regret to report that this patch didn't fix the hanging in
v9fs_evict_inode when running selftests/bpf.

Here is what I tried to test:

  * Checked out latest bpf-next source tree (0fc5dddb9409)
  * Applied patch: https://lore.kernel.org/netfs/3173328.1738024385@warth=
og.procyon.org.uk/
  * Applied retry stats patch: https://lore.kernel.org/netfs/3187377.1738=
056789@warthog.procyon.org.uk/
  * Modified tools/testing/selftests/bpf/config to enable /proc/fs/netfs/=
stats
  * Modified CI scripts to collect the stats
  * Ran the shell script reproducing the CI testing pipeline

Bash piece starting a process collecting /proc/fs/netfs/stats:

    function tail_netfs {
        echo -n > /mnt/vmtest/netfs-stats.log
        while true; do
            echo >> /mnt/vmtest/netfs-stats.log
            cat /proc/fs/netfs/stats >> /mnt/vmtest/netfs-stats.log
            sleep 1
        done
    }
    export -f tail_netfs
    nohup bash -c 'tail_netfs' & disown

Last recored /proc/fs/netfs/stats (note 0 retries):

    Reads  : DR=3D0 RA=3D15184 RF=3D5 RS=3D0 WB=3D0 WBZ=3D0
    Writes : BW=3D488 WT=3D0 DW=3D0 WP=3D488 2C=3D0
    ZeroOps: ZR=3D7964 sh=3D0 sk=3D0
    DownOps: DL=3D15189 ds=3D15189 df=3D0 di=3D0
    CaRdOps: RD=3D0 rs=3D0 rf=3D0
    UpldOps: UL=3D488 us=3D488 uf=3D0
    CaWrOps: WR=3D0 ws=3D0 wf=3D0
    Retries: rq=3D0 rs=3D0 wq=3D0 ws=3D0
    Objs   : rr=3D2 sr=3D1 foq=3D1 wsc=3D0
    WbLock : skip=3D0 wait=3D0
    -- FS-Cache statistics --
    Cookies: n=3D0 v=3D0 vcol=3D0 voom=3D0
    Acquire: n=3D0 ok=3D0 oom=3D0
    LRU    : n=3D0 exp=3D0 rmv=3D0 drp=3D0 at=3D0
    Invals : n=3D0
    Updates: n=3D0 rsz=3D0 rsn=3D0
    Relinqs: n=3D0 rtr=3D0 drop=3D0
    NoSpace: nwr=3D0 ncr=3D0 cull=3D0
    IO     : rd=3D0 wr=3D0 mis=3D0

The stack on hung task hasn't changed:

    [  184.375149] INFO: task modprobe:2759 blocked for more than 20 seco=
nds.
    [  184.376149]       Tainted: G           OE      6.13.0-gbb67a65a921=
c-dirty #3
    [  184.376593] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" dis=
ables this message.
    [  184.377119] task:modprobe        state:D stack:0     pid:2759  tgi=
d:2759  ppid:455    flags:0x00004002
    [  184.377701] Call Trace:
    [  184.377886]  <TASK>
    [  184.378039]  __schedule+0xa91/0xe80
    [  184.378282]  schedule+0x41/0xb0
    [  184.378490]  v9fs_evict_inode+0xfe/0x170
    [  184.378754]  ? __pfx_var_wake_function+0x10/0x10
    [  184.379070]  evict+0x1ef/0x360
    [  184.379288]  __dentry_kill+0xb0/0x220
    [  184.379528]  ? dput+0x3a/0x1d0
    [  184.379736]  dput+0x114/0x1d0
    [  184.379946]  __fput+0x136/0x2b0
    [  184.380158]  task_work_run+0x89/0xc0
    [  184.380396]  do_exit+0x2c6/0x9c0
    [  184.380617]  do_group_exit+0xa4/0xb0
    [  184.380870]  __x64_sys_exit_group+0x17/0x20
    [  184.381137]  x64_sys_call+0x21a0/0x21a0
    [  184.381386]  do_syscall_64+0x79/0x120
    [  184.381630]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
    [  184.381969] RIP: 0033:0x7f817bf7c21d
    [  184.382202] RSP: 002b:00007fff92c8d148 EFLAGS: 00000206 ORIG_RAX: =
00000000000000e7
    [  184.382676] RAX: ffffffffffffffda RBX: 00007f817c092fa8 RCX: 00007=
f817bf7c21d
    [  184.383138] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 00000=
00000000001
    [  184.383582] RBP: 00007fff92c8d1a0 R08: 00007fff92c8d0e8 R09: 00000=
00000000000
    [  184.384042] R10: 00007fff92c8d05f R11: 0000000000000206 R12: 00000=
00000000001
    [  184.384486] R13: 0000000000000000 R14: 0000000000000001 R15: 00007=
f817c092fc0
    [  184.384963]  </TASK>
    [  184.385112]
    [  184.385112] Showing all locks held in the system:
    [  184.385499] 1 lock held by khungtaskd/32:
    [  184.385793]  #0: ffffffff9d195d90 (rcu_read_lock){....}-{1:3}, at:=
 debug_show_all_locks+0x2e/0x180
    [  184.386366] 2 locks held by kworker/u8:10/455:
    [  184.386649]  #0: ffffa1a240104d48 ((wq_completion)events_unbound){=
+.+.}-{0:0}, at: process_scheduled_works+0x23a/0x600
    [  184.387357]  #1: ffffb06380a23e20 ((work_completion)(&sub_info->wo=
rk)){+.+.}-{0:0}, at: process_scheduled_works+0x25a/0x600
    [  184.388076]
    [  184.388183] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

I pushed full logs to github:
https://github.com/kernel-patches/bpf/commit/88c0d0e1692b04c0d54b7c194100=
3758d23e0d6a

I recommend trying to reproduce with steps I shared in my initial report:
https://lore.kernel.org/bpf/a7x33d4dnMdGTtRivptq6S1i8btK70SNBP2XyX_xwDAhL=
vgQoPox6FVBOkifq4eBinfFfbZlIkMZBe3QarlWTxoEtHZwJCZbNKtaqrR7PvI=3D@pm.me/

I know it may not be very convenient due to all the CI stuff, but you
should be able to use it to iterate on the kernel source locally and
narrow down the problem.

I have everything set up, so you also might share some debugging code
for me to run if you prefer.

Thanks.

---

Not directly related, but it took me a while to figure out how to
collect the netfs stats.

I first added:
    CONFIG_NETFS_DEBUG=3Dy
    CONFIG_NETFS_STATS=3Dy

But that didn't work, because /proc/fs/netfs/stats is created only
with CONFIG_FSCACHE_STATS (fs/netfs/main.c):

    #ifdef CONFIG_FSCACHE_STATS
            if (!proc_create_single("fs/netfs/stats", S_IFREG | 0444, NUL=
L,
                                    netfs_stats_show))
                    goto error_procfile;
    #endif

And that depends on CONFIG_FSCACHE=3Dy, so I ended up with:

    CONFIG_FSCACHE=3Dy
    CONFIG_FSCACHE_STATS=3Dy
    CONFIG_NETFS_SUPPORT=3Dy
    CONFIG_NETFS_DEBUG=3Dy
    CONFIG_NETFS_STATS=3Dy

