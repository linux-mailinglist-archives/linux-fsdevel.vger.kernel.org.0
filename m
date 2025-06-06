Return-Path: <linux-fsdevel+bounces-50835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8552AD00D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 12:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756921895DD0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 10:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65966287517;
	Fri,  6 Jun 2025 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RUk9OlUj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kq531umt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RUk9OlUj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kq531umt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7F2874FB
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749207260; cv=none; b=u4F5B74aMEY+RFjx8Z/GybnMA9HiCydcifEIyMpjKJ5GBy6/XDaIRE4T6aDCo77cFj9glt+uFeODu9uxY0sxUL5q3RcJ5HZ10LzafP9Ja7t1l3m5OL34+1Rxft30oXXV2WbZ1KP65zrS5WLOAXIfMsT11Omx4Z1n/cFDijqHne4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749207260; c=relaxed/simple;
	bh=yLMp0stnknfWTQ9MudqOyXhSE5L6h8zVutcH0wb97p8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iz3GYIuofsdULkxcK67/kZvW97alTfI9UCYHiDWInyfkDOf2dbuzCkGvXs5p3tqjdJ5kb4C2drIECAcmL+4Q6zYlcnvHtsGB31PGrfckkZ9umysks0L4f4s5ISMck2YzPjTLbxMA82sSLripHRkx1DWNZhvTlTZdsOWJGosHw8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RUk9OlUj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kq531umt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RUk9OlUj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kq531umt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 295253368A;
	Fri,  6 Jun 2025 10:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749207256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ew054TM1gF94MAbHnxCooxRjNeN0J3AbhNTO/vAqYtY=;
	b=RUk9OlUjGhBWX6JlHVAinvcmdfRjfzEs0gvYQnobgiLNSOwg0A1bA4tdt9sqddXseX3vMc
	IuDzdSl9rrjPMpN/FFkOIAvByfjrxzaeO3zTwiO1d7Kdg+FRzHojxYpLdbNb9YpREbpPqF
	sBBSTefAiNoecfIjoKkeR/nRP76QFcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749207256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ew054TM1gF94MAbHnxCooxRjNeN0J3AbhNTO/vAqYtY=;
	b=Kq531umtRfvG15Tgw9dKgXh391N5q5/XoVjdg9QK6q5jknYp4YF01Yu/aEUHnruwmdjL2T
	r4l0vK71/NIKfODA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749207256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ew054TM1gF94MAbHnxCooxRjNeN0J3AbhNTO/vAqYtY=;
	b=RUk9OlUjGhBWX6JlHVAinvcmdfRjfzEs0gvYQnobgiLNSOwg0A1bA4tdt9sqddXseX3vMc
	IuDzdSl9rrjPMpN/FFkOIAvByfjrxzaeO3zTwiO1d7Kdg+FRzHojxYpLdbNb9YpREbpPqF
	sBBSTefAiNoecfIjoKkeR/nRP76QFcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749207256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ew054TM1gF94MAbHnxCooxRjNeN0J3AbhNTO/vAqYtY=;
	b=Kq531umtRfvG15Tgw9dKgXh391N5q5/XoVjdg9QK6q5jknYp4YF01Yu/aEUHnruwmdjL2T
	r4l0vK71/NIKfODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1ED5E1369F;
	Fri,  6 Jun 2025 10:54:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CsJ/B9jIQmh8OQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Jun 2025 10:54:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D02D0A0951; Fri,  6 Jun 2025 12:54:15 +0200 (CEST)
Date: Fri, 6 Jun 2025 12:54:15 +0200
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, Chi Zhiling <chizhiling@163.com>, 
	willy@infradead.org, josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] readahead: fix return value of page_cache_next_miss()
 when no hole is found
Message-ID: <i2zcz37av7oon464vj4jqvmyz53j46kpd6427xmpamukcqekro@hg566sdiruba>
References: <20250605054935.2323451-1-chizhiling@163.com>
 <qbuhdfdvbyida5y7g34o4rf5s5ntx462ffy3wso3pb5f3t4pev@3hqnswkp7of6>
 <20250605145152.9ae3edb99f29ef46b30096e4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605145152.9ae3edb99f29ef46b30096e4@linux-foundation.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,163.com,infradead.org,toxicpanda.com,vger.kernel.org,kvack.org,kylinos.cn];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 

On Thu 05-06-25 14:51:52, Andrew Morton wrote:
> On Thu, 5 Jun 2025 10:22:23 +0200 Jan Kara <jack@suse.cz> wrote:
> 
> > On Thu 05-06-25 13:49:35, Chi Zhiling wrote:
> > > From: Chi Zhiling <chizhiling@kylinos.cn>
> > > 
> > > max_scan in page_cache_next_miss always decreases to zero when no hole
> > > is found, causing the return value to be index + 0.
> > > 
> > > Fix this by preserving the max_scan value throughout the loop.
> > > 
> > > Fixes: 901a269ff3d5 ("filemap: fix page_cache_next_miss() when no hole found")
> > > Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> > 
> > Indeed. Thanks for catching this. Don't know how I missed that. Feel free
> > to add:
> > 
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > 
> 
> Thanks.  It's a simple patch - do we expect it to have significant
> runtime effects?

I'm not sure if Chi Zhiling observed some practical effects. From what I
know and have seen in the past, wrong responses from page_cache_next_miss()
can lead to readahead window reduction and thus reduced read speeds.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

