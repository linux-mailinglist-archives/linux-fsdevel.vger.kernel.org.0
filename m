Return-Path: <linux-fsdevel+bounces-52880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0226AE7EC6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 12:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF25189A42C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 10:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F572BEC39;
	Wed, 25 Jun 2025 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="3kUpTaWJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A02BCF4D;
	Wed, 25 Jun 2025 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846246; cv=none; b=GeVlSea+aNoIrt8Ytx9ZjG7dLgi4ksacCMBF8ZaYnoe87HpCkltQzCL1ICurKSChN360ZSgtlVsVlAU2Sx+v40F70IaU8/+V5Lu2VcyWC9vrIHmVStX3srZtO2lPZhaCgdvIcuM2n86OftCCwSBkUyuZUbE+5pj+5QXs+sRlYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846246; c=relaxed/simple;
	bh=LkUIUuxvI9+pSOrM8fBaunPMfvu0A7Df8v7u8k0hgL4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=h9/ECqPotC3g11I5seU4jldo1R3PnvqGxGgOQ9NL+BogEEq1+K1V2lsdolmp0QeRKWvC72spJHKBoRgzdKi4CqBezYWVf6RQlW6sXilFNw9xUXXcxZxSC2RCNYLPeX/hMMWNlSACQPhp4besKaGm2HQLGWGYhf0d1VD+0+OsuEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=3kUpTaWJ; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Cc:To:From:Date:Message-ID;
	bh=I3JIQN87DhAmoN/r06JPMh2tWfRpL1kRv0heGpkhbBM=; b=3kUpTaWJ1rZ88rj1OYca6ayMzk
	YbrnyXoEV3eNPbk/zeXBexKjC6LeP3XEelU39BxPj+dJNNMR4gPHH6PrehllsGMB2+8s3mfq/zyD3
	JfS0y4bRwKDbIjvJX7LcAiTqEx6RQTWkeULcqnlmztVUA8goPGIEjb5fn7Ns3oXF83dJ84IWvGbdc
	soVeqVWcHdl7TyJ8N2C1dO0FHFwMNiRkzRH/T2e/4VkAs6Um+4sRU1ZVES3ZDrTHtg1qojW9/ursQ
	KJasMsRfbg7sCiQtSqoNho/xZx8tn+lmG4eHV8syaJFPul85MkTGVUv6R1EkVSe0XxeEf7rpFvQWy
	55pslHw6gofDg0D6I7vrc+Y+MDg3bGn1Rh90b/Pvcof3Y+MfLpR5toCULoB+FzCuiOkpxct3tsWxt
	56txvhfGwLvCf3mVo++xTF3L43bPseOBhb/srQTD5RSiZ9q7Vo9an/r0g+oNPaqErdVjHEzfsjOLd
	4ps7PLr33J3W3hqASSxDRlxu;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uUN5W-00COeD-0V;
	Wed, 25 Jun 2025 10:10:42 +0000
Message-ID: <6b69eef7-781d-42d3-9ce0-973ff9152dd5@samba.org>
Date: Wed, 25 Jun 2025 12:10:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cifs: Collapse smbd_recv_*() into smbd_recv() and just
 use copy_to_iter()
From: Stefan Metzmacher <metze@samba.org>
To: David Howells <dhowells@redhat.com>
Cc: "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
 netfs@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Steve French <stfrench@microsoft.com>
References: <f448a729-ca2e-40a8-be67-3334f47a3916@samba.org>
 <1107690.1750683895@warthog.procyon.org.uk>
 <1156127.1750774971@warthog.procyon.org.uk>
 <acb7f612-df26-4e2a-a35d-7cd040f513e1@samba.org>
Content-Language: en-US
In-Reply-To: <acb7f612-df26-4e2a-a35d-7cd040f513e1@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 25.06.25 um 10:07 schrieb Stefan Metzmacher:
> Am 24.06.25 um 16:22 schrieb David Howells:
>> Stefan Metzmacher <metze@samba.org> wrote:
>>
>>>>    read_rfc1002_done:
>>>> +        /* SMBDirect will read it all or nothing */
>>>> +        msg->msg_iter.count = 0;
>>>
>>> And this iov_iter_truncate(0);
>>
>> Actually, it should probably have been iov_iter_advance().
>>
>>> While I'm wondering why we had this at all.
>>>
>>> It seems all callers of cifs_read_iter_from_socket()
>>> don't care and the code path via sock_recvmsg() doesn't
>>> truncate it just calls copy_to_iter() via this chain:
>>> ->inet_recvmsg->tcp_recvmsg->skb_copy_datagram_msg->skb_copy_datagram_iter
>>> ->simple_copy_to_iter->copy_to_iter()
>>>
>>> I think the old code should have called
>>> iov_iter_advance(rc) instead of msg->msg_iter.count = 0.
>>>
>>> But the new code doesn't need it as copy_to_iter()
>>> calls iterate_and_advance().
>>
>> Yeah, it should.  I seem to remember that there were situations in which it
>> didn't, but it's possible I managed to get rid of them.
>>
>>>> -    default:
>>>> -        /* It's a bug in upper layer to get there */
>>>> -        cifs_dbg(VFS, "Invalid msg type %d\n",
>>>> -             iov_iter_type(&msg->msg_iter));
>>>> -        rc = -EINVAL;
>>>> -    }
>>>
>>> I guess this is actually a real fix as I just saw
>>> CIFS: VFS: Invalid msg type 4
>>> in logs while running the cifs/001 test.
>>> And 4 is ITER_FOLIOQ.
>>
>> Ah... Were you using "-o seal"?  The encrypted data is held in a buffer formed
>> from a folioq with a series of folios in it.
> 
> I know tested it standalone in this tree:
> https://git.samba.org/?p=metze/linux/wip.git;a=shortlog;h=46a31189b8b059b3595a9586714761e6e76ba7c4

It also happens with this:
https://git.samba.org/?p=metze/linux/wip.git;a=shortlog;h=442dcd18dc1bf8d1e39f53d20810ca0a4958d139

Which contains your netfs fixes...

> Doing following mount:
> 
> mount -t cifs -ousername=administrator,password=...,rdma,noperm,vers=3.0,mfsymlinks,actimeo=0 //172.31.9.1/test /mnt/test/
> 
> It's using the siw driver (with modifications to work against the chelsio t404-bt card on windows) from
> here:
> https://git.samba.org/?p=metze/linux/wip.git;a=shortlog;h=5b89ff89f440ec36cf2c5ed2212be0d8523a4c9b
> 
> But the siw difference should not really matter.
> 
> This realiable generates this:
> 
> [  922.048997] [   T6639] CIFS: Attempting to mount //172.31.9.1/test
> [  922.188445] [   T6639] CIFS: VFS: RDMA transport established
> [  922.217974] [   T6642] usercopy: Kernel memory exposure attempt detected from SLUB object 'smbd_response_0000000091e24ea1' (offset 81, size 63)!
> [  922.218221] [   T6642] ------------[ cut here ]------------
> [  922.218230] [   T6642] kernel BUG at mm/usercopy.c:102!
> [  922.218299] [   T6642] Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> [  922.218439] [   T6642] CPU: 1 UID: 0 PID: 6642 Comm: cifsd Kdump: loaded Tainted: G           OE       6.16.0-rc3-metze.01+ #1 PREEMPT(voluntary)
> [  922.218585] [   T6642] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [  922.218635] [   T6642] Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
> [  922.218704] [   T6642] RIP: 0010:usercopy_abort+0x6c/0x80
> [  922.218783] [   T6642] Code: fa 91 51 48 c7 c2 c0 d4 fa 91 41 52 48 c7 c7 40 d5 fa 91 48 0f 45 d6 48 c7 c6 00 d5 fa 91 48 89 c1 49 0f 45 f3 e8 84 aa 6b ff <0f> 0b 49 c7 
> c1 c0 d3 fa 91 4d 89 ca 4d 89 c8 eb a8 0f 1f 00 90 90
> [  922.218925] [   T6642] RSP: 0018:ffffc90001887820 EFLAGS: 00010246
> [  922.218983] [   T6642] RAX: 0000000000000079 RBX: 0000000000000051 RCX: 0000000000000000
> [  922.219046] [   T6642] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [  922.219108] [   T6642] RBP: ffffc90001887838 R08: 0000000000000000 R09: 0000000000000000
> [  922.219201] [   T6642] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000003f
> [  922.219261] [   T6642] R13: ffff88801f579280 R14: 0000000000000001 R15: ffffea0000163340
> [  922.219323] [   T6642] FS:  0000000000000000(0000) GS:ffff8881466e8000(0000) knlGS:0000000000000000
> [  922.219415] [   T6642] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  922.219469] [   T6642] CR2: 000075a216d19bb8 CR3: 000000000f5f6004 CR4: 00000000000726f0
> [  922.219560] [   T6642] Call Trace:
> [  922.219591] [   T6642]  <TASK>
> [  922.219624] [   T6642]  __check_heap_object+0xe3/0x120
> [  922.221090] [   T6642]  __check_object_size+0x4dc/0x6d0
> [  922.222547] [   T6642]  smbd_recv+0x77f/0xfe0 [cifs]
> [  922.224416] [   T6642]  ? __pfx_smbd_recv+0x10/0x10 [cifs]
> [  922.226195] [   T6642]  ? __kasan_check_write+0x14/0x30
> [  922.227722] [   T6642]  ? _raw_spin_lock+0x81/0xf0
> [  922.229190] [   T6642]  ? __pfx__raw_spin_lock+0x10/0x10
> [  922.230699] [   T6642]  ? sched_clock_noinstr+0x9/0x10
> [  922.232248] [   T6642]  cifs_readv_from_socket+0x276/0x8f0 [cifs]
> [  922.234149] [   T6642]  ? __pfx_cifs_readv_from_socket+0x10/0x10 [cifs]
> [  922.236222] [   T6642]  ? mempool_alloc_slab+0x15/0x20
> [  922.237705] [   T6642]  cifs_read_from_socket+0xcd/0x120 [cifs]
> [  922.239559] [   T6642]  ? __pfx_cifs_read_from_socket+0x10/0x10 [cifs]
> [  922.241403] [   T6642]  ? __pfx_mempool_alloc_noprof+0x10/0x10
> [  922.242827] [   T6642]  ? __kasan_check_write+0x14/0x30
> [  922.244141] [   T6642]  ? cifs_small_buf_get+0x62/0x90 [cifs]
> [  922.245500] [   T6642]  ? allocate_buffers+0x216/0x390 [cifs]
> [  922.246810] [   T6642]  cifs_demultiplex_thread+0x7e9/0x2d50 [cifs]
> [  922.248150] [   T6642]  ? _raw_spin_lock_irqsave+0x95/0x100
> [  922.249143] [   T6642]  ? __pfx_cifs_demultiplex_thread+0x10/0x10 [cifs]
> [  922.250163] [   T6642]  ? __pfx___schedule+0x10/0x10
> [  922.250977] [   T6642]  ? _raw_spin_lock_irqsave+0x95/0x100
> [  922.251715] [   T6642]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  922.252415] [   T6642]  ? __pfx_try_to_wake_up+0x10/0x10
> [  922.253094] [   T6642]  ? __kasan_check_read+0x11/0x20
> [  922.253766] [   T6642]  ? __kthread_parkme+0xa0/0x190
> [  922.254344] [   T6642]  ? __pfx_cifs_demultiplex_thread+0x10/0x10 [cifs]
> [  922.255073] [   T6642]  kthread+0x396/0x830
> [  922.255584] [   T6642]  ? __pfx__raw_spin_lock_irq+0x10/0x10
> [  922.256070] [   T6642]  ? __pfx_kthread+0x10/0x10
> [  922.256568] [   T6642]  ? __kasan_check_write+0x14/0x30
> [  922.257047] [   T6642]  ? recalc_sigpending+0x180/0x210
> [  922.257535] [   T6642]  ? _raw_spin_unlock_irq+0xe/0x50
> [  922.258015] [   T6642]  ? calculate_sigpending+0x84/0xb0
> [  922.258509] [   T6642]  ? __pfx_kthread+0x10/0x10
> [  922.258976] [   T6642]  ret_from_fork+0x2b8/0x3b0
> [  922.259377] [   T6642]  ? __pfx_kthread+0x10/0x10
> [  922.259757] [   T6642]  ret_from_fork_asm+0x1a/0x30
> [  922.260133] [   T6642]  </TASK>
> [  922.260514] [   T6642] Modules linked in: cifs(OE) ccm cmac nls_utf8 cifs_arc4 nls_ucs2_utils rdma_cm iw_cm ib_cm cifs_md4 netfs siw(OE) ib_uverbs ib_core softdog vboxsf 
> vboxguest intel_rapl_msr intel_rapl_common intel_uncore_frequency_common intel_pmc_core pmt_telemetry pmt_class intel_pmc_ssram_telemetry intel_vsec polyval_clmulni 
> ghash_clmulni_intel sha1_ssse3 aesni_intel rapl i2c_piix4 i2c_smbus input_leds joydev mac_hid sunrpc binfmt_misc kvm_intel kvm irqbypass sch_fq_codel efi_pstore nfnetlink 
> vsock_loopback vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock vmw_vmci dmi_sysfs ip_tables x_tables autofs4 hid_generic vboxvideo drm_vram_helper usbhid 
> drm_ttm_helper vga16fb hid vgastate ahci ttm libahci video pata_acpi psmouse serio_raw wmi [last unloaded: cifs(OE)]
> 
> 
> Reverting it fixes it again.
> 
> metze


