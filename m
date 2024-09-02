Return-Path: <linux-fsdevel+bounces-28294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E44E969024
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 00:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418F51C2316C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 22:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211AF18BB86;
	Mon,  2 Sep 2024 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LrVGqvSz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AE318951D;
	Mon,  2 Sep 2024 22:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317749; cv=none; b=EI4w7dKY302mJiXIX7ehWy1GCmqg+bm2KQrDIIfA4ekS3fiO1b5X1PifONWX3kMWsd5P5llnhjez+HTsNhqhCQ5BGT1N6PKby3LJZbEmv3sYay8+simLlODYH1ZcFiGImUDikDR5xW7GmEKrjnG1jp5h1k8CgSDTxdYZ3ZjD54c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317749; c=relaxed/simple;
	bh=bfy9X/41JJTcQ2en24m+K17nT+y0aTFyRFZOh4kbNyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIrxSPIz8/gC1r21GcEUhyjzc1volsLl4Cxc2ZmPIQj1Srwptd7GULChgFBn48q6JZ5BoJ3de0yUqGCnhhhcUphv8zdIvG927ygFm0KISYP/gZmUyX1pP2WzG7xYZfjhVeAlXTrCLgc2bgCToxM7YwJoMZZvH0tl8WBDL4iOB4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LrVGqvSz; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7VI+yky5LaYBS1bSHdHAgpXKw65lgRI7FAY05caFqb4=; b=LrVGqvSzFlJiFx1ovS/TrKYVRm
	YVRST5UuQ3EQLIqL0oUdhvMxlWx5A94Vvh4Ypwkv3/u/cUfEFG7kGtAcNXrlfb6xgum369T5jm0C7
	md4caOkyV5QHRo63Yj/sXiHFNwRBLacDkfqO5nV+uEOiO87mzXrTHRJUbqfPPDCReOfs8J8vVDbck
	1J2ODqREXz+7pX94ivq4f/dPT+zJviI7LHrs7lDydHLbSRWJrjzpW2P47+CY/7j8nIraefqXYwKRz
	EpmcTPJcv8Eh0j4yabBxXcs0aehoFrjfO//6T4VYJIDMjbkQIzgLYerNQaqJrS9x5uUqdhv6REN9R
	IV1vXBhg==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1slFxM-008VrL-H0; Tue, 03 Sep 2024 00:55:32 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: [PATCH v2 3/8] ext4: Use utf8_check_strict_name helper
Date: Mon,  2 Sep 2024 19:55:05 -0300
Message-ID: <20240902225511.757831-4-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902225511.757831-1-andrealmeid@igalia.com>
References: <20240902225511.757831-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Use the helper function to check the requeriments for casefold
directories using strict enconding.

Suggested-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 fs/ext4/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 6a95713f9193..067face4dc41 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2394,8 +2394,7 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 		return -ENOKEY;
 
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (sb_has_strict_encoding(sb) && IS_CASEFOLDED(dir) &&
-	    utf8_validate(sb->s_encoding, &dentry->d_name))
+	if (!utf8_check_strict_name(dir, &dentry->d_name))
 		return -EINVAL;
 #endif
 
-- 
2.46.0


