Return-Path: <linux-fsdevel+bounces-27582-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2C89628B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 15:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84FA283527
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 13:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1237F189510;
	Wed, 28 Aug 2024 13:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BknUxCKF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aGOkd8FE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BknUxCKF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aGOkd8FE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC0188CC6;
	Wed, 28 Aug 2024 13:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851979; cv=none; b=nNb2v4xO5JDcPsyVIyKgXHVikQLcQ3NDbSnlfaANXapGN+dcbRlmJliEhX8QK4W3twL67yRp2PxdEjOHu9/uAGzAWoTQb0sxJPqkYYn1n5CG52blUwNx74MfOiYVOLkLhROYx0eViBF23ot40I+l62JS8ERFCaskHkdxRM0hVBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851979; c=relaxed/simple;
	bh=96ydddc6Dj30xj7o2gg8H9Sj9/8GQqdwaW3E1WKKOFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djbZN7sLmGLGixc2pVbjWfHmDSLndcypJ3QJabs0+0hgk00L1t5ic4T4501KRU95a5UlfZ8wKHn9lZYIn2eNKtNvQ85duh3FckFcXZBH3WQ89uOwZ2FKwmQ7X/6EMzIKlenc3YO+4bq2F4Vo0ag515oPWOpwvny0bSNzmxYGa8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BknUxCKF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aGOkd8FE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BknUxCKF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aGOkd8FE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 45D2B1FC26;
	Wed, 28 Aug 2024 13:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724851975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xja6Pjwyvc7R8ZMFEJBK/M/Tdr2wYRTf2pi8k45GY7o=;
	b=BknUxCKFK5GfoBAsk/Mv9p6pKvaOBP6UWvF5kPIeW2wHdYY2SCx2+QFQoVr+bnaAoOKnB4
	Odeo9Wrewui9Z+eDl16/dePEU4tdsQI0Nnb7ArqMeoycP0DdlUAoenw6VzO0OY/A3iWkE6
	hB+xdxFwg/MzC7yaMUqj3jRIjdaTeZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724851975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xja6Pjwyvc7R8ZMFEJBK/M/Tdr2wYRTf2pi8k45GY7o=;
	b=aGOkd8FELcSll2xUCFSBJ+4fuNqX3AYx/sIL5Gh78L6FT3tv7EpXaNNpXOm9gX28Cq38RV
	ciIUgjR0R84FFyCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BknUxCKF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aGOkd8FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724851975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xja6Pjwyvc7R8ZMFEJBK/M/Tdr2wYRTf2pi8k45GY7o=;
	b=BknUxCKFK5GfoBAsk/Mv9p6pKvaOBP6UWvF5kPIeW2wHdYY2SCx2+QFQoVr+bnaAoOKnB4
	Odeo9Wrewui9Z+eDl16/dePEU4tdsQI0Nnb7ArqMeoycP0DdlUAoenw6VzO0OY/A3iWkE6
	hB+xdxFwg/MzC7yaMUqj3jRIjdaTeZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724851975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xja6Pjwyvc7R8ZMFEJBK/M/Tdr2wYRTf2pi8k45GY7o=;
	b=aGOkd8FELcSll2xUCFSBJ+4fuNqX3AYx/sIL5Gh78L6FT3tv7EpXaNNpXOm9gX28Cq38RV
	ciIUgjR0R84FFyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C521A138D2;
	Wed, 28 Aug 2024 13:32:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BnIaMAYnz2b7KAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 28 Aug 2024 13:32:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 84878A0968; Wed, 28 Aug 2024 15:32:42 +0200 (CEST)
Date: Wed, 28 Aug 2024 15:32:42 +0200
From: Jan Kara <jack@suse.cz>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/inode: Prevent dump_mapping() accessing invalid
 dentry.d_name.name
Message-ID: <20240828133242.vizccpxbdhpctfwu@quack3>
References: <20240826055503.1522320-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826055503.1522320-1-lizhijian@fujitsu.com>
X-Rspamd-Queue-Id: 45D2B1FC26
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 26-08-24 13:55:03, Li Zhijian wrote:
> It's observed that a crash occurs during hot-remove a memory device,
> in which user is accessing the hugetlb. See calltrace as following:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 14045 at arch/x86/mm/fault.c:1278 do_user_addr_fault+0x2a0/0x790
> Modules linked in: kmem device_dax cxl_mem cxl_pmem cxl_port cxl_pci dax_hmem dax_pmem nd_pmem cxl_acpi nd_btt cxl_core crc32c_intel nvme virtiofs fuse nvme_core nfit libnvdimm dm_multipath scsi_dh_rdac scsi_dh_emc s
> mirror dm_region_hash dm_log dm_mod
> CPU: 1 PID: 14045 Comm: daxctl Not tainted 6.10.0-rc2-lizhijian+ #492
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> RIP: 0010:do_user_addr_fault+0x2a0/0x790
> Code: 48 8b 00 a8 04 0f 84 b5 fe ff ff e9 1c ff ff ff 4c 89 e9 4c 89 e2 be 01 00 00 00 bf 02 00 00 00 e8 b5 ef 24 00 e9 42 fe ff ff <0f> 0b 48 83 c4 08 4c 89 ea 48 89 ee 4c 89 e7 5b 5d 41 5c 41 5d 41
> RSP: 0000:ffffc90000a575f0 EFLAGS: 00010046
> RAX: ffff88800c303600 RBX: 0000000000000000 RCX: 0000000000000000
> RDX: 0000000000001000 RSI: ffffffff82504162 RDI: ffffffff824b2c36
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffc90000a57658
> R13: 0000000000001000 R14: ffff88800bc2e040 R15: 0000000000000000
> FS:  00007f51cb57d880(0000) GS:ffff88807fd00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000001000 CR3: 00000000072e2004 CR4: 00000000001706f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ? __warn+0x8d/0x190
>  ? do_user_addr_fault+0x2a0/0x790
>  ? report_bug+0x1c3/0x1d0
>  ? handle_bug+0x3c/0x70
>  ? exc_invalid_op+0x14/0x70
>  ? asm_exc_invalid_op+0x16/0x20
>  ? do_user_addr_fault+0x2a0/0x790
>  ? exc_page_fault+0x31/0x200
>  exc_page_fault+0x68/0x200
> <...snip...>
> BUG: unable to handle page fault for address: 0000000000001000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 800000000ad92067 P4D 800000000ad92067 PUD 7677067 PMD 0
>  Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>  ---[ end trace 0000000000000000 ]---
>  BUG: unable to handle page fault for address: 0000000000001000
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 800000000ad92067 P4D 800000000ad92067 PUD 7677067 PMD 0
>  Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>  CPU: 1 PID: 14045 Comm: daxctl Kdump: loaded Tainted: G        W          6.10.0-rc2-lizhijian+ #492
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>  RIP: 0010:dentry_name+0x1f4/0x440
> <...snip...>
> ? dentry_name+0x2fa/0x440
> vsnprintf+0x1f3/0x4f0
> vprintk_store+0x23a/0x540
> vprintk_emit+0x6d/0x330
> _printk+0x58/0x80
> dump_mapping+0x10b/0x1a0
> ? __pfx_free_object_rcu+0x10/0x10
> __dump_page+0x26b/0x3e0
> ? vprintk_emit+0xe0/0x330
> ? _printk+0x58/0x80
> ? dump_page+0x17/0x50
> dump_page+0x17/0x50
> do_migrate_range+0x2f7/0x7f0
> ? do_migrate_range+0x42/0x7f0
> ? offline_pages+0x2f4/0x8c0
> offline_pages+0x60a/0x8c0
> memory_subsys_offline+0x9f/0x1c0
> ? lockdep_hardirqs_on+0x77/0x100
> ? _raw_spin_unlock_irqrestore+0x38/0x60
> device_offline+0xe3/0x110
> state_store+0x6e/0xc0
> kernfs_fop_write_iter+0x143/0x200
> vfs_write+0x39f/0x560
> ksys_write+0x65/0xf0
> do_syscall_64+0x62/0x130
> 
> Previously, some sanity check have been done in dump_mapping() before
> the print facility parsing '%pd' though, it's still possible to run into
> an invalid dentry.d_name.name.
> 
> Since dump_mapping() only needs to dump the filename only, retrieve it
> by itself in a safer way to prevent an unnecessary crash.
> 
> Note that either retrieving the filename with '%pd' or
> strncpy_from_kernel_nofault(), the filename could be unreliable.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

I guess this is a reliability improvement :). Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index f356fe2ec2b6..d3f9d73d59d0 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -562,6 +562,7 @@ void dump_mapping(const struct address_space *mapping)
>  	struct hlist_node *dentry_first;
>  	struct dentry *dentry_ptr;
>  	struct dentry dentry;
> +	char fname[64] = {};
>  	unsigned long ino;
>  
>  	/*
> @@ -598,11 +599,14 @@ void dump_mapping(const struct address_space *mapping)
>  		return;
>  	}
>  
> +	if (strncpy_from_kernel_nofault(fname, dentry.d_name.name, 63) < 0)
> +		strscpy(fname, "<invalid>");
>  	/*
> -	 * if dentry is corrupted, the %pd handler may still crash,
> -	 * but it's unlikely that we reach here with a corrupt mapping
> +	 * Even if strncpy_from_kernel_nofault() succeeded,
> +	 * the fname could be unreliable
>  	 */
> -	pr_warn("aops:%ps ino:%lx dentry name:\"%pd\"\n", a_ops, ino, &dentry);
> +	pr_warn("aops:%ps ino:%lx dentry name(?):\"%s\"\n",
> +		a_ops, ino, fname);
>  }
>  
>  void clear_inode(struct inode *inode)
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

