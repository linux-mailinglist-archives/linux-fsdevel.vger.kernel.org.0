Return-Path: <linux-fsdevel+bounces-24511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190B093FFAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 22:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A1B31C221C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 20:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D02018C323;
	Mon, 29 Jul 2024 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TPzVjM2w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C9E1891C6;
	Mon, 29 Jul 2024 20:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285830; cv=none; b=CJcsEzK2QlxtyHqv04nJd6VdWhQOHDhPi2QIqTIFMIfMYQuEA/grCmR5DNkMzxRed7wzezy2HuoM7503WA14JTVON1ByQq1L1YwkFIXJBBreeZlf2ZUAhVEVgg7DgH3/PBFz0Ayu8imOgHPLQL5AUs3ihb9nRpdHAdpoGvdVyrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285830; c=relaxed/simple;
	bh=wBgdt4L4EyoDAU+mT9ij7hDNmnSqVWf3X3bm35G+jsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fsmy0bxagmKPlv6UZtVjcT5f4GdozY+QDJTiX/4NN3OZTfxGRVan+j2imeaNqKM8BLyKt/j6kQDCHlmECUOSThwHOfoOVk2EpN4j3m8iB8bjDfEzS62muSuoe/qGJFCoVbG8QCoYgm48yf59Ek8dQUQcFrYaA9Gga3N87TNx2lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TPzVjM2w; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722285819;
	bh=wBgdt4L4EyoDAU+mT9ij7hDNmnSqVWf3X3bm35G+jsQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TPzVjM2wg7X8BQNIY5PrLqbPKjOoInXhnlpIzqrsA1AV0qKJ9H3uFGW75fwVoqNdo
	 imQB3o14qh72nB03ckKlCUDGUmwp0CD3Oyr0rh5VONVMplWpgKpBhF+97lqZIdXC8b
	 wRtt1jS6LPoESbwTOFSbZaoqTwpIv8S+gJR2NoPw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 29 Jul 2024 22:43:34 +0200
Subject: [PATCH 5/5] const_structs.checkpatch: add ctl_table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240729-sysctl-const-api-v1-5-ca628c7a942c@weissschuh.net>
References: <20240729-sysctl-const-api-v1-0-ca628c7a942c@weissschuh.net>
In-Reply-To: <20240729-sysctl-const-api-v1-0-ca628c7a942c@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722285818; l=622;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wBgdt4L4EyoDAU+mT9ij7hDNmnSqVWf3X3bm35G+jsQ=;
 b=b5gttQlm7Hfv4Ca/iEHJVjTqRqCqYvih6IXJUWLLtBn+wsC/8SK+SqdvzyZkZTPWw7QX7DNQs
 nyUPELfVUhjAzf0xB91FBLDs416whwpz15MFAcTw0rM6q7LZ7ITnCDj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Now that the sysctl core can handle "const struct ctl_table", make
sure that new usages of the struct already enter the tree as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/const_structs.checkpatch | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index 014b3bfe3237..e8609a03c3d8 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -6,6 +6,7 @@ bus_type
 clk_ops
 comedi_lrange
 component_ops
+ctl_table
 dentry_operations
 dev_pm_ops
 device_type

-- 
2.45.2


