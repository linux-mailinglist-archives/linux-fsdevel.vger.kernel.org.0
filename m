Return-Path: <linux-fsdevel+bounces-17241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94F28A97EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 12:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 366AD1F21259
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 10:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FFE15E81F;
	Thu, 18 Apr 2024 10:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xOkhIZ36";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+roT5dl9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xOkhIZ36";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+roT5dl9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D115ECC0
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437611; cv=none; b=WQdGRFCqeXOHL43nn9+WutuBMjG8mf62XXfypqhpRFadyQOMWkpr3p0zTf1nyBXvJgZ/oVi8Y0GeKKb2VOxDoqzlYNUy2kfSjJOqS1lujKcUi0TS13AU0jOHlgLHraouZmERgz5dtANLgg3NLyfURdrKla2X3mD9xxkOjKTekto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437611; c=relaxed/simple;
	bh=MoZbp1+a72PjeQMcLf9pbWd1zl10oUlbhefOLAknGCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nr7hcOhoHV1jwBRWXAs0OhPoc3mDKPZd5Usa0RT6j3Hf940UkhhCEmvZtVgYnMtiaAIHVBR1s1aqsEOq2lkZB2Ea4BD3eF19QbaS8bY0Uc4LQVldbZtf5zxnnCfRkYN9vWIaHfDqBAoRI2acMmrmJbxdOMeW6b5W0rjCAEy6s1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xOkhIZ36; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+roT5dl9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xOkhIZ36; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+roT5dl9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDE6C34DA1;
	Thu, 18 Apr 2024 10:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713437607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9PIP4G5YgUhOgoQWRZrr8x87XOSOTX3/v5RWPJtuLC0=;
	b=xOkhIZ36ibQjVIrZ9VWXPBk4LnPQWzNu/aXhfwgByW8Yw2G0ocfsLsh9rE4rolVFOwzTg+
	CbJu7c+8Zk2rBLbn0IW52NUPRfa7Q80ctK4XMk+WKMYwFPqpmGnPIN/rFUKNScV5ydpOYB
	iwysbUW2JCfSHii5qUXARU6cmiUqalo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713437607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9PIP4G5YgUhOgoQWRZrr8x87XOSOTX3/v5RWPJtuLC0=;
	b=+roT5dl91450cqcE+LEMgpItJ769jd+vY0awbw0AWxs8N2mAR16sNAtSL+J1gYVIoD87mX
	rxYYn2g2EYDmJeAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713437607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9PIP4G5YgUhOgoQWRZrr8x87XOSOTX3/v5RWPJtuLC0=;
	b=xOkhIZ36ibQjVIrZ9VWXPBk4LnPQWzNu/aXhfwgByW8Yw2G0ocfsLsh9rE4rolVFOwzTg+
	CbJu7c+8Zk2rBLbn0IW52NUPRfa7Q80ctK4XMk+WKMYwFPqpmGnPIN/rFUKNScV5ydpOYB
	iwysbUW2JCfSHii5qUXARU6cmiUqalo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713437607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9PIP4G5YgUhOgoQWRZrr8x87XOSOTX3/v5RWPJtuLC0=;
	b=+roT5dl91450cqcE+LEMgpItJ769jd+vY0awbw0AWxs8N2mAR16sNAtSL+J1gYVIoD87mX
	rxYYn2g2EYDmJeAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3C351384C;
	Thu, 18 Apr 2024 10:53:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 383HL6f7IGZJVwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 18 Apr 2024 10:53:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 77320A0812; Thu, 18 Apr 2024 12:53:23 +0200 (CEST)
Date: Thu, 18 Apr 2024 12:53:23 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/7] Convert UDF to folios
Message-ID: <20240418105323.qyelkvgnzodlkwpr@quack3>
References: <20240417150416.752929-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417150416.752929-1-willy@infradead.org>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.79 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
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
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -3.79
X-Spam-Flag: NO

On Wed 17-04-24 16:04:06, Matthew Wilcox (Oracle) wrote:
> I'm not making any attempt here to support large folios.  This is just to
> remove uses of the page-based APIs.  Most of these places are for inline
> data or symlinks, so it wouldn't be appropriate to use large folios
> (unless we want to support bs>PS, which seems to be permitted by UDF,
> although not widely supported).

Thanks for the conversion. Overall it looks good and I can fixup the minor
stuff I've found on commit, just I'd like to get a confirmation regarding
the flush_dcache_folio() thing...

								Honza

> Matthew Wilcox (Oracle) (7):
>   udf: Convert udf_symlink_filler() to use a folio
>   udf: Convert udf_write_begin() to use a folio
>   udf: Convert udf_expand_file_adinicb() to use a folio
>   udf: Convert udf_adinicb_readpage() to udf_adinicb_read_folio()
>   udf: Convert udf_symlink_getattr() to use a folio
>   udf: Convert udf_page_mkwrite() to use a folio
>   udf: Use a folio in udf_write_end()
> 
>  fs/udf/file.c    | 20 +++++++--------
>  fs/udf/inode.c   | 65 ++++++++++++++++++++++++------------------------
>  fs/udf/symlink.c | 34 +++++++++----------------
>  3 files changed, 54 insertions(+), 65 deletions(-)
> 
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

