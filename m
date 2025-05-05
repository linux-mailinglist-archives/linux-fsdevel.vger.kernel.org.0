Return-Path: <linux-fsdevel+bounces-48145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C70AAA83E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 02:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4DC47B0157
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 00:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAFA34B1EA;
	Mon,  5 May 2025 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxpZnc6E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8290F34B1D9;
	Mon,  5 May 2025 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484778; cv=none; b=hzGYIp1pf5FDCthYIG75d4eJiyNWRuj1LFxv8iQayMm8yKvfCuGxc6E7ohjJd2sFxhfDqDqSya/N8bvF5tFIAocedgDi+Sj5Xeac9mqwS8DbfpuuFyZUU8WhyNJBfh+HxpD3CwUV29hP4C0alCP7hYnLVsusLSEORi9WdH4EIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484778; c=relaxed/simple;
	bh=Htq4hTaRuKJlRyduoQTxp26RoqXVn7UqHuQSjWmu360=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GT1U+fJW+TOnf+O9Z91eViJuo9IxSUMEpjgN+aVFXbUJfHfTm8T5m+HSp5TCg43/wMd9MNu4Pb4DuPLHhrxZ5GfsJxUiUl9ypBUfnfNIOwWr8MJGdwi5kAFOcHLdh1J926/kHVUopEj9smw637oQDJ1V8inQ6A2InZTrjYkfvx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxpZnc6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309C4C4CEF2;
	Mon,  5 May 2025 22:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484778;
	bh=Htq4hTaRuKJlRyduoQTxp26RoqXVn7UqHuQSjWmu360=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YxpZnc6E/gCZfmq6LEK7a33skYof1POgxSa6McVaO+ubxSGgU78Shw6xPhmZdq1qq
	 ZDijvCJjN0UkNcH2ToYKMnrEit3o2l7WOrkXbx01k6ltPXvdREFZJuEfY2rbGX1H8l
	 ufFKYNHggEl7UhXRKK84JNSoiiEg6OS/tF1+bnIpB41kxlIic56JHaxX4jBDmqi3FF
	 S1ux7y1uVuektOtIanX+0N2bsFN7dyWZbWUBmNd4784YEX2tL3X4nYZLBQTWEj2lxe
	 tWSnaZ0MwWAOjz/K6VRgQKxt1ycMkTe8GVEtOyFbZQY3a5BIXxZV3NsNQ8v2fW3cTU
	 XxSmcX6nExSbw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 008/486] fuse: Return EPERM rather than ENOSYS from link()
Date: Mon,  5 May 2025 18:31:24 -0400
Message-Id: <20250505223922.2682012-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Matt Johnston <matt@codeconstruct.com.au>

[ Upstream commit 8344213571b2ac8caf013cfd3b37bc3467c3a893 ]

link() is documented to return EPERM when a filesystem doesn't support
the operation, return that instead.

Link: https://github.com/libfuse/libfuse/issues/925
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index a1e86ec07c38b..ff543dc09130e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1133,6 +1133,8 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	else if (err == -EINTR)
 		fuse_invalidate_attr(inode);
 
+	if (err == -ENOSYS)
+		err = -EPERM;
 	return err;
 }
 
-- 
2.39.5


