Return-Path: <linux-fsdevel+bounces-21235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A329007F2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88B61C231D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047B91991D5;
	Fri,  7 Jun 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6ObOs3v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682831990D9
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jun 2024 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717772155; cv=none; b=KabeQhyayzpIGuHwbasZDf1nVqDifJGvHd2Gtdt4fFvZmERUMgk99acjo7Gmxo97A1xkTvzhOa1Ca6JmlWpgP6V2kC1mAN07LTrS2fULfhXweUdJ8vG0LaBRmko8IcEff484IXukWHHEgleDmYE4NZWxwvwM/vSYJBcBimOQpkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717772155; c=relaxed/simple;
	bh=lXEWnQoKFX8hD3f8kGU3u1jNUSzOr1a9E68qjTBr3Yg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLc1xaa5rJHuaxijqx3YYLD4JBSkleDPyX9JRxHReWMU1X4mb/YuUZjilJwnwsx/BpFuuZCsFRwCi1fbmv58uceZyQHLNusggUU1S5gk4yVPgmU2r1c90U0+bTXqv/omu+MvvZfuhVH+5Uu8aLeHnURDpRwZ2kkxSHQrK9yUiEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6ObOs3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4553FC2BBFC;
	Fri,  7 Jun 2024 14:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717772155;
	bh=lXEWnQoKFX8hD3f8kGU3u1jNUSzOr1a9E68qjTBr3Yg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W6ObOs3vQyT5bHQlaSYmsojbf+1QUzvOkJB0n03ijh9oMpDBsnOYJ4AwHdOifq61n
	 qWK1T/icgzxBk8M44lbxzV8lTpiY9D4XzTv1ncVwvFNgySLru87nGqOnClycR0BdZ0
	 Uht7nm3TmyYRykLhcJ8Q/ZmwYTAbny3Xn+jtxsy9XFPl5l3XxZDtmzs2/cuLAaKl2F
	 Vr9tYORlrrU3/v4VhEDjFK5ndf0NizpU1F9GsE7AiRXt1oShZ3PBdV2LvEUiBB76Ax
	 hHtZYmHKnDjXqdMWDwVt1uy9fWpOTEO32lNV8a49XSCWoCr3SxT1IeESD65tmfs7ih
	 2m5w99jO9efPg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 07 Jun 2024 16:55:35 +0200
Subject: [PATCH 2/4] path: add cleanup helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-vfs-listmount-reverse-v1-2-7877a2bfa5e5@kernel.org>
References: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>
In-Reply-To: <20240607-vfs-listmount-reverse-v1-0-7877a2bfa5e5@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14-dev-2ee9f
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lXEWnQoKFX8hD3f8kGU3u1jNUSzOr1a9E68qjTBr3Yg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQly5c5165p2KT/VvuchmzIBK4Va1M6HJdMc7Z3Mo3j6
 DsjZvKno5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLnJzL8ZFRLUbN2MJrvvWnl
 2TO3dG/2rXPki9ETZ9StzdQ49u6uA8P/yOBtam8ZrzAunnLqZ+Tm5cfSuRaa9sQ9E9t/a/Mq91N
 7OAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple cleanup helper so we can cleanup struct path easily.
No need for any extra machinery. Avoid DEFINE_FREE() as it causes a
local copy of struct path to be used. Just rely on path_put() directly
called from a cleanup helper.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/path.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/path.h b/include/linux/path.h
index 475225a03d0d..ca073e70decd 100644
--- a/include/linux/path.h
+++ b/include/linux/path.h
@@ -24,4 +24,13 @@ static inline void path_put_init(struct path *path)
 	*path = (struct path) { };
 }
 
+/*
+ * Cleanup macro for use with __free(path_put). Avoids dereference and
+ * copying @path unlike DEFINE_FREE(). path_put() will handle the empty
+ * path correctly just ensure @path is initialized:
+ *
+ * struct path path __free(path_put) = {};
+ */
+#define __free_path_put path_put
+
 #endif  /* _LINUX_PATH_H */

-- 
2.43.0


