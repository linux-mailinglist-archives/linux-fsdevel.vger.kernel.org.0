Return-Path: <linux-fsdevel+bounces-4734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FC0802D2E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A879B1C2099F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BD0E552
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ZBXFhIz9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8626D135;
	Sun,  3 Dec 2023 23:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676351;
	bh=T3jII5zUnYlnbPPOk4OeB1e7CrcIRU8AQwdXqX+t2X0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZBXFhIz94gSg8Kt7v4w19SdE5yTe/j5v18vyl9a3isW/pKheYAYWCJ55ZQhgDSVA/
	 VVK2ulqv4htTjx9Gvb3dCYsL2nmaejGLVJvR8Fev13rdYXI3H7RuqdTH3r99MH26RL
	 3yay1rFxRe0DseFdG/F9jH9gklQnbzsfpENugf0o=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 04 Dec 2023 08:52:17 +0100
Subject: [PATCH v2 04/18] cgroup: bpf: constify ctl_table arguments and
 fields
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-4-7a5060b11447@weissschuh.net>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
To: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=1943;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=T3jII5zUnYlnbPPOk4OeB1e7CrcIRU8AQwdXqX+t2X0=;
 b=empLB4oJMwGiCFdfTNXuKBYx88Wx32Olsk3PXjNKGw04ybJ6PSzYfGsjskQjHYM/x/F1Q2mHD
 B8qDNrFLuhSDfKF7RqS74q2ZdbS3z89noN6eESpUZOp3EUXpVM/QYbb
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In a future commit the sysctl core will only use
"const struct ctl_table". As a preparation for that adapt the cgroup-bpf
code.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/bpf-cgroup.h | 2 +-
 include/linux/filter.h     | 2 +-
 kernel/bpf/cgroup.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index a789266feac3..504fe9f8a3e7 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -138,7 +138,7 @@ int __cgroup_bpf_check_dev_permission(short dev_type, u32 major, u32 minor,
 				      short access, enum cgroup_bpf_attach_type atype);
 
 int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
-				   struct ctl_table *table, int write,
+				   const struct ctl_table *table, int write,
 				   char **buf, size_t *pcount, loff_t *ppos,
 				   enum cgroup_bpf_attach_type atype);
 
diff --git a/include/linux/filter.h b/include/linux/filter.h
index a4953fafc8cb..4d035fbd8558 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -1358,7 +1358,7 @@ struct bpf_sock_ops_kern {
 
 struct bpf_sysctl_kern {
 	struct ctl_table_header *head;
-	struct ctl_table *table;
+	const struct ctl_table *table;
 	void *cur_val;
 	size_t cur_len;
 	void *new_val;
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 491d20038cbe..85476970b487 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1694,7 +1694,7 @@ const struct bpf_verifier_ops cg_dev_verifier_ops = {
  * returned value != 1 during execution. In all other cases 0 is returned.
  */
 int __cgroup_bpf_run_filter_sysctl(struct ctl_table_header *head,
-				   struct ctl_table *table, int write,
+				   const struct ctl_table *table, int write,
 				   char **buf, size_t *pcount, loff_t *ppos,
 				   enum cgroup_bpf_attach_type atype)
 {

-- 
2.43.0


