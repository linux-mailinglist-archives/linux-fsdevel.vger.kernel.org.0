Return-Path: <linux-fsdevel+bounces-23698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5830293153A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 14:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E58728157B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2024 12:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70A118EA6F;
	Mon, 15 Jul 2024 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CFgQMJo9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9/Xgu24N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CFgQMJo9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9/Xgu24N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4059B18C352
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2024 12:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721048221; cv=none; b=R4hQQsGBMt/5m5mTiMUEE3/mo82mQuX5utZhoaxbg71Ur28VTTi/Ahs/hx5C5zowwsk3rWYJ88irfYMF+VUI2OHf84UkkgtEMdcmySoMpbuSnNMsgZtDsYzwfA0fVFcE7Fkrd2hB15ffYFBiLbKWCQhNJklYhimVmhwg4XVAHGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721048221; c=relaxed/simple;
	bh=EWIMfb5jjTq+9utlQBFfY0TPDorJ7s3rYHJbzng9IdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNfevjNp4UwLbxri3snuyn6rMBj3rOTE6tehPH29zNVaKco4ahJy/fhJdOWHQLYBPpUKbLAqDSoPbyMsM9vtlrJ5L78z0bFZ11vZA03UXT+EmSox0ub2q+EmLet81lz3PKz44yFtCT6j6vi1I40oGQRERpV6D2ahkHnCBRkSMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CFgQMJo9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9/Xgu24N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CFgQMJo9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9/Xgu24N; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 63E8C1F7F1;
	Mon, 15 Jul 2024 12:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721048217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YWfVGf2wzvsCfbQ13sbggXZ7hg6b5kf5YfjPqph/MGA=;
	b=CFgQMJo9oP9mFEbOMOV5OE2WD/vpVa+pBH1kYQqAGrAXn2lxvPslvUnNtQF62D3rJ7+AWw
	3tPoAl/l5tlZU+Aa0zv2MLAGkFC4poYBclqU3Dq+qxQ3VdNHBDVHqbQaOJdqRIFiQwhYKB
	dMKexAqOcukc85VMcOB82B6HQQaijto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721048217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YWfVGf2wzvsCfbQ13sbggXZ7hg6b5kf5YfjPqph/MGA=;
	b=9/Xgu24Nolxsz+KIza0THSSwg3tJ20ikPxHqNvGfbCNURZcNwPsIjv88k5H5aZP3OaOoYJ
	1PmSKOu4LDe44kCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721048217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YWfVGf2wzvsCfbQ13sbggXZ7hg6b5kf5YfjPqph/MGA=;
	b=CFgQMJo9oP9mFEbOMOV5OE2WD/vpVa+pBH1kYQqAGrAXn2lxvPslvUnNtQF62D3rJ7+AWw
	3tPoAl/l5tlZU+Aa0zv2MLAGkFC4poYBclqU3Dq+qxQ3VdNHBDVHqbQaOJdqRIFiQwhYKB
	dMKexAqOcukc85VMcOB82B6HQQaijto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721048217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YWfVGf2wzvsCfbQ13sbggXZ7hg6b5kf5YfjPqph/MGA=;
	b=9/Xgu24Nolxsz+KIza0THSSwg3tJ20ikPxHqNvGfbCNURZcNwPsIjv88k5H5aZP3OaOoYJ
	1PmSKOu4LDe44kCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5155B134AB;
	Mon, 15 Jul 2024 12:56:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fjeRE5kclWb6SwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 15 Jul 2024 12:56:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0ABC5A0987; Mon, 15 Jul 2024 14:56:53 +0200 (CEST)
Date: Mon, 15 Jul 2024 14:56:53 +0200
From: Jan Kara <jack@suse.cz>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
	Jan Kara <jack@suse.cz>,
	syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
Subject: Re: [PATCH] fsnotify: Avoid data race between fsnotify_recalc_mask()
 and fsnotify_object_watched()
Message-ID: <20240715125653.ys4xmbno3d7lqyer@quack3>
References: <20240715123610.27095-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715123610.27095-1-jack@suse.cz>
X-Spamd-Result: default: False [-6.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[701037856c25b143f1ad];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,suse.cz,syzkaller.appspotmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -6.30
X-Spam-Level: 

On Mon 15-07-24 14:36:10, Jan Kara wrote:
> When __fsnotify_recalc_mask() recomputes the mask on the watched object,
> the compiler can "optimize" the code to perform partial updates to the
> mask (including zeroing it at the beginning). Thus places checking
> the object mask without conn->lock such as fsnotify_object_watched()
> could see invalid states of the mask. Make sure the mask update is
> performed by one memory store using WRITE_ONCE().
> 
> Reported-by: syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://lore.kernel.org/all/CACT4Y+Zk0ohwwwHSD63U2-PQ=UuamXczr1mKBD6xtj2dyYKBvA@mail.gmail.com
> Signed-off-by: Jan Kara <jack@suse.cz>

Apparently my brain is still in vacation mode and although this will
probably be good enough to stop the data race from happening, it will not
be probably good enough for KCSAN as WRITE_ONCE() should better be paired
with READ_ONCE(). I'll send v2.

								Honza

> ---
>  fs/notify/mark.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> I plan to merge this fix through my tree.
> 
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index c3eefa70633c..74a8a8ed42ff 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -245,7 +245,11 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>  		    !(mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
>  			want_iref = true;
>  	}
> -	*fsnotify_conn_mask_p(conn) = new_mask;
> +	/*
> +	 * We use WRITE_ONCE() to prevent silly compiler optimizations from
> +	 * confusing readers not holding conn->lock with partial updates.
> +	 */
> +	WRITE_ONCE(*fsnotify_conn_mask_p(conn), new_mask);
>  
>  	return fsnotify_update_iref(conn, want_iref);
>  }
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

