Return-Path: <linux-fsdevel+bounces-48445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14501AAF2E9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 07:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442EE1BC516E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 05:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ADC1EBFE3;
	Thu,  8 May 2025 05:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VT+XagNG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB6E8472
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 05:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746682262; cv=none; b=Qm6dfGJubTX+pDnHafdR2cFXqrOOHUGMQdKzu5dAFL3/905ZGQb38iCfw6AODCoXtYT0qBRXm3uqtq2XbeLLngpaOYx0fmuncnK+Jy4rLO6395Jz1tdbY5nC5CbrP9VqPDDpaMAn+N/hIQDCI3phXmc5arDjgHPj7zee3tuCM7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746682262; c=relaxed/simple;
	bh=A0gbx3wfSdRuPbdEKLgiwT1yRw4RpwyxZobvj/F08q0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FZBSpqnzmenKxXRbvnHEEYOUMx+eTnrGN/sRqgVklygl9tl/kCDfSpI3cJ5r4AXh3X5+IdOTpUE2zghfp65VonOg4pmzt/RgUkJGGfkUwaOZLVz1Wlm8W2ycI4WheLppkWQopazSVPxXFQjjpCXlZgZi90ZyJT67ZEsX7d6r8BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VT+XagNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 088FAC4CEE8;
	Thu,  8 May 2025 05:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746682262;
	bh=A0gbx3wfSdRuPbdEKLgiwT1yRw4RpwyxZobvj/F08q0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=VT+XagNGJ+hPtEtX899csYitcPXv3V3mDjYtdY5P+Xlbs2+Ega/3prTbOUujZOaBQ
	 DgSPcZjMzec74sB0gqmcbVcRJpKWw5rBl/E2fqALjZLnVlj4pUQmamfbAbsOvuyOk+
	 wHzojozITa/g+9b2//fLa0NUgURKilz14eX9GUlfMKZJa5JvFyIWVF2ZIdcHMzw1pC
	 n71+z/OChJcR39xjH86VDWVvOKCJ/dCJfYzQR1W3GfhBY11ZfVKeg1TrRF78qJyr4p
	 3PgRN3EwJ0bxB1UMGUp9nt2XDrP9L0OlxrXla3D0cdkL+EOb3YqNL1dHy3Uvw5OcL7
	 flWn6WouLzLgA==
Message-ID: <1d47a36e-2182-44bf-a3b7-cdc5e07a820d@kernel.org>
Date: Thu, 8 May 2025 13:30:59 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 lihongbo22@huawei.com
Subject: Re: [PATCH V3 3/7] f2fs: Allow sbi to be NULL in f2fs_printk
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-4-sandeen@redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250423170926.76007-4-sandeen@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 01:08, Eric Sandeen wrote:
> From: Hongbo Li <lihongbo22@huawei.com>
> 
> At the parsing phase of the new mount api, sbi will not be
> available. So here allows sbi to be NULL in f2fs log helpers
> and use that in handle_mount_opt().
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> [sandeen: forward port]
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

