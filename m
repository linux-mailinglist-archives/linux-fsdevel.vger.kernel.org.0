Return-Path: <linux-fsdevel+bounces-22622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E43491A646
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 14:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51AEF1C242A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 12:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F6515278B;
	Thu, 27 Jun 2024 12:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZMPJO36w";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PEB3tZQd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FST4u5v8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="37QQcbdZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFFD149009;
	Thu, 27 Jun 2024 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490168; cv=none; b=VDolP0aFqXZBxTzqJAdROFzS3c3D+pCONBGsuWLAxEfCqdy+W1ofhqd+ZqTAqchOZjShLVAQPvvLs92FKUVbNrng0K09BQQ0p3Qdw7QsIZOjKtSV/OPZSiwFyidXGfVdZypAAqf5FMo32ksVMJLXKLMPCHNxYwQ3KQNJHfFDsk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490168; c=relaxed/simple;
	bh=nKkqwTC2YXYVeYA9tHJKpGR5yua+vDQ7OeiRiV5xKvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdnsTgUOBBfN2p49twswRmHpZyXtnEDOwVhRVmF4n4CsAj93XIX8VoujaNhCB/yMbD1cj7KoCvJIDXA96N1ROtifjp1VQ1FZ+3H4dBxRHRP9Ut+D2iVtN+vamd4FiAFsgg0RDw5smnISD5/g/SgNT0hY4IwnQas82UPXX3OttAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZMPJO36w; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PEB3tZQd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FST4u5v8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=37QQcbdZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A3FD21B02;
	Thu, 27 Jun 2024 12:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719490164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJDIbhHucGu+/bORF7HHESali9jR1Q46qHC6aNAwFlE=;
	b=ZMPJO36we7VlH8PHE7ztexUQtuyBLtti0R4K3FZSWLOSUyit/s+4/mV2u0TU9+mz44JhQ4
	dlqHbYGxg38gNka2ABpT6q5OiXp/ERHt52GMPHEFAKjLXCgzSdscwMY81liksegpnXelUC
	iuAh5FC4HnS6fmCTG+mc87PnRD+zLEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719490164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJDIbhHucGu+/bORF7HHESali9jR1Q46qHC6aNAwFlE=;
	b=PEB3tZQdr5oEggeTM+vN9Jimyiqrpq0lFp8ajpga5YPVMGITj0uMWT8P7r+nHGxqTvxYW7
	a3UWZMo8iNONPZDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719490163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJDIbhHucGu+/bORF7HHESali9jR1Q46qHC6aNAwFlE=;
	b=FST4u5v8prXpJ4V90me8MonX1yMN6t22skoyzaLPVW7Qg6ZK/sHIChRy5jcqE57qC6vwvN
	RniM56bGF0hMgXQBUzUbSaOK8tLGqI57ZqPQAg10Edt3LNE0QYQsyGBoFx5x3SgFIBh7qf
	tl4T1O+ZvIptYBSFqJcygmEEy5rlCP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719490163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XJDIbhHucGu+/bORF7HHESali9jR1Q46qHC6aNAwFlE=;
	b=37QQcbdZh87OS5zetsGWfh2LT2xI1T5Gx/YYjRPC3gIaUUkxj1xMuzE/7z3FYORtx5f1Ar
	s7a56tJQz+phU9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11AA0137DF;
	Thu, 27 Jun 2024 12:09:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5u1GBHNWfWb7SQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Jun 2024 12:09:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AC0DEA08A2; Thu, 27 Jun 2024 14:09:22 +0200 (CEST)
Date: Thu, 27 Jun 2024 14:09:22 +0200
From: Jan Kara <jack@suse.cz>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Jan Kara <jack@suse.cz>, "Ma, Yu" <yu.ma@intel.com>,
	viro@zeniv.linux.org.uk, brauner@kernel.org, mjguzik@gmail.com,
	edumazet@google.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, pan.deng@intel.com,
	tianyou.li@intel.com, tim.c.chen@intel.com
Subject: Re: [PATCH v2 1/3] fs/file.c: add fast path in alloc_fd()
Message-ID: <20240627120922.khxiy5xjxlnnyhiy@quack3>
References: <20240614163416.728752-1-yu.ma@intel.com>
 <20240622154904.3774273-1-yu.ma@intel.com>
 <20240622154904.3774273-2-yu.ma@intel.com>
 <20240625115257.piu47hzjyw5qnsa6@quack3>
 <20240625125309.y2gs4j5jr35kc4z5@quack3>
 <87a1279c-c5df-4f3b-936d-c9b8ed58f46e@intel.com>
 <20240626115427.d3x7g3bf6hdemlnq@quack3>
 <690de703aeee089f86beca5cb90d3d43dcd7df56.camel@linux.intel.com>
 <3d553b6571eaa878e4ce68898113d73c9c1ed87d.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d553b6571eaa878e4ce68898113d73c9c1ed87d.camel@linux.intel.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,intel.com,zeniv.linux.org.uk,kernel.org,gmail.com,google.com,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Wed 26-06-24 09:52:50, Tim Chen wrote:
> On Wed, 2024-06-26 at 09:43 -0700, Tim Chen wrote:
> > On Wed, 2024-06-26 at 13:54 +0200, Jan Kara wrote:
> > > 
> > > 
> > > Indeed, thanks for correcting me! next_fd is just a lower bound for the
> > > first free fd.
> > > 
> > > > The conditions
> > > > should either be like it is in patch or if (!start && !test_bit(0,
> > > > fdt->full_fds_bits)), the latter should also have the bitmap loading cost,
> > > > but another point is that a bit in full_fds_bits represents 64 bits in
> > > > open_fds, no matter fd >64 or not, full_fds_bits should be loaded any way,
> > > > maybe we can modify the condition to use full_fds_bits ?
> > > 
> > > So maybe I'm wrong but I think the biggest benefit of your code compared to
> > > plain find_next_fd() is exactly in that we don't have to load full_fds_bits
> > > into cache. So I'm afraid that using full_fds_bits in the condition would
> > > destroy your performance gains. Thinking about this with a fresh head how
> > > about putting implementing your optimization like:
> > > 
> > > --- a/fs/file.c
> > > +++ b/fs/file.c
> > > @@ -490,6 +490,20 @@ static unsigned int find_next_fd(struct fdtable *fdt, unsigned int start)
> > >         unsigned int maxbit = maxfd / BITS_PER_LONG;
> > >         unsigned int bitbit = start / BITS_PER_LONG;
> > >  
> > > +       /*
> > > +        * Optimistically search the first long of the open_fds bitmap. It
> > > +        * saves us from loading full_fds_bits into cache in the common case
> > > +        * and because BITS_PER_LONG > start >= files->next_fd, we have quite
> > > +        * a good chance there's a bit free in there.
> > > +        */
> > > +       if (start < BITS_PER_LONG) {
> > > +               unsigned int bit;
> > > +
> > > +               bit = find_next_zero_bit(fdt->open_fds, BITS_PER_LONG, start);
> > 
> > Say start is 31 (< BITS_PER_LONG)
> > bit found here could be 32 and greater than start.  Do we care if we return bit > start?
> 
> Sorry, I mean to say that we could find a bit like 30 that is less than
> start instead of the other way round. 

Well, I propose calling find_next_zero_bit() with offset set to 'start' so
it cannot possibly happen that the returned bit number is smaller than
start... But maybe I'm missing something?

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

