Return-Path: <linux-fsdevel+bounces-59599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED64B3AEF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 02:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8313858373D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 00:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EDC266A7;
	Fri, 29 Aug 2025 00:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="a04s+sH1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672641863E
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 00:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756426273; cv=none; b=CQSILeB0BJ4LhlXY36xAmTUi1rVAqcmyfmMelK38wWyUuMwkSTuzh0Tqq8zQgTli+171h5B+5ba6UOekeULIvISqWoY9bznKkSfUepvjqUHZjKsXh6ZttAklcyBEZ4eRifYsO5//e5x7sovFTFOiHWOKb983+FenMHfNln7i0Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756426273; c=relaxed/simple;
	bh=yLhYYcKpPsV3+W+3q6pGx+Q8bMroXXci5Yqh9+AWJJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lx4tlYH29+9ALXjeZeyDBDNYjRxv/0vO9RjYG4Uxad82e4Vpj/9+FO/a9i0EYilo/5nHKMHPWETNfXuHi2aFeEmWBI6Kxxju3yKSvhXOXGKuupbfRCPU6yScUr0cqSpvJvmBWNAP1MADsla/CHpTMxED68eg6xz4BxPDoACU1Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=a04s+sH1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ypUBtNU4wefecbcW4dfUMKNnD/UvKClqK/2A4NB7+/E=; b=a04s+sH18lXLLNrTVTBH7XDVOb
	uR7+ja8RIoC07ZeqinXFu1YOkOkB/UwaY1qPs+mgtgYY1RUOVz5JxB9TuWrt59XAovyBh/hpBceb5
	8KoKZyqQA5jb+0XyYSaodsmTl+xjML3Qa8DBCLw8vzBxKZU3WpC9LfE1QUFwqqqNL0p66gLlQUr/P
	rU1lL5a+Jr4WsVY0sLRoQrjQ9NTCi5LJQElijBfgIS4wmuYBQt91dh3APrQztbYjUT0s0sM496mj1
	DRAL/+bvUyeAYxH5mAgKJWLcooJBfiKVBZSpC0VuG0mG5Acf3Qg5tS7wPhffwRSdMhDlgC6c0+p59
	je8lfvig==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urmhx-0000000FpRi-2qrZ;
	Fri, 29 Aug 2025 00:11:09 +0000
Date: Fri, 29 Aug 2025 01:11:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH v2 61/63] struct mount: relocate MNT_WRITE_HOLD bit
Message-ID: <20250829001109.GB39973@ZenIV>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
 <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 28, 2025 at 04:31:56PM -0700, Linus Torvalds wrote:

> Same largely goes for that
> 
> > -       struct mount **mnt_pprev_for_sb;/* except that LSB of pprev will be stolen */
> > +       unsigned long mnt_pprev_for_sb; /* except that LSB of pprev is stolen */
> 
> change, but at least there it's now a 'unsigned long', so it will
> *always* complain if a cast is missing in either direction. That's
> better, but still horrendously ugly.
> 
> If you want to use an opaque type, then please make it be truly
> opaque. Not 'unsigned long'. And certainly not 'void *'. Make it be
> something that is still type-safe - you can make up a pointer to
> struct name that is never actually declared, so that it's basically a
> unique type (or two separate types for mnt_pprev_for_sb and
> 
> I'm not even clear on why you did this change, but if you want to have
> specific types for some reason, make them *really* specific. Don't
> make them 'void *', and 'unsigned long'.

What I want to avoid is compiler seeing something like
	(unsigned long)READ_ONCE(m->mnt_pprev_for_sb) & 1
and going "that thing is a pointer to struct mount *, either the address
is even or it's an undefined behaviour and I can do whatever I want
anyway; optimize it to 0".

unsigned long is a brute-force way to avoid that - it avoids UB (OK, avoids
it as long as no struct mount instance has an odd address), so compiler can't
start playing silly buggers.

If you have a prettier approach, I'd like to hear it - I obviously do not
enjoy the way this one looks.

