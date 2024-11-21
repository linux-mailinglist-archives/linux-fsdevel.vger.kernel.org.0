Return-Path: <linux-fsdevel+bounces-35411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2158E9D4B6B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85652B24BFF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B111D151F;
	Thu, 21 Nov 2024 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vpyrFgGY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NLQCsoPk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vpyrFgGY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NLQCsoPk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00014BF87;
	Thu, 21 Nov 2024 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187808; cv=none; b=b7qL+6BCbLXQ3LN3e4bTnbIqAgUowxiiWRlFkEqCZ1ttMZfUPFU7x6pxXQeWGJed0JAhWDfi8VcmuTYlNTA1baiirnGPpNUJT9A5JjzjhFxmFmKrSoGi+H9PxbFMpUMFHJtW9xNTkJ48bVz4ZDxT1AkZGhOMEPeVGoKtifqknq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187808; c=relaxed/simple;
	bh=/O0aOpgtlnZw2iUbI6fRTObWtPMku+Z9mvWO/9PAk7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OHwm94xy2ldT/VK0dP7q/w/PJJgDZKkYv/owBFloPDwwzCqsQuuJU0UnV8NPSZhzXWuAJvPcSf7tO21uqhrSwk3xieJzwUdzWlt3F5+n+shdV/9vsqjxE7IM+eXD0XlV+mYpcjsOjk6yRySkJC48W9EjNKCBX103df3YxjJsS58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vpyrFgGY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NLQCsoPk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vpyrFgGY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NLQCsoPk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8A6B11F800;
	Thu, 21 Nov 2024 11:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732187804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OO3PiFMSVMzJJNLk3EErxSTVlpJaS5ys4vHrrygEOx0=;
	b=vpyrFgGYPbLysXQTkhAwkgafmzcuWtDagZ+kEtMsYu23SuwnRwY2mZrgbqiFJevWTOtHyU
	ilGPMT9oJbOHcqaZtxDR6K19jMzja3h5PzTrwS+9wyajBpagf8PAczKfXEa6l7Q1DBAAu8
	k1hSJLen9A1awEYNIhFXuJU5BhahU8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732187804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OO3PiFMSVMzJJNLk3EErxSTVlpJaS5ys4vHrrygEOx0=;
	b=NLQCsoPkUtM3JKWpx4YvqUx8eeiWKIxDZyA8FB81qe09O12lwWgUuB2D0BwRApsvAga2Z6
	eP+yNFPFQHj7HhDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732187804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OO3PiFMSVMzJJNLk3EErxSTVlpJaS5ys4vHrrygEOx0=;
	b=vpyrFgGYPbLysXQTkhAwkgafmzcuWtDagZ+kEtMsYu23SuwnRwY2mZrgbqiFJevWTOtHyU
	ilGPMT9oJbOHcqaZtxDR6K19jMzja3h5PzTrwS+9wyajBpagf8PAczKfXEa6l7Q1DBAAu8
	k1hSJLen9A1awEYNIhFXuJU5BhahU8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732187804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OO3PiFMSVMzJJNLk3EErxSTVlpJaS5ys4vHrrygEOx0=;
	b=NLQCsoPkUtM3JKWpx4YvqUx8eeiWKIxDZyA8FB81qe09O12lwWgUuB2D0BwRApsvAga2Z6
	eP+yNFPFQHj7HhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D0FC137CF;
	Thu, 21 Nov 2024 11:16:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KJSAHpwWP2clfQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:16:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3B6C4A089E; Thu, 21 Nov 2024 12:16:44 +0100 (CET)
Date: Thu, 21 Nov 2024 12:16:44 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk, linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH v8 02/19] fsnotify: opt-in for permission events at file
 open time
Message-ID: <20241121111644.y63uejriiti4vce5@quack3>
References: <cover.1731684329.git.josef@toxicpanda.com>
 <5ea5f8e283d1edb55aa79c35187bfe344056af14.1731684329.git.josef@toxicpanda.com>
 <20241120155309.lecjqqhohgcgyrkf@quack3>
 <CAOQ4uxgjOZN_=BM3DuLLZ8Vzdh-q7NYKhMnF0p_NveYd=e7vdA@mail.gmail.com>
 <20241121093918.d2ml5lrfcqwknffb@quack3>
 <20241121-satirisch-siehst-5cdabde2ff67@brauner>
 <CAOQ4uxgL1p2P1e2AkHLHiicKXa9cwrFNkHy-oXsdGKA9EkDb6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgL1p2P1e2AkHLHiicKXa9cwrFNkHy-oXsdGKA9EkDb6g@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 21-11-24 12:04:23, Amir Goldstein wrote:
> On Thu, Nov 21, 2024 at 11:09 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > > It is not that I object to "two bit constants". FMODE_FSNOTIFY_MASK is a
> > > two-bit constant and a good one. But the name clearly suggests it is not a
> > > single bit constant. When you have all FMODE_FOO and FMODE_BAR things
> > > single bit except for FMODE_BAZ which is multi-bit, then this is IMHO a
> > > recipe for problems and I rather prefer explicitely spelling the
> > > combination out as FMODE_NONOTIFY | FMODE_NONOTIFY_PERM in the few places
> > > that need this instead of hiding it behind some other name.
> >
> > Very much agreed!
> 
> Yes, I agree as well.
> What I meant is that the code that does
>     return FMODE_NONOTIFY | FMODE_NONOTIFY_PERM;
> 
> is going to be unclear to the future code reviewer unless there is
> a comment above explaining that this is a special flag combination
> to specify "suppress only pre-content events".

So this combination is used in file_set_fsnotify_mode() only (three
occurences) and there I have:

        /*
         * If there are permission event watchers but no pre-content event
         * watchers, set FMODE_NONOTIFY | FMODE_NONOTIFY_PERM to indicate that.
         */

at the first occurence. So hopefully that's enough of an explanation.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

