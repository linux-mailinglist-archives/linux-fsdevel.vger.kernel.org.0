Return-Path: <linux-fsdevel+bounces-49523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B7EABDD7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 16:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CBD188EE31
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCB32505BE;
	Tue, 20 May 2025 14:41:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6507B2505A9
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752060; cv=none; b=GerXUKznYNyL+TspyceAO1hbe7vHN6iXxW175Suycamweg6pVMcYjYs2nwochw0YeQLPFT+TdozDogGkWv0jm9rUugFAO3L2EWLegb9YKRoMqpQNm+Iz1IJNjhhBhQNEuVkGmLHX0BR4eS2ZPS0vSe/sjlR68RWlgZjQPOK0ovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752060; c=relaxed/simple;
	bh=aJenwxdDmXYJfWrC4hpGWB7PoCgfVUGznezpZ57Nbg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EuGQKZciziT53QJ4ZNYSLNYPa8Q/1At1WKjLMrRO/K2uwrMdZwpE4NlFSvH6YoWZB0viLHnx8n7RyfKhnmZjqCRQhGhr7DO+5n17Ik4HNLvNY1l/hF/Y2v72GDKBtHH4IRaedQBcpmhSSM+3AWpTdqm2C3ra4+4UyxzLI8yMB/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54KEeQ5i013155
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:40:26 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C8C812E00E7; Tue, 20 May 2025 10:40:24 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, libaokun1@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH 0/9] ext4: fix stale extent status entries and clairfy rules
Date: Tue, 20 May 2025 10:40:18 -0400
Message-ID: <174775151762.432196.4176698555758333920.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250423085257.122685-1-yi.zhang@huaweicloud.com>
References: <20250423085257.122685-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 23 Apr 2025 16:52:48 +0800, Zhang Yi wrote:
> This patch series addresses the potential problems discussed with Jan
> Kara regarding the modification rules for mapping extents[1]. Preparing
> for the buffered I/O conversion for regular files.
> 
> This change includes:
> 
> Patch 1-5 fixes problems related to stale extent status entries that
> may arise during the collapsing of ranges, the insertion of ranges, or
> file truncation when these operations compete with concurrent writeback,
> fiemap, or get extent cache.
> 
> [...]

Applied, thanks!

[1/9] ext4: ext4: unify EXT4_EX_NOCACHE|NOFAIL flags in ext4_ext_remove_space()
      commit: 53ce42accd2002cc490fc86000ac532530507a74
[2/9] ext4: generalize EXT4_GET_BLOCKS_IO_SUBMIT flag usage
      commit: 86b349ce0312a397a6961e457108556e44a3d211
[3/9] ext4: prevent stale extent cache entries caused by concurrent I/O writeback
      commit: 402e38e6b71f5739119ca3107f375e112d63c7c5
[4/9] ext4: prevent stale extent cache entries caused by concurrent fiemap
      commit: 151ff9325e5e17c97839a00b740726656b04647b
[5/9] ext4: prevent stale extent cache entries caused by concurrent get es_cache
      commit: f22a0ef2231a7d8374bb021eb86404d0e9de5a02
[6/9] ext4: factor out is_special_ino()
      commit: 0b8e0bd45007d5740391e658c2581bd614207387
[7/9] ext4: introduce ext4_check_map_extents_env() debug helper
      commit: 7871da20d484d5c7e536bfd52845b6be4488ff30
[8/9] ext4: check env when mapping and modifying extents
      commit: 1b4d2a0b794669e54914e3f429c08e49ea40b40c
[9/9] ext4: clairfy the rules for modifying extents
      commit: 24b7a2331fcdf6de103ea85e67eede43c0372f77

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

