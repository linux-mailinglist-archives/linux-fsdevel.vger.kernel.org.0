Return-Path: <linux-fsdevel+bounces-49524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5112CABDD86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 16:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 121DD188A8B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB1A2512DE;
	Tue, 20 May 2025 14:41:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F44248F7F
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 14:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752064; cv=none; b=jYaJzU9q8Dr2C9stDSSfqrENxf6/1qZBJH0Q1Q5GbuoyZ0Q7LkDDyL01WTJ7XVfsLE3ByoTsUdaQhKsmoDy5Y8thLwgEG2BNXQT25byXTYFFB7OFktooCOHr5c5iWZC7fYiCuAQP7NPST9iNpbg8bVPp2ARi0TO7Bw/xS7tDvoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752064; c=relaxed/simple;
	bh=H0EzHZkaZM4OH7UPbd8j0MRTzc1Tc3zDBZyC2BudrnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0ypujggRJbYjPUtcUlFlAhCUN4A+ApHcuomD4+T3MdW821WWfhEV0bp2+UDac50xsJl9L882FYzr/bYSj970+mMYBiVpyxKuIi/qXpAXGmQm6nISJdA4DgGl771ZikcAqOSYIyeZfcekGVPUhhQAUUIBlGMj/RBN24j9EkwBgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54KEeQ0U013156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:40:26 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id CB70C2E00E8; Tue, 20 May 2025 10:40:24 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        libaokun1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 0/8] ext4: enable large folio for regular files
Date: Tue, 20 May 2025 10:40:19 -0400
Message-ID: <174775151766.432196.8064523744534615676.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
References: <20250512063319.3539411-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 12 May 2025 14:33:11 +0800, Zhang Yi wrote:
> Changes since v1:
>  - Rebase codes on 6.15-rc6.
>  - Drop the modifications in block_read_full_folio() which has supported
>    by commit b72e591f74de ("fs/buffer: remove batching from async
>    read").
>  - Fine-tuning patch 6 without modifying the logic.
> 
> [...]

Applied, thanks!

[1/8] ext4: make ext4_mpage_readpages() support large folios
      commit: fdbd0df9d4a36c9091d4f7e8cdfbe76c94aab0ab
[2/8] ext4: make regular file's buffered write path support large folios
      commit: 16705e52e6291c6ab4249aaf1cdf0b8e88afe775
[3/8] ext4: make __ext4_block_zero_page_range() support large folio
      commit: 2e9466fc5d7c74a0aeeb388c3c2a4c02b7069d58
[4/8] ext4/jbd2: convert jbd2_journal_blocks_per_page() to support large folio
      commit: d6bf294773a472fe4694b92714af482f5c6aa4c6
[5/8] ext4: correct the journal credits calculations of allocating blocks
      commit: 0e32d86170121c2d43508e923cb171fb58953b42
[6/8] ext4: make the writeback path support large folios
      commit: cd9f76de6ae9a5a0ca6201b1f06cf116a6a3e3a2
[7/8] ext4: make online defragmentation support large folios
      commit: 01e807e18fd87937f515926b79152dfa4f13b735
[8/8] ext4: enable large folio for regular file
      commit: 7ac67301e82f02b77a5c8e7377a1f414ef108b84

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

