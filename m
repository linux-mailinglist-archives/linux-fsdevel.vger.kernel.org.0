Return-Path: <linux-fsdevel+bounces-58933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B23B33581
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6702D17ADCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0E7283FDE;
	Mon, 25 Aug 2025 04:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="c0QWtmOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC67627CCCD
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097043; cv=none; b=pVGtD99/BSamKqnRuKwMF9zp7Z4eSiN4Smv5S8S8MzQA+m5b7aIDi+fvDhDg+FGV03ygbSSHHNkg9pnjG5M5xiQS9sh4V+IMT4+L9Pmh5dBrhu1S7RllFOpNScaxgn8zAw+a98kJjES3IjjCOFxnNtx+hP6xqZoTy5MDBmoOZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097043; c=relaxed/simple;
	bh=AHSiYXaV6OSChclTqQjMkfUBLTUo7HdjX4jaR+/fOPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUAa4eWI6IapLyxRqeeYm6z9kmJU0ufNKrC9hp1BE/o4Yi+WAsQ7fgw6iYkpuqJLvD2dA9XaROGPU+vzuZmYLeDITPw3xBVtX0H59ARv6l5vBGZZYVMTB2tuvNcjb8Udc9uO3Qqb82xrt0nCUFR5EE6FqR/vLLVTIgNalTjd/vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=c0QWtmOP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=c9wrPRah5jsoYrcpuwVBR5zoayKhbaylymOHRCSrJhE=; b=c0QWtmOPEEPt8PjBYcAwxFkc8t
	bfFk3XW5O/44K05RRit2FIhQYM6mknRBhnOzytCl7DkVrrwURThjDGL/vF1vmwLR5Bq1ABH0J0N1x
	Ya1UdHnYdXu0r4ogU8uC6MfzOUt2gJmH/geXpo031ZyVl5H0JGgBfzViGrOVH/sEaIYQYOjIQs/ho
	JW63bf4t7J3YIbekYC2eTI0n+TG/N74at6GMAaZ6v+MqLoPEobSjphRDsP1gC9216+WQZqDxE58mK
	kZON3cG8n9EkXAY+RPE0j/CHbv4cj7IeN4SiYGS4Ccg+L+N5MrPMfAHtf9ua5aYhpLhnXVr6t142k
	r/Ep9LjA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3o-00000006TDa-15Ty;
	Mon, 25 Aug 2025 04:44:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 35/52] constify check_mnt()
Date: Mon, 25 Aug 2025 05:43:38 +0100
Message-ID: <20250825044355.1541941-35-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f95e12ab6c9a..458bef569816 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1010,7 +1010,7 @@ static void unpin_mountpoint(struct pinned_mountpoint *m)
 	}
 }
 
-static inline int check_mnt(struct mount *mnt)
+static inline int check_mnt(const struct mount *mnt)
 {
 	return mnt->mnt_ns == current->nsproxy->mnt_ns;
 }
-- 
2.47.2


