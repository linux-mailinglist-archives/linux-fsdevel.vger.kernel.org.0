Return-Path: <linux-fsdevel+bounces-56384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF75B1702F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 13:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 002947B1291
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Jul 2025 11:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DB22BE7C3;
	Thu, 31 Jul 2025 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U/idqGjB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uOs2klm2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sznea/cB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GcFGAaW+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71162BE646
	for <linux-fsdevel@vger.kernel.org>; Thu, 31 Jul 2025 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753960314; cv=none; b=qm3msZu08bOPxLGX3gV+i1uHM3QD6sb9CCG6ABMdE4apNWFFxKCIqllaK8rl4sc4xcq6gxbDh+7GW4ivjHwLfIyNV/vq5hf8qhL1ko/jH+xYfUNZgwlClRuDFg7pDIM7breOgQBjLrx5MYQCGrJMauJngEZm3wRhe/kiegXFnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753960314; c=relaxed/simple;
	bh=XqdT38zKkoheSOE0qMe6rcrdX01xPR+cQNuEAHnJvbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Otd/RC6bynbv8QkBTMCnste0/k60f0DANpNJB43U48r5p2mDGNW3L11nnh95XB7WtT8DyLM8+sWUC2Amn0U3cTCJF5a03LrfLghSf9Ptckhc8zvugzqjbUwvp/Da1H7KNhxa7g6E6Uy7q1sfDuBtDK4UUYNZ7Ja9P3PQnFAQhJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U/idqGjB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uOs2klm2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sznea/cB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GcFGAaW+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E62421F45A;
	Thu, 31 Jul 2025 11:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753960311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bC7FB0x391njBB/QqTinlGQnb1L1WFmu9ZyfULAa6+w=;
	b=U/idqGjB0QhBvRAJ/d0R2hHXS5H5ckbXC6itH3aDdRl4fhQ1AvUxxOFJCGlyHJtRlbT67e
	BhafGMCEhgddhOSem3taKX0XACIG1BdYR3XJEDILvWJrDVtsFYR972yoMg+5antUg+jfR0
	LWVsPKBtLSMZbT2bMo8YLWPKuJhQTMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753960311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bC7FB0x391njBB/QqTinlGQnb1L1WFmu9ZyfULAa6+w=;
	b=uOs2klm2Q0N0sRXL4a1hXbPB5Ct8XGdR9ZeIrVzpWsgUWBslPBZLmGVRWLqAfMmj9kURQh
	qz0e7xSOb4wrMECQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="sznea/cB";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GcFGAaW+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753960310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bC7FB0x391njBB/QqTinlGQnb1L1WFmu9ZyfULAa6+w=;
	b=sznea/cBGcersWNs+RtlhR9bYwiCe3Xcw037IneQcsBbMe08ZpB8n0ogM/4bHEOO8StIl1
	zrW/25PviAbQtfVVIPLvjQ4dFuV2D3a1+0U22F+a6oVDEcyBzsrJzRpFJ5L5Z5X+F3h6Rc
	H7FN1nEI7MDYFHd6vQ0qdURpUZ1jQCo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753960310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bC7FB0x391njBB/QqTinlGQnb1L1WFmu9ZyfULAa6+w=;
	b=GcFGAaW+o2SK6mRCweleohLkmDZNmYU9LF4EZbW/yaJPfCU2wvGgGIPwB3f01txLkNe1VS
	43VnBVxXycmAhRDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D83A713876;
	Thu, 31 Jul 2025 11:11:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5v+ANHZPi2hUPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 31 Jul 2025 11:11:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 65A2DA0A25; Thu, 31 Jul 2025 13:11:46 +0200 (CEST)
Date: Thu, 31 Jul 2025 13:11:46 +0200
From: Jan Kara <jack@suse.cz>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] fs: document 'name' parameter for name_contains_dotdot()
Message-ID: <oo4phoyuqa7g4d4y76rekvkwjyndgovny4u2h4tk5klzt5dsyq@3cnq5fneh23l>
References: <20250730201853.8436-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730201853.8436-1-kriish.sharma2006@gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E62421F45A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.51

On Wed 30-07-25 20:18:53, Kriish Sharma wrote:
> The kernel-doc for name_contains_dotdot() was missing the @name
> parameter description, leading to a warning during make htmldocs.
> 
> Add the missing documentation to resolve this warning.
> 
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2ec4807d4ea8..d7d311b99438 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3279,7 +3279,7 @@ static inline bool is_dot_dotdot(const char *name, size_t len)
>  
>  /**
>   * name_contains_dotdot - check if a file name contains ".." path components
> - *
> + * @name: File path string to check
>   * Search for ".." surrounded by either '/' or start/end of string.
>   */
>  static inline bool name_contains_dotdot(const char *name)
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

