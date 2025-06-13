Return-Path: <linux-fsdevel+bounces-51574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00030AD8540
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 10:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7D816B422
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895431EA7E1;
	Fri, 13 Jun 2025 08:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6SmUy65"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A252DA767;
	Fri, 13 Jun 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749802030; cv=none; b=E8kmJT2TwE/ZULooWIa9tce9bYwiLOhMS2G3WT6mP+XslK+ND/fedTtxMB2CtEXc/j6ZWa2UQvr/QKHu5LVV4pCw8lx12scnPo4ZL+RimCubWZ6LJQ3k/apTP+GwDTtgIsIwOcRbJ3kokyBmFJi3IRHlACF+KDjBWytX+6G61aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749802030; c=relaxed/simple;
	bh=FguKn5cWBBBVfu317SRW++wMPeu6yXq2aquB7LyL3Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V28c3omZbqlnWnrrcL6szRWl9A2n2Zw8QRfY0zoksJFUfcDzO9xA+bqmx7DgnUJFEPQPZMMp4RhaRXqlFZg1ITJkLO0qOLqcW5B1paC++FX7Qiws3BmzRzxL7Ct+p+egboJZsGPSQkN6Ej/aSc7AAb31rAlIMsgK+miOflW91z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6SmUy65; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC262C4CEE3;
	Fri, 13 Jun 2025 08:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749802029;
	bh=FguKn5cWBBBVfu317SRW++wMPeu6yXq2aquB7LyL3Vw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E6SmUy651+0syjkpXgiF0ZllUAG6RLTxi9pFGfGH9racoJk82/bGawR4G/TPZj54o
	 JppnPAyBSh7pKRWuPK6OYMFEBWC0izd1Jp6qKhtIMk+XyH+jmtUwzIdKcHNDdF4YPm
	 x8WPhR3rf/KKBUJ5+MCc47W87cXTG1OE6jXITt8nVJ993s55S5efpnN6GzXxCRai4/
	 z2PdCIQsOISOwZT8rKTQ7IlcM7+ng6FTp27DpzQGfTOZdfkkL3JC83eR6rPft6Clf6
	 YyXSskRmsm57JwEydU8p7GQjMd6kzeq/KOzW2CZELTGdl1bbMn+9c+dBR86XpTZ+at
	 U1EmJL3YcTp1w==
Message-ID: <839d0ce4-375a-4888-94b8-c2827208263d@kernel.org>
Date: Fri, 13 Jun 2025 17:07:07 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: use ZONEFS_SUPER_SIZE instead of PAGE_SIZE
To: Johannes Thumshirn <jth@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <c14f62628e0417498ace0caaa1f4fef2cb0f8477.1745934166.git.jth@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <c14f62628e0417498ace0caaa1f4fef2cb0f8477.1745934166.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/25 22:42, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Use ZONEFS_SUPER_SIZE constant instead of PAGE_SIZE allocating memory for
> reading the super block in zonefs_read_super().
> 
> While PAGE_SIZE technically isn't incorrect as Linux doesn't support pages
> smaller than 4k ZONEFS_SUPER_SIZE is semantically more correct.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Applied to for-6.17. Thanks !

-- 
Damien Le Moal
Western Digital Research

