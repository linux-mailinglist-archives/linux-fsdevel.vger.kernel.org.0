Return-Path: <linux-fsdevel+bounces-55784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8900EB0EC5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 09:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBB9562963
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 07:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAD9278E75;
	Wed, 23 Jul 2025 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="j8eVmbqy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y+6cEqra";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="amTNqtKC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BRI1RrZg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5000C278143
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257018; cv=none; b=EyFro69CQpW3EXL/FPEAF/BSinrPjpSfAgSNfmCF8xnJ4jMKm3XX68QFwWoMyHgi6E9RpPubjlx1I+tFNZAmKflq9V3I6Z+V4t/GgcLfdooTQdy95qyuHkWKas5AXdyNkIxZ2cAMVNS1nVL5yGhbIPlCYWAqNVrO76GK2cRMoek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257018; c=relaxed/simple;
	bh=1QAXiT/6WxOdRE9/064IT6VJ63xCO04wJQaCizZUFyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJqc7AYrBAEzlHZ6NC3j+cAI91TQfYnhlU0jAqJxtqzXoYwF+NawPdyTLXD59Rozo6rSdo2PrD1NIdWkTcbklkXYjm2t6qn+l3JnbuWkg0mdFJb3/ErpFelOjyKl1JbkXvJX3WpJBBV//+0mpWCt8ydF9lbIeZ8KaEsKVzMXttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=j8eVmbqy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y+6cEqra; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=amTNqtKC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BRI1RrZg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 917D621272;
	Wed, 23 Jul 2025 07:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753256589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Axxb+Stg+fwvn1mKr54jCv6xeL+8AJTCJsPJtMs1Kqg=;
	b=j8eVmbqyNZK58tPfMgq5uATfFt57D1ZG/66zN9N2Cf54fVjDwd6o+KAJSeprl71iNbKmns
	Z0oPqlhu+zhuKJ2Rapi2WAk+TRhNju4+fyg4VZ4evn+mcnXQZIEplQl4Bc5qcWPuyIPpE+
	RYpU039QLdAX4l9a1sk0HcRE1450kHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753256589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Axxb+Stg+fwvn1mKr54jCv6xeL+8AJTCJsPJtMs1Kqg=;
	b=y+6cEqra8w3iCZuHfYf4rmwvbBaoq4JLxBXteSdIxs9xEjNkdyqTQl6oVzGl8/dZDw3a6I
	cPLw+XTwaf3iRjDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753256587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Axxb+Stg+fwvn1mKr54jCv6xeL+8AJTCJsPJtMs1Kqg=;
	b=amTNqtKCUG24e13aj9q9ovT8KrzHLwhshEc7jvHePscWtHB9+u9mpZOZ9v7F1UoF9mYkpT
	r2AvmjQE8lBctLAQXDaAtSlYttsiRZZNGvEXIQ9UIXM8epu2tpsEOsWa5rliS0pF1rl82R
	KMaWMKAFMm/BMx81j3MMVVNWzNifV7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753256587;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Axxb+Stg+fwvn1mKr54jCv6xeL+8AJTCJsPJtMs1Kqg=;
	b=BRI1RrZgEAbyvadKT855SJuP3pzVmxvw+u/x3XoBnxpr0k5KGDz65nsBfqtP2k2q29xK+X
	X0xoGRmAQ0uQ6hDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79F6A13ABE;
	Wed, 23 Jul 2025 07:43:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xfa+HYuSgGgfNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Jul 2025 07:43:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6B9BAA0AD7; Wed, 23 Jul 2025 09:43:06 +0200 (CEST)
Date: Wed, 23 Jul 2025 09:43:06 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Ibrahim Jirdeh <ibrahimjirdeh@meta.com>, 
	josef@toxicpanda.com, lesha@meta.com, linux-fsdevel@vger.kernel.org, sargun@meta.com
Subject: Re: [PATCH v4 1/3] fanotify: add support for a variable length
 permission event
Message-ID: <kxsaemqmcvwrhk3f63kdzda7uef7bvuo5mqu4qy2duud4m44vb@oy2cfejdccqu>
References: <20250711183101.4074140-1-ibrahimjirdeh@meta.com>
 <20250711183101.4074140-2-ibrahimjirdeh@meta.com>
 <zliib52glfaw3vaook5xvv6h5opvnnrdo2mfh6wg26mqfouslm@etramyyx6tjb>
 <CAOQ4uxg66RuFpeVZoK8bp5S9LbcYHQxVW+uQ8LMJQzgNRu2KOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxg66RuFpeVZoK8bp5S9LbcYHQxVW+uQ8LMJQzgNRu2KOA@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 22-07-25 17:13:07, Amir Goldstein wrote:
> On Tue, Jul 22, 2025 at 4:01 PM Jan Kara <jack@suse.cz> wrote:
> > Sorry for a bit delayed reply I was busy with other work...
> >
> > On Fri 11-07-25 11:30:59, Ibrahim Jirdeh wrote:
> > > From: Amir Goldstein <amir73il@gmail.com>
> > >
> > > In preparation for pre-content events that report fid info + name,
> > > we need a new event type that is both variable length and can be
> > > put on a user response wait list.
> > >
> > > Create an event type FANOTIFY_EVENT_TYPE_FID_NAME_PERM with is a
> > > combination of the variable length fanotify_name_event prefixed
> > > with a fix length fanotify_perm_event and they share the common
> > > fanotify_event memeber.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > As a procedural note, this patch should have your Signed-off-by as well
> > Ibrahim, when you resend it as part of your patch set.
> 
> Right, but I don't think Ibrahim needs those patches anymore,
> because as you said FAN_RESTARTABLE_EVENTS do not require
> a response id.

Right, I've lost track a bit of who needs what :). So nobody is currently
striving to get the response ID changes merged? Just that I don't waste
time reviewing changes nobody is interested in at this point...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

