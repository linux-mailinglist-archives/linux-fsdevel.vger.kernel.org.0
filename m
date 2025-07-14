Return-Path: <linux-fsdevel+bounces-54877-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9335FB046DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 19:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918801A6106D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Jul 2025 17:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1D5266577;
	Mon, 14 Jul 2025 17:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="omceRwRM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000DA258CEC
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Jul 2025 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752515269; cv=none; b=gmiF1SvANRiLH2jXcMjuv25ipiSkkJne2tLDMGHYH9vf4YhaBvY1NNNmslF1o0Vd08IiyuTkHEb2eJjqNMa3PSFbTL2Bgq6f5D7PDJK7kD2q7bcm9etQU37g79vsyiA/55a8k2RPnL46zxmBMQk4nB+sXvw7bLHhc9o5HhP/bhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752515269; c=relaxed/simple;
	bh=pRLmzq/67ThMDCRf1SUK8lPAAbVBbB4Cg1lY5AXK69k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KuU6ropOP+j+kCCmcwxgeriI1uyKHF1UG+4x4jJSg4uOZ6NQnZxnrVD5ZVide5SU0kjWbDa5WWiCxbnafqKPdTljN1U+cdxRt0usrKR8ZQ2annqjoSad/8OigYuBXMLTGCNMbytJarvAcaW63pwS1PrUDqq6h5yIqVY7LZNdRng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=omceRwRM; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-108-26-156-88.bstnma.fios.verizon.net [108.26.156.88])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56EHl26W021854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 13:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752515226; bh=WVeVS8ghlhSXlPKutqTq4jxAQQ7jm0W3yKizKXZBUhw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=omceRwRMuKbPrvU+8hmTSJ3MQme/7Pa9K7hCwaGuDcvpvEsbn4EaLDmT8CUaGYxKb
	 MYHuv2g/nLa9oG1NKvNP9I0UKm+8cqQlrRfdc2grmhlZ3jLBo1eWB42mnCzEhyxfnk
	 j+2AuKlurwEt5RKf6gZaWFoFpONy+7rIEzwEHyWuXd1O9RyTmr5i26bcy67ZUWL2cl
	 +pQzscr52NSfyuojywzCEsh2WrnuYW5DoUT3OWEeTNcEzuY8CICGvr6C7M4XXEIBW0
	 dUKcpXrlbc21fe0xMKcWZfDF1E368XCGtxBuyFiYwEO9S4HfWlRdoti1GLBKOqi7Vj
	 zqPx9sZ8s9IQQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id D00342E00D5; Mon, 14 Jul 2025 13:47:02 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ojaswin@linux.ibm.com, sashal@kernel.org, naresh.kamboju@linaro.org,
        jiangqi903@gmail.com, yi.zhang@huawei.com, libaokun1@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4 00/11] ext4: fix insufficient credits when writing back large folios
Date: Mon, 14 Jul 2025 13:46:41 -0400
Message-ID: <175251519237.80092.16212793631969121417.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
References: <20250707140814.542883-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 07 Jul 2025 22:08:03 +0800, Zhang Yi wrote:
> Changes since v3:
>  - Fix the end_pos assignment in patch 01.
>  - Rename mpage_submit_buffers() to mpage_submit_partial_folio(), and
>    fix a left shift out-of-bounds problem in patch 03.
>  - Fix the spelling errors in patch 04.
>  - Add a comment for NULL 'handle' test in
>    ext4_journal_ensure_extent_credits().
>  - Add patch 11 to limit the maximum order of the folio to 2048 fs
>    blocks, prevent the overestimation of reserve journal credits during
>    folios write-back.
> Changes since v2:
>  - Convert the processing of folios writeback in bytes instead of pages.
>  - Refactor ext4_page_mkwrite() and ensure journal credits in
>    ext4_block_write_begin() instead of in _ext4_get_block().
>  - Enhance tracepoints in ext4_do_writepages().
>  - Replace the outdated ext4_da_writepages_trans_blocks() and
>    ext4_writepage_trans_blocks() with the new helper used to reserve
>    credits for a single extent.
> Changes since v1:
>  - Make the write-back process supports writing a partial folio if it
>    exits the mapping loop prematurely due to insufficient sapce or
>    journal credits, it also fix the potential stale data and
>    inconsistency issues.
>  - Fix the same issue regarding the allocation of blocks in
>    ext4_write_begin() and ext4_page_mkwrite() when delalloc is not
>    enabled.
> 
> [...]

Applied, thanks!

[01/11] ext4: process folios writeback in bytes
        commit: 1bfe6354e0975fe89c3d25e81b6546d205556a4b
[02/11] ext4: move the calculation of wbc->nr_to_write to mpage_folio_done()
        commit: f922c8c2461b022a2efd9914484901fb358a5b2a
[03/11] ext4: fix stale data if it bail out of the extents mapping loop
        commit: ded2d726a3041fce8afd88005cbfe15cd4737702
[04/11] ext4: refactor the block allocation process of ext4_page_mkwrite()
        commit: 2bddafea3d0d85ee9ac3cf5ba9a4b2f2d2f50257
[05/11] ext4: restart handle if credits are insufficient during allocating blocks
        commit: e2c4c49dee64ca2f42ad2958cbe1805de96b6732
[06/11] ext4: enhance tracepoints during the folios writeback
        commit: 6b132759b0fe78e518abafb62190c294100db6d6
[07/11] ext4: correct the reserved credits for extent conversion
        commit: 95ad8ee45cdbc321c135a2db895d48b374ef0f87
[08/11] ext4: reserved credits for one extent during the folio writeback
        commit: bbbf150f3f85619569ac19dc6458cca7c492e715
[09/11] ext4: replace ext4_writepage_trans_blocks()
        commit: 57661f28756c59510e31543520b5b8f5e591f384
[10/11] ext4: fix insufficient credits calculation in ext4_meta_trans_blocks()
        commit: 5137d6c8906b55b3c7b5d1aa5a549753ec8520f5
[11/11] ext4: limit the maximum folio order
        commit: e14bef2a00b5e9b9a100210ec0676aac384904be

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

