Return-Path: <linux-fsdevel+bounces-61720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2363EB594B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CDD3206B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 11:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624582C0F83;
	Tue, 16 Sep 2025 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Clk+EEY/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ytwML0GF";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ADFGvhn8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xgKcjVaa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F8B2877D3
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 11:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758020691; cv=none; b=k931JflVBwzR61YPng6TKeF4a0nV4rohVsNFxyof5n9zaKvIyLU4MBlo1TGk4OdntBZNgyg2sjIVHtj8hBVSqiOBF5nZ69NcJHOixWO5QxLkX/zWeXcvzbyoS8uaKaXK19IlIlmoO644qV5Xz0X0FPjk1AGXNFjeOnIL2hU4FZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758020691; c=relaxed/simple;
	bh=6iZ/hVZU+vtlEEp0FSXnhKnIBs8Acs2EWAnqw48/cAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKG3wo2iwV7/9D1ByUEfiJxRa35jUex0Njv6ULQMaD0IEh6a4FUdj8/rLElGs32zLGPcGyngMVIDQ7Pt035q0aKTFABJuUasCRSNJLiqnDLYMVIruuo3Y0yW9XDzdXIXD9P1Zb2euGzrl9zROqQIdtYthx/faW7M2KFZKErCwzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Clk+EEY/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ytwML0GF; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ADFGvhn8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xgKcjVaa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 02404222A4;
	Tue, 16 Sep 2025 11:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758020688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uB3s75uIkNgs3ivEMPKxDsUxxOEwMyVjkPUAHjlB29Q=;
	b=Clk+EEY/+XyLZNpY7QrN3RIYjibUWBqNZxtXJMrDon3ieCDpqQh2JnfZKi+RKyrOU60LEG
	FP7qfvM62au2DSQ+8TmDY38UoH0sqpq5hL8XRCY+NIkmB91dtOLeohxaQuJ2gkICXzp1dD
	nnCQnXA6gr3AnOYrOomCJmGSZNiRIGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758020688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uB3s75uIkNgs3ivEMPKxDsUxxOEwMyVjkPUAHjlB29Q=;
	b=ytwML0GF7CjWKv4PZQYYPP8fvkQDech1EF33QYkPxi5T2wtVrgBiEgspeMXS0NG/hXFpdM
	R36MqZLTjypGkSBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ADFGvhn8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xgKcjVaa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758020687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uB3s75uIkNgs3ivEMPKxDsUxxOEwMyVjkPUAHjlB29Q=;
	b=ADFGvhn8TGyBrfikNQaf6x+czHKdB2l2gBTVPQXS6ImHtS5/3EGceVwdmS2ktyJqeoc7g2
	TT0iTTklU0jZ6mv6HZVj8bMHGSqzRqlHZFblUTVgsN39efBfKtggb9XxX2+QRjnQuv2uJT
	dNNBqDn5MDWLkytYEzLFBIoCiu1yuHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758020687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uB3s75uIkNgs3ivEMPKxDsUxxOEwMyVjkPUAHjlB29Q=;
	b=xgKcjVaahlY6F4xvT0zvJHVxkesQv4XnlpiukwTfXth/tfjg/hpVPAkFe35PXXcLMtKwsc
	GrgIVvYz1tcAwPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4C5D139CB;
	Tue, 16 Sep 2025 11:04:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pQ+IN05EyWh3WwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 16 Sep 2025 11:04:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 76DECA0A56; Tue, 16 Sep 2025 13:04:42 +0200 (CEST)
Date: Tue, 16 Sep 2025 13:04:42 +0200
From: Jan Kara <jack@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, LTP List <ltp@lists.linux.it>, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Christian Brauner <brauner@kernel.org>, 
	chrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: next-20250915: LTP chdir01 df01_sh stat04 tst_device.c:97:
 TBROK: Could not stat loop device 0
Message-ID: <arfepejkmgi63wepbkfhl2jjbhleh5degel7i3o7htgwjsayqg@z3pjoszloxni>
References: <CA+G9fYuFdesVkgGOow7+uQpw-QA6hdqBBUye8CKMxGAiwHagOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuFdesVkgGOow7+uQpw-QA6hdqBBUye8CKMxGAiwHagOA@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 02404222A4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.it,lists.linaro.org,lists.linux.dev,kernel.org,suse.cz,arndb.de,linaro.org,zeniv.linux.org.uk,gmail.com,oracle.com,samsung.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,linaro.org:email,linaro.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -4.01

On Tue 16-09-25 12:57:26, Naresh Kamboju wrote:
> The following LTP chdir01 df01_sh and stat04 tests failed on the rock-pi-4b
> qemu-arm64 on the Linux next-20250915 tag build.
> 
> First seen on next-20250915
> Good: next-20250912
> Bad: next-20250915
> 
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> * rk3399-rock-pi-4b, ltp-smoke
> * qemu-arm64, ltp-smoke
> * qemu-arm64-compat, ltp-smoke
>  - chdir01
>   - df01_sh
>   - stat04
> 
> Test regression: next-20250915: LTP chdir01 df01_sh stat04
> tst_device.c:97: TBROK: Could not stat loop device 0

This is really strange. Those failing tests all start to complain that
/dev/loop0 doesn't exist (open gets ENOENT)... The fact that this is
limited to only a few archs suggests it's some race somewhere but I don't
see any relevant changes in linux-block in last three days...

								Honza

> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Test log
> <8>[   53.655971] <LAVA_SIGNAL_STARTTC chdir01>
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_chdm4pHJb as tmpdir (tmpfs filesystem)
> tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:1953: TINFO: LTP version: 20250530
> tst_test.c:1956: TINFO: Tested kernel: 6.17.0-rc6-next-20250915 #1 SMP
> PREEMPT @1757983656 aarch64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
> which might slow the execution
> tst_test.c:1774: TINFO: Overall timeout per run is 0h 28m 48s
> tst_supported_fs_types.c:97: TINFO: Kernel supports ext2
> tst_supported_fs_types.c:62: TINFO: mkfs.ext2 does exist
> tst_supported_fs_types.c:97: TINFO: Kernel supports ext3
> tst_supported_fs_types.c:62: TINFO: mkfs.ext3 does exist
> tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
> tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
> tst_supported_fs_types.c:128: TINFO: Filesystem xfs is not supported
> tst_supported_fs_types.c:97: TINFO: Kernel supports btrfs
> tst_supported_fs_types.c:62: TINFO: mkfs.btrfs does exist
> tst_supported_fs_types.c:105: TINFO: Skipping bcachefs because of FUSE blacklist
> tst_supported_fs_types.c:97: TINFO: Kernel supports vfat
> tst_supported_fs_types.c:62: TINFO: mkfs.vfat does exist
> tst_supported_fs_types.c:128: TINFO: Filesystem exfat is not supported
> tst_supported_fs_types.c:132: TINFO: FUSE does support ntfs
> tst_supported_fs_types.c:62: TINFO: mkfs.ntfs does exist
> tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
> tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
> tst_test.c:1888: TINFO: === Testing on ext2 ===
> tst_device.c:391: TWARN: Failed to clear 512k block on /dev/loop0
> tst_test.c:1217: TBROK: tst_clear_device() failed
> Summary:
> passed   0
> failed   0
> broken   1
> skipped  0
> warnings 1
> tst_device.c:283: TWARN: open(/dev/loop0) failed: ENOENT (2)
> <8>[   53.679564] <LAVA_SIGNAL_ENDTC chdir01>
> <8>[   53.708246] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=chdir01 RESULT=fail>
> 
> <8>[   53.933883] <LAVA_SIGNAL_STARTTC stat04>
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_staPDxElt as tmpdir (tmpfs filesystem)
> tst_device.c:97: TBROK: Could not stat loop device 0
> Summary:
> passed   0
> failed   0
> broken   1
> skipped  0
> warnings 0
> <8>[   53.947889] <LAVA_SIGNAL_ENDTC stat04>
> <8>[   53.974024] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=stat04 RESULT=fail>
> 
> <8>[   54.048075] <LAVA_SIGNAL_STARTTC df01_sh>
> df01 1 TINFO: Running: df01.sh
> df01 1 TINFO: Tested kernel: Linux
> runner-j2nyww-sk-project-40964107-concurrent-0
> 6.17.0-rc6-next-20250915 #1 SMP PREEMPT @1757983656 aarch64 GNU/Linux
> df01 1 TINFO: Using /tmp/LTP_df01.7pcwUXe1CN as tmpdir (tmpfs filesystem)
> tst_device.c:97: TBROK: Could not stat loop device 0
> df01 1 TBROK: Failed to acquire device
> Summary:
> passed   0
> failed   0
> broken   1
> skipped  0
> warnings 0
> <8>[   54.060936] <LAVA_SIGNAL_ENDTC df01_sh>
> <8>[   54.087630] <LAVA_SIGNAL_TESTCASE TEST_CASE_ID=df01_sh RESULT=fail>
> 
> ## Source
> * Kernel version: 6.17.0-rc6
> * Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
> * Git describe: 6.17.0-rc6-next-20250915
> * Git commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
> * Architectures: arm64
> * Toolchains: gcc-13 and gcc-8
> * Kconfigs: lkftconfigs
> 
> ## Build
> * Test log: https://qa-reports.linaro.org/api/testruns/29896973/log_file/
> * Test details:
> https://regressions.linaro.org/lkft/linux-next-master/next-20250915/ltp-smoke/stat04/
> * Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/32l4Vv9hKep2EcmS18u3NBtmoAm
> * Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32l4UF8KltAzu6kUpW3hXaYRWjZ/
> * Kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/32l4UF8KltAzu6kUpW3hXaYRWjZ/config
> 
> --
> Linaro LKFT
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

