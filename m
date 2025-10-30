Return-Path: <linux-fsdevel+bounces-66443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B688C1F532
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 10:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4ADB34D8EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 09:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C11341661;
	Thu, 30 Oct 2025 09:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PF9eMXTf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="17KHT2Y0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PF9eMXTf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="17KHT2Y0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E782BAF7
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761816918; cv=none; b=ArnbDu/uXQqNOLBETw029J5+ybZ7X+zsaNhrXreY38zokomIJv0giZry8KEb01kXOAuXQvHJXE+WIyHxRaMnNqgXBvMHa3uYniItvtshJUE7aRlIE6W2Ng8d8+gH2qkYB4+MzyrPuTU3W4XZ7uE7TEBDd06a1PcV4M4nPAiv5Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761816918; c=relaxed/simple;
	bh=FG1KBd3+7a1WDBggi+IRAdbBFJtZf+UXFMChBnIFUFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxFhKiyMXJp1mu7Lf+qanA5Sget8RPKKPVXQ1gQrftalszH8oXHePHXQyC05bMLAIadBvY/zAGQHc9Wtx2/sR0ZeqAhWHLyoshoBdC1i0PA9jSnEXsy2+gfrBLTxSWHeKk171r+BVRUQCfyYKhfdpx259LJ2jGQ5oMGNMt79Sio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PF9eMXTf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=17KHT2Y0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PF9eMXTf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=17KHT2Y0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C105A3384F;
	Thu, 30 Oct 2025 09:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761816914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ssp6Kii1wkuTyB4BGoy9CUQMXMsX8y4VG4gQSEzTu4s=;
	b=PF9eMXTfOhOQIKShddjJg4fHf/qU3r9+MlCZZeWE37Gqk5BWGHvAIxdlkQZGbMvC+Ovq5y
	EgCs0r4qXsMvywqJ3yeQtg7mlnSGmp/wkvAEy1oe1b+KttbZK6iSJz0XyOuMZreomLLWQF
	w/1C7r9940uEZM1w2HbBDXlMtNilMLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761816914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ssp6Kii1wkuTyB4BGoy9CUQMXMsX8y4VG4gQSEzTu4s=;
	b=17KHT2Y0B3vULWUBZo3Omxg8H/KqEUiuX6BUuzeQiIDIHkJf1g7YflVcXs1JC3P0heqPGI
	o+pZCFczzblquLDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761816914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ssp6Kii1wkuTyB4BGoy9CUQMXMsX8y4VG4gQSEzTu4s=;
	b=PF9eMXTfOhOQIKShddjJg4fHf/qU3r9+MlCZZeWE37Gqk5BWGHvAIxdlkQZGbMvC+Ovq5y
	EgCs0r4qXsMvywqJ3yeQtg7mlnSGmp/wkvAEy1oe1b+KttbZK6iSJz0XyOuMZreomLLWQF
	w/1C7r9940uEZM1w2HbBDXlMtNilMLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761816914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ssp6Kii1wkuTyB4BGoy9CUQMXMsX8y4VG4gQSEzTu4s=;
	b=17KHT2Y0B3vULWUBZo3Omxg8H/KqEUiuX6BUuzeQiIDIHkJf1g7YflVcXs1JC3P0heqPGI
	o+pZCFczzblquLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFB0D1396A;
	Thu, 30 Oct 2025 09:35:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kkGXKlIxA2kfeQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Oct 2025 09:35:14 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5FDF6A0AD6; Thu, 30 Oct 2025 10:35:10 +0100 (CET)
Date: Thu, 30 Oct 2025 10:35:10 +0100
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 03/10] buffer: Use folio_next_pos()
Message-ID: <vetw2d2lns7ggrgnyfmpctdhva4vandhpp5or5ulw2dkribcqv@etqv2orxnphe>
References: <20251024170822.1427218-1-willy@infradead.org>
 <20251024170822.1427218-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024170822.1427218-4-willy@infradead.org>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,infradead.org:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri 24-10-25 18:08:11, Matthew Wilcox (Oracle) wrote:
> This is one instruction more efficient than open-coding folio_pos() +
> folio_size().  It's the equivalent of (x + y) << z rather than
> x << z + y << z.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Jan Kara <jack@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 6a8752f7bbed..185ceb0d6baa 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2732,7 +2732,7 @@ int block_write_full_folio(struct folio *folio, struct writeback_control *wbc,
>  	loff_t i_size = i_size_read(inode);
>  
>  	/* Is the folio fully inside i_size? */
> -	if (folio_pos(folio) + folio_size(folio) <= i_size)
> +	if (folio_next_pos(folio) <= i_size)
>  		return __block_write_full_folio(inode, folio, get_block, wbc);
>  
>  	/* Is the folio fully outside i_size? (truncate in progress) */
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

