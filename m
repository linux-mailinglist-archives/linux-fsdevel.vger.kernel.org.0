Return-Path: <linux-fsdevel+bounces-49749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F266AC1EDE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 10:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E693B66A9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 08:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1168522D7A4;
	Fri, 23 May 2025 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meNo4HVc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703B51F9F7A
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 May 2025 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747989680; cv=none; b=Ccuw1RwPMKo16r7A9uQh41i6AC1ytMcQXqW7uylTnXXhpOt1tFUaHEPjc3Zil2Z3QOke5eV+ct4wNtdxv1SlsuFh+icYX3MLZd0uTzj+dQKlYXYSHe5M7WeHFSC43u7aXSf9muRY29XvKgI0u8RJjQuKwAIsEDBV9470AL/mmys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747989680; c=relaxed/simple;
	bh=dPBEtSBG8eUbYy70ru+X/CdqsauDb/zBwC3RIBfNAP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My43GxNNzA1Y6EOCt27E/kVZbr9Dp9LFLv1A5wGRjx5U6Vk7couGk/L68R68hDCE2to1LBzzytx4az2uNJgcTD4XptqXwlOgJCVD0qDSpGUb1U9v49Xhz+/ZS9QKhLNJYiNs4bDL1k1r960eSj2bqJP9ws2prRAOa+ujvJKOO0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meNo4HVc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC2FC4CEE9;
	Fri, 23 May 2025 08:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747989677;
	bh=dPBEtSBG8eUbYy70ru+X/CdqsauDb/zBwC3RIBfNAP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=meNo4HVc2R2U5bTCRVswA9BFcDXMlhe9mJrSsFB3TvRwmjMtJF38gnFuDjMDCzVH8
	 S6ZOQR6aDnLvzSAYGqDvKv7pq8AOOHSvNOzmAFdx5AAf9L6C89zsUURFqm4xO6OMQL
	 6ajxwM128TtLH7SdhWxZ06+Fpuu8GdcDaIwhZqB9P33xIcAJNvp4NHRRvWgk+tutPR
	 naBiAWOhkcKvqAOZwiB0+tAbdlXODWMlt7x2Gq2+9NGsWSgT0/3Ps76qIt1nFCOo02
	 tWeaKhe3R8qPw9ELNyUt3t0O/e7L5qxXAweBL5+exwkfGzd/2VS4du2HIsX8IpwNUS
	 D5Fb8QiAYtOcQ==
Date: Fri, 23 May 2025 10:41:14 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Allison Karlitskaya <lis@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: Apparent mount behaviour change in 6.15
Message-ID: <20250523-aufweichen-dreizehn-c69ee4529b8b@brauner>
References: <CAOYeF9WQhFDe+BGW=Dp5fK8oRy5AgZ6zokVyTj1Wp4EUiYgt4w@mail.gmail.com>
 <20250515-abhauen-geflecht-c7eb5df70b78@brauner>
 <20250523063238.GI2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250523063238.GI2023217@ZenIV>

On Fri, May 23, 2025 at 07:32:38AM +0100, Al Viro wrote:
> On Thu, May 15, 2025 at 01:25:27PM +0200, Christian Brauner wrote:
> 
> > Al, I want to kill this again and restore the pre v6.15 behavior.
> > Allowing mount propagation for detached trees was a crazy
> > idea on my part. It's a pain and it regresses userspace. If composefs is
> > broken by this then systemd will absolutely get broken by my change as
> > well.
> > 
> > Something like this will allow to restore the status-quo:
> 
> > -#define IS_MNT_NEW(m) (!(m)->mnt_ns)
> > +#define IS_MNT_NEW(m) (!(m)->mnt_ns || is_anon_ns((m)->mnt_ns))
> 
> FWIW, I'm not sure that ever had been quite correct, no matter how you
> call the macro.  I'm not up to building a counterexample right now,
> will do in the morning...

The point is that we can't do mount propagation with detached trees
without regressing userspace. And we didn't do it before. I don't
specifically care how we block this but it needs to go out again.
Otherwise we release a kernel with the new semantics that regress
userspace.

