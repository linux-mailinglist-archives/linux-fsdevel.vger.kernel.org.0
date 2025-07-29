Return-Path: <linux-fsdevel+bounces-56236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62673B149A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 09:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7D797A326E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 07:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D30926B77A;
	Tue, 29 Jul 2025 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cr2KzO7C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0620297C;
	Tue, 29 Jul 2025 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753775929; cv=none; b=TyIiPXQOUG51Sipt1Fi/ufrmUD3lECteTFWWwcnZvv1dUcgMf8JtVe9wQSd9jlNg9GO65ZIChMA5V3MFIt5ubjP1GWxUxRsp4yOmJ91QaX86Pf+YZTgZeUDIFzGYJVuXJih2eq6T1lKBk7mmnXWncLMR7y0KSVuBdq5ie+ufjyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753775929; c=relaxed/simple;
	bh=Vp6TxifByKcfcj1fkcF3/qXF8DfPdAmSyvTmkE6JE5M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=WGcXrxXcySye3SUjjILKKmei1FUod6vY/bSPs3nKo1oG3FWvOknuk1H6YTzQaqvaXW78Ps2GSrKj1txOI0cEN1+ry1GwjiIJMiemcj3Mx6wLS4m2Hmwxe4AXlLsOwAaW9NlgOSf1RAbkAaq7PS7KN1vUKpN7FCSTCKWDYFPnSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cr2KzO7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AF7C4CEEF;
	Tue, 29 Jul 2025 07:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753775929;
	bh=Vp6TxifByKcfcj1fkcF3/qXF8DfPdAmSyvTmkE6JE5M=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=cr2KzO7CEyIW17W9A71jkiCDkBG+CPZvae1doz9cDltsJsRneypVvmyiAWtctbyve
	 uB0JSMpWs6KpRUjGXFwHbMKQpmDfCJOBjFQY2NkqaWNBviJ7YNQHTeNvC5EUd3XKMZ
	 deSW9+siw0CNmgfnYqGwcBiX/0HV4qSAxa+tswEUk0lrT6FG2CsvsZNVMzxbdmCo3Q
	 sfh2FHKGa+9cBNOaA5F64NA589OaXPYrwuuVZ3LBY+eXhkPEGzHNfZLdepD0KwP7QH
	 QhiPWsi0Qd+/VQ0o/L4DqaZxHGDlaGQdRuEdG6Ti7b1JKe1CjE6IZ7HH38Btb/JygS
	 3jWc4mZsblaEA==
Message-ID: <dd34e42f-4451-40cf-ae14-ba5da2efcc49@kernel.org>
Date: Tue, 29 Jul 2025 16:58:47 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Improve read ahead size for rotational devices
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@vger.kernel.org
References: <20250616062856.1629897-1-dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250616062856.1629897-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 15:28, Damien Le Moal wrote:
> For a device that does not advertize an optimal I/O size, the function
> blk_apply_bdi_limits() defaults to an initial setting of the ra_pages
> field of struct backing_dev_info to VM_READAHEAD_PAGES, that is, 128 KB.
> 
> This low I/O size value is far from being optimal for hard-disk devices:
> when reading files from multiple contexts using buffered I/Os, the seek
> overhead between the small read commands generated to read-ahead
> multiple files will significantly limit the performance that can be
> achieved.
> 
> This fact applies to all ATA devices as ATA does not define an optimal
> I/O size and the SCSI SAT specification does not define a default value
> to expose to the host.
> 
> Modify blk_apply_bdi_limits() to use a device max_sectors limit to
> calculate the ra_pages field of struct backing_dev_info, when the device
> is a rotational one (BLK_FEAT_ROTATIONAL feature is set). For a SCSI
> disk, this defaults to 2560 KB, which significantly improve performance
> for buffered reads. Using XFS and sequentially reading randomly selected
> (large) files stored on a SATA HDD, the maximum throughput achieved with
> 8 readers reading files with 1MB buffered I/Os increases from 122 MB/s
> to 167 MB/s (+36%). The improvement is even larger when reading files
> using 128 KB buffered I/Os, with a throughput increasing from 57 MB/s to
> 165 MB/s (+189%).
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Jens,

Ping ? This is reviewed. Did it got lost ? Or will it be part of a different PR ?

-- 
Damien Le Moal
Western Digital Research

