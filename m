Return-Path: <linux-fsdevel+bounces-62490-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A379B95598
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 11:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7297318A26A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Sep 2025 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7CD320CA4;
	Tue, 23 Sep 2025 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UHX7qx7o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ruU2lr8c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UHX7qx7o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ruU2lr8c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E518027
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Sep 2025 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621445; cv=none; b=LBouHFsxEVc98R94lWjXc44drGejnY9R/eqJ5SowzEBw3nnLYC6lzpOYD+a8RmIzZQoF8Q6B4WEA02Wjs744EI5H3So+RPexc9muBAv6/CMFH7coe6CKlzbwFYXadHZOUGGCEg7zVIV+55/lW8dd7w0OxzBlh0Ode6sqmjVZP0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621445; c=relaxed/simple;
	bh=/MMAFSrPWQcfJiRsKFcdCNayN8FwsiJm0spR01tbdAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlXPT2+GGTPuuPnaEOkygvjVfN5+r2rmkB2x0wlOdlV4r7qWlz3h/KNO+1IFum6uzKVBklXuCCqTks6p9p6RntqyMnWYuS+Ruj93Fm1w5ANs1onfXnjy/6iWIEP+/IFiJYcaiGgH78te7moYzSR1rmjdPERi9jG7KgEPYijZj1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UHX7qx7o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ruU2lr8c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UHX7qx7o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ruU2lr8c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B2A421FCE;
	Tue, 23 Sep 2025 09:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758621442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oPVjjucApSRx+R2misnP6FirOYmaZeSfZK2uZlsWJVE=;
	b=UHX7qx7o2b6ey5mBgk7knXhSh5NAomprqW21FOo3+i6AoaYjVxzuMInDFqJq5xlD0jN7jE
	l9RdrJAOT9uA5RmNnoc82zw3jNRxsSqGPknIFbKilV4hihF0zw/YTsm6ByAapLHTsAV9VO
	57CJylLPXR5bzh84ywSpKTnl/NrVnCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758621442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oPVjjucApSRx+R2misnP6FirOYmaZeSfZK2uZlsWJVE=;
	b=ruU2lr8cQiR7fVNcl8XuNGkvChlzJ0Fo5o5rGdZZM/dtI4Hc971GO4eoOvVJcuZVXmHi3x
	ko66sHZwAV6xxTDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UHX7qx7o;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ruU2lr8c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758621442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oPVjjucApSRx+R2misnP6FirOYmaZeSfZK2uZlsWJVE=;
	b=UHX7qx7o2b6ey5mBgk7knXhSh5NAomprqW21FOo3+i6AoaYjVxzuMInDFqJq5xlD0jN7jE
	l9RdrJAOT9uA5RmNnoc82zw3jNRxsSqGPknIFbKilV4hihF0zw/YTsm6ByAapLHTsAV9VO
	57CJylLPXR5bzh84ywSpKTnl/NrVnCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758621442;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oPVjjucApSRx+R2misnP6FirOYmaZeSfZK2uZlsWJVE=;
	b=ruU2lr8cQiR7fVNcl8XuNGkvChlzJ0Fo5o5rGdZZM/dtI4Hc971GO4eoOvVJcuZVXmHi3x
	ko66sHZwAV6xxTDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A5E5132C9;
	Tue, 23 Sep 2025 09:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BUaAAgJv0mh0YQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Sep 2025 09:57:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A67B1A09AF; Tue, 23 Sep 2025 11:57:21 +0200 (CEST)
Date: Tue, 23 Sep 2025 11:57:21 +0200
From: Jan Kara <jack@suse.cz>
To: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Nanhai Zou <nanhai.zou@intel.com>, 
	Gang Deng <gang.deng@intel.com>, Tianyou Li <tianyou.li@intel.com>, 
	Vinicius Gomes <vinicius.gomes@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Chen Yu <yu.c.chen@intel.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH] mm/readahead: Skip fully overlapped range
Message-ID: <cghebadvzchca3lo2cakcihwyoexx7fdqtibfywfm4xjo7eyp2@vbccezepgtoe>
References: <20250923035946.2560876-1-aubrey.li@linux.intel.com>
 <20250922204921.898740570c9a595c75814753@linux-foundation.org>
 <93f7e2ad-563b-4db5-bab6-4ce2e994dbae@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f7e2ad-563b-4db5-bab6-4ce2e994dbae@linux.intel.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1B2A421FCE
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Tue 23-09-25 13:11:37, Aubrey Li wrote:
> On 9/23/25 11:49, Andrew Morton wrote:
> > On Tue, 23 Sep 2025 11:59:46 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:
> > 
> >> RocksDB sequential read benchmark under high concurrency shows severe
> >> lock contention. Multiple threads may issue readahead on the same file
> >> simultaneously, which leads to heavy contention on the xas spinlock in
> >> filemap_add_folio(). Perf profiling indicates 30%~60% of CPU time spent
> >> there.
> >>
> >> To mitigate this issue, a readahead request will be skipped if its
> >> range is fully covered by an ongoing readahead. This avoids redundant
> >> work and significantly reduces lock contention. In one-second sampling,
> >> contention on xas spinlock dropped from 138,314 times to 2,144 times,
> >> resulting in a large performance improvement in the benchmark.
> >>
> >> 				w/o patch       w/ patch
> >> RocksDB-readseq (ops/sec)
> >> (32-threads)			1.2M		2.4M
> > 
> > On which kernel version?  In recent times we've made a few readahead
> > changes to address issues with high concurrency and a quick retest on
> > mm.git's current mm-stable branch would be interesting please.
> 
> I'm on v6.16.7. Thanks Andrew for the information, let me check with mm.git.

I don't expect much of a change for this load but getting test result with
mm.git as a confirmation would be nice. Also, based on the fact that the
patch you propose helps, this looks like there are many threads sharing one
struct file which race to read the same content. That is actually rather
problematic for current readahead code because there's *no synchronization*
on updating file's readhead state. So threads can race and corrupt the
state in interesting ways under one another's hands. On rare occasions I've
observed this with heavy NFS workload where the NFS server is
multithreaded. Since the practical outcome is "just" reduced read
throughput / reading too much, it was never high enough on my priority list
to fix properly (I do have some preliminary patch for that laying around
but there are some open questions that require deeper thinking - like how
to handle a situation where one threads does readahead, filesystem requests
some alignment of the request size after the fact, so we'd like to update
readahead state but another thread has modified the shared readahead state
in the mean time).  But if we're going to work on improving behavior of
readahead for multiple threads sharing readahead state, fixing the code so
that readahead state is at least consistent is IMO the first necessary
step. And then we can pile more complex logic on top of that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

