Return-Path: <linux-fsdevel+bounces-78050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLrQCMfenGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:12:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C041717EF95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 480FA317B4D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DEC37E2F8;
	Mon, 23 Feb 2026 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSmIA3rf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FDC37D132;
	Mon, 23 Feb 2026 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888167; cv=none; b=spqmcs1MzN89NpKeq8YMKZo3hEz2o/ciLhVmkV5h71xTplA7NprwUKrLoH+/7GJ1IyucK8NcQ8pTjh3QIujWBH2WBaWpfPFxp58qom2KyreInyqh5tWVQ6H2bs1E9S96sEO2EkYQcFuHk6OLpcO6VuwAPEWvQRVReGSlL3EIKhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888167; c=relaxed/simple;
	bh=/w/xgCdATbtP5PCQ004Ce6uIg19AwIwxTReKdOiZs6s=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqY4GsTA4vIP+jYfEs9Kj8ye10YifIF81KTq04FvnTkmKegN0pKk4rKrwcHQ/H44zkKhHonr+e0Bzv1c4GvPGz28W5DKPAZl4fi1U88kao8rL1mBfKBCrMeF7xR8M7maTz1YKnwFTn8Bj3FnligRK5/f4gEi/wgr3u8KWaOFa8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSmIA3rf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4EFC116C6;
	Mon, 23 Feb 2026 23:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771888167;
	bh=/w/xgCdATbtP5PCQ004Ce6uIg19AwIwxTReKdOiZs6s=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DSmIA3rfR3mzfZrxWV9KHXZ7uLYiC9afiR7hdX2BfLyaCg5TsUxRYMHDCqUe/uchN
	 1Pmvjo6AapJ1cuTivEK3RMkWITHplaPZRX7zPZRtrV9ujEQqRJ+vyb5Mf0q87EwaAy
	 WPDNm8pD6Z/MjoGKFfGC/rWSpjWfPkkRvHJcISkTMA9SvNeX3iBtFsNC6aw9cYNL9i
	 Gf2/8kBNMAh8z3uPg0KXr8YIujhPhkBuoAjnLcRzNxeiVBkCDx9ZwXGChOsF8lTtEG
	 gU9eNY1y59QeK9epVpr7lAc7g/Gvu7FMTVtoXWejEC9INMAo1J+nSgzebZswFmUbkr
	 CGzWl0S3adWBA==
Date: Mon, 23 Feb 2026 15:09:26 -0800
Subject: [PATCH 03/33] fuse: make debugging configurable at runtime
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188734310.3935739.8491015946459269214.stgit@frogsfrogsfrogs>
In-Reply-To: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
References: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78050-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C041717EF95
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Use static keys so that we can configure debugging assertions and dmesg
warnings at runtime.  By default this is turned off so the cost is
merely scanning a nop sled.  However, fuse server developers can turn
it on for their debugging systems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap_i.h |   17 ++++++++++++++---
 fs/fuse/Kconfig        |   15 +++++++++++++++
 fs/fuse/fuse_iomap.c   |   43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 3 deletions(-)


diff --git a/fs/fuse/fuse_iomap_i.h b/fs/fuse/fuse_iomap_i.h
index b9ab8ce140e8e1..c37a7c5cfc862f 100644
--- a/fs/fuse/fuse_iomap_i.h
+++ b/fs/fuse/fuse_iomap_i.h
@@ -8,17 +8,28 @@
 
 #if IS_ENABLED(CONFIG_FUSE_IOMAP)
 #if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
-# define ASSERT(condition) do {						\
+
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_BY_DEFAULT)
+DECLARE_STATIC_KEY_TRUE(fuse_iomap_debug);
+#else
+DECLARE_STATIC_KEY_FALSE(fuse_iomap_debug);
+#endif /* FUSE_IOMAP_DEBUG_BY_DEFAULT */
+
+# define ASSERT(condition) \
+while (static_branch_unlikely(&fuse_iomap_debug)) {			\
 	int __cond = !!(condition);					\
 	if (unlikely(!__cond))						\
 		trace_fuse_iomap_assert(__func__, __LINE__, #condition); \
 	WARN(!__cond, "Assertion failed: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
-} while (0)
+	break;								\
+}
 # define BAD_DATA(condition) ({						\
 	int __cond = !!(condition);					\
 	if (unlikely(__cond))						\
 		trace_fuse_iomap_bad_data(__func__, __LINE__, #condition); \
-	WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
+	if (static_branch_unlikely(&fuse_iomap_debug))			\
+		WARN(__cond, "Bad mapping: %s, func: %s, line: %d", #condition, __func__, __LINE__); \
+	unlikely(__cond);								\
 })
 #else
 # define ASSERT(condition)
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 934d48076a010c..1b8990f1c2a8f9 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -101,6 +101,21 @@ config FUSE_IOMAP_DEBUG
 	  Enable debugging assertions for the fuse iomap code paths and logging
 	  of bad iomap file mapping data being sent to the kernel.
 
+	  Say N here if you don't want any debugging code code compiled in at
+	  all.
+
+config FUSE_IOMAP_DEBUG_BY_DEFAULT
+	bool "Debug FUSE file IO over iomap at boot time"
+	default n
+	depends on FUSE_IOMAP_DEBUG
+	help
+	  At boot time, enable debugging assertions for the fuse iomap code
+	  paths and warnings about bad iomap file mapping data.  This enables
+	  fuse server authors to control debugging at runtime even on a
+	  distribution kernel while avoiding most of the overhead on production
+	  systems.  The setting can be changed at runtime via the debug_iomap
+	  module parameter.
+
 config FUSE_IO_URING
 	bool "FUSE communication over io-uring"
 	default y
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index c22c7961cc0bdc..f7a7eba8317c18 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -18,6 +18,49 @@ static bool __read_mostly enable_iomap =
 module_param(enable_iomap, bool, 0644);
 MODULE_PARM_DESC(enable_iomap, "Enable file I/O through iomap");
 
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG_BY_DEFAULT)
+DEFINE_STATIC_KEY_TRUE(fuse_iomap_debug);
+#else
+DEFINE_STATIC_KEY_FALSE(fuse_iomap_debug);
+#endif /* FUSE_IOMAP_DEBUG_BY_DEFAULT */
+
+static int iomap_debug_set(const char *val, const struct kernel_param *kp)
+{
+	bool now;
+	int ret;
+
+	if (!val)
+		return -EINVAL;
+
+	ret = kstrtobool(val, &now);
+	if (ret)
+		return ret;
+
+	if (now)
+		static_branch_enable(&fuse_iomap_debug);
+	else
+		static_branch_disable(&fuse_iomap_debug);
+
+	return 0;
+}
+
+static int iomap_debug_get(char *buffer, const struct kernel_param *kp)
+{
+	return sprintf(buffer, "%c\n",
+		       static_branch_unlikely(&fuse_iomap_debug) ? 'Y' : 'N');
+}
+
+static const struct kernel_param_ops iomap_debug_ops = {
+	.set = iomap_debug_set,
+	.get = iomap_debug_get,
+};
+
+module_param_cb(debug_iomap, &iomap_debug_ops, NULL, 0644);
+__MODULE_PARM_TYPE(debug_iomap, "bool");
+MODULE_PARM_DESC(debug_iomap, "Enable debugging of fuse iomap");
+#endif /* IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG) */
+
 bool fuse_iomap_enabled(void)
 {
 	/* Don't let anyone touch iomap until the end of the patchset. */


