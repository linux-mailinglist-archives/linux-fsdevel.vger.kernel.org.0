Return-Path: <linux-fsdevel+bounces-52050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A20ADF16D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 17:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2717E1896D49
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 15:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64A12EBDEB;
	Wed, 18 Jun 2025 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z6lA4HUe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LTHX0T3+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z6lA4HUe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LTHX0T3+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C305F42049
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260694; cv=none; b=LpqVKfkrp3v+nh9I4mRAItnBqaiK14tQE53ps7nnSdiGK+SNt9Fl9W9x+ZzExlmt5uAEWPvL/vuA+I+D2rOJ4NfDFUnzOZ8j/8LaXzHLloBi5DiqcLiUX/TySpy4ZCW7DgbOLzZQ31MpNTW7AYwqeBl0zC1P+dxOqch2iKZif+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260694; c=relaxed/simple;
	bh=aWGF2JbuOH4++9EpJGoeAzXMpX7P3SqWckIH/4SBNkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcieCM/uM1JEIQEgtMXxkwgJfrodkgpqRD+yweozHWL0283MmDFhoww0hitksW7IMv063cfvQ9dO1fcA6V80XOcWHNFJsbVAZigxjuBKUNKkPAGN8FtyztF7GLews3N7Ff9q9FpPKPmczYxxMPs6NKAW8F/vFsID+LwF5dEWTZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z6lA4HUe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LTHX0T3+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z6lA4HUe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LTHX0T3+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 332891F7BD;
	Wed, 18 Jun 2025 15:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750260691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owjkAWQ3KYXsX+IefJJA+Ziv2qfJ85C6X7WRXhmfYKQ=;
	b=z6lA4HUemsyrQw0IbqDayHnqZjeult3eFtaeY3eLf+oBuEaQDPw6IOYz734scHqJtOyeXi
	0ohy4FOQK1XEFTVZgLzZ2VEvRshkW546ji6YOmSju+r7lAWWipPwRSkW5hA/sdO8czyhh8
	IvQiKV68dbALYwg6U7m+verk60cUJ44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750260691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owjkAWQ3KYXsX+IefJJA+Ziv2qfJ85C6X7WRXhmfYKQ=;
	b=LTHX0T3+QHDosod7b6W0OS7VWeFSlSlTSO+bx3ylHy6HDjET9NK6BOSGpbjK0iE7NpGTaB
	CAhY8mZsoL7lanAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750260691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owjkAWQ3KYXsX+IefJJA+Ziv2qfJ85C6X7WRXhmfYKQ=;
	b=z6lA4HUemsyrQw0IbqDayHnqZjeult3eFtaeY3eLf+oBuEaQDPw6IOYz734scHqJtOyeXi
	0ohy4FOQK1XEFTVZgLzZ2VEvRshkW546ji6YOmSju+r7lAWWipPwRSkW5hA/sdO8czyhh8
	IvQiKV68dbALYwg6U7m+verk60cUJ44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750260691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owjkAWQ3KYXsX+IefJJA+Ziv2qfJ85C6X7WRXhmfYKQ=;
	b=LTHX0T3+QHDosod7b6W0OS7VWeFSlSlTSO+bx3ylHy6HDjET9NK6BOSGpbjK0iE7NpGTaB
	CAhY8mZsoL7lanAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 298F813A3F;
	Wed, 18 Jun 2025 15:31:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K04cCtPbUmirEwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Jun 2025 15:31:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A49C9A09DC; Wed, 18 Jun 2025 17:31:30 +0200 (CEST)
Date: Wed, 18 Jun 2025 17:31:30 +0200
From: Jan Kara <jack@suse.cz>
To: RubenKelevra <rubenkelevra@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs_context: fix parameter name in infofc() macro
Message-ID: <w2mvyptwkgmtpz5whnv4svsqkrmsepxrhug5fcfpdcvozbzilb@goimb6s56trb>
References: <20250617230927.1790401-1-rubenkelevra@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250617230927.1790401-1-rubenkelevra@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Wed 18-06-25 01:09:27, RubenKelevra wrote:
> The macro takes a parameter called "p" but references "fc" internally.
> This happens to compile as long as callers pass a variable named fc,
> but breaks otherwise. Rename the first parameter to “fc” to match the
> usage and to be consistent with warnfc() / errorfc().
> 
> Fixes: a3ff937b33d9 ("prefix-handling analogues of errorf() and friends")
> Signed-off-by: RubenKelevra <rubenkelevra@gmail.com>

Good catch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs_context.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
> index a19e4bd32e4d..7773eb870039 100644
> --- a/include/linux/fs_context.h
> +++ b/include/linux/fs_context.h
> @@ -200,7 +200,7 @@ void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt,
>   */
>  #define infof(fc, fmt, ...) __logfc(fc, 'i', fmt, ## __VA_ARGS__)
>  #define info_plog(p, fmt, ...) __plog(p, 'i', fmt, ## __VA_ARGS__)
> -#define infofc(p, fmt, ...) __plog((&(fc)->log), 'i', fmt, ## __VA_ARGS__)
> +#define infofc(fc, fmt, ...) __plog((&(fc)->log), 'i', fmt, ## __VA_ARGS__)
>  
>  /**
>   * warnf - Store supplementary warning message
> -- 
> 2.49.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

