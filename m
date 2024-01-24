Return-Path: <linux-fsdevel+bounces-8666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6806839F15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 03:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B3B71F2998D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 02:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042D418054;
	Wed, 24 Jan 2024 02:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCbs3Nsa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530F2566;
	Wed, 24 Jan 2024 02:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706062994; cv=none; b=SnVCaBOolmvPkaWtp+NSul0OUr6auVf7rpKryBYqdptKaoeUATOyHB1IceajOb9E1jkq2CjwwtFGU9bV8wkE84RYqHVCgGQSaBEyJnfW+NKnJi1u5OYymn+rd6gsYV6NPas9Jwz+iVetLdQcYdOzDyvU6oroQ+nRWzVGcErJ+Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706062994; c=relaxed/simple;
	bh=Z7nNF35CCpeJs23ohkxJ9oMTZTiX1MAFeANW81jjReg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mmE8fsXO0usOwbfqSTwTVeLdGxEATZlh0d+uLHig+pSg0oj7917L5a3kfhW0wG9Mj3sNcshwTmCi7RG5PsAl2pi9cbdohoiDQUUThUuYpywplNZ0dZYeZnASiBGpBLYpUxfTurgTbg/dzknXiWq11RSs4EQoWYp94am4bVTRxzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCbs3Nsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37F0C433F1;
	Wed, 24 Jan 2024 02:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706062993;
	bh=Z7nNF35CCpeJs23ohkxJ9oMTZTiX1MAFeANW81jjReg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LCbs3NsaQcFjyO+lY9sFLdueCXlM9fsI6JHiVqZQW8OalY7F7bGxx1ULyFjtHoUIL
	 IqJuxDSzMRTe5B5n/igURCvZg2kmohyjjO7KycWYj0xhIrytJWVSItQCiduCtn3vpz
	 EtRA2sNsq8hRYGc1DGfOE7KXdpD63tiShzkxF9VlMebZoRl/N8f7bpANqWoHqVShxH
	 HfKB3y3303rMzNiBM3Tlc/fIz3H2kvWDUW7Hcsjyn2RVIFGgmoAcnud7tiQfcSk2Sd
	 dkz+YRjWpOl7s+etqOBnfGDxfApYlJoNN2QyT+nM5VDSXUbFLQIt1gtBdQWO6bQd7j
	 OTVpUP6zEIcxg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	paul@paul-moore.com,
	brauner@kernel.org
Cc: torvalds@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 28/30] libbpf: support BPF token path setting through LIBBPF_BPF_TOKEN_PATH envvar
Date: Tue, 23 Jan 2024 18:21:25 -0800
Message-Id: <20240124022127.2379740-29-andrii@kernel.org>
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

To allow external admin authority to override default BPF FS location
(/sys/fs/bpf) for implicit BPF token creation, teach libbpf to recognize
LIBBPF_BPF_TOKEN_PATH envvar. If it is specified and user application
didn't explicitly specify bpf_token_path option, it will be treated
exactly like bpf_token_path option, overriding default /sys/fs/bpf
location and making BPF token mandatory.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 6 ++++++
 tools/lib/bpf/libbpf.h | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a2866329d8f2..38a0e1e9a472 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7585,6 +7585,12 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 		return ERR_PTR(-EINVAL);
 
 	token_path = OPTS_GET(opts, bpf_token_path, NULL);
+	/* if user didn't specify bpf_token_path explicitly, check if
+	 * LIBBPF_BPF_TOKEN_PATH envvar was set and treat it as bpf_token_path
+	 * option
+	 */
+	if (!token_path)
+		token_path = getenv("LIBBPF_BPF_TOKEN_PATH");
 	if (token_path && strlen(token_path) >= PATH_MAX)
 		return ERR_PTR(-ENAMETOOLONG);
 
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 535ae15ed493..5723cbbfcc41 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -183,6 +183,14 @@ struct bpf_object_open_opts {
 	 * that accept BPF token (e.g., map creation, BTF and program loads,
 	 * etc) automatically within instantiated BPF object.
 	 *
+	 * If bpf_token_path is not specified, libbpf will consult
+	 * LIBBPF_BPF_TOKEN_PATH environment variable. If set, it will be
+	 * taken as a value of bpf_token_path option and will force libbpf to
+	 * either create BPF token from provided custom BPF FS path, or will
+	 * disable implicit BPF token creation, if envvar value is an empty
+	 * string. bpf_token_path overrides LIBBPF_BPF_TOKEN_PATH, if both are
+	 * set at the same time.
+	 *
 	 * Setting bpf_token_path option to empty string disables libbpf's
 	 * automatic attempt to create BPF token from default BPF FS mount
 	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
-- 
2.34.1


