Return-Path: <linux-fsdevel+bounces-63625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 765C6BC74E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 05:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23D5F34F651
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 03:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1172376FD;
	Thu,  9 Oct 2025 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH6h/V4L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E372110;
	Thu,  9 Oct 2025 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759980875; cv=none; b=fUfoj9eMWNCyYMStfFK8vhLD4+fprqZi1xZzN6RAQPeWvoo56JW7Qx3ryMaOm23f4CXS1Qrt5N/KmLMc6TAxwNRrOFtNMi4v9iuayh25U6Aczya+sDZk9YGP6CQvYjVJJuPKiwyklEBJdOtkfFFwRdQ/rWaRImfucDpAXF6fbN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759980875; c=relaxed/simple;
	bh=zQySicJyzHQVgMUqKbwHP7OwMs25Xmyd6FMcON63clo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iksL6k00kR0ojbM99+pTt3wWCZgEI24blYPTWQbzeeWHttyR/p8oas+TVYgd9pvm+JMf6FqOIj6vMpN1WTdFFLVeBYsCt7mpYuZI+Zxa1FrI/TGj0cW22n7GDgyudNBhxQkumCYNPXbBXdinZU8ba/FjdzkpqhSuk8F8TvyHBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH6h/V4L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ECBC4CEE7;
	Thu,  9 Oct 2025 03:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759980874;
	bh=zQySicJyzHQVgMUqKbwHP7OwMs25Xmyd6FMcON63clo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=RH6h/V4LzvAFQvOGHVQ2ReUSAztcIIgNnTZI6HgBtL0oY+CicvyhuIYatvy14xFwk
	 P8GGaviitDQx6U9ns/eFTL9bVRAO/XRdBj8Zy5mk78UQO+37ZJAiH5f6Rd8gsWNxVI
	 JhyUe/KdUPA1EoitSXFo1DWJGzJ7tPdVk5Mo3lKgzS3U7FZ6kYHCRxaK8cD0DgkJOe
	 Q72WWEZuGiS3QzAmDQgxX8/9Y5MXwPvNppIckVU8/pCIyTozmyF5IbD2gDwj4MLfFa
	 rusQJx87owxAw7+zASR5N84tZG/hgmInIH75Yv3bHxIGsKAVw+YrMEAft510JQM1H5
	 65UG6A9ZmxYdg==
Message-ID: <e6feb193-0d3d-4cbc-857b-7576db25e929@kernel.org>
Date: Thu, 9 Oct 2025 11:34:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, oe-lkp@lists.linux.dev,
 oliver.sang@intel.com, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 ltp@lists.linux.it
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't call iput() from f2fs_drop_inode()
To: Mateusz Guzik <mjguzik@gmail.com>, brauner@kernel.org
References: <202509301450.138b448f-lkp@intel.com>
 <20250930232957.14361-1-mjguzik@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250930232957.14361-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/2025 7:29 AM, Mateusz Guzik wrote:
> iput() calls the problematic routine, which does a ->i_count inc/dec
> cycle. Undoing it with iput() recurses into the problem.
> 
> Note f2fs should not be playing games with the refcount to begin with,
> but that will be handled later. Right now solve the immediate
> regression.
> 
> Fixes: bc986b1d756482a ("fs: stop accessing ->i_count directly in f2fs and gfs2")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202509301450.138b448f-lkp@intel.com
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

