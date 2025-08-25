Return-Path: <linux-fsdevel+bounces-58954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3A7B33595
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DFC53A67C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AA1275B19;
	Mon, 25 Aug 2025 04:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Z/2P8sbi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD6280CC9
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097047; cv=none; b=BsR6qZ2KsOjmyk3Wq+ybdiEaBfUiRdL508QHpz8Zg/9sttDkRLDxsNLxSlSVr+XR7LjgVFQhTXUIEaOWAj9nyqX9q37+On54K/Fy0YFcNPtv/yGSTnigKIfrcFP+gSUcYsrh4Uqvglbs0u/pTguW1Qy+aQdVBsIyyFoc0naz/xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097047; c=relaxed/simple;
	bh=M9EJGXoUMFYXb2xCmBrRgGkaM0BjgwDH8IDniAvU5iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MpAOIkKKgb/HvbEs7fiS/u2N7c9qHRl6fza4tqsQ2skxecxtB0kL5FEAWBW+iR/9pIukAll5azfIdp17DkE1ediP6cKT8udlXUH3T2bAxXdz9r+QABQJk9r682t7/w1PSjSiopz9S71cngEoIbrpOMqUPoKxKfqv/3v5d2x2CUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Z/2P8sbi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KguAl0n+bSfLoHDvrXpZK+ZFaPhDm6vUZtPCJoihBag=; b=Z/2P8sbiNjYWHX9opwmrOseSKh
	YcmlOo04p+RIScrxMtVTJirO09BjI5DipO+qtQbedn6fny890m0NoH7ZthhWcdF7Ot2CQl4LeKjkI
	fQsAPyzknEp5E44Tj8ZNu1ZTv88dzT4W0zzNX28gK0g2queLjoNVmr2gAbq4mlwY2DsFoGqrksyFs
	YIPyt6yZiS6qKFgPx0RMIc0glzXi/1GoyMXpRPiwYn37hUCQ1FlEjq5dcKVVEu7xS6oNWgSBNJFL0
	fzA4QUKFKp1j6GcuJm/6M3+LkocGXwmtORKpU6+9wbre6jruIM0k+xEKbXXyrYm1m1OelvJzQ61et
	MHKnrBww==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3p-00000006TFo-488U;
	Mon, 25 Aug 2025 04:44:01 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 49/52] do_mount(): use __free(path_put)
Date: Mon, 25 Aug 2025 05:43:52 +0100
Message-ID: <20250825044355.1541941-49-viro@zeniv.linux.org.uk>
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
 fs/namespace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index da30c7b757d3..d8554742b1c0 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4104,15 +4104,13 @@ int path_mount(const char *dev_name, const struct path *path,
 int do_mount(const char *dev_name, const char __user *dir_name,
 		const char *type_page, unsigned long flags, void *data_page)
 {
-	struct path path;
+	struct path path __free(path_put) = {};
 	int ret;
 
 	ret = user_path_at(AT_FDCWD, dir_name, LOOKUP_FOLLOW, &path);
 	if (ret)
 		return ret;
-	ret = path_mount(dev_name, &path, type_page, flags, data_page);
-	path_put(&path);
-	return ret;
+	return path_mount(dev_name, &path, type_page, flags, data_page);
 }
 
 static struct ucounts *inc_mnt_namespaces(struct user_namespace *ns)
-- 
2.47.2


