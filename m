Return-Path: <linux-fsdevel+bounces-32480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A71A19A6901
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 14:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61C41C22292
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 12:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F69D1F4FA1;
	Mon, 21 Oct 2024 12:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH9Mk1Wk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED7C1D3590
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514883; cv=none; b=L5MJdDcxAPFly5FD5MHJegI8FTPdSEbeNcHI1Zmw4wlW3G+2N3eL8RFVyH7HcMsWhJSUPS72amUvW8qumwtt1gJzP39e2AuxH/HtJHT1JItjXgN4rdgfouFrXxqKa+9INegmSan6zrNvUgsv4QJw1DX27NUBkWzGzxsID/fzjV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514883; c=relaxed/simple;
	bh=MWe1mivTurcAkU1biBe41syefbSoC+k9I3qt9eaaiy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPF6jFsLgfVaDoM86MbsetkEv71F298wiU81IscvpBiQ3zqYINsdiDfA3lI211mxCL/ZLYmcjVTLQEoJdDyE6Qk0oHAOk57l+7xCd9LgRwJYsjXq1h/b+QaTlPswf8h8GYIfAC7YBp2hIkKlU8vfoo149JgWI141z0rIrR3JHv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH9Mk1Wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC54C4CEC3;
	Mon, 21 Oct 2024 12:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729514883;
	bh=MWe1mivTurcAkU1biBe41syefbSoC+k9I3qt9eaaiy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FH9Mk1Wk2CDn8qJHz1DO9PeCZwORGZjuIQQEJA/u0t772Vy0QQScou1QEkSvCf6sU
	 hXhp/4N5wy3iOqpI95ao10BaKQCJXTxflBUMUAkDp6MIK7TYuzhs7FPMb7tW8Zcrmc
	 Yuk5BGV9g4mE8dF9E59HlIrROHV/pN53WnOCWC23WghZ3IJn1SwcoqdSsAT8kdy4Or
	 dy+EmYslBqYEPcYNelY1RGVPHoEtj5p9kZfTP1V7vEkMIuLEf7pCPr+E2X0ku9wsME
	 emQPLTFNVQUMFyGsXwg386Dp7Z8/t0WF4cr+ncjxm3gSFPsE4oIy//rBmpypmtFqJk
	 e/KN8ekEltvNA==
Date: Mon, 21 Oct 2024 14:47:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241021-weinreben-loslegen-564010b902a7@brauner>
References: <20241009040316.GY4017910@ZenIV>
 <20241015-falter-zuziehen-30594fd1e1c0@brauner>
 <20241016050908.GH4017910@ZenIV>
 <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV>
 <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV>
 <20241018-stadien-einweichen-32632029871a@brauner>
 <20241018165158.GA1172273@ZenIV>
 <20241018193822.GB1172273@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018193822.GB1172273@ZenIV>

On Fri, Oct 18, 2024 at 08:38:22PM +0100, Al Viro wrote:
> On Fri, Oct 18, 2024 at 05:51:58PM +0100, Al Viro wrote:
> 
> > Extra cycles where?  If anything, I'd expect a too-small-to-measure
> > speedup due to dereference shifted from path_init() to __set_nameidata().
> > Below is literally all it takes to make filename_lookup() treat NULL
> > as empty-string name.
> > 
> > NOTE: I'm not talking about forcing the pure by-descriptor case through
> > the dfd+pathname codepath; not without serious profiling.  But treating
> > AT_FDCWD + NULL by the delta below and passing NULL struct filename to
> > filename_lookup()?  Where do you expect to have the lost cycles on that?
> 
> [snip]
> 
> BTW, could you give me a reference to the mail with those objections?
> I don't see anything in my mailbox, but...

I had to search for quite a bit myself:

https://lore.kernel.org/r/CAHk-=wifPKRG2w4mw+YchNtAuk4mMJBde7bG-Z7wt0+ZeQMJ_A@mail.gmail.com

