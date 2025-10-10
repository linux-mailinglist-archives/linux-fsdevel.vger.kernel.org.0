Return-Path: <linux-fsdevel+bounces-63814-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFBABCEA1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 23:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827FD1A64137
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 21:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D72730498E;
	Fri, 10 Oct 2025 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cQSRbwST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A97C3043BA
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 21:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760132556; cv=none; b=lHhWrYKdflCdSvS07z1/YrPQA89NCvySQLZOVKsVDZT0c3bmxGRGx2lbAVOOASBbPkVFN9N30EZ3OrmJsa0G5dYhXbNdZm+EHVz9Tqoxj2D2Ohch05fzyF5+RH/tO28Wezpyy75fm7Rs4bgjpCncvRYrOqZJODqkpTzNjNfSkG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760132556; c=relaxed/simple;
	bh=mnFRGKWiCU/Y0bSZZZtd3RfpnEkP2aMwME88vWhneF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4s+BfRHxh1AVcj7GOKmHG5xCpSv2u42LMrV3ywCJJ4TMjnhciz+tDvN9eduxTgcASs0tv1jRWNImkVdPqUNU1PFvBbuoOQ1bCArpE85rrbvUVgyZPbeTkJZb8Rb9IHcYxqx2Q4qbBKa9m5qGH+5RvC/EnuH6Pvk/W9tRqFg9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cQSRbwST; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760132552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8sfkdq85h44HFcZmUBA7XKUXRGbpoM+BKPyNcgI4PI0=;
	b=cQSRbwSTYGMtPj0ejsCfmKeNZElVu/Yc5/6Q+KLc2IqJHW+aLgua0+czpOl0YJtrSUetSX
	mpyfU90PvQRKtY94s1vTv+3ZMNpHNejaTq6FfFnojSLCQ38JkAatPjEeWVtCM4Ohdtepwf
	kCJ4ZfVsmCb33+P4mFv6zmJcyX1vy7Y=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-iQfYXKyiOzm7308ARad_Xg-1; Fri, 10 Oct 2025 17:42:31 -0400
X-MC-Unique: iQfYXKyiOzm7308ARad_Xg-1
X-Mimecast-MFC-AGG-ID: iQfYXKyiOzm7308ARad_Xg_1760132550
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-42f9b476ca8so75711675ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 14:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760132550; x=1760737350;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8sfkdq85h44HFcZmUBA7XKUXRGbpoM+BKPyNcgI4PI0=;
        b=hDDsDwBHFDlKoic2GXDZNuy3o+R8BwlTmof4uhd+P4mZOy67MHKM7ZF4pTWIkwpON7
         m75Y9+i4eNLu52SlT20USWEfjBX8+hNZd1kshXqPMqykiV6eo5kWR5XlxRfFaYj/txvK
         l2X3O2S+8l8Uku46mMv+Mq1lCWrSGMJnlIMqnYP5oX0GW0B3zbfizeeRd60M8L0Z4baY
         2WqXhaPJ6hbeUjLIHmeolxmwQcHBR91w5JvbpdCzSNaU3dDgiDCS0867ecDgU6nRq9bZ
         TM6ZhkNLuFvAu63DcoicL0V3Uko8Mmm9huQCufGZOX3F3oiffk/dzgmbeN66W48EOvTu
         u+3A==
X-Gm-Message-State: AOJu0YzwxgVQQCQXii5OXtZ2DCmvIp3OXR2qIl3+GHTOXnbiWwIMpUlv
	0aKw25KExNEIg+l/0iJVRa9GD6Mz303bfJS9nUoYu7NCCJE5XDop5RPzkfMJaEinE5d285t40LQ
	/UuTzeRFOU3qOtrv1dw1yHyL72uWtNMlmlEFM3yZsuVLkOiGXRcs4eXut+1huxYkuj4I=
X-Gm-Gg: ASbGncspsQg2eg33ho5w6IdhYakHYFCknpNT184CvGJS/4a+urlSnrfz6Qwo+k+ce4T
	rj8BI0xT8XJR/ZPI9EOK3BhjZEiK6Yx8rBsRXEehxPVu5YRj9R1I8cRMiAI7holCzHR3N5AwuWV
	2AYmefS/Kuc/IET+3Yq1WgTFAHE84Di6vEGOgwwx4Qqos17KhyrhmbMq7r9lo8acoVOm/pH/HMk
	jlwxYrw5qCd6dXZsSsc9fg3kEzaHoLrPc2bCUE0VWPOGF+kqOyPXib2PbkOcrujEPTSqON7d6dD
	+gVjp717YVZH2LsEYxMigS0=
X-Received: by 2002:a05:6e02:23c3:b0:42f:8afa:326f with SMTP id e9e14a558f8ab-42f8afa34damr141170805ab.19.1760132549626;
        Fri, 10 Oct 2025 14:42:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrY+hGXobn1ewxHQXDJ3/LtKFA8P9+G4dWvdRYK2yRdKIyf0wrOGJ3XuNy5C3ZGsCPTMqXeQ==
X-Received: by 2002:a05:6e02:23c3:b0:42f:8afa:326f with SMTP id e9e14a558f8ab-42f8afa34damr141169795ab.19.1760132548892;
        Fri, 10 Oct 2025 14:42:28 -0700 (PDT)
Received: from big24.xxmyappdomainxx.com ([79.127.136.56])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f9027855bsm24382895ab.11.2025.10.10.14.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 14:42:28 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ericvh@kernel.org,
	lucho@ionkov.net,
	asmadeus@codewreck.org,
	linux_oss@crudebyte.com,
	eadavis@qq.com,
	Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH V3 4/4] 9p: convert to the new mount API
Date: Fri, 10 Oct 2025 16:36:19 -0500
Message-ID: <20251010214222.1347785-5-sandeen@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010214222.1347785-1-sandeen@redhat.com>
References: <20251010214222.1347785-1-sandeen@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert 9p to the new mount API. This patch consolidates all parsing
into fs/9p/v9fs.c, which stores all results into a filesystem context
which can be passed to the various transports as needed.

Some of the parsing helper functions such as get_cache_mode() have been
eliminated in favor of using the new mount API's enum param type,
for simplicity.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 fs/9p/v9fs.c               | 539 +++++++++++++++++++------------------
 fs/9p/v9fs.h               |   7 +-
 fs/9p/vfs_super.c          | 130 ++++++---
 include/net/9p/client.h    |   2 +-
 include/net/9p/transport.h |   2 +-
 net/9p/client.c            | 148 +---------
 net/9p/mod.c               |   2 +-
 net/9p/trans_fd.c          | 109 +-------
 net/9p/trans_rdma.c        | 108 +-------
 net/9p/trans_usbg.c        |   4 +-
 net/9p/trans_virtio.c      |   8 +-
 net/9p/trans_xen.c         |   4 +-
 12 files changed, 411 insertions(+), 652 deletions(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 77e9c4387c1d..07be64e73711 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -13,7 +13,8 @@
 #include <linux/fs.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
-#include <linux/parser.h>
+#include <linux/fs_parser.h>
+#include <linux/fs_context.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
 #include <net/9p/9p.h>
@@ -43,55 +44,80 @@ enum {
 	Opt_access, Opt_posixacl,
 	/* Lock timeout option */
 	Opt_locktimeout,
-	/* Error token */
-	Opt_err
+
+	/* Client options */
+	Opt_msize, Opt_trans, Opt_legacy, Opt_version,
+
+	/* fd transport options */
+	/* Options that take integer arguments */
+	Opt_rfdno, Opt_wfdno,
+	/* Options that take no arguments */
+
+	/* rdma transport options */
+	/* Options that take integer arguments */
+	Opt_rq_depth, Opt_sq_depth, Opt_timeout,
+
+	/* Options for both fd and rdma transports */
+	Opt_port, Opt_privport,
 };
 
-static const match_table_t tokens = {
-	{Opt_debug, "debug=%x"},
-	{Opt_dfltuid, "dfltuid=%u"},
-	{Opt_dfltgid, "dfltgid=%u"},
-	{Opt_afid, "afid=%u"},
-	{Opt_uname, "uname=%s"},
-	{Opt_remotename, "aname=%s"},
-	{Opt_nodevmap, "nodevmap"},
-	{Opt_noxattr, "noxattr"},
-	{Opt_directio, "directio"},
-	{Opt_ignoreqv, "ignoreqv"},
-	{Opt_cache, "cache=%s"},
-	{Opt_cachetag, "cachetag=%s"},
-	{Opt_access, "access=%s"},
-	{Opt_posixacl, "posixacl"},
-	{Opt_locktimeout, "locktimeout=%u"},
-	{Opt_err, NULL}
+static const struct constant_table p9_versions[] = {
+	{ "9p2000",	p9_proto_legacy },
+	{ "9p2000.u",	p9_proto_2000u },
+	{ "9p2000.L",	p9_proto_2000L },
+	{}
 };
 
-/* Interpret mount options for cache mode */
-static int get_cache_mode(char *s)
-{
-	int version = -EINVAL;
-
-	if (!strcmp(s, "loose")) {
-		version = CACHE_SC_LOOSE;
-		p9_debug(P9_DEBUG_9P, "Cache mode: loose\n");
-	} else if (!strcmp(s, "fscache")) {
-		version = CACHE_SC_FSCACHE;
-		p9_debug(P9_DEBUG_9P, "Cache mode: fscache\n");
-	} else if (!strcmp(s, "mmap")) {
-		version = CACHE_SC_MMAP;
-		p9_debug(P9_DEBUG_9P, "Cache mode: mmap\n");
-	} else if (!strcmp(s, "readahead")) {
-		version = CACHE_SC_READAHEAD;
-		p9_debug(P9_DEBUG_9P, "Cache mode: readahead\n");
-	} else if (!strcmp(s, "none")) {
-		version = CACHE_SC_NONE;
-		p9_debug(P9_DEBUG_9P, "Cache mode: none\n");
-	} else if (kstrtoint(s, 0, &version) != 0) {
-		version = -EINVAL;
-		pr_info("Unknown Cache mode or invalid value %s\n", s);
-	}
-	return version;
-}
+static const struct constant_table p9_cache_mode[] = {
+	{ "loose",	CACHE_SC_LOOSE },
+	{ "fscache",	CACHE_SC_FSCACHE },
+	{ "mmap",	CACHE_SC_MMAP },
+	{ "readahead",	CACHE_SC_READAHEAD },
+	{ "none",	CACHE_SC_NONE },
+	{}
+};
+
+/*
+ * This structure contains all parameters used for the core code,
+ * the client, and all the transports.
+ */
+const struct fs_parameter_spec v9fs_param_spec[] = {
+	fsparam_u32hex	("debug",	Opt_debug),
+	fsparam_uid	("dfltuid",	Opt_dfltuid),
+	fsparam_gid	("dfltgid",	Opt_dfltgid),
+	fsparam_u32	("afid",	Opt_afid),
+	fsparam_string	("uname",	Opt_uname),
+	fsparam_string	("aname",	Opt_remotename),
+	fsparam_flag	("nodevmap",	Opt_nodevmap),
+	fsparam_flag	("noxattr",	Opt_noxattr),
+	fsparam_flag	("directio",	Opt_directio),
+	fsparam_flag	("ignoreqv",	Opt_ignoreqv),
+	fsparam_enum	("cache",	Opt_cache, p9_cache_mode),
+	fsparam_string	("cachetag",	Opt_cachetag),
+	fsparam_string	("access",	Opt_access),
+	fsparam_flag	("posixacl",	Opt_posixacl),
+	fsparam_u32	("locktimeout",	Opt_locktimeout),
+
+	/* client options */
+	fsparam_u32	("msize",	Opt_msize),
+	fsparam_flag	("noextend",	Opt_legacy),
+	fsparam_string	("trans",	Opt_trans),
+	fsparam_enum	("version",	Opt_version, p9_versions),
+
+	/* fd transport options */
+	fsparam_u32	("rfdno",	Opt_rfdno),
+	fsparam_u32	("wfdno",	Opt_wfdno),
+
+	/* rdma transport options */
+	fsparam_u32	("sq",		Opt_sq_depth),
+	fsparam_u32	("rq",		Opt_rq_depth),
+	fsparam_u32	("timeout",	Opt_timeout),
+
+	/* fd and rdma transprt options */
+	fsparam_u32	("port",	Opt_port),
+	fsparam_flag	("privport",	Opt_privport),
+	{}
+};
 
 /*
  * Display the mount options in /proc/mounts.
@@ -153,267 +179,244 @@ int v9fs_show_options(struct seq_file *m, struct dentry *root)
 }
 
 /**
- * v9fs_parse_options - parse mount options into session structure
- * @v9ses: existing v9fs session information
- * @opts: The mount option string
+ * v9fs_parse_param - parse a mount option into the filesystem context
+ * @fc: the filesystem context
+ * @param: the parameter to parse
  *
  * Return 0 upon success, -ERRNO upon failure.
  */
-
-static int v9fs_parse_options(struct v9fs_session_info *v9ses, char *opts)
+int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
-	char *options, *tmp_options;
-	substring_t args[MAX_OPT_ARGS];
-	char *p;
-	int option = 0;
+	struct v9fs_context *ctx = fc->fs_private;
+	struct fs_parse_result result;
 	char *s;
-	int ret = 0;
-
-	/* setup defaults */
-	v9ses->afid = ~0;
-	v9ses->debug = 0;
-	v9ses->cache = CACHE_NONE;
-#ifdef CONFIG_9P_FSCACHE
-	v9ses->cachetag = NULL;
-#endif
-	v9ses->session_lock_timeout = P9_LOCK_TIMEOUT;
-
-	if (!opts)
-		return 0;
+	int r;
+	int opt;
+	struct p9_client_opts	*clnt = &ctx->client_opts;
+	struct p9_fd_opts	*fd_opts = &ctx->fd_opts;
+	struct p9_rdma_opts	*rdma_opts = &ctx->rdma_opts;
+	struct p9_session_opts	*session_opts = &ctx->session_opts;
+
+	opt = fs_parse(fc, v9fs_param_spec, param, &result);
+	if (opt < 0) {
+		/*
+		 * We might like to report bad mount options here, but
+		 * traditionally 9p has ignored unknown mount options
+		 */
+		if (opt == -ENOPARAM)
+			return 0;
 
-	tmp_options = kstrdup(opts, GFP_KERNEL);
-	if (!tmp_options) {
-		ret = -ENOMEM;
-		goto fail_option_alloc;
+		return opt;
 	}
-	options = tmp_options;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token, r;
-
-		if (!*p)
-			continue;
-
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_debug:
-			r = match_int(&args[0], &option);
-			if (r < 0) {
-				p9_debug(P9_DEBUG_ERROR,
-					 "integer field, but no integer?\n");
-				ret = r;
-			} else {
-				v9ses->debug = option;
+
+	switch (opt) {
+	case Opt_debug:
+		session_opts->debug = result.uint_32;
 #ifdef CONFIG_NET_9P_DEBUG
-				p9_debug_level = option;
+		p9_debug_level = result.uint_32;
 #endif
-			}
-			break;
-
-		case Opt_dfltuid:
-			r = match_int(&args[0], &option);
-			if (r < 0) {
-				p9_debug(P9_DEBUG_ERROR,
-					 "integer field, but no integer?\n");
-				ret = r;
-				continue;
-			}
-			v9ses->dfltuid = make_kuid(current_user_ns(), option);
-			if (!uid_valid(v9ses->dfltuid)) {
-				p9_debug(P9_DEBUG_ERROR,
-					 "uid field, but not a uid?\n");
-				ret = -EINVAL;
-			}
-			break;
-		case Opt_dfltgid:
-			r = match_int(&args[0], &option);
-			if (r < 0) {
-				p9_debug(P9_DEBUG_ERROR,
-					 "integer field, but no integer?\n");
-				ret = r;
-				continue;
-			}
-			v9ses->dfltgid = make_kgid(current_user_ns(), option);
-			if (!gid_valid(v9ses->dfltgid)) {
-				p9_debug(P9_DEBUG_ERROR,
-					 "gid field, but not a gid?\n");
-				ret = -EINVAL;
-			}
-			break;
-		case Opt_afid:
-			r = match_int(&args[0], &option);
-			if (r < 0) {
-				p9_debug(P9_DEBUG_ERROR,
-					 "integer field, but no integer?\n");
-				ret = r;
-			} else {
-				v9ses->afid = option;
-			}
-			break;
-		case Opt_uname:
-			kfree(v9ses->uname);
-			v9ses->uname = match_strdup(&args[0]);
-			if (!v9ses->uname) {
-				ret = -ENOMEM;
-				goto free_and_return;
-			}
-			break;
-		case Opt_remotename:
-			kfree(v9ses->aname);
-			v9ses->aname = match_strdup(&args[0]);
-			if (!v9ses->aname) {
-				ret = -ENOMEM;
-				goto free_and_return;
-			}
-			break;
-		case Opt_nodevmap:
-			v9ses->nodev = 1;
-			break;
-		case Opt_noxattr:
-			v9ses->flags |= V9FS_NO_XATTR;
-			break;
-		case Opt_directio:
-			v9ses->flags |= V9FS_DIRECT_IO;
-			break;
-		case Opt_ignoreqv:
-			v9ses->flags |= V9FS_IGNORE_QV;
-			break;
-		case Opt_cachetag:
+		break;
+
+	case Opt_dfltuid:
+		session_opts->dfltuid = result.uid;
+		break;
+	case Opt_dfltgid:
+		session_opts->dfltgid = result.gid;
+		break;
+	case Opt_afid:
+		session_opts->afid = result.uint_32;
+		break;
+	case Opt_uname:
+		kfree(session_opts->uname);
+		session_opts->uname = param->string;
+		param->string = NULL;
+		break;
+	case Opt_remotename:
+		kfree(session_opts->aname);
+		session_opts->aname = param->string;
+		param->string = NULL;
+		break;
+	case Opt_nodevmap:
+		session_opts->nodev = 1;
+		break;
+	case Opt_noxattr:
+		session_opts->flags |= V9FS_NO_XATTR;
+		break;
+	case Opt_directio:
+		session_opts->flags |= V9FS_DIRECT_IO;
+		break;
+	case Opt_ignoreqv:
+		session_opts->flags |= V9FS_IGNORE_QV;
+		break;
+	case Opt_cachetag:
 #ifdef CONFIG_9P_FSCACHE
-			kfree(v9ses->cachetag);
-			v9ses->cachetag = match_strdup(&args[0]);
-			if (!v9ses->cachetag) {
-				ret = -ENOMEM;
-				goto free_and_return;
-			}
+		kfree(session_opts->cachetag);
+		session_opts->cachetag = param->string;
+		param->string = NULL;
 #endif
-			break;
-		case Opt_cache:
-			s = match_strdup(&args[0]);
-			if (!s) {
-				ret = -ENOMEM;
-				p9_debug(P9_DEBUG_ERROR,
-					 "problem allocating copy of cache arg\n");
-				goto free_and_return;
-			}
-			r = get_cache_mode(s);
-			if (r < 0)
-				ret = r;
-			else
-				v9ses->cache = r;
-
-			kfree(s);
-			break;
-
-		case Opt_access:
-			s = match_strdup(&args[0]);
-			if (!s) {
-				ret = -ENOMEM;
-				p9_debug(P9_DEBUG_ERROR,
-					 "problem allocating copy of access arg\n");
-				goto free_and_return;
+		break;
+	case Opt_cache:
+		session_opts->cache = result.uint_32;
+		p9_debug(P9_DEBUG_9P, "Cache mode: %s\n", param->string);
+		break;
+	case Opt_access:
+		s = param->string;
+		session_opts->flags &= ~V9FS_ACCESS_MASK;
+		if (strcmp(s, "user") == 0) {
+			session_opts->flags |= V9FS_ACCESS_USER;
+		} else if (strcmp(s, "any") == 0) {
+			session_opts->flags |= V9FS_ACCESS_ANY;
+		} else if (strcmp(s, "client") == 0) {
+			session_opts->flags |= V9FS_ACCESS_CLIENT;
+		} else {
+			uid_t uid;
+
+			session_opts->flags |= V9FS_ACCESS_SINGLE;
+			r = kstrtouint(s, 10, &uid);
+			if (r) {
+				pr_info("Unknown access argument %s: %d\n",
+					param->string, r);
+				return r;
 			}
-
-			v9ses->flags &= ~V9FS_ACCESS_MASK;
-			if (strcmp(s, "user") == 0)
-				v9ses->flags |= V9FS_ACCESS_USER;
-			else if (strcmp(s, "any") == 0)
-				v9ses->flags |= V9FS_ACCESS_ANY;
-			else if (strcmp(s, "client") == 0) {
-				v9ses->flags |= V9FS_ACCESS_CLIENT;
-			} else {
-				uid_t uid;
-
-				v9ses->flags |= V9FS_ACCESS_SINGLE;
-				r = kstrtouint(s, 10, &uid);
-				if (r) {
-					ret = r;
-					pr_info("Unknown access argument %s: %d\n",
-						s, r);
-					kfree(s);
-					continue;
-				}
-				v9ses->uid = make_kuid(current_user_ns(), uid);
-				if (!uid_valid(v9ses->uid)) {
-					ret = -EINVAL;
-					pr_info("Unknown uid %s\n", s);
-				}
+			session_opts->uid = make_kuid(current_user_ns(), uid);
+			if (!uid_valid(session_opts->uid)) {
+				pr_info("Unknown uid %s\n", s);
+				return -EINVAL;
 			}
+		}
+		break;
 
-			kfree(s);
-			break;
-
-		case Opt_posixacl:
+	case Opt_posixacl:
 #ifdef CONFIG_9P_FS_POSIX_ACL
-			v9ses->flags |= V9FS_POSIX_ACL;
+		session_opts->flags |= V9FS_POSIX_ACL;
 #else
-			p9_debug(P9_DEBUG_ERROR,
-				 "Not defined CONFIG_9P_FS_POSIX_ACL. Ignoring posixacl option\n");
+		p9_debug(P9_DEBUG_ERROR,
+			 "Not defined CONFIG_9P_FS_POSIX_ACL. Ignoring posixacl option\n");
 #endif
-			break;
-
-		case Opt_locktimeout:
-			r = match_int(&args[0], &option);
-			if (r < 0) {
-				p9_debug(P9_DEBUG_ERROR,
-					 "integer field, but no integer?\n");
-				ret = r;
-				continue;
-			}
-			if (option < 1) {
-				p9_debug(P9_DEBUG_ERROR,
-					 "locktimeout must be a greater than zero integer.\n");
-				ret = -EINVAL;
-				continue;
-			}
-			v9ses->session_lock_timeout = (long)option * HZ;
-			break;
+		break;
 
-		default:
-			continue;
+	case Opt_locktimeout:
+		if (result.uint_32 < 1) {
+			p9_debug(P9_DEBUG_ERROR,
+				 "locktimeout must be a greater than zero integer.\n");
+			return -EINVAL;
+		}
+		session_opts->session_lock_timeout = (long)result.uint_32 * HZ;
+		break;
+
+	/* Options for client */
+	case Opt_msize:
+		if (result.uint_32 < 4096) {
+			p9_debug(P9_DEBUG_ERROR, "msize should be at least 4k\n");
+			return -EINVAL;
+		}
+		if (result.uint_32 > INT_MAX) {
+			p9_debug(P9_DEBUG_ERROR, "msize too big\n");
+			return -EINVAL;
 		}
+		clnt->msize = result.uint_32;
+		break;
+	case Opt_trans:
+		v9fs_put_trans(clnt->trans_mod);
+		clnt->trans_mod = v9fs_get_trans_by_name(param->string);
+		if (!clnt->trans_mod) {
+			pr_info("Could not find request transport: %s\n",
+				param->string);
+			return -EINVAL;
+		}
+		break;
+	case Opt_legacy:
+		clnt->proto_version = p9_proto_legacy;
+		break;
+	case Opt_version:
+		clnt->proto_version = result.uint_32;
+		p9_debug(P9_DEBUG_9P, "Protocol version: %s\n", param->string);
+		break;
+	/* Options for fd transport */
+	case Opt_rfdno:
+		fd_opts->rfd = result.uint_32;
+		break;
+	case Opt_wfdno:
+		fd_opts->wfd = result.uint_32;
+		break;
+	/* Options for rdma transport */
+	case Opt_sq_depth:
+		rdma_opts->sq_depth = result.uint_32;
+		break;
+	case Opt_rq_depth:
+		rdma_opts->rq_depth = result.uint_32;
+		break;
+	case Opt_timeout:
+		rdma_opts->timeout = result.uint_32;
+		break;
+	/* Options for both fd and rdma transports */
+	case Opt_port:
+		fd_opts->port = result.uint_32;
+		rdma_opts->port = result.uint_32;
+		break;
+	case Opt_privport:
+		fd_opts->privport = true;
+		rdma_opts->port = true;
+		break;
 	}
 
-free_and_return:
-	kfree(tmp_options);
-fail_option_alloc:
-	return ret;
+	return 0;
+}
+
+static void v9fs_apply_options(struct v9fs_session_info *v9ses,
+		  struct fs_context *fc)
+{
+	struct v9fs_context	*ctx = fc->fs_private;
+
+	v9ses->debug = ctx->session_opts.debug;
+	v9ses->dfltuid = ctx->session_opts.dfltuid;
+	v9ses->dfltgid = ctx->session_opts.dfltgid;
+	v9ses->afid = ctx->session_opts.afid;
+	v9ses->uname = ctx->session_opts.uname;
+	ctx->session_opts.uname = NULL;
+	v9ses->aname = ctx->session_opts.aname;
+	ctx->session_opts.aname = NULL;
+	v9ses->nodev = ctx->session_opts.nodev;
+	/*
+	 * Note that we must |= flags here as session_init already
+	 * set basic flags. This adds in flags from parsed options.
+	 */
+	v9ses->flags |= ctx->session_opts.flags;
+#ifdef CONFIG_9P_FSCACHE
+	v9ses->cachetag = ctx->session_opts.cachetag;
+	ctx->session_opts.cachetag = NULL;
+#endif
+	v9ses->cache = ctx->session_opts.cache;
+	v9ses->uid = ctx->session_opts.uid;
+	v9ses->session_lock_timeout = ctx->session_opts.session_lock_timeout;
 }
 
 /**
  * v9fs_session_init - initialize session
  * @v9ses: session information structure
- * @dev_name: device being mounted
- * @data: options
+ * @fc: the filesystem mount context
  *
  */
 
 struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
-		  const char *dev_name, char *data)
+		  struct fs_context *fc)
 {
 	struct p9_fid *fid;
 	int rc = -ENOMEM;
 
-	v9ses->uname = kstrdup(V9FS_DEFUSER, GFP_KERNEL);
-	if (!v9ses->uname)
-		goto err_names;
-
-	v9ses->aname = kstrdup(V9FS_DEFANAME, GFP_KERNEL);
-	if (!v9ses->aname)
-		goto err_names;
 	init_rwsem(&v9ses->rename_sem);
 
-	v9ses->uid = INVALID_UID;
-	v9ses->dfltuid = V9FS_DEFUID;
-	v9ses->dfltgid = V9FS_DEFGID;
-
-	v9ses->clnt = p9_client_create(dev_name, data);
+	v9ses->clnt = p9_client_create(fc);
 	if (IS_ERR(v9ses->clnt)) {
 		rc = PTR_ERR(v9ses->clnt);
 		p9_debug(P9_DEBUG_ERROR, "problem initializing 9p client\n");
 		goto err_names;
 	}
 
+	/*
+	 * Initialize flags on the real v9ses. v9fs_apply_options below
+	 * will |= the additional flags from parsed options.
+	 */
 	v9ses->flags = V9FS_ACCESS_USER;
 
 	if (p9_is_proto_dotl(v9ses->clnt)) {
@@ -423,9 +426,7 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 		v9ses->flags |= V9FS_PROTO_2000U;
 	}
 
-	rc = v9fs_parse_options(v9ses, data);
-	if (rc < 0)
-		goto err_clnt;
+	v9fs_apply_options(v9ses, fc);
 
 	v9ses->maxdata = v9ses->clnt->msize - P9_IOHDRSZ;
 
@@ -472,7 +473,7 @@ struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
 #ifdef CONFIG_9P_FSCACHE
 	/* register the session for caching */
 	if (v9ses->cache & CACHE_FSCACHE) {
-		rc = v9fs_cache_session_get_cookie(v9ses, dev_name);
+		rc = v9fs_cache_session_get_cookie(v9ses, fc->source);
 		if (rc < 0)
 			goto err_clnt;
 	}
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index f28bc763847a..6a12445d3858 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -10,6 +10,9 @@
 
 #include <linux/backing-dev.h>
 #include <linux/netfs.h>
+#include <linux/fs_parser.h>
+#include <net/9p/client.h>
+#include <net/9p/transport.h>
 
 /**
  * enum p9_session_flags - option flags for each 9P session
@@ -163,11 +166,13 @@ static inline struct fscache_volume *v9fs_session_cache(struct v9fs_session_info
 #endif
 }
 
+extern const struct fs_parameter_spec v9fs_param_spec[];
 
+extern int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param);
 extern int v9fs_show_options(struct seq_file *m, struct dentry *root);
 
 struct p9_fid *v9fs_session_init(struct v9fs_session_info *v9ses,
-				 const char *dev_name, char *data);
+				 struct fs_context *fc);
 extern void v9fs_session_close(struct v9fs_session_info *v9ses);
 extern void v9fs_session_cancel(struct v9fs_session_info *v9ses);
 extern void v9fs_session_begin_cancel(struct v9fs_session_info *v9ses);
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 1581ebac5bb4..315336de6f02 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -19,6 +19,7 @@
 #include <linux/statfs.h>
 #include <linux/magic.h>
 #include <linux/fscache.h>
+#include <linux/fs_context.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 
@@ -30,32 +31,10 @@
 
 static const struct super_operations v9fs_super_ops, v9fs_super_ops_dotl;
 
-/**
- * v9fs_set_super - set the superblock
- * @s: super block
- * @data: file system specific data
- *
- */
-
-static int v9fs_set_super(struct super_block *s, void *data)
-{
-	s->s_fs_info = data;
-	return set_anon_super(s, data);
-}
-
-/**
- * v9fs_fill_super - populate superblock with info
- * @sb: superblock
- * @v9ses: session information
- * @flags: flags propagated from v9fs_mount()
- *
- */
-
-static int
-v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
-		int flags)
+static int v9fs_fill_super(struct super_block *sb)
 {
 	int ret;
+	struct v9fs_session_info *v9ses = v9ses = sb->s_fs_info;
 
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_blocksize_bits = fls(v9ses->maxdata - 1);
@@ -95,16 +74,12 @@ v9fs_fill_super(struct super_block *sb, struct v9fs_session_info *v9ses,
 }
 
 /**
- * v9fs_mount - mount a superblock
- * @fs_type: file system type
- * @flags: mount flags
- * @dev_name: device name that was mounted
- * @data: mount options
+ * v9fs_get_tree - create the mountable root and superblock
+ * @fc: the filesystem context
  *
  */
 
-static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
-		       const char *dev_name, void *data)
+static int v9fs_get_tree(struct fs_context *fc)
 {
 	struct super_block *sb = NULL;
 	struct inode *inode = NULL;
@@ -117,20 +92,21 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 
 	v9ses = kzalloc(sizeof(struct v9fs_session_info), GFP_KERNEL);
 	if (!v9ses)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
-	fid = v9fs_session_init(v9ses, dev_name, data);
+	fid = v9fs_session_init(v9ses, fc);
 	if (IS_ERR(fid)) {
 		retval = PTR_ERR(fid);
 		goto free_session;
 	}
 
-	sb = sget(fs_type, NULL, v9fs_set_super, flags, v9ses);
+	fc->s_fs_info = v9ses;
+	sb = sget_fc(fc, NULL, set_anon_super_fc);
 	if (IS_ERR(sb)) {
 		retval = PTR_ERR(sb);
 		goto clunk_fid;
 	}
-	retval = v9fs_fill_super(sb, v9ses, flags);
+	retval = v9fs_fill_super(sb);
 	if (retval)
 		goto release_sb;
 
@@ -159,14 +135,15 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	v9fs_fid_add(root, &fid);
 
 	p9_debug(P9_DEBUG_VFS, " simple set mount, return 0\n");
-	return dget(sb->s_root);
+	fc->root = dget(sb->s_root);
+	return 0;
 
 clunk_fid:
 	p9_fid_put(fid);
 	v9fs_session_close(v9ses);
 free_session:
 	kfree(v9ses);
-	return ERR_PTR(retval);
+	return retval;
 
 release_sb:
 	/*
@@ -177,7 +154,7 @@ static struct dentry *v9fs_mount(struct file_system_type *fs_type, int flags,
 	 */
 	p9_fid_put(fid);
 	deactivate_locked_super(sb);
-	return ERR_PTR(retval);
+	return retval;
 }
 
 /**
@@ -303,11 +280,86 @@ static const struct super_operations v9fs_super_ops_dotl = {
 	.write_inode = v9fs_write_inode_dotl,
 };
 
+static void v9fs_free_fc(struct fs_context *fc)
+{
+	struct v9fs_context *ctx = fc->fs_private;
+
+	if (!ctx)
+		return;
+
+	/* These should be NULL by now but guard against leaks */
+	kfree(ctx->session_opts.uname);
+	kfree(ctx->session_opts.aname);
+#ifdef CONFIG_9P_FSCACHE
+	kfree(ctx->session_opts.cachetag);
+#endif
+	if (ctx->client_opts.trans_mod)
+		v9fs_put_trans(ctx->client_opts.trans_mod);
+	kfree(ctx);
+}
+
+static const struct fs_context_operations v9fs_context_ops = {
+	.parse_param	= v9fs_parse_param,
+	.get_tree	= v9fs_get_tree,
+	.free		= v9fs_free_fc,
+};
+
+static int v9fs_init_fs_context(struct fs_context *fc)
+{
+	struct v9fs_context	*ctx;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	/* initialize core options */
+	ctx->session_opts.afid = ~0;
+	ctx->session_opts.cache = CACHE_NONE;
+	ctx->session_opts.session_lock_timeout = P9_LOCK_TIMEOUT;
+	ctx->session_opts.uname = kstrdup(V9FS_DEFUSER, GFP_KERNEL);
+	if (!ctx->session_opts.uname)
+		goto error;
+
+	ctx->session_opts.aname = kstrdup(V9FS_DEFANAME, GFP_KERNEL);
+	if (!ctx->session_opts.aname)
+		goto error;
+
+	ctx->session_opts.uid = INVALID_UID;
+	ctx->session_opts.dfltuid = V9FS_DEFUID;
+	ctx->session_opts.dfltgid = V9FS_DEFGID;
+
+	/* initialize client options */
+	ctx->client_opts.proto_version = p9_proto_2000L;
+	ctx->client_opts.msize = DEFAULT_MSIZE;
+
+	/* initialize fd transport options */
+	ctx->fd_opts.port = P9_FD_PORT;
+	ctx->fd_opts.rfd = ~0;
+	ctx->fd_opts.wfd = ~0;
+	ctx->fd_opts.privport = false;
+
+	/* initialize rdma transport options */
+	ctx->rdma_opts.port = P9_RDMA_PORT;
+	ctx->rdma_opts.sq_depth = P9_RDMA_SQ_DEPTH;
+	ctx->rdma_opts.rq_depth = P9_RDMA_RQ_DEPTH;
+	ctx->rdma_opts.timeout = P9_RDMA_TIMEOUT;
+	ctx->rdma_opts.privport = false;
+
+	fc->ops = &v9fs_context_ops;
+	fc->fs_private = ctx;
+
+	return 0;
+error:
+	fc->need_free = 1;
+	return -ENOMEM;
+}
+
 struct file_system_type v9fs_fs_type = {
 	.name = "9p",
-	.mount = v9fs_mount,
 	.kill_sb = v9fs_kill_super,
 	.owner = THIS_MODULE,
 	.fs_flags = FS_RENAME_DOES_D_MOVE,
+	.init_fs_context = v9fs_init_fs_context,
+	.parameters = v9fs_param_spec,
 };
 MODULE_ALIAS_FS("9p");
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index cc18443f7d51..838a94218b59 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -279,7 +279,7 @@ int p9_client_rename(struct p9_fid *fid, struct p9_fid *newdirfid,
 		     const char *name);
 int p9_client_renameat(struct p9_fid *olddirfid, const char *old_name,
 		       struct p9_fid *newdirfid, const char *new_name);
-struct p9_client *p9_client_create(const char *dev_name, char *options);
+struct p9_client *p9_client_create(struct fs_context *fc);
 void p9_client_destroy(struct p9_client *clnt);
 void p9_client_disconnect(struct p9_client *clnt);
 void p9_client_begin_disconnect(struct p9_client *clnt);
diff --git a/include/net/9p/transport.h b/include/net/9p/transport.h
index ebbb4b50ee20..e53f312191b6 100644
--- a/include/net/9p/transport.h
+++ b/include/net/9p/transport.h
@@ -53,7 +53,7 @@ struct p9_trans_module {
 	int def;		/* this transport should be default */
 	struct module *owner;
 	int (*create)(struct p9_client *client,
-		      const char *devname, char *args);
+		      struct fs_context *fc);
 	void (*close)(struct p9_client *client);
 	int (*request)(struct p9_client *client, struct p9_req_t *req);
 	int (*cancel)(struct p9_client *client, struct p9_req_t *req);
diff --git a/net/9p/client.c b/net/9p/client.c
index 5e3230b1bfab..22b88596e2fe 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -20,8 +20,8 @@
 #include <linux/uio.h>
 #include <linux/netfs.h>
 #include <net/9p/9p.h>
-#include <linux/parser.h>
 #include <linux/seq_file.h>
+#include <linux/fs_context.h>
 #include <net/9p/client.h>
 #include <net/9p/transport.h>
 #include "protocol.h"
@@ -33,22 +33,6 @@
  *  - a little lazy - parse all client options
  */
 
-enum {
-	Opt_msize,
-	Opt_trans,
-	Opt_legacy,
-	Opt_version,
-	Opt_err,
-};
-
-static const match_table_t tokens = {
-	{Opt_msize, "msize=%u"},
-	{Opt_legacy, "noextend"},
-	{Opt_trans, "trans=%s"},
-	{Opt_version, "version=%s"},
-	{Opt_err, NULL},
-};
-
 inline int p9_is_proto_dotl(struct p9_client *clnt)
 {
 	return clnt->proto_version == p9_proto_2000L;
@@ -97,124 +81,16 @@ static int safe_errno(int err)
 	return err;
 }
 
-/* Interpret mount option for protocol version */
-static int get_protocol_version(char *s)
+static int apply_client_options(struct p9_client *clnt, struct fs_context *fc)
 {
-	int version = -EINVAL;
-
-	if (!strcmp(s, "9p2000")) {
-		version = p9_proto_legacy;
-		p9_debug(P9_DEBUG_9P, "Protocol version: Legacy\n");
-	} else if (!strcmp(s, "9p2000.u")) {
-		version = p9_proto_2000u;
-		p9_debug(P9_DEBUG_9P, "Protocol version: 9P2000.u\n");
-	} else if (!strcmp(s, "9p2000.L")) {
-		version = p9_proto_2000L;
-		p9_debug(P9_DEBUG_9P, "Protocol version: 9P2000.L\n");
-	} else {
-		pr_info("Unknown protocol version %s\n", s);
-	}
+	struct v9fs_context *ctx = fc->fs_private;
 
-	return version;
-}
-
-/**
- * parse_opts - parse mount options into client structure
- * @opts: options string passed from mount
- * @clnt: existing v9fs client information
- *
- * Return 0 upon success, -ERRNO upon failure
- */
-
-static int parse_opts(char *opts, struct p9_client *clnt)
-{
-	char *options, *tmp_options;
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-	char *s;
-	int ret = 0;
-
-	clnt->proto_version = p9_proto_2000L;
-	clnt->msize = DEFAULT_MSIZE;
-
-	if (!opts)
-		return 0;
+	clnt->msize = ctx->client_opts.msize;
+	clnt->trans_mod = ctx->client_opts.trans_mod;
+	ctx->client_opts.trans_mod = NULL;
+	clnt->proto_version = ctx->client_opts.proto_version;
 
-	tmp_options = kstrdup(opts, GFP_KERNEL);
-	if (!tmp_options)
-		return -ENOMEM;
-	options = tmp_options;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token, r;
-
-		if (!*p)
-			continue;
-		token = match_token(p, tokens, args);
-		switch (token) {
-		case Opt_msize:
-			r = match_int(&args[0], &option);
-			if (r < 0) {
-				p9_debug(P9_DEBUG_ERROR,
-					 "integer field, but no integer?\n");
-				ret = r;
-				continue;
-			}
-			if (option < 4096) {
-				p9_debug(P9_DEBUG_ERROR,
-					 "msize should be at least 4k\n");
-				ret = -EINVAL;
-				continue;
-			}
-			clnt->msize = option;
-			break;
-		case Opt_trans:
-			s = match_strdup(&args[0]);
-			if (!s) {
-				ret = -ENOMEM;
-				p9_debug(P9_DEBUG_ERROR,
-					 "problem allocating copy of trans arg\n");
-				goto free_and_return;
-			}
-
-			v9fs_put_trans(clnt->trans_mod);
-			clnt->trans_mod = v9fs_get_trans_by_name(s);
-			if (!clnt->trans_mod) {
-				pr_info("Could not find request transport: %s\n",
-					s);
-				ret = -EINVAL;
-			}
-			kfree(s);
-			break;
-		case Opt_legacy:
-			clnt->proto_version = p9_proto_legacy;
-			break;
-		case Opt_version:
-			s = match_strdup(&args[0]);
-			if (!s) {
-				ret = -ENOMEM;
-				p9_debug(P9_DEBUG_ERROR,
-					 "problem allocating copy of version arg\n");
-				goto free_and_return;
-			}
-			r = get_protocol_version(s);
-			if (r < 0)
-				ret = r;
-			else
-				clnt->proto_version = r;
-			kfree(s);
-			break;
-		default:
-			continue;
-		}
-	}
-
-free_and_return:
-	if (ret)
-		v9fs_put_trans(clnt->trans_mod);
-	kfree(tmp_options);
-	return ret;
+	return 0;
 }
 
 static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
@@ -968,7 +844,7 @@ static int p9_client_version(struct p9_client *c)
 	return err;
 }
 
-struct p9_client *p9_client_create(const char *dev_name, char *options)
+struct p9_client *p9_client_create(struct fs_context *fc)
 {
 	int err;
 	static atomic_t seqno = ATOMIC_INIT(0);
@@ -991,8 +867,8 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	idr_init(&clnt->fids);
 	idr_init(&clnt->reqs);
 
-	err = parse_opts(options, clnt);
-	if (err < 0)
+	err = apply_client_options(clnt, fc);
+	if (err)
 		goto free_client;
 
 	if (!clnt->trans_mod)
@@ -1008,7 +884,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	p9_debug(P9_DEBUG_MUX, "clnt %p trans %p msize %d protocol %d\n",
 		 clnt, clnt->trans_mod, clnt->msize, clnt->proto_version);
 
-	err = clnt->trans_mod->create(clnt, dev_name, options);
+	err = clnt->trans_mod->create(clnt, fc);
 	if (err)
 		goto put_trans;
 
diff --git a/net/9p/mod.c b/net/9p/mod.c
index 55576c1866fa..85160b52da55 100644
--- a/net/9p/mod.c
+++ b/net/9p/mod.c
@@ -16,7 +16,6 @@
 #include <linux/moduleparam.h>
 #include <net/9p/9p.h>
 #include <linux/fs.h>
-#include <linux/parser.h>
 #include <net/9p/client.h>
 #include <net/9p/transport.h>
 #include <linux/list.h>
@@ -171,6 +170,7 @@ void v9fs_put_trans(struct p9_trans_module *m)
 	if (m)
 		module_put(m->owner);
 }
+EXPORT_SYMBOL(v9fs_put_trans);
 
 /**
  * init_p9 - Initialize module
diff --git a/net/9p/trans_fd.c b/net/9p/trans_fd.c
index 9ef4f2e0db3c..cb4398d79b0a 100644
--- a/net/9p/trans_fd.c
+++ b/net/9p/trans_fd.c
@@ -22,7 +22,7 @@
 #include <linux/uaccess.h>
 #include <linux/inet.h>
 #include <linux/file.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
 #include <net/9p/9p.h>
@@ -37,26 +37,6 @@
 static struct p9_trans_module p9_tcp_trans;
 static struct p9_trans_module p9_fd_trans;
 
-/*
-  * Option Parsing (code inspired by NFS code)
-  *  - a little lazy - parse all fd-transport options
-  */
-
-enum {
-	/* Options that take integer arguments */
-	Opt_port, Opt_rfdno, Opt_wfdno, Opt_err,
-	/* Options that take no arguments */
-	Opt_privport,
-};
-
-static const match_table_t tokens = {
-	{Opt_port, "port=%u"},
-	{Opt_rfdno, "rfdno=%u"},
-	{Opt_wfdno, "wfdno=%u"},
-	{Opt_privport, "privport"},
-	{Opt_err, NULL},
-};
-
 enum {
 	Rworksched = 1,		/* read work scheduled or running */
 	Rpending = 2,		/* can read */
@@ -744,73 +724,6 @@ static int p9_fd_show_options(struct seq_file *m, struct p9_client *clnt)
 	return 0;
 }
 
-/**
- * parse_opts - parse mount options into p9_fd_opts structure
- * @params: options string passed from mount
- * @opts: fd transport-specific structure to parse options into
- *
- * Returns 0 upon success, -ERRNO upon failure
- */
-
-static int parse_opts(char *params, struct p9_fd_opts *opts)
-{
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-	char *options, *tmp_options;
-
-	opts->port = P9_FD_PORT;
-	opts->rfd = ~0;
-	opts->wfd = ~0;
-	opts->privport = false;
-
-	if (!params)
-		return 0;
-
-	tmp_options = kstrdup(params, GFP_KERNEL);
-	if (!tmp_options) {
-		p9_debug(P9_DEBUG_ERROR,
-			 "failed to allocate copy of option string\n");
-		return -ENOMEM;
-	}
-	options = tmp_options;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
-		int r;
-		if (!*p)
-			continue;
-		token = match_token(p, tokens, args);
-		if ((token != Opt_err) && (token != Opt_privport)) {
-			r = match_int(&args[0], &option);
-			if (r < 0) {
-				p9_debug(P9_DEBUG_ERROR,
-					 "integer field, but no integer?\n");
-				continue;
-			}
-		}
-		switch (token) {
-		case Opt_port:
-			opts->port = option;
-			break;
-		case Opt_rfdno:
-			opts->rfd = option;
-			break;
-		case Opt_wfdno:
-			opts->wfd = option;
-			break;
-		case Opt_privport:
-			opts->privport = true;
-			break;
-		default:
-			continue;
-		}
-	}
-
-	kfree(tmp_options);
-	return 0;
-}
-
 static int p9_fd_open(struct p9_client *client, int rfd, int wfd)
 {
 	struct p9_trans_fd *ts = kzalloc(sizeof(struct p9_trans_fd),
@@ -965,17 +878,18 @@ static int p9_bind_privport(struct socket *sock)
 }
 
 static int
-p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
+p9_fd_create_tcp(struct p9_client *client, struct fs_context *fc)
 {
+	const char *addr = fc->source;
+	struct v9fs_context *ctx = fc->fs_private;
 	int err;
 	char port_str[6];
 	struct socket *csocket;
 	struct sockaddr_storage stor = { 0 };
 	struct p9_fd_opts opts;
 
-	err = parse_opts(args, &opts);
-	if (err < 0)
-		return err;
+	/* opts are already parsed in context */
+	opts = ctx->fd_opts;
 
 	if (!addr)
 		return -EINVAL;
@@ -1022,8 +936,9 @@ p9_fd_create_tcp(struct p9_client *client, const char *addr, char *args)
 }
 
 static int
-p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
+p9_fd_create_unix(struct p9_client *client, struct fs_context *fc)
 {
+	const char *addr = fc->source;
 	int err;
 	struct socket *csocket;
 	struct sockaddr_un sun_server;
@@ -1062,14 +977,12 @@ p9_fd_create_unix(struct p9_client *client, const char *addr, char *args)
 }
 
 static int
-p9_fd_create(struct p9_client *client, const char *addr, char *args)
+p9_fd_create(struct p9_client *client, struct fs_context *fc)
 {
+	struct v9fs_context *ctx = fc->fs_private;
+	struct p9_fd_opts opts = ctx->fd_opts;
 	int err;
-	struct p9_fd_opts opts;
 
-	err = parse_opts(args, &opts);
-	if (err < 0)
-		return err;
 	client->trans_opts.fd.rfd = opts.rfd;
 	client->trans_opts.fd.wfd = opts.wfd;
 
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index 46ee37061faf..fa3365990fdf 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -22,7 +22,7 @@
 #include <linux/uaccess.h>
 #include <linux/inet.h>
 #include <linux/file.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
 #include <linux/semaphore.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
@@ -106,26 +106,6 @@ struct p9_rdma_context {
 	};
 };
 
-/*
- * Option Parsing (code inspired by NFS code)
- */
-enum {
-	/* Options that take integer arguments */
-	Opt_port, Opt_rq_depth, Opt_sq_depth, Opt_timeout,
-	/* Options that take no argument */
-	Opt_privport,
-	Opt_err,
-};
-
-static match_table_t tokens = {
-	{Opt_port, "port=%u"},
-	{Opt_sq_depth, "sq=%u"},
-	{Opt_rq_depth, "rq=%u"},
-	{Opt_timeout, "timeout=%u"},
-	{Opt_privport, "privport"},
-	{Opt_err, NULL},
-};
-
 static int p9_rdma_show_options(struct seq_file *m, struct p9_client *clnt)
 {
 	struct p9_trans_rdma *rdma = clnt->trans;
@@ -143,77 +123,6 @@ static int p9_rdma_show_options(struct seq_file *m, struct p9_client *clnt)
 	return 0;
 }
 
-/**
- * parse_opts - parse mount options into rdma options structure
- * @params: options string passed from mount
- * @opts: rdma transport-specific structure to parse options into
- *
- * Returns 0 upon success, -ERRNO upon failure
- */
-static int parse_opts(char *params, struct p9_rdma_opts *opts)
-{
-	char *p;
-	substring_t args[MAX_OPT_ARGS];
-	int option;
-	char *options, *tmp_options;
-
-	opts->port = P9_RDMA_PORT;
-	opts->sq_depth = P9_RDMA_SQ_DEPTH;
-	opts->rq_depth = P9_RDMA_RQ_DEPTH;
-	opts->timeout = P9_RDMA_TIMEOUT;
-	opts->privport = false;
-
-	if (!params)
-		return 0;
-
-	tmp_options = kstrdup(params, GFP_KERNEL);
-	if (!tmp_options) {
-		p9_debug(P9_DEBUG_ERROR,
-			 "failed to allocate copy of option string\n");
-		return -ENOMEM;
-	}
-	options = tmp_options;
-
-	while ((p = strsep(&options, ",")) != NULL) {
-		int token;
-		int r;
-		if (!*p)
-			continue;
-		token = match_token(p, tokens, args);
-		if ((token != Opt_err) && (token != Opt_privport)) {
-			r = match_int(&args[0], &option);
-			if (r < 0) {
-				p9_debug(P9_DEBUG_ERROR,
-					 "integer field, but no integer?\n");
-				continue;
-			}
-		}
-		switch (token) {
-		case Opt_port:
-			opts->port = option;
-			break;
-		case Opt_sq_depth:
-			opts->sq_depth = option;
-			break;
-		case Opt_rq_depth:
-			opts->rq_depth = option;
-			break;
-		case Opt_timeout:
-			opts->timeout = option;
-			break;
-		case Opt_privport:
-			opts->privport = true;
-			break;
-		default:
-			continue;
-		}
-	}
-	/* RQ must be at least as large as the SQ */
-	opts->rq_depth = max(opts->rq_depth, opts->sq_depth);
-	kfree(tmp_options);
-	return 0;
-}
-
 static int
 p9_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 {
@@ -607,14 +516,15 @@ static int p9_rdma_bind_privport(struct p9_trans_rdma *rdma)
 /**
  * rdma_create_trans - Transport method for creating a transport instance
  * @client: client instance
- * @addr: IP address string
- * @args: Mount options string
+ * @fc: The filesystem context
  */
 static int
-rdma_create_trans(struct p9_client *client, const char *addr, char *args)
+rdma_create_trans(struct p9_client *client, struct fs_context *fc)
 {
+	const char *addr = fc->source;
+	struct v9fs_context *ctx = fc->fs_private;
+	struct p9_rdma_opts opts = ctx->rdma_opts;
 	int err;
-	struct p9_rdma_opts opts;
 	struct p9_trans_rdma *rdma;
 	struct rdma_conn_param conn_param;
 	struct ib_qp_init_attr qp_attr;
@@ -622,10 +532,8 @@ rdma_create_trans(struct p9_client *client, const char *addr, char *args)
 	if (addr == NULL)
 		return -EINVAL;
 
-	/* Parse the transport specific mount options */
-	err = parse_opts(args, &opts);
-	if (err < 0)
-		return err;
+	/* options are already parsed, in the fs context */
+	opts = ctx->rdma_opts;
 
 	/* Create and initialize the RDMA transport structure */
 	rdma = alloc_rdma(&opts);
diff --git a/net/9p/trans_usbg.c b/net/9p/trans_usbg.c
index 6b694f117aef..61197dae52cb 100644
--- a/net/9p/trans_usbg.c
+++ b/net/9p/trans_usbg.c
@@ -27,6 +27,7 @@
 #include <linux/cleanup.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/fs_context.h>
 #include <linux/usb/composite.h>
 #include <linux/usb/func_utils.h>
 
@@ -366,8 +367,9 @@ enable_usb9pfs(struct usb_composite_dev *cdev, struct f_usb9pfs *usb9pfs)
 	return ret;
 }
 
-static int p9_usbg_create(struct p9_client *client, const char *devname, char *args)
+static int p9_usbg_create(struct p9_client *client, struct fs_context *fc)
 {
+	const char *devname = fc->source;
 	struct f_usb9pfs_dev *dev;
 	struct f_usb9pfs *usb9pfs;
 	int ret = -ENOENT;
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 0b8086f58ad5..580d74ca92b0 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -26,7 +26,7 @@
 #include <linux/highmem.h>
 #include <linux/slab.h>
 #include <net/9p/9p.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
 #include <net/9p/client.h>
 #include <net/9p/transport.h>
 #include <linux/scatterlist.h>
@@ -679,8 +679,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 /**
  * p9_virtio_create - allocate a new virtio channel
  * @client: client instance invoking this transport
- * @devname: string identifying the channel to connect to (unused)
- * @args: args passed from sys_mount() for per-transport options (unused)
+ * @fc: the filesystem context
  *
  * This sets up a transport channel for 9p communication.  Right now
  * we only match the first available channel, but eventually we could look up
@@ -691,8 +690,9 @@ static int p9_virtio_probe(struct virtio_device *vdev)
  */
 
 static int
-p9_virtio_create(struct p9_client *client, const char *devname, char *args)
+p9_virtio_create(struct p9_client *client, struct fs_context *fc)
 {
+	const char *devname = fc->source;
 	struct virtio_chan *chan;
 	int ret = -ENOENT;
 	int found = 0;
diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index b9ff69c7522a..091a99eb51f4 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -15,6 +15,7 @@
 
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/fs_context.h>
 #include <net/9p/9p.h>
 #include <net/9p/client.h>
 #include <net/9p/transport.h>
@@ -66,8 +67,9 @@ static int p9_xen_cancel(struct p9_client *client, struct p9_req_t *req)
 	return 1;
 }
 
-static int p9_xen_create(struct p9_client *client, const char *addr, char *args)
+static int p9_xen_create(struct p9_client *client, struct fs_context *fc)
 {
+	const char *addr = fc->source;
 	struct xen_9pfs_front_priv *priv;
 
 	if (addr == NULL)
-- 
2.51.0


