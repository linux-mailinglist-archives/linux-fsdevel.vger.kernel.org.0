Return-Path: <linux-fsdevel+bounces-23104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A739273A4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 12:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17ECD1F2702A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 10:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BB21AB907;
	Thu,  4 Jul 2024 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MKzBvm8J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="107LPPl3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="twWpHAt9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kJq0cezH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18E18637;
	Thu,  4 Jul 2024 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720087639; cv=none; b=CkOCOizp085dUgFx9MGSfcCVfrUfUbcDJofqMX3QDfbkSJ67ilWBHxZ1K921WtTXAaM+xym8XVNqRhCun+YAfoILhTC8ptfCwiFRGMUvj45v8LB1nDA6uVkBzgNJrmLbg3/Eo93OrRMgx8uESU+8iBYnZZ/s/ugOJbmcTIASLr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720087639; c=relaxed/simple;
	bh=hxsuoh71wfORW3jgVluGq83IqgoV8iRPXbKMm5fjJD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYRFQIiAUhGGcI0F52vTjiBN61uUt4sFD8BEWTW+pICsL4E5Oz4uoGWgNDfZ7lJdT/LueXkVMr1BxQEf3VlwgSnTg9xBLueaHDovtod7o8cQNPmLliWld1PRnWLS1I3IId3zjh33UnkguQveFvJXoXPW9zD+STDxCekPICgyCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MKzBvm8J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=107LPPl3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=twWpHAt9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kJq0cezH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D00CE1F7B7;
	Thu,  4 Jul 2024 10:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720087636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bc+TSGhY4xzlZZbkOaKUVRj2Dc5/7oDx0D4PudXyKVQ=;
	b=MKzBvm8JaWou4CMDx4D8fnc7Xf9t+QRg9Yym68ZzH1qZClM2HEDTfM9d+EZm1HItrbTYav
	WmNyK4dy5f2HVK2z09l6yyTkDyY1nwi2PhXvRoFd32doe19k3nIkRiz6agM29cAcS56aU8
	n/qM0ueVQzZnEvhmhr3XNRzHr4KhOGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720087636;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bc+TSGhY4xzlZZbkOaKUVRj2Dc5/7oDx0D4PudXyKVQ=;
	b=107LPPl3svmk5c2OuM1wpdzZ8E5h0KgoHYKG2wqoq+l+wzOkxu8m29hZIvjiE4YONq2Aru
	PQ5AFlN3hF00JuCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720087635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bc+TSGhY4xzlZZbkOaKUVRj2Dc5/7oDx0D4PudXyKVQ=;
	b=twWpHAt9+XrprrkgBKJcUjYYTGsuyVDdxqL9sYPlXnmfLHbJn6QqQ/ojKgixpU7XtdGxBi
	BojLc3fmJufcTV5uSdN3MpSl/6jauva+prwnz8AetdutgDhtYqDZXWAjDlPbECw4ciW/Z1
	Xa9U4I7OZveki6G71OKrXI9lfpxMXqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720087635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bc+TSGhY4xzlZZbkOaKUVRj2Dc5/7oDx0D4PudXyKVQ=;
	b=kJq0cezHBMKsAISBqvbzpMiEHPuRiFPkYrbHwqVcBNXQTwnCQG41tPp4eGBleicG5VkVnc
	S4KBMfxTBAm68XCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0FA71369F;
	Thu,  4 Jul 2024 10:07:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c/jKLlN0hma9YQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jul 2024 10:07:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7230EA088E; Thu,  4 Jul 2024 12:07:15 +0200 (CEST)
Date: Thu, 4 Jul 2024 12:07:15 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Yu Ma <yu.ma@intel.com>, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, edumazet@google.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, pan.deng@intel.com,
	tianyou.li@intel.com, tim.c.chen@intel.com,
	tim.c.chen@linux.intel.com
Subject: Re: [PATCH v3 3/3] fs/file.c: add fast path in find_next_fd()
Message-ID: <20240704100715.6mlnuusse6iv64ny@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240703143311.2184454-1-yu.ma@intel.com>
 <20240703143311.2184454-4-yu.ma@intel.com>
 <CAGudoHEcb3g16O1daqGdViHoPEnEC7iJ-Z2B+ZC9JA9LucimDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHEcb3g16O1daqGdViHoPEnEC7iJ-Z2B+ZC9JA9LucimDA@mail.gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,intel.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 03-07-24 16:17:01, Mateusz Guzik wrote:
> On Wed, Jul 3, 2024 at 4:07 PM Yu Ma <yu.ma@intel.com> wrote:
> >
> > There is available fd in the lower 64 bits of open_fds bitmap for most cases
> > when we look for an available fd slot. Skip 2-levels searching via
> > find_next_zero_bit() for this common fast path.
> >
> > Look directly for an open bit in the lower 64 bits of open_fds bitmap when a
> > free slot is available there, as:
> > (1) The fd allocation algorithm would always allocate fd from small to large.
> > Lower bits in open_fds bitmap would be used much more frequently than higher
> > bits.
> > (2) After fdt is expanded (the bitmap size doubled for each time of expansion),
> > it would never be shrunk. The search size increases but there are few open fds
> > available here.
> > (3) There is fast path inside of find_next_zero_bit() when size<=64 to speed up
> > searching.
> >
> > As suggested by Mateusz Guzik <mjguzik gmail.com> and Jan Kara <jack@suse.cz>,
> > update the fast path from alloc_fd() to find_next_fd(). With which, on top of
> > patch 1 and 2, pts/blogbench-1.1.0 read is improved by 13% and write by 7% on
> > Intel ICX 160 cores configuration with v6.10-rc6.
> >
> > Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> > Signed-off-by: Yu Ma <yu.ma@intel.com>
> > ---
> >  fs/file.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/fs/file.c b/fs/file.c
> > index a15317db3119..f25eca311f51 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -488,6 +488,11 @@ struct files_struct init_files = {
> >
> >  static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
> >  {
> > +       unsigned int bit;
> > +       bit = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, start);
> > +       if (bit < BITS_PER_LONG)
> > +               return bit;
> > +
> 
> The rest of the patchset looks good on cursory read.
> 
> As for this one, the suggestion was to make it work across the entire range.

I'm not sure what do you exactly mean by "make it work across the entire
range" because what Ma has implemented is exactly what I originally had in
mind - i.e., search the first word of open_fds starting from next_fd (note
that 'start' in this function is already set to max(start, next_fd)), if
that fails, go through the two level bitmap.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

