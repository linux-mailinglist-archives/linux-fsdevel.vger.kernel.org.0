Return-Path: <linux-fsdevel+bounces-37660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCC79F579F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 21:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62102188F924
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 20:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228BB1F942F;
	Tue, 17 Dec 2024 20:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6EOtLby"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8914885B;
	Tue, 17 Dec 2024 20:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467146; cv=none; b=YwkQwBtpu9qYxZd9jr6Vs2q8STvmzVcZQMn/4qC7TwKxWBvD3VN0mlxHHOiDNEIEsJcFB1s4OiFxalSDJt1ni3jjx7roJSPCPanI8bmX6S9yx2crWgrQ2lMYOep3vvPukB8+gOI+q5Z0HJnOo82kf9eOnSeSYHFX6PT6umcKvEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467146; c=relaxed/simple;
	bh=S0S+fEaGKC5jgReGp1FPYiXcyUYhRdxd30lq2rjho3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Giphy7eN5BLj+TUUyqUcFDd7f38U+FB752IFc6aRm3IDqNv+q2R0ZY4gpTvNfJthobKGQv73xxAXAXOg6pG2WKGnSUpKfT+L3WN7FuM1Z54zaDSL5kCpgQqqDmZA4jyukQC2m2zzqeC2+L9MQtgTtiHAKMqENFJXUTNJ6KwRNbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6EOtLby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529DEC4CED3;
	Tue, 17 Dec 2024 20:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734467146;
	bh=S0S+fEaGKC5jgReGp1FPYiXcyUYhRdxd30lq2rjho3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M6EOtLbytJ9UiVvXSJxMH5dqjmiZONvZV8RX/aRQdJ26tezhgSj5upoi744C54EUx
	 x8wPPPM9+NULvB+ZSgMXuLepYjQMJnTJtpjEglJa3StJK7gSscHkM2MLeKUf73i/AN
	 dnc6mZs2G+ZRHO2qdCQ9Losi8la726lL1sYjDXWZVDBUyvp32rEzBhJ26a4kXr4+6i
	 CZ7zcoxgDfC0/PNJ2k2iuXMFEId0WKETbbIjwQ5iPFW5yQFC5JUNXJyVnZe4LsYp1g
	 pmhn9wyXLWAjYza7+Qy//IJeAzugHY+WkhdssTULw3QRhtv/o6MWLfKwg9jUXjoeTq
	 3rSeCk+QVE6TA==
From: Song Liu <song@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kernel-team@meta.com,
	brauner@kernel.org,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	Song Liu <song@kernel.org>
Subject: [RFC 1/2] ima: Add kernel parameter to disable IMA
Date: Tue, 17 Dec 2024 12:25:24 -0800
Message-ID: <20241217202525.1802109-2-song@kernel.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241217202525.1802109-1-song@kernel.org>
References: <20241217202525.1802109-1-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch provides kernel parameter 'ima=off' that disables IMA.
This will reduce memory consumption by the ima when it is not needed.
Specifically, this saves one pointer per inode in the system.

Originally-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Signed-off-by: Song Liu <song@kernel.org>
---
 security/integrity/ima/ima_main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 06132cf47016..21968c78f03f 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -1144,10 +1144,22 @@ static int ima_kernel_module_request(char *kmod_name)
 
 #endif /* CONFIG_INTEGRITY_ASYMMETRIC_KEYS */
 
+
+static int ima_mode = 1;
+static int __init ima_setup(char *str)
+{
+	if (strncmp(str, "off", 3) == 0)
+		ima_mode = 0;
+	return 1;
+}
+__setup("ima=", ima_setup);
+
 static int __init init_ima(void)
 {
 	int error;
 
+	if (!ima_mode)
+		return 0;
 	ima_appraise_parse_cmdline();
 	ima_init_template_list();
 	hash_setup(CONFIG_IMA_DEFAULT_HASH);
@@ -1217,6 +1229,7 @@ DEFINE_LSM(ima) = {
 	.name = "ima",
 	.init = init_ima_lsm,
 	.order = LSM_ORDER_LAST,
+	.enabled = &ima_mode,
 	.blobs = &ima_blob_sizes,
 };
 
-- 
2.43.5


