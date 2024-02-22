Return-Path: <linux-fsdevel+bounces-12449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB1885F776
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 12:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914F12857AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Feb 2024 11:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6576B381B8;
	Thu, 22 Feb 2024 11:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OQ9WENxL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KTjgGJO9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OQ9WENxL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KTjgGJO9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A6F208A2;
	Thu, 22 Feb 2024 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602645; cv=none; b=W286EtR+tytwa4n/8e1f8THEl7/BHafn1qsaZB75dM2hldZNinXK7Ln5o7srWG92+I3o4G1MRQDhO25OF2HbUwBsIpIZDP99apwOceapaIpAIqLhRUN3U7pkJOhM45AzdIf+ysuTyZ/knMMbhQBjRA8K5mZW7Xke3wGM6XcSXWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602645; c=relaxed/simple;
	bh=HgRKsDY0PLOGMDAasKMEGBLFqk2ft8ubOfJfMmQV5N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyvijNzmzbTZXOlRww/VEJEZ91pGIJ9G9LgTjbUgpQGm/7ELrQPeMBJDtutcj3zSqOO5vgFPbA6l5EnZLomNjhpujgJZ24UeoQ3vu+jZRlwxjO1bK6NK+0f9WNMGnw4KByVJlRDpql1hk/k4qFmeTDP1c9cBiyLYDH4vH9HfZ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OQ9WENxL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KTjgGJO9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OQ9WENxL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KTjgGJO9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 36555222B5;
	Thu, 22 Feb 2024 11:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708602641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=liUtPNlK9kyLGztd5stD/0r54k1A7gG6pWsCn6Vb0e0=;
	b=OQ9WENxLJThQnmKrDmZe1chLMzOPrUbrUEsnGFbRdYTDxD58soTl6ZgUGxOHmG8FAzZatV
	4C4waoX+yHTn87c+gfwbhRmeejfVvhgkrx5fwHC2qPF8wjIWl6crPYMBDP9a1zVF2Ib5ZZ
	G5at/OK0iLTwQDGs8gTo5EPKi29S7aU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708602641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=liUtPNlK9kyLGztd5stD/0r54k1A7gG6pWsCn6Vb0e0=;
	b=KTjgGJO9gucsDYuF8huMNLLkVx+dd1XuU5vwqpAGnq57bT98ATwNnY58Gub9QH/XYEYLON
	e8dQCy4lQg30zbCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708602641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=liUtPNlK9kyLGztd5stD/0r54k1A7gG6pWsCn6Vb0e0=;
	b=OQ9WENxLJThQnmKrDmZe1chLMzOPrUbrUEsnGFbRdYTDxD58soTl6ZgUGxOHmG8FAzZatV
	4C4waoX+yHTn87c+gfwbhRmeejfVvhgkrx5fwHC2qPF8wjIWl6crPYMBDP9a1zVF2Ib5ZZ
	G5at/OK0iLTwQDGs8gTo5EPKi29S7aU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708602641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=liUtPNlK9kyLGztd5stD/0r54k1A7gG6pWsCn6Vb0e0=;
	b=KTjgGJO9gucsDYuF8huMNLLkVx+dd1XuU5vwqpAGnq57bT98ATwNnY58Gub9QH/XYEYLON
	e8dQCy4lQg30zbCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 293E513A6B;
	Thu, 22 Feb 2024 11:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id B8QKChE112ViQAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 22 Feb 2024 11:50:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C9950A0807; Thu, 22 Feb 2024 12:50:32 +0100 (CET)
Date: Thu, 22 Feb 2024 12:50:32 +0100
From: Jan Kara <jack@suse.cz>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Jan Kara <jack@suse.cz>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Guo Xuenan <guoxuenan@huawei.com>, linux-fsdevel@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [readahead]  ab4443fe3c:
 vm-scalability.throughput -21.4% regression
Message-ID: <20240222115032.u5h2phfxpn77lu5a@quack3>
References: <202402201642.c8d6bbc3-oliver.sang@intel.com>
 <20240221111425.ozdozcbl3konmkov@quack3>
 <ZdakRFhEouIF5o6D@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdakRFhEouIF5o6D@xsang-OptiPlex-9020>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[31.24%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.40

Hello,

On Thu 22-02-24 09:32:52, Oliver Sang wrote:
> On Wed, Feb 21, 2024 at 12:14:25PM +0100, Jan Kara wrote:
> > On Tue 20-02-24 16:25:37, kernel test robot wrote:
> > > kernel test robot noticed a -21.4% regression of vm-scalability.throughput on:
> > > 
> > > commit: ab4443fe3ca6298663a55c4a70efc6c3ce913ca6 ("readahead: avoid multiple marked readahead pages")
> > > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > 
> > > testcase: vm-scalability
> > > test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
> > > parameters:
> > > 
> > > 	runtime: 300s
> > > 	test: lru-file-readtwice
> > > 	cpufreq_governor: performance
> > 
> > JFYI I had a look into this. What the test seems to do is that it creates
> > image files on tmpfs, loopmounts XFS there, and does reads over file on
> > XFS. But I was not able to find what lru-file-readtwice exactly does,
> > neither I was able to reproduce it because I got stuck on some missing Ruby
> > dependencies on my test system yesterday.
> 
> what's your OS?

I have SLES15-SP4 installed in my VM. What was missing was 'git' rubygem
which apparently is not packaged at all and when I manually installed it, I
was still hitting other problems so I rather went ahead and checked the
vm-scalability source and wrote my own reproducer based on that.

I'm now able to reproduce the regression in my VM so I'm investigating...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

