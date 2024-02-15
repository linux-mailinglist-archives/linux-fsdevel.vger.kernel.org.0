Return-Path: <linux-fsdevel+bounces-11665-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5282A855E30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 10:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8011F21035
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 09:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1DF1B800;
	Thu, 15 Feb 2024 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DeW4mmZx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1wnlXCsM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DeW4mmZx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1wnlXCsM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024917730;
	Thu, 15 Feb 2024 09:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989482; cv=none; b=mNqqHhMp2jeFnxjf5wJENNvRzsVNhL32TZ43hi4xQBedHNnPwI7e6gJx/UlNoIYOMWkUWFKmbL99Q4TGE9V0I4DJowD7MPFTZgKg2z424jU7FbmhjwzATdQ+nHjz2m5lI6LrSUsRByE0SzUkm7UqR+xSbrdMpwYMHx9IQ3nLwiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989482; c=relaxed/simple;
	bh=//IYYbdpL4OunOBLD26ICNLcZrp9kb0wNw9na3TCW3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5+R0Tn9tepkohBoW+KbBMxghIHLdjrbpHoph10MEjFHVdXtqFrkfkT7MObwdBfn+hEpR4PeGME6EI+z0ys7tDspbXfCrSttPUawUbTyr3rJBvfMrwSFjaFJmnz1jkIsv5BPepZj3DB0gn+EZNPz3zL9oMfDxLW/nnl/TR/6nW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DeW4mmZx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1wnlXCsM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DeW4mmZx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1wnlXCsM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6351421F86;
	Thu, 15 Feb 2024 09:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707989479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJ2RIRbHuDlNpht/wlEMXLnwxWumvhJ/wdRsLs0UrL8=;
	b=DeW4mmZx4HnTja/ymavqoKDrOaQqrC4tu/qZ97aClfsrUSIcBS3S1AxiG75s5jgYJkHRNp
	jCpUKpnV9eWDEwlE0Yoorp0aWlApy7Z5UXTBgGTxJje9G1USQJxPCVnXOzuglNNRmVxQ6E
	ETCRPcWDXVpuVyx58jkF49DgiXgFmY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707989479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJ2RIRbHuDlNpht/wlEMXLnwxWumvhJ/wdRsLs0UrL8=;
	b=1wnlXCsMiq2FXMU0Evi59wWmLyM8qsADTkLmSCUGY3jFMOHzJXN659NqKocPediwGzriBz
	tPEKXvatjxDp9RBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707989479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJ2RIRbHuDlNpht/wlEMXLnwxWumvhJ/wdRsLs0UrL8=;
	b=DeW4mmZx4HnTja/ymavqoKDrOaQqrC4tu/qZ97aClfsrUSIcBS3S1AxiG75s5jgYJkHRNp
	jCpUKpnV9eWDEwlE0Yoorp0aWlApy7Z5UXTBgGTxJje9G1USQJxPCVnXOzuglNNRmVxQ6E
	ETCRPcWDXVpuVyx58jkF49DgiXgFmY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707989479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJ2RIRbHuDlNpht/wlEMXLnwxWumvhJ/wdRsLs0UrL8=;
	b=1wnlXCsMiq2FXMU0Evi59wWmLyM8qsADTkLmSCUGY3jFMOHzJXN659NqKocPediwGzriBz
	tPEKXvatjxDp9RBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5916A139EF;
	Thu, 15 Feb 2024 09:31:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id dM24FefZzWXtZwAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 15 Feb 2024 09:31:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0D39DA0809; Thu, 15 Feb 2024 10:31:15 +0100 (CET)
Date: Thu, 15 Feb 2024 10:31:15 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] writeback: don't call mapping_set_error on
 AOP_WRITEPAGE_ACTIVATE
Message-ID: <20240215093115.ad6ouwphhbbcwq73@quack3>
References: <20240215063649.2164017-1-hch@lst.de>
 <20240215063649.2164017-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215063649.2164017-2-hch@lst.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.39 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[51.42%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.39

On Thu 15-02-24 07:36:36, Christoph Hellwig wrote:
> mapping_set_error should only be called on 0 returns (which it ignores)
> or a negative error code.
> 
> writepage_cb ends up being able to call writepage_cb on the magic
> AOP_WRITEPAGE_ACTIVATE return value from ->writepage which means
> success but the caller needs to unlock the page.  Ignore that and
> just call mapping_set_error on negative errors.
> 
> (no fixes tag as this goes back more than 20 years over various renames
>  and refactors so I've given up chasing down the original introduction)
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 3f255534986a2f..703e83c69ffe08 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2535,7 +2535,9 @@ static int writepage_cb(struct folio *folio, struct writeback_control *wbc,
>  {
>  	struct address_space *mapping = data;
>  	int ret = mapping->a_ops->writepage(&folio->page, wbc);
> -	mapping_set_error(mapping, ret);
> +
> +	if (ret < 0)
> +		mapping_set_error(mapping, ret);
>  	return ret;
>  }
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

