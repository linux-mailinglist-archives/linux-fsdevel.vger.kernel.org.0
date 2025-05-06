Return-Path: <linux-fsdevel+bounces-48255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B051AAC6F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 15:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4B54A43B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F54F28033C;
	Tue,  6 May 2025 13:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJl28nR7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763B5208CA;
	Tue,  6 May 2025 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539511; cv=none; b=s5GUQDVvZxcRprGDkarSDSWiYB9yi8k1zLsp2wmHzfDe/l0Zy3YGl0aa96M5eQpeHd5KzBK1xTlEGEetSh8oJl9BjfO3YLrkUNDLleIlOBQZ9tTtnLxCHWQlxqxR6AKdABscDx2/uKjZ7MxzJ0AYrs0AIiG7iLxAu7J/8KO1dqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539511; c=relaxed/simple;
	bh=kOu+LL3zjg0TPwi96MyHYxoid3IjGnXwNv+/5apGPu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOT6H5xVoHnEXYk1VfpO/mEk/ZAV4DDSIZJhTqhFM1RP44T6pzBOzVw8Mg/6r03dlRKvqZT5rvMWp1hIpEP5oImODvr1+cTNprrM2trLhCUzhJp+6Nnb98YY1e73/y4C3pW/yMZ00ABdg0nyDqraynOzZV5UuEP3QNKZICExGhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJl28nR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BB72C4CEE4;
	Tue,  6 May 2025 13:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746539511;
	bh=kOu+LL3zjg0TPwi96MyHYxoid3IjGnXwNv+/5apGPu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJl28nR72rfmuk2s98JB1ZSX0+S6O28XoA3j92AfT7OtwbvpbF9LwWPtUcV6gBfdT
	 aRANHjba9zvbGfkzGJgXxQ+wfU2+qHBCYqyoXDmQWKtqmKYvsHfawYMstuMH1kRsYU
	 n4VDSXikvmAG0o5SGTcI8UPuabNre4pguxgfGvOz1OKRoc8tzRHnpcHSfUKt5vtUCj
	 puQXh0ibnZ9Mh/sWUzzeIJLfVSxLITm2jfr/YwRxuPKrIHmbnW7PMRHy0UMgpqHbra
	 E41dcjJ3w6Kok+XOL0FQMofTdUxXhYDi4SE5bjbVQdeF8To/vcgJI6ovtAfZZrls5T
	 Av1htu2/EdoRw==
Date: Tue, 6 May 2025 09:51:47 -0400
From: Sasha Levin <sashal@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	Christian Brauner <brauner@kernel.org>, viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 342/642] fs/mpage: avoid negative shift for
 large blocksize
Message-ID: <aBoT89awjNjboEe8@lappy>
References: <20250505221419.2672473-1-sashal@kernel.org>
 <20250505221419.2672473-342-sashal@kernel.org>
 <aBlfg8tuWY1_GVPJ@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aBlfg8tuWY1_GVPJ@bombadil.infradead.org>

On Mon, May 05, 2025 at 06:01:55PM -0700, Luis Chamberlain wrote:
>On Mon, May 05, 2025 at 06:09:18PM -0400, Sasha Levin wrote:
>> From: Hannes Reinecke <hare@kernel.org>
>>
>> [ Upstream commit 86c60efd7c0ede43bd677f2eee1d84200528df1e ]
>>
>> For large blocksizes the number of block bits is larger than PAGE_SHIFT,
>> so calculate the sector number from the byte offset instead. This is
>> required to enable large folios with buffer-heads.
>>
>> Reviewed-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>> Signed-off-by: Hannes Reinecke <hare@kernel.org>
>> Link: https://lore.kernel.org/r/20250221223823.1680616-4-mcgrof@kernel.org
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: Christian Brauner <brauner@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>This is not relevant to older kernels as we had no buffer-head usage of
>large folios before v6.15. So this is just creating noise / drama for
>older kernels.

Sure, I'll drop it.

>Where's that code for  auto-sel again?

https://git.sr.ht/~sashal/autosel :)

-- 
Thanks,
Sasha

