Return-Path: <linux-fsdevel+bounces-39077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D6CA0C04B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3563A7A96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEAD20AF8B;
	Mon, 13 Jan 2025 18:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxMjQXXX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FD920B7E4;
	Mon, 13 Jan 2025 18:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793346; cv=none; b=PTw3JHuy1PpCbSfMeiM0h7+y38llrGBQA3uCNth7ueWbzDo+QkPNK73r3RHOTtr3iYdQ67e/7EMq9rbjwpYrq5+Tngxd1yRFzc/YNe0WP8gnghH9N8AGmO7AOdRXr/+dAhsm9C85d2st+Gce48kBl02d3taGcOLUM3pBy4PcxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793346; c=relaxed/simple;
	bh=FwVsBM8MCU5jCU97csf2TPv9NjCpeizSYe9aIzOxrxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AbmsPR89YT5TRb+qSHddNrM6oDJINNdgbpwknxXadLLOxsTaSgBnLJha/U4pNG1u6QjUv76A8g2yL2/tEtyxrvokZggFqL0GmXCwcRn+YYBchOlZhRdrLve10O6SzdUvOn6+xhYaKMnnC+TrG+SCIBIokG3OuLE8MI63EvQkTf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxMjQXXX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A48C4CEE2;
	Mon, 13 Jan 2025 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793345;
	bh=FwVsBM8MCU5jCU97csf2TPv9NjCpeizSYe9aIzOxrxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PxMjQXXXQRsEGOUK3xvlNyQpuKBjWCGPNat4Ksj+bK4+7AN4sZkhB8LtjE70Ouxwp
	 UN/yCuf6cynLkRZZ2T7JMGaFbvKUc5m4yqWyobYVHdoU8PznyxhD0cvSX5Kar4w831
	 hFt4s0tMeKRf7Wr9NcgrjBbGIG4hEeL8dOpL2qovS3VYhzhDwZAupdqhy20PEq11xl
	 lgqk98fZ7Iyo76GpF2FwPB7FTLKL0ufOs8kphM6btfsY+l1IDnCg4XDj/HSRSHe0VT
	 jC6g9iitwcNyPYmvzVTatOsENR9UHcMrgIxLTLPVElc0rAK1udQf1sQfIjplIHHeet
	 2An/9ooynCCXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Kunbo <zhangkunbo@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/10] fs: fix missing declaration of init_files
Date: Mon, 13 Jan 2025 13:35:29 -0500
Message-Id: <20250113183537.1784136-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183537.1784136-1-sashal@kernel.org>
References: <20250113183537.1784136-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.124
Content-Transfer-Encoding: 8bit

From: Zhang Kunbo <zhangkunbo@huawei.com>

[ Upstream commit 2b2fc0be98a828cf33a88a28e9745e8599fb05cf ]

fs/file.c should include include/linux/init_task.h  for
 declaration of init_files. This fixes the sparse warning:

fs/file.c:501:21: warning: symbol 'init_files' was not declared. Should it be static?

Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
Link: https://lore.kernel.org/r/20241217071836.2634868-1-zhangkunbo@huawei.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/file.c b/fs/file.c
index 48f0b28da524..bc0c087b31bb 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -21,6 +21,7 @@
 #include <linux/rcupdate.h>
 #include <linux/close_range.h>
 #include <net/sock.h>
+#include <linux/init_task.h>
 
 #include "internal.h"
 
-- 
2.39.5


