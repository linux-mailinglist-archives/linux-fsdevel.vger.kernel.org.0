Return-Path: <linux-fsdevel+bounces-45949-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3CDA7FC99
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DF119E0575
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51A1267B99;
	Tue,  8 Apr 2025 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PwIcb/iH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wSi2WvPf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PwIcb/iH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wSi2WvPf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E87F26738A
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108796; cv=none; b=ma19sK+3A9wyfFpzrDP6kbBxwDC4AJHy9JG0r76qTTZmQm5DDMSDn+n1Vbv+9LoTiPNeBhW4OMhdV+9VN3y0dptjrWOT8Z0av9IVwL0+PHTz7D2WoNZNzu2TNzdZloV3oCvOwRuIG0ZnnYZOzO7gljspivDt/200JzVgJeNwcRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108796; c=relaxed/simple;
	bh=WVA4MPIQJhEssJzTsJTk2+UnoVJTaUrnUwN8ABmgA+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzwefV0+UcH5cX+uUEJQSDbM7c+7Bcolseqd+KC94cVXG8swpCXvMjrxzkS2787u9sHFneQEsqiLajwCvxdBWMVvT4p9ERettufmvfMYuRZuPXqIjM3X6dEKC+KdKc8EzCM/8ok4ITWaNZh47PDtzh3+l6/Q/sRTr00pUB6NKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PwIcb/iH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wSi2WvPf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PwIcb/iH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wSi2WvPf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BAFCB21185;
	Tue,  8 Apr 2025 10:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744108792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zU5/w2QWN/1fvqB3YV1G99E2WQUMsP30QTD81AV/x90=;
	b=PwIcb/iH/7IQUk1/bKaF23HJtqcFvHGsy4f5bwMMs/tq6tXO6DsiA2UysdcS5wd/tTcNYP
	PO77TLLI0g7kce5mRCZKSI/sdlG1cSjnm8jACl0C8vb4LfFkWgnQX1+Y2qhHTC0RI538d0
	I1kXVEKOecnDn2B57q1NimfyCHArjkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744108792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zU5/w2QWN/1fvqB3YV1G99E2WQUMsP30QTD81AV/x90=;
	b=wSi2WvPfIRCGzIpleqINSVL7779sMm8p+HvBQr5H5TTh8OFzEHTcU23AvFQe8G5lVcvyZb
	yKh/p5cqsJuiUGCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744108792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zU5/w2QWN/1fvqB3YV1G99E2WQUMsP30QTD81AV/x90=;
	b=PwIcb/iH/7IQUk1/bKaF23HJtqcFvHGsy4f5bwMMs/tq6tXO6DsiA2UysdcS5wd/tTcNYP
	PO77TLLI0g7kce5mRCZKSI/sdlG1cSjnm8jACl0C8vb4LfFkWgnQX1+Y2qhHTC0RI538d0
	I1kXVEKOecnDn2B57q1NimfyCHArjkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744108792;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zU5/w2QWN/1fvqB3YV1G99E2WQUMsP30QTD81AV/x90=;
	b=wSi2WvPfIRCGzIpleqINSVL7779sMm8p+HvBQr5H5TTh8OFzEHTcU23AvFQe8G5lVcvyZb
	yKh/p5cqsJuiUGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADAE413691;
	Tue,  8 Apr 2025 10:39:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vl9hKvj89GelegAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Apr 2025 10:39:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 624C8A098A; Tue,  8 Apr 2025 12:39:52 +0200 (CEST)
Date: Tue, 8 Apr 2025 12:39:52 +0200
From: Jan Kara <jack@suse.cz>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Jan Kara <jack@suse.cz>, Andreas Gruenbacher <agruenba@redhat.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Carlos Maiolino <cem@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: Recent changes mean sb_min_blocksize() can now fail
Message-ID: <ormbk7uxe7v4givkz6ylo46aacfbrcy5zbasmti5tsqcirgijs@ulgt66vb2wbg>
References: <86290c9b-ba40-4ebd-96c1-d3a258abe9d4@squashfs.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86290c9b-ba40-4ebd-96c1-d3a258abe9d4@squashfs.org.uk>
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

Hi!

On Tue 08-04-25 06:33:53, Phillip Lougher wrote:
> A recent (post 6.14) change to the kernel means sb_min_blocksize() can now fail,
> and any filesystem which doesn't check the result may behave unexpectedly as a
> result.  This change has recently affected Squashfs, and checking the kernel code,
> a number of other filesystems including isofs, gfs2, exfat, fat and xfs do not
> check the result.  This is a courtesy email to warn others of this change.
> 
> The following emails give the relevant details.
> 
> https://lore.kernel.org/all/2a13ea1c-08df-4807-83d4-241831b7a2ec@squashfs.org.uk/
> https://lore.kernel.org/all/129d4f39-6922-44e9-8b1c-6455ee564dda@squashfs.org.uk/

Indeed. Thanks for the heads up!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

