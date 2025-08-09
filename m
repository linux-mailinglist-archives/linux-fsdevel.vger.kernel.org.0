Return-Path: <linux-fsdevel+bounces-57185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A5EB1F723
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 01:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6490D1786F1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 23:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963FA2512FF;
	Sat,  9 Aug 2025 23:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T7m+UkYw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971871C2324;
	Sat,  9 Aug 2025 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754780491; cv=none; b=hef4NVK4k5nUreT2y6GsPysDb3xLfhj+sKUwLUx+x/GyHW41NdAu2IvD0mT7wSc5Vtpp8x+UU5n2sGE1/kUIdr/WVrK0SzrYId4L2GL12goITkUjZL3mgter53b5YayeSzFZ6J/FWJvRDFYZeYP/wvJLEqfX1d5KO2gGtoWJ8J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754780491; c=relaxed/simple;
	bh=If17jhKfTfvnCrbpdWWKlNj01AnvZXZylbmRi/I12RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNnJ/3J1/uOJ0PaBasY1N+ioXGfC7mCDdc15A/LzkzNid8ZtF0rk0GDMGA9LjT3tUwuWpH4XDaR7IT7fMwbaBWYUL/aBP31zLvU2akridkYUaljI51vUEtKrvY8n3qEKSIyVyh3k2F9jCcPjyJNIFUWuzKyiqCBLcE/f6/NJvWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T7m+UkYw; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+GHbL+2thnDTAchEhJDBnLOieaRoTv86wX69IAATfFE=; b=T7m+UkYwdpn1IGrDs8M6co92C0
	TmJrfLYHXV8vKDyuQMkNXNOanLqnUcpHmVK7nUMPM2MqxYNtX56R2DpLiebN5H3NfyMdMX+lCnpCL
	amcOLur3bN3YWHgZTO0nnTb5mK02hfVggHRztHSbj0Yfnm67qvKUd3w1neFGX8q8txgOeGBhZFLtS
	dfOtbC8mgpfiX7FB60Q6jgYpQrhV8FRcQiySKh3eXVBKZLkzkJUi8XsO92NPq4IcWDU4E/sSaqbkB
	M5K2DzAq90J4J+YWdib7tdPhlRKtZQrzR+thrd3Y200W1TgbDh/3ae5Pt5+aZQZ2eEiMXXYodXNx7
	vBZ6vKHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uksYw-00000009owE-3Qhe;
	Sat, 09 Aug 2025 23:01:18 +0000
Date: Sun, 10 Aug 2025 00:01:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Aquinas Admin <admin@aquinas.su>,
	Malte =?iso-8859-1?Q?Schr=F6der?= <malte.schroeder@tnxip.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Carl E. Thompson" <list-bcachefs@carlthompson.net>,
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Message-ID: <aJfTPliez_WkwOF3@casper.infradead.org>
References: <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <f4be82e7-d98c-44d1-a65b-8c4302574fff@tnxip.de>
 <1869778184.298.1754433695609@mail.carlthompson.net>
 <5909824.DvuYhMxLoT@woolf>
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>

On Sat, Aug 09, 2025 at 01:36:39PM -0400, Kent Overstreet wrote:
> Yes, this is accurate. I've been getting entirely too many emails from
> Linus about how pissed off everyone is, completely absent of details -
> or anything engineering related, for that matter. Lots of "you need to
> work with us better" - i.e. bend to demands - without being willing to
> put forth an argument that stands to scrutiny.

Kent, if you genuinely don't understand by now what it is that you do
that pisses people off, find someone you trust and get them to explain it
to you.  I've tried.  Other people have tried.  You react by dismissing
and insulting us, then pretending months later that you've done nothing
wrong.  Now you've pissed off Linus and he has ultimate power to decide to
accept your pull requests or not ... and he's decided not to.  You had
a lot of chances to fix your behaviour before it got to this point.
It's sad that you chose not to take any of them.

Can you really not see the difference between, eg Palmer's response here:
https://lore.kernel.org/lkml/mhng-655602B8-F102-4B0F-AF4A-4AB94A9F231F@Palmers-Mini.rwc.dabbelt.com/

and your response whenever Linus dares to critique even the smallest
parts of your pull requests?

[pointless attempt to divert the conversation to engineering snipped]

