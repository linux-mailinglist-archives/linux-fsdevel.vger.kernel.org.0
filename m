Return-Path: <linux-fsdevel+bounces-45654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2B1A7A5D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 17:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30D7188D70F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 15:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2FA2505A4;
	Thu,  3 Apr 2025 15:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zPzpKmfD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wBBYEeeA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zPzpKmfD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wBBYEeeA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E1F2459EE
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692407; cv=none; b=P7+gy5ZeExrxx0UvDvkadCJh74DL3IuAearhujVgR3WFeU28doT6jtJEMUZy2Cx7YmwKFN/HAZmyThXoLuZrLAnmrGtX63nICNCift8mBcIOh6fdWua6m1/TSYWi1Ievpatme/JDFR2dvY/iADiifr5Egtdyehq2AYi4fXw2bBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692407; c=relaxed/simple;
	bh=4N/dLPPHi79oRi7/kRqolUaajM0ANvcSXLnLERVmLd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNHnfe8azjV4Ygj87j8JYaodUlUaIZy+IedxEo2pyvW06V9ghp0S6iwSnkoaheXPQi77naTshpzmjeIzLVuBVoafDhcnguL0cbvDyvVsgNKcyC4gjJ02q97f/+UNwbTGBfTc8tV7LqIZonTbZ691Mc9mJEDsa2nD84azOugMiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zPzpKmfD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wBBYEeeA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zPzpKmfD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wBBYEeeA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5A80D211A6;
	Thu,  3 Apr 2025 15:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743692404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWUjIhUp9SgUl9rZUi8TjYPIKL7EfKMDbuaxp3n2dzA=;
	b=zPzpKmfD9WNZN+yykCu4nwciD/0gE9H6h0tHmn2nQXo7G3oFMVhArBbRrTOLqFZQSq2Sx8
	wiuwNT3XNEcDYByDtiZwn4MQnhcDENmVkQWd2B36JFEXVZ0joiLhcPxuPun9Q8sE8L4DQm
	Ysw62c3oF8jMG3N76Ia2mMpbPMl/LM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743692404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWUjIhUp9SgUl9rZUi8TjYPIKL7EfKMDbuaxp3n2dzA=;
	b=wBBYEeeAAUr2XX08UFRKWf9CCBslQ29nQroweHlMdOht+8kOoIlELIjawkTmveR/akysAY
	VAj4cIgrLQ/9enBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zPzpKmfD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wBBYEeeA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743692404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWUjIhUp9SgUl9rZUi8TjYPIKL7EfKMDbuaxp3n2dzA=;
	b=zPzpKmfD9WNZN+yykCu4nwciD/0gE9H6h0tHmn2nQXo7G3oFMVhArBbRrTOLqFZQSq2Sx8
	wiuwNT3XNEcDYByDtiZwn4MQnhcDENmVkQWd2B36JFEXVZ0joiLhcPxuPun9Q8sE8L4DQm
	Ysw62c3oF8jMG3N76Ia2mMpbPMl/LM8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743692404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RWUjIhUp9SgUl9rZUi8TjYPIKL7EfKMDbuaxp3n2dzA=;
	b=wBBYEeeAAUr2XX08UFRKWf9CCBslQ29nQroweHlMdOht+8kOoIlELIjawkTmveR/akysAY
	VAj4cIgrLQ/9enBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 487A11392A;
	Thu,  3 Apr 2025 15:00:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R9+0EXSi7md9YAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Apr 2025 15:00:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EB6A5A07E6; Thu,  3 Apr 2025 16:59:59 +0200 (CEST)
Date: Thu, 3 Apr 2025 16:59:59 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, mcgrof@kernel.org, hch@infradead.org, david@fromorbit.com, 
	rafael@kernel.org, djwong@kernel.org, pavel@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, will@kernel.org, boqun.feng@gmail.com
Subject: Re: [PATCH v2 2/4] fs: allow all writers to be frozen
Message-ID: <qqxbrigfucdh34lknahdre5cuovvzpqmmmn3cg7flpofj5jfbv@ly5t2sicegnj>
References: <20250402-work-freeze-v2-0-6719a97b52ac@kernel.org>
 <20250402-work-freeze-v2-2-6719a97b52ac@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402-work-freeze-v2-2-6719a97b52ac@kernel.org>
X-Rspamd-Queue-Id: 5A80D211A6
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,kernel.org,hansenpartnership.com,infradead.org,fromorbit.com,redhat.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Wed 02-04-25 16:07:32, Christian Brauner wrote:
> During freeze/thaw we need to be able to freeze all writers during
> suspend/hibernate. Otherwise tasks such as systemd-journald that mmap a
> file and write to it will not be frozen after we've already frozen the
> filesystem.
> 
> This has some risk of not being able to freeze processes in case a
> process has acquired SB_FREEZE_PAGEFAULT under mmap_sem or
> SB_FREEZE_INTERNAL under some other filesytem specific lock. If the
> filesystem is frozen, a task can block on the frozen filesystem with
> e.g., mmap_sem held. If some other task then blocks on grabbing that
> mmap_sem, hibernation ill fail because it is unable to hibernate a task
> holding mmap_sem. This could be fixed by making a range of filesystem
> related locks use freezable sleeping. That's impractical and not
> warranted just for suspend/hibernate. Assume that this is an infrequent
> problem and we've given userspace a way to skip filesystem freezing
> through a sysfs file.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW, I agree about the need to silence lockdep somehow.

								Honza

> ---
>  include/linux/fs.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index b379a46b5576..1edcba3cd68e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1781,8 +1781,7 @@ static inline void __sb_end_write(struct super_block *sb, int level)
>  
>  static inline void __sb_start_write(struct super_block *sb, int level)
>  {
> -	percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1,
> -				   level == SB_FREEZE_WRITE);
> +	percpu_down_read_freezable(sb->s_writers.rw_sem + level - 1, true);
>  }
>  
>  static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
> 
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

