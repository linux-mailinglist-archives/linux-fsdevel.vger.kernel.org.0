Return-Path: <linux-fsdevel+bounces-53157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28557AEB149
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 10:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B6C189AB73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 08:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6946723C4FD;
	Fri, 27 Jun 2025 08:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fsyw0vXR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B714F221FA4;
	Fri, 27 Jun 2025 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751012795; cv=none; b=WT+IYmGakzbZtcQWTcVuGHacZQM5nNCl16gOEZSYy4R744aaaCRS5WYpCf5dOpdrE1L00pOTc1Q8ztftAeBqNVFw64eiEDWhZG3IWyfH2sGUXcFitkE5FDBY9VwZRuV8p/mYm4GAx1WxkoLW52tw0LW6tZOjuFuzXw6PxG42lqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751012795; c=relaxed/simple;
	bh=KxJpOYD+3nHKS3dwy4PM75505XQKwtvSJxp4O8pwOTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOBVKZJLx0O/j+UhhUChB+a7Vciv76G2gG5HnlZpEcDB+qP5xAEiEeEquzkhdEUVfzZkV9nIZw0KznpMvLR+BTJkJ/B2eh7DmL1tPAnRd4i+rfTGdrj4yeJPoZ8PVXxyG/B8zTZQwmSmZguXk8yirx8+ZMt3011bcttg7lSC7Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fsyw0vXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15503C4CEE3;
	Fri, 27 Jun 2025 08:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751012795;
	bh=KxJpOYD+3nHKS3dwy4PM75505XQKwtvSJxp4O8pwOTA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fsyw0vXRqV/SFIoD6NxzRCy1M+vH+xngMBKnYR3icuDCPuQLonUT3nuP87ItKWC9h
	 LDg614GVm24IsZx/LJE8Abl/X4XASFxdT/FJdhHFqtnlzu3HtF7OU3SIHpnC6VIuOp
	 Lg5gQbJ2Q/bvIkaYVLPJneZiXadtiXCk+e8Xcwc1NVUjxVlENMXJOWPhdW2d0ie7XR
	 9lGNBtkf6AmzwxctidSmfOuCwErjbM0tv/Ps/mEB28O6mkVwyURAl5X0A4xoYYFqhr
	 P6FjwJ4b36pHDowkZt3qgOKo8xQWSQ26TP1aSMhpNNWD0cik05T9QVP/K5yJKOHM7Z
	 tspcAKrhgSSXw==
Message-ID: <cfa09ea7-a446-4bf5-9c34-cbc3092ce986@kernel.org>
Date: Fri, 27 Jun 2025 17:26:33 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] iomap: hide ioends from the generic writeback code
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-block@vger.kernel.org, gfs2@lists.linux.dev
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-5-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250627070328.975394-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 16:02, Christoph Hellwig wrote:
> Replace the ioend pointer in iomap_writeback_ctx with a void *wb_ctx
> one to facilitate non-block, non-ioend writeback for use.  Rename
> the submit_ioend method to writeback_submit and make it mandatory so
> that the generic writeback code stops seeing ioends and bios.
> 
> Co-developed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

