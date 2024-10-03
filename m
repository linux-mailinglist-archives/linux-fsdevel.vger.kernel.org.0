Return-Path: <linux-fsdevel+bounces-30866-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E29098EEE8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B4F1C22172
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF65F178399;
	Thu,  3 Oct 2024 12:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hQBBLOxb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rJoFd6g4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hQBBLOxb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rJoFd6g4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8973D170A2E;
	Thu,  3 Oct 2024 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957807; cv=none; b=b81vuvhgdPdVVCRyhxoM2x/dK9N8RcrVQuXQz9NmGZbifgRYbqVjtSIVWK1LjRKCqy+nu+J36WMlOurnkkbU7V8j5McaIz898tbNwHu9wGR8Uxt+0LgDIU847p1F8rfLrWzGYEvm+KwbStyvrm9iInDVpeKeiZoDpIp06c1vSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957807; c=relaxed/simple;
	bh=SEJwaaFr2ADiYX4qg+k6s74GJOUgEqwMZSCm/dJa30A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kfxUdOxb7jc2R94IYRbLaomBSVJ/WNspznXGmVjVwTdfEh8M3+rkn9qFbcEDKVzubjl7ueFMYDrF7PTPypPHPTpS7rC/GhfQT2G6HLm5mYWhhXCIAGqM0jbS6FZmGw6UCA7CHH1fnxhU+MfGrjvk4XavCkOzA+2EKdi9XVj05Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hQBBLOxb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rJoFd6g4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hQBBLOxb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rJoFd6g4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D24221CFF;
	Thu,  3 Oct 2024 12:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727957803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/hSFLEwAHNuNwWLKgwfodoEokY1wh1J/NWvIOHRUOVM=;
	b=hQBBLOxbU7Xr882TXBje5AtzYamifhI7nVZZ9CEj1ZaurIV7Nfbai9t3347dV65UdijPQt
	34YQH0nlKmtBA2AR7wfWCkJDe7BakbwArojJ9VF03y3UzaaDzfQc8blF9qQPZK2KdL5OvK
	iKS9cHLD8C6H6NMstZOuDKWbp8TaZ+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727957803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/hSFLEwAHNuNwWLKgwfodoEokY1wh1J/NWvIOHRUOVM=;
	b=rJoFd6g4t4NgKS0B0jW+MIeltvmf+B9SPhP9/fxWbI0MWmp0IsuKY8ZPxB9NyhLD1mK3Eg
	ShIfi7vzZr/4e8Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727957803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/hSFLEwAHNuNwWLKgwfodoEokY1wh1J/NWvIOHRUOVM=;
	b=hQBBLOxbU7Xr882TXBje5AtzYamifhI7nVZZ9CEj1ZaurIV7Nfbai9t3347dV65UdijPQt
	34YQH0nlKmtBA2AR7wfWCkJDe7BakbwArojJ9VF03y3UzaaDzfQc8blF9qQPZK2KdL5OvK
	iKS9cHLD8C6H6NMstZOuDKWbp8TaZ+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727957803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/hSFLEwAHNuNwWLKgwfodoEokY1wh1J/NWvIOHRUOVM=;
	b=rJoFd6g4t4NgKS0B0jW+MIeltvmf+B9SPhP9/fxWbI0MWmp0IsuKY8ZPxB9NyhLD1mK3Eg
	ShIfi7vzZr/4e8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 932A313882;
	Thu,  3 Oct 2024 12:16:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /HHnIyuL/mboIwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Oct 2024 12:16:43 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3541DA086F; Thu,  3 Oct 2024 14:16:35 +0200 (CEST)
Date: Thu, 3 Oct 2024 14:16:35 +0200
From: Jan Kara <jack@suse.cz>
To: Tang Yizhou <yizhou.tang@shopee.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, chandan.babu@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/page-writeback.c: Fix comment of
 wb_domain_writeout_add()
Message-ID: <20241003121635.l7wpciq2jnoh7sq2@quack3>
References: <20241002130004.69010-1-yizhou.tang@shopee.com>
 <20241002130004.69010-3-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002130004.69010-3-yizhou.tang@shopee.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 02-10-24 21:00:03, Tang Yizhou wrote:
> From: Tang Yizhou <yizhou.tang@shopee.com>
> 
> __bdi_writeout_inc() has undergone multiple renamings, but the comment
> within the function body have not been updated accordingly. Update it
> to reflect the latest wb_domain_writeout_add().
> 
> Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index a848e7f0719d..4f6efaa060bd 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -586,7 +586,7 @@ static void wb_domain_writeout_add(struct wb_domain *dom,
>  	/* First event after period switching was turned off? */
>  	if (unlikely(!dom->period_time)) {
>  		/*
> -		 * We can race with other __bdi_writeout_inc calls here but
> +		 * We can race with other wb_domain_writeout_add calls here but
>  		 * it does not cause any harm since the resulting time when
>  		 * timer will fire and what is in writeout_period_time will be
>  		 * roughly the same.
> -- 
> 2.25.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

