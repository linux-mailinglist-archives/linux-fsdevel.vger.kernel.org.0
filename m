Return-Path: <linux-fsdevel+bounces-64209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A055BDCD57
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 09:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1C03B4ECE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 07:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096162BDC34;
	Wed, 15 Oct 2025 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZx30LAw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1FE28BA81;
	Wed, 15 Oct 2025 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512246; cv=none; b=bljxpH3gwTEBf4ZyGAz7196mrtA+tLpEG0s5xBaJ0Sxl5qz7CI2hTJ+doQDneBhvOsRzCsvlmG+x7JNx0KCZ39em3FpoFnqI+5OcRoHh84UMI196ERLlK/6v9Fl6hixvoes7tAmZZOB7vb1V+G0NtNDUiU1To+cdYCibdpvHof4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512246; c=relaxed/simple;
	bh=F6XEA9b/WIuMYIbxBjEHDXJdabmhas9e25A+k7+TJMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mYJAxng+eIH0K9bH0g2XrlBumJSgWHBOa9o97DTkplP7Qb3SIxmhWDjii+zdoF2tCkXYQD4Fp1RSuLmiKYg/vSDnzylfBniPVMnc1BGnLfZExXqCEc1O4e1W25x5UCIT/KAsJlJz89fgDQDFIzi7QeI+a+mun4Lw3Cnuwdwy3J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZx30LAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DEBC4CEF8;
	Wed, 15 Oct 2025 07:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760512245;
	bh=F6XEA9b/WIuMYIbxBjEHDXJdabmhas9e25A+k7+TJMQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OZx30LAwyJMjpxckQ/FquHzM1LwSmGYscCGhcbdgfRJIOJ3hCFaAW2ElMNehp713c
	 /X2oaS29okThe+nrgPPoHulukEOKJA98YYZ2mCyQwU5mZz4AUJ7pokRGMaPKYSMce3
	 PuVhzcN8KnEtTWhoCtJoaCQbcpfOdGGcbllVuMiLZFtMRG2cF30wgWprtT5JUesZ80
	 DtNT+UKcoIhY4TV/qF7n5AfBG+bzHDEk3zR8fjAtKlU59NCMpPvSLQTQ7v3UZQ+u22
	 nwYcF/HsfZESoglixG0NXAK57mEA3uLNbZba7TLyyUdYrWPYS9Uv0Qd8vOYeuyI9qE
	 MBnlMKKDEJsKA==
Message-ID: <ed5fdaf9-f813-4b47-8f4d-7f2988038402@kernel.org>
Date: Wed, 15 Oct 2025 16:10:43 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] xfs: set s_min_writeback_pages for zoned file systems
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
 hans.holmberg@wdc.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org
References: <20251015062728.60104-1-hch@lst.de>
 <20251015062728.60104-4-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20251015062728.60104-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/10/15 15:27, Christoph Hellwig wrote:
> Set s_min_writeback_pages to the zone size, so that writeback always
> writes up to a full zone.  This ensures that writeback does not add
> spurious file fragmentation when writing back a large number of
> files that are larger than the zone size.
> 
> Fixes: 4e4d52075577 ("xfs: add the zoned space allocator")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

