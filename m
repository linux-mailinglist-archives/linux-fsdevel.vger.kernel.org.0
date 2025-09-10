Return-Path: <linux-fsdevel+bounces-60811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F50B51BCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 17:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FF47B3870
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 15:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ACC1FECD4;
	Wed, 10 Sep 2025 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PWGyUj04";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="swB7uzEb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PWGyUj04";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="swB7uzEb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DAF266B6F
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518494; cv=none; b=INXzZh8ZKEA8QG1ejhLL8UJhelRt/78GhM62WhPelT6YBOsoh28mXcDHvWRn50KNfBDXCFseHWYMnrfkosXRpnjHQhTLWD+i8+CCQLku5JR5/3pQh9xHENC3VdaIOHE8BVu+QM/WpsKD+q02m1+HP2R1R4G6ibl++YRg/7RN71g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518494; c=relaxed/simple;
	bh=OABbPnjsoirvMYSq5Q/9Yv08rPKleDSQijiwvxAQW08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJ5Rt5D2AzMBxGAEO7JYaqIklRdcVPn7bfeYjaTd5BwY6aA/5CqRH5UF4e1NbQxNjRVdqLV1o2h7vgYSz8E520jglfLYg0UDB+9hDt+FWK88Gwk+v0l2Z4uEVi5lm7XxNAhZ9RA3S0pMqwi1rcG2DRvnX+FYenlTrNMXAOY62w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PWGyUj04; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=swB7uzEb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PWGyUj04; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=swB7uzEb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A58E613C2;
	Wed, 10 Sep 2025 15:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0PBoFpxn2QKQExHoWjxYXzd2TdEfo3Q6mtB7Saqzzw=;
	b=PWGyUj04Qw9F2PDZMd19D/t3tWqDdG9AbJHIM1l4v93fCmoy3z25bW2L7Dpbfg05UudqiG
	4HVnNXi7FxQEFenC/3N229oDFzmdochy0eZo7AXETx0RA25yu7GlDDFWxYY+1sUAgszuqe
	dUN4sxleBqNbLZ7y2kGyMm2zvSEyDKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0PBoFpxn2QKQExHoWjxYXzd2TdEfo3Q6mtB7Saqzzw=;
	b=swB7uzEbU0s8yhfPp9+Vw8GterYdrCl/wRUz6/N4uQeaSk1I78a+sM0s7rljovka0Klpre
	DyNvahstIaNfr4CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757518485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0PBoFpxn2QKQExHoWjxYXzd2TdEfo3Q6mtB7Saqzzw=;
	b=PWGyUj04Qw9F2PDZMd19D/t3tWqDdG9AbJHIM1l4v93fCmoy3z25bW2L7Dpbfg05UudqiG
	4HVnNXi7FxQEFenC/3N229oDFzmdochy0eZo7AXETx0RA25yu7GlDDFWxYY+1sUAgszuqe
	dUN4sxleBqNbLZ7y2kGyMm2zvSEyDKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757518485;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g0PBoFpxn2QKQExHoWjxYXzd2TdEfo3Q6mtB7Saqzzw=;
	b=swB7uzEbU0s8yhfPp9+Vw8GterYdrCl/wRUz6/N4uQeaSk1I78a+sM0s7rljovka0Klpre
	DyNvahstIaNfr4CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6122B13301;
	Wed, 10 Sep 2025 15:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Txa1F5WawWhUOQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 10 Sep 2025 15:34:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 237FEA0A2D; Wed, 10 Sep 2025 17:34:37 +0200 (CEST)
Date: Wed, 10 Sep 2025 17:34:37 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 03/32] block: use extensible_ioctl_valid()
Message-ID: <g4wrfq6kcejrgpf4twsku55pe2xfl34nxekg2y73esodxhprnk@gavy3kiw27sz>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-3-4dd56e7359d8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910-work-namespace-v1-3-4dd56e7359d8@kernel.org>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLbyy5b47ky7xssyr143sji8pp)];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,toxicpanda.com,kernel.org,yhndnzj.com,in.waw.pl,0pointer.de,cyphar.com,zeniv.linux.org.uk,kernel.dk,cmpxchg.org,suse.com,google.com,redhat.com,oracle.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.30

On Wed 10-09-25 16:36:48, Christian Brauner wrote:
> Use the new extensible_ioctl_valid() helper which is equivalent to what
> is done here.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  block/blk-integrity.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> index 056b8948369d..609d75d6a39b 100644
> --- a/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -58,16 +58,14 @@ int blk_rq_count_integrity_sg(struct request_queue *q, struct bio *bio)
>  int blk_get_meta_cap(struct block_device *bdev, unsigned int cmd,
>  		     struct logical_block_metadata_cap __user *argp)
>  {
> -	struct blk_integrity *bi = blk_get_integrity(bdev->bd_disk);
> +	struct blk_integrity *bi;
>  	struct logical_block_metadata_cap meta_cap = {};
>  	size_t usize = _IOC_SIZE(cmd);
>  
> -	if (_IOC_DIR(cmd)  != _IOC_DIR(FS_IOC_GETLBMD_CAP) ||
> -	    _IOC_TYPE(cmd) != _IOC_TYPE(FS_IOC_GETLBMD_CAP) ||
> -	    _IOC_NR(cmd)   != _IOC_NR(FS_IOC_GETLBMD_CAP) ||
> -	    _IOC_SIZE(cmd) < LBMD_SIZE_VER0)
> +	if (extensible_ioctl_valid(cmd, FS_IOC_GETLBMD_CAP, LBMD_SIZE_VER0))
>  		return -ENOIOCTLCMD;
>  
> +	bi = blk_get_integrity(bdev->bd_disk);
>  	if (!bi)
>  		goto out;
>  
> 
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

