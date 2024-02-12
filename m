Return-Path: <linux-fsdevel+bounces-11254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5FD8522C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 00:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5EB1C23281
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 23:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6770B50268;
	Mon, 12 Feb 2024 23:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RdRJbcyJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kIzp9Exf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RdRJbcyJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kIzp9Exf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C045024A
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 23:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707781759; cv=none; b=P1SJbQ39Ls5KInWitBzBFTy12aat5w8GdsNE5i8FsQw8U34f9d+Gj44K6/aboz7ovkSsOWZN6122J9zydnPx06DvETsggtuvPiImqQ0twN3os1nQ4hKwcRn4KTlfoB+CuzY+C9adjeqR5yLJzNMWIs3WspP2Lx9lfqKp8KJ+mm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707781759; c=relaxed/simple;
	bh=qvhwlD1qx3qoNJXUMg3D/YGiLWITB/wqw6+KaEVsTKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bND+R25NL1JO+mLSJWLwJ60Udw1DDj5oedHRP51UYSXjAQkUHUVIxUIk4w+PYZ0ojUUNRi5Y7r2N0xYBY1K/NTselsqNxud7KyPvsPiAuU+rz0ROCq2dznOJtWBvowu25wUzBsYYUsK2zrURowdRS5/WzpnINhQxNVYUfFxR5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RdRJbcyJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kIzp9Exf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RdRJbcyJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kIzp9Exf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 778A61F78F;
	Mon, 12 Feb 2024 23:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707781737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ETNHb1xDcKtGfvaVOvwo7RVvocOS1eN4JRlPGjIgUQ=;
	b=RdRJbcyJvOG2EJaTfxULw6EBqTUpqmWVB76RhcIAWQ+pNAlwhvEtVI6IZXskvdKOlwCNEi
	CLY8Gik0bJ7W6qhMQ5k/gE4q2SnsK2oFdZFrOxHxIWFRL/z4o79y3sGfRzyHEuSdqG7TOA
	+N4f/k6DNdTw6EWYcmPZtc0j5/RLnZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707781737;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ETNHb1xDcKtGfvaVOvwo7RVvocOS1eN4JRlPGjIgUQ=;
	b=kIzp9ExfzVOS5oMauehGD4eZ0pwQ5crHmxxSkHgGaKGiyu7U2hljRjyZ+6BGO0TpxrBJ50
	Eb/GbvzfKQFuhbDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707781737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ETNHb1xDcKtGfvaVOvwo7RVvocOS1eN4JRlPGjIgUQ=;
	b=RdRJbcyJvOG2EJaTfxULw6EBqTUpqmWVB76RhcIAWQ+pNAlwhvEtVI6IZXskvdKOlwCNEi
	CLY8Gik0bJ7W6qhMQ5k/gE4q2SnsK2oFdZFrOxHxIWFRL/z4o79y3sGfRzyHEuSdqG7TOA
	+N4f/k6DNdTw6EWYcmPZtc0j5/RLnZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707781737;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ETNHb1xDcKtGfvaVOvwo7RVvocOS1eN4JRlPGjIgUQ=;
	b=kIzp9ExfzVOS5oMauehGD4eZ0pwQ5crHmxxSkHgGaKGiyu7U2hljRjyZ+6BGO0TpxrBJ50
	Eb/GbvzfKQFuhbDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EAB613212;
	Mon, 12 Feb 2024 23:48:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id jkbLFmmuymUINQAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 12 Feb 2024 23:48:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EC30EA0809; Tue, 13 Feb 2024 00:48:56 +0100 (CET)
Date: Tue, 13 Feb 2024 00:48:56 +0100
From: Jan Kara <jack@suse.cz>
To: Kees Cook <keescook@chromium.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] quota: Detect loops in quota tree
Message-ID: <20240212234856.dx7eaf6xdvtqga6p@quack3>
References: <20240209112250.10894-1-jack@suse.cz>
 <202402121046.42785619B@keescook>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402121046.42785619B@keescook>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.11
X-Spamd-Result: default: False [-3.11 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.31)[96.75%]
X-Spam-Flag: NO

On Mon 12-02-24 10:47:28, Kees Cook wrote:
> On Fri, Feb 09, 2024 at 12:22:50PM +0100, Jan Kara wrote:
> > [...]
> > @@ -613,15 +658,17 @@ static loff_t find_block_dqentry(struct qtree_mem_dqinfo *info,
> >  
> >  /* Find entry for given id in the tree */
> >  static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
> > -				struct dquot *dquot, uint blk, int depth)
> > +				struct dquot *dquot, uint *blks, int depth)
> >  {
> >  	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
> >  	loff_t ret = 0;
> >  	__le32 *ref = (__le32 *)buf;
> > +	uint blk;
> > +	int i;
> >  
> >  	if (!buf)
> >  		return -ENOMEM;
> > -	ret = read_blk(info, blk, buf);
> > +	ret = read_blk(info, blks[depth], buf);
> >  	if (ret < 0) {
> >  		quota_error(dquot->dq_sb, "Can't read quota tree block %u",
> >  			    blk);
>                             ^^^
> Coverity noticed this is used uninitialized. It should be "blks[depth]"
> now, I think.

Yup, already pushed fix to my tree as 0-day notified me as well :) But
thanks for noticing!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

