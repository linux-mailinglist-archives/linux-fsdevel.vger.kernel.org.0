Return-Path: <linux-fsdevel+bounces-30973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9371C9902E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 14:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5454E1C211D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 12:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A204E15B111;
	Fri,  4 Oct 2024 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T1is47nf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SMLHzTAq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="T1is47nf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SMLHzTAq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC502747B;
	Fri,  4 Oct 2024 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728044880; cv=none; b=HurspF4gxCKWBlgFHu5htOrDEZyYEwSQXdJOR5459oDCbieGJ7s9FaQhHAb2/lravnv8q1Wkh9gVLbS/qbgqzR0huoxA4czGr5xCi9lhMvS/YQp+0aMhhMNLsS/vzHzgPDHFcntBkPUYfRuCIRs3o/A/VQxo8kIueI7c0z2HeZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728044880; c=relaxed/simple;
	bh=uj1Jm+M6EKlUMwu0HHcQnfsV7WFP4tK/uifjBub0kPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VLO0voXgQaI1VL+8Wdk80sdwy3QyPeU+SKgKawWI4W4VoNL0AFLz1orEicJstYruw6m4uclf0YdFeq/E2VkMh5K2oS/UEiOD3jTKjD0VaAcJqt/J8zOoPa5yfjNS81Idjrh+QdvroYbStZ11PWzAZ3d02jZ5hQCE8HgGPLsfFzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T1is47nf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SMLHzTAq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=T1is47nf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SMLHzTAq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 924E621C0A;
	Fri,  4 Oct 2024 12:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728044876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lXp7igrrMbPqIGVIgIjKBeis7bIH0t2FfQZ+ezRMfPU=;
	b=T1is47nfyxMdOtKTGigP6/dFW2NI+qUZMYCUfNPuu7ovEfnVTDCibbZJq6QgeLLkBdnGEB
	4f25K17Ds88Ls6NKklgdMM5GluYYtzEywVpZ9APYQfBzBe8FkFyMyQgxtWUHq603BctYZF
	0bildl1RlRpBTjNbdhSUMd8UK6wyBWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728044876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lXp7igrrMbPqIGVIgIjKBeis7bIH0t2FfQZ+ezRMfPU=;
	b=SMLHzTAqWmsRHwSLbKPRx+Fa9WYLoZBof6raaSSU/WL2SDKLpp35Hx+/RIxDxYSvkVfQEh
	iuLH/YPcSS39x7BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728044876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lXp7igrrMbPqIGVIgIjKBeis7bIH0t2FfQZ+ezRMfPU=;
	b=T1is47nfyxMdOtKTGigP6/dFW2NI+qUZMYCUfNPuu7ovEfnVTDCibbZJq6QgeLLkBdnGEB
	4f25K17Ds88Ls6NKklgdMM5GluYYtzEywVpZ9APYQfBzBe8FkFyMyQgxtWUHq603BctYZF
	0bildl1RlRpBTjNbdhSUMd8UK6wyBWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728044876;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lXp7igrrMbPqIGVIgIjKBeis7bIH0t2FfQZ+ezRMfPU=;
	b=SMLHzTAqWmsRHwSLbKPRx+Fa9WYLoZBof6raaSSU/WL2SDKLpp35Hx+/RIxDxYSvkVfQEh
	iuLH/YPcSS39x7BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 842EA13A6E;
	Fri,  4 Oct 2024 12:27:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bDQ/IEzf/2YmQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 04 Oct 2024 12:27:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 38A2AA0877; Fri,  4 Oct 2024 14:27:56 +0200 (CEST)
Date: Fri, 4 Oct 2024 14:27:56 +0200
From: Jan Kara <jack@suse.cz>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: inode insertion kdoc corrections
Message-ID: <20241004122756.3szmzyetiir435ua@quack3>
References: <20241004115151.44834-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004115151.44834-1-agruenba@redhat.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 04-10-24 13:51:51, Andreas Gruenbacher wrote:
> Some minor corrections to the inode_insert5 and iget5_locked kernel
> documentation.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 471ae4a31549..6b3ff38df7f7 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1239,16 +1239,15 @@ EXPORT_SYMBOL(unlock_two_nondirectories);
>   * @data:	opaque data pointer to pass to @test and @set
>   *
>   * Search for the inode specified by @hashval and @data in the inode cache,
> - * and if present it is return it with an increased reference count. This is
> - * a variant of iget5_locked() for callers that don't want to fail on memory
> - * allocation of inode.
> + * and if present return it with an increased reference count. This is a
> + * variant of iget5_locked() that doesn't allocate an inode.
>   *
> - * If the inode is not in cache, insert the pre-allocated inode to cache and
> + * If the inode is not present in the cache, insert the pre-allocated inode and
>   * return it locked, hashed, and with the I_NEW flag set. The file system gets
>   * to fill it in before unlocking it via unlock_new_inode().
>   *
> - * Note both @test and @set are called with the inode_hash_lock held, so can't
> - * sleep.
> + * Note that both @test and @set are called with the inode_hash_lock held, so
> + * they can't sleep.
>   */
>  struct inode *inode_insert5(struct inode *inode, unsigned long hashval,
>  			    int (*test)(struct inode *, void *),
> @@ -1312,16 +1311,16 @@ EXPORT_SYMBOL(inode_insert5);
>   * @data:	opaque data pointer to pass to @test and @set
>   *
>   * Search for the inode specified by @hashval and @data in the inode cache,
> - * and if present it is return it with an increased reference count. This is
> - * a generalized version of iget_locked() for file systems where the inode
> + * and if present return it with an increased reference count. This is a
> + * generalized version of iget_locked() for file systems where the inode
>   * number is not sufficient for unique identification of an inode.
>   *
> - * If the inode is not in cache, allocate a new inode and return it locked,
> - * hashed, and with the I_NEW flag set. The file system gets to fill it in
> - * before unlocking it via unlock_new_inode().
> + * If the inode is not present in the cache, allocate and insert a new inode
> + * and return it locked, hashed, and with the I_NEW flag set. The file system
> + * gets to fill it in before unlocking it via unlock_new_inode().
>   *
> - * Note both @test and @set are called with the inode_hash_lock held, so can't
> - * sleep.
> + * Note that both @test and @set are called with the inode_hash_lock held, so
> + * they can't sleep.
>   */
>  struct inode *iget5_locked(struct super_block *sb, unsigned long hashval,
>  		int (*test)(struct inode *, void *),
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

