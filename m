Return-Path: <linux-fsdevel+bounces-48156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F32AAB928
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 08:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57913A445E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 06:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465F62980D0;
	Tue,  6 May 2025 03:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJbg0MqW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98432353108;
	Tue,  6 May 2025 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493317; cv=none; b=ghnpX8Jcj2LKrsEY9xlmr6je9pjA838oJxcI9mbyZaLoePnslkwYRtmCnK0zNl+oF/EthN0sWcu98HjYbTc41M7FK/GYmgN8OAdVlwA0v6hqvCg2hKDMdOwyCkq30Fa1R8xpvsAGaIm7P7GePnKwxApGLar+ZxBFNkKlknkOu1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493317; c=relaxed/simple;
	bh=Q7sf4DCZ7/YCbSs+WNWgVbrWK8nZx3UuEcr6fvAaq7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ca3ko4lmm7sEE7jmGh+svOYSwDaZpukauTeX8/uFhWOTgnD9ld5Ecn0T8CIw/rHtnvAKmmfIbzNLAD37IM8VkSlHcGKYZW6stq2hMkvG37NTGWP90kLoSVa1871EKPLHhJ8KJlw+KUC86PcHW9DOhZIxRyEpCLkD+Ewc7qfFZzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJbg0MqW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7156C4CEEE;
	Tue,  6 May 2025 01:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746493317;
	bh=Q7sf4DCZ7/YCbSs+WNWgVbrWK8nZx3UuEcr6fvAaq7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eJbg0MqWMi4z/ikUODUOJ2SQNtVEMS1Pi4gt/AWGNP2Imnki22QI0mTOI6pBOX0e0
	 ks1uCPTEWTf7ZkOdOocF+hNgmYE9Jro0LHIFdpQpeevz+KqRPmr390NujC7N14NSEE
	 eDv3vOdIAweUp3OoK1w6xMO4MZx68YDzqLhHFJuJIewOQe+LcCNDryyG6lb6aN9d8w
	 eTgn+McM1W5mYyd7/hZrnz20m/XNGly9+pnoAlP2vvCbtuRlrP7a+9EQUpEgVfNJai
	 WkXdrHB3uz2bUvnaJQOwfUy8PspA8M/rR87Jq7iSEvmZcY/7ecn5TmDdWcusWQCnKW
	 z/Ey237rbhOWw==
Date: Mon, 5 May 2025 18:01:55 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 342/642] fs/mpage: avoid negative shift for
 large blocksize
Message-ID: <aBlfg8tuWY1_GVPJ@bombadil.infradead.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-342-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505221419.2672473-342-sashal@kernel.org>

On Mon, May 05, 2025 at 06:09:18PM -0400, Sasha Levin wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> [ Upstream commit 86c60efd7c0ede43bd677f2eee1d84200528df1e ]
> 
> For large blocksizes the number of block bits is larger than PAGE_SHIFT,
> so calculate the sector number from the byte offset instead. This is
> required to enable large folios with buffer-heads.
> 
> Reviewed-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> Link: https://lore.kernel.org/r/20250221223823.1680616-4-mcgrof@kernel.org
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is not relevant to older kernels as we had no buffer-head usage of
large folios before v6.15. So this is just creating noise / drama for
older kernels.

Where's that code for  auto-sel again?

  Luis

