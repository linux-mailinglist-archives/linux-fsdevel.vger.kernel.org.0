Return-Path: <linux-fsdevel+bounces-9566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9420842EB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FF92879E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F6A78B79;
	Tue, 30 Jan 2024 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VMmDyszM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+R+8+Cbs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VMmDyszM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+R+8+Cbs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0937578B4C;
	Tue, 30 Jan 2024 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706650810; cv=none; b=U+DlSnwiq8gzgRGEwljg9sDtDyWROj9Z8Ef+Y6YJPHej2bCGfrFyAao9NAMrN8IcFsZUAshzPOQenw0fEDMuZCBARq6vVKsBcAdcsFH0OQ6RzFg9zsUqPZjvRoe+RP3O8gUi5RTY/vSrc2f2HcEMxRXEtb25+1xGdkbv2WYijkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706650810; c=relaxed/simple;
	bh=G17DxU9UC6n3OJzyReXQ58Lh4ZC68cV87WeaVPg/Dv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMKVKzdcFV/xMkRt/JlyHUfBUiM8dqEi7yZFsbOhsqPqcUtu16wp8cVGBWu2HO2UkPnjyLx+aE5rx0hGdy5wUfpl2VqlVVNsk2VSx0hkKHhjMNwTWVK4i3qqN6yAgr1Odd129b57fFWu/KgD7/LJHVNegfKPJAlsR9ExPlG5JSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VMmDyszM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+R+8+Cbs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VMmDyszM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+R+8+Cbs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 318E221FB0;
	Tue, 30 Jan 2024 21:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706650807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3uk8ksGjp+S/t97XadUwt9XprzXFLFr3a0kQ6HsH4bQ=;
	b=VMmDyszMhOgX153e8Q8P/4Y6Zu/EvHkdqibK3Wn695Pt4esQqem/mEPDAzKsaQV8wJGauw
	BYmBM28clHZNiW3pDWwBU80fJ4imkfAaRltJXUwlnsNuT2IHr1n2V72gP68noR26ykm3Bx
	5rZhB84BRj6vDXSqQisLDOHeL4yF+xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706650807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3uk8ksGjp+S/t97XadUwt9XprzXFLFr3a0kQ6HsH4bQ=;
	b=+R+8+Cbst92IRAezsU4YrXEpatYNOVUMJjIlxnw82J2D/fhIIM8m1bsjNlQsrkX7v9nE06
	ECw0o38O4LKHYVBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706650807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3uk8ksGjp+S/t97XadUwt9XprzXFLFr3a0kQ6HsH4bQ=;
	b=VMmDyszMhOgX153e8Q8P/4Y6Zu/EvHkdqibK3Wn695Pt4esQqem/mEPDAzKsaQV8wJGauw
	BYmBM28clHZNiW3pDWwBU80fJ4imkfAaRltJXUwlnsNuT2IHr1n2V72gP68noR26ykm3Bx
	5rZhB84BRj6vDXSqQisLDOHeL4yF+xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706650807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3uk8ksGjp+S/t97XadUwt9XprzXFLFr3a0kQ6HsH4bQ=;
	b=+R+8+Cbst92IRAezsU4YrXEpatYNOVUMJjIlxnw82J2D/fhIIM8m1bsjNlQsrkX7v9nE06
	ECw0o38O4LKHYVBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BA5513462;
	Tue, 30 Jan 2024 21:40:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id PT9uBrdsuWWuGgAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 30 Jan 2024 21:40:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A5D09A07F9; Tue, 30 Jan 2024 22:40:06 +0100 (CET)
Date: Tue, 30 Jan 2024 22:40:06 +0100
From: Jan Kara <jack@suse.cz>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Russell King <linux@armlinux.org.uk>,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/8] ext2: Use dax_is_supported()
Message-ID: <20240130214006.qgqykoqm4c2pk4kh@quack3>
References: <20240130165255.212591-1-mathieu.desnoyers@efficios.com>
 <20240130165255.212591-4-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130165255.212591-4-mathieu.desnoyers@efficios.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[17];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,linux-foundation.org:email,linux.dev:email,intel.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

On Tue 30-01-24 11:52:50, Mathieu Desnoyers wrote:
> Use dax_is_supported() to validate whether the architecture has
> virtually aliased data caches at mount time. Print an error and disable
> DAX if dax=always is requested as a mount option on an architecture
> which does not support DAX.
> 
> This is relevant for architectures which require a dynamic check
> to validate whether they have virtually aliased data caches.
> 
> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Jan Kara <jack@suse.com>
> Cc: linux-ext4@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-arch@vger.kernel.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: nvdimm@lists.linux.dev
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org

OK, yeah, this is better than v1. Feel free to add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext2/super.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 01f9addc8b1f..30ff57d47ed4 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -955,7 +955,11 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  	blocksize = BLOCK_SIZE << le32_to_cpu(sbi->s_es->s_log_block_size);
>  
>  	if (test_opt(sb, DAX)) {
> -		if (!sbi->s_daxdev) {
> +		if (!dax_is_supported()) {
> +			ext2_msg(sb, KERN_ERR,
> +				"DAX unsupported by architecture. Turning off DAX.");
> +			clear_opt(sbi->s_mount_opt, DAX);
> +		} else if (!sbi->s_daxdev) {
>  			ext2_msg(sb, KERN_ERR,
>  				"DAX unsupported by block device. Turning off DAX.");
>  			clear_opt(sbi->s_mount_opt, DAX);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

