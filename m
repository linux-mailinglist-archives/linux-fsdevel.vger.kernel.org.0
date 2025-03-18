Return-Path: <linux-fsdevel+bounces-44336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4390A678DC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 17:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEA03BF963
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80F3211710;
	Tue, 18 Mar 2025 16:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="bkG1iSRV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [84.16.66.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA83211283
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314506; cv=none; b=rhxf/u3Yy3XPdVE0KaNF+077ENAQJ5mwsX31A5hz+BXqHfjHVudInA5l7wfp39JLac0DXAlh4eHhLqg8HYqHqeAJuHUD6RzTtHEzzvvfSMI6l0UT8HY+ueTez1vMSTE2GrU0SbBQKTZ8l3Ks91nfKROhDIGSCMerboxh/GlqnKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314506; c=relaxed/simple;
	bh=+jsbZE09sFbnqsbp9iUkpYGeJQyb0fNC/hr1RqK0xOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HIz1AlknB2c5zFlJgETUr7T7RzJvK1vdIbJhrM2K/2PeN4pukKaR2z4M3DcPDiIRjsn3xfeCzQNAOvzIKtwcPeKne2WTEHX25OJgUYnyZU4JatAIYSG3A/xPRZ1ugc6iFHQ0sX8l88FbbLwtO99a6cx2pAD3nbVLq/sz304cFuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=bkG1iSRV; arc=none smtp.client-ip=84.16.66.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZHH4001wyzMg7;
	Tue, 18 Mar 2025 17:14:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1742314495;
	bh=eVR89nHy+SMCXHmKZ7A2eqpWJRHyf58wP1OCT4R3BfI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bkG1iSRVl/52MgwNDm13ctUztFsadboorHOU9JffPO3c40dbfLOhvS+X9b9c8ym3h
	 d6AAlZl33DcTcg5F8iPbGRiJfrCCyaFKJwLeNkhXxoapjI8b/0plf/Yah57V3tgm6y
	 H5ANSTcMtJvWZkv6fl5KeQKV0KVtiSF36s0teAaY=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZHH3z2KYPzXHC;
	Tue, 18 Mar 2025 17:14:55 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Kees Cook <kees@kernel.org>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 4/8] landlock: Prepare to add second errata
Date: Tue, 18 Mar 2025 17:14:39 +0100
Message-ID: <20250318161443.279194-5-mic@digikod.net>
In-Reply-To: <20250318161443.279194-1-mic@digikod.net>
References: <20250318161443.279194-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Potentially include errata for Landlock ABI v5 (Linux 6.10) and v6
(Linux 6.12).  That will be useful for the following signal scoping
erratum.

As explained in errata.h, this commit should be backportable without
conflict down to ABI v5.  It must then not include the errata/abi-6.h
file.

Fixes: 54a6e6bbf3be ("landlock: Add signal scoping")
Cc: Günther Noack <gnoack@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20250318161443.279194-5-mic@digikod.net
---

Changes since v1:
- New patch.
---
 security/landlock/errata.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/security/landlock/errata.h b/security/landlock/errata.h
index f26b28b9873d..8e626accac10 100644
--- a/security/landlock/errata.h
+++ b/security/landlock/errata.h
@@ -63,6 +63,18 @@ static const struct landlock_erratum landlock_errata_init[] __initconst = {
 #endif
 #undef LANDLOCK_ERRATA_ABI
 
+#define LANDLOCK_ERRATA_ABI 5
+#if __has_include("errata/abi-5.h")
+#include "errata/abi-5.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
+#define LANDLOCK_ERRATA_ABI 6
+#if __has_include("errata/abi-6.h")
+#include "errata/abi-6.h"
+#endif
+#undef LANDLOCK_ERRATA_ABI
+
 /*
  * For each new erratum, we need to include all the ABI files up to the impacted
  * ABI to make all potential future intermediate errata easy to backport.
-- 
2.48.1


