Return-Path: <linux-fsdevel+bounces-23995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 756AC93773A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 13:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2997F1F2244C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 11:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215D112BF32;
	Fri, 19 Jul 2024 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpt01EdN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F7A85931
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Jul 2024 11:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721389355; cv=none; b=bxnXeGkLkg2ztAdM+5/ay0gU85TfrOUBCn8JfVp2bHiWNew9bnhiCOpoGlQkpnplouJfnSt6RoJCdVpbci1HxaHlH6+tDeToDDidnxexT35MXtdR3zgppu7hC2ZjvzJnCwTvS5NqDyKPdFh/v63MFFuA2pXlsCMskg3O1Y/IpHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721389355; c=relaxed/simple;
	bh=UdvVua2f64s/hO0aTGtXb1syPtlODuVi7B1i/6pCVYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7lBa4EXA7nhSUcmcdmsiUH3dTWSznCbM8AA31cNdw9lrZLKBL5DBcdKSFv7eaLYuFhufKsCCxRhmH3c0Y8d0lgKWg4A4PVgYY7vehm57apmeZRsp8oDdxpO96HZnoX1ksuJKzQWNqqNKdqzfsHJRuehbJ23XcP6IR5srmRQumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpt01EdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6129BC4AF09;
	Fri, 19 Jul 2024 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721389355;
	bh=UdvVua2f64s/hO0aTGtXb1syPtlODuVi7B1i/6pCVYc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cpt01EdN4luc4A+i8Mv2Rw+fZ78xyNEcoBf5N0hcFgVwqEVDuA2UFfAZXBeyBXOyV
	 v2L1LTtojpAN6t/PO7YidPtKlYhokXaDdAuQNvVgrP/JoyC3uUDgn3pnKz2qXlNliV
	 AAkHZdH/N9LXCmQ7D38nwLAg5dzf017Oq117WeWfU4h0a5Tq2381/9RS7gl2zI6Amx
	 wofBPYq9W3MT62jFh5WOpOQu3aNzP5yASEa2wDsjCc11zkQfmUjlTsFleQN3ZZZCd4
	 oSAPH47eKKc/M+1sJzoWPjkB3RQaVwZbxpMooMI4x/eySjfsH102S9yjWAq4Nmy+Lw
	 YWPmj6oo9eV7Q==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 19 Jul 2024 13:41:51 +0200
Subject: [PATCH RFC 4/5] file: add fput() cleanup helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-work-mount-namespace-v1-4-834113cab0d2@kernel.org>
References: <20240719-work-mount-namespace-v1-0-834113cab0d2@kernel.org>
In-Reply-To: <20240719-work-mount-namespace-v1-0-834113cab0d2@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Karel Zak <kzak@redhat.com>, Stephane Graber <stgraber@stgraber.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=826; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UdvVua2f64s/hO0aTGtXb1syPtlODuVi7B1i/6pCVYc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTNClRYV7l5815GMb3nF37JLMuINvD/ljbRYc2/WWKue
 hHata1aHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5HcHwm+Whazmb14XbsUpr
 N/R+97fRbWPqWvuSI1p1zRSrVD3HBkaGH6scfl+R9lLe7J4fdXj2xDVczIG3LEzEfb86JBdMWm3
 JCwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add a simple helper to put a file reference.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/file.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/file.h b/include/linux/file.h
index 237931f20739..d1e768b06069 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -11,6 +11,7 @@
 #include <linux/posix_types.h>
 #include <linux/errno.h>
 #include <linux/cleanup.h>
+#include <linux/err.h>
 
 struct file;
 
@@ -96,6 +97,7 @@ extern void put_unused_fd(unsigned int fd);
 
 DEFINE_CLASS(get_unused_fd, int, if (_T >= 0) put_unused_fd(_T),
 	     get_unused_fd_flags(flags), unsigned flags)
+DEFINE_FREE(fput, struct file *, if (!IS_ERR_OR_NULL(_T)) fput(_T))
 
 /*
  * take_fd() will take care to set @fd to -EBADF ensuring that

-- 
2.43.0


