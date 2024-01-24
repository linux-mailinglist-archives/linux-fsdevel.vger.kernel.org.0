Return-Path: <linux-fsdevel+bounces-8651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734C4839ED9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6C831C214AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4730F168D0;
	Wed, 24 Jan 2024 02:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCWOufW8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4EB168B1;
	Wed, 24 Jan 2024 02:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062939; cv=none; b=Nf80kWx4gw/ghmaKnt343DC8Vjb0HC5FiGw1ixpUTwWYuCkPrKMrSj4ATQpmx0YKaUijgMrNlkKlCA14LWAm6UL/8jZaYUSDpT7tL9rArQQVxn7m9vWgokhI6mJP29blM+206DxEIeAMHMvJJlstZNaL3KwKWmpT2kxb2QMDg9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062939; c=relaxed/simple;
	bh=OAf0H8xCjgTehuy6LEv785Gpeiz7HDBuitlgXR1tzP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FboUrxJfwSbmpDGUhwsPRkJQ3l7TcehIoBcoc3I9+q+dWDqCj01XhOOB6Cnc0zoSClr+sbOlqAUeCrVJjZPaU+UbStcrEl52LAHYaLbqylQsjGIirG7lvBRxTYrGDTGVguxSXv0dwHOcmkyCH7jPbvKGD2A/6KKFBXb9oFj/vDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCWOufW8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C530C433C7;
	Wed, 24 Jan 2024 02:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062939;
	bh=OAf0H8xCjgTehuy6LEv785Gpeiz7HDBuitlgXR1tzP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HCWOufW8NjxXHeZtsX5Da22b8eFnTSjLYENxmBuC1VUK6yHt1377m65n7tJr1pW6n
	 JvPJ3ecN+dXZdQ9IegvCZ7n/BNP8NfBXP70ugmwqr8JQLZTROaTpzCj9D9GONh8j5E
	 12cQfsqMPJdzXiATQhu06sIgUL57CrXWu42vYa5RQCWOCEtKHPxkxOMVKYXek3gyc5
	 wmqaLgPJvQKaTpgH2RrSUInpmgI94D8yKKNXsfC3kIkB8P18grMgaMNYEafewXFJRC
	 MoXCxvXCweAsmQmvcJ63uKJMt9zRqUq+3pUn+hv1+suLQ5yjgMZUGQrmwMtLdc2JrV
	 FFizHsG70AEHQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 13/30] libbpf: add BPF token support to bpf_map_create() API
Date: Tue, 23 Jan 2024 18:21:10 -0800
Message-Id: <20240124022127.2379740-14-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124022127.2379740-1-andrii@kernel.org>
References: <20240124022127.2379740-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ability to provide token_fd for BPF_MAP_CREATE command through
bpf_map_create() API.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c | 4 +++-
 tools/lib/bpf/bpf.h | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index d4019928a864..1653b64b7015 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -169,7 +169,7 @@ int bpf_map_create(enum bpf_map_type map_type,
 		   __u32 max_entries,
 		   const struct bpf_map_create_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, map_extra);
+	const size_t attr_sz = offsetofend(union bpf_attr, map_token_fd);
 	union bpf_attr attr;
 	int fd;
 
@@ -198,6 +198,8 @@ int bpf_map_create(enum bpf_map_type map_type,
 	attr.numa_node = OPTS_GET(opts, numa_node, 0);
 	attr.map_ifindex = OPTS_GET(opts, map_ifindex, 0);
 
+	attr.map_token_fd = OPTS_GET(opts, token_fd, 0);
+
 	fd = sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
 	return libbpf_err_errno(fd);
 }
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index e49254c9f68f..ae2136f596b4 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -51,8 +51,11 @@ struct bpf_map_create_opts {
 
 	__u32 numa_node;
 	__u32 map_ifindex;
+
+	__u32 token_fd;
+	size_t :0;
 };
-#define bpf_map_create_opts__last_field map_ifindex
+#define bpf_map_create_opts__last_field token_fd
 
 LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
 			      const char *map_name,
-- 
2.34.1


