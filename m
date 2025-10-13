Return-Path: <linux-fsdevel+bounces-63942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE84ABD289D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 12:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F011A1886CAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 10:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD322FF14D;
	Mon, 13 Oct 2025 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bHlTjkWj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pk3ERnEk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bHlTjkWj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pk3ERnEk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0E12FE58F
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Oct 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350912; cv=none; b=UF8Pu2X0BnZTwovSZHrnBCQpqN2ZEyi1d43wdNvbCz0kbqHvav8KTpoAKkbMNaf5E19q9sStW40Ne2qpp225eNRpVUuNE0mlY5WIFotAKzj09/i+Fl+x2issfKScYbFmAz5dn9UWRSh3hR5E1QhAmX8ysRVVO3SIE7+9U6yYhHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350912; c=relaxed/simple;
	bh=htq2wfiGSRS4u2OB3vWqPswGjCN55ciNdnlPCO2JWQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHsfhXUhbG2ojWftSO9XPBhhXEjXxIrKwkhZGrj/DVmDuzcmHNULoCT/C00tU68tzmydM9f1+6FJ5JSYviMQDZAkaWEFWOZqJja+5egGge3bTIs4s7qd/FqEaztlQAv1f8fxwbVRiKhSXERwiElSoKEsMV4c8yOEiZbuafZ+bgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bHlTjkWj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pk3ERnEk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bHlTjkWj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pk3ERnEk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 547D421A19;
	Mon, 13 Oct 2025 10:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760350907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K7Xnat0LWYhhpDlz4Hf2R0blFTg02jqogiUtgcvqClA=;
	b=bHlTjkWjyVt7G3Myd6gcZvMO7frqoBEyIDdEXJhypW8aCclydlzTQashmHvmCR1jlMzVDo
	rzHZdoS9AUhKmBXXV7oCDffayZ9eO3rBUCCfXbM1+kYFc5n7Pxmc8BPwNLf5BaQc23mGQA
	jPoVTrNX8ap9V7eeTNyiU01Ea0rz/QU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760350907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K7Xnat0LWYhhpDlz4Hf2R0blFTg02jqogiUtgcvqClA=;
	b=Pk3ERnEkhM35Roy3IMomoB6DbCRuMdAcKX/sxmvLwBD4bh2VJpfi7DE6Kf6+K0zGHnLgDC
	Qr3zN15U593xUVCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760350907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K7Xnat0LWYhhpDlz4Hf2R0blFTg02jqogiUtgcvqClA=;
	b=bHlTjkWjyVt7G3Myd6gcZvMO7frqoBEyIDdEXJhypW8aCclydlzTQashmHvmCR1jlMzVDo
	rzHZdoS9AUhKmBXXV7oCDffayZ9eO3rBUCCfXbM1+kYFc5n7Pxmc8BPwNLf5BaQc23mGQA
	jPoVTrNX8ap9V7eeTNyiU01Ea0rz/QU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760350907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K7Xnat0LWYhhpDlz4Hf2R0blFTg02jqogiUtgcvqClA=;
	b=Pk3ERnEkhM35Roy3IMomoB6DbCRuMdAcKX/sxmvLwBD4bh2VJpfi7DE6Kf6+K0zGHnLgDC
	Qr3zN15U593xUVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C97613874;
	Mon, 13 Oct 2025 10:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xbZPDrvS7GiYIQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Oct 2025 10:21:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AD48EA0A58; Mon, 13 Oct 2025 12:21:42 +0200 (CEST)
Date: Mon, 13 Oct 2025 12:21:42 +0200
From: Jan Kara <jack@suse.cz>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs: Fix uninitialized 'offp' in statmount_string()
Message-ID: <m7ifqu2trqoqxwkili6tr2v27x524kbtme3ysmfisx4uxtd455@jimiqiuku6wq>
References: <20251011091353.353898-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251011091353.353898-1-zhen.ni@easystack.cn>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Sat 11-10-25 17:13:53, Zhen Ni wrote:
> In statmount_string(), most flags assign an output offset pointer (offp)
> which is later updated with the string offset. However, the
> STATMOUNT_MNT_UIDMAP and STATMOUNT_MNT_GIDMAP cases directly set the
> struct fields instead of using offp. This leaves offp uninitialized,
> leading to a possible uninitialized dereference when *offp is updated.
> 
> Fix it by assigning offp for UIDMAP and GIDMAP as well, keeping the code
> path consistent.
> 
> Fixes: 37c4a9590e1e ("statmount: allow to retrieve idmappings")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>

The bug happened because of mismerge between commits 37c4a9590e1e and
e52e97f09fb6 so I think we should also add:

Fixes: e52e97f09fb6 ("statmount: let unset strings be empty")

Otherwise the patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namespace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d82910f33dc4..5b5ab2ae238b 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5454,11 +5454,11 @@ static int statmount_string(struct kstatmount *s, u64 flag)
>  		ret = statmount_sb_source(s, seq);
>  		break;
>  	case STATMOUNT_MNT_UIDMAP:
> -		sm->mnt_uidmap = start;
> +		offp = &sm->mnt_uidmap;
>  		ret = statmount_mnt_uidmap(s, seq);
>  		break;
>  	case STATMOUNT_MNT_GIDMAP:
> -		sm->mnt_gidmap = start;
> +		offp = &sm->mnt_gidmap;
>  		ret = statmount_mnt_gidmap(s, seq);
>  		break;
>  	default:
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

