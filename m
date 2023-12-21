Return-Path: <linux-fsdevel+bounces-6662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F58B81B48E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 12:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13001C23877
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Dec 2023 11:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793D96AB9A;
	Thu, 21 Dec 2023 11:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KOX9jgSm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a5SMVjtV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KOX9jgSm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a5SMVjtV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598126A02D;
	Thu, 21 Dec 2023 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E4B91FB42;
	Thu, 21 Dec 2023 10:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703156397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npajW/mlWHrdK3reJzYC8iKJhiyMeovPiW3SxiW3PpU=;
	b=KOX9jgSmKdCXnbQ05qeZeEyD/jTUeiSMMXmb78ldAvYlyvqNxabY3TB6ALwaCCgEyDa3n8
	EQBTpLoWyijBPOZDfC7W01R28BIHiyE+Ib/rJ+U27Bc44UXCjZagaGjB0rz+mDtleJUkuA
	MTvZYEbT7KizaGn9vezvjOCPie+ZLSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703156397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npajW/mlWHrdK3reJzYC8iKJhiyMeovPiW3SxiW3PpU=;
	b=a5SMVjtV5OgcuJnDegg+TTnF73BGoJXfTmVoKqFOhRO7o8ahluGCw/YOn/2FC3YHdka5M8
	jkBuR0SECJwCKcAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1703156397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npajW/mlWHrdK3reJzYC8iKJhiyMeovPiW3SxiW3PpU=;
	b=KOX9jgSmKdCXnbQ05qeZeEyD/jTUeiSMMXmb78ldAvYlyvqNxabY3TB6ALwaCCgEyDa3n8
	EQBTpLoWyijBPOZDfC7W01R28BIHiyE+Ib/rJ+U27Bc44UXCjZagaGjB0rz+mDtleJUkuA
	MTvZYEbT7KizaGn9vezvjOCPie+ZLSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1703156397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=npajW/mlWHrdK3reJzYC8iKJhiyMeovPiW3SxiW3PpU=;
	b=a5SMVjtV5OgcuJnDegg+TTnF73BGoJXfTmVoKqFOhRO7o8ahluGCw/YOn/2FC3YHdka5M8
	jkBuR0SECJwCKcAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 59D5213725;
	Thu, 21 Dec 2023 10:59:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GXLsFa0ahGVRUQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Dec 2023 10:59:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 22EBAA07E3; Thu, 21 Dec 2023 11:59:57 +0100 (CET)
Date: Thu, 21 Dec 2023 11:59:57 +0100
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/17] writeback: remove a duplicate prototype for
 tag_pages_for_writeback
Message-ID: <20231221105957.havwaqt4ijlu6l65@quack3>
References: <20231218153553.807799-1-hch@lst.de>
 <20231218153553.807799-6-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153553.807799-6-hch@lst.de>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.com:email,infradead.org:email,suse.cz:email];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[28.53%]
X-Spam-Flag: NO

On Mon 18-12-23 16:35:41, Christoph Hellwig wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> [hch: split from a larger patch]
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/writeback.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index 083387c00f0c8b..833ec38fc3e0c9 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -364,8 +364,6 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb);
>  typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
>  				void *data);
>  
> -void tag_pages_for_writeback(struct address_space *mapping,
> -			     pgoff_t start, pgoff_t end);
>  int write_cache_pages(struct address_space *mapping,
>  		      struct writeback_control *wbc, writepage_t writepage,
>  		      void *data);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

