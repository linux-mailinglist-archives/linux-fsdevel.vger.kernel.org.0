Return-Path: <linux-fsdevel+bounces-61084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E36ADB54F23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 15:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566F2A001FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0406630DED0;
	Fri, 12 Sep 2025 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NuffpF8a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E080309DCB
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757682982; cv=none; b=MN/5LZ1HTmaeTd+TwA9WgxxhqGT62Ub9CKWBE6lkzeK7Wg/FEZNfZLlm7/dAvXX7IuAyq8mkL7kkg4BwdxEviec1jeMCbnrZCV4MOF1+TwtYC3YB1SA9TLxQyni/PSCxfK79JDsdSEj0nDjGH7u0x5FYoAbhdrTb5WubKSfwXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757682982; c=relaxed/simple;
	bh=9zL1d/Eo8LPWIuZSVErzfe9xt5SmhQ7+18/W9NoHyvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rhwh336rmo090YTO2OmQqMVGchOs4VYlWiN8T2fKQGQ4w0j0NN8CEysIW9qi17gjFvtj7S69s5kEJzswqfMrC7CY3a+R7xHR+sdHLb44LLmcO/b9RyhZ02oTb8w0oYOkQbekmNsNjdDQX0c5ey/zg2hwYwYBip0fcRa6wJTWAuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NuffpF8a; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ea3e8290621so255210276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Sep 2025 06:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757682979; x=1758287779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WacX0Y225mfF5Mr+dq8TTghuE82OqAke+XlwrZchO4o=;
        b=NuffpF8avu1rUQlK93HcgBEIW8Bn5cqsdpwGXuWpKfIEcnr7PbtiAXcrICiLp94p3s
         tPM0ehosF0pW8pqtUN+bp5bJUpkKUGfoaH6x4ofI2TvToqnyUT4LOCDIkZz5Z3S21xHn
         xgnRsKCzdW6u9ro6T6VuPu0eqeGpZBCZKYjChZvJ2GrntnxRT4wCw/kctshKyvUfeXKd
         zT7ZMVjmnGSA4KoosnYLunPmLVIMMloqJt2G8JMcMd/z4qFPeURy0rIpdg3b9MCChSKR
         mm2VfmuTT3Z+RKNK+dRr4j1og9U+trkHW3n89EmgewPsnyzD4lsAaF8GGZKRQsE+dbey
         eVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757682979; x=1758287779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WacX0Y225mfF5Mr+dq8TTghuE82OqAke+XlwrZchO4o=;
        b=BYpfj+zCN0woODxMsMbXaddyesCl233Y9/KRLFcF9yWK3OosmoYurTGmPECfVKQ1Je
         pMHfiKS1iG/NZ2Pcs0uFdZf4VmXIHn55+MF8erPeerBLnq9S+W9+k801Aw5K+BoQeOzq
         CdNbCAYv1RnLxhkSr9G+MUOl2EWQQ/7ImAO7cOZL9476IVlKtAJUNSBpcBprT9F69PLn
         4tNsNL2dpn1uz3opQpzAs2NL/2BGFDKDeVjH7HdL8YLvnwIKhl6Lz+G24xn3StSOOSuZ
         totbQEUupfUh+xiGTmEcRyE7n45RxkbUp2g6Mlxi433R2RfNW/WzgfKhnsgN1C9eKqzq
         PO/A==
X-Forwarded-Encrypted: i=1; AJvYcCWlN83XX0okd0P1nZXfJuScMR9Ue0G9B7RNRRz28m673jIZb8fL65KRaet70S3URfp9UaD8jjTHk7eULUTi@vger.kernel.org
X-Gm-Message-State: AOJu0YwJUOxL5VzCGpbqJaaq+io8MSpLEo7A/FbAXXyJIUHrrDZ6bgJP
	f3Bp/gar3oNj016JXVpD9BgjL3nUH657obwNCGUjHF/E+X5WUUaBDw/gvXqwOiWwhgAvucD8opY
	oqhb09fY8NW5TposeUa5PfaFTXDqifjoOPB1e1BlGdA==
X-Gm-Gg: ASbGncuT2zTGuPQDBy6rlX8dUZLVYR/dwD0LFFSrKdy9TNbSBscFVIojQvqWwAOs0Be
	cb/qHcIXY9LIREbNu/ta1zzH8vY5cIvEv7DDRMaS94y40qwG/3p7UuQHQG1yewFR3xGAFDBq4S4
	8dgj/An/0JP/ou3z0jhqp5NQ97NDnMq5xD1Ii+0wJhJFVblHQJEicNNRPpPJzYJTx75FO5VjdwM
	VyBwgg3UA8yf+Y=
X-Google-Smtp-Source: AGHT+IGYP/z3abyUgCJL16DnEpbMeZjMz4kBCICiy0J25UHYR5eBa2TN11vPJBGTBUTyY1a8ErBJ1zUjhD2KUm8MoWo=
X-Received: by 2002:a05:690c:c90:b0:723:b3d4:1cfd with SMTP id
 00721157ae682-73065dac45bmr29462097b3.54.1757682978514; Fri, 12 Sep 2025
 06:16:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8957c526-d05c-4c0d-bfed-0eb6e6d2476c@linux.ibm.com> <BAEAC2F7-7D7F-49E4-AB21-10FC0E4BF5F3@linux.ibm.com>
In-Reply-To: <BAEAC2F7-7D7F-49E4-AB21-10FC0E4BF5F3@linux.ibm.com>
From: Julian Sun <sunjunchao@bytedance.com>
Date: Fri, 12 Sep 2025 21:16:07 +0800
X-Gm-Features: Ac12FXxgWzP6HGChGViD5jg5oUeivsG-aZaYxectxJJdHUjuwBlW_e-BOMpk6RE
Message-ID: <CAHSKhteONXP5n9m0=Xia0jTFvLWnfpSKHYWyzRVigT0VwmGcgQ@mail.gmail.com>
Subject: Re: [External] Re: [linux-next20250911]Kernel OOPs while running
 generic/256 on Pmem device
To: Venkat <venkat88@linux.ibm.com>
Cc: tj@kernel.org, akpm@linux-foundation.org, stable@vger.kernel.org, 
	songmuchun@bytedance.com, shakeelb@google.com, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, mhocko@suse.com, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, riteshh@linux.ibm.com, 
	ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Linux Next Mailing List <linux-next@vger.kernel.org>, 
	cgroups@vger.kernel.org, linux-mm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the report. I will take a look at this issue.

On Fri, Sep 12, 2025 at 8:33=E2=80=AFPM Venkat <venkat88@linux.ibm.com> wro=
te:
>
>
>
> > On 12 Sep 2025, at 10:51=E2=80=AFAM, Venkat Rao Bagalkote <venkat88@lin=
ux.ibm.com> wrote:
> >
> > Greetings!!!
> >
> >
> > IBM CI has reported a kernel crash, while running generic/256 test case=
 on pmem device from xfstests suite on linux-next20250911 kernel.
> >
> >
> > xfstests: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> >
> > local.config:
> >
> > [xfs_dax]
> > export RECREATE_TEST_DEV=3Dtrue
> > export TEST_DEV=3D/dev/pmem0
> > export TEST_DIR=3D/mnt/test_pmem
> > export SCRATCH_DEV=3D/dev/pmem0.1
> > export SCRATCH_MNT=3D/mnt/scratch_pmem
> > export MKFS_OPTIONS=3D"-m reflink=3D0 -b size=3D65536 -s size=3D512"
> > export FSTYP=3Dxfs
> > export MOUNT_OPTIONS=3D"-o dax"
> >
> >
> > Test case: generic/256
> >
> >
> > Traces:
> >
> >
> > [  163.371929] ------------[ cut here ]------------
> > [  163.371936] kernel BUG at lib/list_debug.c:29!
> > [  163.371946] Oops: Exception in kernel mode, sig: 5 [#1]
> > [  163.371954] LE PAGE_SIZE=3D64K MMU=3DRadix  SMP NR_CPUS=3D8192 NUMA =
pSeries
> > [  163.371965] Modules linked in: xfs nft_fib_inet nft_fib_ipv4 nft_fib=
_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_=
ct nft_chain_nat nf_nat nf_conntrack bonding tls nf_defrag_ipv6 nf_defrag_i=
pv4 rfkill ip_set nf_tables nfnetlink sunrpc pseries_rng vmx_crypto dax_pme=
m fuse ext4 crc16 mbcache jbd2 nd_pmem papr_scm sd_mod libnvdimm sg ibmvscs=
i ibmveth scsi_transport_srp pseries_wdt
> > [  163.372127] CPU: 22 UID: 0 PID: 130 Comm: kworker/22:0 Kdump: loaded=
 Not tainted 6.17.0-rc5-next-20250911 #1 VOLUNTARY
> > [  163.372142] Hardware name: IBM,9080-HEX Power11 (architected) 0x8202=
00 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> > [  163.372155] Workqueue: cgroup_free css_free_rwork_fn
> > [  163.372169] NIP:  c000000000d051d4 LR: c000000000d051d0 CTR: 0000000=
000000000
> > [  163.372176] REGS: c00000000ba079b0 TRAP: 0700   Not tainted (6.17.0-=
rc5-next-20250911)
> > [  163.372183] MSR:  800000000282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>=
  CR: 28000000  XER: 00000006
> > [  163.372214] CFAR: c0000000002bae9c IRQMASK: 0
> > [  163.372214] GPR00: c000000000d051d0 c00000000ba07c50 c00000000230a60=
0 0000000000000075
> > [  163.372214] GPR04: 0000000000000004 0000000000000001 c000000000507e2=
c 0000000000000001
> > [  163.372214] GPR08: c000000d0cb87d13 0000000000000000 000000000000000=
0 a80e000000000000
> > [  163.372214] GPR12: c00e0001a1970fa2 c000000d0ddec700 c000000000208e5=
8 c000000107b5e190
> > [  163.372214] GPR16: c00000000d3e5d08 c00000000b71cf78 c00000000d3e5d0=
5 c00000000b71cf30
> > [  163.372214] GPR20: c00000000b71cf08 c00000000b71cf10 c000000019f5858=
8 c000000004704bc8
> > [  163.372214] GPR24: c000000107b5e100 c000000004704bd0 000000000000000=
3 c000000004704bd0
> > [  163.372214] GPR28: c000000004704bc8 c000000019f585a8 c000000019f53da=
8 c000000004704bc8
> > [  163.372315] NIP [c000000000d051d4] __list_add_valid_or_report+0x124/=
0x188
> > [  163.372326] LR [c000000000d051d0] __list_add_valid_or_report+0x120/0=
x188
> > [  163.372335] Call Trace:
> > [  163.372339] [c00000000ba07c50] [c000000000d051d0] __list_add_valid_o=
r_report+0x120/0x188 (unreliable)
> > [  163.372352] [c00000000ba07ce0] [c000000000834280] mem_cgroup_css_fre=
e+0xa0/0x27c
> > [  163.372363] [c00000000ba07d50] [c0000000003ba198] css_free_rwork_fn+=
0xd0/0x59c
> > [  163.372374] [c00000000ba07da0] [c0000000001f5d60] process_one_work+0=
x41c/0x89c
> > [  163.372385] [c00000000ba07eb0] [c0000000001f76c0] worker_thread+0x55=
8/0x848
> > [  163.372394] [c00000000ba07f80] [c000000000209038] kthread+0x1e8/0x23=
0
> > [  163.372406] [c00000000ba07fe0] [c00000000000ded8] start_kernel_threa=
d+0x14/0x18
> > [  163.372416] Code: 4b9b1099 60000000 7f63db78 4bae8245 60000000 e8bf0=
008 3c62ff88 7fe6fb78 7fc4f378 38637d40 4b5b5c89 60000000 <0fe00000> 600000=
00 60000000 7f83e378
> > [  163.372453] ---[ end trace 0000000000000000 ]---
> > [  163.380581] pstore: backend (nvram) writing error (-1)
> > [  163.380593]
> >
> >
> > If you happen to fix this issue, please add below tag.
> >
> >
> > Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> >
> >
> >
> > Regards,
> >
> > Venkat.
> >
> >
>
> After reverting the below commit, issue is not seen.
>
> commit 61bbf51e75df1a94cf6736e311cb96aeb79826a8
> Author: Julian Sun <sunjunchao@bytedance.com>
> Date:   Thu Aug 28 04:45:57 2025 +0800
>
>     memcg: don't wait writeback completion when release memcg
>          Recently, we encountered the following hung task:
>          INFO: task kworker/4:1:1334558 blocked for more than 1720 second=
s.
>     [Wed Jul 30 17:47:45 2025] Workqueue: cgroup_destroy css_free_rwork_f=
n
>     [Wed Jul 30 17:47:45 2025] Call Trace:
>     [Wed Jul 30 17:47:45 2025]  __schedule+0x934/0xe10
>     [Wed Jul 30 17:47:45 2025]  ? complete+0x3b/0x50
>     [Wed Jul 30 17:47:45 2025]  ? _cond_resched+0x15/0x30
>     [Wed Jul 30 17:47:45 2025]  schedule+0x40/0xb0
>     [Wed Jul 30 17:47:45 2025]  wb_wait_for_completion+0x52/0x80
>     [Wed Jul 30 17:47:45 2025]  ? finish_wait+0x80/0x80
>     [Wed Jul 30 17:47:45 2025]  mem_cgroup_css_free+0x22/0x1b0
>     [Wed Jul 30 17:47:45 2025]  css_free_rwork_fn+0x42/0x380
>     [Wed Jul 30 17:47:45 2025]  process_one_work+0x1a2/0x360
>     [Wed Jul 30 17:47:45 2025]  worker_thread+0x30/0x390
>     [Wed Jul 30 17:47:45 2025]  ? create_worker+0x1a0/0x1a0
>     [Wed Jul 30 17:47:45 2025]  kthread+0x110/0x130
>     [Wed Jul 30 17:47:45 2025]  ? __kthread_cancel_work+0x40/0x40
>     [Wed Jul 30 17:47:45 2025]  ret_from_fork+0x1f/0x30
>          The direct cause is that memcg spends a long time waiting for di=
rty page
>     writeback of foreign memcgs during release.
>          The root causes are:
>         a. The wb may have multiple writeback tasks, containing millions
>            of dirty pages, as shown below:
>          >>> for work in list_for_each_entry("struct wb_writeback_work", =
\
>                                         wb.work_list.address_of_(), "list=
"):
>     ...     print(work.nr_pages, work.reason, hex(work))
>     ...
>     900628  WB_REASON_FOREIGN_FLUSH 0xffff969e8d956b40
>     1116521 WB_REASON_FOREIGN_FLUSH 0xffff9698332a9540
>     1275228 WB_REASON_FOREIGN_FLUSH 0xffff969d9b444bc0
>     1099673 WB_REASON_FOREIGN_FLUSH 0xffff969f0954d6c0
>     1351522 WB_REASON_FOREIGN_FLUSH 0xffff969e76713340
>     2567437 WB_REASON_FOREIGN_FLUSH 0xffff9694ae208400
>     2954033 WB_REASON_FOREIGN_FLUSH 0xffff96a22d62cbc0
>     3008860 WB_REASON_FOREIGN_FLUSH 0xffff969eee8ce3c0
>     3337932 WB_REASON_FOREIGN_FLUSH 0xffff9695b45156c0
>     3348916 WB_REASON_FOREIGN_FLUSH 0xffff96a22c7a4f40
>     3345363 WB_REASON_FOREIGN_FLUSH 0xffff969e5d872800
>     3333581 WB_REASON_FOREIGN_FLUSH 0xffff969efd0f4600
>     3382225 WB_REASON_FOREIGN_FLUSH 0xffff969e770edcc0
>     3418770 WB_REASON_FOREIGN_FLUSH 0xffff96a252ceea40
>     3387648 WB_REASON_FOREIGN_FLUSH 0xffff96a3bda86340
>     3385420 WB_REASON_FOREIGN_FLUSH 0xffff969efc6eb280
>     3418730 WB_REASON_FOREIGN_FLUSH 0xffff96a348ab1040
>     3426155 WB_REASON_FOREIGN_FLUSH 0xffff969d90beac00
>     3397995 WB_REASON_FOREIGN_FLUSH 0xffff96a2d7288800
>     3293095 WB_REASON_FOREIGN_FLUSH 0xffff969dab423240
>     3293595 WB_REASON_FOREIGN_FLUSH 0xffff969c765ff400
>     3199511 WB_REASON_FOREIGN_FLUSH 0xffff969a72d5e680
>     3085016 WB_REASON_FOREIGN_FLUSH 0xffff969f0455e000
>     3035712 WB_REASON_FOREIGN_FLUSH 0xffff969d9bbf4b00
>              b. The writeback might severely throttled by wbt, with a spe=
ed
>            possibly less than 100kb/s, leading to a very long writeback t=
ime.
>          >>> wb.write_bandwidth
>     (unsigned long)24
>     >>> wb.write_bandwidth
>     (unsigned long)13
>          The wb_wait_for_completion() here is probably only used to preve=
nt
>     use-after-free.  Therefore, we manage 'done' separately and automatic=
ally
>     free it.
>          This allows us to remove wb_wait_for_completion() while preventi=
ng the
>     use-after-free issue.
>      com
>     Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flush=
ing")
>     Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
>     Acked-by: Tejun Heo <tj@kernel.org>
>     Cc: Michal Hocko <mhocko@suse.com>
>     Cc: Roman Gushchin <roman.gushchin@linux.dev>
>     Cc: Johannes Weiner <hannes@cmpxchg.org>
>     Cc: Shakeel Butt <shakeelb@google.com>
>     Cc: Muchun Song <songmuchun@bytedance.com>
>     Cc: <stable@vger.kernel.org>
>     Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>
> Regards,
> Venkat.
>
> >
>

Thanks,
--=20
Julian Sun <sunjunchao@bytedance.com>

