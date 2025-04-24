Return-Path: <linux-fsdevel+bounces-47302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81063A9B9E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 23:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31574460A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B15218ACA;
	Thu, 24 Apr 2025 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOoFAQBo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BFA111BF;
	Thu, 24 Apr 2025 21:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745530221; cv=none; b=RS4Ob0GUXZATA/Z+JPQbwu/9DsOuyhg1bkqLsb8jzS9PQ/7idP9MNicrAWP7iDmFaAYOF3kQOHShZK4795sFApKl1Q7joR3LSfXv4U1g5+EknPd/FGzPdHOdUUfbAXqFeGnhECPFDVVX2ou10ROUvit12glyO8W+TkBMSdQVkhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745530221; c=relaxed/simple;
	bh=AjdpIdUlS4/oUvDm+FsTLVvYVXkvxw6dBUJhegqyS+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oFLi0HZzlMjIiX4tykXZSxjrd7HRnoy70276AFvH0mHpIaQpbOEFKY95SVOZN3LN2y1Vn/KTSQGPG+IllWEfbUxy+YJ3Cgk58cs5iygG74S6EA1gYmiRgkiEUtxF3Yvqknjh58LrY+iW4q2E734hAMgV53qj3S3cGdRIyVssaKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOoFAQBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21ABC4CEE4;
	Thu, 24 Apr 2025 21:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745530220;
	bh=AjdpIdUlS4/oUvDm+FsTLVvYVXkvxw6dBUJhegqyS+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bOoFAQBoGsEli/jr1uWKe6KC1p1B7ypgl0kEaUUjqWQLj7UmVV0AWyvylmrGB+L1b
	 Zty4K5kWFT7c1HL33i9A2y4lyZcy7Emap3nQx7cjXtoL26C8Q89FRcgQ05eojxus0Q
	 zFpE4CTYLUwTJgH8ufdiPPMpTw97jiqaq9BDOxe2u2Ec+ZQlkuLxLDsbF7vBx6257K
	 A4p8Vxwo8MBGEAcaxJBE6/VZh5AmhIapVMDGLtky4VwE1nU+7wSVgEspOI/kiTcABT
	 x4DF4UqyptjWEZDZNiJgWBVnyoX6VRAQwOr7jzn4ozODDuc+29pZtpq4TtjTIN6Ytr
	 cxpctx9f41u0A==
Date: Thu, 24 Apr 2025 17:30:18 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: trondmy@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] filemap: Add a helper for filesystems
 implementing dropbehind
Message-ID: <aAqtaj2i-eW8T-Ni@kernel.org>
References: <cover.1745381692.git.trond.myklebust@hammerspace.com>
 <5588a06f6d5a2cf6746828e2d36e7ada668b1739.1745381692.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5588a06f6d5a2cf6746828e2d36e7ada668b1739.1745381692.git.trond.myklebust@hammerspace.com>

On Wed, Apr 23, 2025 at 12:25:30AM -0400, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> Add a helper to allow filesystems to attempt to free the 'dropbehind'
> folio.
> 
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>

