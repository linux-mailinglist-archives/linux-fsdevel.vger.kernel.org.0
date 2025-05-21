Return-Path: <linux-fsdevel+bounces-49578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAA7ABF43C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 14:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B527C7B07C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 May 2025 12:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1972641E7;
	Wed, 21 May 2025 12:21:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1E2638BA
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 May 2025 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830088; cv=none; b=OFW8up6sGDukkQbghUHNLVDLnnC/cZ8Xs/M8WUMFQlA0uGn8QckqjWpvugG+RIS4v0TjW/0BrgFApreXQMlwXXrYYugvmeB4Wm0AY1CnBTonnxXOmItueOymdLDsSR4wP5vHmTEY53xYAZEwYH+gXjyFxAFoO8mMmoUd/l8zfH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830088; c=relaxed/simple;
	bh=IX1qKeAq25XLpmkzZID0b8HZlu8q8ZSw2B8uUzvwM3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XH6IWBKD+Gz2w3QfURyJ30uzPFsGiAR/2q5GOb4YlfcBsNBMA1mYGeO0uWpv6gsptnWG/CbMaLZcvFfWGKpVrCMAHstjOynIDKWNSyPP/tFNoYUv2f5lpcl4WMLfV+sQU+K/cCXHWaGApaMiWAZasuUi2J4Ken+m4Ubfn4Fpf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54LCL2hC023859
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 08:21:02 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 12E0C2E00DD; Wed, 21 May 2025 08:21:02 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        John Garry <john.g.garry@oracle.com>, djwong@kernel.org,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] ext4: Minor fixes and improvements for atomic write series
Date: Wed, 21 May 2025 08:20:59 -0400
Message-ID: <174782999401.679857.10177907153334574333.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <cover.1747677758.git.ritesh.list@gmail.com>
References: <cover.1747677758.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 19 May 2025 23:49:25 +0530, Ritesh Harjani (IBM) wrote:
> Some minor fixes and improvements on top of ext4's dev branch [1] for atomic
> write patch series.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/log/?h=dev
> 
> Patch-1: Is the fix needed after rebase on top of extent status cleanup.
> Patch-2: warning fix for cocci
> Patch-{3..5}: Minor improvements / simplifications.
> 
> [...]

Applied, thanks!

[1/5] ext4: Unwritten to written conversion requires EXT4_EX_NOCACHE
      commit: 3be4bb7e71477c0b9708bd6f1975db0ffc72cce4
[2/5] ext4: Simplify last in leaf check in ext4_map_query_blocks
      commit: 797ac3ca24ca1af396e84d16c79c523cfefe1737
[3/5] ext4: Rename and document EXT4_EX_FILTER to EXT4_EX_QUERY_FILTER
      commit: 9597376bdb6e5830448ba40aacd3ebd705fe35cc
[4/5] ext4: Simplify flags in ext4_map_query_blocks()
      commit: 618320daa9673ce2b6adae5ad6fbf16e878ff6c9
[5/5] ext4: Add a WARN_ON_ONCE for querying LAST_IN_LEAF instead
      commit: 7acd1b315cdcc03b11a3aa1f9c9c85d99ddb4f0e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

