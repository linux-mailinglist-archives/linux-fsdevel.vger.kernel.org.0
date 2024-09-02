Return-Path: <linux-fsdevel+bounces-28253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09099968941
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 15:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BA691C2214C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 13:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4353C20FAAB;
	Mon,  2 Sep 2024 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UeIlEDAM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5db7eGO6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UeIlEDAM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5db7eGO6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4F41865F6;
	Mon,  2 Sep 2024 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725285358; cv=none; b=Tu5TN27ghw2FCU6PfgHIyZdWbE0g9QD0kUBkprhJri8l2FGPiRrwhHnNRnA+CyLfJ+9X7nSrLXLZYKaEvgwTyKnJbw38g9dT0pitbvGiJs8Id6DKXlSxoUUoXgiyBt1hzEqPOmm7uOb7bFux2QQwb7jv0Ui4x56k68O3u/YIccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725285358; c=relaxed/simple;
	bh=qDwgUgA6BFRCJnZk2ZnLHYuW6GNf5pmOBpojoH40Qpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBHr62ebSEuvPILSZJF7A2GuLgJwiWHmBneg4ReYoM1GyM7JIakourLK4R3dC7QyBa+wZkImumaSgILqQ42pUmlNEQqcJG+kW10VSHlcq8zqIhPnUE6EDy/QPGx7gNwjgKwRI+oN+9h5VWugUoASwIZVrOJrGRVU4QC3c6llym4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UeIlEDAM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5db7eGO6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UeIlEDAM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5db7eGO6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 45E8D21B0B;
	Mon,  2 Sep 2024 13:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725285355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4038p6ypsmLl7oHu34zkmir0R68SGXAAGBzY5mWGhqw=;
	b=UeIlEDAMemVjcNiNR2XZIBkOuzlMrD71xDt00PUzZf5Wjkd45qZPRdZS+OGciG7ETVp2fz
	hMzwuutDQ6Q2+0Jvl1riItgaADkLdWEJoxx8NxIR5HAlDVN6njerpCzacZhR3pak2zizBC
	WGEMdpMJ1ie+KPCnbQt4En454mFxePU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725285355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4038p6ypsmLl7oHu34zkmir0R68SGXAAGBzY5mWGhqw=;
	b=5db7eGO6LpwPt3n0kG/UGeHdTQKtl1dYeIRY0muRmv/GvMoWpV5MX641WDS88/kqwMF6d8
	ayytcXT5Sppv/BCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725285355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4038p6ypsmLl7oHu34zkmir0R68SGXAAGBzY5mWGhqw=;
	b=UeIlEDAMemVjcNiNR2XZIBkOuzlMrD71xDt00PUzZf5Wjkd45qZPRdZS+OGciG7ETVp2fz
	hMzwuutDQ6Q2+0Jvl1riItgaADkLdWEJoxx8NxIR5HAlDVN6njerpCzacZhR3pak2zizBC
	WGEMdpMJ1ie+KPCnbQt4En454mFxePU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725285355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4038p6ypsmLl7oHu34zkmir0R68SGXAAGBzY5mWGhqw=;
	b=5db7eGO6LpwPt3n0kG/UGeHdTQKtl1dYeIRY0muRmv/GvMoWpV5MX641WDS88/kqwMF6d8
	ayytcXT5Sppv/BCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A5F513AE0;
	Mon,  2 Sep 2024 13:55:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K6c8DuvD1WZCKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Sep 2024 13:55:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E0E8BA0965; Mon,  2 Sep 2024 15:55:54 +0200 (CEST)
Date: Mon, 2 Sep 2024 15:55:54 +0200
From: Jan Kara <jack@suse.cz>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: jack@suse.cz, kees@kernel.org, gustavoars@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] isofs: Annotate struct SL_component with __counted_by()
Message-ID: <20240902135554.xpeqg724t2hsqx2u@quack3>
References: <20240830164902.112682-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830164902.112682-2-thorsten.blum@toblux.com>
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
	RCPT_COUNT_SEVEN(0.00)[7];
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

On Fri 30-08-24 18:49:03, Thorsten Blum wrote:
> Add the __counted_by compiler attribute to the flexible array member
> text to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/isofs/rock.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/isofs/rock.h b/fs/isofs/rock.h
> index ee9660e9671c..7755e587f778 100644
> --- a/fs/isofs/rock.h
> +++ b/fs/isofs/rock.h
> @@ -44,7 +44,7 @@ struct RR_PN_s {
>  struct SL_component {
>  	__u8 flags;
>  	__u8 len;
> -	__u8 text[];
> +	__u8 text[] __counted_by(len);
>  } __attribute__ ((packed));
>  
>  struct RR_SL_s {
> -- 
> 2.46.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

