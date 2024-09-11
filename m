Return-Path: <linux-fsdevel+bounces-29121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F06975A8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 20:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 541ACB24FD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 18:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461A51B81D5;
	Wed, 11 Sep 2024 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6NrGWtg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32171B6541;
	Wed, 11 Sep 2024 18:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726080493; cv=none; b=WUzV0P20MCtpiWFtvGJ6xbtyc5t1UtWhaxABV2xEUSfXWSKYT7rnMLh88zBI1wHGvr10UNHk5eIz2recCniL+tQ3N947X6AYvL6sqRJKt4j7dRyEMF6aEbNxKBz6KcD7pRpFeHdQvaC27zuAxkhCQzkSxxswENRVBtwsgoS+m60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726080493; c=relaxed/simple;
	bh=iuS44/l8xT5IbaQDLO+YL+PtbRY25zHTQ/H3zqDfA6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+GSJeKTAxlFsJoWa6NOEiYtPyrzmYdT5FZUnmOf+jFrN/0CHSZevYolAsVNl8kmgmeGqrkiKxKJYFSltFg2dwr+Ue2HUs50JIdY8ExFMoDNOqDx/7Gd03EmqyuidbA9pN60tB1M7rCijPWNhgIfJSdCOxCi5xObN2kX7DxKxPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6NrGWtg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB21C4CEC0;
	Wed, 11 Sep 2024 18:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726080493;
	bh=iuS44/l8xT5IbaQDLO+YL+PtbRY25zHTQ/H3zqDfA6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A6NrGWtgWhChgEYhtMrsgcxcju2zFdZc2NiHW+KkUvmlEOXhOn/DGCMxvl4q8xnaB
	 4ium5ynhnJ633+TUB7j67cGEfmgB45ga0j8uXGAj3iR8MG/81m6XJeJKM2Ci+uM2Tx
	 KfqRA1WB6j+dgrlSYlPPGOS4IX2kQYyqwKvMINpb/S7bGCMkDqyb0Rk9IEFv7AWQMf
	 hKb8Z5HaK3/Wa7pmBF+BGx1PeWiBYYLdLuKL/VWJ/HMlreikbkfI3k/BpD4XIWoJw/
	 oVOaRJlW4JlW3ps6ifH48V7jUiy737TkH91/pPTfu64HqYX4INHDOO1nlnsqPYbznZ
	 bWV2L91CazaFA==
Date: Wed, 11 Sep 2024 14:48:11 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
Message-ID: <ZuHl69qJk8Q9b1p4@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <66ab4e72-2d6e-4b78-a0ea-168e1617c049@oracle.com>
 <ZttnSndjMaU1oObp@kernel.org>
 <ZuB3l71L_Gu1Xsrn@kernel.org>
 <ZuCasKhlB4-eGyg0@kernel.org>
 <686b4118-0505-4ea5-a2bb-2b16acc33c51@oracle.com>
 <ZuDEJukUYv3yVSQM@kernel.org>
 <ZuHYtiL1PBr6fG3B@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuHYtiL1PBr6fG3B@kernel.org>

On Wed, Sep 11, 2024 at 01:51:50PM -0400, Mike Snitzer wrote:
> 
> Will keep after this with urgency, just wanted to let you know what I
> have found so far...

Hi Anna,

Forgot to ask, but:

Hopefully you can make progress on other aspects of your LOCALIO
review despite me working to find and fix this generic/525 issue?

Thanks,
Mike

