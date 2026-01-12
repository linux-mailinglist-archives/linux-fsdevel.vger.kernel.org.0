Return-Path: <linux-fsdevel+bounces-73180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07897D1038E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 02:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01DA0302AFD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 01:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B8815665C;
	Mon, 12 Jan 2026 01:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8nUe/Sf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7C429408
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 01:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768179783; cv=none; b=HWWC1D48XQD2RF0Tj6iqd9UcEPFWL4Gkksy2MtyQNve73MHpAhNA6BZkjfWwTQSSuBZLfV8qDSXBvfXPBRAURhgNP+G8pueCVqHdOZFSWHaIzFLxOtfjjE/V3MRlM/fCltDJCF75dgPqtjaFhJrQ7sGfscNWRsutyX1CPsDT38c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768179783; c=relaxed/simple;
	bh=31M5baKvnKcs8ZfP2eQXS6/Foy0grzlRmN5hR/hBPiE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=T4NiiFWSBtD0/7N9+TeB7XwbYV12jDTMVVW3emyDYU19cZ0QGGlpK1SN2KgP84ZnuIEqFBQ4l3e0wMqDmpiC+Tc9ntp/DNEPtnC06xNF+LqCLl3LqQb8fLHvJ6UAtkav9g9ohK9BOBbKotETFOHKUX4pMDpULcBHwBH2Uef3t3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8nUe/Sf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAAAC4CEF7;
	Mon, 12 Jan 2026 01:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768179783;
	bh=31M5baKvnKcs8ZfP2eQXS6/Foy0grzlRmN5hR/hBPiE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=X8nUe/SfvweawAdrtmOrdwoGWIRWf4jBElenHv6kevPssljudINUVi60LkPgv15ZV
	 cj4I4DgX7QlAH1Qd9Du64i0EIfU4f/GozLvZ8JPFXnPQvzYHWQgbPFB9VqxOb6/uzr
	 GYtoiAMZ8Xq1HpTojURx0L0Ftx7snI1MPlGZMXisZPq0Oa338icCebxsd7DCXPnoo7
	 /q9jNNT6bwm6fBLJ/vMkjBsd9cneisnaolor7G5biej54Pnws6bNet7VpZ6upN+IqX
	 xboFjFZKuobW9oHKPxSSHX+f09ESkiSrVomQywWDRDQXFs8E95LnmB2ChnjjTt6PUK
	 VsXXgrBIT44jQ==
Message-ID: <a1e52b25-ca95-4698-b36d-c67b65a227c9@kernel.org>
Date: Mon, 12 Jan 2026 09:03:03 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org
Subject: Re: [f2fs-dev] [PATCH v2 2/2] f2fs: advance index and offset after
 zeroing in large folio read
To: Nanzhe Zhao <nzzhao@126.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
References: <20260111100941.119765-1-nzzhao@126.com>
 <20260111100941.119765-3-nzzhao@126.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260111100941.119765-3-nzzhao@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/11/2026 6:09 PM, Nanzhe Zhao wrote:
> In f2fs_read_data_large_folio(), the block zeroing path calls
> folio_zero_range() and then continues the loop. However, it fails to
> advance index and offset before continuing.
> 
> This can cause the loop to repeatedly process the same subpage of the
> folio, leading to stalls/hangs and incorrect progress when reading large
> folios with holes/zeroed blocks.
> 
> Fix it by advancing index and offset unconditionally in the loop
> iteration, so they are updated even when the zeroing path continues.
> 
> Signed-off-by: Nanzhe Zhao <nzzhao@126.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

