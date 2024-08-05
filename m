Return-Path: <linux-fsdevel+bounces-24994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1039478A9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 11:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B66BB231E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65B81581F8;
	Mon,  5 Aug 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iyjLa4Yb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A37156225;
	Mon,  5 Aug 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722850835; cv=none; b=AjFhbhBbXWIH3MoVPqKkvsSWxpAhwB/KiDY8rEVpmGuB5mLtiXmmCjd+7zTdjd+wEI3WZLDXnSf0NA+Qzi9Y+Vnu491c0SSaBzxWnhUbSTm/fzWC3QCDe50ybQkgBVZGGGKo08pFObgsOAG66eujFy1lGTqOMYvNGkPi6ejT0U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722850835; c=relaxed/simple;
	bh=nm32PnqAjO9H4K8KB3Um59/Tn6i74Jg0x+xVLVLfkks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qpXx2vDSkK+0I4yynhISm1eTL3pY5d0gBRZSxh3dP5FhoEfXNJH144dHxgaFxaYVIxxpD4ItHotmd8O2VOAfHhaP2M13dmbbZOyWdeYLbl8dfjuW5YA0O0/MfculWZMmkzwOoM1nw064sWk9i6YifX2iM4pQNcfXnX+n58Tu+JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iyjLa4Yb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722850825;
	bh=nm32PnqAjO9H4K8KB3Um59/Tn6i74Jg0x+xVLVLfkks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iyjLa4YbE1j+BtzEy9Lu1ITIS7OZkoW9IzcZTEYl+wyzT6udeYiYXSX9dQ0dBMSN3
	 kMwGehiMbKPD/O0xUCGRSxJk7L+Yrlc1ZGqH277LQsW/zkyZi/tHtMLHnb6SsRKaR+
	 bUKgftP/9wMOKl3+jHVJfLrEamJkdmPay0ru2I1A=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 05 Aug 2024 11:39:39 +0200
Subject: [PATCH v2 5/6] sysctl: make internal ctl_tables const
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240805-sysctl-const-api-v2-5-52c85f02ee5e@weissschuh.net>
References: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
In-Reply-To: <20240805-sysctl-const-api-v2-0-52c85f02ee5e@weissschuh.net>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Kees Cook <kees@kernel.org>, Joel Granados <j.granados@samsung.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722850824; l=1041;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=nm32PnqAjO9H4K8KB3Um59/Tn6i74Jg0x+xVLVLfkks=;
 b=ow6lwrgh0tJ3bDLvbcoAMGjFrtDebrJ+UpTi/foC8+Yn3kdtz+ElX+hXLA0pqXIB4MaH9r1Jo
 qLiWd2EgRXECSopi4RC7N/PWuS3dlOqQxHGwD7QdQLgmGd2qRyuJxqa
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Now that the sysctl core can handle registration of
"const struct ctl_table" constify the sysctl internal tables.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 968f8dcffd8f..9b9dfc450cb3 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -33,7 +33,7 @@ static const struct inode_operations proc_sys_dir_operations;
  * Support for permanently empty directories.
  * Must be non-empty to avoid sharing an address with other tables.
  */
-static struct ctl_table sysctl_mount_point[] = {
+static const struct ctl_table sysctl_mount_point[] = {
 	{ }
 };
 
@@ -67,7 +67,7 @@ void proc_sys_poll_notify(struct ctl_table_poll *poll)
 	wake_up_interruptible(&poll->wait);
 }
 
-static struct ctl_table root_table[] = {
+static const struct ctl_table root_table[] = {
 	{
 		.procname = "",
 		.mode = S_IFDIR|S_IRUGO|S_IXUGO,

-- 
2.46.0


