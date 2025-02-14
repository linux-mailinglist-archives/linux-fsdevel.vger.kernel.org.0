Return-Path: <linux-fsdevel+bounces-41714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F708A35BB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 11:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA1817A1CA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94533259487;
	Fri, 14 Feb 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zyd9oAwe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+BrWn7wC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zyd9oAwe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+BrWn7wC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F412212D67
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739529864; cv=none; b=U0dlgLFz7RGYcXaLVf9IqJYYIl+GrCRs6ZLJ1MmswEEZ2QhrFQ5ubQpbsx6KE//fouUdvot1sOM9X0j9H+kt8lHVvPMdFwaVpjBT56qC0fQ/JB2lkg9kcXSmUJqwK2uPCd2eSp63rf//ncVxLZmWrRuRNfkQM+tHV/cFNESvP5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739529864; c=relaxed/simple;
	bh=7R1jHyhQrvVo3QmUl55pIczvLWUBFMdBrtXb/zX3sew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rv5zadouGOngmGH7fyvmJyE602IBUNDR4QNBF5NM6IN+JEY0Q6xA5JOGXzcS6OPEoIkRQRYDr3oNm0Azao+BiJXccdpxiYoKgHW4wzwfB042kWjW7NBGUcnkaeOdeDNJo0ZhwUMOdpklg01V3vABF5enQrqlYuHlSbWQAjTvSyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=fail smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zyd9oAwe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+BrWn7wC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zyd9oAwe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+BrWn7wC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50032211AB;
	Fri, 14 Feb 2025 10:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739529861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SIhH9c0vSfoyJPt+JyPDQLZ6YRpy4cPjIOD5iIr1kik=;
	b=zyd9oAwetDXC9Xr2y/VEyR+2rSeul7UrNXaumpIEPusekvUE97PecItIqsbHyFdl30PrhX
	e9TZ5w0yklzXLYEyd/CEvtQflEuYwzYwLUg2XO7+wtdI6eSRJ8ZB+LJ/nMwDkVkU7fQ8mz
	qKsndig4oKb8EOmaDPahu88TqgYSJ70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739529861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SIhH9c0vSfoyJPt+JyPDQLZ6YRpy4cPjIOD5iIr1kik=;
	b=+BrWn7wC9mr9CJQ0TftocdyUCU6nV00TK5R/FM7stewAPPYHJ1KMojOfFV+In3ohjq+EpQ
	4FhJ2UX/A4wGAECQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zyd9oAwe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+BrWn7wC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739529861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SIhH9c0vSfoyJPt+JyPDQLZ6YRpy4cPjIOD5iIr1kik=;
	b=zyd9oAwetDXC9Xr2y/VEyR+2rSeul7UrNXaumpIEPusekvUE97PecItIqsbHyFdl30PrhX
	e9TZ5w0yklzXLYEyd/CEvtQflEuYwzYwLUg2XO7+wtdI6eSRJ8ZB+LJ/nMwDkVkU7fQ8mz
	qKsndig4oKb8EOmaDPahu88TqgYSJ70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739529861;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SIhH9c0vSfoyJPt+JyPDQLZ6YRpy4cPjIOD5iIr1kik=;
	b=+BrWn7wC9mr9CJQ0TftocdyUCU6nV00TK5R/FM7stewAPPYHJ1KMojOfFV+In3ohjq+EpQ
	4FhJ2UX/A4wGAECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44FE9137DB;
	Fri, 14 Feb 2025 10:44:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vevSEIUer2dnUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 14 Feb 2025 10:44:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ED48BA07B2; Fri, 14 Feb 2025 11:44:16 +0100 (CET)
Date: Fri, 14 Feb 2025 11:44:16 +0100
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] ext2: Remove reference to bh->b_page
Message-ID: <vfarqzsexo2654itlcru3ha76jx7o3byxoim4dubv3s2mswvjg@mkuljny5u73j>
References: <20250213182045.2131356-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213182045.2131356-1-willy@infradead.org>
X-Rspamd-Queue-Id: 50032211AB
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu 13-02-25 18:20:43, Matthew Wilcox (Oracle) wrote:
> Buffer heads are attached to folios, not to pages.  Also
> flush_dcache_page() is now deprecated in favour of flush_dcache_folio().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks. Added to my tree.

								Honza

> ---
>  fs/ext2/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 37f7ce56adce..21bea926e0ee 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -1556,7 +1556,7 @@ static ssize_t ext2_quota_write(struct super_block *sb, int type,
>  		}
>  		lock_buffer(bh);
>  		memcpy(bh->b_data+offset, data, tocopy);
> -		flush_dcache_page(bh->b_page);
> +		flush_dcache_folio(bh->b_folio);
>  		set_buffer_uptodate(bh);
>  		mark_buffer_dirty(bh);
>  		unlock_buffer(bh);
> -- 
> 2.47.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

