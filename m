Return-Path: <linux-fsdevel+bounces-53156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6A1AEB132
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 10:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BA9E17E325
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 08:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139FA23B62E;
	Fri, 27 Jun 2025 08:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEG0xXYV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6212D234994;
	Fri, 27 Jun 2025 08:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751012598; cv=none; b=TmihBsGrhvU7u0OAIZIhNrNXpZAdHyHSFH+0lzKYLGqmd1M2Z+YLNSRVvZb0nyo8ajntoaXJ5y6pufA7YGuZlMc9w+bw8Jz5jubcwsncOYBVqkc4SjgqiP7d41x497v+rJEkCpgqIKzgf6xyIMrWoUCC4Vn4xH/vdQfWBYOu2GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751012598; c=relaxed/simple;
	bh=1DCg+7SgOk9SWHlBdL0rkujTDi5yPr3Sw57TG6gX0MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9hd23MNRD34dEtZBqWT/UN7H6ApA+2bIHtMZ0baPkdfC/gD9WXw0vecVMCt+N7b+hEEH76PB0Kfot2MipBdXKDZ66VGJ/wkzoH7El0gP9Sa+hq134V/0EC05wPbbQBTFtzCbp4aDr3T9Rk8U7u6y1AubI1TdGkY5TOuV3C/qRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEG0xXYV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B153FC4CEE3;
	Fri, 27 Jun 2025 08:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751012597;
	bh=1DCg+7SgOk9SWHlBdL0rkujTDi5yPr3Sw57TG6gX0MU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eEG0xXYVBC/pGaUKEYqSVk+qYa/DL9lo2VWIz9Nga8Sb/J4E2gjgEOnWFQLDwuNdP
	 M4yv8u74LtOM2Ab3Ziuos43c7FRpg4w+VlP23rPeETBjEcGCTBtAkKHYo7/cYzLs0h
	 E4c5wtxsKDvuc2PEhpk5eO6fwEBObbUEWaGJo8M2lXGZJBlDd+m2xDIgqf8eKrZ6RB
	 CWeTODHhdruMhwMokDGsY26yHEMFfB2pwFhp9fubWA/WlTgAAKPk4A1gef7bHsX60N
	 EbUAjrpcNEBqEyBvPRS4pfK/4zIRWd+7QiyWTIbFq/ROmnB5bzTGJBG4B5T8ckArH2
	 93NgnUJb724yw==
Message-ID: <e2041940-5673-4eeb-ba9c-9a18663b1b43@kernel.org>
Date: Fri, 27 Jun 2025 17:23:15 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] iomap: refactor the writeback interface
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
 Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-block@vger.kernel.org, gfs2@lists.linux.dev
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-4-hch@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250627070328.975394-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 16:02, Christoph Hellwig wrote:
> Replace ->map_blocks with a new ->writeback_range, which differs in the
> following ways:
> 
>  - it must also queue up the I/O for writeback, that is called into the
>    slightly refactored and extended in scope iomap_add_to_ioend for
>    each region
>  - can handle only a part of the requested region, that is the retry
>    loop for partial mappings moves to the caller
>  - handles cleanup on failures as well, and thus also replaces the
>    discard_folio method only implemented by XFS.
> 
> This will allow to use the iomap writeback code also for file systems
> that are not block based like fuse.
> 
> Co-developed-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For zonefs:

Acked-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

