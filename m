Return-Path: <linux-fsdevel+bounces-10195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DACC2848879
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 20:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AC4282D86
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 19:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81475DF2E;
	Sat,  3 Feb 2024 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aFA8rQ1a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B666C5EE6C;
	Sat,  3 Feb 2024 19:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706987957; cv=none; b=RQvkmTdsmM5tk5zEqyYpQKOYqo6htw51iYYvB/2a/8WsC9jZGM1rklXw7lCYsekKEWhD5f+DiJFT+EtuKEMBGVVWdeOfxqBoSGS2CI7r0xY1clkkHV5njDxFbpyBhAv1LnNJbjoGJPbG7NgIo9/86q25lp/LX8h2TIF5JL4JSLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706987957; c=relaxed/simple;
	bh=9wbmSDuXLQsTvBXIWvyok8vDsRPUOz2Eu+W/4FJ3oRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ5+hgSNZA51x10bs3CoVcecAreperqZkQPT6QohqYRhDtIqZhc4u2LeSuyJhYKlbbwK0KM4mGJuCDW86tcE7wn1d7byyW6Ldnt5LE8l2iTiGMkj2BVRBcE+MSnmLqO4Jh+m/StaN78zd91ac5XAyGmRdOfJptlxYSIvsQ5SABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aFA8rQ1a; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3sp615ubLIGUFTBs5mkge4Pj6zeRiaFtVTrso1UptCM=; b=aFA8rQ1aUwBaskVWMU0hBfiCZG
	r5InxUp3+UUQiR1Md1Okf4ZAgFcMsT32DZl4axdQp6jm0ldF0EnuCmlpk1tJ4d5kWG4QQJXN8ul0I
	9adMI5dmT3SLkgJOxa0Hr/6TLz1BTxkfy3DQfit70XDkujc97iitVWm9PqWFBfleQTLfk7UgoaArQ
	FEtrJZwBpoCIEnikMO4hdW3PITkodoNPfOVwxhw12EkVtJoyiWONepWzh1Ill7GCmT+UcDFg06ELz
	Xyrv1ZV4Pt58xxvjjicNE84e79PEheN9j3iL3BWFvBxoj4BgHqLTbr8FJLPsFoL8H29djiGN4J5Oi
	wIw61OLA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWLXl-00000004fFN-2uuf;
	Sat, 03 Feb 2024 19:19:13 +0000
Date: Sat, 3 Feb 2024 19:19:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>, Arjun Roy <arjunroy@google.com>,
	linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	ZhangPeng <zhangpeng362@huawei.com>
Subject: Re: [PATCH 6.1 194/219] tcp: add sanity checks to rx zerocopy
Message-ID: <Zb6Rse9AMI9IHCgk@casper.infradead.org>
References: <20240203035317.354186483@linuxfoundation.org>
 <20240203035344.297241145@linuxfoundation.org>
 <Zb6RLr7OoZsUboQD@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb6RLr7OoZsUboQD@casper.infradead.org>


... and the patch has the wrong email address for linux-mm on it,
further reducing the number of experts who are going to see it.

On Sat, Feb 03, 2024 at 07:17:02PM +0000, Matthew Wilcox wrote:
> On Fri, Feb 02, 2024 at 08:06:07PM -0800, Greg Kroah-Hartman wrote:
> > 6.1-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Eric Dumazet <edumazet@google.com>
> > 
> > [ Upstream commit 577e4432f3ac810049cb7e6b71f4d96ec7c6e894 ]
> 
> Um, I thought this was an inapproproate way to fix the problem and I
> said so at the time.  Why did this get applied?  I'm starting to get
> quite angry at networking developers poking around in the guts of MM.
> They don't know what they're doing and it shows.
> 

