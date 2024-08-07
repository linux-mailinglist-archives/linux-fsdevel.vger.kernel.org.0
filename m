Return-Path: <linux-fsdevel+bounces-25263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0A094A562
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85802833D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2109F1DE843;
	Wed,  7 Aug 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKxRgmj+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34E190077;
	Wed,  7 Aug 2024 10:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723026376; cv=none; b=saRWJA2ZjyEu7LKQeDylzUkS0zoRNtmzzB/ZgkTVTPBYgTYC+o5uIfgSSiRUx2AlBC4sQK1Z5VJMFnlReL9npOTMf3Tc8sAfd7Xx/X69/tuhHOovFkGtVEyrPcl+vTYdIeT+oKqrKUlIrkzAFBpfEiK9aSTYIL9PQOuVjg/d4PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723026376; c=relaxed/simple;
	bh=01AHvKOt3s9t+JgP0kcr/IY2jCKRiE80qh0V7HFdnFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RreLXVtaLBNT9kahGattwdM6rs5neNh58CxW2gEWLnXsRRSjiiw8KU2NObRFbhU/heX6+XRtzCs8uji7/yp5lV3Rz/GzZDuzPGHzHWBjCWus1+ATDbBlJMSvo0HafZptnJqq/sB98HLtuMyY3pC0Y+psGjX+0G2bRmt5GQHWszU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKxRgmj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4CDC32782;
	Wed,  7 Aug 2024 10:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723026376;
	bh=01AHvKOt3s9t+JgP0kcr/IY2jCKRiE80qh0V7HFdnFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vKxRgmj+lOFL4AF9jABbKResiIPD9RBjibkttlFAjGoztf9/wGYEB7ir5Nz9dUPIF
	 JxqZy52kpcgw3iPNvrI833d6H4F+jOw6nPvlKHc8jTlvlzNu9LjV/YCopJaIcXl9fB
	 r1AHJvUy8KXdF4wjUS/bAXBz4jhMYiJFKm7ITcid0hcrKskZXoxYTcPzjvkLtfq61x
	 w6BdmAeoDXUFvoI0JKqKjMpDMtYS9Yms8mq09eDfyoWEWKV++OPDnrwCqqsKWZyNt8
	 YK3bTo6tbWS5CKM/L34GRpoyUGaaXI7je2+kb+aNWMRiN1+r2NpRFW95Ao/ALSxd6v
	 sw0YsqJVqVvTQ==
Date: Wed, 7 Aug 2024 12:26:11 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 11/39] switch netlink_getsockbyfilp() to taking descriptor
Message-ID: <20240807-beunruhigen-klarstellen-881d9d97272f@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-11-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-11-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:15:57AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

