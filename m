Return-Path: <linux-fsdevel+bounces-63595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B455BC5008
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 14:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C114038EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 12:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A671F2512C8;
	Wed,  8 Oct 2025 12:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aTmMpC2v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UCu18VNL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="R/m232qK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="83qoPr/r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A461255F52
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928007; cv=none; b=SjZrMHy7QrviadWponhNpGfXcXt5b4nWhM0AmaAsLzRAcLFiWP8pDCszAB5y+fNdHf7+eM6qazBGtHAu7lIoatve4/HHodzo/YtfLJd31IrA5IyEy8uFs5cXv+c6m4L78qWF0gKQCmR9LN/46ipHhprH1yJ9n6ZEdtntvT8JLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928007; c=relaxed/simple;
	bh=jolk5sBxPv60IpiEazWwOVg3Mme1Sq2PHc8+LGnUf2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IE7L6rYG0j5h/0N7L8btadIsYISeKOjRv/kBLUIYwKg49NkOhQCjQZzVKpJVfV905YmV+22Lbott4TISVR/AtEh65dbVeAadMb5QKxo/5Aeqzlz5kiGUXrfl1om3jgX9hcTk1zftWtiVZswlnAe8zyLJ9ZwRYOZsbVz+cSSzBqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aTmMpC2v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UCu18VNL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=R/m232qK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=83qoPr/r; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E6F61FD71;
	Wed,  8 Oct 2025 12:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759928003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzniZCrvw6b1u3KIHRNwcErdevqzQ6AHeU1M43FbPEE=;
	b=aTmMpC2vtjCN8DywNjEvhhWpJHjGuJxzR5Lccjfpjpb89gvRuT8FRRblYzgXP09Y0qEUhs
	eQljvpstKPfNk38WFRnAxKNOFEvgXKpEVxiyWTIDCsvmSguMKaLEZhFOk/bF2rVZzbhUBl
	AGDjNY+iMsNX79Wykns7hXG0r9Jr1lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759928003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzniZCrvw6b1u3KIHRNwcErdevqzQ6AHeU1M43FbPEE=;
	b=UCu18VNL5+7RfKl5TqWDeaGeyJbkjlZFqWTRdhLaP8t3PrUOtyg8yQitbjgEKzOrKDabUg
	3MTVpEQVik+OAtCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759928002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzniZCrvw6b1u3KIHRNwcErdevqzQ6AHeU1M43FbPEE=;
	b=R/m232qKJ3JNvBO4b25EAZjziwXlQIx/SOB0+iC9h/gJQNafR+5vjEU4wPDZVHcfly7Tbe
	62qF8nrmeS/hhXXGbGR87rpd4ggEqd+XhdKT1niR67EsYgkgQNeRNeKn+MIt65i08pAwMP
	ZvyHmucK1Lhod2TPHqfzV0siwnzRgC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759928002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YzniZCrvw6b1u3KIHRNwcErdevqzQ6AHeU1M43FbPEE=;
	b=83qoPr/r+O0Fj4WgTzc81bfa7TqWuoXD8XhsF5Vsx9si+w3cTg6+lJfqkTqgrvtUp1loQU
	a5sVK0gAqhdzK/DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53E2513693;
	Wed,  8 Oct 2025 12:53:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9FjaE8Je5mj9RAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 08 Oct 2025 12:53:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B07EDA0A9C; Wed,  8 Oct 2025 14:53:13 +0200 (CEST)
Date: Wed, 8 Oct 2025 14:53:13 +0200
From: Jan Kara <jack@suse.cz>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, 
	yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 12/13] ext4: add large folios support for moving
 extents
Message-ID: <axefpw7kkvnto72cde4cmn7ns6elbh6xrmfqh523dgjfveej5w@nmh5nsos4xoz>
References: <20250925092610.1936929-1-yi.zhang@huaweicloud.com>
 <20250925092610.1936929-13-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925092610.1936929-13-yi.zhang@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Thu 25-09-25 17:26:08, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Pass the moving extent length into mext_folio_double_lock() so that it
> can acquire a higher-order folio if the length exceeds PAGE_SIZE. This
> can speed up extent moving when the extent is larger than one page.
> Additionally, remove the unnecessary comments from
> mext_folio_double_lock().
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

One nit below, otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -214,7 +206,8 @@ static int mext_move_begin(struct mext_data *mext, struct folio *folio[2],
>  	orig_pos = ((loff_t)mext->orig_map.m_lblk) << blkbits;
>  	donor_pos = ((loff_t)mext->donor_lblk) << blkbits;
>  	ret = mext_folio_double_lock(orig_inode, donor_inode,
> -			orig_pos >> PAGE_SHIFT, donor_pos >> PAGE_SHIFT, folio);
> +			orig_pos >> PAGE_SHIFT, donor_pos >> PAGE_SHIFT,
> +			mext->orig_map.m_len << blkbits, folio);
			^^^ This is just cosmetical but we should cast to
  size_t before the shift...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

