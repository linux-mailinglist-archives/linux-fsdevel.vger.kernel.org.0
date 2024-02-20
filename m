Return-Path: <linux-fsdevel+bounces-12084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AE785B235
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 06:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DFCA1C22340
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 05:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E584056B88;
	Tue, 20 Feb 2024 05:19:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 0F060482D0;
	Tue, 20 Feb 2024 05:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708406347; cv=none; b=OmgTYeYRsM1e6Jj7khyqF3hR/mN95VwppG6RmY2FmIqDgcoXMLBZljEbpgkiGU9hurwrv6ipb4dD6BhdvXl3RtylKelmghrBo7v5CdEtvOTjpd2p3J5EFusGvUq/Q9OKWkpTZ6Cu1GzhVTn5zqpooAwL2hteph5t7O8tLEA3aU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708406347; c=relaxed/simple;
	bh=WW6nBO6M2oCGgiocdFG4e1PF8PO+zS+gCZmKFpHIpp8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SyW6wyixAF3KZRDpUYrJPyus1bECDYjWhxnrHDBuFBT7h25zWYdUf4ie0TJGiNhH8Wyw9g2utMoiNxqKlcPkvpS2uz+8uHPtFDHdatKhCN65d6Hzj9ApHyjpAJ1ISMRLVk6gkUVQsVd6WF0DHlRHU3Cdy0w9tw/5fAwGah6p1Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id BD124602610CC;
	Tue, 20 Feb 2024 13:18:37 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	ebiederm@xmission.com,
	keescook@chromium.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?exec:=20Remove=20unnecessary=20=E2=80=98NULL?= =?UTF-8?q?=E2=80=99=20values=20from=20vma?=
Date: Tue, 20 Feb 2024 13:18:30 +0800
Message-Id: <20240220051830.61099-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

vma is assigned first, so it does not need to initialize the
assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index af4fbb61cd53e..7be0527f5ff25 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -254,7 +254,7 @@ static void flush_arg_page(struct linux_binprm *bprm, unsigned long pos,
 static int __bprm_mm_init(struct linux_binprm *bprm)
 {
 	int err;
-	struct vm_area_struct *vma = NULL;
+	struct vm_area_struct *vma;
 	struct mm_struct *mm = bprm->mm;
 
 	bprm->vma = vma = vm_area_alloc(mm);
-- 
2.18.2


