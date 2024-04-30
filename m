Return-Path: <linux-fsdevel+bounces-18297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A28928B6927
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 436B11F2149A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0046C10A3F;
	Tue, 30 Apr 2024 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvMyL9O7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542311CBD;
	Tue, 30 Apr 2024 03:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448495; cv=none; b=hBdXrWB6rmfMPEIYBCmSxMht3YYhcpA23uumQWPndyLTGykFUsS/3KhNwHrTV9tc5U7BYtikasHmCZF3cX+MM/VNnl2T5a8d3fRpch9aySJl2QGd+I9DK/bBnC8eeEbA/Nn9eLsbffRWAhNBJWQ/GFRlwWmkldnHFVjavBRMMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448495; c=relaxed/simple;
	bh=jkDQ8eXsq+DHM5pSHVl9SYPETIT1FOlvO5lUtfN+v24=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYEkG9YZa8l5llzdoZMyH6PKWGr/d/9t547KD9GWtYLZtL/y7ed5vddxfcXyro9BdTie/9XHX+uAGfowDEDgxN1clIeb0r97fGpf/AZ78GTEczbX9rqJCytf1rMSGZgksrJYq3JybPOEOMYJ0FzzPLLivN9nYO5SNmNu5Kd0DYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvMyL9O7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256E7C116B1;
	Tue, 30 Apr 2024 03:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448495;
	bh=jkDQ8eXsq+DHM5pSHVl9SYPETIT1FOlvO5lUtfN+v24=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JvMyL9O7DtsHeJAuOtUlU/n6Ybj9+vv6utvj/TlMZkxtXsZHpWD6zLn6vge7cLfiP
	 Y4heCy5FNJVa8EI+qVyB12bNrfyYv+77PofauYg5UdaMePiSwrzbuvFL48MHjxNwb2
	 SPBiSpbTdnlvyel+wCp+Pvu1ZK3gq3vIH0BUiqQMMcc4WEdL5UoMW88KWOhmT/8Ipe
	 W6+puVd7ziXOUFLzu35w54ellSSFRu40frwUQHJo+/LwNJr0sATwH7bszNr+HhiX75
	 k/+9HpQdNy3T4Vw+7o/RO/I5GbnmHfWgIqWM1oJ65QIKgW+xci/rUK6s619g1k8pgy
	 LtZV3FKHX01Zg==
Date: Mon, 29 Apr 2024 20:41:34 -0700
Subject: [PATCH 3/6] xfs/122: adapt to fsverity
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, zlang@redhat.com, ebiggers@kernel.org,
 djwong@kernel.org
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org, guan@eryu.me,
 linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Message-ID: <171444688024.962488.13214660928692324111.stgit@frogsfrogsfrogs>
In-Reply-To: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
References: <171444687971.962488.18035230926224414854.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Add fields for fsverity ondisk structures.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/xfs/122.out |    2 ++
 1 file changed, 2 insertions(+)


diff --git a/tests/xfs/122.out b/tests/xfs/122.out
index 019fe7545f..22f36c0311 100644
--- a/tests/xfs/122.out
+++ b/tests/xfs/122.out
@@ -65,6 +65,7 @@ sizeof(struct xfs_agfl) = 36
 sizeof(struct xfs_attr3_leaf_hdr) = 80
 sizeof(struct xfs_attr3_leafblock) = 88
 sizeof(struct xfs_attr3_rmt_hdr) = 56
+sizeof(struct xfs_attr3_rmtverity_hdr) = 36
 sizeof(struct xfs_attr_sf_entry) = 3
 sizeof(struct xfs_attr_sf_hdr) = 4
 sizeof(struct xfs_attr_shortform) = 8
@@ -120,6 +121,7 @@ sizeof(struct xfs_log_dinode) = 176
 sizeof(struct xfs_log_legacy_timestamp) = 8
 sizeof(struct xfs_map_extent) = 32
 sizeof(struct xfs_map_freesp) = 32
+sizeof(struct xfs_merkle_key) = 8
 sizeof(struct xfs_parent_rec) = 12
 sizeof(struct xfs_phys_extent) = 16
 sizeof(struct xfs_refcount_key) = 4


