Return-Path: <linux-fsdevel+bounces-27807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0042964363
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 13:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543B31F253ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 11:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A6D191F86;
	Thu, 29 Aug 2024 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RrlpT4LS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5moWWxk6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RrlpT4LS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5moWWxk6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD75192B6F;
	Thu, 29 Aug 2024 11:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724931816; cv=none; b=IEs9ifWVf+gTD//sQYgmRQgOXDmmeit8AgR5RvD58kNaJ82IhPaWsJdY+HpFfTeftAAeh16mS3bXrCMKeZ95p0COViHg7WS1MjP09YdQRmMQ1FU2NlqdPJfJGitOmC7664ZK18MzznMZeH/eRgoD/9lAzRYYa6uCJLS7lj4sSf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724931816; c=relaxed/simple;
	bh=+w4RXKVr4Mo69e4UF+UO4WO0/jN6pQLtwomt7d/LS8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q54GUz0WBIZTv6DYoa2gVCAJUYabtHBLc5ftf+FPcQ2lu12C0Tv8rvlTFpJttk85vdQ5v/FBATZ/U/1x7F0AeAXS6pWKVS90r4y4UDo3oZOPDo5krmw3u8h5YW69yrbyZREouQ593ZEYk/JE//DYypeNYhT/dkpA/ADvYBrUD0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RrlpT4LS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5moWWxk6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RrlpT4LS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5moWWxk6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6325B1F381;
	Thu, 29 Aug 2024 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724931812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7wSk+srFQ2e7HSobC00pOafBgG7Duw5VlO3s1ICYqE=;
	b=RrlpT4LSij2Pc7jfQwVShhwpkJNl8uDhs+HYtyqCEqp48JnseIximpL8g5YyNFMzmVbBdF
	ya4ACJuhq0kIqzNGtoA1CBIVslVby8fu/naeTtpOYskNd/JXJHHBXuhe4EyRnuOaWbfjSq
	r2DGBf7QbJSAGPwaw8CS73Qz8wVYaYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724931812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7wSk+srFQ2e7HSobC00pOafBgG7Duw5VlO3s1ICYqE=;
	b=5moWWxk6AfXZHIZBCOiJi0DNTR8i178UHqCXmoG53cmj1Og65yPFTalVXyXvYflwL0qdsW
	C8lCDSw9ZCqTqxCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724931812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7wSk+srFQ2e7HSobC00pOafBgG7Duw5VlO3s1ICYqE=;
	b=RrlpT4LSij2Pc7jfQwVShhwpkJNl8uDhs+HYtyqCEqp48JnseIximpL8g5YyNFMzmVbBdF
	ya4ACJuhq0kIqzNGtoA1CBIVslVby8fu/naeTtpOYskNd/JXJHHBXuhe4EyRnuOaWbfjSq
	r2DGBf7QbJSAGPwaw8CS73Qz8wVYaYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724931812;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7wSk+srFQ2e7HSobC00pOafBgG7Duw5VlO3s1ICYqE=;
	b=5moWWxk6AfXZHIZBCOiJi0DNTR8i178UHqCXmoG53cmj1Og65yPFTalVXyXvYflwL0qdsW
	C8lCDSw9ZCqTqxCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56B6813408;
	Thu, 29 Aug 2024 11:43:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QXcnFeRe0Gb1HgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 29 Aug 2024 11:43:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 043CBA0965; Thu, 29 Aug 2024 13:43:27 +0200 (CEST)
Date: Thu, 29 Aug 2024 13:43:27 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
	kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
	brauner@kernel.org, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v4 15/16] gfs2: add pre-content fsnotify hook to fault
Message-ID: <20240829114327.zm3ghtjic3abvucy@quack3>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <2bd333be8352f31163eac7528fdcb8b47a1f97b4.1723670362.git.josef@toxicpanda.com>
 <20240829111510.dfyqczbyzefqzdtx@quack3>
 <CAOQ4uxjuySfiOXy_R28nhQnF+=ty=hL2Zj3h=aVrGXjm_v7gug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjuySfiOXy_R28nhQnF+=ty=hL2Zj3h=aVrGXjm_v7gug@mail.gmail.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,toxicpanda.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 29-08-24 13:26:17, Amir Goldstein wrote:
> On Thu, Aug 29, 2024 at 1:15 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Wed 14-08-24 17:25:33, Josef Bacik wrote:
> > > gfs2 takes the glock before calling into filemap fault, so add the
> > > fsnotify hook for ->fault before we take the glock in order to avoid any
> > > possible deadlock with the HSM.
> > >
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >
> > The idea of interactions between GFS2 cluster locking and HSM gives me
> > creeps. But yes, this patch looks good to me. Would be nice to get ack from
> > GFS2 guys. Andreas?
> 
> If we are being honest, I think that the fact that HSM events require careful
> handling in ->fault() and not to mention no documentation of this fact,
> perhaps we should let HSM events be an opt-in file_system_type feature?
> 
> Additionally, we had to introduce FS_DISALLOW_NOTIFY_PERM
> and restrict sb marks on SB_NOUSER, all because these fanotify
> features did not require fs opt-in to begin with.
> 
> I think we would be repeating this mistake if we do not add
> FS_ALLOW_HSM from the start.
> 
> After all, I cannot imagine HSM being used on anything but
> the major disk filesystems.
> 
> Hmm?

Yeah, I was considering this already when thinking about btrfs quirks with
readahead and various special filesystem ioctls and I agree that a need to be
careful with page faults is another good reason to make this a
per-filesystem opt in. Will you send a patch?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

