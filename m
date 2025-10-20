Return-Path: <linux-fsdevel+bounces-64671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C74FBBF048A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 11:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 333F218A0240
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F182F999F;
	Mon, 20 Oct 2025 09:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JkOPDAv9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8LY7bl7l";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JWjHlviR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TvpaJKOm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C62F6186
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760953421; cv=none; b=T5z7OY8iEZduM41oQx0bl6Xpl9hZCPvxdfZOdyocZ3tcSAonI+t1yQOn2iAy95KDE9Sk4YTOupC/8px8MrlOo8dvLArHvNj4RyLLZQbdEiCjw7EeuDIZ5MF6A6aFVH73ZHPU6qzOPTHnliQmH7wvRkN0oNtFG4o7alJ6Tn/Oi+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760953421; c=relaxed/simple;
	bh=QCBwOixgSMWhmCuogL+IE6LR+QUlcBVpeVT944sSYxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTkcRRcp7U27BK3wjraCBnxWoFp5kAtrzavnD/WCre77U8GYRz5t+Sbz4n45GPHFEzw6rtKN5AyJ41bgf5qq7s4yZ++ENPET7p/HAoGyQqA9zXnzZz6X01HqjeI4xGh2E/qFg0oJD9icyd8+oKmCKdvpAKVa7eGYh8b/PDsW3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JkOPDAv9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8LY7bl7l; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JWjHlviR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TvpaJKOm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 762D41F387;
	Mon, 20 Oct 2025 09:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760953413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvLarYG9RrjbBe2euX4L2iExX2aV37Sl8rwAKGZdDSc=;
	b=JkOPDAv98Hwxl4onZszjA7K7ND9F8kMEzc+oHyB4zmIEWkggGn2WtuMW+m0mlfLOiWNtpM
	TTtIpjNjo+Mz/0bXsFIWxQalmnbOLK4wY5mWOxNzItedSD0ggBKj1UCHgWP32XaksY7zIF
	uxYt92vV5Guxynm8mqE2LsjcaFvNLk0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760953413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvLarYG9RrjbBe2euX4L2iExX2aV37Sl8rwAKGZdDSc=;
	b=8LY7bl7lZJcS2kqu7SEwoOczpQT+Ze0SMhcv8gZ36W+3vozjhzTOS9QCkJDkY4LmmvYBEk
	iLuaZdaHXWjKnnAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JWjHlviR;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TvpaJKOm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760953409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvLarYG9RrjbBe2euX4L2iExX2aV37Sl8rwAKGZdDSc=;
	b=JWjHlviRC/5JdkfXQ/YY15bK+zZbHVu9Wg8b6hcjum9HgIu94+M8AcC93td8uVFfX5mthN
	Z5FQk3eRAj85Qo911J47gItuHhR23Wxi15o9/aFfuFwl3/0eSG0MZBSu2QFEmYV+7egb3X
	W5B51eIb0GsEEn7sykZtewk99hm27Rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760953409;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FvLarYG9RrjbBe2euX4L2iExX2aV37Sl8rwAKGZdDSc=;
	b=TvpaJKOm3mRE3miMvvMmO8sYPO+Ct1PN35hjscYYPqg8/am05scQj2zzud86E0xR+75QAd
	K+ORiF5CtMojvKDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BB3513AAC;
	Mon, 20 Oct 2025 09:43:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w+xDGkEE9mgiFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 20 Oct 2025 09:43:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1E8B2A0856; Mon, 20 Oct 2025 11:43:29 +0200 (CEST)
Date: Mon, 20 Oct 2025 11:43:29 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 03/14] fs: provide accessors for ->i_state
Message-ID: <4p5wgvk2t3rgosly6nkccr45youbatu4w7t3vpxqz2ahqugwny@cyluq56bnuw3>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-4-mjguzik@gmail.com>
 <h2etb4acmmlmcvvfyh2zbwgy7bd4xeuqqyciqjw6k5zd3thmzq@vwhxpsoauli7>
 <CAGudoHFJxFOj=cbxcjmMtkzXCagg4vgfmexTG1e_Fo1M=QXt-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHFJxFOj=cbxcjmMtkzXCagg4vgfmexTG1e_Fo1M=QXt-g@mail.gmail.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 762D41F387
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,kernel.org,zeniv.linux.org.uk,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.01

On Fri 10-10-25 17:51:06, Mateusz Guzik wrote:
> On Fri, Oct 10, 2025 at 4:44 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 09-10-25 09:59:17, Mateusz Guzik wrote:
> > > +static inline void inode_state_set_raw(struct inode *inode,
> > > +                                    enum inode_state_flags_enum flags)
> > > +{
> > > +     WRITE_ONCE(inode->i_state, inode->i_state | flags);
> > > +}
> >
> > I think this shouldn't really exist as it is dangerous to use and if we
> > deal with XFS, nobody will actually need this function.
> >
> 
> That's not strictly true, unless you mean code outside of fs/inode.c
> 
> First, something is still needed to clear out the state in
> inode_init_always_gfp().
> 
> Afterwards there are few spots which further modify it without the
> spinlock held (for example see insert_inode_locked4()).
> 
> My take on the situation is that the current I_NEW et al handling is
> crap and the inode hash api is also crap.
> 
> For starters freshly allocated inodes should not be starting with 0,
> but with I_NEW.
> 
> I can agree after the dust settles there should be no _raw thing for
> filesystems to use, but getting there is beyond the scope of this
> patchset.

OK, then we are on the same page wrt the final goal. I can bear the raw
variants in the tree for some time if that makes the whole transition
easier.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

