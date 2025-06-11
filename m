Return-Path: <linux-fsdevel+bounces-51292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7632DAD532C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 164CB3B108B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFBC25A2A4;
	Wed, 11 Jun 2025 10:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/G7PZon"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7254C79
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639546; cv=none; b=WPJ7b8QOg9BygCLkxJgxq+YMpTRg7qNpdpukR34P1uw6sArtMjXHPYIwtqhnGrL0/qAvWk+pK3KPYRIQ7/NzKOg/BC3/AGq6kgLlhJvlBnKvUfRCQFrKb1Pkbb0pjYRRscvnwUEeb3bHRjLkTsMKRqCYrmrH66Y6GcPgUgsOIIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639546; c=relaxed/simple;
	bh=ZUQNKNPfKZDKvi13u2up92118M6HTG8NaCFAWXXhGhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvT0N3o/f2lHBmmqYoXWNTeu5cHP/TRvPdYyvXMznCiSlq4I3og6Lh9hgMaGP2i2LLTcmSEcJ/cR7TSPKEJVz6T4mgxA5lmqlcbI2lk0jbIyeAh/aWGuADXWUv1Y4atXJAOIwtaA3ChSVCPAUcW+j07i8sEBJcH3jzqzUKfJMv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/G7PZon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAD7C4CEF1;
	Wed, 11 Jun 2025 10:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639545;
	bh=ZUQNKNPfKZDKvi13u2up92118M6HTG8NaCFAWXXhGhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/G7PZon4eUwxWmHlzAx0Py9BgNS5w6CfOO/bXoCYcHMvl2OfkwXQ2dT+sG6+ItBb
	 9lEAWG1Y4noeuVCgltnU4hJGE6RNkhLGZ6OyMT1+jfX1M8CNjGvwSqc+wV8bZdoC9T
	 n8oAgiMuiZdn/cU5F4+VsIWSVyqU+Xh8CfLTqy30gMpkO5a7QBWr4eWDhQ7V8JIffy
	 NhmbhoWuT6ID6EmNtVK3RLV6yjo32gd16EZDx7JqHn4BvTpxYy/hE3u+P5WEXDrDm5
	 OOXqpz5jtYW7vlOuSAWGKOTwtA+CL/+86IqKa9KX8JXLGGqOTbTPlth/jgJofsjASY
	 LAkDnJqqjbdDw==
Date: Wed, 11 Jun 2025 12:59:02 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, ebiederm@xmission.com, jack@suse.cz, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 13/26] attach_mnt(): expand in attach_recursive_mnt(),
 then lose the flag argument
Message-ID: <20250611-ankommen-weinwirtschaft-9e518a885f0a@brauner>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
 <20250610082148.1127550-13-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250610082148.1127550-13-viro@zeniv.linux.org.uk>

On Tue, Jun 10, 2025 at 09:21:35AM +0100, Al Viro wrote:
> simpler that way - all but one caller pass false as 'beneath' argument,
> and that one caller is actually happier with the call expanded - the
> logics with choice of mountpoint is identical for 'moving' and 'attaching'
> cases, and now that is no longer hidden.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

