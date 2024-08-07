Return-Path: <linux-fsdevel+bounces-25255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E85994A514
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC66A1F236BA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83401D365D;
	Wed,  7 Aug 2024 10:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWTXwkdg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A3A1CCB4A;
	Wed,  7 Aug 2024 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723025247; cv=none; b=SWhS9jtogvSdixCXJgIEEPAkFZSRZEAkqK7h772exw6HmTCaq+jaQNBCiff+DfE000br4p+Zi7aYYzhiXR8IGrhK6I9xIWE6sOEuB+HrnSaYz3d65swC7EbQR++HY2+SrMyj2vON9JY94RCSP6lY4GP6pf4LZOFCl16M1O9Kjjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723025247; c=relaxed/simple;
	bh=pkkdvbWx4jEYAp/1QACwyQM5Rd1UrpR3f8x9642eZ0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWyf8Ck9ilxaTZUpV+z3AxJh3UrW3GtShUW//56ULdx7LZMy6Y4xfa6XwfGjrqU2HG6azxYi0Atn+X98gRwNymUm1fDyuwCMmMYEmKfDVFvsuD7WpwJGG3+u4MHw+8H5jxnNEZ80xIlSvkl99f4yWM12fGARs3c3KuR4lkE7Sh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWTXwkdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605FDC32782;
	Wed,  7 Aug 2024 10:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723025246;
	bh=pkkdvbWx4jEYAp/1QACwyQM5Rd1UrpR3f8x9642eZ0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JWTXwkdgAUu8YogRPTwtcZZGjymBxwSITowKEEajZQTZCbsjoxLusAZ5BX3zrYlBV
	 fRm1x9VRQZvzKNUP2pfH/Xja7NHI97PuX2xiqUoSm7UuJPVfWUm4eLmWuK1zH9l/9d
	 HS9k4EldKhtM/+GTRDqPzqSx8QE3w9AuZCxCN2pnapwZXpfAZ/gSOhmdBk54H5hiAa
	 Dg+OiUZLvwK/SiaX/gSqBGnR9leuDipfJmKh2cSP0HymrriXw0Pj1OebJwII/3jIky
	 aI9Dc4mYl4b4ZJHsGQsKdzZ6mpyaWjZCRhPHj/D2e9/xWD1saPMwd7bi4cUhwo/zXg
	 9uGmgMXOC7b3Q==
Date: Wed, 7 Aug 2024 12:07:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: viro@kernel.org, linux-fsdevel@vger.kernel.org, amir73il@gmail.com, 
	bpf@vger.kernel.org, cgroups@vger.kernel.org, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 03/39] struct fd: representation change
Message-ID: <20240807-sitzkissen-trafen-664e526082a4@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-3-viro@kernel.org>
 <20240730181048.GA3830393@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730181048.GA3830393@perftesting>

> Which makes a whole lot of sense.  The member name doesn't matter much since
> we're now using helpers everywhere, but for an idiot like me having something
> like this
> 
> struct fd {
> 	unsigned long __file_ptr;
> };

I agree that that would be helpful.

