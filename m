Return-Path: <linux-fsdevel+bounces-39070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FFEA0BFF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 19:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF753A4E81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2025 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1F51CD21E;
	Mon, 13 Jan 2025 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifDrqDBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CDD1CCEEC;
	Mon, 13 Jan 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736793280; cv=none; b=HV9w0tDocr7aJ8x6K4rmsvpkuC7/mKEDgOEQCK4hNJNTSemjazdVEjZjmG0Cb6BIBoh4KZNqWhQOGczS/PPenejDOzZOp9DY/uBbGUsKdIEXvCEgU0zVitPBFaycn5HrMBgdS4dlca4rHS4P576OWWDmx04IeTS9ctBbFBK/vaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736793280; c=relaxed/simple;
	bh=/pMvMIPeUjcSrEw9r381b8ueVUZsX82EYFAWKS3YBG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g+1YRusqapYusTaQkjhBpvXIAqGOj1CVIeLyGBiy3XdfbPfHBovfctf+8q5ThWm5J/5rDrDh4WPXuF3qJFyEseW8336s002zPJgsvUQpxvlnjv2rMbX2Gw5fv56sGJFSAc/dR5NIiQy32l6EiwfwHGaqwRF6Azot2rQBjETjEGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifDrqDBW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC9BBC4CEE1;
	Mon, 13 Jan 2025 18:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736793279;
	bh=/pMvMIPeUjcSrEw9r381b8ueVUZsX82EYFAWKS3YBG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ifDrqDBWhjhttb9AbSPkCNLMptwK/0b8ry1cxdQvKN4TYsPuQliO6K8voL5RmBAmd
	 wqw9nkw+hHY4++0XpxmAP2Ee8rB+izU1jeYxHrMOEmX5hdODRYsa2Qc0/dSyxvgIdr
	 VhVZYEIdMsYn+TYLhIPxYmJe/rlq0biEiZIFkaPbFRzH47DNUEZO2z5xDKttf0wyhw
	 SX2qYNRCy5nhT1XiSDDVF4qN6VPi3vx0UyNXL8HJWBDjvgobt2mcN6vjfhFZZqhb58
	 NdtgRHPlf6mzj8GVUUnEphPOa6TxFRy4W2X7E9iFD9c1U1MLTF0nvTUl/xMA6C+Swm
	 +Yj9Z4o7N+Bog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhang Kunbo <zhangkunbo@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	viro@zeniv.linux.org.uk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 05/20] fs: fix missing declaration of init_files
Date: Mon, 13 Jan 2025 13:34:10 -0500
Message-Id: <20250113183425.1783715-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250113183425.1783715-1-sashal@kernel.org>
References: <20250113183425.1783715-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.9
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
index eb093e736972..4cb952541dd0 100644
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


