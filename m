Return-Path: <linux-fsdevel+bounces-30110-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6849C986443
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 17:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5471C2793F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 15:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBCA22318;
	Wed, 25 Sep 2024 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2QiSRjzM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fGk4FfR/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KKPBTOat";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yf0iwNtl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F171B949;
	Wed, 25 Sep 2024 15:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727279835; cv=none; b=hj55YNATfwM9bRhBbzfocBalW3SwtXBNId8Sb3xCtEZQ2JaK7+WVLY+g0UBsreeJQRXTy4mg4nyLOWAtqCcCHpWquSiknds4kyziXGxqsrx8xeSvfcUd2W+zP/OX6wreeQWIyKzUbVUx0Q3LbzJoM7shUuBhZPoZo+uHvVzAEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727279835; c=relaxed/simple;
	bh=fliI3WurLpbz3JqE8ckBaMDYvH0f/jMx03dDRXu8KBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PeIrGy3lfj2qDDt3Ex6EKqm2A2NanISmnTSEfetlEVAhbYv6ka5c2qOzPVH4HW6wNmEt1ELhJuedTZbOxPxQvVgyKK6lTqACoYjFTYj/7rmwsl/vpgdTSLlGjHZNOZwqWN2x6xUxzoCcjLjM78gOaX44LUY9MQPocFAf5HVmKsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2QiSRjzM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fGk4FfR/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KKPBTOat; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yf0iwNtl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D4E9B1F7CA;
	Wed, 25 Sep 2024 15:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727279831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xz8BgoBkgBevARHxzLzwe82i2OKcUUDGcY0Ygrqdsfs=;
	b=2QiSRjzMiHNC9a2y8FuW/0I+LkTaIqRVA+kMGOrpogrq2/Ji2VMuBAh96BgkqdP+uIz0Vn
	jH3NliV4LDsHZnEHHysfih1clI4c6xZEBAHgU4HC02YFvKdOEvLbcakabCrcp6CPvDULhy
	OujYmGlFKPLwUfNtT9F9xE7ExVqZxp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727279831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xz8BgoBkgBevARHxzLzwe82i2OKcUUDGcY0Ygrqdsfs=;
	b=fGk4FfR/8umU6mDEFtLGpPCJKf/3P8KRiFtneKmD/gFeg+REzNMbNAPJTXDBSEEM/A4FN4
	MSsibvzAmT4ZXKDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KKPBTOat;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yf0iwNtl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727279830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xz8BgoBkgBevARHxzLzwe82i2OKcUUDGcY0Ygrqdsfs=;
	b=KKPBTOatbQ8/vYOW6SytHUE3wlVM8X2/vk2iTF00E35yhsaewFj/PMsub0Ye02Jqtx3hOK
	nikysmRow0jDF/yyn4eCCN+pHUNAwjE/ZHsxAiKq08ZOnO9DhkVyvp7nXtOa+fn3gh5Z+v
	SX2Vwh5Dfm58XqDQQQY5Y013WNrtq/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727279830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xz8BgoBkgBevARHxzLzwe82i2OKcUUDGcY0Ygrqdsfs=;
	b=yf0iwNtlsBws4bD6k3U1rVUtQDDzUGgWO4PEXuV/BqR9J4Ri4GApAQhURBIZW4Uc0iaG5o
	JsaOGIto9VEzD7AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3C8E13A6A;
	Wed, 25 Sep 2024 15:57:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uMPFL9Yy9GabCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Sep 2024 15:57:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 761D7A0810; Wed, 25 Sep 2024 17:57:06 +0200 (CEST)
Date: Wed, 25 Sep 2024 17:57:06 +0200
From: Jan Kara <jack@suse.cz>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: tytso@mit.edu, stable@vger.kernel.org,
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun1@huawei.com>,
	=?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	Wesley Hershberger <wesley.hershberger@canonical.com>
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
Message-ID: <20240925155706.zad2euxxuq7h6uja@quack3>
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com>
X-Rspamd-Queue-Id: D4E9B1F7CA
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 25-09-24 16:33:24, Alexander Mikhalitsyn wrote:
> [   33.882936] EXT4-fs (dm-5): mounted filesystem 8aaf41b2-6ac0-4fa8-b92b-77d10e1d16ca r/w with ordered data mode. Quota mode: none.
> [   33.888365] EXT4-fs (dm-5): resizing filesystem from 7168 to 786432 blocks
> [   33.888740] ------------[ cut here ]------------
> [   33.888742] kernel BUG at fs/ext4/resize.c:324!

Ah, I was staring at this for a while before I understood what's going on
(it would be great to explain this in the changelog BTW).  As far as I
understand commit 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation
in alloc_flex_gd()") can actually make flex_gd->resize_bg larger than
flexbg_size (for example when ogroup = flexbg_size, ngroup = 2*flexbg_size
- 1) which then confuses things. I think that was not really intended and
instead of fixing up ext4_alloc_group_tables() we should really change
the logic in alloc_flex_gd() to make sure flex_gd->resize_bg never exceeds
flexbg size. Baokun?

								Honza


> [   33.889075] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [   33.889503] CPU: 9 UID: 0 PID: 3576 Comm: resize2fs Not tainted 6.11.0+ #27
> [   33.890039] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [   33.890705] RIP: 0010:ext4_resize_fs+0x1212/0x12d0
> [   33.891063] Code: b8 45 31 c0 4c 89 ff 45 31 c9 31 c9 ba 0e 08 00 00 48 c7 c6 68 75 65 b8 e8 2b 79 01 00 41 b8 ea ff ff ff 41 5f e9 8d f1 ff ff <0f> 0b 48 83 bd 70 ff ff ff 00 75 32 45 31 c0 e9 53 f1 ff ff 41 b8
> [   33.892701] RSP: 0018:ffffa97f413f3cc8 EFLAGS: 00010202
> [   33.893081] RAX: 0000000000000018 RBX: 0000000000000001 RCX: 00000000fffffff0
> [   33.893639] RDX: 0000000000000017 RSI: 0000000000000016 RDI: 00000000e8c2c810
> [   33.894197] RBP: ffffa97f413f3d90 R08: 0000000000000000 R09: 0000000000008000
> [   33.894755] R10: ffffa97f413f3cc8 R11: ffffa2c1845bfc80 R12: 0000000000000000
> [   33.895317] R13: ffffa2c1843d6000 R14: 0000000000008000 R15: ffffa2c199963000
> [   33.895877] FS:  00007f46efd17000(0000) GS:ffffa2c89fc40000(0000) knlGS:0000000000000000
> [   33.896524] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   33.896954] CR2: 00005630a4a1cc88 CR3: 000000010532c000 CR4: 0000000000350eb0
> [   33.897516] Call Trace:
> [   33.897638]  <TASK>
> [   33.897728]  ? show_regs+0x6d/0x80
> [   33.897942]  ? die+0x3c/0xa0
> [   33.898106]  ? do_trap+0xe5/0x110
> [   33.898311]  ? do_error_trap+0x6e/0x90
> [   33.898555]  ? ext4_resize_fs+0x1212/0x12d0
> [   33.898844]  ? exc_invalid_op+0x57/0x80
> [   33.899101]  ? ext4_resize_fs+0x1212/0x12d0
> [   33.899387]  ? asm_exc_invalid_op+0x1f/0x30
> [   33.899675]  ? ext4_resize_fs+0x1212/0x12d0
> [   33.899961]  ? ext4_resize_fs+0x745/0x12d0
> [   33.900239]  __ext4_ioctl+0x4e0/0x1800
> [   33.900489]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   33.900832]  ? putname+0x5b/0x70
> [   33.901028]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   33.901374]  ? do_sys_openat2+0x87/0xd0
> [   33.901632]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   33.901981]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   33.902324]  ? __x64_sys_openat+0x59/0xa0
> [   33.902595]  ext4_ioctl+0x12/0x20
> [   33.902802]  ? ext4_ioctl+0x12/0x20
> [   33.903031]  __x64_sys_ioctl+0x99/0xd0
> [   33.903277]  x64_sys_call+0x1206/0x20d0
> [   33.903534]  do_syscall_64+0x72/0x110
> [   33.903771]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   33.904115]  ? irqentry_exit+0x3f/0x50
> [   33.904362]  ? srso_alias_return_thunk+0x5/0xfbef5
> [   33.904707]  ? exc_page_fault+0x1aa/0x7b0
> [   33.904979]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   33.905349] RIP: 0033:0x7f46efe3294f
> [   33.905579] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
> [   33.907321] RSP: 002b:00007ffe9b8833a0 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [   33.907926] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f46efe3294f
> [   33.908487] RDX: 00007ffe9b8834a0 RSI: 0000000040086610 RDI: 0000000000000004
> [   33.909046] RBP: 00005630a4a0b0e0 R08: 0000000000000000 R09: 00007ffe9b8832d7
> [   33.909605] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000004
> [   33.910165] R13: 00005630a4a0c580 R14: 00005630a4a10400 R15: 0000000000000000
> [   33.910740]  </TASK>
> [   33.910837] Modules linked in:
> [   33.911049] ---[ end trace 0000000000000000 ]---
> [   33.911428] RIP: 0010:ext4_resize_fs+0x1212/0x12d0
> [   33.911810] Code: b8 45 31 c0 4c 89 ff 45 31 c9 31 c9 ba 0e 08 00 00 48 c7 c6 68 75 65 b8 e8 2b 79 01 00 41 b8 ea ff ff ff 41 5f e9 8d f1 ff ff <0f> 0b 48 83 bd 70 ff ff ff 00 75 32 45 31 c0 e9 53 f1 ff ff 41 b8
> [   33.913928] RSP: 0018:ffffa97f413f3cc8 EFLAGS: 00010202
> [   33.914313] RAX: 0000000000000018 RBX: 0000000000000001 RCX: 00000000fffffff0
> [   33.914909] RDX: 0000000000000017 RSI: 0000000000000016 RDI: 00000000e8c2c810
> [   33.915482] RBP: ffffa97f413f3d90 R08: 0000000000000000 R09: 0000000000008000
> [   33.916258] R10: ffffa97f413f3cc8 R11: ffffa2c1845bfc80 R12: 0000000000000000
> [   33.917027] R13: ffffa2c1843d6000 R14: 0000000000008000 R15: ffffa2c199963000
> [   33.917884] FS:  00007f46efd17000(0000) GS:ffffa2c89fc40000(0000) knlGS:0000000000000000
> [   33.918818] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   33.919322] CR2: 00005630a4a1cc88 CR3: 000000010532c000 CR4: 0000000000350eb0
> [   44.072293] ------------[ cut here ]------------
> 
> Cc: stable@vger.kernel.org # v6.8+
> Fixes: 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc_flex_gd()")
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Baokun Li <libaokun1@huawei.com>
> Cc: Stéphane Graber <stgraber@stgraber.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: <linux-kernel@vger.kernel.org>
> Cc: <linux-fsdevel@vger.kernel.org>
> Cc: <linux-ext4@vger.kernel.org>
> Reported-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2081231
> Reported-by: Stéphane Graber <stgraber@stgraber.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>  fs/ext4/resize.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> index e04eb08b9060..c057a7867363 100644
> --- a/fs/ext4/resize.c
> +++ b/fs/ext4/resize.c
> @@ -300,8 +300,7 @@ static void free_flex_gd(struct ext4_new_flex_group_data *flex_gd)
>   * block group.
>   */
>  static int ext4_alloc_group_tables(struct super_block *sb,
> -				struct ext4_new_flex_group_data *flex_gd,
> -				unsigned int flexbg_size)
> +				struct ext4_new_flex_group_data *flex_gd)
>  {
>  	struct ext4_new_group_data *group_data = flex_gd->groups;
>  	ext4_fsblk_t start_blk;
> @@ -313,7 +312,7 @@ static int ext4_alloc_group_tables(struct super_block *sb,
>  	ext4_group_t group;
>  	ext4_group_t last_group;
>  	unsigned overhead;
> -	__u16 uninit_mask = (flexbg_size > 1) ? ~EXT4_BG_BLOCK_UNINIT : ~0;
> +	__u16 uninit_mask = (flex_gd->resize_bg > 1) ? ~EXT4_BG_BLOCK_UNINIT : ~0;
>  	int i;
>  
>  	BUG_ON(flex_gd->count == 0 || group_data == NULL);
> @@ -321,8 +320,8 @@ static int ext4_alloc_group_tables(struct super_block *sb,
>  	src_group = group_data[0].group;
>  	last_group  = src_group + flex_gd->count - 1;
>  
> -	BUG_ON((flexbg_size > 1) && ((src_group & ~(flexbg_size - 1)) !=
> -	       (last_group & ~(flexbg_size - 1))));
> +	BUG_ON((flex_gd->resize_bg > 1) && ((src_group & ~(flex_gd->resize_bg - 1)) !=
> +	       (last_group & ~(flex_gd->resize_bg - 1))));
>  next_group:
>  	group = group_data[0].group;
>  	if (src_group >= group_data[0].group + flex_gd->count)
> @@ -403,7 +402,7 @@ static int ext4_alloc_group_tables(struct super_block *sb,
>  
>  		printk(KERN_DEBUG "EXT4-fs: adding a flex group with "
>  		       "%u groups, flexbg size is %u:\n", flex_gd->count,
> -		       flexbg_size);
> +		       flex_gd->resize_bg);
>  
>  		for (i = 0; i < flex_gd->count; i++) {
>  			ext4_debug(
> @@ -2158,7 +2157,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
>  					 ext4_blocks_count(es));
>  			last_update_time = jiffies;
>  		}
> -		if (ext4_alloc_group_tables(sb, flex_gd, flexbg_size) != 0)
> +		if (ext4_alloc_group_tables(sb, flex_gd) != 0)
>  			break;
>  		err = ext4_flex_group_add(sb, resize_inode, flex_gd);
>  		if (unlikely(err))
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

