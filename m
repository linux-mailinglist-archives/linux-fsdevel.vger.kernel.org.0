Return-Path: <linux-fsdevel+bounces-17472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC488ADECD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 09:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17381F2380C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 07:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761EC54BF6;
	Tue, 23 Apr 2024 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dtp2KrFT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2198C481D1;
	Tue, 23 Apr 2024 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858976; cv=none; b=LqRoNWjFfV0+v7jIzgT/YDOzGpzC38G+T/WiHkjcKFAOApaGDtLVucjzsJJ5aIAIGQ7gE/xogrNmgH06kjY0Jbto708RzEA1ELPjA3pVQbOJbEbOEAdPEY8FLrolIviSDXryHXZs8NebagKTh8x/ilaItw37Owl/xuaBZL5Sm5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858976; c=relaxed/simple;
	bh=C10U8w+9znaxkvj5EdGV6iNeFy+LKwoCMige5+WbmRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bD9ZBWbR3V/5EtyCQMG2+iC2V6SOZi/v8HBmspcWwGGYIKbjSu/uuR/8lrBBM2pESbdgQtfy17cvpI/H1R7BAUPKUzpGp/QsetVpR6TWsqI4tialNxHBMqTGMgJp0uVjbt5SxkUyCt2CENdr/dcOX0xWWnaoS/iTzREF+gM4axA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dtp2KrFT; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713858962;
	bh=C10U8w+9znaxkvj5EdGV6iNeFy+LKwoCMige5+WbmRk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dtp2KrFTs1ZPOV423X3Lj+ohYH+w1R0E/8kBpk9DMXXZtdIcFmbTu30wN5OkBGmMP
	 FLzPXuqgfXj6gzjMKHmGAW69Xpdffu14WLEeO5qDjUe0ZwtkRmnV3IoKoevaneipoy
	 3sjOVDTg0D0OU3K0YuEo6+K2obOUKB6HIC+G61H4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 09:54:40 +0200
Subject: [PATCH v3 05/11] neighbour: constify ctl_table arguments of
 utility function
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-sysctl-const-handler-v3-5-e0beccb836e2@weissschuh.net>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
In-Reply-To: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Joel Granados <j.granados@samsung.com>, Kees Cook <keescook@chromium.org>
Cc: Eric Dumazet <edumazet@google.com>, Dave Chinner <david@fromorbit.com>, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, kexec@lists.infradead.org, 
 linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
 lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
 linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713858961; l=808;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=C10U8w+9znaxkvj5EdGV6iNeFy+LKwoCMige5+WbmRk=;
 b=EAoTey3kmtnh/z6T2K9kHOuOiGQPDvnlrHzdVg4MNSMG74MpVnrzaAzOlr8qG7tTA+0aGApZ5
 EfQ5uq8SVYaAWFetEV8qu3UzVUp6J12UzjZsoq4ZupsTosh3ACnOL89
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In a future commit the proc_handlers themselves will change to
"const struct ctl_table". As a preparation for that adapt the internal
helper.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 net/core/neighbour.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 0805c00c63d4..92a01664a723 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3578,7 +3578,7 @@ static void neigh_copy_dflt_parms(struct net *net, struct neigh_parms *p,
 	rcu_read_unlock();
 }
 
-static void neigh_proc_update(struct ctl_table *ctl, int write)
+static void neigh_proc_update(const struct ctl_table *ctl, int write)
 {
 	struct net_device *dev = ctl->extra1;
 	struct neigh_parms *p = ctl->extra2;

-- 
2.44.0


