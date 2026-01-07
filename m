Return-Path: <linux-fsdevel+bounces-72600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D16CFCE06
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 10:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B36A7303E40D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 09:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59A63016F1;
	Wed,  7 Jan 2026 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bXfedOmC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jW9f7Yus";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h4IHSs4J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KP6u3b9p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBF72FC876
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 09:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767777604; cv=none; b=a9xplnUTFgLHZ/FCfEYtG0974HjKrv6sNzNfM9Ajo2QWqw60EcH1g4VI3/8XbJCfKEnlPejwYT30zzuI7H0nqEv2x5E5pYUS2ocUcRqhQIc+mlLge8iCgK2XLjAUqAd4VAYim8DrYpvFlvxf1ws5pNJMoT+KFO7b8CNka0QCJkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767777604; c=relaxed/simple;
	bh=JCHXxrF7Y+7Sq6FcTC54S4bP/QhVFrsw6qhIl7klmFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BN6ED62OYaiSbdyG6Hu4OceQ+igf46VIjbIl4SdRboGPlSaZD0Eq5MG6yovjtd2nBxJ7rMWyFC5Q5NEiZUu9OMalTO7l9uP3RACnX7SVM9CN/ZBXw4OdkmD/kzR05B7UfGZt3p8fEkOWnmZ8Ee2VRs3yY7X1zV2oNzR0EwouHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bXfedOmC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jW9f7Yus; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h4IHSs4J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KP6u3b9p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D65D15BD1D;
	Wed,  7 Jan 2026 09:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767777600; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlGYLZNyph8hwnmX949LAFvR/W9X+jGV+eGG9YFr+iU=;
	b=bXfedOmC9atRFSGdFpW1KxyaZNPQ4bY5Nyh29DSJ492/Babj0RmmYLqYpWxq9JZrJe5kVX
	zs4ErBlXbW+vSSqF5TawBIERL8bQENJc2jRkTo2bzHC1OAQK2YhO6xLQe0gYy4bJi1AaUe
	NfHKBGsVD5csw+3oOD9mUhsP5bVcaL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767777600;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlGYLZNyph8hwnmX949LAFvR/W9X+jGV+eGG9YFr+iU=;
	b=jW9f7YusVK7GF6BmyqVhLyHQirVfDQqoFe1Q6WfCw/NFBUdpbaixfEtocef55I/BF+HdPY
	146nuCRl07Lgk3Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767777599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlGYLZNyph8hwnmX949LAFvR/W9X+jGV+eGG9YFr+iU=;
	b=h4IHSs4JSrqj93ZXFqsMfDZ6GZ21Tbxlffs3UXOrzRKnB9ECSpAS/oAq7vCKgKY2Hbtoke
	A8EAyhTBY7D6Y3Yjn/pirqKly+89tzaR83PMfR3K32XUOiVEbp2MM8iHn3gGta5ppkhYei
	0+Qc37vjlr9RhkunSG5K8e97klx/dqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767777599;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlGYLZNyph8hwnmX949LAFvR/W9X+jGV+eGG9YFr+iU=;
	b=KP6u3b9p1clYfgk7bXomx05vaoCAYs/KU1Zr8RhMhBWKm1K6mC6l85Eg8z9jdBVwz3LoE9
	9+IeyLKYVe83l2Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBB083EA63;
	Wed,  7 Jan 2026 09:19:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l621MT8lXmntEwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Jan 2026 09:19:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7CA55A090B; Wed,  7 Jan 2026 10:19:59 +0100 (CET)
Date: Wed, 7 Jan 2026 10:19:59 +0100
From: Jan Kara <jack@suse.cz>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: jack@suse.cz, brauner@kernel.org, linux-api@vger.kernel.org, 
	hch@lst.de, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, gabriel@krisman.be, amir73il@gmail.com
Subject: Re: [PATCH 7/6] fs: improve comment in fserror_alloc_event
Message-ID: <z64qfesodgulcztm7377w475vpriwo47svljmvorwdqmoxo5qm@konpxvnqn4se>
References: <176602332085.686273.7564676516217176769.stgit@frogsfrogsfrogs>
 <20260106233349.GL191501@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106233349.GL191501@frogsfrogsfrogs>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,vger.kernel.org,lst.de,krisman.be,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 06-01-26 15:33:49, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Document the ordering requirements between SB_ACTIVE and
> s_pending_errors in the new fserror code.
> 
> Cc: jack@suse.cz
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks! I guess this will be folded into the original patch but just in
case:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fserror.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/fserror.c b/fs/fserror.c
> index ec92f5a6db59ce..06ca86adab9b76 100644
> --- a/fs/fserror.c
> +++ b/fs/fserror.c
> @@ -79,6 +79,11 @@ static inline struct fserror_event *fserror_alloc_event(struct super_block *sb,
>  	 * If pending_errors already reached zero or is no longer active,
>  	 * the superblock is being deactivated so there's no point in
>  	 * continuing.
> +	 *
> +	 * The order of the check of s_pending_errors and SB_ACTIVE are
> +	 * mandated by order of accesses in generic_shutdown_super and
> +	 * fserror_unmount.  Barriers are implicitly provided by the refcount
> +	 * manipulations in this function and fserror_unmount.
>  	 */
>  	if (!refcount_inc_not_zero(&sb->s_pending_errors))
>  		return NULL;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

