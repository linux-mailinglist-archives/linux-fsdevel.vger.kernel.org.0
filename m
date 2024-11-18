Return-Path: <linux-fsdevel+bounces-35103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A43309D1195
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 14:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AAAA1F22CB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 13:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63CE19AD7E;
	Mon, 18 Nov 2024 13:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GaLXp7WB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Lw7GPVd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GaLXp7WB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9Lw7GPVd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E8138B;
	Mon, 18 Nov 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731935732; cv=none; b=X6vqrNiR4mvuT7o3HcM/Dj0RBI+aIOvviHws9vMvQitlDD0ZxtGQl251RVwUQnd2WKC0ucYzyYQb4Ab6Q1/mIGMDAlcxWxKVfOLmiz1Bv2CpiDu9OlRDW8acSMLbGnNjNJDngV1TmZ+W4cAatqXd7tR0vLMn7TXii7O2HPCQBdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731935732; c=relaxed/simple;
	bh=YWX9QEoETYmk/JhV97zqqwgnk5pqiw0XoZceR7bRg4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gL5dK1I5UWPHcAuTRRbV6kSt6Lx9TKYckU87ooF5mFQrSwMeSHF1zFmDJ52jHHgzIKsxxmoAn0Ioi1aSJ+QThLa/gw73nPOiQW+IIqyE5WEFh7mDO/MMZZGZdEXfuN+sF1tytZGDvqDFgkLVP8TxACJmor+Aft32HIKC7714FCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GaLXp7WB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9Lw7GPVd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GaLXp7WB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9Lw7GPVd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 199561F365;
	Mon, 18 Nov 2024 13:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731935728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oH8dgWng2LISpFimH1eB2N3OKIE0Vyux0IaBFAiplag=;
	b=GaLXp7WBXzHQYQT3YSR0sWzQCZauOFBvwDKHPx6kNYZjIigPq2YfW8XZY8resUI2eMUE5n
	KAHMdlC2NjPRqC8xcOnV6cL2I1j8AROjvh2mLNwstF3GHpcm9eRFY0priu8fb6coiL5tK7
	zPaTJ7VYmYaKl6JK8R9w5yHMKuARTj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731935728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oH8dgWng2LISpFimH1eB2N3OKIE0Vyux0IaBFAiplag=;
	b=9Lw7GPVdKqBvWga7aBa3g+Vd00WdonaX5MjurA6Hu6ymPyWJXVb/APPwyeUBTusdoklRCp
	X3D9piMsyyZmFsDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GaLXp7WB;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9Lw7GPVd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731935728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oH8dgWng2LISpFimH1eB2N3OKIE0Vyux0IaBFAiplag=;
	b=GaLXp7WBXzHQYQT3YSR0sWzQCZauOFBvwDKHPx6kNYZjIigPq2YfW8XZY8resUI2eMUE5n
	KAHMdlC2NjPRqC8xcOnV6cL2I1j8AROjvh2mLNwstF3GHpcm9eRFY0priu8fb6coiL5tK7
	zPaTJ7VYmYaKl6JK8R9w5yHMKuARTj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731935728;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oH8dgWng2LISpFimH1eB2N3OKIE0Vyux0IaBFAiplag=;
	b=9Lw7GPVdKqBvWga7aBa3g+Vd00WdonaX5MjurA6Hu6ymPyWJXVb/APPwyeUBTusdoklRCp
	X3D9piMsyyZmFsDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CF1A1376E;
	Mon, 18 Nov 2024 13:15:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9vgmA/A9O2dsYQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 18 Nov 2024 13:15:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B6AEAA0984; Mon, 18 Nov 2024 14:15:12 +0100 (CET)
Date: Mon, 18 Nov 2024 14:15:12 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCH 1/1] quota: flush quota_release_work upon quota writeback
Message-ID: <20241118131512.ku7g7bllelrtkdeo@quack3>
References: <20241115183449.2058590-1-ojaswin@linux.ibm.com>
 <20241115183449.2058590-2-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115183449.2058590-2-ojaswin@linux.ibm.com>
X-Rspamd-Queue-Id: 199561F365
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,gmail.com,linux.ibm.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Sat 16-11-24 00:04:49, Ojaswin Mujoo wrote:
> One of the paths quota writeback is called from is:
> 
> freeze_super()
>   sync_filesystem()
>     ext4_sync_fs()
>       dquot_writeback_dquots()
> 
> Since we currently don't always flush the quota_release_work queue in
> this path, we can end up with the following race:
> 
>  1. dquot are added to releasing_dquots list during regular operations.
>  2. FS freeze starts, however, this does not flush the quota_release_work queue.
>  3. Freeze completes.
>  4. Kernel eventually tries to flush the workqueue while FS is frozen which
>     hits a WARN_ON since transaction gets started during frozen state:
> 
>   ext4_journal_check_start+0x28/0x110 [ext4] (unreliable)
>   __ext4_journal_start_sb+0x64/0x1c0 [ext4]
>   ext4_release_dquot+0x90/0x1d0 [ext4]
>   quota_release_workfn+0x43c/0x4d0
> 
> Which is the following line:
> 
>   WARN_ON(sb->s_writers.frozen == SB_FREEZE_COMPLETE);
> 
> Which ultimately results in generic/390 failing due to dmesg
> noise. This was detected on powerpc machine 15 cores.
> 
> To avoid this, make sure to flush the workqueue during
> dquot_writeback_dquots() so we dont have any pending workitems after
> freeze.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks for debugging this!

> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index 3dd8d6f27725..2782cfc8c302 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -729,6 +729,8 @@ int dquot_writeback_dquots(struct super_block *sb, int type)
>  			sb->dq_op->write_info(sb, cnt);
>  	dqstats_inc(DQST_SYNCS);
>  
> +	flush_delayed_work(&quota_release_work);
> +

I'd rather do this at the start of dquot_writeback_dquots(). Chances are
this saves some retry loops in the dirty list iterations. That being said I
don't think this is enough as I'm thinking about it. iput() can be called
anytime while the filesystem is frozen (just freeze the filesystem and do
echo 3 >/proc/sys/vm/drop_caches) which will consequently call dquot_drop()
-> dqput(). This should not be really freeing the dquot on-disk structure
(the inode itself is still accounted there) but nevertheless it may end up
dropping the last dquot in-memory reference and ext4_release_dquot() will
call ext4_journal_start() and complain. So I think on top of this patch
which makes sense on its own and deals with 99.9% of cases, we also need
ext4 specific fix which uses sb_start_intwrite() to get freeze protection
in ext4_release_dquot() (and in principle we always needed this, delayed
dquot releasing does not influence this particular problem). Some care will
be needed if the transaction is already started when ext4_release_dquot()
is called - you can take inspiration in how ext4_evict_inode() handles
this.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

