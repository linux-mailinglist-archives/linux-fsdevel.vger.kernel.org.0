Return-Path: <linux-fsdevel+bounces-49742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34151AC1D19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 08:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 208965069D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 06:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB7222618F;
	Fri, 23 May 2025 06:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="P7ITPmr6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17771FE45D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 06:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747981963; cv=none; b=HMeLHX8bLBRxzwePgtw6c9kNeWcHfjE2rIfDyr1twnXmHOE1IzN3NqpaohhVt72xXNfB/VD1MWJdwCU5CdlneFxokwdNIx/ynfEwcWLHXs6on669aOVPFJpdGe3VftFWfIrWpnOVSoKsLDS+PRlyZgcO1/s0wzwQbenTI5FyQUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747981963; c=relaxed/simple;
	bh=XJwuYHJjsgAPUoWvcdHqok+hxQ2Ac6pAl4/kgamDf/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ipVDgg6PbC5xPLYHMWISjnzKDRuU6RIHtDwCemzGEhfRAon7SLiAtbmQfOSWzYKtJSS5iKfXhcEFMu8elak8FPuV9kkuBOrFPXEqaZZodb+CgCQbZFfuZYJEpZ8IgvKlBIO7Dyw5wbw/zz4FV7jrfYy1CNu5hEmRb/R4o9n5vOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=P7ITPmr6; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wkQqNaQksJXe8eSpY2sK5nryQXjPMhh2xodLzjiw8eg=; b=P7ITPmr6LlnVuzK/DYRjyv7nFO
	DnB7KjJc5nZEdEUSrFhG3E15+nKkzFeKxwcXcCIigjYo4XR/N8tgxJ3HH7qWcBYKQ5QiSL84C2kHF
	/ekE5nT2ysTgqEUbI0Ip246G/n18MHatkaQKliN3QJODzoZS83SIhu0faaypugoSeea5Ibh6gMGX1
	9n8ehpZynuOXg7E+A0tBiEgemsjzWHnA7r2IcJlAysgMaTRnHch3Cm7s3tAtvslL8m3Iymfj4jTLU
	y3rYv4dv4nPlbILhSLbnmrgx586kmoxsQW9O1yVaDNlkY0+K+uGAM3/quo/g6lMAJcgOpMKxW72kb
	LvJvaWHw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uILxO-00000008tv5-3jUd;
	Fri, 23 May 2025 06:32:38 +0000
Date: Fri, 23 May 2025 07:32:38 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Allison Karlitskaya <lis@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: Apparent mount behaviour change in 6.15
Message-ID: <20250523063238.GI2023217@ZenIV>
References: <CAOYeF9WQhFDe+BGW=Dp5fK8oRy5AgZ6zokVyTj1Wp4EUiYgt4w@mail.gmail.com>
 <20250515-abhauen-geflecht-c7eb5df70b78@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515-abhauen-geflecht-c7eb5df70b78@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, May 15, 2025 at 01:25:27PM +0200, Christian Brauner wrote:

> Al, I want to kill this again and restore the pre v6.15 behavior.
> Allowing mount propagation for detached trees was a crazy
> idea on my part. It's a pain and it regresses userspace. If composefs is
> broken by this then systemd will absolutely get broken by my change as
> well.
> 
> Something like this will allow to restore the status-quo:

> -#define IS_MNT_NEW(m) (!(m)->mnt_ns)
> +#define IS_MNT_NEW(m) (!(m)->mnt_ns || is_anon_ns((m)->mnt_ns))

FWIW, I'm not sure that ever had been quite correct, no matter how you
call the macro.  I'm not up to building a counterexample right now,
will do in the morning...

