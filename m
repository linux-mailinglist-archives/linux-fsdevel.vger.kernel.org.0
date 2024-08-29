Return-Path: <linux-fsdevel+bounces-27802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 361329642CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABFDF1F22885
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2262619148A;
	Thu, 29 Aug 2024 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h9ClwNiX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rqhwlPWm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h9ClwNiX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rqhwlPWm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F2918E039;
	Thu, 29 Aug 2024 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930114; cv=none; b=DFvYENZQDJLX3VoqFUSxEYltmM87HiS1DmbP9y5NMtE3AugQnKeGgCLXogxsFznBnXkBMFOp/plAaAyOyiq4NlKwTCKfd57r+961CNm2sg/YuOYlqSftScvCA7t1TKJS3cyg4gp08BA57qAzjSpkaB6BOjIq1HDy2HlStPCbf+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930114; c=relaxed/simple;
	bh=zLqxcxoQehGXa3k0Fo3MFlW544NW6AkQKyvqyotnnR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+VzRW3bs62+/XOuYBIXjg0GoHmeXD/R1h+2dBQJlTiJA0FAtAs+fIMzCknN61geVUyST1rCY9LOW53y9YUxFH8wgrl7xxApVrOQY6WkeX4j0euJeik1IdteRHz+2AovdnB0cq+zoEqqyiSZVdEdYfIuPAdzKjsvdKCfkJ3REFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h9ClwNiX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rqhwlPWm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h9ClwNiX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rqhwlPWm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E31D1FD29;
	Thu, 29 Aug 2024 11:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724930111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rfDxXf5iNcNFz7gHEBFfifLefJ0Y22jeDSPIMj00Q4I=;
	b=h9ClwNiX9pS321BiJmwtE7HGM7zUJqcakQ2qlgwi5cRunBDrVzkCdc5Apg/ukE8FEhFL8a
	xKZRUCf9IUK+vL1skRh6elNvD0X2mXA3X8Ld7JSzMmFqZybzee883GKkbVmOFyHL80Dbwv
	5jrhvGAWYtdPjXerx1cS0Qeg60/d8+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724930111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rfDxXf5iNcNFz7gHEBFfifLefJ0Y22jeDSPIMj00Q4I=;
	b=rqhwlPWm1KAUCCyo1vi+G2bFtT1alMvt3MMA1Gw4PqKMWoIDUxbaf1Ab4f5V/0lhqXbhyi
	WZUQMtJoIYJyMXBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724930111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rfDxXf5iNcNFz7gHEBFfifLefJ0Y22jeDSPIMj00Q4I=;
	b=h9ClwNiX9pS321BiJmwtE7HGM7zUJqcakQ2qlgwi5cRunBDrVzkCdc5Apg/ukE8FEhFL8a
	xKZRUCf9IUK+vL1skRh6elNvD0X2mXA3X8Ld7JSzMmFqZybzee883GKkbVmOFyHL80Dbwv
	5jrhvGAWYtdPjXerx1cS0Qeg60/d8+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724930111;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rfDxXf5iNcNFz7gHEBFfifLefJ0Y22jeDSPIMj00Q4I=;
	b=rqhwlPWm1KAUCCyo1vi+G2bFtT1alMvt3MMA1Gw4PqKMWoIDUxbaf1Ab4f5V/0lhqXbhyi
	WZUQMtJoIYJyMXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25993139B0;
	Thu, 29 Aug 2024 11:15:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TNnfCD9Y0GZsFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 11:15:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BA5FEA0965; Thu, 29 Aug 2024 13:15:10 +0200 (CEST)
Date: Thu, 29 Aug 2024 13:15:10 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, jack@suse.cz,
	amir73il@gmail.com, brauner@kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-bcachefs@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v4 15/16] gfs2: add pre-content fsnotify hook to fault
Message-ID: <20240829111510.dfyqczbyzefqzdtx@quack3>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <2bd333be8352f31163eac7528fdcb8b47a1f97b4.1723670362.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bd333be8352f31163eac7528fdcb8b47a1f97b4.1723670362.git.josef@toxicpanda.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,vger.kernel.org,suse.cz,gmail.com,kernel.org,lists.linux.dev,redhat.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,toxicpanda.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Wed 14-08-24 17:25:33, Josef Bacik wrote:
> gfs2 takes the glock before calling into filemap fault, so add the
> fsnotify hook for ->fault before we take the glock in order to avoid any
> possible deadlock with the HSM.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

The idea of interactions between GFS2 cluster locking and HSM gives me
creeps. But yes, this patch looks good to me. Would be nice to get ack from
GFS2 guys. Andreas?

								Honza

> ---
>  fs/gfs2/file.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
> index 08982937b5df..d4af70d765e0 100644
> --- a/fs/gfs2/file.c
> +++ b/fs/gfs2/file.c
> @@ -556,6 +556,10 @@ static vm_fault_t gfs2_fault(struct vm_fault *vmf)
>  	vm_fault_t ret;
>  	int err;
>  
> +	ret = filemap_maybe_emit_fsnotify_event(vmf);
> +	if (unlikely(ret))
> +		return ret;
> +
>  	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
>  	err = gfs2_glock_nq(&gh);
>  	if (err) {
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

