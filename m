Return-Path: <linux-fsdevel+bounces-60360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19265B459EA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 15:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFAD61CC374E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Sep 2025 13:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD9A35FC1B;
	Fri,  5 Sep 2025 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+G/Nc2M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93B835E4D3
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Sep 2025 13:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080641; cv=none; b=PKrYRaJdlc0eh0os1Edgq4oyRSuTmpHfDPB4q2U2s68KrFsxKC4X/He17JqsQuczpTpHZhRP9EOhxDwwjbnmbdgLzjTLYsNAF+fqyzUmVrq2K8sA9D/0h2dQi6KuH4VJ9nbxlSWctNriLghkGnfTxb1SINJPISPy9L/DSuNSPR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080641; c=relaxed/simple;
	bh=lb6a88GQKunfL/XCfDSIu9unYoP3QNmI+OzjoDCcF+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPr0uvRegC81jW09x9oER9QZdxqotihLuIFLLAOqUd1a+E60v6R1Q5Do1K9b8fFlqU45IwHbLA9F6LyjYVBeK4hZByzQ/WrUfT88W/UkDrDbTcLv8RCo7nBg/f6zhqkbRr8sV2S41HSLRAlJRJRhtItXekkdcrIsPAryDlojad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+G/Nc2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339A5C4CEF5;
	Fri,  5 Sep 2025 13:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757080640;
	bh=lb6a88GQKunfL/XCfDSIu9unYoP3QNmI+OzjoDCcF+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+G/Nc2M2FEMHbtKuKQuP6c78nKJaB6rkgYRZx3Q8Fjp4PTatf8+VqgBmjmMYe0Za
	 wgAB25TbMO74fizD+h4O3vlAlYYw4DzPukJ3dtAFud16tzSk62tnkN6NaGBOjPptuk
	 jJEoq4j3wh7tl3e/wLy+Dt+uBdvaRlyJgpdbvUHYEGCdJnK3VZDpVcDLYww0Uzqg6f
	 /1pW+kUrN8fFHkRg4k7MpOpKSYINtp2UVcqLhatSR3BfieSHbkkfMEoqIoDvsQCsvN
	 V7MKwGtSwfgVnnUsUt4iIUdeA6fMyrglXk12wkNhnK854QbvVNaf6vE+lQn94ttllU
	 k+Txh8Tmfbelw==
Date: Fri, 5 Sep 2025 15:57:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: linux-fsdevel@vger.kernel.org, repnop@google.com, amir73il@gmail.com, 
	jack@suse.cz
Subject: Re: [PATCH v2] fanotify: Validating the return value of
 mnt_ns_from_dentry() before dereferencing mntns->user_ns in
 do_fanotify_mark()
Message-ID: <20250905-abhaken-vorhut-82932065a4d2@brauner>
References: <CAPhRvkw4ONypNsJrCnxbKnJbYmLHTDEKFC4C_num_5sVBVa8jg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPhRvkw4ONypNsJrCnxbKnJbYmLHTDEKFC4C_num_5sVBVa8jg@mail.gmail.com>

On Thu, Sep 04, 2025 at 09:58:12AM -0300, Anderson Nascimento wrote:
> Validating the return value of mnt_ns_from_dentry() before
> dereferencing mntns->user_ns in do_fanotify_mark()
> 
> The function do_fanotify_mark() does not validate if
> mnt_ns_from_dentry() returns NULL before dereferencing mntns->user_ns.
> This causes a NULL pointer dereference in do_fanotify_mark() if the
> path is not a mount namespace object.
> 
> Fix this by checking mnt_ns_from_dentry()'s return value before
> dereferencing it. Tested on v6.17-rc4.
> 
> Before the patch
> 
> $ gcc fanotify_nullptr.c -o fanotify_nullptr
> $ mkdir A
> $ ./fanotify_nullptr
> Fanotify fd: 3
> fanotify_mark: Operation not permitted
> $ unshare -Urm
> # ./fanotify_nullptr
> Fanotify fd: 3
> Killed
> # cat fanotify_nullptr.c
> #include <stdio.h>
> #include <stdlib.h>
> #include <fcntl.h>
> #include <sys/fanotify.h>
> 
> int main(void){
>     int ffd;
>     ffd = fanotify_init(FAN_CLASS_NOTIF | FAN_REPORT_MNT, 0);
>     if(ffd < 0){
>         perror("fanotify_init");
>         exit(EXIT_FAILURE);
>     }
> 
>     printf("Fanotify fd: %d\n",ffd);
> 
>     if(fanotify_mark(ffd, FAN_MARK_ADD | FAN_MARK_MNTNS,
> FAN_MNT_ATTACH, AT_FDCWD, "A") < 0){
>         perror("fanotify_mark");
>         exit(EXIT_FAILURE);
>     }
> 
> return 0;
> }
> #
> 
> After the patch
> 
> $ gcc fanotify_nullptr.c -o fanotify_nullptr
> $ mkdir A
> $ ./fanotify_nullptr
> Fanotify fd: 3
> fanotify_mark: Operation not permitted
> $ unshare -Urm
> # ./fanotify_nullptr
> Fanotify fd: 3
> fanotify_mark: Invalid argument
> #
> 
> [   25.694973] BUG: kernel NULL pointer dereference, address: 0000000000000038
> [   25.695006] #PF: supervisor read access in kernel mode
> [   25.695012] #PF: error_code(0x0000) - not-present page
> [   25.695017] PGD 109a30067 P4D 109a30067 PUD 142b46067 PMD 0
> [   25.695025] Oops: Oops: 0000 [#1] SMP NOPTI
> [   25.695032] CPU: 4 UID: 1000 PID: 1478 Comm: fanotify_nullpt Not
> tainted 6.17.0-rc4 #1 PREEMPT(lazy)
> [   25.695040] Hardware name: VMware, Inc. VMware Virtual
> Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
> [   25.695049] RIP: 0010:do_fanotify_mark+0x817/0x950
> [   25.695066] Code: 04 00 00 e9 45 fd ff ff 48 8b 7c 24 48 4c 89 54
> 24 18 4c 89 5c 24 10 4c 89 0c 24 e8 b3 11 fc ff 4c 8b 54 24 18 4c 8b
> 5c 24 10 <48> 8b 78 38 4c 8b 0c 24 49 89 c4 e9 13 fd ff ff 8b 4c 24 28
> 85 c9
> [   25.695081] RSP: 0018:ffffd31c469e3c08 EFLAGS: 00010203
> [   25.695104] RAX: 0000000000000000 RBX: 0000000001000000 RCX: ffff8eb48aebd220
> [   25.695110] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8eb4835e8180
> [   25.695115] RBP: 0000000000000111 R08: 0000000000000000 R09: 0000000000000000
> [   25.695142] R10: ffff8eb48a7d56c0 R11: ffff8eb482bede00 R12: 00000000004012a7
> [   25.695148] R13: 0000000000000110 R14: 0000000000000001 R15: ffff8eb48a7d56c0
> [   25.695154] FS:  00007f8733bda740(0000) GS:ffff8eb61ce5f000(0000)
> knlGS:0000000000000000
> [   25.695162] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   25.695170] CR2: 0000000000000038 CR3: 0000000136994006 CR4: 00000000003706f0
> [   25.695201] Call Trace:
> [   25.695209]  <TASK>
> [   25.695215]  __x64_sys_fanotify_mark+0x1f/0x30
> [   25.695222]  do_syscall_64+0x82/0x2c0
> [   25.695229]  ? do_syscall_64+0x82/0x2c0
> [   25.695234]  ? memcg1_commit_charge+0x7a/0xa0
> [   25.695240]  ? mod_memcg_lruvec_state+0xe7/0x2e0
> [   25.695246]  ? charge_memcg+0x48/0x80
> [   25.695251]  ? blk_cgroup_congested+0x65/0x70
> [   25.695258]  ? __lruvec_stat_mod_folio+0x85/0xd0
> [   25.695272]  ? __folio_mod_stat+0x2d/0x90
> [   25.695284]  ? set_ptes.isra.0+0x36/0x80
> [   25.695290]  ? do_anonymous_page+0x100/0x520
> [   25.695295]  ? __handle_mm_fault+0x54f/0x6a0
> [   25.695317]  ? anon_inode_getfile_fmode+0x18/0x30
> [   25.695322]  ? count_memcg_events+0xd6/0x220
> [   25.695327]  ? handle_mm_fault+0x248/0x360
> [   25.695333]  ? do_user_addr_fault+0x21a/0x690
> [   25.695339]  ? clear_bhb_loop+0x50/0xa0
> [   25.695344]  ? clear_bhb_loop+0x50/0xa0
> [   25.695348]  ? clear_bhb_loop+0x50/0xa0
> [   25.695353]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   25.695358] RIP: 0033:0x7f8733cd26ae
> [   25.695373] Code: f8 48 8d 75 f8 e8 12 3c ff ff c9 48 83 f8 08 0f
> 95 c0 0f b6 c0 f7 d8 c3 0f 1f 40 00 f3 0f 1e fa 41 89 ca b8 2d 01 00
> 00 0f 05 <48> 3d 00 f0 ff ff 77 0a c3 66 0f 1f 84 00 00 00 00 00 48 8b
> 15 19
> [   25.695613] RSP: 002b:00007ffcd6842cd8 EFLAGS: 00000206 ORIG_RAX:
> 000000000000012d
> [   25.695820] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f8733cd26ae
> [   25.695992] RDX: 0000000001000000 RSI: 0000000000000111 RDI: 0000000000000003
> [   25.696141] RBP: 00007ffcd6842cf0 R08: 00000000004012a7 R09: 0000000000000000
> [   25.696273] R10: 00000000ffffff9c R11: 0000000000000206 R12: 00007ffcd6842e18
> [   25.696438] R13: 0000000000000001 R14: 00007f8733e15000 R15: 0000000000402e00
> [   25.696616]  </TASK>
> [   25.696752] Modules linked in: rfkill nft_fib_inet nft_fib_ipv4
> nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
> nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 nf_tables qrtr intel_rapl_msr intel_rapl_common
> intel_uncore_frequency_common intel_pmc_core pmt_telemetry
> pmt_discovery pmt_class intel_pmc_ssram_telemetry intel_vsec rapl
> vmw_balloon pcspkr i2c_piix4 i2c_smbus joydev loop vsock_loopback
> vmw_vsock_virtio_transport_common vmw_vsock_vmci_transport vsock zram
> vmw_vmci lz4hc_compress lz4_compress xfs polyval_clmulni vmwgfx
> ghash_clmulni_intel vmxnet3 nvme drm_ttm_helper ata_generic ttm
> pata_acpi nvme_tcp nvme_fabrics nvme_core nvme_keyring nvme_auth
> serio_raw sunrpc be2iscsi bnx2i cnic uio cxgb4i cxgb4 tls cxgb3i cxgb3
> mdio libcxgbi libcxgb qla4xxx iscsi_boot_sysfs iscsi_tcp libiscsi_tcp
> libiscsi scsi_transport_iscsi scsi_dh_rdac scsi_dh_emc scsi_dh_alua
> fuse i2c_dev dm_multipath nfnetlink
> [   25.698055] CR2: 0000000000000038
> [   25.698202] ---[ end trace 0000000000000000 ]---
> [   25.698385] RIP: 0010:do_fanotify_mark+0x817/0x950
> [   25.698595] Code: 04 00 00 e9 45 fd ff ff 48 8b 7c 24 48 4c 89 54
> 24 18 4c 89 5c 24 10 4c 89 0c 24 e8 b3 11 fc ff 4c 8b 54 24 18 4c 8b
> 5c 24 10 <48> 8b 78 38 4c 8b 0c 24 49 89 c4 e9 13 fd ff ff 8b 4c 24 28
> 85 c9
> [   25.698921] RSP: 0018:ffffd31c469e3c08 EFLAGS: 00010203
> [   25.699076] RAX: 0000000000000000 RBX: 0000000001000000 RCX: ffff8eb48aebd220
> [   25.699232] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8eb4835e8180
> [   25.699409] RBP: 0000000000000111 R08: 0000000000000000 R09: 0000000000000000
> [   25.699645] R10: ffff8eb48a7d56c0 R11: ffff8eb482bede00 R12: 00000000004012a7
> [   25.699818] R13: 0000000000000110 R14: 0000000000000001 R15: ffff8eb48a7d56c0
> [   25.699970] FS:  00007f8733bda740(0000) GS:ffff8eb61ce5f000(0000)
> knlGS:0000000000000000
> [   25.700125] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   25.700280] CR2: 0000000000000038 CR3: 0000000136994006 CR4: 00000000003706f0
> [   25.700495] note: fanotify_nullpt[1478] exited with irqs disabled
> 
> Fixes: 58f5fbeb367f ("fanotify: support watching filesystems and
> mounts inside userns")
> Signed-off-by: Anderson Nascimento <anderson@allelesecurity.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

