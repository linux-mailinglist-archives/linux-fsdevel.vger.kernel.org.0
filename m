Return-Path: <linux-fsdevel+bounces-23992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6012937737
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 13:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA61B21ABC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 11:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908E126F1A;
	Fri, 19 Jul 2024 11:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIXDPRF4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042301E871
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 11:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389349; cv=none; b=PQEf+kc5GArrDP/PzphCc6NJPIX2ozZBM58GWj3eBpj19CbdFUsSo42hAc8qGtBoV2yE/EGPcHj0W+wgT9bOi/qwk94Q4z5WKbD0fdAQZs1skRMiGVO6wwZY8s7moOcccR150r3voarJBnc+1dgHTjfwuu4x5yEtjq1aN0s5BZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389349; c=relaxed/simple;
	bh=xqaxZx8Uc26vypiRSSMPInvBcBTGnfSI3euLzrmAsiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UcLXe03rlWcty4x2gzMjNOCcPkLtpLnAXoaPzg8FFCffPPtXguHL/7LrERZjLdWI+7yRG1q3I76BYSj1RKuxtjGpbVlWriZrfWZTvaD111dLsLAEwrgmhfD+5RsU3CJyp615W5IFCx+fZpeLxHW8WOwcf9zzokmPo/7ea8RmCeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIXDPRF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA11C4AF0E;
	Fri, 19 Jul 2024 11:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721389348;
	bh=xqaxZx8Uc26vypiRSSMPInvBcBTGnfSI3euLzrmAsiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PIXDPRF4g/3K3sggt0VFREfOvjxV1tdr95QrC2HH5GLbA4co+61MLEJEixBEMYIVQ
	 2vKnTTeJA7LXBv58w9NC4HvIoTSgY76bXbIR1hmpH3gPMG+JXTB0AF4PNY55lG+T/v
	 4WCXV0A6QDIfcL+9tK3zqDaGZu1ffo/Ne9DpSCba4XOYzGewk4Hcd/c5mVAbWZWboQ
	 xvK1Iu0GqMeFYmHYLXZl63JUM8DpaVzfJthQBbIqLgIacSus1QlbictdBn47o0gLKO
	 HotdzD146USUKczxL58E9/0QN63kByVBeAvDev17aWNXJhSfzJVZ5YDGElu6joGaHw
	 R0jYM7E/pm+MQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 19 Jul 2024 13:41:48 +0200
Subject: [PATCH RFC 1/5] fs: use all available ids
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-work-mount-namespace-v1-1-834113cab0d2@kernel.org>
References: <20240719-work-mount-namespace-v1-0-834113cab0d2@kernel.org>
In-Reply-To: <20240719-work-mount-namespace-v1-0-834113cab0d2@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Karel Zak <kzak@redhat.com>, Stephane Graber <stgraber@stgraber.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=811; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xqaxZx8Uc26vypiRSSMPInvBcBTGnfSI3euLzrmAsiU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTNClRQefH4g/Wzb1u8t1seUdQo+fsue8V2Pc8/JdJph
 hcKnzAFdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk9gNGhhvse5dUXt0s2hly
 3uH32+LzB+buC7Dh9ppZ15R/NyfxejvD/+Dti1v7uNh6nnE5qqcsEJjL9rn1rFZ/lkV0zIYJohI
 LGQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The counter is unconditionally incremented for each mount allocation.
If we set it to 1ULL << 32 we're losing 4294967296 as the first valid
non-32 bit mount id.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 221db9de4729..328087a4df8a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -70,7 +70,7 @@ static DEFINE_IDA(mnt_id_ida);
 static DEFINE_IDA(mnt_group_ida);
 
 /* Don't allow confusion with old 32bit mount ID */
-#define MNT_UNIQUE_ID_OFFSET (1ULL << 32)
+#define MNT_UNIQUE_ID_OFFSET (1ULL << 31)
 static atomic64_t mnt_id_ctr = ATOMIC64_INIT(MNT_UNIQUE_ID_OFFSET);
 
 static struct hlist_head *mount_hashtable __ro_after_init;

-- 
2.43.0


