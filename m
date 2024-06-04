Return-Path: <linux-fsdevel+bounces-20931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F0A8FAEBC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 11:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463691F21C50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 09:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A73143898;
	Tue,  4 Jun 2024 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bFxyH7fB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kFfWpXu/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bFxyH7fB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kFfWpXu/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21461823BC
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493282; cv=none; b=PWbHuUMxj59RxvCmZQ2Pxjxqc14dDnaixABsnKSqPqoJjOp8s4pnpNr849ylAnMNnV+G5voueIQ8ORXpTN88G3MA8+Odic/OmMk45cWZ/rgvZGb5HsB+cGQxclN9toQlHv/DhuEy4fIkLDLr1WoHDSNnp3CbD2arWlfTqobcwMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493282; c=relaxed/simple;
	bh=3lMLtGlNfOHQoIHcqwyqfiXUDRgQgtlYIONEfmANOKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSJ7uFxG1z8+AVQewl33Xyn40Kz/dlpwE+lEQy6d4pHArvRlVpqRtnAprXqnp7ppjI/J1G8Ic0UPuokVF5ee3f3T9Lt7qPYtK6+98/sfE+WFj+5sKKeYCPI0r128emJfWcgi2hETVXntWzfEE4qLELyphSmH2mXgVQKenwc7lYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bFxyH7fB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kFfWpXu/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bFxyH7fB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kFfWpXu/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3694D1F7DB;
	Tue,  4 Jun 2024 09:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717493278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyu0dA5OD8cG3QzMqvCexMsipvUkaQWchy7/rf2Ho20=;
	b=bFxyH7fB6266+lvs0NOkQ1JrkP32W4aYugtetp9zR5JKvsvKs1GUXxyMse5ngS0CasnpLv
	3JVLXjLXXP5lU/rnNuhr73TqiRw6cvkPud1bI9f7ZNRZ2Epown/UJgII6xJpPRRyeXLL6S
	XuBhhiU2YjDxz13w4ErCxp2EcVsdf6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717493278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyu0dA5OD8cG3QzMqvCexMsipvUkaQWchy7/rf2Ho20=;
	b=kFfWpXu/wv26eJTtTktij99hErXFQKgH9zLenFsqb4cDuNk78yYGzFXOxvMwKxGVZb7vbl
	DpIwjqF+k/AzHvDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717493278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyu0dA5OD8cG3QzMqvCexMsipvUkaQWchy7/rf2Ho20=;
	b=bFxyH7fB6266+lvs0NOkQ1JrkP32W4aYugtetp9zR5JKvsvKs1GUXxyMse5ngS0CasnpLv
	3JVLXjLXXP5lU/rnNuhr73TqiRw6cvkPud1bI9f7ZNRZ2Epown/UJgII6xJpPRRyeXLL6S
	XuBhhiU2YjDxz13w4ErCxp2EcVsdf6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717493278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyu0dA5OD8cG3QzMqvCexMsipvUkaQWchy7/rf2Ho20=;
	b=kFfWpXu/wv26eJTtTktij99hErXFQKgH9zLenFsqb4cDuNk78yYGzFXOxvMwKxGVZb7vbl
	DpIwjqF+k/AzHvDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D2471398F;
	Tue,  4 Jun 2024 09:27:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8uD+Ch7eXma0KwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Jun 2024 09:27:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D0172A086D; Tue,  4 Jun 2024 11:27:57 +0200 (CEST)
Date: Tue, 4 Jun 2024 11:27:57 +0200
From: Jan Kara <jack@suse.cz>
To: JunChao Sun <sunjunchao2870@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	Jan Kara <jack@suse.cz>
Subject: Re: Is is reasonable to support quota in fuse?
Message-ID: <20240604092757.k5kkc67j3ssnc6um@quack3>
References: <CAHB1NaicRULmaq8ks4JCtc3ay3AQ9mG77jc5t_bNdn3wMwMrMg@mail.gmail.com>
 <CAJfpegsELV80nfYUP0CvbE=c45re184T4_WtUEhhfRGVmpmpcQ@mail.gmail.com>
 <CAHB1NaiddGRxh7UjaXejWsYnJY52dYDvaB2oZpqQXqVocxTm+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB1NaiddGRxh7UjaXejWsYnJY52dYDvaB2oZpqQXqVocxTm+w@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,szeredi.hu:email]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On Tue 04-06-24 14:54:01, JunChao Sun wrote:
> Miklos Szeredi <miklos@szeredi.hu> 于2024年6月4日周二 14:40写道：
> >
> > On Mon, 3 Jun 2024 at 13:37, JunChao Sun <sunjunchao2870@gmail.com> wrote:
> >
> > > Given these challenges, I would like to inquire about the community's
> > > perspective on implementing quota functionality at the FUSE kernel
> > > part. Is it feasible to implement quota functionality in the FUSE
> > > kernel module, allowing users to set quotas for FUSE just as they
> > > would for ext4 (e.g., using commands like quotaon /mnt/fusefs or
> > > quotaset /mnt/fusefs)?  Would the community consider accepting patches
> > > for this feature?
> >
> >
> > > I would say yes, but I have no experience with quota in any way, so
> > > cannot help with the details.
> 
> Thanks for your reply. I'd like try to implement this feature.

Nice idea! But before you go and spend a lot of time trying to implement
something, I suggest that you write down a design how you imagine all this
to work and we can talk about it. Questions like: Do you have particular
usecases in mind? Where do you plan to perform the accounting /
enforcement? Where do you want to store quota information? How do you want
to recover from unclean shutdowns? Etc...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

