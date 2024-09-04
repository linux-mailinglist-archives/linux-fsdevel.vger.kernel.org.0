Return-Path: <linux-fsdevel+bounces-28503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CC896B5AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DE502825E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 08:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1331CC888;
	Wed,  4 Sep 2024 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNc+4Fm5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4B11CC144
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440328; cv=none; b=i/7mifV8y7yFDSdPWTziJ4vfjNESJ3UCU/G0+L0mmgTPuGB0COIeWRavIaDs0ePsKOV+SjS7ONYYNdx6hejiwFUvFNE1hx5Wky8hdQxSm9LAbUyrSIubCPor043izY+lRQs3ae+NMqEZeeVz28CWQ9OFldUgQk47W4TSFc3PnnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440328; c=relaxed/simple;
	bh=EtqRKArhzC9Y2UBCDEv3yc4n6+elGDXQTlG0Qw3Q5O4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEIpNYO3djTQWBDdF4jXRohcuEWpqUG2ADRb867H0DbLGgEcbg/zExCj+WJzpZiarp2voFXOMkK60RKmfps6gzVdJQ46Jn9ac5JOv5Kq94nzSJFTZGSh+hkbRa3Fo/mthp7fjccU+YKv50OXAHs835545dMG/vAfgpy759EQpZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNc+4Fm5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE2EC4CEC5;
	Wed,  4 Sep 2024 08:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725440327;
	bh=EtqRKArhzC9Y2UBCDEv3yc4n6+elGDXQTlG0Qw3Q5O4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNc+4Fm53vgHPTWcFUca263vDcKYtSTlqrOnVIiYGIgsASPppHCj5sEBjmKChKq0i
	 d3Q2l+oaT+OTkgKGfn4PvnPfPhq2+aLG85HwJMYQw9Tr5n/6cBbMiAaIX8q7BAMtcD
	 WVSg+8uyg2bNbIxdgA2d1AzVygqUYyJjm9VRi6Kw5scChZad/gUl/JC8u+o4SFZt0N
	 cu/avGNdr7VwLCqE6dZRdKsCsmlcOl44O7amgqMt9uTPrwkBJCkTTZzeAlkERd5Kk1
	 lrj5lOirxbil68kgaxWSxR2kT2WoTpbCBeuqmiuMu66EQRmfTsuUg8+JfFYFn38OqG
	 hB+Fsw3P21cvA==
Date: Wed, 4 Sep 2024 10:58:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 09/15] sl*b: remove rcu_freeptr_offset from struct
 kmem_cache
Message-ID: <20240904-quallen-stuben-2fefcb33e6b5@brauner>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-9-76f97e9a4560@kernel.org>
 <79eb89f6-1e19-4785-b807-1e0459b6011b@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79eb89f6-1e19-4785-b807-1e0459b6011b@suse.cz>

On Wed, Sep 04, 2024 at 10:16:17AM GMT, Vlastimil Babka wrote:
> On 9/3/24 16:20, Christian Brauner wrote:
> > Now that we pass down struct kmem_cache_args to calculate_sizes() we
> > don't need it anymore.
> 
> Nit: that sounds like a previous patch did the "pass down" part? Fine to do
> both at once but maybe adjust description that we do both here?

Hm, maybe that was misleadingly phrased but my intention was to express
that this patch passes it down and removes the now unneeded member from
struct kmem_cache. I've rephrased this to:

"Pass down struct kmem_cache_args to calculate_sizes() so we can use
args->{use}_freeptr_offset directly. This allows us to remove
->rcu_freeptr_offset from struct kmem_cache."

on the work.kmem_cache_args branch.

