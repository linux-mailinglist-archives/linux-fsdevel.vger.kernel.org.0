Return-Path: <linux-fsdevel+bounces-49520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8B5ABDD71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 16:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E4981B6361A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF8124BD03;
	Tue, 20 May 2025 14:40:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F6024E019
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 May 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747752044; cv=none; b=rbyfoX7cd+x676Gil81y+PHqYYun3Hhr03o1nmkp9/hWcsQsTWKXGdsHlY9c8KhwsleiMAH5M0GOkS6XRN8GBHg4MEQsCjVa+15WQHnFpZR0Z7G9GVjqeAjntoiRsUbVuj7VPLPStxh3tGkx9FkLQsd1/CNcmLCRnoxP6KJosbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747752044; c=relaxed/simple;
	bh=LsM88u3pVbxA/BOMk9ls5exyQPdnwLE0ED0kTY2Rohk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rV2s9OvlvCZcX+dDB5kaueB0DwqN3eJtiqnEnCLCH5jE65BGOGDG8wt9LLchNhJQ/wJF/Z9UCIRNxx085GLj9TzPQNuEUzlWaYTMW5KN7P114UEVY5RGIorkXKu2Mo1Dch4yKm0BhdKPGDVGaZMPdXFhYDKZTnTirMOf3DiwjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54KEeQWk013150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 10:40:26 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C62FE2E00E6; Tue, 20 May 2025 10:40:24 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        John Garry <john.g.garry@oracle.com>, djwong@kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 0/7] ext4: Add multi-fsblock atomic write support with bigalloc
Date: Tue, 20 May 2025 10:40:17 -0400
Message-ID: <174775151766.432196.9150024510509123836.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1747337952.git.ritesh.list@gmail.com>
References: <cover.1747337952.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 16 May 2025 01:20:48 +0530, Ritesh Harjani (IBM) wrote:
> This adds multi-fsblock atomic write support to ext4 using bigalloc. The major
> chunk of the design changes are kept in Patch-4 & 5.
> 
> v4 -> v5:
> =========
> 1. Addressed review comments and added Acked-by from Darrick.
> 2. Changed a minor WARN_ON(1) at one place to WARN_ON_ONCE(1) in patch-5 in
>    ext4_iomap_begin(). Ideally we may never hit it.
> 3. Added force commit related info in the Documentation section where
>    mixed mapping details are mentioned.
> [v4]: https://lore.kernel.org/linux-ext4/cover.1747289779.git.ritesh.list@gmail.com/
> 
> [...]

Applied, thanks!

[1/7] ext4: Document an edge case for overwrites
      commit: 9fa6121684dad974c8c2b2aceb0df2b27f0627fe
[2/7] ext4: Check if inode uses extents in ext4_inode_can_atomic_write()
      commit: 1c972b1d13dde34c9897d991283e2c54209b44e9
[3/7] ext4: Make ext4_meta_trans_blocks() non-static for later use
      commit: 255e7bc2127cbd3a718a55d2da5b2d3f015adcd7
[4/7] ext4: Add support for EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS
      commit: 5bb12b1837c0bf7ddc84e27812f1693a126fe27a
[5/7] ext4: Add multi-fsblock atomic write support with bigalloc
      commit: b86629c2b2998338b4a715058b402e47d0b36206
[6/7] ext4: Enable support for ext4 multi-fsblock atomic write using bigalloc
      commit: 642e0dc73c5def8270ff7c55d750ff36a6ea5d10
[7/7] ext4: Add atomic block write documentation
      commit: 0bf1f51e34c4e260095fc7306c564c7fe01503e3

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

