Return-Path: <linux-fsdevel+bounces-35677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2380E9D72B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD901284D64
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1476F205AA1;
	Sun, 24 Nov 2024 13:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhUge8+4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBA7204F89;
	Sun, 24 Nov 2024 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455860; cv=none; b=bXqKNWIo3kuc+LYMTETLkZ+rDIG8ryi0lIQmx3HBIGiGBEWj6RVqUFFz3Eu/k6TyPMXTFEZJ2Ywx0WYcgzHHB5wUQYFuG9B8Lc063Y6QnUnW5P5m9TmuliPqiI28iakrJ8zfSjBSynfKY0TvqnQaf4ULAltaWoxecuQmhh4EgbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455860; c=relaxed/simple;
	bh=/k0C1GOH7oc08vW3tBXmzVQAQebTLcc7/aYdKqgOGO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTyE9w0y3Or45YHXApsJN4UH5aa8vgr5wh9elIBLK+oRU7s1pk7hCFQhRI/+BENMLuS1ZnXwbMR/ErWFQ99wVGQ87wfFnsyTbMGHloE/nEwo9avHUmzZqC2ADRR7xlXmU0NX/CvLDtv9vFMV9Cuyhr8lM3grgMzCXSPb+SQt5lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhUge8+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCABC4CED7;
	Sun, 24 Nov 2024 13:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455860;
	bh=/k0C1GOH7oc08vW3tBXmzVQAQebTLcc7/aYdKqgOGO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhUge8+41kAqTrJyxNLF81vwRM3YwQqvFXRUOAFIp296egp1G0UCjKlX7no1yo70s
	 NHQF+XsjP6XZrOkURnksvufG3MY/AArKo7rmjK6ACd2arn97YICHYyL2WF8XmDL1+Y
	 aMLv56a7qOOnKonafGRsaCterbAaz/Rub5rUc2gyHtxuHgV8bLpe52A5OfkSRCaYAz
	 enf4VwemAdKS74WwDv2P/nINKraOLRR6az2CKH/NDFrcFbQKrrR102QjP4TkSgUz62
	 DYivV/3XAvRXlSnnLlR73kHdaJD1x9W7eAvkfeWE3WcXsbnTBBd9sgtmzalQYZj+8i
	 r1Ga9FZ8lBbbA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/26] cred: return old creds from revert_creds_light()
Date: Sun, 24 Nov 2024 14:43:48 +0100
Message-ID: <20241124-work-cred-v1-2-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=899; i=brauner@kernel.org; h=from:subject:message-id; bh=/k0C1GOH7oc08vW3tBXmzVQAQebTLcc7/aYdKqgOGO0=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7685Qd+fRyF5y+k74tKupb/8s1L9alN+hbP6SRycx4 PD/GxPOd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEhIfhv4OM2lEnSwH/D+yz UiZlzulM2Fy7iuf9pdNzZpzZe2ixvhAjw1S2khdHvlqu8t7KYfrJM6Qke6rQv6creLL6JtV4zOZ k5wUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

So we can easily convert revert_creds() callers over to drop the
reference count explicitly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/cred.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index e4a3155fe409d6b991fa6639005ebc233fc17dcc..382768a9707b5c3e6cbd3e8183769e1227a73107 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -185,9 +185,12 @@ static inline const struct cred *override_creds_light(const struct cred *overrid
 	return old;
 }
 
-static inline void revert_creds_light(const struct cred *revert_cred)
+static inline const struct cred *revert_creds_light(const struct cred *revert_cred)
 {
+	const struct cred *override_cred = current->cred;
+
 	rcu_assign_pointer(current->cred, revert_cred);
+	return override_cred;
 }
 
 /**

-- 
2.45.2


