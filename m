Return-Path: <linux-fsdevel+bounces-28557-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1465796BFC6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD8471F26301
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6A01DA614;
	Wed,  4 Sep 2024 14:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rUu6c/nB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F4F1DA620;
	Wed,  4 Sep 2024 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725459240; cv=none; b=onyvugHeYzxVi4CtxvzZ48KP7KU1XDeedazSREKa52r+7kIEqr7cBpciAGOa/uRIkuIOqKzkFTjTMJD/bm2w32wtRedRdBxp+tvSK4FwTB5tZoMv/H++iys6n5kGlzeJBso+jLnYrFzbkxu/UTjcZZM4wEl0Q36Vg+Fuba4llvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725459240; c=relaxed/simple;
	bh=PemaLvMHjSMzuV9FfMkS+wc9zPML5WeOSLg9W3wOqVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FVwEaT2TkQsRoTc37fSyNjakzoxFNk+CemEYHTK0VB7wg0cpWPdQ03tFOjQ3LCc+gkXWg4YM76tuO1cB1u4sSz7gkDofWcnmLOWTBRF4I5f9wfAINZb8bO/s468CXaQ7U8rgpc2EKU/tn3OX84KYxdzCftJ3SIT7KNOyCneisjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rUu6c/nB; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1725459231;
	bh=PemaLvMHjSMzuV9FfMkS+wc9zPML5WeOSLg9W3wOqVo=;
	h=From:Date:Subject:To:Cc:From;
	b=rUu6c/nByCvsjumlGzmFwPSxMDEVCe00xshIYdQy5xQohPNKmn+0XpbHxdm0cY4wl
	 2PCVvbHacBYqEM2F2t0RWKzseSqqwUcbiaJlCPgpKSWGa3bM7hiThcK5epVOkL0cx3
	 mQWSigi+q498Ccgj+EcykZ0tU/DpZBD1zIVTRDgiaCnFEedlZrGcugYZ+Bjm8j0N/t
	 PfdCcG5/gr5r+C7jdghNeFrGke2F2WNuKhvxJF9jLFsp+dvb+VhxWsgWPGYBaDM/Ps
	 Z1xbqqHoxbKN84Q5Wkz8GwIr6pfXQT/j+0YiuVS9VIIclP5h2nnWXWzBwjnGGfIMoE
	 w09I432fb7P7Q==
Received: from smtpout01.internal.efficios.com (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WzPcG6pjsz1K6X;
	Wed,  4 Sep 2024 10:13:50 -0400 (EDT)
Received: from laptop-kstewart.internal.efficios.com (laptop-kstewart.internal.efficios.com [172.16.0.60])
	by smtpout01.internal.efficios.com (Postfix) with ESMTP id B319D9A2;
	Wed,  4 Sep 2024 10:13:50 -0400 (EDT)
From: Kienan Stewart <kstewart@efficios.com>
Date: Wed, 04 Sep 2024 10:13:29 -0400
Subject: [PATCH] fs/pipe: Correct imprecise wording in comment
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-pipe-correct_imprecise_wording-v1-1-2b07843472c2@efficios.com>
X-B4-Tracking: v=1; b=H4sIAAhr2GYC/x2NywoCMRAEf2WZs4ExCj5+RWTRpF37YBImiwrL/
 ruDp6Io6F6kw4gu52ERw5udtbhsN4Ok561MCMzuEjXu9RhPobEhpGqGNI98NSc7xk+1zDKFHBW
 7gyLfk4qPeH/w+z+4XNf1B6y6BMZwAAAA
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-janitors@vger.kernel.org, Kienan Stewart <kstewart@efficios.com>
X-Mailer: b4 0.14.1

The comment inaccurately describes what pipefs is - that is, a file
system.

Signed-off-by: Kienan Stewart <kstewart@efficios.com>
---
Hi,

while reading through `pipe.c`, I noticed that the comment explaining
why pipefs should not be mounted in user space inaccurately describes
what pipefs is - that is, a file system.

While I understand the original language used in context, I believe
this change increases the legibility of the comment.

thanks,
kienan
---
 fs/pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 7dff2aa50a6d..9a6dfe39f012 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1427,7 +1427,7 @@ static const struct super_operations pipefs_ops = {
 
 /*
  * pipefs should _never_ be mounted by userland - too much of security hassle,
- * no real gain from having the whole whorehouse mounted. So we don't need
+ * no real gain from having the whole file system mounted. So we don't need
  * any operations on the root directory. However, we need a non-trivial
  * d_name - pipe: will go nicely and kill the special-casing in procfs.
  */

---
base-commit: d5d547aa7b51467b15d9caa86b116f8c2507c72a
change-id: 20240829-pipe-correct_imprecise_wording-d20e370edbc0

Best regards,
-- 
Kienan Stewart <kstewart@efficios.com>


