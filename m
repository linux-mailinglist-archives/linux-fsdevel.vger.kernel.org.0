Return-Path: <linux-fsdevel+bounces-77563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WME9DTiklWnnSwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 12:36:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABB4155ED2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 12:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B19663009FB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 11:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B942FFDD5;
	Wed, 18 Feb 2026 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EI+E1DNg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ybgpTxLz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EI+E1DNg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ybgpTxLz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5CF30C350
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771414571; cv=none; b=jaiJU86k1wU81FiEqvPqKjsD1RdU4CYA9GJ93QLfXfyfBWxe2pi2zCeVkhsXsCdmOxG8v17PwdsW0XPCpyIOW0rMGils0ROxtWAyHC0lyWfLn/r90V5U2Bl7JLdL0ptcdgaSUrIv+ga29jOSiT33Nzh0ny2WuvM7svGt0Y9v2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771414571; c=relaxed/simple;
	bh=ACO3lR3pEmCqZ3Qhc33VeZTszZMYY/oAyWCbt5g/Cxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NAkm3gRHH45Y3ghhTCgX9aloPBPOhylEtCodY4/DB5vW8xnP6zle9W56zAmJRY19jxA0dggVZObTJ1ss4e1xPqGfQ2SNaxP+JHDiSKvwq0p6HldWnP34Foh2bTxzkTpjOa5sOGBIlJK3UJf0qbDHTznpVhpPpDpeXKZ9rZb5428=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EI+E1DNg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ybgpTxLz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EI+E1DNg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ybgpTxLz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8AFBA3E6D9;
	Wed, 18 Feb 2026 11:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771414567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LLWVE2pJKdeDYL0jdPU0U6FRetE5sTTjadtPT3PYWfA=;
	b=EI+E1DNgRnDuFFGenJw2KFJo8KFpVcYBzo+CkcbTy48mlcfHjKPV9C3S0MD5zBQyg/HkxG
	U2pb2VuM/AksrDJjEcMghe1C+BCzUbeIfJMCsJwWcR/jgu9CUPbfc0cvMoKhRpsRbR1Nz5
	qMhi/CvE9Iut0sT9BUHXDTsxCS+rGhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771414567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LLWVE2pJKdeDYL0jdPU0U6FRetE5sTTjadtPT3PYWfA=;
	b=ybgpTxLz3P6lZ8RyGGj/kScKLN20KLJ1HnH6DJxed8g8rwVUg007cQb1odjRfNIFeG4HsX
	/0IooVgCWBEugoAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EI+E1DNg;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ybgpTxLz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1771414567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LLWVE2pJKdeDYL0jdPU0U6FRetE5sTTjadtPT3PYWfA=;
	b=EI+E1DNgRnDuFFGenJw2KFJo8KFpVcYBzo+CkcbTy48mlcfHjKPV9C3S0MD5zBQyg/HkxG
	U2pb2VuM/AksrDJjEcMghe1C+BCzUbeIfJMCsJwWcR/jgu9CUPbfc0cvMoKhRpsRbR1Nz5
	qMhi/CvE9Iut0sT9BUHXDTsxCS+rGhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1771414567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LLWVE2pJKdeDYL0jdPU0U6FRetE5sTTjadtPT3PYWfA=;
	b=ybgpTxLz3P6lZ8RyGGj/kScKLN20KLJ1HnH6DJxed8g8rwVUg007cQb1odjRfNIFeG4HsX
	/0IooVgCWBEugoAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FAC03EA65;
	Wed, 18 Feb 2026 11:36:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7tS0ESeklWnOZQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 18 Feb 2026 11:36:07 +0000
Message-ID: <b4288fae-f805-42ff-a823-f6b66748ecfe@suse.cz>
Date: Wed, 18 Feb 2026 12:36:06 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [next-20260216]NULL pointer dereference in drain_obj_stock() (RCU
 free path)
Content-Language: en-US
To: Carlos Maiolino <cem@kernel.org>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Ritesh Harjani <riteshh@linux.ibm.com>, ojaswin@linux.ibm.com,
 Muchun Song <muchun.song@linux.dev>, Cgroups <cgroups@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Harry Yoo <harry.yoo@oracle.com>,
 Hao Li <hao.li@linux.dev>
References: <ca241daa-e7e7-4604-a48d-de91ec9184a5@linux.ibm.com>
 <aZReMzl-S9KM_snh@nidhogg.toxiclabs.cc>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aZReMzl-S9KM_snh@nidhogg.toxiclabs.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-77563-lists,linux-fsdevel=lfdr.de];
	DMARC_NA(0.00)[suse.cz];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@suse.cz,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:mid,suse.cz:dkim]
X-Rspamd-Queue-Id: 8ABB4155ED2
X-Rspamd-Action: no action

On 2/17/26 13:40, Carlos Maiolino wrote:
> On Tue, Feb 17, 2026 at 04:59:12PM +0530, Venkat Rao Bagalkote wrote:
>> Greetings!!!
>> 
>> I am observing below OOPs, while running xfstests generic/428 test case. But
>> I am not able to reproduce this consistently.
>> 
>> 
>> Platform: IBM Power11 (pSeries LPAR), Radix MMU, LE, 64K pages
>> Kernel: 6.19.0-next-20260216
>> Tests: generic/428
>> 
>> local.config >>>
>> [xfs_4k]
>> export RECREATE_TEST_DEV=true
>> export TEST_DEV=/dev/loop0
>> export TEST_DIR=/mnt/test
>> export SCRATCH_DEV=/dev/loop1
>> export SCRATCH_MNT=/mnt/scratch
>> export MKFS_OPTIONS="-b size=4096"
>> export FSTYP=xfs
>> export MOUNT_OPTIONS=""-
>> 
>> 
>> 
>> Attached is .config file used.
>> 
>> 
>> Traces:
>> 
> 
> /me fixing trace's indentation

CCing memcg and slab folks.
Would be nice to figure out where in drain_obj_stock things got wrong. Any
change for e.g. ./scripts/faddr2line ?

I wonder if we have either some bogus objext pointer, or maybe the
rcu_free_sheaf() context is new (or previously rare) for memcg and we have
some locking issues being exposed in refill/drain.

>> 
>> [ 6054.957411] run fstests generic/428 at 2026-02-16 22:25:57
>> [ 6055.136443] Kernel attempted to read user page (0) - exploit attempt?
>> (uid: 0)
>> [ 6055.136474] BUG: Kernel NULL pointer dereference on read at 0x00000000
>> [ 6055.136485] Faulting instruction address: 0xc0000000008aff0c
>> [ 6055.136495] Oops: Kernel access of bad area, sig: 11 [#1]
>> [ 6055.136505] LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=8192 NUMA pSeries
>> [ 6055.136517] Modules linked in: dm_thin_pool dm_persistent_data
>> dm_bio_prison dm_snapshot dm_bufio dm_flakey xfs loop dm_mod nft_fib_inet
>> nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4
>> nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack
>> nf_defrag_ipv6 nf_defrag_ipv4 bonding ip_set tls nf_tables rfkill sunrpc
>> nfnetlink pseries_rng vmx_crypto dax_pmem fuse ext4 crc16 mbcache jbd2
>> nd_pmem papr_scm sd_mod libnvdimm sg ibmvscsi ibmveth scsi_transport_srp
>> pseries_wdt [last unloaded: scsi_debug]
>> [ 6055.136684] CPU: 19 UID: 0 PID: 0 Comm: swapper/19 Kdump: loaded Tainted:
>> G        W           6.19.0-next-20260216 #1 PREEMPTLAZY
>> [ 6055.136701] Tainted: [W]=WARN
>> [ 6055.136708] Hardware name: IBM,9080-HEX Power11 (architected) 0x820200
>> 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
>> [ 6055.136719] NIP:  c0000000008aff0c LR: c0000000008aff00 CTR:
>> c00000000036d5e0
>> [ 6055.136730] REGS: c000000d0dc877c0 TRAP: 0300   Tainted: G   W           
>> (6.19.0-next-20260216)
>> [ 6055.136742] MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 84042802 XER: 20040037
>> [ 6055.136777] CFAR: c000000000862a74 DAR: 0000000000000000 DSISR: 40000000 IRQMASK: 0
>> [ 6055.136777] GPR00: c0000000008aff00 c000000d0dc87a60 c00000000243a500 0000000000000001
>> [ 6055.136777] GPR04: 0000000000000008 0000000000000001 c0000000008aff00 0000000000000001
>> [ 6055.136777] GPR08: a80e000000000000 0000000000000001 0000000000000007
>> a80e000000000000
>> [ 6055.136777] GPR12: c00e00000c46e6d5 c000000d0ddf0b00 c000000019069a00
>> 0000000000000006
>> [ 6055.136777] GPR16: c000000007012fa0 c000000007012fa4 c000000005160980
>> c000000007012f88
>> [ 6055.136777] GPR20: c00c0000004d7cec c000000d0d10f008 0000000000000001
>> ffffffffffffff78
>> [ 6055.136777] GPR24: 0000000000000005 c000000d0d58f180 c0000001d0795e00
>> c000000d0d10f01c
>> [ 6055.136777] GPR28: c000000d0d10f008 c000000d0d10f010 c0000001d0795e08
>> 0000000000000000
>> [ 6055.136891] NIP [c0000000008aff0c] drain_obj_stock+0x620/0xa48
>> [ 6055.136905] LR [c0000000008aff00] drain_obj_stock+0x614/0xa48
>> [ 6055.136915] Call Trace:
>> [ 6055.136919] [c000000d0dc87a60] [c0000000008aff00] drain_obj_stock+0x614/0xa48 (unreliable)
>> [ 6055.136933] [c000000d0dc87b10] [c0000000008b27e4] refill_obj_stock+0x104/0x680
>> [ 6055.136945] [c000000d0dc87b90] [c0000000008b9238] __memcg_slab_free_hook+0x238/0x3ec
>> [ 6055.136956] [c000000d0dc87c60] [c0000000007f39a0] __rcu_free_sheaf_prepare+0x314/0x3e8
>> [ 6055.136968] [c000000d0dc87d10] [c0000000007fbf0c] rcu_free_sheaf+0x38/0x170
>> [ 6055.136980] [c000000d0dc87d50] [c0000000003344b0] rcu_do_batch+0x2ec/0xfa8
>> [ 6055.136992] [c000000d0dc87e50] [c000000000339948] rcu_core+0x22c/0x48c
>> [ 6055.137002] [c000000d0dc87ec0] [c0000000001cfe6c] handle_softirqs+0x1f4/0x74c
>> [ 6055.137013] [c000000d0dc87fe0] [c00000000001b0cc] do_softirq_own_stack+0x60/0x7c
>> [ 6055.137025] [c000000009717930] [c00000000001b0b8] do_softirq_own_stack+0x4c/0x7c
>> [ 6055.137036] [c000000009717960] [c0000000001cf128] __irq_exit_rcu+0x268/0x308
>> [ 6055.137046] [c0000000097179a0] [c0000000001d0ba4] irq_exit+0x20/0x38
>> [ 6055.137056] [c0000000097179c0] [c0000000000315f4] interrupt_async_exit_prepare.constprop.0+0x18/0x2c
>> [ 6055.137069] [c0000000097179e0] [c000000000009ffc] decrementer_common_virt+0x28c/0x290
>> [ 6055.137080] ---- interrupt: 900 at plpar_hcall_norets_notrace+0x18/0x2c
>> [ 6055.137090] NIP:  c00000000012d8f0 LR: c00000000135c3fc CTR: 0000000000000000
>> [ 6055.137097] REGS: c000000009717a10 TRAP: 0900   Tainted: G   W            (6.19.0-next-20260216)
>> [ 6055.137105] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24000804  XER: 00000037
>> [ 6055.137134] CFAR: 0000000000000000 IRQMASK: 0
>> [ 6055.137134] GPR00: 0000000000000000 c000000009717cb0 c00000000243a500 0000000000000000
>> [ 6055.137134] GPR04: 0000000000000000 800400002fe6fc10 0000000000000000 0000000000000001
>> [ 6055.137134] GPR08: 0000000000000033 0000000000000000 0000000000000090 0000000000000001
>> [ 6055.137134] GPR12: 800400002fe6fc00 c000000d0ddf0b00 0000000000000000 000000002ef01a60
>> [ 6055.137134] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
>> [ 6055.137134] GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000001
>> [ 6055.137134] GPR24: 0000000000000000 c000000004d7a778 00000581d1a507b8 0000000000000000
>> [ 6055.137134] GPR28: 0000000000000000 0000000000000001 c0000000032b18d8 c0000000032b18e0
>> [ 6055.137229] NIP [c00000000012d8f0] plpar_hcall_norets_notrace+0x18/0x2c
>> [ 6055.137238] LR [c00000000135c3fc] cede_processor.isra.0+0x1c/0x30
>> [ 6055.137248] ---- interrupt: 900
>> [ 6055.137253] [c000000009717cb0] [c000000009717cf0] 0xc000000009717cf0 (unreliable)
>> [ 6055.137265] [c000000009717d10] [c0000000019af160] dedicated_cede_loop+0x90/0x170
>> [ 6055.137277] [c000000009717d60] [c0000000019aeb10] cpuidle_enter_state+0x394/0x480
>> [ 6055.137288] [c000000009717e00] [c0000000013589ec] cpuidle_enter+0x64/0x9c
>> [ 6055.137298] [c000000009717e50] [c000000000284a8c] call_cpuidle+0x7c/0xf8
>> [ 6055.137310] [c000000009717e90] [c000000000290398] cpuidle_idle_call+0x1c4/0x2b4
>> [ 6055.137321] [c000000009717f00] [c0000000002905bc] do_idle+0x134/0x208
>> [ 6055.137330] [c000000009717f50] [c000000000290a0c] cpu_startup_entry+0x60/0x64
>> [ 6055.137341] [c000000009717f80] [c0000000000744b8] start_secondary+0x3fc/0x400
>> [ 6055.137352] [c000000009717fe0] [c00000000000e258] start_secondary_prolog+0x10/0x14
>> [ 6055.137363] Code: 60000000 3bda0008 7fc3f378 4bfb148d 60000000 ebfa0008 38800008 7fe3fb78 4bfb2b51 60000000 7c0004ac 39200001 <7d40f8a8> 7d495050 7d40f9ad 40c2fff4
>> [ 6055.137400] ---[ end trace 0000000000000000 ]---
> 
> Again, nothing here seems to point to a xfs problem.
> 


