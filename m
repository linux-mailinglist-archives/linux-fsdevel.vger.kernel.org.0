Return-Path: <linux-fsdevel+bounces-27792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CE0964103
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBC971F23136
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3AC18E34D;
	Thu, 29 Aug 2024 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cu6b4CGk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EiXRhKlb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IVOFurtJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="P2eZQo1X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4948B15FA93;
	Thu, 29 Aug 2024 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926413; cv=none; b=WeyyZoul4z5fWVZGrZT/h43ibe+J5RyP+HdpCCSNGTrajDW0Cw+d2oxz0AryFKSIZpuel2Nawpvt+U9fic3mdNG7KfXJyMXTuenYn0cVstAAK447K3AZtCoyhqk9Tsg8UoqSQ6hShbgXhSyCOuiy1OIHawzoPEMsBnzteQxyS6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926413; c=relaxed/simple;
	bh=ij8F03JTbxpCN1aNxCZRXXFALiaRJUYBVCod53CD064=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3+twMBQ3pEfXT7AZRqmDKoqhOeYccPtuCDqXsC1wNWOQjbIkfMwH6sopcv+uDc4JwQQJX84/K5MH6TKK+6Zdt4y2dRAfKXTyWvYZ3e2hC7TtTvXvuEdc/fVjulYEhcXwwjK47ChJU2DTIE/hj/IBg1/o4ioQOVFrrY2fw2bO+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cu6b4CGk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EiXRhKlb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IVOFurtJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=P2eZQo1X; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8643A21BC0;
	Thu, 29 Aug 2024 10:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724926409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A5QvPK4aT73dpyW2LhWF8Vjybmp95Gd9EsVVIvVHWbQ=;
	b=Cu6b4CGkAcInRXZM2roANTnQcG+LLHiqX2cNSwJT5QXZNGYUvvf4hYxElnUcJe1NYftKj+
	RineeeS28gH+kqH3FoLtsNM2/CunbWFQe+YMI44VnFbcGlHU/2gY1ga8acFbmy8PjoWF5w
	adMuhKIRztS/DRxwZwVHWigkH7KqFUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724926409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A5QvPK4aT73dpyW2LhWF8Vjybmp95Gd9EsVVIvVHWbQ=;
	b=EiXRhKlbnshSnaPzeuFnsItIZaudLNhghlYepqyX7gRV3Ie0feA7Ei9VMXmsV4fYAUyawN
	5MOBc5glWICu0LBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724926408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A5QvPK4aT73dpyW2LhWF8Vjybmp95Gd9EsVVIvVHWbQ=;
	b=IVOFurtJnoU0Q2KyoSZ6OC3MtN2XXWWsqOkJnPxJ0kvZ2BuLqPDerc1RSMzPFs4H6ycaoY
	KwiFbUdQDFJVcQJsEb46H7ABzF+Li2wYXWy7Hbg7R6jajpdu3BFLYzF8cx/+/QkynGHI8k
	FweBeDw685ef7zZvp8pe62aoSTVbwF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724926408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A5QvPK4aT73dpyW2LhWF8Vjybmp95Gd9EsVVIvVHWbQ=;
	b=P2eZQo1XIasLHdjqQlziXDm+gpyLzRqZU5a6m3O1LfP74+ZTwVpDh93m/IGdGkybtuo39n
	TTrPlnv93+GPMUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C03C13408;
	Thu, 29 Aug 2024 10:13:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qhxCHshJ0GZAAQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 10:13:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D163CA0965; Thu, 29 Aug 2024 12:13:23 +0200 (CEST)
Date: Thu, 29 Aug 2024 12:13:23 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v4 08/16] fanotify: report file range info with
 pre-content events
Message-ID: <20240829101323.coocz3kuscxtbsj4@quack3>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <b72ac7d8171570eaa9adf05e5a55f6ea8ba41ac2.1723670362.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b72ac7d8171570eaa9adf05e5a55f6ea8ba41ac2.1723670362.git.josef@toxicpanda.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
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
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 14-08-24 17:25:26, Josef Bacik wrote:
> From: Amir Goldstein <amir73il@gmail.com>
> 
> With group class FAN_CLASS_PRE_CONTENT, report offset and length info
> along with FAN_PRE_ACCESS and FAN_PRE_MODIFY permission events.
> 
> This information is meant to be used by hierarchical storage managers
> that want to fill partial content of files on first access to range.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

...

> @@ -191,6 +192,12 @@ struct fanotify_event_info_error {
>  	__u32 error_count;
>  };
>  
> +struct fanotify_event_info_range {
> +	struct fanotify_event_info_header hdr;

There will be 32-bits of padding here and for UAPI, I prefer to keep that
explicit by adding:

	__u32 pad;

here. I can fix it on commit...

> +	__u64 offset;
> +	__u64 count;
> +};
> +
>  /*
>   * User space may need to record additional information about its decision.
>   * The extra information type records what kind of information is included.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

