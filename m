Return-Path: <linux-fsdevel+bounces-31601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C2B998B84
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 17:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3ABC28F63B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3801CCB4E;
	Thu, 10 Oct 2024 15:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DQuSc0S/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68521CCB26;
	Thu, 10 Oct 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574030; cv=none; b=Bu/JKKhhG7qIsdNJSrSh3v+fs6pXi0NMauEaJ4NNxds5lTZxvp2+yPk/I21Lzq1X0iDgUTBVgRpvcb0F3EdH3XLlwN+Utwf3B2GPRSPjqhxhhZ6Cv2yZHCX5otNKOmJewNgWR0hnElCUPLHeuIEjuEW8aDk0RL09AYKOfK0AdpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574030; c=relaxed/simple;
	bh=8mYX1qnXDm7Tyw5nzXRttaxTYfM94c2OY6x8h1WhS4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOEzDwQHy6WjbzY1z3C03gUcc/pwwDbbE+coM/G2L9IoTQwh01ZcSzC7jqOZbkAPprzImu/tHMqPP3Yh0pHC3z3GqcOu5Bneioa5nGPNofhOupg5Gq4VA5NxcrFRwqIwENqbXTfnUW6r4gpbicZEASlKbhPUc/ucMkd9sJjeIAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DQuSc0S/; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XPYX54qCNz66M;
	Thu, 10 Oct 2024 17:27:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728574021;
	bh=6EsIR1F1yBU2hfVkY0ZIPc1OPufElDnPGIffuAFYdkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQuSc0S/Ny+YDvPYnjRuf8f+8NM9BqlzaFNeWIUkIjw5ZeSdD98cqeYyJ8Zn2NGsz
	 BwDPqVU8ThHfRRRWUZ5nr7oyBYflHdNeLTiU8NGXveUCHvcmYZUC51B6f/WwErS+cU
	 Ca8xPxbcxAtqWEPyogCK0JN988I2zgIKcSSgSKjk=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XPYX51gnRzS2C;
	Thu, 10 Oct 2024 17:27:01 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [RFC PATCH v1 5/7] ipe: Fix inode numbers in audit records
Date: Thu, 10 Oct 2024 17:26:45 +0200
Message-ID: <20241010152649.849254-5-mic@digikod.net>
In-Reply-To: <20241010152649.849254-1-mic@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Use the new inode_get_ino() helper to log the user space's view of
inode's numbers instead of the private kernel values.

Cc: Fan Wu <wufan@linux.microsoft.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/ipe/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/ipe/audit.c b/security/ipe/audit.c
index f05f0caa4850..72d3e02c2b5f 100644
--- a/security/ipe/audit.c
+++ b/security/ipe/audit.c
@@ -150,7 +150,7 @@ void ipe_audit_match(const struct ipe_eval_ctx *const ctx,
 		if (inode) {
 			audit_log_format(ab, " dev=");
 			audit_log_untrustedstring(ab, inode->i_sb->s_id);
-			audit_log_format(ab, " ino=%lu", inode->i_ino);
+			audit_log_format(ab, " ino=%llu", inode_get_ino(inode));
 		} else {
 			audit_log_format(ab, " dev=? ino=?");
 		}
-- 
2.46.1


