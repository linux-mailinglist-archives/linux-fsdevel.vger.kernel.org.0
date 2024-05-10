Return-Path: <linux-fsdevel+bounces-19284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651B08C2778
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 17:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74171F255DC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 15:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEF6171646;
	Fri, 10 May 2024 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SYWaCTf/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ssG029tG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SYWaCTf/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ssG029tG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F552171653;
	Fri, 10 May 2024 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715354113; cv=none; b=VtlvoSH2KoNTKo66JEXozkcodCvMO9PBTc0zJkYCeK/SR6kTaNQQuUZxTThYg7hWeO/SPZsOkPy71CtoJ2gFmxi60S/X58S7B/n1fo0+4a7t5CRzAyxwQedJQ4seL8SStyfXYa6MYcKPBkRXuOav3rFVYE/wWB4W5XtYUOVHZVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715354113; c=relaxed/simple;
	bh=+l80251r0ZhwdypAfFr7iG7PA4iPz9YsZVkf3xTYNbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBcqco3+X4HY7hBnlvnmICkFlwv6/jqLUo10LDECP5C57rIKQlxbzXEP1nTf71pFmvioRbHpnyoXKWfK92cCjEKRfP937thgMjDOuHDc9xIYpbgMkbN6iuWTYuxxI/dgaID9NFmIzc6wlRppEkNt4miycKnxVxINWYTSlSJI/v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SYWaCTf/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ssG029tG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SYWaCTf/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ssG029tG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1664567398;
	Fri, 10 May 2024 15:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715354109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkfYfa2bSqpqubQurBedtYk/7Fl2S8Y+GKROzrM51Ig=;
	b=SYWaCTf/d50jctkmp4j8AYu1ygzCnz99vfAWh+792nzYE8+Y26mKg31h2M8xAb0K8Lu63C
	cSbNKxgJq3BPMZWSnKRmO/ScTnAouMc8FDXwl39KsoYQQWLCXt9dGmUPOF+2O4lBVDDodS
	yrXkDXTlOIxvtEiAlDD4s5d4b5OgSxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715354109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkfYfa2bSqpqubQurBedtYk/7Fl2S8Y+GKROzrM51Ig=;
	b=ssG029tGeFnfLQzjax5mMmKqSG6X1vCpV9q/jWyoYoCnZ5e0obffkT29/ZI/pazxqECgm4
	Xu9WiQurQwCiqGDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="SYWaCTf/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ssG029tG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715354109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkfYfa2bSqpqubQurBedtYk/7Fl2S8Y+GKROzrM51Ig=;
	b=SYWaCTf/d50jctkmp4j8AYu1ygzCnz99vfAWh+792nzYE8+Y26mKg31h2M8xAb0K8Lu63C
	cSbNKxgJq3BPMZWSnKRmO/ScTnAouMc8FDXwl39KsoYQQWLCXt9dGmUPOF+2O4lBVDDodS
	yrXkDXTlOIxvtEiAlDD4s5d4b5OgSxo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715354109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gkfYfa2bSqpqubQurBedtYk/7Fl2S8Y+GKROzrM51Ig=;
	b=ssG029tGeFnfLQzjax5mMmKqSG6X1vCpV9q/jWyoYoCnZ5e0obffkT29/ZI/pazxqECgm4
	Xu9WiQurQwCiqGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09A90139AA;
	Fri, 10 May 2024 15:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zAxUAv05PmYqKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 May 2024 15:15:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A59B8A0983; Fri, 10 May 2024 17:15:08 +0200 (CEST)
Date: Fri, 10 May 2024 17:15:08 +0200
From: Jan Kara <jack@suse.cz>
To: Justin Stitt <justinstitt@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fs: fix unintentional arithmetic wraparound in offset
 calculation
Message-ID: <20240510151508.hajqjxsn7rghk3dj@quack3>
References: <20240509-b4-sio-read_write-v1-1-06bec2022697@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509-b4-sio-read_write-v1-1-06bec2022697@google.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1664567398
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Thu 09-05-24 21:34:58, Justin Stitt wrote:
> When running syzkaller with the newly reintroduced signed integer
> overflow sanitizer we encounter this report:
> 
> [   67.991989] ------------[ cut here ]------------
> [   67.995501] UBSAN: signed-integer-overflow in ../fs/read_write.c:91:10
> [   68.000067] 9223372036854775807 + 4096 cannot be represented in type 'loff_t' (aka 'long long')
> [   68.006266] CPU: 4 PID: 10851 Comm: syz-executor.5 Not tainted 6.8.0-rc2-00035-gb3ef86b5a957 #1
> [   68.012353] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   68.018983] Call Trace:
> [   68.020803]  <TASK>
> [   68.022540]  dump_stack_lvl+0x93/0xd0
> [   68.025222]  handle_overflow+0x171/0x1b0
> [   68.028053]  generic_file_llseek_size+0x35b/0x380
> ...
> 
> Historically, the signed integer overflow sanitizer did not work in the
> kernel due to its interaction with `-fwrapv` but this has since been
> changed [1] in the newest version of Clang. It was re-enabled in the
> kernel with Commit 557f8c582a9ba8ab ("ubsan: Reintroduce signed overflow
> sanitizer").
> 
> Since @offset is later limited by @maxsize, we can proactively safeguard
> against exceeding that value and also dodge some accidental overflow
> (which may cause bad file access):
> 
> 	loff_t vfs_setpos(struct file *file, loff_t offset, loff_t maxsize)
> 	{
> 		if (offset < 0 && !unsigned_offsets(file))
> 			return -EINVAL;
> 		if (offset > maxsize)
> 			return -EINVAL;
> 		...
> 
> Link: https://github.com/llvm/llvm-project/pull/82432 [1]
> Closes: https://github.com/KSPP/linux/issues/358
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Here's the syzkaller reproducer:
> | # {Threaded:false Repeat:false RepeatTimes:0 Procs:1 Slowdown:1 Sandbox:
> | # SandboxArg:0 Leak:false NetInjection:false NetDevices:false
> | # NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:false
> | # DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false
> | # IEEE802154:false Sysctl:false Swap:false UseTmpDir:false
> | # HandleSegv:false Repro:false Trace:false LegacyOptions:{Collide:false
> | # Fault:false FaultCall:0 FaultNth:0}}
> | r0 = openat$sysfs(0xffffffffffffff9c, &(0x7f0000000000)='/sys/kernel/address_bits', 0x0, 0x98)
> | lseek(r0, 0x7fffffffffffffff, 0x2)
> 
> ... which was used against Kees' tree here (v6.8rc2):
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=wip/v6.9-rc2/unsigned-overflow-sanitizer
> 
> ... with this config:
> https://gist.github.com/JustinStitt/824976568b0f228ccbcbe49f3dee9bf4
> ---
>  fs/read_write.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index d4c036e82b6c..10c3eaa5ef55 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -88,7 +88,7 @@ generic_file_llseek_size(struct file *file, loff_t offset, int whence,
>  {
>  	switch (whence) {
>  	case SEEK_END:
> -		offset += eof;
> +		offset = min_t(loff_t, offset, maxsize - eof) + eof;

Well, but by this you change the behavior of seek(2) for huge offsets.
Previously we'd return -EINVAL (from following vfs_setpos()), now we set
position to maxsize. I don't think that is desirable?

Also the addition in SEEK_CUR could overflow in the same way AFAICT so we
could treat that in one patch so that the whole function is fixed at once?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

