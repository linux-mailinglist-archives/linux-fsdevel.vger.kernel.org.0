Return-Path: <linux-fsdevel+bounces-51780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF37CADB44B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE163A9051
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 14:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219F22045B7;
	Mon, 16 Jun 2025 14:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9wF/nAs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F44820297E
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jun 2025 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750085052; cv=none; b=hGMnFM1aM8rkQO4aTnBngDZgWaxtOIFBkotQibULe9GH5NrfpJ+fvM9d+6/9OFmM1ZXBNnHPeFA/odEEJKGCudc2k789CIEcmYRDv1mqWRG05C8fX519QD7P50hKdoqN23yHpr8p4d11Z/3GmOzKPzjsLEmF1PJNJM/VFMeQsvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750085052; c=relaxed/simple;
	bh=7sY6GDrRTvC+hRQuipSmH0MG8c5UpUQLYP05YVDmO3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBB7SiiCj5RYrDzPkDxfc5+hHLdrJe9n40JfBqnfMCume8xEm//ZX1daLUGasSqbQsB+FL/l/d/MNOMTk08BVQI+2tTj7HoKd1xGETBe2LsJrGuz/OMxDAavBCthjfVyqcEANKhVLFCUX+qmEYPDVv+TU/VlFEMMn4iXA0d8Fqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9wF/nAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA28C4CEEA;
	Mon, 16 Jun 2025 14:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750085052;
	bh=7sY6GDrRTvC+hRQuipSmH0MG8c5UpUQLYP05YVDmO3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X9wF/nAsOg0II+2Gtj4kwvT4Or1B+bRTNnb/9CPyiF8KorVyVwiAMMobY23Xv2P+e
	 mC5mFRLGoth4UaK8ey4LpuH+ir0Xy/XFOIC/efbc2jmRrcsw3ffBwiPUaLz/eXCIuc
	 neQchCMxZmfNKAJWMNc1mWmp+6euv1JB5p/dy8xZrFrrq2FXa56WrSIZaGrMdI7NBF
	 GKHGBIvK+5Gem9kUiZgcT7p2zAeIaTs9lg8VrbBW+g7BN06HIkDed5PlPgzxjmf5Yj
	 JLaRHczCoVlgyMQTvAK+t/ZwukrZnCJ2I1LhugUJkzGFw5TJ36b4zm87N5JZKRpYEW
	 pNAP7h7rpxVjg==
Date: Mon, 16 Jun 2025 16:44:08 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, neil@brown.name, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6/8] fuse_ctl: use simple_recursive_removal()
Message-ID: <20250616-raffiniert-wolfram-3a4f310bfd3e@brauner>
References: <20250614060050.GB1880847@ZenIV>
 <20250614060230.487463-1-viro@zeniv.linux.org.uk>
 <20250614060230.487463-6-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250614060230.487463-6-viro@zeniv.linux.org.uk>

On Sat, Jun 14, 2025 at 07:02:28AM +0100, Al Viro wrote:
> easier that way - no need to keep that array of dentry references, etc.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

