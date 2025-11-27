Return-Path: <linux-fsdevel+bounces-70004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 354CAC8DEA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 12:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7321C4E73DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 11:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6303732C30D;
	Thu, 27 Nov 2025 11:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sqLxV5X3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i2URrXxn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oZjKf6t0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BfhflpNY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466932AADA
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764241999; cv=none; b=nKpJqhkD0mJsug5o/D0NfVp72CrO1ivFogqjgjAoU6hwev+BLfcr0wVLe9gbaeuJ1GblN3Om5UEeZWU6TbZ0BTOYld+YtWt6HEBoEcJAzqJNYojfDLAGo+m/Gzy1lMYn935Pi5B3GEYrJwNNRfA1x6IciqYxn0IOVdNgB7dmPw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764241999; c=relaxed/simple;
	bh=TW6ZbTjgpqrTAi9FSvaBl98YISSsepU5hvHxTFQKXJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FraC21qwbbFL4TlInJqErYQhnDoTAzfB3jYSC8rc7X8563AH+hoKXbvDJtvcQsr1vkMU6Rl+VE7IOD1BZlx/lCOtbu23rS4JEnr0Nr9sVYcN/k3PfqNErAQr3nrwJWMVGLSQzEhllGqPnlo5iGQd3slLLKHPrKZuMooXCnHciBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sqLxV5X3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i2URrXxn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oZjKf6t0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BfhflpNY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C4935BCCE;
	Thu, 27 Nov 2025 11:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764241996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=keGa8aE93ohGGaBTGwK+KRBLhuQbb7wyOAKGgg/6WJQ=;
	b=sqLxV5X3xGUsAj4sico7aux5kxDKpgYzy2a2itVD8BKhxQrUVZOF0+/HMJEivdjf9U1tos
	xOCHVNMWNAaSGmEcjkLRysD3wWZfBV2iy6onLtYBh8pEwe4ea2aBgiZHnMxwYbaCXEAzyc
	ICVTjBNyUoZNDbsu8hJ/j+MfdvdrvEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764241996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=keGa8aE93ohGGaBTGwK+KRBLhuQbb7wyOAKGgg/6WJQ=;
	b=i2URrXxnrB7v8gbDFDgzeKpmBHmum+t+IyiWzDRGOu8nRh4/AK/1+6v+rd9wur7YpzVp4c
	fE5I+XBn/271/dAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764241995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=keGa8aE93ohGGaBTGwK+KRBLhuQbb7wyOAKGgg/6WJQ=;
	b=oZjKf6t0xY73FN+agE27ThcyUOVZRjeFtwyo66Xf87TVTviDiGy+kJVwO1pbg/0FZ6jNtp
	FeZxOMmBS75XzMOQuiXNGOKs+rY7YNc6Y8C6ZgJinK19xyBQVb8eI2PTVBdG0941MuNaiz
	rCWmJ8lRRWj6TDw4RxQA5mIqLe06MrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764241995;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=keGa8aE93ohGGaBTGwK+KRBLhuQbb7wyOAKGgg/6WJQ=;
	b=BfhflpNYyT1FmR45oxKldWMuKM4Ioa0P0y4bWQMv6tN0UNQBwTQWUVAfjmmd3I8hPlLy8D
	qHdZdSYkDvrhXQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE3F73EA63;
	Thu, 27 Nov 2025 11:13:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P73ZOEoyKGkcSgAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Thu, 27 Nov 2025 11:13:14 +0000
Date: Thu, 27 Nov 2025 12:14:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Joel Granados <joel.granados@kernel.org>
Cc: Oliver Sang <oliver.sang@intel.com>, lkp@intel.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	oe-lkp@lists.linux.dev,
	ltp@lists.linux.itccccbjfeunckknjvluceftfithdduijkhkcinjndvek
Subject: Re: [LTP] [linux-next:master] [sysctl]  50b496351d: ltp.proc01.fail
Message-ID: <aSgygYnVBK1MxdOT@yuki.lan>
References: <202511251654.9c415e9b-lkp@intel.com>
 <aSWI07xSK9zGsivq@yuki.lan>
 <aSZnS2a4hcHWB6V7@xsang-OptiPlex-9020>
 <774fersjoa3ymtmorfoxs7xei3vjdf5h4dohkkjjgxo6qgpz5w@kqn6du5d62m7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774fersjoa3ymtmorfoxs7xei3vjdf5h4dohkkjjgxo6qgpz5w@kqn6du5d62m7>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]

Hi!
> > > > PATH=/lkp/benchmarks/ltp:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/lkp/lkp/src/bin
> > > > 2025-11-25 05:37:33 cd /lkp/benchmarks/ltp
> > > > 2025-11-25 05:37:33 export LTP_RUNTIME_MUL=2
> > > > 2025-11-25 05:37:33 export LTPROOT=/lkp/benchmarks/ltp
> > > > 2025-11-25 05:37:33 kirk -U ltp -f fs-00
> > > 
> > > Oliver can you please record the test logs with '-o results.json' and
> > > include that file in the download directory?
> > 
> > I attached one results.json FYI.
> I can see the errors and I can reproduce on my side. I'll take a look.
> thx.
> 
> BTW: I saw this path in the logs
> /proc/sys/net/ipv5/neigh/default/anycast_delay
> 
> not sure if "ipv5" is part of the suit, but worth mentioning from my
> side.

The proc01 test walks over proc files and attempts to read one after
another. It does not invent paths that are not on the system already.


-- 
Cyril Hrubis
chrubis@suse.cz

