Return-Path: <linux-fsdevel+bounces-43702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E76FA5BFB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CC7189631A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 11:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0832254872;
	Tue, 11 Mar 2025 11:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swP1eeJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60736224258
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 11:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693740; cv=none; b=qI4Fh+s6V2ErzJ8FfmydQzw233o4GDqD2Vs8/cYuIeNCwXpkBxvPBXHa7ZwNh7v3gxNwI6hkwiyadcC2YvSs5TJ8rWkyJhEnJcstSw9RmvLGrksKYoVaXFqRzEPQacHIEln8GQG4Mo0Dm8+ojfZUKpdMrGm6aMurZaHPlvWUW9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693740; c=relaxed/simple;
	bh=RtjSiZtx5omuFVg3avMcut1p0gnfZssAhseajHHPr5c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fGQVxkK+p8yurdfx9Y14GYmcLmoUpTksjzFRkeQYsoMkvGYdh1zyteuSFDo4WFW8RJf+l6A3uLdS+h03RqZunE5WL3fHLL9qndH8/VUgBZ9+MvsQ9WO6x+LSI8IHhaZypAuXADBW1lFdPYs/qM5PgjdXXwI3VsRaZ/6zDOt2UIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swP1eeJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CB98C4CEEE;
	Tue, 11 Mar 2025 11:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741693739;
	bh=RtjSiZtx5omuFVg3avMcut1p0gnfZssAhseajHHPr5c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=swP1eeJqz9wAlJelMRxacwPkGbFz6jh0DEgR7pUP0pbGycnEyhtMvsxwzvh1LD5YK
	 LIWiwzgY+BbGJA4LoafjQO1AIywnS7Ytl+SWVG+GRSpnHY9/8IQvUwVYDJlcraPMAs
	 LV/m0fXHIp7yUFNWeMFD8Pat0sQ9MRj+e+tCxbVAGB1ZS0wof2BtbTeOnvfeJMbszb
	 dqR+bVNWcQiFi/HU4KrBZ3QtI6tIhYCGKUpbEQlAjBsXZH3R9UU+ecDDfb5PVarKv6
	 6u8RLr1+cdGZ4G/j28jn7Yd25DHwweCCO2+Npv1xiJIA5QkVPIxgwOQU/rGSQyb7Ka
	 hlK49v4FGxpIQ==
Message-ID: <88e7f270-a752-471b-b57a-8b557c586ed4@kernel.org>
Date: Tue, 11 Mar 2025 19:48:57 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] f2fs: Remove f2fs_write_data_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250307182151.3397003-1-willy@infradead.org>
 <20250307182151.3397003-3-willy@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250307182151.3397003-3-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 02:21, Matthew Wilcox (Oracle) wrote:
> Mappings which implement writepages should not implement writepage
> as it can only harm writeback patterns.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

