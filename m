Return-Path: <linux-fsdevel+bounces-8616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D923F8398F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 20:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 088AC1C29933
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 19:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7E285C40;
	Tue, 23 Jan 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uA1KO9rD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kMdikD+i";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DouiawT3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DF8gGY22"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E6A811EE;
	Tue, 23 Jan 2024 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036186; cv=none; b=J6TVhIFUO/P/RinWfPSDExSsq41qMHbVkeAKH0OklBrpW1cCJ2pTkswW+mCNAQcsgoWy7drHAULxGRILy5hCP49wv/dj93qi+qbhuBR5EWNuaMGTW/WPSJ4Y9Iqz6UD+SORtGhP0qB+MqzuQoFcHZSump4m2fDoTkp9VdWtQyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036186; c=relaxed/simple;
	bh=yMVwDPGxmW1hBgGbumiN4jovYOk6hgd3lGDtpib0Q+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBDJkB+/maw94CSONuTphitRPMIp7c5AyIpH29mlvOPIlCpvczYg/VukNYNGOZMPnQZnsW7KyKxGHVqesFoVtqj5KjmKu0oEar3zD/vntDjn9ZDwLPzqgPUcLElWJJLAJkCm7/xWHQXYUkpdchBGcTkPTgtkgjjo1Qw3ydwRxRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uA1KO9rD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kMdikD+i; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DouiawT3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DF8gGY22; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2EE41F79C;
	Tue, 23 Jan 2024 18:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706036183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n50lANKb1Xnko9FAuo+Gr5gF/E9aejtyu77w24xrRRU=;
	b=uA1KO9rDe4tA7xmZr3uNJ3k8XL4liA8dpeYtjrez03tKtSMJTHnVcxr5tJRmoNBpLTSX6d
	7Sa1CFvJOWtp+MayRrTY7a+kbbY3kHah7tplqAphIFbcqwFHg9BEnByXJc5LPsdt5ORvE5
	hyvUlHqgkH9KzCiiOwTsRf23/ts7w+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706036183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n50lANKb1Xnko9FAuo+Gr5gF/E9aejtyu77w24xrRRU=;
	b=kMdikD+ivOe3J9NcCRX1htYLcGH1shTOuP0W+421/niu2BIOftySD6OAfHqOzPgwI0Vj87
	80VjI3Yvwd5gXrBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706036182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n50lANKb1Xnko9FAuo+Gr5gF/E9aejtyu77w24xrRRU=;
	b=DouiawT3n5aqnqt0Sy5BaVxbnbnRvYqywh3k3FFzoXzkuNwCkYXNrt1D8sm0RvIYcJ7tsw
	kzy9rkUPAeUmYSCXsyyZtKWqjxEszQlm1btn1iPTelBuX1nGTDlBwoAmB/NjyMuNr50fN+
	Y0YJ0h3VL/XCfXn8RBB3EvqxalywXLY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706036182;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n50lANKb1Xnko9FAuo+Gr5gF/E9aejtyu77w24xrRRU=;
	b=DF8gGY22DQ7MWI8H1F0Cho241CTTJrootUzz7JubK98p6ynCN5qUrD9LGAq7S96Oe4XQOg
	WWMDkkpVOJXFqkBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF9E713786;
	Tue, 23 Jan 2024 18:56:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rBhqMtYLsGWJOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 18:56:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 291B8A0803; Tue, 23 Jan 2024 19:56:22 +0100 (CET)
Date: Tue, 23 Jan 2024 19:56:22 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Baokun Li <libaokun1@huawei.com>, torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, willy@infradead.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] fs: make the i_size_read/write helpers be
 smp_load_acquire/store_release()
Message-ID: <20240123185622.ssscyrrw5mjqjdyh@quack3>
References: <20240122094536.198454-1-libaokun1@huawei.com>
 <20240122-gepokert-mitmachen-6d6ba8d2f0a8@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-gepokert-mitmachen-6d6ba8d2f0a8@brauner>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DouiawT3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=DF8gGY22
X-Spamd-Result: default: False [0.19 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[17.09%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 0.19
X-Rspamd-Queue-Id: E2EE41F79C
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Mon 22-01-24 12:14:52, Christian Brauner wrote:
> On Mon, 22 Jan 2024 17:45:34 +0800, Baokun Li wrote:
> > This patchset follows the linus suggestion to make the i_size_read/write
> > helpers be smp_load_acquire/store_release(), after which the extra smp_rmb
> > in filemap_read() is no longer needed, so it is removed.
> > 
> > Functional tests were performed and no new problems were found.
> > 
> > Here are the results of unixbench tests based on 6.7.0-next-20240118 on
> > arm64, with some degradation in single-threading and some optimization in
> > multi-threading, but overall the impact is not significant.
> > 
> > [...]
> 
> Hm, we can certainly try but I wouldn't rule it out that someone will
> complain aobut the "non-significant" degradation in single-threading.
> We'll see. Let that performance bot chew on it for a bit as well.

Yeah, over 5% regression in buffered read/write cost is a bit hard to
swallow. I somewhat wonder why this is so much - maybe people call
i_size_read() without thinking too much and now it becomes atomic op on
arm? Also LKP tests only on x86 (where these changes are going to be
for noop) and I'm not sure anybody else runs performance tests on
linux-next, even less so on ARM... So not sure anybody will complain until
this gets into some distro (such as Android).

> But I agree that the smp_load_acquire()/smp_store_release() is clearer
> than the open-coded smp_rmb().

Agreed, conceptually this is nice and it will also silence some KCSAN
warnings about i_size updates vs reads.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

