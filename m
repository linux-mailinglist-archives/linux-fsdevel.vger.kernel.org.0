Return-Path: <linux-fsdevel+bounces-77363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JPWNcZhlGlfDQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 13:40:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7995014C09A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 13:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 123BF3034DE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 12:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D673542EB;
	Tue, 17 Feb 2026 12:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mINhAXpX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338D238D52;
	Tue, 17 Feb 2026 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332013; cv=none; b=VfbLBiRu1GBIshH4+QMHNB+DubK9f+6E2+3o1wvytHWgulpBvgZu7pVeL3zZRjbZNfhJqY5LV88HlVrHhhOqw9/e5i5+PJHFpk1IX/nf8QFLx4lI5vxP6kVKPN/STKLMSpAhfF5bdsbXEZUZs0mxsDl/uR02T+KqE+/LhWw01aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332013; c=relaxed/simple;
	bh=Cv9YZAtKIYxIQHe8nYOsd5s6BvFlBPBW7t+UdGCZP+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppia72lo8WgpfM3H49qfqj1YfDJwS2YAIFnNmtFNtJl5S82AraVXHHBU33E4WlzOjLbphGqhCxbkCw7LEOETZoSscUMaUxNthYtBso62b+aRT5PkN3E7THVYsC1Y0jRP+oUhSVPjrr7EgihmW0qnAy/zO2Ltx1ZG5bMwamJOtLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mINhAXpX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D155C4CEF7;
	Tue, 17 Feb 2026 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771332013;
	bh=Cv9YZAtKIYxIQHe8nYOsd5s6BvFlBPBW7t+UdGCZP+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mINhAXpXy7TA7ywuNp5N1U19In2TE7v83dMzDGDiTokcaFdbC9QTxipK03vwN0pgr
	 8dZlrAzy4n4UmaU+xbA00J5YaIWMV/qgxA6+p7RrR1RLs/ORSYCdi/xvwDMdR78nuU
	 V2nUk5BLMbfIMv7kbU/bA4Iqzi3uw+kxPfWa8GsZSq6qQz0c+Q6Wtmu95mKC+zFB+Y
	 3/9M/WmoyP5jRKhD/31lhSETeM4ooVR6P8B8c2IOqJAUY6/4DjUBNWNHrBobdbd3nL
	 6g9vuFP5jEaALn/BcOrYyQH5Z0r4XvAgE1ZGlPZM/FtPIavdqxFQh2wiijYQtmDT2h
	 UotufL0nDCgGQ==
Date: Tue, 17 Feb 2026 13:40:08 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Ritesh Harjani <riteshh@linux.ibm.com>, ojaswin@linux.ibm.com
Subject: Re: [next-20260216]NULL pointer dereference in drain_obj_stock()
 (RCU free path)
Message-ID: <aZReMzl-S9KM_snh@nidhogg.toxiclabs.cc>
References: <ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-77363-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nidhogg.toxiclabs.cc:mid]
X-Rspamd-Queue-Id: 7995014C09A
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 04:59:12PM +0530, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> I am observing below OOPs, while running xfstests generic/428 test case. But
> I am not able to reproduce this consistently.
> 
> 
> Platform: IBM Power11 (pSeries LPAR), Radix MMU, LE, 64K pages
> Kernel: 6.19.0-next-20260216
> Tests: generic/428
> 
> local.config >>>
> [xfs_4k]
> export RECREATE_TEST_DEV=true
> export TEST_DEV=/dev/loop0
> export TEST_DIR=/mnt/test
> export SCRATCH_DEV=/dev/loop1
> export SCRATCH_MNT=/mnt/scratch
> export MKFS_OPTIONS="-b size=4096"
> export FSTYP=xfs
> export MOUNT_OPTIONS=""-
> 
> 
> 
> Attached is .config file used.
> 
> 
> Traces:
> 

/me fixing trace's indentation

> 
> [ 6054.957411] run fstests generic/428 at 2026-02-16 22:25:57
> [ 6055.136443] Kernel attempted to read user page (0) - exploit attempt?
> (uid: 0)
> [ 6055.136474] BUG: Kernel NULL pointer dereference on read at 0x00000000
> [ 6055.136485] Faulting instruction address: 0xc0000000008aff0c
> [ 6055.136495] Oops: Kernel access of bad area, sig: 11 [#1]
> [ 6055.136505] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
> [ 6055.136517] Modules linked in: dm_thin_pool dm_persistent_data
> dm_bio_prison dm_snapshot dm_bufio dm_flakey xfs loop dm_mod nft_fib_inet
> nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
> nf_defrag_ipv6 nf_defrag_ipv4 bonding ip_set tls nf_tables rfkill sunrpc
> nfnetlink pseries_rng vmx_crypto dax_pmem fuse ext4 crc16 mbcache jbd2
> nd_pmem papr_scm sd_mod libnvdimm sg ibmvscsi ibmveth scsi_transport_srp
> pseries_wdt [last unloaded: scsi_debug]
> [ 6055.136684] CPU: 19 UID: 0 PID: 0 Comm: swapper/19 Kdump: loaded Tainted:
> G        W           6.19.0-next-20260216 #1 PREEMPTLAZY
> [ 6055.136701] Tainted: [W]=WARN
> [ 6055.136708] Hardware name: IBM,9080-HEX Power11 (architected) 0x820200
> 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [ 6055.136719] NIP:  c0000000008aff0c LR: c0000000008aff00 CTR:
> c00000000036d5e0
> [ 6055.136730] REGS: c000000d0dc877c0 TRAP: 0300   Tainted: G   W           
> (6.19.0-next-20260216)
> [ 6055.136742] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 84042802 XER: 20040037
> [ 6055.136777] CFAR: c000000000862a74 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0
> [ 6055.136777] GPR00: c0000000008aff00 c000000d0dc87a60 c00000000243a500 0000000000000001
> [ 6055.136777] GPR04: 0000000000000008 0000000000000001 c0000000008aff00 0000000000000001
> [ 6055.136777] GPR08: a80e000000000000 0000000000000001 0000000000000007
> a80e000000000000
> [ 6055.136777] GPR12: c00e00000c46e6d5 c000000d0ddf0b00 c000000019069a00
> 0000000000000006
> [ 6055.136777] GPR16: c000000007012fa0 c000000007012fa4 c000000005160980
> c000000007012f88
> [ 6055.136777] GPR20: c00c0000004d7cec c000000d0d10f008 0000000000000001
> ffffffffffffff78
> [ 6055.136777] GPR24: 0000000000000005 c000000d0d58f180 c0000001d0795e00
> c000000d0d10f01c
> [ 6055.136777] GPR28: c000000d0d10f008 c000000d0d10f010 c0000001d0795e08
> 0000000000000000
> [ 6055.136891] NIP [c0000000008aff0c] drain_obj_stock+0x620/0xa48
> [ 6055.136905] LR [c0000000008aff00] drain_obj_stock+0x614/0xa48
> [ 6055.136915] Call Trace:
> [ 6055.136919] [c000000d0dc87a60] [c0000000008aff00] drain_obj_stock+0x614/0xa48 (unreliable)
> [ 6055.136933] [c000000d0dc87b10] [c0000000008b27e4] refill_obj_stock+0x104/0x680
> [ 6055.136945] [c000000d0dc87b90] [c0000000008b9238] __memcg_slab_free_hook+0x238/0x3ec
> [ 6055.136956] [c000000d0dc87c60] [c0000000007f39a0] __rcu_free_sheaf_prepare+0x314/0x3e8
> [ 6055.136968] [c000000d0dc87d10] [c0000000007fbf0c] rcu_free_sheaf+0x38/0x170
> [ 6055.136980] [c000000d0dc87d50] [c0000000003344b0] rcu_do_batch+0x2ec/0xfa8
> [ 6055.136992] [c000000d0dc87e50] [c000000000339948] rcu_core+0x22c/0x48c
> [ 6055.137002] [c000000d0dc87ec0] [c0000000001cfe6c] handle_softirqs+0x1f4/0x74c
> [ 6055.137013] [c000000d0dc87fe0] [c00000000001b0cc] do_softirq_own_stack+0x60/0x7c
> [ 6055.137025] [c000000009717930] [c00000000001b0b8] do_softirq_own_stack+0x4c/0x7c
> [ 6055.137036] [c000000009717960] [c0000000001cf128] __irq_exit_rcu+0x268/0x308
> [ 6055.137046] [c0000000097179a0] [c0000000001d0ba4] irq_exit+0x20/0x38
> [ 6055.137056] [c0000000097179c0] [c0000000000315f4] interrupt_async_exit_prepare.constprop.0+0x18/0x2c
> [ 6055.137069] [c0000000097179e0] [c000000000009ffc] decrementer_common_virt+0x28c/0x290
> [ 6055.137080] ---- interrupt: 900 at plpar_hcall_norets_notrace+0x18/0x2c
> [ 6055.137090] NIP:  c00000000012d8f0 LR: c00000000135c3fc CTR: 0000000000000000
> [ 6055.137097] REGS: c000000009717a10 TRAP: 0900   Tainted: G   W            (6.19.0-next-20260216)
> [ 6055.137105] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24000804  XER: 00000037
> [ 6055.137134] CFAR: 0000000000000000 IRQMASK: 0
> [ 6055.137134] GPR00: 0000000000000000 c000000009717cb0 c00000000243a500 0000000000000000
> [ 6055.137134] GPR04: 0000000000000000 800400002fe6fc10 0000000000000000 0000000000000001
> [ 6055.137134] GPR08: 0000000000000033 0000000000000000 0000000000000090 0000000000000001
> [ 6055.137134] GPR12: 800400002fe6fc00 c000000d0ddf0b00 0000000000000000 000000002ef01a60
> [ 6055.137134] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [ 6055.137134] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000001
> [ 6055.137134] GPR24: 0000000000000000 c000000004d7a778 00000581d1a507b8 0000000000000000
> [ 6055.137134] GPR28: 0000000000000000 0000000000000001 c0000000032b18d8 c0000000032b18e0
> [ 6055.137229] NIP [c00000000012d8f0] plpar_hcall_norets_notrace+0x18/0x2c
> [ 6055.137238] LR [c00000000135c3fc] cede_processor.isra.0+0x1c/0x30
> [ 6055.137248] ---- interrupt: 900
> [ 6055.137253] [c000000009717cb0] [c000000009717cf0] 0xc000000009717cf0 (unreliable)
> [ 6055.137265] [c000000009717d10] [c0000000019af160] dedicated_cede_loop+0x90/0x170
> [ 6055.137277] [c000000009717d60] [c0000000019aeb10] cpuidle_enter_state+0x394/0x480
> [ 6055.137288] [c000000009717e00] [c0000000013589ec] cpuidle_enter+0x64/0x9c
> [ 6055.137298] [c000000009717e50] [c000000000284a8c] call_cpuidle+0x7c/0xf8
> [ 6055.137310] [c000000009717e90] [c000000000290398] cpuidle_idle_call+0x1c4/0x2b4
> [ 6055.137321] [c000000009717f00] [c0000000002905bc] do_idle+0x134/0x208
> [ 6055.137330] [c000000009717f50] [c000000000290a0c] cpu_startup_entry+0x60/0x64
> [ 6055.137341] [c000000009717f80] [c0000000000744b8] start_secondary+0x3fc/0x400
> [ 6055.137352] [c000000009717fe0] [c00000000000e258] start_secondary_prolog+0x10/0x14
> [ 6055.137363] Code: 60000000 3bda0008 7fc3f378 4bfb148d 60000000 ebfa0008 38800008 7fe3fb78 4bfb2b51 60000000 7c0004ac 39200001 <7d40f8a8> 7d495050 7d40f9ad 40c2fff4
> [ 6055.137400] ---[ end trace 0000000000000000 ]---

Again, nothing here seems to point to a xfs problem.

