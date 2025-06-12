Return-Path: <linux-fsdevel+bounces-51475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4D9AD71E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4F0166AF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6997325B2E2;
	Thu, 12 Jun 2025 13:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Setzk7gq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C861824C060
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734759; cv=none; b=P58xy8+wX2wVQI3n2J9HsYD/9oaY4wIXY5kbfTLKhJZLnFeE6F+3N6XEhhqITYWGL7u3hVdn7VEa1b4325gzjN0nbgYZ586fHnDPdwQCl2OnjbKtEkqj0VfTrxfbOzket6AP6bgYNfbA323Cg+FnAf2MO6fcoF6BL5EhF9r07no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734759; c=relaxed/simple;
	bh=wPejOV2L6RBzrH/hwtr1Gsiw8oGCzm+T9bEIthVvclc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o5RZFyw3DTEHcN0LIjgPA9I2WVHqmyywovnKw+jEf0Hx5Su5EgFiJMoEBivCW48CKc6pPPCQS9P4Jrt/P4C3uIpLD54hmso2QJY3lo4xz2pfMMN6GdCYTPF0HOfVmapL2QbeD2Y5hG0vmmW9r/avTpSbAEDy3zkR7J0u6+QXRus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Setzk7gq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAFBC4CEEA;
	Thu, 12 Jun 2025 13:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734759;
	bh=wPejOV2L6RBzrH/hwtr1Gsiw8oGCzm+T9bEIthVvclc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Setzk7gqbhjS0oJFX8tWh6i8cbJWgSi/WHQ4nPBnDk5dy8emaqFu/xZGEPqh0CC4k
	 U8FoIqnF/ZF0RqBJO/ncwRlad0aJTgR9GwhGol0YaaVNiCuk0GAb/E/TZiM6j1jQym
	 US9VnF8uDbt/iaSmaI7A7XR1x76/YuGgRFGRilqVDBcnbAEwOYxoK70q+rJevpbwoK
	 WTqElKEBmnqrLK+fLXx+7v3/fY8c+PVxZpxeQs8qSI7r5O87WM6DmIvG7fONk4dqeb
	 PYoLzFcKorLw71GmsQUIdVnncDzHGnOklJZhtEZUSqZTm5ccA0fmf2WmA1HSiIWlp2
	 UuDC48m6n7cHw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:28 +0200
Subject: [PATCH 14/24] coredump: move pipe specific file check into
 coredump_pipe()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-14-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1204; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wPejOV2L6RBzrH/hwtr1Gsiw8oGCzm+T9bEIthVvclc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXXnO2ZV3becLTEt3fvc5ckWWf8ss6++kU+Q5nv4Z
 3nDG9MlHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZq8nwh09qS6ga/wa53fIz
 Dh6OP76BgXfS17ZXTguY+HYtO7/rVBkjQ2O8Ar/id6WIZLP4Wd11lXzrsw80/HYtLYn4Hvj94/Q
 0PgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

There's no point in having this eyesore in the middle of vfs_coredump().

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 081b5e9d16e2..cddc1f7bfcab 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1024,6 +1024,15 @@ static bool coredump_pipe(struct core_name *cn, struct coredump_params *cprm,
 		return false;
 	}
 
+	/*
+	 * umh disabled with CONFIG_STATIC_USERMODEHELPER_PATH="" would
+	 * have this set to NULL.
+	 */
+	if (!cprm->file) {
+		coredump_report_failure("Core dump to |%s disabled", cn->corename);
+		return false;
+	}
+
 	return true;
 }
 
@@ -1117,14 +1126,6 @@ void vfs_coredump(const kernel_siginfo_t *siginfo)
 		goto close_fail;
 
 	if ((cn.mask & COREDUMP_KERNEL) && !dump_interrupted()) {
-		/*
-		 * umh disabled with CONFIG_STATIC_USERMODEHELPER_PATH="" would
-		 * have this set to NULL.
-		 */
-		if (!cprm.file) {
-			coredump_report_failure("Core dump to |%s disabled", cn.corename);
-			goto close_fail;
-		}
 		if (!dump_vma_snapshot(&cprm))
 			goto close_fail;
 

-- 
2.47.2


