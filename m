Return-Path: <linux-fsdevel+bounces-24900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A624F946550
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 23:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 503091F2328F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 21:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375C213DB88;
	Fri,  2 Aug 2024 21:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZmrOL88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C9313D510;
	Fri,  2 Aug 2024 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722635125; cv=none; b=KLZNT5LdyUYur+tyetXR/ddggXZzWfXjqFp4R6RkqEJi2oEuFSteZg2JYvOl6whgrHYo5l1mzNlDgXiilav3TeHxirsjE/iVc1CBjsO15bzTPLgGdEmcYkUaLkTes5TAK7rg7SB2ISJnnuGEkAwXbvDUflFi+W30R2pUks+nWi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722635125; c=relaxed/simple;
	bh=eFIVIaqhqy20S7ZAovlsajPhxGNdqzxpPG9//wXU0WA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dE34yaF4HPrx3SRNLgY5D3HvXCL4KJB/DDFOVcc6yZeAHXvEoSzD6Abk69BuABirAjOJLenjS6N4uwoJ+WXFRmKRzabHckv9bmf0jJjfLN/+FAMq5gJMR01AP2XIk2N7+rB67585rMlz0OHNOj6Oi0DoZU+XppBg17CnoYLXyLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZmrOL88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92916C32782;
	Fri,  2 Aug 2024 21:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722635124;
	bh=eFIVIaqhqy20S7ZAovlsajPhxGNdqzxpPG9//wXU0WA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BZmrOL88Z9LfmDG/8mfdfCNLwM75SVTr/gR8Pd5txtPdGPq2jUmspqmydfU++pOgZ
	 o7fUdUL1+QKQNFoE3Z6G8HlJrnoNMhc09VaWcJxcNAjcAW4vgg4mgLzWpuN6hYjcr9
	 oWH0Dy7sdsP3DfZoLhjxqDcxRzkSqXhVDZE/aj8Mqp/4De1SbL9+O0yZ6YU/u0nANO
	 FryXeOqlbogtSE1yAu3jneUmBz5QvfwG4UgzaVRBBr/I3yxpxX0O9idiSa1sMMgxJg
	 UklSLXs9fydVUr+CDaZqzdyGx7RBxtRFKqMw1ZsufgJuM3SXX5k/5/ryOhjKu9+7v9
	 vPcTh5BhBZYcg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 02 Aug 2024 17:45:03 -0400
Subject: [PATCH RFC 2/4] fs: add a kerneldoc header over lookup_fast
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-openfast-v1-2-a1cff2a33063@kernel.org>
References: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
In-Reply-To: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eFIVIaqhqy20S7ZAovlsajPhxGNdqzxpPG9//wXU0WA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmrVNxYuWJj+TSUz08yvtyJg7ibZtNis2OxnxCT
 4hTbU2e3R6JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZq1TcQAKCRAADmhBGVaC
 FR9iD/9Vg2jCsCKRseyOmQ+CeQbzqdkJDfzKereToztyPsCGuI2ZjKFHpsK/ZYGsMqGIVnxgZ13
 a1shwfqNNGu51d/Vq8FX1x0Jd+aWLMheJbNw9sPf1YDV2igbd+8Wu6kWB+85tTv0VOAUd9RUvNr
 AIDVkV8mJppQ2d3skNgQzTAyxtT34eLFrmlwdNhQ/XXaEvAMlS6KYiJYxR8N1cUIVubpBmvZ8vd
 K7bbyDheVMgw9p1ynHipib+Sq9PybH1yx9niHqKkwY9jNBH6HiPVo8bkuL38HvvyWKRs3q9lPaR
 N8uY14BF9H31y1fiMDnX56jIOxxoKzndTyR0YdZnkr7CwdXThJAj1I1E+ocbxjFBJR80WIVcefJ
 kDEzHEl5HFnwKEmKsfiqaumyMRAAycotgSSfO8GEIJKgDvws/lZNmntJcwrPrqgv5+H9/tVlIl3
 6AlOIeXy3rZQKDmA1TAFitLfe4E4/WMCfCoBQBSdSrgbxA+4w/JUZBZluxjUVWdblzhOKdLCK39
 T3BAvmEzi8+NvMe2hSjMaytXvGeWxBp+uFg4QlD2uJSaFTGdm/lUA5jCc2qtSZaNUhkqwhGV45F
 Iwj/AQP/DTXbk8IYfaOcD3K69gG4ABucc4azNp7A39SLYodhU2VYCyCAfxpT1yBaY4qcweRotwb
 J7wpugLvsPcLaZw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The lookup_fast helper in fs/namei.c has some subtlety in how dentries
are returned. Document them.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/namei.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 1e05a0f3f04d..b9bdb8e6214a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1613,6 +1613,20 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 }
 EXPORT_SYMBOL(lookup_one_qstr_excl);
 
+/**
+ * lookup_fast - do fast lockless (but racy) lookup of a dentry
+ * @nd: current nameidata
+ *
+ * Do a fast, but racy lookup in the dcache for the given dentry, and
+ * revalidate it. Returns a valid dentry pointer or NULL if one wasn't
+ * found. On error, an ERR_PTR will be returned.
+ *
+ * If this function returns a valid dentry and the walk is no longer
+ * lazy, the dentry will carry a reference that must later be put. If
+ * RCU mode is still in force, then this is not the case and the dentry
+ * must be legitimized before use. If this returns NULL, then the walk
+ * will no longer be in RCU mode.
+ */
 static struct dentry *lookup_fast(struct nameidata *nd)
 {
 	struct dentry *dentry, *parent = nd->path.dentry;

-- 
2.45.2


