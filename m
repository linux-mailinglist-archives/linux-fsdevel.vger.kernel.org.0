Return-Path: <linux-fsdevel+bounces-36777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 102189E938C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 13:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06E31886448
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 12:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD82B2248B2;
	Mon,  9 Dec 2024 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sM4L6vVL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C+9ZeTNI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sM4L6vVL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C+9ZeTNI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451FE21CFF0;
	Mon,  9 Dec 2024 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733746273; cv=none; b=awtmuAolxz98FBgu9HXAnQP0xnlgS1p8kpcaCGd0rxZwHXPqtSkXXPCOM9/rv707BsLn+8RITCZDACRxuDoNCgVyAop3ZJeuJsCbMKkQBchwD6h1yEEd4RsR5OTjuB/V8wh3cvQxm0sgL1j8p+9AUDtgLR49PJSEzYxHp1gYFJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733746273; c=relaxed/simple;
	bh=DW37JksRys5w20Dss6QcUZ8G3H0LMQpXXkLpEeU7Kaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdyP5b7oconMSghdQSZfW0FgVzm5Z936BHQBGvwz3zJMX5FI388L7VDugKOQCUhwFyHVHVlz3nR0bod0eMN7T3NQMMwwPVVjYqPlYw71n3j4y/PV9psJ811mogS7yamFMPbuo67qYmibH6iw0PdSBDsRkyh6/rN+9C9FeQf7vnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sM4L6vVL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C+9ZeTNI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sM4L6vVL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C+9ZeTNI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B8421F45B;
	Mon,  9 Dec 2024 12:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733746269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9eTu4ICqX/MBWv87d6ghYK9vw3zsKiLYe3pMYvqXdg=;
	b=sM4L6vVL4A73Y1BAcWwMnbB8eeLPSE88ltpR2s3HoRQ7A8BmyvdPjqSvIKjr1Cn1gsRMJu
	/VZjAG1bQcix+ncpFJpFgPWfBgQXCSCKsbNjjiXkBFVRuw0kp18eQG7XQlryzLHiSiLE7Y
	X9OUOQyeOcVQ/hmyf23wcfYRddwpCnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733746269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9eTu4ICqX/MBWv87d6ghYK9vw3zsKiLYe3pMYvqXdg=;
	b=C+9ZeTNI7MdhXfH0wO4e2TOSHL404mhYJPPpbDy4LlsCeaHiR3DY7jvZSKcihK/XZMtJpA
	0xbQVbv3uMlYk7BQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sM4L6vVL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=C+9ZeTNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733746269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9eTu4ICqX/MBWv87d6ghYK9vw3zsKiLYe3pMYvqXdg=;
	b=sM4L6vVL4A73Y1BAcWwMnbB8eeLPSE88ltpR2s3HoRQ7A8BmyvdPjqSvIKjr1Cn1gsRMJu
	/VZjAG1bQcix+ncpFJpFgPWfBgQXCSCKsbNjjiXkBFVRuw0kp18eQG7XQlryzLHiSiLE7Y
	X9OUOQyeOcVQ/hmyf23wcfYRddwpCnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733746269;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9eTu4ICqX/MBWv87d6ghYK9vw3zsKiLYe3pMYvqXdg=;
	b=C+9ZeTNI7MdhXfH0wO4e2TOSHL404mhYJPPpbDy4LlsCeaHiR3DY7jvZSKcihK/XZMtJpA
	0xbQVbv3uMlYk7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3C30138D2;
	Mon,  9 Dec 2024 12:11:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8fiVN1zeVmfwUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Dec 2024 12:11:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 71156A0B0C; Mon,  9 Dec 2024 13:11:04 +0100 (CET)
Date: Mon, 9 Dec 2024 13:11:04 +0100
From: Jan Kara <jack@suse.cz>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: commit 0790303ec869 leads to cpu stall without
 CONFIG_FANOTIFY_ACCESS_PERMISSIONS=y
Message-ID: <20241209121104.j6zttbqod3sh3qhr@quack3>
References: <20241208152520.3559-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241208152520.3559-1-spasswolf@web.de>
X-Rspamd-Queue-Id: 1B8421F45B
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
	FREEMAIL_TO(0.00)[web.de];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,web.de];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[toxicpanda.com,vger.kernel.org,suse.cz,fb.com,gmail.com,kernel.org,linux-foundation.org,zeniv.linux.org.uk,kvack.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

Hello!

On Sun 08-12-24 16:25:19, Bert Karwatzki wrote:
> Since linux-next-20241206 booting my debian unstable system hangs before starting gdm.
> After some time these messages appear in /var/log/kern.log:

Thanks for report!

<snip stacktraces>

> I bisected this between linux-6.13-rc1 and linux-20241206 and found this as
> offending commit:
> 0790303ec869 ("fsnotify: generate pre-content permission event on page fault")
> 
> I also noticed that only a part of the commit causes the issue, and reverting
> that part solves it in linux-next-20241206:
> 
> commit 6207000b72058b45bb03f0975fbbbcd9dae06238
> Author: Bert Karwatzki <spasswolf@web.de>
> Date:   Sun Dec 8 01:51:59 2024 +0100
> 
>     mm: filemap: partially revert commit 790303ec869
> 
>     Reverting this part of commit 790303ec869 is enough
>     to fix the issue.
> 
>     Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 23e001f5cd0f..9bf2fc833f3c 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3419,37 +3419,6 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
>  	 * or because readahead was otherwise unable to retrieve it.
>  	 */
>  	if (unlikely(!folio_test_uptodate(folio))) {
> -		/*
> -		 * If this is a precontent file we have can now emit an event to
> -		 * try and populate the folio.
> -		 */
> -		if (!(vmf->flags & FAULT_FLAG_TRIED) &&
> -		    unlikely(FMODE_FSNOTIFY_HSM(file->f_mode))) {
> -			loff_t pos = folio_pos(folio);
> -			size_t count = folio_size(folio);
> -
> -			/* We're NOWAIT, we have to retry. */
> -			if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT) {
> -				folio_unlock(folio);
> -				goto out_retry;
> -			}
> -
> -			if (mapping_locked)
> -				filemap_invalidate_unlock_shared(mapping);
> -			mapping_locked = false;
> -
> -			folio_unlock(folio);
> -			fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> -			if (!fpin)
> -				goto out_retry;
> -
> -			error = fsnotify_file_area_perm(fpin, MAY_ACCESS, &pos,
> -							count);
> -			if (error)
> -				ret = VM_FAULT_SIGBUS;
> -			goto out_retry;
> -		}
> -
>  		/*
>  		 * If the invalidate lock is not held, the folio was in cache
>  		 * and uptodate and now it is not. Strange but possible since we
> 
> 
> Then I took a closer look at the function called in the problematic code
> and noticed that fsnotify_file_area_perm(), is a NOOP when
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS is not set (which was the case in my
> .config). This also explains why this was not found before, as
> distributional .config file have this option enabled.  Setting the option
> to y solves the issue, too

Well, I agree with you on all the points but the real question is, how come
the test FMODE_FSNOTIFY_HSM(file->f_mode) was true on our kernel when you
clearly don't run HSM software, even more so with
CONFIG_FANOTIFY_ACCESS_PERMISSIONS disabled. That's the real cause of this
problem. Something fishy is going on here... checking...

Ah, because I've botched out file_set_fsnotify_mode() in case
CONFIG_FANOTIFY_ACCESS_PERMISSIONS is disabled. This should fix the
problem:

index 1a9ef8f6784d..778a88fcfddc 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -215,6 +215,7 @@ static inline int fsnotify_open_perm(struct file *file)
 #else
 static inline void file_set_fsnotify_mode(struct file *file)
 {
+       file->f_mode |= FMODE_NONOTIFY_PERM;
 }

I'm going to test this with CONFIG_FANOTIFY_ACCESS_PERMISSIONS disabled and
push out a fixed version. Thanks again for the report and analysis!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

