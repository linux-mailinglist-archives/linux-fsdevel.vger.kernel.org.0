Return-Path: <linux-fsdevel+bounces-27794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A7B9641F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A880B213DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 10:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FB5191F77;
	Thu, 29 Aug 2024 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dyX9yxZa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3f0Grbwy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dyX9yxZa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3f0Grbwy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11B18F2C3;
	Thu, 29 Aug 2024 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724927150; cv=none; b=qTa6A0xFRl2VUdXd1l2UzueC8Xp8vfyVg2cZlaJvYPVYvmJs/C7PpDyJjVXrgGvBdZhwpW4rm6eYW5SCkd6c5xjs0rrsll2iFxajZ3bJRcE1Z0+rIYpuvKLA1Eu0MqnznjVLuLH2dVSfdtHUc4UZ26ZU8bttnL9oTBlI+lzhkes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724927150; c=relaxed/simple;
	bh=ImoKvwzRABvOksexQsib+o40UfphuSoPsexuZwdyPS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=detu7VgNBFpnRk6tD7VswotfJPrPwgrLP/2clMB+4rp9dWCj2FTg9xVAcytbGoW4m85QDyX1wx+LaQxq9ZW54t2Fd6HRlU9lt7lGgW8BQ7ntDVx3WBpNPHAVCQV0+i7agnvfE59EjwarCL9lhgzl+LdTSakMa2oY/qqe8Cc3B98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dyX9yxZa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3f0Grbwy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dyX9yxZa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3f0Grbwy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 192701FD13;
	Thu, 29 Aug 2024 10:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724927147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YaT22OrVfG57dq8NFn6T1Lr0AlETwLwNRzW9Ptpwq8=;
	b=dyX9yxZatVj/85u1ZX4/fJGBTSTW/ITgeBs6zDDtg7LjcYtP1Ncf7WlzXclU8smeb2j99q
	5VNiXK+ewDQ2l6cnWegnqbmezI/vjgnWxBxKFtSkXHr2CNrs3DC9Aai92+loBnpsmGEbQd
	1uiLVGpmMvXVchsrPsEypAIm0RzM7ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724927147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YaT22OrVfG57dq8NFn6T1Lr0AlETwLwNRzW9Ptpwq8=;
	b=3f0GrbwyqhwHIlKzmJPWExw3Rd32HHYA1NAX1GgxhmAsjhWA430VTiFQPe0mJorptuJEIT
	El8IGvvoeFeMGcCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724927147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YaT22OrVfG57dq8NFn6T1Lr0AlETwLwNRzW9Ptpwq8=;
	b=dyX9yxZatVj/85u1ZX4/fJGBTSTW/ITgeBs6zDDtg7LjcYtP1Ncf7WlzXclU8smeb2j99q
	5VNiXK+ewDQ2l6cnWegnqbmezI/vjgnWxBxKFtSkXHr2CNrs3DC9Aai92+loBnpsmGEbQd
	1uiLVGpmMvXVchsrPsEypAIm0RzM7ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724927147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2YaT22OrVfG57dq8NFn6T1Lr0AlETwLwNRzW9Ptpwq8=;
	b=3f0GrbwyqhwHIlKzmJPWExw3Rd32HHYA1NAX1GgxhmAsjhWA430VTiFQPe0mJorptuJEIT
	El8IGvvoeFeMGcCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CA27139B0;
	Thu, 29 Aug 2024 10:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id opMOA6tM0GZLBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 10:25:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B4883A0965; Thu, 29 Aug 2024 12:25:46 +0200 (CEST)
Date: Thu, 29 Aug 2024 12:25:46 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v4 09/16] fanotify: allow to set errno in FAN_DENY
 permission response
Message-ID: <20240829102546.ouke3obnq5o4nx5l@quack3>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <728fb849cd446e6b9a5b9fb9e9985c7d3bd9896a.1723670362.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <728fb849cd446e6b9a5b9fb9e9985c7d3bd9896a.1723670362.git.josef@toxicpanda.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,lists.linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 14-08-24 17:25:27, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> With FAN_DENY response, user trying to perform the filesystem operation
> gets an error with errno set to EPERM.
> 
> It is useful for hierarchical storage management (HSM) service to be able
> to deny access for reasons more diverse than EPERM, for example EAGAIN,
> if HSM could retry the operation later.
> 
> Allow fanotify groups with priority FAN_CLASSS_PRE_CONTENT to responsd
> to permission events with the response value FAN_DENY_ERRNO(errno),
> instead of FAN_DENY to return a custom error.
> 
> Limit custom error values to errors expected on read(2)/write(2) and
> open(2) of regular files. This list could be extended in the future.
> Userspace can test for legitimate values of FAN_DENY_ERRNO(errno) by
> writing a response to an fanotify group fd with a value of FAN_NOFD in
> the fd field of the response.
> 
> The change in fanotify_response is backward compatible, because errno is
> written in the high 8 bits of the 32bit response field and old kernels
> reject respose value with high bits set.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

...

> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 7f06355afa1f..d0722ef13138 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -528,3 +528,13 @@ static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
>  
>  	return mflags;
>  }
> +
> +static inline u32 fanotify_get_response_decision(u32 res)
> +{
> +	return res & (FANOTIFY_RESPONSE_ACCESS | FANOTIFY_RESPONSE_FLAGS);
> +}

I'm not convinced this helper really helps readability. Probably I'll drop
it on commit...

> +
> +static inline int fanotify_get_response_errno(int res)

'res' should be u32 here. Otherwise C compiler would do arithmetic shifting
and returned errno would be wrong. I can fix this on commit.

> +{
> +	return res >> FAN_ERRNO_SHIFT;
> +}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

