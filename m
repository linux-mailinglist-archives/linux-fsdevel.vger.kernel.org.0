Return-Path: <linux-fsdevel+bounces-19633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A3C8C7F95
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 03:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54021C2129A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 01:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7191C27;
	Fri, 17 May 2024 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LFENJQ1o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2C5231;
	Fri, 17 May 2024 01:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715909555; cv=none; b=i94SL7PR2pGzBn1weKENsulgUsX/TEinfi4W1YOClSxDpp3tVBcna4yxPfTMEBdoN3OSlkwPFXz5IU8ed+HAGJ5zjRz8eMJ1pHw5LQbVCwpgjzjFrvvdFIsFZ0Hx0FcDBuEwjHeVPvoIo1qZcLLyeZ5ikCKzXUA4tR6PhISgKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715909555; c=relaxed/simple;
	bh=9c0s2GKvvOfQ23LJ52vwKqyEr/KuQAz47cH8vvVFxlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vDhHg2fMo3aZ8VArVGw18ug/M84WP96BkKwahvE109Rhu0PlyEaxpMXlkBlDRo+UnWBI7r3lAkmRuLYcPvBz1klX1sfw47ovCTgXITNPmQmCWhKtEwkegppSd8cNyWZ5K0PTQlFy6yvwQ1dwcR/EiOVUgimsitaIEH5wuZh+5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LFENJQ1o; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RuIWX4aNEFSWmvrH04EyeppZrNqXLtjq0nP4g1IH03k=; b=LFENJQ1onu7hYhFRYkXVF7Q0zx
	ImNyORhjT/cgVvwf3MJc+na5tdNTi0tDbZVI7Y+WPJoVxze4O8KDxFfkv2D01XRt5X2xD/lenE4vg
	TpyaH7zW0kZoh4gYVQS5lG03aLaFTLV6VQveQFuIdWYzeA6k8AjvkimKJkzsNl+lUjlc2Q1eLn/4E
	L3CtXmTier2GGHifoytAx+9+8nJ11m7lCCiwiMqup411z+cotrQR2tS9hgoLrhn8d4f+OU1ETXI5g
	5aeYHxe5xACKtmL2E2AbuKw69PykicOc6BkVNfLePjiCRS3vMaZydZ2gOvZypa99+Xg1FcsDo/5yL
	SBQObwiA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7mSI-0000000CSax-3f4J;
	Fri, 17 May 2024 01:32:18 +0000
Date: Fri, 17 May 2024 02:32:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Justin Stitt <justinstitt@google.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] fs: fix unintentional arithmetic wraparound in offset
 calculation
Message-ID: <ZkazomqvozgSMe_z@casper.infradead.org>
References: <20240517-b4-sio-read_write-v3-1-f180df0a19e6@google.com>
 <ZkavMgtP2IQFGCoQ@casper.infradead.org>
 <20240517012647.GN2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517012647.GN2118490@ZenIV>

On Fri, May 17, 2024 at 02:26:47AM +0100, Al Viro wrote:
> On Fri, May 17, 2024 at 02:13:22AM +0100, Matthew Wilcox wrote:
> > On Fri, May 17, 2024 at 12:29:06AM +0000, Justin Stitt wrote:
> > > When running syzkaller with the newly reintroduced signed integer
> > > overflow sanitizer we encounter this report:
> > 
> > why do you keep saying it's unintentional?  it's clearly intended.
> 
> Because they are short on actual bugs to be found by their tooling
> and attempt to inflate the sound/noise rate; therefore, every time
> when overflow _IS_ handled correctly, it must have been an accident -
> we couldn't have possibly done the analysis correctly.  And if somebody
> insists that they _are_ capable of basic math, they must be dishonest.
> So... "unintentional" it's going to be.
> 
> <southpark> Math is hard, mmkay?  </southpark>
> 
> Al, more than slightly annoyed by that aspect of the entire thing...

Yes, some of the patches I've seen floating past actually seem nice, but
the vast majority just seem like make-work.  And the tone is definitely
inappropriate.

