Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E357AABB7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2019 21:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbfIETGD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Sep 2019 15:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728377AbfIETGC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Sep 2019 15:06:02 -0400
Received: from tleilax.poochiereds.net.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A63FE206BA;
        Thu,  5 Sep 2019 19:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567710361;
        bh=UyMQNeioSqSoRP48It906In8AfLD8xp/D2+E2SBEArc=;
        h=From:To:Cc:Subject:Date:From;
        b=ZKnJnvuOUcZQKhu1LyXtxkevh87WUT2/fciQBqFZ1uxxh9NpWgxhp8HhwtVAEkQUR
         jwhg1JGnH52UN2cpRvYxROhmUw9VGMRCLbnQWgbkPE/5OrBKVLLYxl/e4UExHCPnwy
         NtLtUi0Efd3tByy4sy5yMiD1Oz5JnpR1dVvpbo30=
From:   Jeff Layton <jlayton@kernel.org>
To:     dhowells@redhat.com, viro@zeniv.linux.org.uk, idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        zyan@redhat.com
Subject: [PATCH v2] ceph: Convert ceph to use the new mount API
Date:   Thu,  5 Sep 2019 15:05:58 -0400
Message-Id: <20190905190558.25717-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Convert the ceph filesystem to the new internal mount API as the old
one will be obsoleted and removed.  This allows greater flexibility in
communication of mount parameters between userspace, the VFS and the
filesystem.

See Documentation/filesystems/mount_api.txt for more information.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: Sage Weil <sage@redhat.com>
cc: ceph-devel@vger.kernel.org
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/block/rbd.c          | 341 ++++++++---------
 fs/ceph/cache.c              |  10 +-
 fs/ceph/cache.h              |   5 +-
 fs/ceph/super.c              | 687 +++++++++++++++++------------------
 fs/ceph/super.h              |   1 -
 include/linux/ceph/libceph.h |  17 +-
 net/ceph/ceph_common.c       | 410 +++++++++------------
 7 files changed, 715 insertions(+), 756 deletions(-)

v2: fix several string parsing bugs in rbd_add_parse_args and rbd_parse_monolithic
    prefix rbd log message with "rbd:"
    drop unneeded #undef from ceph_debug.h
    drop unrelated comment fixes in fs/fs_*.c
    rebase onto current ceph/testing branch

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c3df76a862d2..cfd9e86aafc0 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -34,7 +34,7 @@
 #include <linux/ceph/cls_lock_client.h>
 #include <linux/ceph/striper.h>
 #include <linux/ceph/decode.h>
-#include <linux/parser.h>
+#include <linux/fs_parser.h>
 #include <linux/bsearch.h>
 
 #include <linux/kernel.h>
@@ -823,34 +823,12 @@ enum {
 	Opt_queue_depth,
 	Opt_alloc_size,
 	Opt_lock_timeout,
-	Opt_last_int,
-	/* int args above */
 	Opt_pool_ns,
-	Opt_last_string,
-	/* string args above */
 	Opt_read_only,
 	Opt_read_write,
 	Opt_lock_on_read,
 	Opt_exclusive,
 	Opt_notrim,
-	Opt_err
-};
-
-static match_table_t rbd_opts_tokens = {
-	{Opt_queue_depth, "queue_depth=%d"},
-	{Opt_alloc_size, "alloc_size=%d"},
-	{Opt_lock_timeout, "lock_timeout=%d"},
-	/* int args above */
-	{Opt_pool_ns, "_pool_ns=%s"},
-	/* string args above */
-	{Opt_read_only, "read_only"},
-	{Opt_read_only, "ro"},		/* Alternate spelling */
-	{Opt_read_write, "read_write"},
-	{Opt_read_write, "rw"},		/* Alternate spelling */
-	{Opt_lock_on_read, "lock_on_read"},
-	{Opt_exclusive, "exclusive"},
-	{Opt_notrim, "notrim"},
-	{Opt_err, NULL}
 };
 
 struct rbd_options {
@@ -871,85 +849,86 @@ struct rbd_options {
 #define RBD_EXCLUSIVE_DEFAULT	false
 #define RBD_TRIM_DEFAULT	true
 
-struct parse_rbd_opts_ctx {
-	struct rbd_spec		*spec;
-	struct rbd_options	*opts;
+static const struct fs_parameter_spec rbd_param_specs[] = {
+	fsparam_u32	("alloc_size",			Opt_alloc_size),
+	fsparam_flag	("exclusive",			Opt_exclusive),
+	fsparam_flag	("lock_on_read",		Opt_lock_on_read),
+	fsparam_u32	("lock_timeout",		Opt_lock_timeout),
+	fsparam_flag	("notrim",			Opt_notrim),
+	fsparam_string	("_pool_ns",			Opt_pool_ns),
+	fsparam_u32	("queue_depth",			Opt_queue_depth),
+	fsparam_flag	("ro",				Opt_read_only),
+	fsparam_flag	("rw",				Opt_read_write),
+	{}
+};
+
+static const struct fs_parameter_description rbd_parameters = {
+	.name		= "rbd",
+	.specs		= rbd_param_specs,
 };
 
-static int parse_rbd_opts_token(char *c, void *private)
+static int rbd_parse_param(struct ceph_config_context *ctx, struct fs_parameter *param)
 {
-	struct parse_rbd_opts_ctx *pctx = private;
-	substring_t argstr[MAX_OPT_ARGS];
-	int token, intval, ret;
+	struct rbd_options *opts = ctx->rbd_opts;
+	struct rbd_spec *spec = ctx->rbd_spec;
+	struct fs_parse_result result;
+	int ret, opt;
 
-	token = match_token(c, rbd_opts_tokens, argstr);
-	if (token < Opt_last_int) {
-		ret = match_int(&argstr[0], &intval);
-		if (ret < 0) {
-			pr_err("bad option arg (not int) at '%s'\n", c);
-			return ret;
-		}
-		dout("got int token %d val %d\n", token, intval);
-	} else if (token > Opt_last_int && token < Opt_last_string) {
-		dout("got string token %d val %s\n", token, argstr[0].from);
-	} else {
-		dout("got token %d\n", token);
-	}
+	ret = ceph_parse_option(ctx->opt, NULL, param);
+	if (ret != -ENOPARAM)
+		return ret;
 
-	switch (token) {
+	opt = fs_parse(NULL, &rbd_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
 	case Opt_queue_depth:
-		if (intval < 1) {
-			pr_err("queue_depth out of range\n");
-			return -EINVAL;
-		}
-		pctx->opts->queue_depth = intval;
+		if (result.uint_32 < 1)
+			goto out_of_range;
+		opts->queue_depth = result.uint_32;
 		break;
 	case Opt_alloc_size:
-		if (intval < SECTOR_SIZE) {
-			pr_err("alloc_size out of range\n");
-			return -EINVAL;
-		}
-		if (!is_power_of_2(intval)) {
-			pr_err("alloc_size must be a power of 2\n");
-			return -EINVAL;
-		}
-		pctx->opts->alloc_size = intval;
+		if (result.uint_32 < SECTOR_SIZE)
+			goto out_of_range;
+		if (!is_power_of_2(result.uint_32))
+			return invalf(NULL, "alloc_size must be a power of 2\n");
+		opts->alloc_size = result.uint_32;
 		break;
 	case Opt_lock_timeout:
 		/* 0 is "wait forever" (i.e. infinite timeout) */
-		if (intval < 0 || intval > INT_MAX / 1000) {
-			pr_err("lock_timeout out of range\n");
-			return -EINVAL;
-		}
-		pctx->opts->lock_timeout = msecs_to_jiffies(intval * 1000);
+		if (result.uint_32 > INT_MAX / 1000)
+			goto out_of_range;
+		opts->lock_timeout = msecs_to_jiffies(result.uint_32 * 1000);
 		break;
 	case Opt_pool_ns:
-		kfree(pctx->spec->pool_ns);
-		pctx->spec->pool_ns = match_strdup(argstr);
-		if (!pctx->spec->pool_ns)
-			return -ENOMEM;
+		kfree(spec->pool_ns);
+		spec->pool_ns = param->string;
+		param->string = NULL;
 		break;
 	case Opt_read_only:
-		pctx->opts->read_only = true;
+		opts->read_only = true;
 		break;
 	case Opt_read_write:
-		pctx->opts->read_only = false;
+		opts->read_only = false;
 		break;
 	case Opt_lock_on_read:
-		pctx->opts->lock_on_read = true;
+		opts->lock_on_read = true;
 		break;
 	case Opt_exclusive:
-		pctx->opts->exclusive = true;
+		opts->exclusive = true;
 		break;
 	case Opt_notrim:
-		pctx->opts->trim = false;
+		opts->trim = false;
 		break;
 	default:
-		/* libceph prints "bad option" msg */
 		return -EINVAL;
 	}
 
 	return 0;
+
+out_of_range:
+	return invalf(NULL, "rbd: %s out of range", param->key);
 }
 
 static char* obj_op_name(enum obj_operation_type op_type)
@@ -6438,22 +6417,82 @@ static inline size_t next_token(const char **buf)
  *
  * Note: uses GFP_KERNEL for allocation.
  */
-static inline char *dup_token(const char **buf, size_t *lenp)
+static inline char *dup_token(const char **buf)
 {
 	char *dup;
 	size_t len;
 
 	len = next_token(buf);
-	dup = kmemdup(*buf, len + 1, GFP_KERNEL);
-	if (!dup)
-		return NULL;
-	*(dup + len) = '\0';
-	*buf += len;
+	dup = kmemdup_nul(*buf, len, GFP_KERNEL);
+	if (dup)
+		*buf += len;
+	return dup;
+}
+
+/*
+ * Parse the parameter string.
+ */
+static int rbd_parse_monolithic(struct ceph_config_context *ctx, size_t len,
+				const char *data)
+{
+	const char *sep, *key, *eq, *value;
+	char key_buf[32];
+	size_t size, klen;
+	int ret = 0;
 
-	if (lenp)
-		*lenp = len;
+	struct fs_parameter param = {
+		.key	= key_buf,
+		.type	= fs_value_is_string,
+	};
 
-	return dup;
+	do {
+		key = data;
+		sep = strchr(data, ',');
+		if (sep) {
+			data = sep + 1;
+			size = sep - key;
+		} else {
+			data = NULL;
+			size = len;
+		}
+
+		len -= size;
+		if (!size)
+			continue;
+
+		eq = memchr(key, '=', size);
+		if (eq) {
+			klen = eq - key;
+			if (klen == 0)
+				return invalf(NULL, "Invalid option \"\"");
+			value = eq + 1;
+			param.size = size - klen - 1;
+		} else {
+			klen = size;
+			value = NULL;
+			param.size = 0;
+		}
+
+		if (klen >= sizeof(key_buf))
+			return invalf(NULL, "Unknown option %*.*s",
+				      (int)klen, (int)klen, key);
+		memcpy(key_buf, key, klen);
+		key_buf[klen] = 0;
+
+		if (param.size > 0) {
+			param.string = kmemdup_nul(value, param.size,
+						   GFP_KERNEL);
+			if (!param.string)
+				return -ENOMEM;
+		}
+
+		ret = rbd_parse_param(ctx, &param);
+		kfree(param.string);
+		if (ret < 0)
+			break;
+	} while (data);
+
+	return ret;
 }
 
 /*
@@ -6497,18 +6536,11 @@ static inline char *dup_token(const char **buf, size_t *lenp)
  *      created.  The image head is used if no snapshot id is
  *      provided.  Snapshot mappings are always read-only.
  */
-static int rbd_add_parse_args(const char *buf,
-				struct ceph_options **ceph_opts,
-				struct rbd_options **opts,
-				struct rbd_spec **rbd_spec)
+static int rbd_add_parse_args(const char *buf, struct ceph_config_context *ctx)
 {
-	size_t len;
-	char *options;
-	const char *mon_addrs;
+	const char *options, *mon_addrs;
+	size_t len, options_len, mon_addrs_size;
 	char *snap_name;
-	size_t mon_addrs_size;
-	struct parse_rbd_opts_ctx pctx = { 0 };
-	struct ceph_options *copts;
 	int ret;
 
 	/* The first four tokens are required */
@@ -6519,36 +6551,35 @@ static int rbd_add_parse_args(const char *buf,
 		return -EINVAL;
 	}
 	mon_addrs = buf;
-	mon_addrs_size = len + 1;
+	mon_addrs_size = len;
 	buf += len;
 
-	ret = -EINVAL;
-	options = dup_token(&buf, NULL);
-	if (!options)
-		return -ENOMEM;
-	if (!*options) {
+	options_len = next_token(&buf);
+	if (options_len == 0) {
 		rbd_warn(NULL, "no options provided");
-		goto out_err;
+		return -EINVAL;
 	}
+	options = buf;
+	buf += options_len;
 
-	pctx.spec = rbd_spec_alloc();
-	if (!pctx.spec)
-		goto out_mem;
+	ctx->rbd_spec = rbd_spec_alloc();
+	if (!ctx->rbd_spec)
+		return -ENOMEM;
 
-	pctx.spec->pool_name = dup_token(&buf, NULL);
-	if (!pctx.spec->pool_name)
-		goto out_mem;
-	if (!*pctx.spec->pool_name) {
+	ctx->rbd_spec->pool_name = dup_token(&buf);
+	if (!ctx->rbd_spec->pool_name)
+		return -ENOMEM;
+	if (!*ctx->rbd_spec->pool_name) {
 		rbd_warn(NULL, "no pool name provided");
-		goto out_err;
+		return -EINVAL;
 	}
 
-	pctx.spec->image_name = dup_token(&buf, NULL);
-	if (!pctx.spec->image_name)
-		goto out_mem;
-	if (!*pctx.spec->image_name) {
+	ctx->rbd_spec->image_name = dup_token(&buf);
+	if (!ctx->rbd_spec->image_name)
+		return -ENOMEM;
+	if (!*ctx->rbd_spec->image_name) {
 		rbd_warn(NULL, "no image name provided");
-		goto out_err;
+		return -EINVAL;
 	}
 
 	/*
@@ -6560,51 +6591,37 @@ static int rbd_add_parse_args(const char *buf,
 		buf = RBD_SNAP_HEAD_NAME; /* No snapshot supplied */
 		len = sizeof (RBD_SNAP_HEAD_NAME) - 1;
 	} else if (len > RBD_MAX_SNAP_NAME_LEN) {
-		ret = -ENAMETOOLONG;
-		goto out_err;
+		return -ENAMETOOLONG;
 	}
-	snap_name = kmemdup(buf, len + 1, GFP_KERNEL);
+
+	snap_name = kmemdup_nul(buf, len, GFP_KERNEL);
 	if (!snap_name)
-		goto out_mem;
-	*(snap_name + len) = '\0';
-	pctx.spec->snap_name = snap_name;
+		return -ENOMEM;
+	ctx->rbd_spec->snap_name = snap_name;
 
 	/* Initialize all rbd options to the defaults */
 
-	pctx.opts = kzalloc(sizeof(*pctx.opts), GFP_KERNEL);
-	if (!pctx.opts)
-		goto out_mem;
-
-	pctx.opts->read_only = RBD_READ_ONLY_DEFAULT;
-	pctx.opts->queue_depth = RBD_QUEUE_DEPTH_DEFAULT;
-	pctx.opts->alloc_size = RBD_ALLOC_SIZE_DEFAULT;
-	pctx.opts->lock_timeout = RBD_LOCK_TIMEOUT_DEFAULT;
-	pctx.opts->lock_on_read = RBD_LOCK_ON_READ_DEFAULT;
-	pctx.opts->exclusive = RBD_EXCLUSIVE_DEFAULT;
-	pctx.opts->trim = RBD_TRIM_DEFAULT;
-
-	copts = ceph_parse_options(options, mon_addrs,
-				   mon_addrs + mon_addrs_size - 1,
-				   parse_rbd_opts_token, &pctx);
-	if (IS_ERR(copts)) {
-		ret = PTR_ERR(copts);
-		goto out_err;
-	}
-	kfree(options);
+	ctx->rbd_opts = kzalloc(sizeof(*ctx->rbd_opts), GFP_KERNEL);
+	if (!ctx->rbd_opts)
+		return -ENOMEM;
 
-	*ceph_opts = copts;
-	*opts = pctx.opts;
-	*rbd_spec = pctx.spec;
+	ctx->rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;
+	ctx->rbd_opts->queue_depth = RBD_QUEUE_DEPTH_DEFAULT;
+	ctx->rbd_opts->alloc_size = RBD_ALLOC_SIZE_DEFAULT;
+	ctx->rbd_opts->lock_timeout = RBD_LOCK_TIMEOUT_DEFAULT;
+	ctx->rbd_opts->lock_on_read = RBD_LOCK_ON_READ_DEFAULT;
+	ctx->rbd_opts->exclusive = RBD_EXCLUSIVE_DEFAULT;
+	ctx->rbd_opts->trim = RBD_TRIM_DEFAULT;
 
-	return 0;
-out_mem:
-	ret = -ENOMEM;
-out_err:
-	kfree(pctx.opts);
-	rbd_spec_put(pctx.spec);
-	kfree(options);
+	ctx->opt = ceph_alloc_options();
+	if (!ctx->opt)
+		return -ENOMEM;
 
-	return ret;
+	ret = ceph_parse_server_specs(ctx->opt, NULL, mon_addrs, mon_addrs_size);
+	if (ret < 0)
+		return ret;
+
+	return rbd_parse_monolithic(ctx, options_len, options);
 }
 
 static void rbd_dev_image_unlock(struct rbd_device *rbd_dev)
@@ -7037,10 +7054,8 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 			  const char *buf,
 			  size_t count)
 {
+	struct ceph_config_context ctx = {};
 	struct rbd_device *rbd_dev = NULL;
-	struct ceph_options *ceph_opts = NULL;
-	struct rbd_options *rbd_opts = NULL;
-	struct rbd_spec *spec = NULL;
 	struct rbd_client *rbdc;
 	int rc;
 
@@ -7048,33 +7063,34 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 		return -ENODEV;
 
 	/* parse add command */
-	rc = rbd_add_parse_args(buf, &ceph_opts, &rbd_opts, &spec);
+	rc = rbd_add_parse_args(buf, &ctx);
 	if (rc < 0)
 		goto out;
 
-	rbdc = rbd_get_client(ceph_opts);
+	rbdc = rbd_get_client(ctx.opt);
 	if (IS_ERR(rbdc)) {
 		rc = PTR_ERR(rbdc);
 		goto err_out_args;
 	}
 
 	/* pick the pool */
-	rc = ceph_pg_poolid_by_name(rbdc->client->osdc.osdmap, spec->pool_name);
+	rc = ceph_pg_poolid_by_name(rbdc->client->osdc.osdmap,
+				    ctx.rbd_spec->pool_name);
 	if (rc < 0) {
 		if (rc == -ENOENT)
-			pr_info("pool %s does not exist\n", spec->pool_name);
+			pr_info("pool %s does not exist\n", ctx.rbd_spec->pool_name);
 		goto err_out_client;
 	}
-	spec->pool_id = (u64)rc;
+	ctx.rbd_spec->pool_id = (u64)rc;
 
-	rbd_dev = rbd_dev_create(rbdc, spec, rbd_opts);
+	rbd_dev = rbd_dev_create(rbdc, ctx.rbd_spec, ctx.rbd_opts);
 	if (!rbd_dev) {
 		rc = -ENOMEM;
 		goto err_out_client;
 	}
 	rbdc = NULL;		/* rbd_dev now owns this */
-	spec = NULL;		/* rbd_dev now owns this */
-	rbd_opts = NULL;	/* rbd_dev now owns this */
+	ctx.rbd_spec = NULL;	/* rbd_dev now owns this */
+	ctx.rbd_opts = NULL;	/* rbd_dev now owns this */
 
 	rbd_dev->config_info = kstrdup(buf, GFP_KERNEL);
 	if (!rbd_dev->config_info) {
@@ -7139,8 +7155,9 @@ static ssize_t do_rbd_add(struct bus_type *bus,
 err_out_client:
 	rbd_put_client(rbdc);
 err_out_args:
-	rbd_spec_put(spec);
-	kfree(rbd_opts);
+	rbd_spec_put(ctx.rbd_spec);
+	kfree(ctx.rbd_opts);
+	ceph_destroy_options(ctx.opt);
 	goto out;
 }
 
diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index b2ec29eeb4c4..20ce51d16f60 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -7,7 +7,7 @@
  */
 
 #include <linux/ceph/ceph_debug.h>
-
+#include <linux/fs_context.h>
 #include "super.h"
 #include "cache.h"
 
@@ -49,7 +49,7 @@ void ceph_fscache_unregister(void)
 	fscache_unregister_netfs(&ceph_cache_netfs);
 }
 
-int ceph_fscache_register_fs(struct ceph_fs_client* fsc)
+int ceph_fscache_register_fs(struct fs_context *fc, struct ceph_fs_client* fsc)
 {
 	const struct ceph_fsid *fsid = &fsc->client->fsid;
 	const char *fscache_uniq = fsc->mount_options->fscache_uniq;
@@ -66,8 +66,8 @@ int ceph_fscache_register_fs(struct ceph_fs_client* fsc)
 		if (uniq_len && memcmp(ent->uniquifier, fscache_uniq, uniq_len))
 			continue;
 
-		pr_err("fscache cookie already registered for fsid %pU\n", fsid);
-		pr_err("  use fsc=%%s mount option to specify a uniquifier\n");
+		errorf(fc, "fscache cookie already registered for fsid %pU\n", fsid);
+		errorf(fc, "  use fsc=%%s mount option to specify a uniquifier\n");
 		err = -EBUSY;
 		goto out_unlock;
 	}
@@ -95,7 +95,7 @@ int ceph_fscache_register_fs(struct ceph_fs_client* fsc)
 		list_add_tail(&ent->list, &ceph_fscache_list);
 	} else {
 		kfree(ent);
-		pr_err("unable to register fscache cookie for fsid %pU\n",
+		errorf(fc, "unable to register fscache cookie for fsid %pU\n",
 		       fsid);
 		/* all other fs ignore this error */
 	}
diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
index e486fac3434d..f72328fd357b 100644
--- a/fs/ceph/cache.h
+++ b/fs/ceph/cache.h
@@ -16,7 +16,7 @@ extern struct fscache_netfs ceph_cache_netfs;
 int ceph_fscache_register(void);
 void ceph_fscache_unregister(void);
 
-int ceph_fscache_register_fs(struct ceph_fs_client* fsc);
+int ceph_fscache_register_fs(struct fs_context *fc, struct ceph_fs_client* fsc);
 void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc);
 
 void ceph_fscache_register_inode_cookie(struct inode *inode);
@@ -88,7 +88,8 @@ static inline void ceph_fscache_unregister(void)
 {
 }
 
-static inline int ceph_fscache_register_fs(struct ceph_fs_client* fsc)
+static inline int ceph_fscache_register_fs(struct fs_context *fc,
+					   struct ceph_fs_client *fsc)
 {
 	return 0;
 }
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 03b63b1cd32c..5ccaec686eda 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -9,7 +9,8 @@
 #include <linux/in6.h>
 #include <linux/module.h>
 #include <linux/mount.h>
-#include <linux/parser.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -138,276 +139,305 @@ enum {
 	Opt_readdir_max_entries,
 	Opt_readdir_max_bytes,
 	Opt_congestion_kb,
-	Opt_last_int,
-	/* int args above */
 	Opt_snapdirname,
 	Opt_mds_namespace,
-	Opt_fscache_uniq,
 	Opt_recover_session,
-	Opt_last_string,
-	/* string args above */
 	Opt_dirstat,
-	Opt_nodirstat,
 	Opt_rbytes,
-	Opt_norbytes,
 	Opt_asyncreaddir,
-	Opt_noasyncreaddir,
 	Opt_dcache,
-	Opt_nodcache,
 	Opt_ino32,
-	Opt_noino32,
 	Opt_fscache,
-	Opt_nofscache,
 	Opt_poolperm,
-	Opt_nopoolperm,
 	Opt_require_active_mds,
-	Opt_norequire_active_mds,
-#ifdef CONFIG_CEPH_FS_POSIX_ACL
 	Opt_acl,
-#endif
-	Opt_noacl,
 	Opt_quotadf,
-	Opt_noquotadf,
 	Opt_copyfrom,
-	Opt_nocopyfrom,
+	Opt_source,
 };
 
-static match_table_t fsopt_tokens = {
-	{Opt_wsize, "wsize=%d"},
-	{Opt_rsize, "rsize=%d"},
-	{Opt_rasize, "rasize=%d"},
-	{Opt_caps_wanted_delay_min, "caps_wanted_delay_min=%d"},
-	{Opt_caps_wanted_delay_max, "caps_wanted_delay_max=%d"},
-	{Opt_caps_max, "caps_max=%d"},
-	{Opt_readdir_max_entries, "readdir_max_entries=%d"},
-	{Opt_readdir_max_bytes, "readdir_max_bytes=%d"},
-	{Opt_congestion_kb, "write_congestion_kb=%d"},
-	/* int args above */
-	{Opt_snapdirname, "snapdirname=%s"},
-	{Opt_mds_namespace, "mds_namespace=%s"},
-	{Opt_recover_session, "recover_session=%s"},
-	{Opt_fscache_uniq, "fsc=%s"},
-	/* string args above */
-	{Opt_dirstat, "dirstat"},
-	{Opt_nodirstat, "nodirstat"},
-	{Opt_rbytes, "rbytes"},
-	{Opt_norbytes, "norbytes"},
-	{Opt_asyncreaddir, "asyncreaddir"},
-	{Opt_noasyncreaddir, "noasyncreaddir"},
-	{Opt_dcache, "dcache"},
-	{Opt_nodcache, "nodcache"},
-	{Opt_ino32, "ino32"},
-	{Opt_noino32, "noino32"},
-	{Opt_fscache, "fsc"},
-	{Opt_nofscache, "nofsc"},
-	{Opt_poolperm, "poolperm"},
-	{Opt_nopoolperm, "nopoolperm"},
-	{Opt_require_active_mds, "require_active_mds"},
-	{Opt_norequire_active_mds, "norequire_active_mds"},
-#ifdef CONFIG_CEPH_FS_POSIX_ACL
-	{Opt_acl, "acl"},
-#endif
-	{Opt_noacl, "noacl"},
-	{Opt_quotadf, "quotadf"},
-	{Opt_noquotadf, "noquotadf"},
-	{Opt_copyfrom, "copyfrom"},
-	{Opt_nocopyfrom, "nocopyfrom"},
-	{-1, NULL}
+enum ceph_recover_session_mode {
+	ceph_recover_session_no,
+	ceph_recover_session_clean
+};
+
+static const struct fs_parameter_enum ceph_param_enums[] = {
+	{ Opt_recover_session,	"no",		ceph_recover_session_no },
+	{ Opt_recover_session,	"clean",	ceph_recover_session_clean },
+	{}
 };
 
-static int parse_fsopt_token(char *c, void *private)
+static const struct fs_parameter_spec ceph_param_specs[] = {
+	fsparam_flag_no ("acl",				Opt_acl),
+	fsparam_flag_no ("asyncreaddir",		Opt_asyncreaddir),
+	fsparam_u32	("caps_max",			Opt_caps_max),
+	fsparam_u32	("caps_wanted_delay_max",	Opt_caps_wanted_delay_max),
+	fsparam_u32	("caps_wanted_delay_min",	Opt_caps_wanted_delay_min),
+	fsparam_s32	("write_congestion_kb",		Opt_congestion_kb),
+	fsparam_flag_no ("copyfrom",			Opt_copyfrom),
+	fsparam_flag_no ("dcache",			Opt_dcache),
+	fsparam_flag_no ("dirstat",			Opt_dirstat),
+	__fsparam	(fs_param_is_string, "fsc",	Opt_fscache,
+			 fs_param_neg_with_no | fs_param_v_optional),
+	fsparam_flag_no ("ino32",			Opt_ino32),
+	fsparam_string	("mds_namespace",		Opt_mds_namespace),
+	fsparam_flag_no ("poolperm",			Opt_poolperm),
+	fsparam_flag_no ("quotadf",			Opt_quotadf),
+	fsparam_u32	("rasize",			Opt_rasize),
+	fsparam_flag_no ("rbytes",			Opt_rbytes),
+	fsparam_s32	("readdir_max_bytes",		Opt_readdir_max_bytes),
+	fsparam_s32	("readdir_max_entries",		Opt_readdir_max_entries),
+	fsparam_enum	("recover_session",		Opt_recover_session),
+	fsparam_flag_no ("require_active_mds",		Opt_require_active_mds),
+	fsparam_u32	("rsize",			Opt_rsize),
+	fsparam_string	("snapdirname",			Opt_snapdirname),
+	fsparam_string	("source",			Opt_source),
+	fsparam_u32	("wsize",			Opt_wsize),
+	{}
+};
+
+static const struct fs_parameter_description ceph_fs_parameters = {
+	.name           = "ceph",
+	.specs          = ceph_param_specs,
+	.enums		= ceph_param_enums,
+};
+
+/*
+ * Parse the source parameter.  Distinguish the server list from the path.
+ * Internally we do not include the leading '/' in the path.
+ *
+ * The source will look like:
+ *     <server_spec>[,<server_spec>...]:[<path>]
+ * where
+ *     <server_spec> is <ip>[:<port>]
+ *     <path> is optional, but if present must begin with '/'
+ */
+static int ceph_parse_source(struct fs_context *fc, struct fs_parameter *param)
 {
-	struct ceph_mount_options *fsopt = private;
-	substring_t argstr[MAX_OPT_ARGS];
-	int token, intval, ret;
-
-	token = match_token((char *)c, fsopt_tokens, argstr);
-	if (token < 0)
-		return -EINVAL;
-
-	if (token < Opt_last_int) {
-		ret = match_int(&argstr[0], &intval);
-		if (ret < 0) {
-			pr_err("bad option arg (not int) at '%s'\n", c);
-			return ret;
+	struct ceph_config_context *ctx = fc->fs_private;
+	struct ceph_mount_options *fsopt = ctx->mount_options;
+	char *dev_name = param->string, *dev_name_end;
+	int ret;
+
+	dout("parse_mount_options %p, dev_name '%s'\n", fsopt, dev_name);
+
+	if (fc->source)
+		return invalf(fc, "Multiple sources specified");
+	if (!dev_name || !*dev_name)
+		return invalf(fc, "Empty source");
+	if (dev_name[0] == '/')
+		return invalf(fc, "Missing colon");
+
+	dev_name_end = strchr(dev_name + 1, '/');
+	if (dev_name_end) {
+		if (strlen(dev_name_end) > 1) {
+			kfree(fsopt->server_path);
+			fsopt->server_path = kstrdup(dev_name_end, GFP_KERNEL);
+			if (!fsopt->server_path)
+				return -ENOMEM;
 		}
-		dout("got int token %d val %d\n", token, intval);
-	} else if (token > Opt_last_int && token < Opt_last_string) {
-		dout("got string token %d val %s\n", token,
-		     argstr[0].from);
 	} else {
-		dout("got token %d\n", token);
+		dev_name_end = dev_name + strlen(dev_name);
 	}
 
-	switch (token) {
+	/* Trim off the path and the colon separator */
+	dev_name_end--;
+	if (*dev_name_end != ':')
+		return invalf(fc, "device name is missing path (no : separator in %s)\n",
+			      dev_name);
+	*dev_name_end = 0;
+
+	dout("device name '%s'\n", dev_name);
+	if (fsopt->server_path)
+		dout("server path '%s'\n", fsopt->server_path);
+
+	param->size = dev_name_end - dev_name;
+	ret = ceph_parse_server_specs(ctx->opt, fc,
+				      param->string, dev_name_end - dev_name);
+	if (ret == 0) {
+		fc->source = param->string;
+		param->string = NULL;
+	}
+
+	return 0;
+}
+
+static int ceph_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct ceph_config_context *ctx = fc->fs_private;
+	struct ceph_mount_options *fsopt = ctx->mount_options;
+	struct fs_parse_result result;
+	unsigned int mode;
+	int ret, opt;
+
+	ret = ceph_parse_option(ctx->opt, fc, param);
+	if (ret != -ENOPARAM)
+		return ret;
+
+	opt = fs_parse(fc, &ceph_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_source:
+		return ceph_parse_source(fc, param);
 	case Opt_snapdirname:
 		kfree(fsopt->snapdir_name);
-		fsopt->snapdir_name = kstrndup(argstr[0].from,
-					       argstr[0].to-argstr[0].from,
-					       GFP_KERNEL);
-		if (!fsopt->snapdir_name)
-			return -ENOMEM;
+		fsopt->snapdir_name = param->string;
+		param->string = NULL;
 		break;
 	case Opt_mds_namespace:
 		kfree(fsopt->mds_namespace);
-		fsopt->mds_namespace = kstrndup(argstr[0].from,
-						argstr[0].to-argstr[0].from,
-						GFP_KERNEL);
-		if (!fsopt->mds_namespace)
-			return -ENOMEM;
+		fsopt->mds_namespace = param->string;
+		param->string = NULL;
 		break;
 	case Opt_recover_session:
-		if (!strncmp(argstr[0].from, "no",
-			     argstr[0].to - argstr[0].from)) {
+		mode = result.uint_32;
+		if (mode == ceph_recover_session_no)
 			fsopt->flags &= ~CEPH_MOUNT_OPT_CLEANRECOVER;
-		} else if (!strncmp(argstr[0].from, "clean",
-				    argstr[0].to - argstr[0].from)) {
+		else if (mode == ceph_recover_session_clean)
 			fsopt->flags |= CEPH_MOUNT_OPT_CLEANRECOVER;
-		} else {
+		else
 			return -EINVAL;
-		}
-		break;
-	case Opt_fscache_uniq:
-		kfree(fsopt->fscache_uniq);
-		fsopt->fscache_uniq = kstrndup(argstr[0].from,
-					       argstr[0].to-argstr[0].from,
-					       GFP_KERNEL);
-		if (!fsopt->fscache_uniq)
-			return -ENOMEM;
-		fsopt->flags |= CEPH_MOUNT_OPT_FSCACHE;
 		break;
-		/* misc */
 	case Opt_wsize:
-		if (intval < (int)PAGE_SIZE || intval > CEPH_MAX_WRITE_SIZE)
-			return -EINVAL;
-		fsopt->wsize = ALIGN(intval, PAGE_SIZE);
+		if (result.uint_32 < (int)PAGE_SIZE || result.uint_32 > CEPH_MAX_WRITE_SIZE)
+			goto invalid_value;
+		fsopt->wsize = ALIGN(result.uint_32, PAGE_SIZE);
 		break;
 	case Opt_rsize:
-		if (intval < (int)PAGE_SIZE || intval > CEPH_MAX_READ_SIZE)
-			return -EINVAL;
-		fsopt->rsize = ALIGN(intval, PAGE_SIZE);
+		if (result.uint_32 < (int)PAGE_SIZE || result.uint_32 > CEPH_MAX_READ_SIZE)
+			goto invalid_value;
+		fsopt->rsize = ALIGN(result.uint_32, PAGE_SIZE);
 		break;
 	case Opt_rasize:
-		if (intval < 0)
-			return -EINVAL;
-		fsopt->rasize = ALIGN(intval, PAGE_SIZE);
+		fsopt->rasize = ALIGN(result.uint_32, PAGE_SIZE);
 		break;
 	case Opt_caps_wanted_delay_min:
-		if (intval < 1)
-			return -EINVAL;
-		fsopt->caps_wanted_delay_min = intval;
+		if (result.uint_32 < 1)
+			goto invalid_value;
+		fsopt->caps_wanted_delay_min = result.uint_32;
 		break;
 	case Opt_caps_wanted_delay_max:
-		if (intval < 1)
-			return -EINVAL;
-		fsopt->caps_wanted_delay_max = intval;
+		if (result.uint_32 < 1)
+			goto invalid_value;
+		fsopt->caps_wanted_delay_max = result.uint_32;
 		break;
 	case Opt_caps_max:
-		if (intval < 0)
-			return -EINVAL;
-		fsopt->caps_max = intval;
+		fsopt->caps_max = result.uint_32;
 		break;
 	case Opt_readdir_max_entries:
-		if (intval < 1)
-			return -EINVAL;
-		fsopt->max_readdir = intval;
+		if (result.uint_32 < 1)
+			goto invalid_value;
+		fsopt->max_readdir = result.uint_32;
 		break;
 	case Opt_readdir_max_bytes:
-		if (intval < (int)PAGE_SIZE && intval != 0)
-			return -EINVAL;
-		fsopt->max_readdir_bytes = intval;
+		if (result.uint_32 < (int)PAGE_SIZE && result.uint_32 != 0)
+			goto invalid_value;
+		fsopt->max_readdir_bytes = result.uint_32;
 		break;
 	case Opt_congestion_kb:
-		if (intval < 1024) /* at least 1M */
-			return -EINVAL;
-		fsopt->congestion_kb = intval;
+		if (result.uint_32 < 1024) /* at least 1M */
+			goto invalid_value;
+		fsopt->congestion_kb = result.uint_32;
 		break;
 	case Opt_dirstat:
-		fsopt->flags |= CEPH_MOUNT_OPT_DIRSTAT;
-		break;
-	case Opt_nodirstat:
-		fsopt->flags &= ~CEPH_MOUNT_OPT_DIRSTAT;
+		if (!result.negated)
+			fsopt->flags |= CEPH_MOUNT_OPT_DIRSTAT;
+		else
+			fsopt->flags &= ~CEPH_MOUNT_OPT_DIRSTAT;
 		break;
 	case Opt_rbytes:
-		fsopt->flags |= CEPH_MOUNT_OPT_RBYTES;
-		break;
-	case Opt_norbytes:
-		fsopt->flags &= ~CEPH_MOUNT_OPT_RBYTES;
+		if (!result.negated)
+			fsopt->flags |= CEPH_MOUNT_OPT_RBYTES;
+		else
+			fsopt->flags &= ~CEPH_MOUNT_OPT_RBYTES;
 		break;
 	case Opt_asyncreaddir:
-		fsopt->flags &= ~CEPH_MOUNT_OPT_NOASYNCREADDIR;
-		break;
-	case Opt_noasyncreaddir:
-		fsopt->flags |= CEPH_MOUNT_OPT_NOASYNCREADDIR;
+		if (!result.negated)
+			fsopt->flags &= ~CEPH_MOUNT_OPT_NOASYNCREADDIR;
+		else
+			fsopt->flags |= CEPH_MOUNT_OPT_NOASYNCREADDIR;
 		break;
 	case Opt_dcache:
-		fsopt->flags |= CEPH_MOUNT_OPT_DCACHE;
-		break;
-	case Opt_nodcache:
-		fsopt->flags &= ~CEPH_MOUNT_OPT_DCACHE;
+		if (!result.negated)
+			fsopt->flags |= CEPH_MOUNT_OPT_DCACHE;
+		else
+			fsopt->flags &= ~CEPH_MOUNT_OPT_DCACHE;
 		break;
 	case Opt_ino32:
-		fsopt->flags |= CEPH_MOUNT_OPT_INO32;
-		break;
-	case Opt_noino32:
-		fsopt->flags &= ~CEPH_MOUNT_OPT_INO32;
+		if (!result.negated)
+			fsopt->flags |= CEPH_MOUNT_OPT_INO32;
+		else
+			fsopt->flags &= ~CEPH_MOUNT_OPT_INO32;
 		break;
+
 	case Opt_fscache:
-		fsopt->flags |= CEPH_MOUNT_OPT_FSCACHE;
-		kfree(fsopt->fscache_uniq);
-		fsopt->fscache_uniq = NULL;
-		break;
-	case Opt_nofscache:
-		fsopt->flags &= ~CEPH_MOUNT_OPT_FSCACHE;
 		kfree(fsopt->fscache_uniq);
 		fsopt->fscache_uniq = NULL;
+		if (result.negated) {
+			fsopt->flags &= ~CEPH_MOUNT_OPT_FSCACHE;
+		} else {
+			fsopt->flags |= CEPH_MOUNT_OPT_FSCACHE;
+			fsopt->fscache_uniq = param->string;
+			param->string = NULL;
+		}
 		break;
+
 	case Opt_poolperm:
-		fsopt->flags &= ~CEPH_MOUNT_OPT_NOPOOLPERM;
-		break;
-	case Opt_nopoolperm:
-		fsopt->flags |= CEPH_MOUNT_OPT_NOPOOLPERM;
+		if (!result.negated)
+			fsopt->flags &= ~CEPH_MOUNT_OPT_NOPOOLPERM;
+		else
+			fsopt->flags |= CEPH_MOUNT_OPT_NOPOOLPERM;
 		break;
 	case Opt_require_active_mds:
-		fsopt->flags &= ~CEPH_MOUNT_OPT_MOUNTWAIT;
-		break;
-	case Opt_norequire_active_mds:
-		fsopt->flags |= CEPH_MOUNT_OPT_MOUNTWAIT;
+		if (!result.negated)
+			fsopt->flags &= ~CEPH_MOUNT_OPT_MOUNTWAIT;
+		else
+			fsopt->flags |= CEPH_MOUNT_OPT_MOUNTWAIT;
 		break;
 	case Opt_quotadf:
-		fsopt->flags &= ~CEPH_MOUNT_OPT_NOQUOTADF;
-		break;
-	case Opt_noquotadf:
-		fsopt->flags |= CEPH_MOUNT_OPT_NOQUOTADF;
+		if (!result.negated)
+			fsopt->flags &= ~CEPH_MOUNT_OPT_NOQUOTADF;
+		else
+			fsopt->flags |= CEPH_MOUNT_OPT_NOQUOTADF;
 		break;
 	case Opt_copyfrom:
-		fsopt->flags &= ~CEPH_MOUNT_OPT_NOCOPYFROM;
-		break;
-	case Opt_nocopyfrom:
-		fsopt->flags |= CEPH_MOUNT_OPT_NOCOPYFROM;
+		if (!result.negated)
+			fsopt->flags &= ~CEPH_MOUNT_OPT_NOCOPYFROM;
+		else
+			fsopt->flags |= CEPH_MOUNT_OPT_NOCOPYFROM;
 		break;
-#ifdef CONFIG_CEPH_FS_POSIX_ACL
 	case Opt_acl:
-		fsopt->sb_flags |= SB_POSIXACL;
-		break;
+		if (!result.negated) {
+#ifdef CONFIG_CEPH_FS_POSIX_ACL
+			fc->sb_flags |= SB_POSIXACL;
+#else
+			return invalf(fc, "POSIX ACL support is disabled");
 #endif
-	case Opt_noacl:
-		fsopt->sb_flags &= ~SB_POSIXACL;
+		} else {
+			fc->sb_flags &= ~SB_POSIXACL;
+		}
 		break;
 	default:
-		BUG_ON(token);
+		BUG();
 	}
 	return 0;
+
+invalid_value:
+	return invalf(fc, "ceph: Invalid value for %s", param->key);
 }
 
 static void destroy_mount_options(struct ceph_mount_options *args)
 {
-	dout("destroy_mount_options %p\n", args);
-	kfree(args->snapdir_name);
-	kfree(args->mds_namespace);
-	kfree(args->server_path);
-	kfree(args->fscache_uniq);
-	kfree(args);
+	if (args) {
+		dout("destroy_mount_options %p\n", args);
+		kfree(args->snapdir_name);
+		kfree(args->mds_namespace);
+		kfree(args->server_path);
+		kfree(args->fscache_uniq);
+		kfree(args);
+	}
 }
 
 static int strcmp_null(const char *s1, const char *s2)
@@ -450,91 +480,6 @@ static int compare_mount_options(struct ceph_mount_options *new_fsopt,
 	return ceph_compare_options(new_opt, fsc->client);
 }
 
-static int parse_mount_options(struct ceph_mount_options **pfsopt,
-			       struct ceph_options **popt,
-			       int flags, char *options,
-			       const char *dev_name)
-{
-	struct ceph_mount_options *fsopt;
-	const char *dev_name_end;
-	int err;
-
-	if (!dev_name || !*dev_name)
-		return -EINVAL;
-
-	fsopt = kzalloc(sizeof(*fsopt), GFP_KERNEL);
-	if (!fsopt)
-		return -ENOMEM;
-
-	dout("parse_mount_options %p, dev_name '%s'\n", fsopt, dev_name);
-
-	fsopt->sb_flags = flags;
-	fsopt->flags = CEPH_MOUNT_OPT_DEFAULT;
-
-	fsopt->wsize = CEPH_MAX_WRITE_SIZE;
-	fsopt->rsize = CEPH_MAX_READ_SIZE;
-	fsopt->rasize = CEPH_RASIZE_DEFAULT;
-	fsopt->snapdir_name = kstrdup(CEPH_SNAPDIRNAME_DEFAULT, GFP_KERNEL);
-	if (!fsopt->snapdir_name) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	fsopt->caps_wanted_delay_min = CEPH_CAPS_WANTED_DELAY_MIN_DEFAULT;
-	fsopt->caps_wanted_delay_max = CEPH_CAPS_WANTED_DELAY_MAX_DEFAULT;
-	fsopt->max_readdir = CEPH_MAX_READDIR_DEFAULT;
-	fsopt->max_readdir_bytes = CEPH_MAX_READDIR_BYTES_DEFAULT;
-	fsopt->congestion_kb = default_congestion_kb();
-
-	/*
-	 * Distinguish the server list from the path in "dev_name".
-	 * Internally we do not include the leading '/' in the path.
-	 *
-	 * "dev_name" will look like:
-	 *     <server_spec>[,<server_spec>...]:[<path>]
-	 * where
-	 *     <server_spec> is <ip>[:<port>]
-	 *     <path> is optional, but if present must begin with '/'
-	 */
-	dev_name_end = strchr(dev_name, '/');
-	if (dev_name_end) {
-		if (strlen(dev_name_end) > 1) {
-			fsopt->server_path = kstrdup(dev_name_end, GFP_KERNEL);
-			if (!fsopt->server_path) {
-				err = -ENOMEM;
-				goto out;
-			}
-		}
-	} else {
-		dev_name_end = dev_name + strlen(dev_name);
-	}
-	err = -EINVAL;
-	dev_name_end--;		/* back up to ':' separator */
-	if (dev_name_end < dev_name || *dev_name_end != ':') {
-		pr_err("device name is missing path (no : separator in %s)\n",
-				dev_name);
-		goto out;
-	}
-	dout("device name '%.*s'\n", (int)(dev_name_end - dev_name), dev_name);
-	if (fsopt->server_path)
-		dout("server path '%s'\n", fsopt->server_path);
-
-	*popt = ceph_parse_options(options, dev_name, dev_name_end,
-				 parse_fsopt_token, (void *)fsopt);
-	if (IS_ERR(*popt)) {
-		err = PTR_ERR(*popt);
-		goto out;
-	}
-
-	/* success */
-	*pfsopt = fsopt;
-	return 0;
-
-out:
-	destroy_mount_options(fsopt);
-	return err;
-}
-
 /**
  * ceph_show_options - Show mount options in /proc/mounts
  * @m: seq_file to write to
@@ -578,7 +523,7 @@ static int ceph_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",noquotadf");
 
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
-	if (fsopt->sb_flags & SB_POSIXACL)
+	if (root->d_sb->s_flags & SB_POSIXACL)
 		seq_puts(m, ",acl");
 	else
 		seq_puts(m, ",noacl");
@@ -642,12 +587,10 @@ static int extra_mon_dispatch(struct ceph_client *client, struct ceph_msg *msg)
 
 /*
  * create a new fs client
- *
- * Success or not, this function consumes @fsopt and @opt.
  */
-static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
-					struct ceph_options *opt)
+static struct ceph_fs_client *create_fs_client(struct fs_context *fc)
 {
+	struct ceph_config_context *ctx = fc->fs_private;
 	struct ceph_fs_client *fsc;
 	int page_count;
 	size_t size;
@@ -659,17 +602,18 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 		goto fail;
 	}
 
-	fsc->client = ceph_create_client(opt, fsc);
+	fsc->client = ceph_create_client(ctx->opt, fsc);
 	if (IS_ERR(fsc->client)) {
+		errorf(fc, "ceph: Failed to create client");
 		err = PTR_ERR(fsc->client);
 		goto fail;
 	}
-	opt = NULL; /* fsc->client now owns this */
+	ctx->opt = NULL; /* fsc->client now owns this */
 
 	fsc->client->extra_mon_dispatch = extra_mon_dispatch;
 	ceph_set_opt(fsc->client, ABORT_ON_FULL);
 
-	if (!fsopt->mds_namespace) {
+	if (!ctx->mount_options->mds_namespace) {
 		ceph_monc_want_map(&fsc->client->monc, CEPH_SUB_MDSMAP,
 				   0, true);
 	} else {
@@ -677,7 +621,8 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 				   0, false);
 	}
 
-	fsc->mount_options = fsopt;
+	fsc->mount_options = ctx->mount_options;
+	ctx->mount_options = NULL;
 
 	fsc->sb = NULL;
 	fsc->mount_state = CEPH_MOUNT_MOUNTING;
@@ -715,9 +660,6 @@ static struct ceph_fs_client *create_fs_client(struct ceph_mount_options *fsopt,
 	ceph_destroy_client(fsc->client);
 fail:
 	kfree(fsc);
-	if (opt)
-		ceph_destroy_options(opt);
-	destroy_mount_options(fsopt);
 	return ERR_PTR(err);
 }
 
@@ -925,9 +867,9 @@ static struct dentry *open_root_dentry(struct ceph_fs_client *fsc,
 /*
  * mount: join the ceph cluster, and open root directory.
  */
-static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc)
+static int ceph_real_mount(struct fs_context *fc, struct ceph_fs_client *fsc)
 {
-	int err;
+	int err = 0;
 	unsigned long started = jiffies;  /* note the start time */
 	struct dentry *root;
 
@@ -942,7 +884,7 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc)
 
 		/* setup fscache */
 		if (fsc->mount_options->flags & CEPH_MOUNT_OPT_FSCACHE) {
-			err = ceph_fscache_register_fs(fsc);
+			err = ceph_fscache_register_fs(fc, fsc);
 			if (err < 0)
 				goto out;
 		}
@@ -962,33 +904,30 @@ static struct dentry *ceph_real_mount(struct ceph_fs_client *fsc)
 			err = PTR_ERR(root);
 			goto out;
 		}
-		fsc->sb->s_root = dget(root);
-	} else {
-		root = dget(fsc->sb->s_root);
+		fsc->sb->s_root = root;
 	}
 
+	fc->root = dget(fsc->sb->s_root);
 	fsc->mount_state = CEPH_MOUNT_MOUNTED;
 	dout("mount success\n");
 	mutex_unlock(&fsc->client->mount_mutex);
-	return root;
+	return err;
 
 out:
 	mutex_unlock(&fsc->client->mount_mutex);
-	return ERR_PTR(err);
+	return err;
 }
 
-static int ceph_set_super(struct super_block *s, void *data)
+static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 {
-	struct ceph_fs_client *fsc = data;
+	struct ceph_fs_client *fsc = s->s_fs_info;
 	int ret;
 
-	dout("set_super %p data %p\n", s, data);
+	dout("set_super %p\n", s);
 
-	s->s_flags = fsc->mount_options->sb_flags;
 	s->s_maxbytes = MAX_LFS_FILESIZE;
 
 	s->s_xattr = ceph_xattr_handlers;
-	s->s_fs_info = fsc;
 	fsc->sb = s;
 	fsc->max_file_size = 1ULL << 40; /* temp value until we get mdsmap */
 
@@ -998,24 +937,18 @@ static int ceph_set_super(struct super_block *s, void *data)
 
 	s->s_time_gran = 1;
 
-	ret = set_anon_super(s, NULL);  /* what is that second arg for? */
+	ret = set_anon_super_fc(s, fc);
 	if (ret != 0)
-		goto fail;
-
-	return ret;
-
-fail:
-	s->s_fs_info = NULL;
-	fsc->sb = NULL;
+		fsc->sb = NULL;
 	return ret;
 }
 
 /*
  * share superblock if same fs AND options
  */
-static int ceph_compare_super(struct super_block *sb, void *data)
+static int ceph_compare_super(struct super_block *sb, struct fs_context *fc)
 {
-	struct ceph_fs_client *new = data;
+	struct ceph_fs_client *new = fc->s_fs_info;
 	struct ceph_mount_options *fsopt = new->mount_options;
 	struct ceph_options *opt = new->client->options;
 	struct ceph_fs_client *other = ceph_sb_to_client(sb);
@@ -1031,7 +964,7 @@ static int ceph_compare_super(struct super_block *sb, void *data)
 		dout("fsid doesn't match\n");
 		return 0;
 	}
-	if (fsopt->sb_flags != other->mount_options->sb_flags) {
+	if (fc->sb_flags != (sb->s_flags & ~SB_BORN)) {
 		dout("flags differ\n");
 		return 0;
 	}
@@ -1061,46 +994,41 @@ static int ceph_setup_bdi(struct super_block *sb, struct ceph_fs_client *fsc)
 	return 0;
 }
 
-static struct dentry *ceph_mount(struct file_system_type *fs_type,
-		       int flags, const char *dev_name, void *data)
+static int ceph_get_tree(struct fs_context *fc)
 {
-	struct super_block *sb;
 	struct ceph_fs_client *fsc;
-	struct dentry *res;
+	struct super_block *sb;
 	int err;
-	int (*compare_super)(struct super_block *, void *) = ceph_compare_super;
-	struct ceph_mount_options *fsopt = NULL;
-	struct ceph_options *opt = NULL;
+	int (*compare_super)(struct super_block *, struct fs_context *) =
+		ceph_compare_super;
+
+	dout("ceph_get_tree\n");
 
-	dout("ceph_mount\n");
+	if (!fc->source)
+		return invalf(fc, "source parameter not specified");
 
 #ifdef CONFIG_CEPH_FS_POSIX_ACL
-	flags |= SB_POSIXACL;
+	fc->sb_flags |= SB_POSIXACL;
 #endif
-	err = parse_mount_options(&fsopt, &opt, flags, data, dev_name);
-	if (err < 0) {
-		res = ERR_PTR(err);
-		goto out_final;
-	}
 
 	/* create client (which we may/may not use) */
-	fsc = create_fs_client(fsopt, opt);
+	fsc = create_fs_client(fc);
 	if (IS_ERR(fsc)) {
-		res = ERR_CAST(fsc);
-		goto out_final;
+		err = PTR_ERR(fsc);
+		goto out;
 	}
 
 	err = ceph_mdsc_init(fsc);
-	if (err < 0) {
-		res = ERR_PTR(err);
+	if (err < 0)
 		goto out;
-	}
 
 	if (ceph_test_opt(fsc->client, NOSHARE))
 		compare_super = NULL;
-	sb = sget(fs_type, compare_super, ceph_set_super, flags, fsc);
+
+	fc->s_fs_info = fsc;
+	sb = sget_fc(fc, compare_super, ceph_set_super);
 	if (IS_ERR(sb)) {
-		res = ERR_CAST(sb);
+		err = PTR_ERR(sb);
 		goto out;
 	}
 
@@ -1112,30 +1040,97 @@ static struct dentry *ceph_mount(struct file_system_type *fs_type,
 	} else {
 		dout("get_sb using new client %p\n", fsc);
 		err = ceph_setup_bdi(sb, fsc);
-		if (err < 0) {
-			res = ERR_PTR(err);
+		if (err < 0)
 			goto out_splat;
-		}
 	}
 
-	res = ceph_real_mount(fsc);
-	if (IS_ERR(res))
+	err = ceph_real_mount(fc, fsc);
+	if (err < 0)
 		goto out_splat;
-	dout("root %p inode %p ino %llx.%llx\n", res,
-	     d_inode(res), ceph_vinop(d_inode(res)));
-	return res;
+	dout("root %p inode %p ino %llx.%llx\n",
+	     fc->root, d_inode(fc->root), ceph_vinop(d_inode(fc->root)));
+	return 0;
 
 out_splat:
 	ceph_mdsc_close_sessions(fsc->mdsc);
 	deactivate_locked_super(sb);
-	goto out_final;
-
 out:
-	ceph_mdsc_destroy(fsc);
-	destroy_fs_client(fsc);
-out_final:
-	dout("ceph_mount fail %ld\n", PTR_ERR(res));
-	return res;
+	dout("ceph_mount fail %d\n", err);
+	return err;
+}
+
+static void ceph_free_fc(struct fs_context *fc)
+{
+	struct ceph_config_context *ctx = fc->fs_private;
+	struct ceph_fs_client *fsc = fc->s_fs_info;
+
+	if (fsc) {
+		ceph_mdsc_destroy(fsc);
+		destroy_fs_client(fsc);
+	}
+
+	if (ctx) {
+		destroy_mount_options(ctx->mount_options);
+		ceph_destroy_options(ctx->opt);
+		kfree(ctx);
+	}
+}
+
+static const struct fs_context_operations ceph_context_ops = {
+	.free		= ceph_free_fc,
+	.parse_param	= ceph_parse_param,
+	.get_tree	= ceph_get_tree,
+};
+
+/*
+ * Set up the filesystem mount context.
+ */
+static int ceph_init_fs_context(struct fs_context *fc)
+{
+	struct ceph_config_context *ctx;
+	struct ceph_mount_options *fsopt;
+
+	ctx = kzalloc(sizeof(struct ceph_config_context), GFP_KERNEL);
+	if (!ctx)
+		goto nomem;
+
+	ctx->mount_options = kzalloc(sizeof(struct ceph_mount_options), GFP_KERNEL);
+	if (!ctx->mount_options)
+		goto nomem_ctx;
+
+	ctx->mount_options->snapdir_name = kstrdup(CEPH_SNAPDIRNAME_DEFAULT, GFP_KERNEL);
+	if (!ctx->mount_options->snapdir_name)
+		goto nomem_mo;
+
+	ctx->opt = ceph_alloc_options();
+	if (!ctx->opt)
+		goto nomem_snap;
+
+	fsopt = ctx->mount_options;
+	fsopt->flags = CEPH_MOUNT_OPT_DEFAULT;
+
+	fsopt->wsize = CEPH_MAX_WRITE_SIZE;
+	fsopt->rsize = CEPH_MAX_READ_SIZE;
+	fsopt->rasize = CEPH_RASIZE_DEFAULT;
+
+	fsopt->caps_wanted_delay_min = CEPH_CAPS_WANTED_DELAY_MIN_DEFAULT;
+	fsopt->caps_wanted_delay_max = CEPH_CAPS_WANTED_DELAY_MAX_DEFAULT;
+	fsopt->max_readdir = CEPH_MAX_READDIR_DEFAULT;
+	fsopt->max_readdir_bytes = CEPH_MAX_READDIR_BYTES_DEFAULT;
+	fsopt->congestion_kb = default_congestion_kb();
+
+	fc->fs_private = ctx;
+	fc->ops = &ceph_context_ops;
+	return 0;
+
+nomem_snap:
+	kfree(ctx->mount_options->snapdir_name);
+nomem_mo:
+	kfree(ctx->mount_options);
+nomem_ctx:
+	kfree(ctx);
+nomem:
+	return -ENOMEM;
 }
 
 static void ceph_kill_sb(struct super_block *s)
@@ -1164,7 +1159,7 @@ static void ceph_kill_sb(struct super_block *s)
 static struct file_system_type ceph_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "ceph",
-	.mount		= ceph_mount,
+	.init_fs_context = ceph_init_fs_context,
 	.kill_sb	= ceph_kill_sb,
 	.fs_flags	= FS_RENAME_DOES_D_MOVE,
 };
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index f98d9247f9cb..a8d8d59155d8 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -74,7 +74,6 @@
 
 struct ceph_mount_options {
 	int flags;
-	int sb_flags;
 
 	int wsize;            /* max write size */
 	int rsize;            /* max read size */
diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index b9dbda1c26aa..7e8f24787d02 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -66,6 +66,13 @@ struct ceph_options {
 	struct ceph_crypto_key *key;
 };
 
+struct ceph_config_context {
+	struct ceph_options		*opt;
+	struct ceph_mount_options	*mount_options;
+	struct rbd_spec			*rbd_spec;
+	struct rbd_options		*rbd_opts;
+};
+
 /*
  * defaults
  */
@@ -280,10 +287,12 @@ extern const char *ceph_msg_type_name(int type);
 extern int ceph_check_fsid(struct ceph_client *client, struct ceph_fsid *fsid);
 extern void *ceph_kvmalloc(size_t size, gfp_t flags);
 
-extern struct ceph_options *ceph_parse_options(char *options,
-			      const char *dev_name, const char *dev_name_end,
-			      int (*parse_extra_token)(char *c, void *private),
-			      void *private);
+struct fs_parameter;
+extern struct ceph_options *ceph_alloc_options(void);
+extern int ceph_parse_server_specs(struct ceph_options *opt, struct fs_context *fc,
+				   const char *data, size_t size);
+extern int ceph_parse_option(struct ceph_options *opt, struct fs_context *fc,
+			     struct fs_parameter *param);
 int ceph_print_client_options(struct seq_file *m, struct ceph_client *client,
 			      bool show_all);
 extern void ceph_destroy_options(struct ceph_options *opt);
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index b412a3ccc4fc..c41789154cdb 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/nsproxy.h>
-#include <linux/parser.h>
+#include <linux/fs_parser.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
@@ -232,70 +232,84 @@ static int parse_fsid(const char *str, struct ceph_fsid *fsid)
  * ceph options
  */
 enum {
-	Opt_osdtimeout,
-	Opt_osdkeepalivetimeout,
+	Opt_abort_on_full,
+	Opt_cephx_require_signatures,
+	Opt_cephx_sign_messages,
+	Opt_crc,
+	Opt_fsid,
+	Opt_ip,
+	Opt_key,
 	Opt_mount_timeout,
+	Opt_name,
 	Opt_osd_idle_ttl,
 	Opt_osd_request_timeout,
-	Opt_last_int,
-	/* int args above */
-	Opt_fsid,
-	Opt_name,
+	Opt_osdkeepalivetimeout,
+	Opt_osdtimeout,
 	Opt_secret,
-	Opt_key,
-	Opt_ip,
-	Opt_last_string,
-	/* string args above */
 	Opt_share,
-	Opt_noshare,
-	Opt_crc,
-	Opt_nocrc,
-	Opt_cephx_require_signatures,
-	Opt_nocephx_require_signatures,
-	Opt_cephx_sign_messages,
-	Opt_nocephx_sign_messages,
 	Opt_tcp_nodelay,
-	Opt_notcp_nodelay,
-	Opt_abort_on_full,
 };
 
-static match_table_t opt_tokens = {
-	{Opt_osdtimeout, "osdtimeout=%d"},
-	{Opt_osdkeepalivetimeout, "osdkeepalive=%d"},
-	{Opt_mount_timeout, "mount_timeout=%d"},
-	{Opt_osd_idle_ttl, "osd_idle_ttl=%d"},
-	{Opt_osd_request_timeout, "osd_request_timeout=%d"},
-	/* int args above */
-	{Opt_fsid, "fsid=%s"},
-	{Opt_name, "name=%s"},
-	{Opt_secret, "secret=%s"},
-	{Opt_key, "key=%s"},
-	{Opt_ip, "ip=%s"},
-	/* string args above */
-	{Opt_share, "share"},
-	{Opt_noshare, "noshare"},
-	{Opt_crc, "crc"},
-	{Opt_nocrc, "nocrc"},
-	{Opt_cephx_require_signatures, "cephx_require_signatures"},
-	{Opt_nocephx_require_signatures, "nocephx_require_signatures"},
-	{Opt_cephx_sign_messages, "cephx_sign_messages"},
-	{Opt_nocephx_sign_messages, "nocephx_sign_messages"},
-	{Opt_tcp_nodelay, "tcp_nodelay"},
-	{Opt_notcp_nodelay, "notcp_nodelay"},
-	{Opt_abort_on_full, "abort_on_full"},
-	{-1, NULL}
+static const struct fs_parameter_spec ceph_option_specs[] = {
+	fsparam_flag	("abort_on_full",		Opt_abort_on_full),
+	fsparam_flag_no ("cephx_require_signatures",	Opt_cephx_require_signatures),
+	fsparam_flag_no ("cephx_sign_messages",		Opt_cephx_sign_messages),
+	fsparam_flag_no ("crc",				Opt_crc),
+	fsparam_string	("fsid",			Opt_fsid),
+	fsparam_string	("ip",				Opt_ip),
+	fsparam_string	("key",				Opt_key),
+	fsparam_u32	("mount_timeout",		Opt_mount_timeout),
+	fsparam_string	("name",			Opt_name),
+	fsparam_u32	("osd_idle_ttl",		Opt_osd_idle_ttl),
+	fsparam_u32	("osd_request_timeout",		Opt_osd_request_timeout),
+	fsparam_u32	("osdkeepalive",		Opt_osdkeepalivetimeout),
+	__fsparam	(fs_param_is_s32, "osdtimeout", Opt_osdtimeout, fs_param_deprecated),
+	fsparam_string	("secret",			Opt_secret),
+	fsparam_flag_no ("share",			Opt_share),
+	fsparam_flag_no ("tcp_nodelay",			Opt_tcp_nodelay),
+	{}
+};
+
+static const struct fs_parameter_description ceph_options = {
+        .name           = "ceph",
+        .specs          = ceph_option_specs,
 };
 
+struct ceph_options *ceph_alloc_options(void)
+{
+	struct ceph_options *opt;
+	
+	opt = kzalloc(sizeof(struct ceph_options), GFP_KERNEL);
+	if (!opt)
+		return NULL;
+
+	opt->mon_addr = kcalloc(CEPH_MAX_MON, sizeof(*opt->mon_addr), GFP_KERNEL);
+	if (!opt->mon_addr) {
+		kfree(opt);
+		return NULL;
+	}
+
+	opt->flags = CEPH_OPT_DEFAULT;
+	opt->osd_keepalive_timeout = CEPH_OSD_KEEPALIVE_DEFAULT;
+	opt->mount_timeout = CEPH_MOUNT_TIMEOUT_DEFAULT;
+	opt->osd_idle_ttl = CEPH_OSD_IDLE_TTL_DEFAULT;
+	opt->osd_request_timeout = CEPH_OSD_REQUEST_TIMEOUT_DEFAULT;
+	return opt;
+}
+EXPORT_SYMBOL(ceph_alloc_options);
+
 void ceph_destroy_options(struct ceph_options *opt)
 {
-	dout("destroy_options %p\n", opt);
-	kfree(opt->name);
-	if (opt->key) {
-		ceph_crypto_key_destroy(opt->key);
-		kfree(opt->key);
+	if (opt) {
+		dout("destroy_options %p\n", opt);
+		kfree(opt->name);
+		if (opt->key) {
+			ceph_crypto_key_destroy(opt->key);
+			kfree(opt->key);
+		}
+		kfree(opt->mon_addr);
+		kfree(opt);
 	}
-	kfree(opt->mon_addr);
-	kfree(opt);
 }
 EXPORT_SYMBOL(ceph_destroy_options);
 
@@ -344,217 +358,141 @@ static int get_secret(struct ceph_crypto_key *dst, const char *name) {
 	return err;
 }
 
-struct ceph_options *
-ceph_parse_options(char *options, const char *dev_name,
-			const char *dev_name_end,
-			int (*parse_extra_token)(char *c, void *private),
-			void *private)
+int ceph_parse_server_specs(struct ceph_options *opt, struct fs_context *fc,
+			    const char *data, size_t size)
 {
-	struct ceph_options *opt;
-	const char *c;
-	int err = -ENOMEM;
-	substring_t argstr[MAX_OPT_ARGS];
-
-	opt = kzalloc(sizeof(*opt), GFP_KERNEL);
-	if (!opt)
-		return ERR_PTR(-ENOMEM);
-	opt->mon_addr = kcalloc(CEPH_MAX_MON, sizeof(*opt->mon_addr),
-				GFP_KERNEL);
-	if (!opt->mon_addr)
-		goto out;
-
-	dout("parse_options %p options '%s' dev_name '%s'\n", opt, options,
-	     dev_name);
-
-	/* start with defaults */
-	opt->flags = CEPH_OPT_DEFAULT;
-	opt->osd_keepalive_timeout = CEPH_OSD_KEEPALIVE_DEFAULT;
-	opt->mount_timeout = CEPH_MOUNT_TIMEOUT_DEFAULT;
-	opt->osd_idle_ttl = CEPH_OSD_IDLE_TTL_DEFAULT;
-	opt->osd_request_timeout = CEPH_OSD_REQUEST_TIMEOUT_DEFAULT;
-
 	/* get mon ip(s) */
 	/* ip1[:port1][,ip2[:port2]...] */
-	err = ceph_parse_ips(dev_name, dev_name_end, opt->mon_addr,
-			     CEPH_MAX_MON, &opt->num_mon);
-	if (err < 0)
-		goto out;
+	return ceph_parse_ips(data, data + size,
+			      opt->mon_addr, CEPH_MAX_MON, &opt->num_mon);
+}
+EXPORT_SYMBOL(ceph_parse_server_specs);
 
-	/* parse mount options */
-	while ((c = strsep(&options, ",")) != NULL) {
-		int token, intval;
-		if (!*c)
-			continue;
-		err = -EINVAL;
-		token = match_token((char *)c, opt_tokens, argstr);
-		if (token < 0 && parse_extra_token) {
-			/* extra? */
-			err = parse_extra_token((char *)c, private);
-			if (err < 0) {
-				pr_err("bad option at '%s'\n", c);
-				goto out;
-			}
-			continue;
-		}
-		if (token < Opt_last_int) {
-			err = match_int(&argstr[0], &intval);
-			if (err < 0) {
-				pr_err("bad option arg (not int) at '%s'\n", c);
-				goto out;
-			}
-			dout("got int token %d val %d\n", token, intval);
-		} else if (token > Opt_last_int && token < Opt_last_string) {
-			dout("got string token %d val %s\n", token,
-			     argstr[0].from);
-		} else {
-			dout("got token %d\n", token);
-		}
-		switch (token) {
-		case Opt_ip:
-			err = ceph_parse_ips(argstr[0].from,
-					     argstr[0].to,
-					     &opt->my_addr,
-					     1, NULL);
-			if (err < 0)
-				goto out;
+int ceph_parse_option(struct ceph_options *opt, struct fs_context *fc,
+		      struct fs_parameter *param)
+{
+	struct fs_parse_result result;
+	int token, err;
+
+	dout("parse_option '%s'\n", param->key);
+
+	token = fs_parse(fc, &ceph_options, param, &result);
+	if (token < 0)
+		return token;
+
+	switch (token) {
+	case Opt_ip:
+		err = ceph_parse_ips(param->string,
+				     param->string + param->size,
+				     &opt->my_addr,
+				     1, NULL);
+		if (err == 0)
 			opt->flags |= CEPH_OPT_MYIP;
-			break;
+		break;
 
-		case Opt_fsid:
-			err = parse_fsid(argstr[0].from, &opt->fsid);
-			if (err == 0)
-				opt->flags |= CEPH_OPT_FSID;
-			break;
-		case Opt_name:
-			kfree(opt->name);
-			opt->name = kstrndup(argstr[0].from,
-					      argstr[0].to-argstr[0].from,
-					      GFP_KERNEL);
-			if (!opt->name) {
-				err = -ENOMEM;
-				goto out;
-			}
-			break;
-		case Opt_secret:
-			ceph_crypto_key_destroy(opt->key);
-			kfree(opt->key);
-
-		        opt->key = kzalloc(sizeof(*opt->key), GFP_KERNEL);
-			if (!opt->key) {
-				err = -ENOMEM;
-				goto out;
-			}
-			err = ceph_crypto_key_unarmor(opt->key, argstr[0].from);
-			if (err < 0)
-				goto out;
-			break;
-		case Opt_key:
-			ceph_crypto_key_destroy(opt->key);
-			kfree(opt->key);
-
-		        opt->key = kzalloc(sizeof(*opt->key), GFP_KERNEL);
-			if (!opt->key) {
-				err = -ENOMEM;
-				goto out;
-			}
-			err = get_secret(opt->key, argstr[0].from);
-			if (err < 0)
-				goto out;
-			break;
+	case Opt_fsid:
+		err = parse_fsid(param->string, &opt->fsid);
+		if (err < 0)
+			return invalf(fc, "Invalid fsid");
+		opt->flags |= CEPH_OPT_FSID;
+		break;
+	case Opt_name:
+		kfree(opt->name);
+		opt->name = param->string;
+		param->string = NULL;
+		break;
+	case Opt_secret:
+		ceph_crypto_key_destroy(opt->key);
+		kfree(opt->key);
 
-			/* misc */
-		case Opt_osdtimeout:
-			pr_warn("ignoring deprecated osdtimeout option\n");
-			break;
-		case Opt_osdkeepalivetimeout:
-			/* 0 isn't well defined right now, reject it */
-			if (intval < 1 || intval > INT_MAX / 1000) {
-				pr_err("osdkeepalive out of range\n");
-				err = -EINVAL;
-				goto out;
-			}
-			opt->osd_keepalive_timeout =
-					msecs_to_jiffies(intval * 1000);
-			break;
-		case Opt_osd_idle_ttl:
-			/* 0 isn't well defined right now, reject it */
-			if (intval < 1 || intval > INT_MAX / 1000) {
-				pr_err("osd_idle_ttl out of range\n");
-				err = -EINVAL;
-				goto out;
-			}
-			opt->osd_idle_ttl = msecs_to_jiffies(intval * 1000);
-			break;
-		case Opt_mount_timeout:
-			/* 0 is "wait forever" (i.e. infinite timeout) */
-			if (intval < 0 || intval > INT_MAX / 1000) {
-				pr_err("mount_timeout out of range\n");
-				err = -EINVAL;
-				goto out;
-			}
-			opt->mount_timeout = msecs_to_jiffies(intval * 1000);
-			break;
-		case Opt_osd_request_timeout:
-			/* 0 is "wait forever" (i.e. infinite timeout) */
-			if (intval < 0 || intval > INT_MAX / 1000) {
-				pr_err("osd_request_timeout out of range\n");
-				err = -EINVAL;
-				goto out;
-			}
-			opt->osd_request_timeout = msecs_to_jiffies(intval * 1000);
-			break;
+		opt->key = kzalloc(sizeof(*opt->key), GFP_KERNEL);
+		if (!opt->key)
+			return -ENOMEM;
+		return ceph_crypto_key_unarmor(opt->key, param->string);
+	case Opt_key:
+		ceph_crypto_key_destroy(opt->key);
+		kfree(opt->key);
 
-		case Opt_share:
+		opt->key = kzalloc(sizeof(*opt->key), GFP_KERNEL);
+		if (!opt->key)
+			return -ENOMEM;
+		return get_secret(opt->key, param->string);
+
+		/* misc */
+	case Opt_osdkeepalivetimeout:
+		/* 0 isn't well defined right now, reject it */
+		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
+			goto out_of_range;
+		opt->osd_keepalive_timeout =
+			msecs_to_jiffies(result.uint_32 * 1000);
+		break;
+	case Opt_osd_idle_ttl:
+		/* 0 isn't well defined right now, reject it */
+		if (result.uint_32 < 1 || result.uint_32 > INT_MAX / 1000)
+			goto out_of_range;
+		opt->osd_idle_ttl = msecs_to_jiffies(result.uint_32 * 1000);
+		break;
+	case Opt_mount_timeout:
+		/* 0 is "wait forever" (i.e. infinite timeout) */
+		if (result.uint_32 > INT_MAX / 1000)
+			goto out_of_range;
+		opt->mount_timeout = msecs_to_jiffies(result.uint_32 * 1000);
+		break;
+	case Opt_osd_request_timeout:
+		/* 0 is "wait forever" (i.e. infinite timeout) */
+		if (result.uint_32 > INT_MAX / 1000)
+			goto out_of_range;
+		opt->osd_request_timeout = msecs_to_jiffies(result.uint_32 * 1000);
+		break;
+
+	case Opt_share:
+		if (!result.negated)
 			opt->flags &= ~CEPH_OPT_NOSHARE;
-			break;
-		case Opt_noshare:
+		else
 			opt->flags |= CEPH_OPT_NOSHARE;
-			break;
+		break;
 
-		case Opt_crc:
+	case Opt_crc:
+		if (!result.negated)
 			opt->flags &= ~CEPH_OPT_NOCRC;
-			break;
-		case Opt_nocrc:
+		else
 			opt->flags |= CEPH_OPT_NOCRC;
-			break;
+		break;
 
-		case Opt_cephx_require_signatures:
+	case Opt_cephx_require_signatures:
+		if (!result.negated)
 			opt->flags &= ~CEPH_OPT_NOMSGAUTH;
-			break;
-		case Opt_nocephx_require_signatures:
+		else
 			opt->flags |= CEPH_OPT_NOMSGAUTH;
-			break;
-		case Opt_cephx_sign_messages:
+		break;
+	case Opt_cephx_sign_messages:
+		if (!result.negated)
 			opt->flags &= ~CEPH_OPT_NOMSGSIGN;
-			break;
-		case Opt_nocephx_sign_messages:
+		else
 			opt->flags |= CEPH_OPT_NOMSGSIGN;
-			break;
+		break;
 
-		case Opt_tcp_nodelay:
+	case Opt_tcp_nodelay:
+		if (!result.negated)
 			opt->flags |= CEPH_OPT_TCP_NODELAY;
-			break;
-		case Opt_notcp_nodelay:
+		else
 			opt->flags &= ~CEPH_OPT_TCP_NODELAY;
-			break;
+		break;
 
-		case Opt_abort_on_full:
-			opt->flags |= CEPH_OPT_ABORT_ON_FULL;
-			break;
+	case Opt_abort_on_full:
+		opt->flags |= CEPH_OPT_ABORT_ON_FULL;
+		break;
 
-		default:
-			BUG_ON(token);
-		}
+	default:
+		BUG();
 	}
 
-	/* success */
-	return opt;
+	return 0;
 
-out:
-	ceph_destroy_options(opt);
-	return ERR_PTR(err);
+out_of_range:
+	return invalf(fc, "ceph: %s out of range", param->key);
 }
-EXPORT_SYMBOL(ceph_parse_options);
+EXPORT_SYMBOL(ceph_parse_option);
 
 int ceph_print_client_options(struct seq_file *m, struct ceph_client *client,
 			      bool show_all)
-- 
2.21.0

