Return-Path: <linux-fsdevel+bounces-10194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DAC4848878
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 20:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF83BB25FE3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 19:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AC85DF2E;
	Sat,  3 Feb 2024 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y76r2LQ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC475FDBD;
	Sat,  3 Feb 2024 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706987842; cv=none; b=jvdt3mDxfmUaInppvNjQv7hYabPVUIHdrNZCHqXI7weF1xHOj96f3H2/3CGxWA/uSUJkq/NNUvqzTpv1bpl5/7wXBYCPlh8DxueTYU8uVCRCoJ3nio9sut+PtV/avvbyfWuyShKMeNwnfk/MniRdMsLUcFFqYP6F25SBfKWIhns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706987842; c=relaxed/simple;
	bh=cUKQD5l+1MKQ5ALHJqAwUm/2vPwtxJRjNN0WsVYURE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAGhbRvOsLplLtnd19u9sVFkSkeZY88+LMYxNRKKBNDC64j6z0SyEZT5sjY/TYLsFPJYR3DIdA4A3wLKemls6ArIlfHJViHAhKGPl/LHpcVOo/bqw8BXCNq+uRStfguwNo6WmzH3hXH7FV75/rnCUh0M+HEe/ymKWpBXQqWDB6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y76r2LQ+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OeXvRrWTn2B5fELpXRSJLDCDquzmrC8sae4TRHzYbAg=; b=Y76r2LQ+HoxNn7WwtjSIi/sFJ+
	ftpm9b0l50zljouy5cqMeRC0NzZbCA0EEGfsuKs6ohpSkHXs+YHGsBzpXJRsFckotRYN0f1RIw6Gt
	NGPytj+a7dj+mnXLIek9cd8H97BUizxltVO0pzWiwIqZBH3Z6rXw7qyD1Kgy1BxA0iCvy+3ARzbei
	Ew8w77/qyviMN4DYUdt7GKW+pR56TSwFmh0nj5lj34eXmMkN0r8D49STNiU9mfqS6TFGO/4YCS/gP
	dzKKwwnKw81+cFy2K6i104PlPDnH3VZGbLXmwtPjmc+/0WokuSYarUW94+w8kGDI64zHoFDzx0CYl
	dQf8UMaw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWLVf-00000004eZ0-0LnQ;
	Sat, 03 Feb 2024 19:17:03 +0000
Date: Sat, 3 Feb 2024 19:17:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>, Arjun Roy <arjunroy@google.com>,
	linux-mm@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	ZhangPeng <zhangpeng362@huawei.com>
Subject: Re: [PATCH 6.1 194/219] tcp: add sanity checks to rx zerocopy
Message-ID: <Zb6RLr7OoZsUboQD@casper.infradead.org>
References: <20240203035317.354186483@linuxfoundation.org>
 <20240203035344.297241145@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203035344.297241145@linuxfoundation.org>

On Fri, Feb 02, 2024 at 08:06:07PM -0800, Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit 577e4432f3ac810049cb7e6b71f4d96ec7c6e894 ]

Um, I thought this was an inapproproate way to fix the problem and I
said so at the time.  Why did this get applied?  I'm starting to get
quite angry at networking developers poking around in the guts of MM.
They don't know what they're doing and it shows.

