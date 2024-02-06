Return-Path: <linux-fsdevel+bounces-10435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4794A84B244
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 11:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FE84B24D5A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 10:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3090812E1E0;
	Tue,  6 Feb 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cLr5Zriv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N0fL3MlR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cLr5Zriv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="N0fL3MlR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81CF12DD99;
	Tue,  6 Feb 2024 10:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214533; cv=none; b=cNCfFPu4Tfp0NxKJkODHO12913b2/gRyMDiL+mG066uFLosIpAvH0Fz2MjvJXDEfNWov/qdpRoIGNLrEWMuTTrJXYRdcz0puqfqIJaTO7EOITJWARW0MjqYQ5YP+mFBrrRfSLWvjufockqZBF2uUCsHFuTC5zgbzvZ/LcqrBexg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214533; c=relaxed/simple;
	bh=aWSrDqqDDbZkz1Gknzn9ILdQdVypW8uzLLkdALeBdGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVr3AGHY4T7Uj656XwKw8edot8ghFEJHsek8bsZI571f5klczWrGNOSY9w56a2bGOF9Wt76zQgEW78hAq/fYGqKRJET3TvyT+8iAPic5A16ixSL2SL2s+TtHWUpYDEfP4IBH1G0tC8r8HQxMBbA37K7bqmbAeECUi61aEdLeoWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cLr5Zriv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N0fL3MlR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cLr5Zriv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=N0fL3MlR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F3BBD22052;
	Tue,  6 Feb 2024 10:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707214530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I89zPPIlshU+AsbUcqX21NyfDIWTi39UwY/r6vWLmBY=;
	b=cLr5ZrivQTac81QBO8MsenXbHgYwuYexWpkRSBetxYOcA1aIN7frsDQoVhtMan3OKxAz6Q
	MEafbebmIrPsm25ofvMqiaMN39tCvm/RosvpCc2+hNmaSJ2JHEUDYhlVngOQTY1oca5sDh
	w8+4IddoRyo0UFnTOyLPpYs/lZDLyi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707214530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I89zPPIlshU+AsbUcqX21NyfDIWTi39UwY/r6vWLmBY=;
	b=N0fL3MlRuQhsyY0Q9DZFYda4RuuWUr6Lf+O27aMxOwYukQyOdELGFyGqOtpUSsMQXKMPpY
	wXXlY1IuUwTsIADQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707214530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I89zPPIlshU+AsbUcqX21NyfDIWTi39UwY/r6vWLmBY=;
	b=cLr5ZrivQTac81QBO8MsenXbHgYwuYexWpkRSBetxYOcA1aIN7frsDQoVhtMan3OKxAz6Q
	MEafbebmIrPsm25ofvMqiaMN39tCvm/RosvpCc2+hNmaSJ2JHEUDYhlVngOQTY1oca5sDh
	w8+4IddoRyo0UFnTOyLPpYs/lZDLyi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707214530;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I89zPPIlshU+AsbUcqX21NyfDIWTi39UwY/r6vWLmBY=;
	b=N0fL3MlRuQhsyY0Q9DZFYda4RuuWUr6Lf+O27aMxOwYukQyOdELGFyGqOtpUSsMQXKMPpY
	wXXlY1IuUwTsIADQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA2A913A3A;
	Tue,  6 Feb 2024 10:15:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HoFANcEGwmWMfAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Feb 2024 10:15:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 843FDA0809; Tue,  6 Feb 2024 11:15:29 +0100 (CET)
Date: Tue, 6 Feb 2024 11:15:29 +0100
From: Jan Kara <jack@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>,
	Linux-Next Mailing List <linux-next@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	linux-fsdevel@vger.kernel.org, lkft-triage@lists.linaro.org,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: next: /dev/root: Can't open blockdev
Message-ID: <20240206101529.orwe3ofwwcaghqvz@quack3>
References: <CA+G9fYttTwsbFuVq10igbSvP5xC6bf_XijM=mpUqrJV=uvUirQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYttTwsbFuVq10igbSvP5xC6bf_XijM=mpUqrJV=uvUirQ@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linaro.org:url,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[33.55%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.40

On Tue 06-02-24 14:41:17, Naresh Kamboju wrote:
> All qemu's mount rootfs failed on Linux next-20230206 tag due to the following
> kernel crash.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Crash log:
> ---------
> <3>[    3.257960] /dev/root: Can't open blockdev
> <4>[    3.258940] VFS: Cannot open root device "/dev/sda" or
> unknown-block(8,0): error -16

Uhuh, -16 is EBUSY so it seems Christian's block device opening changes are
suspect? Do you have some sample kconfig available somewhere?

								Honza

> <4>[    3.259704] Please append a correct "root=" boot option; here
> are the available partitions:
> <4>[    3.261088] 0800         2500336 sda
> <4>[    3.261186]  driver: sd
> <4>[    3.262260] 0b00         1048575 sr0
> <4>[    3.262409]  driver: sr
> <3>[    3.263022] List of all bdev filesystems:
> <3>[    3.263553]  ext3
> <3>[    3.263708]  ext2
> <3>[    3.263994]  ext4
> <3>[    3.264160]  vfat
> <3>[    3.264419]  msdos
> <3>[    3.264589]  iso9660
> <3>[    3.264773]
> <0>[    3.265665] Kernel panic - not syncing: VFS: Unable to mount
> root fs on unknown-block(8,0)
> <4>[    3.266991] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
> 6.8.0-rc3-next-20240206 #1
> <4>[    3.267593] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> <4>[    3.268937] Call Trace:
> <4>[    3.269316]  <TASK>
> <4>[    3.270113]  dump_stack_lvl+0x71/0xb0
> <4>[    3.271837]  dump_stack+0x14/0x20
> <4>[    3.272128]  panic+0x12f/0x2f0
> <4>[    3.272812]  ? _printk+0x5d/0x80
> <4>[    3.273097]  mount_root_generic+0x26e/0x2b0
> <4>[    3.273941]  mount_block_root+0x3f/0x50
> <4>[    3.274212]  mount_root+0x60/0x80
> <4>[    3.274610]  prepare_namespace+0x7a/0xb0
> <4>[    3.276008]  kernel_init_freeable+0x137/0x180
> <4>[    3.276285]  ? __pfx_kernel_init+0x10/0x10
> <4>[    3.276563]  kernel_init+0x1e/0x1a0
> <4>[    3.276837]  ret_from_fork+0x45/0x50
> <4>[    3.277319]  ? __pfx_kernel_init+0x10/0x10
> <4>[    3.278176]  ret_from_fork_asm+0x1a/0x30
> <4>[    3.278560]  </TASK>
> <0>[    3.280750] Kernel Offset: 0x1a800000 from 0xffffffff81000000
> (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> <0>[    3.281985] ---[ end Kernel panic - not syncing: VFS: Unable to
> mount root fs on unknown-block(8,0) ]---
> 
> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240206/testrun/22547673/suite/log-parser-test/test/check-kernel-panic/log
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240206/testrun/22547673/suite/log-parser-test/tests/
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

