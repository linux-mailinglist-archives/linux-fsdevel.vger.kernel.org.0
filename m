Return-Path: <linux-fsdevel+bounces-16368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015A289C719
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 16:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2752845F4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 14:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAEF13A404;
	Mon,  8 Apr 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n2PEwkJo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x3AnvYBI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="n2PEwkJo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="x3AnvYBI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8161713B594;
	Mon,  8 Apr 2024 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586651; cv=none; b=NL+U8IOQMy1a0TOalLoxCjigFefTKBvHj1kdWeSrIC47qWngNOoE8QXFHQAbpVAPf2b2ddu5Q0OEjcCcxQsYTzi55I3BPNHXa8ZDAMf9aUPhqYi8ocOq1B7+NeeTX2mNMlLSmChqoMXs+pStcFa6304uHWSQ/piOM6XVWMpfxII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586651; c=relaxed/simple;
	bh=Re4ozZr4CHJHzufgoZx5yfogXY8vgcdxYpMPuHB77VI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rm4VsFmkYe/VqqOB5tZBYfIv37pvsfXHk/53d6XWzh8jAkX9+zy+Ygdq/C5Hex+MsbK/F4fiUB3TqQH2WjhAoW5jGzGpkuqcaDHcQBqPWEHirlIsTkkbJ/DA5RHvhAj5RH6oS2UdsDT/xZ4ltIvAfN0TBUK/GciOyNqR+IPDtwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n2PEwkJo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x3AnvYBI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=n2PEwkJo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=x3AnvYBI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95BD9203D1;
	Mon,  8 Apr 2024 14:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712586647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zn/qWfU1LE05R6zzlgfcSN5haYke/pTO+J4746Gv9mo=;
	b=n2PEwkJoZtm1iK07eyggjA7Kqoq15r7fKlEqTDvD/JZSOVAc6rivsnp7W2DSsHOuekfnsH
	4zgFflJPpRtYq4KwKvBE6p7xnL0O3w86+/l/wwY9KPkS2CBXcM/k6qPgON1qSe5LuTZNCC
	ilg2lTg/qpC2dKhOIxmjxrB4dkrRfmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712586647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zn/qWfU1LE05R6zzlgfcSN5haYke/pTO+J4746Gv9mo=;
	b=x3AnvYBIROEdOj1Us8VkbtucD98rhb5N3jcwpGYuI2OrqLs0kXEJKxeVmuV7IuZ98ekVZw
	84xOclvqxuf1TECg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712586647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zn/qWfU1LE05R6zzlgfcSN5haYke/pTO+J4746Gv9mo=;
	b=n2PEwkJoZtm1iK07eyggjA7Kqoq15r7fKlEqTDvD/JZSOVAc6rivsnp7W2DSsHOuekfnsH
	4zgFflJPpRtYq4KwKvBE6p7xnL0O3w86+/l/wwY9KPkS2CBXcM/k6qPgON1qSe5LuTZNCC
	ilg2lTg/qpC2dKhOIxmjxrB4dkrRfmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712586647;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zn/qWfU1LE05R6zzlgfcSN5haYke/pTO+J4746Gv9mo=;
	b=x3AnvYBIROEdOj1Us8VkbtucD98rhb5N3jcwpGYuI2OrqLs0kXEJKxeVmuV7IuZ98ekVZw
	84xOclvqxuf1TECg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A2B91332F;
	Mon,  8 Apr 2024 14:30:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id h3S0IZf/E2Y8cAAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 08 Apr 2024 14:30:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2CB4AA0814; Mon,  8 Apr 2024 16:30:43 +0200 (CEST)
Date: Mon, 8 Apr 2024 16:30:43 +0200
From: Jan Kara <jack@suse.cz>
To: Chao Yu <chao@kernel.org>
Cc: jack@suse.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] quota: don't let mark_dquot_dirty() fail silently
Message-ID: <20240408143043.65yowy2yvf46weab@quack3>
References: <20240407073128.3489785-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240407073128.3489785-1-chao@kernel.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.77 / 50.00];
	BAYES_HAM(-2.97)[99.86%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Score: -3.77
X-Spam-Flag: NO

On Sun 07-04-24 15:31:28, Chao Yu wrote:
> mark_dquot_dirty() will callback to specified filesystem function,
> it may fail due to any reasons, however, no caller will check return
> value of mark_dquot_dirty(), so, it may fail silently, let's print
> one line message for such case.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/quota/dquot.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index dacbee455c03..c5df7863942a 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -399,21 +399,20 @@ int dquot_mark_dquot_dirty(struct dquot *dquot)
>  EXPORT_SYMBOL(dquot_mark_dquot_dirty);
>  
>  /* Dirtify all the dquots - this can block when journalling */
> -static inline int mark_all_dquot_dirty(struct dquot __rcu * const *dquots)
> +static inline void mark_all_dquot_dirty(struct dquot __rcu * const *dquots)
>  {
> -	int ret, err, cnt;
> +	int ret, cnt;
>  	struct dquot *dquot;
>  
> -	ret = err = 0;
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
>  		dquot = srcu_dereference(dquots[cnt], &dquot_srcu);
> -		if (dquot)
> -			/* Even in case of error we have to continue */
> -			ret = mark_dquot_dirty(dquot);
> -		if (!err)
> -			err = ret;
> +		if (!dquot)
> +			continue;
> +		ret = mark_dquot_dirty(dquot);
> +		if (ret < 0)
> +			quota_error(dquot->dq_sb,
> +				"mark_all_dquot_dirty fails, ret: %d", ret);

Do you have any practical case you care about? Because in practice the
filesystem will usually report if there's some catastrophic error (and the
errors from ->mark_dirty() all mean the filesystem is in unhealthy state).
So this message just adds to the noise in the error log - and e.g. if the
disk goes bad so we cannot write, we could spew a lot of messages like
this.

>  	}
> -	return err;
>  }
>  
>  static inline void dqput_all(struct dquot **dquot)
> @@ -2725,6 +2724,7 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
>  {
>  	struct mem_dqblk *dm = &dquot->dq_dqb;
>  	int check_blim = 0, check_ilim = 0;
> +	int ret;
>  	struct mem_dqinfo *dqi = &sb_dqopt(dquot->dq_sb)->info[dquot->dq_id.type];
>  
>  	if (di->d_fieldmask & ~VFS_QC_MASK)
> @@ -2807,7 +2807,10 @@ static int do_set_dqblk(struct dquot *dquot, struct qc_dqblk *di)
>  	else
>  		set_bit(DQ_FAKE_B, &dquot->dq_flags);
>  	spin_unlock(&dquot->dq_dqb_lock);
> -	mark_dquot_dirty(dquot);
> +	ret = mark_dquot_dirty(dquot);
> +	if (ret < 0)
> +		quota_error(dquot->dq_sb,
> +			"mark_dquot_dirty fails, ret: %d", ret);

Here, we can propagate the error back to userspace, which is probably
better than spamming the logs.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

