Return-Path: <linux-fsdevel+bounces-29585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D2797B061
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 14:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272E41C22FDF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 12:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF062176AD8;
	Tue, 17 Sep 2024 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VfU8vG7i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BKPyCv9f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VfU8vG7i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BKPyCv9f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD1B16F824
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Sep 2024 12:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726577495; cv=none; b=KdhCJMZcwWQyhUEFLJaAYFWr+prs9IDYg0NLN3e3RJs1+hyt3ljR0ZRYm8cc9gyckF9Ueqct8mTiOF+LDlNCFpsyo1/tkFIyH0+EB9Wyd2NRaxV03eDCOnCr+GtbAbmT8ugtxjz9A3emfFTyXpPzyCP1I9KLdTgQx3z6/kkBV1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726577495; c=relaxed/simple;
	bh=DcFgyuQHGfkucUOhIRNs4fwclracN7vZEOPHs7ePlxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sr78+tCeoKXveLzrx2R1PWCMzqgC/Ew9Uc36R0McUh9Q3U0kKjGjDRD2D1RPCu3LTecnTzunpz9kA8y8wnJcpS1bMIOkb5M71Aa9ttEPnvc3wF/JcMqNk96YvhkoLBp8zahmZYwFEEsHq8ccvVWmU0HBZMNUPcGNvtHp9d/nXkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VfU8vG7i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BKPyCv9f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VfU8vG7i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BKPyCv9f; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5B77E1FB73;
	Tue, 17 Sep 2024 12:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726577491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ByOUJrawd9xVexVGOwv3nbey58yYELXv2G3eMe9BtsQ=;
	b=VfU8vG7i4cQoPUue5UI1MAOnFYuQVdlWSiYAjInHMoOL4NDJU7azz4iteFCwT4cvSGK6bZ
	uL4pOv8J9V4EKQAUfxa+QQweVqvhvbBuik4Cf324QpSK3k7LsKUhV3bw7uioY3xGPWgOaW
	x54nHpxKeywPxBlXUc056+xoog2t810=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726577491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ByOUJrawd9xVexVGOwv3nbey58yYELXv2G3eMe9BtsQ=;
	b=BKPyCv9fbK8TQoAIZ/80u4kxuzJmedRVK1fZ+NPz1fPPf48VmTnUVVZXcm1dGWHAxBTS4X
	p7J9UicZ5VQbyZBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726577491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ByOUJrawd9xVexVGOwv3nbey58yYELXv2G3eMe9BtsQ=;
	b=VfU8vG7i4cQoPUue5UI1MAOnFYuQVdlWSiYAjInHMoOL4NDJU7azz4iteFCwT4cvSGK6bZ
	uL4pOv8J9V4EKQAUfxa+QQweVqvhvbBuik4Cf324QpSK3k7LsKUhV3bw7uioY3xGPWgOaW
	x54nHpxKeywPxBlXUc056+xoog2t810=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726577491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ByOUJrawd9xVexVGOwv3nbey58yYELXv2G3eMe9BtsQ=;
	b=BKPyCv9fbK8TQoAIZ/80u4kxuzJmedRVK1fZ+NPz1fPPf48VmTnUVVZXcm1dGWHAxBTS4X
	p7J9UicZ5VQbyZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35122139CE;
	Tue, 17 Sep 2024 12:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LRzwDFB76WYnJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Sep 2024 12:51:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1A8F4A08B3; Tue, 17 Sep 2024 14:51:17 +0200 (CEST)
Date: Tue, 17 Sep 2024 14:51:17 +0200
From: Jan Kara <jack@suse.cz>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 2/5] affs: convert affs to use the new mount api
Message-ID: <20240917125117.7ima5ewx54ugpndx@quack3>
References: <20240916172735.866916-1-sandeen@redhat.com>
 <20240916172735.866916-3-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916172735.866916-3-sandeen@redhat.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 16-09-24 13:26:19, Eric Sandeen wrote:
> Convert the affs filesystem to use the new mount API.
> Tested by comparing random mount & remount options before and after
> the change.
> 
> Cc: David Sterba <dsterba@suse.com>
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Just one nit, otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> +	case Opt_verbose:
> +		affs_set_opt(ctx->mount_flags, SF_VERBOSE);
> +		break;
> +	case Opt_volume: {

I guess there's no need for the braces anymore?


> +		strscpy(ctx->volume, param->string, 32);
> +		break;
>  	}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

