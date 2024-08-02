Return-Path: <linux-fsdevel+bounces-24853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69613945AF9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 11:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F1592841AB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414501DC48A;
	Fri,  2 Aug 2024 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0/1BlEEw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DL8LoeQx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n/i3IL2v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J+pkYrpk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92451DB45F;
	Fri,  2 Aug 2024 09:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722590767; cv=none; b=LDh5TZ9Ab0st57fFsyavfOjB2ledCVcO1gXkX20evF1DA0X4JV8/d8Jj/VPEcQTdfNdRrUbEtJ4RjFELbOKTO2vME5n41HRuQWiyJtFQvxWOsLotCzpfkCuTHJ1yby2j+ZsboNBpNfs8l10OytwFWflbufyPx7ECIq4pLMGwdFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722590767; c=relaxed/simple;
	bh=X1C4vuZX8ODqDL57jjQmJR4JlQ/4G4jH9ydCATTfHPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LyJckwfnvfqdRkZtotu+OE2fhoR3Ih0t+ROAxK83yiPTO/8dvnuJ5dOCXY5NLfTHHAv2dcn4uIyjnKzWoeSbAq+QuK/uXSMF+FAdJOBRx4uL0PguHq9QgegmlHmRuo1rpjWd5IbiIwNskO18cgB+bGwq+ILBXfnpS+TOYbTcbG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0/1BlEEw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DL8LoeQx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n/i3IL2v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J+pkYrpk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C98CA1F38C;
	Fri,  2 Aug 2024 09:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722590761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9FasuiBoGtbyU4rhE2DKTVTHzWzbXZGxrQhwHOAKnw=;
	b=0/1BlEEwBnWJD2XkwiJn7+Zy49epwPP7QUyhJ3t56HRyyf/MkqFcogqyoIuj7SBAeuXZzn
	5szw8NaqulTD2Kp8hYTZ2v3SxM0rGKUMfRS6HaKd4oVZbFwYjkCFeoX1XFCPosd6FlCegf
	NrdsNbvYEeb54/qZh3o2JpifXA2uuRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722590761;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9FasuiBoGtbyU4rhE2DKTVTHzWzbXZGxrQhwHOAKnw=;
	b=DL8LoeQxUubuMVQmC7AjwQ6OKPu1Rhxyw0+ngSyH6WPJfuoFoxF68BLNJ6hX7YN8gJE+w5
	fO6sJRHUElmZKNAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722590759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9FasuiBoGtbyU4rhE2DKTVTHzWzbXZGxrQhwHOAKnw=;
	b=n/i3IL2vWO9iu1j+FsZI0Urh6iCGYg2QX5PBq8FGCfK6NVlDfaWJpd5hChiAbAzSvCM51n
	lb8kHx3w5o8wBjz0WuYjXv1QwAFnsos1R1jzYxKY8CIHwvXs57qpH/+dMic2RehVbYUJHe
	BgwtI6ZzO1ul+a0Hoz+sg6QJp4JacKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722590759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9FasuiBoGtbyU4rhE2DKTVTHzWzbXZGxrQhwHOAKnw=;
	b=J+pkYrpkBT4ctpF4iGRejxG5YWGC/4EynK9oihvBNaO7MaUud0eyQ5ikclRnPLfNVT3vMQ
	3G0jb4bn2/jd9SBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDD361388E;
	Fri,  2 Aug 2024 09:25:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q49SLiemrGZVKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 02 Aug 2024 09:25:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7C7C7A08CB; Fri,  2 Aug 2024 11:25:58 +0200 (CEST)
Date: Fri, 2 Aug 2024 11:25:58 +0200
From: Jan Kara <jack@suse.cz>
To: Wang Long <w@laoqinren.net>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	tj@kernel.org, cl@linux.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] percpu-rwsem: remove the unused parameter 'read'
Message-ID: <20240802092558.3dcvf72dguodjxkg@quack3>
References: <20240802091901.2546797-1-w@laoqinren.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802091901.2546797-1-w@laoqinren.net>
X-Spam-Level: 
X-Spamd-Result: default: False [-0.60 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[laoqinren.net:email,suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -0.60

On Fri 02-08-24 17:19:01, Wang Long wrote:
> In the function percpu_rwsem_release, the parameter `read`
> is unused, so remove it.
> 
> Signed-off-by: Wang Long <w@laoqinren.net>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c                   | 2 +-
>  include/linux/fs.h           | 2 +-
>  include/linux/percpu-rwsem.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 38d72a3cf6fc..216c0d2b7927 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1905,7 +1905,7 @@ static void lockdep_sb_freeze_release(struct super_block *sb)
>  	int level;
>  
>  	for (level = SB_FREEZE_LEVELS - 1; level >= 0; level--)
> -		percpu_rwsem_release(sb->s_writers.rw_sem + level, 0, _THIS_IP_);
> +		percpu_rwsem_release(sb->s_writers.rw_sem + level, _THIS_IP_);
>  }
>  
>  /*
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index fd34b5755c0b..d63809e7ea54 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1683,7 +1683,7 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
>  #define __sb_writers_acquired(sb, lev)	\
>  	percpu_rwsem_acquire(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
>  #define __sb_writers_release(sb, lev)	\
> -	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
> +	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], _THIS_IP_)
>  
>  /**
>   * __sb_write_started - check if sb freeze level is held
> diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
> index 36b942b67b7d..c012df33a9f0 100644
> --- a/include/linux/percpu-rwsem.h
> +++ b/include/linux/percpu-rwsem.h
> @@ -145,7 +145,7 @@ extern void percpu_free_rwsem(struct percpu_rw_semaphore *);
>  #define percpu_rwsem_assert_held(sem)	lockdep_assert_held(sem)
>  
>  static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
> -					bool read, unsigned long ip)
> +					unsigned long ip)
>  {
>  	lock_release(&sem->dep_map, ip);
>  }
> -- 
> 2.33.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

