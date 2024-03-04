Return-Path: <linux-fsdevel+bounces-13483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F49F870554
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 16:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91AF91C21AA6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 15:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FA23F9C0;
	Mon,  4 Mar 2024 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X9h0O3Gh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8B43B29A;
	Mon,  4 Mar 2024 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565750; cv=none; b=BgBpe/96cpax2/eGKGCOrHtfGM4/6JRKeY4l38jb++0Bz7cfKCPpj1pD6GCQb/rKosnkuI5IhLuKgxoyn2oIJCYLHbeShwO9QZoKm+mfqSySws/sJziYXBUfFBud/sXIT5rpOzjg+YNZgohBIw4KP3zbLRxQCj8ymIdBzlgREKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565750; c=relaxed/simple;
	bh=eC3i5mDhDhtfWhsyiVQA4ZL/grxMmibiKZR5FXllG8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odwFtAAdAwgCcMSxvJO5xjZK3Yg5CxldgxOS5+E6Zj51TVZPG1BQ7g+F//gtEwQH0ZOEXl35nAT1YNpvPIMP9oj6HhLsfv2E7cd+U4dvq+APaYihNngp03KJS2BEK6T0BcqHsEGrRfFYBlkBdre+Dn5FHsM5T0xOYwwg7pzi7a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X9h0O3Gh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bfwxzN2NInkeiQz2HXVVhHkXSrpL5vJ8jBOEJ4yVSwY=; b=X9h0O3Ghnbtk6t03NYNIf774L4
	ZvBPoa6FwNTQ0IpOOEZBYLFwJaIFMQ7MYE2HRmSwhaRQZdE67L9NiaIy/XhSVY8C0NXQjdXR170Gu
	RmHfH/0c3zrKIl4VKY80rzmiMeOGabV+q0eHeD2NfHhF8Ow3NEJMDTgQ1KXSxQJaYM+PRjrArqTXB
	PwBiK2uJL6RiiX3mdCezkRJXFeMTfp22LQMehpyJVzxL26gQmPAkiTZ9E5HO2/g8re6v3sqZ6kxON
	kBl/Gx0Z+cfnYBP4xLiPc3UOaZfpC4ntWa4YqpE4fn4LRyvGA0P5oP2xKjl0dWSmO7JNC1chrfZZ3
	KyYU/Nvg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhA92-00000001lHU-3jyD;
	Mon, 04 Mar 2024 15:22:24 +0000
Date: Mon, 4 Mar 2024 15:22:24 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
	Jan Engelhardt <jengelh@inai.de>, linux-man@vger.kernel.org
Subject: Re: Undefined Behavior in rw_verify_area() (was: sendfile(2)
 erroneously yields EINVAL on too large counts)
Message-ID: <ZeXnMO0DcZH63B_d@casper.infradead.org>
References: <38nr2286-1o9q-0004-2323-799587773o15@vanv.qr>
 <ZeXSNSxs68FrkLXu@debian>
 <ZeXkLYExJHj98oaS@debian>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeXkLYExJHj98oaS@debian>

On Mon, Mar 04, 2024 at 04:09:26PM +0100, Alejandro Colomar wrote:
> Depending on the width of those types, the sum may be performed as
> 'loff_t' if `sizeof(loff_t) > sizeof(size_t)`, or as 'size_t' if
> `sizeof(loff_t) <= sizeof(size_t)`.  Since 'loff_t' is a 64-bit type,
> but 'size_t' can be either 32-bit or 64-bit, the former is possible.
> 
> In those platforms in which loff_t is wider, the addends are promoted to
> 'loff_t' before the sum.  And a sum of positive signed values can never
> be negative.  If the sum overflows (and the program above triggers
> such an overflow), the behavior is undefined.

Linux is compiled with -fwrapv so it is defined.



