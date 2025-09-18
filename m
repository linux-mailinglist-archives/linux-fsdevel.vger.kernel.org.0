Return-Path: <linux-fsdevel+bounces-60257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2FBB43717
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 11:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2574A1C2826C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5053923D290;
	Thu,  4 Sep 2025 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WByJ3PxU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XbQHkYCJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="I4BHYpWA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ycIJbiyQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEEC2F60CB
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 09:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978132; cv=none; b=RwJQHSnqPS5Z4aRx8JuuFyP+6qAo55bEms1wp9wmt57v9pkB1il4TSYFgkSg1AxcYJQPkkWxra2S2aG0xekj9Qx2ae8dnF8Op3LWBNuM8g4f91szu6p7V4a/HBu6GMlBqe+FKMzl2XTUwNEM9SKNp4qTVsGyAmcSnIwKk3SUwRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978132; c=relaxed/simple;
	bh=5ej0ropi/8jDsfdWMJ/IAgOdwCRzAHm4Zm1mv/3LhXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JE9mS6gpH6FejjrRreD+psybZ1OUNliZxAXvVoH9xyMSDXvEnpOG73ni22KffDWhN90qxre5cGiLbdM8/Spa5htXY5U6GoaDMZ8hTfJZ6RnWg8LHoanYQyb0YN7a2VgoLepOoyQCcaG309YrholNZlzseHnCo9PMjQzl4iB42io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WByJ3PxU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XbQHkYCJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=I4BHYpWA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ycIJbiyQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF038341A6;
	Thu,  4 Sep 2025 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756978129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=byTc2bjRbM0JqYl+QsOHYcEtmykpuhI65DaMcVhqnTs=;
	b=WByJ3PxUTsOg/FaiGtZwmOFIkGbqAlHLPmw8I0FseDSImz9JjAs2zXr4tWdFiIC0kRrWED
	JHEVpKkGi2nHgFpyuDaYyEC+4vH1vMWGQEJWrndudF6QDlujjg6cI0q/9PdLWk33+BxdzS
	G+54FXCcfTvs/k/5C4weDiBOgPL5Ay4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756978129;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=byTc2bjRbM0JqYl+QsOHYcEtmykpuhI65DaMcVhqnTs=;
	b=XbQHkYCJm3h2dmg1yc3tEtmYTwvjE1sGpeopp5+24m3pXNMQTMlMMNBItiFcEsO9Y/QGpx
	9yBJROZBguw6u8DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756978128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=byTc2bjRbM0JqYl+QsOHYcEtmykpuhI65DaMcVhqnTs=;
	b=I4BHYpWAEH7I7T2clnKKRDwvqs7xxNUm/4MXo/MUkBOvttBNZrgj+JITW2bS9uFwfsjAD3
	0iIGweGg5nbZ5JxpEayTHzAOMnto9wfe2hHh5D6Z+cDfU+LHyPd/ghjNicj+ZWMIhurFd8
	6Wm++jeWCeC14ubp9CJ+1+hQjoI+ZKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756978128;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=byTc2bjRbM0JqYl+QsOHYcEtmykpuhI65DaMcVhqnTs=;
	b=ycIJbiyQK543VWo+LG2i+Vw4NZev/d1oX9FC1Z1bae4i8PJkPsn4zl5nfQLnpBR33A8yuW
	cRRCvuel2j3nhyBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C944013AA0;
	Thu,  4 Sep 2025 09:28:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B/8cMdBbuWgKHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Sep 2025 09:28:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 83055A0A2D; Thu,  4 Sep 2025 11:28:44 +0200 (CEST)
Date: Thu, 4 Sep 2025 11:28:44 +0200
From: Jan Kara <jack@suse.cz>
To: Anderson Nascimento <anderson@allelesecurity.com>
Cc: jack@suse.cz, amir73il@gmail.com, repnop@google.com, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] - Validating the return value of mnt_ns_from_dentry()
 before dereferencing mntns->user_ns
Message-ID: <gocil3mtkyq3hasu5gp2wfbp4kb2p6yxlt72tadub4p2ia655d@xg6cnxenjxar>
References: <CAPhRvkwpLt03-OohQiBh_RyD+DsgTcRo-KmoqcvZ-3vNcCo=Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPhRvkwpLt03-OohQiBh_RyD+DsgTcRo-KmoqcvZ-3vNcCo=Uw@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 03-09-25 15:17:10, Anderson Nascimento wrote:
> Validating the return value of mnt_ns_from_dentry() before
> dereferencing mntns->user_ns
> 
> The function do_fanotify_mark() does not validate if
> mnt_ns_from_dentry() returns NULL before dereferencing mntns->user_ns.
> This causes a NULL pointer dereference in do_fanotify_mark() if the
> path is not a mount namespace object.
> 
> Fix this by checking mnt_ns_from_dentry()'s return value before
> dereferencing it. Tested on v6.17-rc4.

Thanks for the report and the fix! It looks good but I need you provide
your Signed-off-by so that I can include the fix into the kernel (see
Documentation/process/submitting-patches.rst, chapter "Sign your work - the
Developer's Certificate of Origin"). Thank you!

								Honza

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
> diff --git a/fs/notify/fanotify/fanotify_user.c
> b/fs/notify/fanotify/fanotify_user.c
> index b192ee068a7a..77046be7d3c1 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1999,7 +1999,10 @@ static int do_fanotify_mark(int fanotify_fd,
> unsigned int flags, __u64 mask,
>                 user_ns = path.mnt->mnt_sb->s_user_ns;
>                 obj = path.mnt->mnt_sb;
>         } else if (obj_type == FSNOTIFY_OBJ_TYPE_MNTNS) {
> +               ret = -EINVAL;
>                 mntns = mnt_ns_from_dentry(path.dentry);
> +               if(!mntns)
> +                       goto path_put_and_out;
>                 user_ns = mntns->user_ns;
>                 obj = mntns;
>         }
> 
> 
> Best regards,
> -- 
> Anderson Nascimento
> Allele Security Intelligence
> https://www.allelesecurity.com
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

