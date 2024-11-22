Return-Path: <linux-fsdevel+bounces-35564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2919D5E0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0455281A0A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 11:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD50B1DE883;
	Fri, 22 Nov 2024 11:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PmYn71yl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fe8iJJwc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wkVaOM19";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MMy1V0P+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A5F1DDC12;
	Fri, 22 Nov 2024 11:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275031; cv=none; b=HV95Ri5B2jAKOWU5eaNtzkxcINp+7NnsSPNhdgH8d/Yfvf/1DFOKlNtAs8WtTFOr1l622EDGpP7IGTi+g1AZ3vA7cFYcqm/zYofREdMS81PAbe788qgnhrjzfsMw9kMCQZtvLsQ9BKxGTdaWwThejID5bL4Y0fHZDWlIstRyCCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275031; c=relaxed/simple;
	bh=EeFxm2dQSHzEemo314U60LuoFW4L7Vzc5dnMBD3tEOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+Sy/RHIaHME4xT75AsALtT8VpWBPNFYO/calOxLmSzQ7qezpnqrQ8zEdpCkicADh1m6qdMqet759YPJrGVbkJL6HTnnsWY2KPlju9LZBA7RK1rVBq0Yfgp44ZflHr0pybD1pusjwLjeaE19r9deCLouvEuadG2cFITSaYtcYsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PmYn71yl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fe8iJJwc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wkVaOM19; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MMy1V0P+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 425B9211EE;
	Fri, 22 Nov 2024 11:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732275026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2vsjY+U6z8LJYccrhaDmy731lanf/zA1aLb7bm+kNo=;
	b=PmYn71ylJl1f7VY2lZpL2QJ8nfaFwFkECCVmXVtxs6WpJgrThVo6bTCdU8/krwtVFf8nUP
	O8kvFLMRa+tOmeWYnfb7mSiDAj3c3encN7NCCCyWZFGDL3KIm4InA67v8WYxToJ0xY/7fh
	2OaGk9UiT4drGZ/lfvYpS+EPpgR+hUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732275026;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2vsjY+U6z8LJYccrhaDmy731lanf/zA1aLb7bm+kNo=;
	b=Fe8iJJwcVQ0zyH0yYy1O9ha7Y32x0iPCrP/Z1zrw4mevr8hVZWcVwYz+WVfcT73tRZTGlW
	O5zUsYpEVKCSBADg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wkVaOM19;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MMy1V0P+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732275025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2vsjY+U6z8LJYccrhaDmy731lanf/zA1aLb7bm+kNo=;
	b=wkVaOM19FTEn3K5rCFEW1PoRB8WqiYWAwNVZqpYSuioghd4XOAed/a9bFL3FUdhhwP53R3
	wddLhgDwrZ6Fgdr1nuxVGRNKOAtRMuDIswzi8iXAXInJ5r6MW+vR0+zyVpFlwaSfyTyniP
	ScXMGJGSRBR/5d6pb1vqk2jTaLMxrfA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732275025;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2vsjY+U6z8LJYccrhaDmy731lanf/zA1aLb7bm+kNo=;
	b=MMy1V0P+fRjJKk/ahnYNaxvwLzGoDTZkXdeK5hIKeSMNVMFq2Vq+I+KtsDLPUrh9F/Sm0S
	/LMD84L2MPaSDmDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3504413998;
	Fri, 22 Nov 2024 11:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aFqhDFFrQGeYMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 22 Nov 2024 11:30:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D6066A08B8; Fri, 22 Nov 2024 12:30:24 +0100 (CET)
Date: Fri, 22 Nov 2024 12:30:24 +0100
From: Jan Kara <jack@suse.cz>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
	reiserfs-devel@vger.kernel.org
Subject: Re: GIT PULL] Remove reiserfs
Message-ID: <20241122113024.ksjt66voobk4565q@quack3>
References: <4b454953-eafa-4bb4-824d-6012f7924d5c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b454953-eafa-4bb4-824d-6012f7924d5c@gmail.com>
X-Rspamd-Queue-Id: 425B9211EE
X-Spam-Score: -3.57
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.57 / 50.00];
	BAYES_HAM(-2.56)[98.05%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi!

On Fri 22-11-24 12:18:40, Xose Vazquez Perez wrote:
> Still traces in the tree:

Yes, and this is actually deliberate. It isn't as reiserfs never existed...
So I've left old changelogs, fs magics, credits for borrowed code, etc. in
tree. Possibly the occurences in scripts/ are pointless now so if you send
a patch, I can merge it.

								Honza

> 
> $ git grep -iE "reiserfs|reiser4|reiser2"
> Documentation/admin-guide/ext4.rst:  a similar level of journaling as that of XFS, JFS, and ReiserFS in its default
> Documentation/admin-guide/laptops/laptop-mode.rst:* If you mount some of your ext3/reiserfs filesystems with the -n option, then
> Documentation/admin-guide/laptops/laptop-mode.rst:ext3 or ReiserFS filesystems (also done automatically by the control script),
> Documentation/admin-guide/laptops/laptop-mode.rst:                                      "ext3"|"reiserfs")
> Documentation/admin-guide/laptops/laptop-mode.rst:                                      "ext3"|"reiserfs")
> Documentation/arch/powerpc/eeh-pci-error-recovery.rst:   Reiserfs does not tolerate errors returned from the block device.
> Documentation/process/3.Early-stage.rst: - The Reiser4 filesystem included a number of capabilities which, in the
> Documentation/process/3.Early-stage.rst:   address some of them - has caused Reiser4 to stay out of the mainline
> Documentation/process/changes.rst:reiserfsprogs          3.6.3            reiserfsck -V
> Documentation/process/changes.rst:Reiserfsprogs
> Documentation/process/changes.rst:The reiserfsprogs package should be used for reiserfs-3.6.x
> Documentation/process/changes.rst:versions of ``mkreiserfs``, ``resize_reiserfs``, ``debugreiserfs`` and
> Documentation/process/changes.rst:``reiserfsck``. These utils work on both i386 and alpha platforms.
> Documentation/process/changes.rst:Reiserfsprogs
> Documentation/process/changes.rst:- <https://git.kernel.org/pub/scm/linux/kernel/git/jeffm/reiserfsprogs.git/>
> Documentation/trace/ftrace.rst:    360.774528 |   1)               |                                  reiserfs_prepare_for_journal() {
> Documentation/translations/it_IT/process/3.Early-stage.rst: - Il filesystem Reiser4 include una seria di funzionalità che, secondo
> Documentation/translations/it_IT/process/changes.rst:reiserfsprogs          3.6.3              reiserfsck -V
> Documentation/translations/it_IT/process/changes.rst:Reiserfsprogs
> Documentation/translations/it_IT/process/changes.rst:Il pacchetto reiserfsprogs dovrebbe essere usato con reiserfs-3.6.x (Linux
> Documentation/translations/it_IT/process/changes.rst:funzionanti di ``mkreiserfs``, ``resize_reiserfs``, ``debugreiserfs`` e
> Documentation/translations/it_IT/process/changes.rst:``reiserfsck``.  Questi programmi funzionano sulle piattaforme i386 e alpha.
> Documentation/translations/it_IT/process/changes.rst:Reiserfsprogs
> Documentation/translations/it_IT/process/changes.rst:- <https://git.kernel.org/pub/scm/linux/kernel/git/jeffm/reiserfsprogs.git/>
> Documentation/translations/zh_CN/process/3.Early-stage.rst: - Reiser4文件系统包含许多功能，核心内核开发人员认为这些功能应该在虚拟文件
> Documentation/translations/zh_CN/process/3.Early-stage.rst:   导致Reiser4置身主线内核之外。
> Documentation/translations/zh_TW/process/3.Early-stage.rst: - Reiser4文件系統包含許多功能，核心內核開發人員認爲這些功能應該在虛擬文件
> Documentation/translations/zh_TW/process/3.Early-stage.rst:   導致Reiser4置身主線內核之外。
> Documentation/userspace-api/ioctl/ioctl-number.rst:0xCD  01     linux/reiserfs_fs.h                                     Dead since 6.13
> fs/btrfs/tree-log.c: * ext3/4, xfs, f2fs, reiserfs, nilfs2). Note that when logging the inodes
> fs/ubifs/key.h: * node. We use "r5" hash borrowed from reiserfs.
> fs/ubifs/key.h: * key_r5_hash - R5 hash function (borrowed from reiserfs).
> include/linux/stringhash.h:/* Hash courtesy of the R5 hash in reiserfs modulo sign bits */
> include/uapi/linux/magic.h:#define REISERFS_SUPER_MAGIC 0x52654973      /* used by gcc */
> include/uapi/linux/magic.h:#define REISERFS_SUPER_MAGIC_STRING  "ReIsErFs"
> include/uapi/linux/magic.h:#define REISER2FS_SUPER_MAGIC_STRING "ReIsEr2Fs"
> include/uapi/linux/magic.h:#define REISER2FS_JR_SUPER_MAGIC_STRING      "ReIsEr3Fs"
> scripts/selinux/install_policy.sh:      grep -E "ext[234]|jfs|xfs|reiserfs|jffs2|gfs2|btrfs|f2fs|ocfs2" | \
> scripts/ver_linux:      printversion("Reiserfsprogs", version("reiserfsck -V"))
> scripts/ver_linux:      printversion("Reiser4fsprogs", version("fsck.reiser4 -V"))
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

