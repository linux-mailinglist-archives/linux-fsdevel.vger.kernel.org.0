Return-Path: <linux-fsdevel+bounces-43701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D174A5BFAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5C81767E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 11:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699CB250BFF;
	Tue, 11 Mar 2025 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXEEMMWp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA73F9CB
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 11:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693733; cv=none; b=ji0rGK1Uf0bgkyPSdsfbjitfYVyQE52+zg0VEQLKYFjtdysYzbQSJZEikNW2lJzz8oRN0Ow3Juoc3wGweTi8qHwiU5/QmqTYTFN8McL+vWOfgalJa0MNqQ7qfpscXb33mp7IQt6/wrg/lW+fWpCDuUrmJzl4/gzyWSHFyU2+iRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693733; c=relaxed/simple;
	bh=ct1RD5Dm6Apm9DcwI7XbOMNgTuO9NkqnuJ8nAT5LQqk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WxBNaCKeXYVOd2KYvyZlzRm8/zN/R/jdtwHOUyZZG95LS7Rk6VTaUs/0cxdikDNbNkJCEt9exK2D6KAqDCu0nDQNKW08SJprLCGnaO2sVR+qiQ45N7RZDK0DHIvvrLIDkv8zBTTcGju4crdXPLIEGH5hiigR3/K9/r5fMAmGkf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXEEMMWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C71AC4CEE9;
	Tue, 11 Mar 2025 11:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741693733;
	bh=ct1RD5Dm6Apm9DcwI7XbOMNgTuO9NkqnuJ8nAT5LQqk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=pXEEMMWpBGQjI7QDoUTKp7aHbBl3dKuT95/mUUumVuP6bS8hOCAAnCOVklo0Rc6kH
	 i7bXA8Ese0b/ZTRW3QLP1npyf8+Ws+hUA+Sg4nnEkIdBegDmdypio4SUPt7CXslPVG
	 VELsElybZiwM5nIPqLSAHSkUko+ArtNhXozvhP7YDn1v6n9F9DAsoww77BFWQvqQvB
	 qHNpk5BQBhq9X2e/kcluQGIjlNdmsdJ/8+ol7UAbVDGWu1HpCDI8nueHU7B3/Vx0eW
	 lYNgmFHAtTA4dgo6jkzHPWulU0ZtGSteNo8fAnw5e9EwCMLja1KMa+AhW847UeuiN6
	 5SbewQNfaeFyQ==
Message-ID: <9562210b-bf6e-4bbc-860f-40aec418ea36@kernel.org>
Date: Tue, 11 Mar 2025 19:48:48 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] f2fs: Remove check for ->writepage
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250307182151.3397003-1-willy@infradead.org>
 <20250307182151.3397003-2-willy@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250307182151.3397003-2-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 02:21, Matthew Wilcox (Oracle) wrote:
> We're almost able to remove a_ops->writepage.  This check is unnecessary
> as we'll never call into __f2fs_write_data_pages() for character
> devices.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

