Return-Path: <linux-fsdevel+bounces-9957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AF58466C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 05:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BED2B232C2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 04:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0718EAF8;
	Fri,  2 Feb 2024 04:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pIco9+AE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82244E549;
	Fri,  2 Feb 2024 04:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706846713; cv=none; b=pEf18maCz62ErsJgI4knNR5EVI56hPbMM20FB3I/aCHJgSWYBLK7j9t1EgJUY/sgXY+X8OUfCAJenW/5g+M+xM5iHPxUZXQNXTbOqyYk3ZJW1U7yHAFgVMwzye1cypXvpYKcyuCSRmiJscVO2C06T6rbH+OHuhthYt1RxGP1bFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706846713; c=relaxed/simple;
	bh=hZfxudAQbzcTFkLzrUZ/iFfqiq5eoB8LM/fFig+PAHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBMoMYYBb2zR97aJvt0THOGBr1gL4bsr3gTXc8ZQ11FxIVZw2Dex8yrD+tx+8Pme0IZn4cqNg60sqy5cMdqxNL09EOPdyYq8sayb2h6ktkS99RTxeO0kzbC+CUFAv/cqaII09sAUjfU+x+Bp51kJWOrvqPGk+6/V1MSmFcobhrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pIco9+AE; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zprcRbdEZTEbzRJzXIqOfmdBLyrHEeb0z5ZjrW+eJjk=; b=pIco9+AEcGpi1eJkqd1+TWTTQ/
	XggxqzL2w7JuIlqFb/qCdHy0ULmOVossWG+kEFJsaGwMh+RytusUgg82M15TvEDjlqwGslNf7cvUq
	sPt2Vassayxn3kWT9oVofZJaRl0DIN7pORLgWXb+9VTqqAlio+oguHQ5mP/B5DZuelRkEJdARnyFU
	m/G0i2qfxHjXcpG4x8OeVf8YUMVphbhJ7Uxp1eVbk/1W+xGbO+bqjutgFRWwu6i/wdiHFEvnCchz4
	ZhCB1hItyVOF2KQdksSMyIe3+2vMkZTegZ2UOl9ci4kUZVIH/f16rNHViC/gdF6VL8VPSjwmx0o57
	Hxxlk+WA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rVknX-003e9i-0F;
	Fri, 02 Feb 2024 04:05:03 +0000
Date: Fri, 2 Feb 2024 04:05:03 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Doug Anderson <dianders@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
Message-ID: <20240202040503.GX2087318@ZenIV>
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
 <20240202012249.GU2087318@ZenIV>
 <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
 <20240202030438.GV2087318@ZenIV>
 <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
 <20240202034925.GW2087318@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202034925.GW2087318@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Feb 02, 2024 at 03:49:25AM +0000, Al Viro wrote:
> On Thu, Feb 01, 2024 at 07:15:48PM -0800, Doug Anderson wrote:
> > >
> > > Well, the next step would be to see which regset it is - if you
> > > see that kind of allocation, print regset->n, regset->size and
> > > regset->core_note_type.
> > 
> > Of course! Here are the big ones:
> > 
> > [   45.875574] DOUG: Allocating 279584 bytes, n=17474, size=16,
> > core_note_type=1029
> 
> 0x405, NT_ARM_SVE
>         [REGSET_SVE] = { /* Scalable Vector Extension */
>                 .core_note_type = NT_ARM_SVE,
>                 .n = DIV_ROUND_UP(SVE_PT_SIZE(SVE_VQ_MAX, SVE_PT_REGS_SVE),
>                                   SVE_VQ_BYTES),
>                 .size = SVE_VQ_BYTES,
> 
> IDGI.  Wasn't SVE up to 32 * 2Kbit, i.e. 8Kbyte max?  Any ARM folks around?
> Sure, I understand that it's variable-sized and we want to allocate enough
> for the worst case, but can we really get about 280Kb there?  Context switches
> would be really unpleasant on such boxen...

FWIW, this apparently intends to be "variable, up to SVE_PT_SIZE(...) bytes";
no idea if SVE_PT_SIZE is the right thing to use here.

