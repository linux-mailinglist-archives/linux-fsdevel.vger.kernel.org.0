Return-Path: <linux-fsdevel+bounces-16927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F96B8A4FB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 14:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564401F22639
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 12:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4B281203;
	Mon, 15 Apr 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvsY+B9a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFA78062E;
	Mon, 15 Apr 2024 12:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185378; cv=none; b=lIBMnpOEdxrdUYWeHCZQr1b8LTqHncBguy5ZM2pHD1Q/RTCJk6AshMhm7C6BaI2z/Ks0af1bjqfm+NAIR88sceUJcYtg8iJec6waOn+ra1587vKtStVzfT5LLFdjWhS4qgZy+U5D9uk8tRcN8LAYrn5kqra76crFdQGj9MlQraw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185378; c=relaxed/simple;
	bh=ez+9pHNThV4Qwno6XjpGOuiqDEvbUby8kRZAvhEvGOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyTS6jM7hNRt6RJgWqSr49p4n3Ia/8DjwXxmYR/bF3g9+nr/bbj5OXZTzmN8Gkf1UA/uHmT4uan8HI+YMhHv41r/9sqaw3tQfmr/PzxwqNWZQRn5E+HIGIcETYOef89mOhvTxLIB19WGgt391zbclAorvNFcFrSNLLupTRSkIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvsY+B9a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43855C3277B;
	Mon, 15 Apr 2024 12:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185378;
	bh=ez+9pHNThV4Qwno6XjpGOuiqDEvbUby8kRZAvhEvGOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WvsY+B9aX95J/tCeYFcYnPI95mwpRzKkhruWPSXXZaUVGfj7SWAv33ZreJAxPp1PQ
	 ekz9B4TzpqFoFWdcHcX7noF+DvHMCdePek64LdPk6knJ6S0wRdO8771zgKMvKikm+8
	 gWR/gTgLv4EGQoe+hVpuR808Jv/rp7OMS8wG3+ay0sb8ehYUdwbJVtUcQqhoDLNRlJ
	 tTwtQPC1lJczWE6ejuNZrqhzHUT8miPdRo0f+GF5lgWgS1CjrU3UlbXl61wF5RB/3B
	 61pC90LsmG/hC36Xr1Dh97xsnQsJBrl4OWZmomZ7HP0MVgyHEyh6yhAqFLJOkJWQNZ
	 XodCUaM+Mm7hg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 13/15] vboxsf: explicitly deny setlease attempts
Date: Mon, 15 Apr 2024 06:02:53 -0400
Message-ID: <20240415100311.3126785-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100311.3126785-1-sashal@kernel.org>
References: <20240415100311.3126785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.6
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 1ece2c43b88660ddbdf8ecb772e9c41ed9cda3dd ]

vboxsf does not break leases on its own, so it can't properly handle the
case where the hypervisor changes the data. Don't allow file leases on
vboxsf.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://lore.kernel.org/r/20240319-setlease-v1-1-5997d67e04b3@kernel.org
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/vboxsf/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/vboxsf/file.c b/fs/vboxsf/file.c
index 2307f8037efc3..118dedef8ebe8 100644
--- a/fs/vboxsf/file.c
+++ b/fs/vboxsf/file.c
@@ -218,6 +218,7 @@ const struct file_operations vboxsf_reg_fops = {
 	.release = vboxsf_file_release,
 	.fsync = noop_fsync,
 	.splice_read = filemap_splice_read,
+	.setlease = simple_nosetlease,
 };
 
 const struct inode_operations vboxsf_reg_iops = {
-- 
2.43.0


