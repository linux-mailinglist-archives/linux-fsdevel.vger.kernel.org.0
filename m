Return-Path: <linux-fsdevel+bounces-70354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BA278C983D0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 17:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA80C342B03
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FB533344D;
	Mon,  1 Dec 2025 16:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MzMhBHbg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD0333727
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764606413; cv=none; b=nTsISkBvIJ/NX20ngIbYIU5gPOoz+qQlWj94DDPkwBlzCHMEvi/qWzNqhZzpIgHAGnLq71KUWZdD+Cz0Q+7r7D4k9ngZ5chgzezxWnZ0chdOZJqU+LRm3FUzwGuUozmGCPdVbyDgT/BthvWUety6Toe1eDrzv6KxtNqKKd353lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764606413; c=relaxed/simple;
	bh=ObSa3cr42p95JZ4Lslz+xZhV2PhJEEGvSjR5Bm34fXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mGc77SFEno+vSaL0TEGh3Nf+gtcocww/BhlDi6KTJKfCX/Q/mEUd84jwEuVhWI6/L9DWeZqu5/hnKzC5/yrVBymv58QCyiXMzBRosG1Ur0OknI+L/9bHxDg3ZPweLPM9vQ9R+XLXlfT8gMuI4JZ+eFHsOwh2mRGsO4n33Cycpyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MzMhBHbg; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-121-67.bstnma.fios.verizon.net [173.48.121.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5B1GNu9j008211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Dec 2025 11:23:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1764606238; bh=0yVUKXTtwJEW6Qb8erb3IMpn8nAvCrMoJd1g+vTGMYE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=MzMhBHbgCgoQq81uxt+PM6X6toic67sGwDyCozloICR4wAE1pNCFFxyIkc7RxGY5j
	 RSJOlDZGQZLfHK/R/hDdJfINXoeiwREktZAMyXZ6T65oCwwKz9629G7U8j/nnXlEV1
	 yodYV5JWYL/pJWtndneRt3UjRqd87+uCA644Cqi8Fo4Vp1OKy0UDeSfLrKs0oNh2w/
	 tyxJNSwJAplKZ2Amd30NCi+TKqpqj+G0U7QBqHL7KYOP1py4bXDbnc/SB6n+Vuh9DS
	 pbD8zVnbSqz6xJ9XB7v5RMCR+9XFJ02v4LRKZr0hwmX39kcgXolwyUos3TrfK0xSJA
	 5TWW41NHIi9Ww==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 0D3872E00E0; Mon, 01 Dec 2025 11:23:54 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, yi.zhang@huawei.com, yizhang089@gmail.com,
        libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 00/14] ext4: replace ext4_es_insert_extent() when caching on-disk extents
Date: Mon,  1 Dec 2025 11:23:50 -0500
Message-ID: <176455640539.1349182.13217688668593418002.b4-ty@mit.edu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
References: <20251129103247.686136-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 29 Nov 2025 18:32:32 +0800, Zhang Yi wrote:
> Changes since v2:
>  - Rebase the codes on ext4.git dev-91ef18b567da.
>  - Move the first cleanup patch in v2 to patch 08 to facilitate easier
>    backporting.
>  - In patch 01, correct the mismatch comments for
>    EXT4_EXT_DATA_ENTIRE_VALID1 and EXT4_EXT_DATA_PARTIAL_VALID1.
>  - Modify patch 06 and add 07, cleanup the commit message to avoid
>    confusion, and don't always drop extent cache before splitting
>    extent, instead, do this only after PARTIAL_VALID1 zeroed out or
>    split extent fails.
>  - In patch 08, mark zero_ex to initialized.
>  - In patch 09, correct the word 'tag' to 'lable' in the commit message.
>  - In patch 11, add return value check of __es_remove_extent() in
>    ext4_es_cache_extent().
>  - Collecting RVB tags.
> 
> [...]

Applied, thanks!

[01/14] ext4: subdivide EXT4_EXT_DATA_VALID1
        commit: 0f9885eab9182118fd7bfd8cdf8bab6f71f74699
[02/14] ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1
        commit: 1fec988b1f71c27c45d31cde6ffe3efdb10657b9
[03/14] ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting before submitting I/O
        commit: c42e9f199c419f11938b8d411123e3f6719941d4
[04/14] ext4: correct the mapping status if the extent has been zeroed
        commit: 2410e55561cc405c56b9e38d69be1b8fdb6c9722
[05/14] ext4: don't cache extent during splitting extent
        commit: 4b4a6ac831ff347127e46c60a516b3ec42921242
[06/14] ext4: drop extent cache after doing PARTIAL_VALID1 zeroout
        commit: 87d5cb059b8ab1623f5bcebcc0b53e43abd36ae7
[07/14] ext4: drop extent cache when splitting extent fails
        commit: 889085343ddffdf9ccb6be8402469458da6b350f
[08/14] ext4: cleanup zeroout in ext4_split_extent_at()
        commit: 02f8dc1707ceb87656288e6460f3ebb94200ba2c
[09/14] ext4: cleanup useless out label in __es_remove_extent()
        commit: 13cbc168d9ba14822de66fc085e85416cc2fda8e
[10/14] ext4: make __es_remove_extent() check extent status
        commit: ad02a3d000a512aada99cfad13d62c3edfb793de
[11/14] ext4: make ext4_es_cache_extent() support overwrite existing extents
        commit: 41a414d53bfb5c91ea5c73125181568901c74a7a
[12/14] ext4: adjust the debug info in ext4_es_cache_extent()
        commit: 4e84970a460d27f35f3127327c3e131476c06b03
[13/14] ext4: replace ext4_es_insert_extent() when caching on-disk extents
        commit: d494567091eddfeded77017bb9b4dc677046d93d
[14/14] ext4: drop the TODO comment in ext4_es_insert_extent()
        commit: 6fb67ac896900e60f46ee4efba97b372a80370e0

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

