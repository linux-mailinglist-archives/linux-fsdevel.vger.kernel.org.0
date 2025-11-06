Return-Path: <linux-fsdevel+bounces-67263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CF6C398CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 09:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346493BC5B2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 08:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB48C2D63F2;
	Thu,  6 Nov 2025 08:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hhz5m9dR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VvC5eyxj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cy3kQaQb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zvHg9C8v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA27145FE0
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Nov 2025 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417191; cv=none; b=AnI7UOfIlBzCyHZxT3eh+cnWk9K3jdh+7QYCGAteu54H8lqi9mm0nfv7S6W+V004iP3kv0fiR3vQpjTidpmy22E5BpZ/yTXR//jU93wCjaIFo4vnHh0W3FdV8bM0kh5xrY6CNz4vOe5ZiMmdq8Mbfm6C9ZmEJJNAUnjnP//wINo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417191; c=relaxed/simple;
	bh=w1jhKK19bPZcNm0NCQz5LFgT5J9i7OqRhOa7qwdSNI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpTrUQ4vtB3IM7vSFyOwnaRSEqQ5H1AH2pf7oZr9BJBlfGtp29bAJhHbDV9TD62h/BMK9hRs4ZbimeMNKOabQEvlrQ9NiS5GiS64oExEoDcRV+Nf7zE9RScLBh4CcTD4pKk2/iEOqIGPuvT8xJN21AzJIID8SlNmaEzqCy1YEAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hhz5m9dR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VvC5eyxj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cy3kQaQb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zvHg9C8v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD8F5211CF;
	Thu,  6 Nov 2025 08:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762417187;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drBt2CXaLppXkJADFpL2NiZ2+fhddPt0th0vzvDdmfs=;
	b=Hhz5m9dRMDYggPQHiHRC/wAEtQbt9acNyy9eZ4Bc+YpaBmCbn94VEnAPVDGCyS77LnYYIw
	WpFfqQtsl4TjYCpkMAITEzjgV0u4jBFlz/xS1Gu1aV1zy6+NLjqD854rRbs6KN7aZ7qLgD
	GPQSpnGNFKX967k9XbCKskimoiy08qs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762417187;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drBt2CXaLppXkJADFpL2NiZ2+fhddPt0th0vzvDdmfs=;
	b=VvC5eyxjLhiw2RN75NSZhXOiezV6oGl1dnQ7PSyIQxZ0LZ7kLOLqMrySZmgo8kL9m4SMTV
	b/Y7/vxYs7WqvgBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cy3kQaQb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zvHg9C8v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762417186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drBt2CXaLppXkJADFpL2NiZ2+fhddPt0th0vzvDdmfs=;
	b=cy3kQaQbM2DahKYSUYnT269gA52gIdFQQObMVNNnzfP9jaUHChqeSlPMxUnkDpiMHFslwF
	NcFnsaq+iejnmntkh51XZUIOObCN9nsr+ed4wEhgelurt4EL940CCC1PVNK/mvrTD15vD9
	l84wPNfhjmwEqGtVRoLmGbyDkzzd+Yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762417186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=drBt2CXaLppXkJADFpL2NiZ2+fhddPt0th0vzvDdmfs=;
	b=zvHg9C8vS5Cnu40YKvRKpHC1kWdpv0QSEpVIKPbs67loFvB2p+Ge7wxi6ZHfQaDynnINHl
	QEZg4IPTmwf+s4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FF3A13A31;
	Thu,  6 Nov 2025 08:19:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UlPzIiJaDGm1TgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 06 Nov 2025 08:19:46 +0000
Date: Thu, 6 Nov 2025 09:19:45 +0100
From: David Sterba <dsterba@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 3/8] btrfs: use super write guard
 btrfs_run_defrag_inode()
Message-ID: <20251106081945.GU13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-3-5108ac78a171@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-work-guards-v1-3-5108ac78a171@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: AD8F5211CF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Nov 04, 2025 at 01:12:32PM +0100, Christian Brauner wrote:
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/btrfs/defrag.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 7b277934f66f..35fb8ee164dc 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -254,10 +254,9 @@ static int btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
>  	range.extent_thresh = defrag->extent_thresh;
>  	file_ra_state_init(ra, inode->vfs_inode.i_mapping);
>  
> -	sb_start_write(fs_info->sb);
> -	ret = btrfs_defrag_file(inode, ra, &range, defrag->transid,
> -				BTRFS_DEFRAG_BATCH);
> -	sb_end_write(fs_info->sb);
> +	scoped_guard(super_write, fs_info->sb)
> +		ret = btrfs_defrag_file(inode, ra, &range,
> +					defrag->transid, BTRFS_DEFRAG_BATCH);

Please use explicit { } around scoped_guard() in btrfs code. It makes
the scope more obvious.

