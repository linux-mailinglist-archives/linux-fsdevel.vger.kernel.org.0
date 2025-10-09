Return-Path: <linux-fsdevel+bounces-63658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F2BBC9027
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 14:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1F0B188CDF6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 12:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D5C2E1EE1;
	Thu,  9 Oct 2025 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zuDy/YSB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nT5WF3TN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zuDy/YSB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nT5WF3TN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4322C2364
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760012955; cv=none; b=HbwZyvOpsh4A/5aY91VzKg0cyZ3bxWeNXFHjM9b8nizoU9C6r0DZi5aQmXVTK33vVf1scXjY8y0hCS9gJ9edygE0vhh0Tq4qYTDJqFvN7nlKU9uESwqa/UF6DcZvYpx6IHTFVbrPK7ZE3GiLzNLwWsgLDXpxkWBvDbWYw0H61MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760012955; c=relaxed/simple;
	bh=9CgaqHo3MAAAeJtHlkgAVymT6PBnRS9hb21mqGiPTXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hqj7OzWyeFY1/0CMmY5zsFQBLh7H8CUUeB1ZW8m8w/x4FK8sx8koo+aBN5m64JBViPBSpJhUKV5jNxdMMa4cBJKMKPS7lSZGy2hjUiGx3WXmdGtK1RbqXq9DRpyRlKp9f4tfen8SURKu+/mclnNM17Y8bq0ho2HInttxkm3Gdnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zuDy/YSB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nT5WF3TN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zuDy/YSB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nT5WF3TN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F347021F74;
	Thu,  9 Oct 2025 12:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760012952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S1skDhzeV1vSK+p1iuz8tLlIOlGr4609+yd0yTH4ohQ=;
	b=zuDy/YSBXQULJfdDxrmqOffq6gad/Iu77NwLM0bZFLcU/H+M0DvIIpfxWlbIcjpMG7tNoK
	QrH351dII+geNtmCrva6xfTbMaM/L1zgx6brnMZzAbKpEUClzC2F8QqIrJEeAX2zf0fAK7
	yeSpGf9FIzu0S4Eem+1NHNloPDjWHpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760012952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S1skDhzeV1vSK+p1iuz8tLlIOlGr4609+yd0yTH4ohQ=;
	b=nT5WF3TNsCqUTWWC9Q+9zkTAyrVrAcLJmL9qXpn+0Z8R7uWgQz38d5GPXX4cGVTdqaQ/BZ
	iMtomZ2sVOL9v3Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760012952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S1skDhzeV1vSK+p1iuz8tLlIOlGr4609+yd0yTH4ohQ=;
	b=zuDy/YSBXQULJfdDxrmqOffq6gad/Iu77NwLM0bZFLcU/H+M0DvIIpfxWlbIcjpMG7tNoK
	QrH351dII+geNtmCrva6xfTbMaM/L1zgx6brnMZzAbKpEUClzC2F8QqIrJEeAX2zf0fAK7
	yeSpGf9FIzu0S4Eem+1NHNloPDjWHpw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760012952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S1skDhzeV1vSK+p1iuz8tLlIOlGr4609+yd0yTH4ohQ=;
	b=nT5WF3TNsCqUTWWC9Q+9zkTAyrVrAcLJmL9qXpn+0Z8R7uWgQz38d5GPXX4cGVTdqaQ/BZ
	iMtomZ2sVOL9v3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E35F513AAC;
	Thu,  9 Oct 2025 12:29:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Q918N5eq52j8ZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 09 Oct 2025 12:29:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7CF57A0A71; Thu,  9 Oct 2025 14:29:07 +0200 (CEST)
Date: Thu, 9 Oct 2025 14:29:07 +0200
From: Jan Kara <jack@suse.cz>
To: Matt Fleming <matt@readmodwrite.com>
Cc: Jan Kara <jack@suse.cz>, adilger.kernel@dilger.ca, 
	kernel-team@cloudflare.com, libaokun1@huawei.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu, willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Message-ID: <ytvfwystemt45b32upwcwdtpl4l32ym6qtclll55kyyllayqsh@g4kakuary2qw>
References: <20251006115615.2289526-1-matt@readmodwrite.com>
 <20251008150705.4090434-1-matt@readmodwrite.com>
 <2nuegl4wtmu3lkprcomfeluii77ofrmkn4ukvbx2gesnqlsflk@yx466sbd7bni>
 <20251009101748.529277-1-matt@readmodwrite.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009101748.529277-1-matt@readmodwrite.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.80

On Thu 09-10-25 11:17:48, Matt Fleming wrote:
> On Wed, Oct 08, 2025 at 06:35:29PM +0200, Jan Kara wrote:
> > On Wed 08-10-25 16:07:05, Matt Fleming wrote:
> > So this particular hang check warning will be silenced by [1]. That being
> > said if the writeback is indeed taking longer than expected (depends on
> > cgroup configuration etc.) these patches will obviously not fix it. Based
> > on what you write below, are you saying that most of the time from these
> > 225s is spent in the filesystem allocating blocks? I'd expect we'd spend
> > most of the time waiting for IO to complete...
>  
> Yeah, you're right. Most of the time is spenting waiting for writeback
> to complete.

OK, so even if we reduce the somewhat pointless CPU load in the allocator
you aren't going to see substantial increase in your writeback throughput.
Reducing the CPU load is obviously a worthy goal but I'm not sure if that's
your motivation or something else that I'm missing :).

> > So I'm somewhat confused here. How big is the allocation request? Above you
> > write that average size of order 9 bucket is < 1280 which is true and
> > makes me assume the allocation is for 1 stripe which is 1280 blocks. But
> > here you write about order 9 allocation.
>  
> Sorry, I muddled my words. The allocation request is for 1280 blocks.

OK, thanks for confirmation.

> > Anyway, stripe aligned allocations don't always play well with
> > mb_optimize_scan logic, so you can try mounting the filesystem with
> > mb_optimize_scan=0 mount option.
> 
> Thanks, but unfortunately running with mb_optimize_scan=0 gives us much
> worse performance. It looks like it's taking a long time to write out
> even 1 page to disk. The flusher thread has been running for 20+hours
> now non-stop and it's blocking tasks waiting on writeback.

OK, so clearly (based on the perf results you've posted) mb_optimize_scan
does significantly reduce the pointless scanning for free space (in the
past we had some pathological cases when it was making things worse). Just
there's still some pointless scanning left. Then, as Ted writes, removing
the stripe mount option might be another way how to reduce the scanning. 

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

