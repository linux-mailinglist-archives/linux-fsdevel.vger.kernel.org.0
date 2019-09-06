Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2FA9ABB9A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 17:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393078AbfIFPAV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 11:00:21 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33232 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbfIFPAV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:00:21 -0400
Received: by mail-io1-f68.google.com with SMTP id m11so13444378ioo.0;
        Fri, 06 Sep 2019 08:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5YYzf1LfXGSECTRxReCou7Cbs5AhXTNOCEGWroTzVj0=;
        b=RpihAMh17wZM6RD9YDcXuH0rGkbu+YzytMa0bXFbPz8jlOsUkitM/I0LVM5dXEkxMO
         quq0ShOKwix025gpCMy09CgnBsI2Oc0jeWwloWBNi9I0cu5CSucvFitoVw3UEsbk6mKE
         q69ET0P4o+XqsPYZSpISpVDyGGVoSoLJsCRAN1oGuJ8r4wCFTtxlEBq5FYYC/DLRFHwv
         gfCo5VbTXU4Go3NDOV3jp3PdKpINeQiNLyzEMvAB4nB0FmCWJXjdl5W7Xn00J6/dggE0
         4fsHVl/xl1XhDymclm3uuSRcaAAY7rUIMoBKZd/VqYXBDrZ6B06tDEp1GOitNe8eeEjX
         UMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5YYzf1LfXGSECTRxReCou7Cbs5AhXTNOCEGWroTzVj0=;
        b=auRsoVRt6kIYtwUAyGZN6xlscD+RfiuwnkYnG1DWPXW2/vzbLXC6L0pIIVT/bexxuZ
         WYYbXXCHj7HAQbe9kp1/N8vtRtbKQs4SQUBK4EofOIIK6gE8SYsSaqBz79UQI50UIQ5u
         yLzQcDVGlvL057e5liZXDWabZEAavnr85iBpJMhvPqnukvF+h4VoDs6BCiMVTnrph/FI
         pK/Onfe0/OLBTZUFUhUFEmK34Xb3dBh1D/uRH2bHfcG8SceNM6JuFk08VPmIZk+GFgt+
         5eRFztMpPm5GMa7PFKyA5WJJawfjx5diW/UlGJn1H49zu29bokKTbdtT/gchbQf3q60q
         Ilug==
X-Gm-Message-State: APjAAAWHl35DxthpUyXT7+RuIGNTmjctQI801S3Xh38Sl2DPKpCU/yzH
        ZBIv1VcBSbGWAKcigcW3mPokorZnFqnvLnvqdL3d6do8hpE=
X-Google-Smtp-Source: APXvYqzQHZCKeh5TySMvyMbyx3u6uInLVIstDmK1Di7bY6wBM2d6XqIgOfRXoV8/aTRW5gxzJyo/8v3khCwvIuj5Heg=
X-Received: by 2002:a5d:938a:: with SMTP id c10mr6536561iol.131.1567782019572;
 Fri, 06 Sep 2019 08:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190906101618.8939-1-jlayton@kernel.org>
In-Reply-To: <20190906101618.8939-1-jlayton@kernel.org>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Fri, 6 Sep 2019 17:00:09 +0200
Message-ID: <CAOi1vP-3aHy8yerpMkmA80WF1=e4umg_zCt8Dvc+X6V8-Dg+Qw@mail.gmail.com>
Subject: Re: [PATCH v3] ceph: Convert ceph to use the new mount API
To:     Jeff Layton <jlayton@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ceph Development <ceph-devel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Yan, Zheng" <zyan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 6, 2019 at 12:16 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> From: David Howells <dhowells@redhat.com>
>
> Convert the ceph filesystem to the new internal mount API as the old
> one will be obsoleted and removed.  This allows greater flexibility in
> communication of mount parameters between userspace, the VFS and the
> filesystem.
>
> See Documentation/filesystems/mount_api.txt for more information.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Sage Weil <sage@redhat.com>
> cc: ceph-devel@vger.kernel.org
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  drivers/block/rbd.c          | 344 +++++++++---------
>  fs/ceph/cache.c              |  10 +-
>  fs/ceph/cache.h              |   5 +-
>  fs/ceph/super.c              | 687 +++++++++++++++++------------------
>  fs/ceph/super.h              |   1 -
>  include/linux/ceph/libceph.h |  17 +-
>  net/ceph/ceph_common.c       | 410 +++++++++------------
>  7 files changed, 718 insertions(+), 756 deletions(-)
>
> v3: fix string handling bugs for key-only rbd options
>
> v2: fix several string parsing bugs in rbd_add_parse_args and rbd_parse_monolithic
>     prefix rbd log message with "rbd:"
>     drop unneeded #undef from ceph_debug.h
>     drop unrelated comment fixes in fs/fs_*.c
>     rebase onto current ceph/testing branch
>
> Ilya, hopefully third time is the charm. This fixes rbd key-only option
> parsing for me.

Nope, this is still buggy.  Attempting to map a non-existing image
seems to be corrupting memory.  "sudo rbd map foobar" in a loop quickly
leads to random GP faults.

>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index c3df76a862d2..8a7f996e228f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -34,7 +34,7 @@
>  #include <linux/ceph/cls_lock_client.h>
>  #include <linux/ceph/striper.h>
>  #include <linux/ceph/decode.h>
> -#include <linux/parser.h>
> +#include <linux/fs_parser.h>
>  #include <linux/bsearch.h>
>
>  #include <linux/kernel.h>
> @@ -823,34 +823,12 @@ enum {
>         Opt_queue_depth,
>         Opt_alloc_size,
>         Opt_lock_timeout,
> -       Opt_last_int,
> -       /* int args above */
>         Opt_pool_ns,
> -       Opt_last_string,
> -       /* string args above */
>         Opt_read_only,
>         Opt_read_write,
>         Opt_lock_on_read,
>         Opt_exclusive,
>         Opt_notrim,
> -       Opt_err
> -};
> -
> -static match_table_t rbd_opts_tokens = {
> -       {Opt_queue_depth, "queue_depth=%d"},
> -       {Opt_alloc_size, "alloc_size=%d"},
> -       {Opt_lock_timeout, "lock_timeout=%d"},
> -       /* int args above */
> -       {Opt_pool_ns, "_pool_ns=%s"},
> -       /* string args above */
> -       {Opt_read_only, "read_only"},
> -       {Opt_read_only, "ro"},          /* Alternate spelling */
> -       {Opt_read_write, "read_write"},
> -       {Opt_read_write, "rw"},         /* Alternate spelling */
> -       {Opt_lock_on_read, "lock_on_read"},
> -       {Opt_exclusive, "exclusive"},
> -       {Opt_notrim, "notrim"},
> -       {Opt_err, NULL}
>  };
>
>  struct rbd_options {
> @@ -871,85 +849,86 @@ struct rbd_options {
>  #define RBD_EXCLUSIVE_DEFAULT  false
>  #define RBD_TRIM_DEFAULT       true
>
> -struct parse_rbd_opts_ctx {
> -       struct rbd_spec         *spec;
> -       struct rbd_options      *opts;
> +static const struct fs_parameter_spec rbd_param_specs[] = {
> +       fsparam_u32     ("alloc_size",                  Opt_alloc_size),
> +       fsparam_flag    ("exclusive",                   Opt_exclusive),
> +       fsparam_flag    ("lock_on_read",                Opt_lock_on_read),
> +       fsparam_u32     ("lock_timeout",                Opt_lock_timeout),
> +       fsparam_flag    ("notrim",                      Opt_notrim),
> +       fsparam_string  ("_pool_ns",                    Opt_pool_ns),
> +       fsparam_u32     ("queue_depth",                 Opt_queue_depth),
> +       fsparam_flag    ("ro",                          Opt_read_only),
> +       fsparam_flag    ("rw",                          Opt_read_write),

The existing code recognizes both ro and read_only, and both rw and
read_write.  The new code only recognizes ro and rw.  I don't think
anybody uses read_only and read_write, but they are trivial to keep
and certainly should not have been dropped without a note.

I'm still getting errno = 519 on an unknown option (random junk or
read_only/read_write because they are no longer known).  The existing
code returns EINVAL for this case.

> +       {}
> +};
> +
> +static const struct fs_parameter_description rbd_parameters = {
> +       .name           = "rbd",
> +       .specs          = rbd_param_specs,
>  };
>
> -static int parse_rbd_opts_token(char *c, void *private)
> +static int rbd_parse_param(struct ceph_config_context *ctx, struct fs_parameter *param)
>  {
> -       struct parse_rbd_opts_ctx *pctx = private;
> -       substring_t argstr[MAX_OPT_ARGS];
> -       int token, intval, ret;
> +       struct rbd_options *opts = ctx->rbd_opts;
> +       struct rbd_spec *spec = ctx->rbd_spec;
> +       struct fs_parse_result result;
> +       int ret, opt;
>
> -       token = match_token(c, rbd_opts_tokens, argstr);
> -       if (token < Opt_last_int) {
> -               ret = match_int(&argstr[0], &intval);
> -               if (ret < 0) {
> -                       pr_err("bad option arg (not int) at '%s'\n", c);
> -                       return ret;
> -               }
> -               dout("got int token %d val %d\n", token, intval);
> -       } else if (token > Opt_last_int && token < Opt_last_string) {
> -               dout("got string token %d val %s\n", token, argstr[0].from);
> -       } else {
> -               dout("got token %d\n", token);
> -       }
> +       ret = ceph_parse_option(ctx->opt, NULL, param);
> +       if (ret != -ENOPARAM)
> +               return ret;
>
> -       switch (token) {
> +       opt = fs_parse(NULL, &rbd_parameters, param, &result);
> +       if (opt < 0)
> +               return opt;
> +
> +       switch (opt) {
>         case Opt_queue_depth:
> -               if (intval < 1) {
> -                       pr_err("queue_depth out of range\n");
> -                       return -EINVAL;
> -               }
> -               pctx->opts->queue_depth = intval;
> +               if (result.uint_32 < 1)
> +                       goto out_of_range;
> +               opts->queue_depth = result.uint_32;
>                 break;
>         case Opt_alloc_size:
> -               if (intval < SECTOR_SIZE) {
> -                       pr_err("alloc_size out of range\n");
> -                       return -EINVAL;
> -               }
> -               if (!is_power_of_2(intval)) {
> -                       pr_err("alloc_size must be a power of 2\n");
> -                       return -EINVAL;
> -               }
> -               pctx->opts->alloc_size = intval;
> +               if (result.uint_32 < SECTOR_SIZE)
> +                       goto out_of_range;
> +               if (!is_power_of_2(result.uint_32))
> +                       return invalf(NULL, "alloc_size must be a power of 2\n");
> +               opts->alloc_size = result.uint_32;
>                 break;
>         case Opt_lock_timeout:
>                 /* 0 is "wait forever" (i.e. infinite timeout) */
> -               if (intval < 0 || intval > INT_MAX / 1000) {
> -                       pr_err("lock_timeout out of range\n");
> -                       return -EINVAL;
> -               }
> -               pctx->opts->lock_timeout = msecs_to_jiffies(intval * 1000);
> +               if (result.uint_32 > INT_MAX / 1000)
> +                       goto out_of_range;
> +               opts->lock_timeout = msecs_to_jiffies(result.uint_32 * 1000);
>                 break;
>         case Opt_pool_ns:
> -               kfree(pctx->spec->pool_ns);
> -               pctx->spec->pool_ns = match_strdup(argstr);
> -               if (!pctx->spec->pool_ns)
> -                       return -ENOMEM;
> +               kfree(spec->pool_ns);
> +               spec->pool_ns = param->string;
> +               param->string = NULL;
>                 break;
>         case Opt_read_only:
> -               pctx->opts->read_only = true;
> +               opts->read_only = true;
>                 break;
>         case Opt_read_write:
> -               pctx->opts->read_only = false;
> +               opts->read_only = false;
>                 break;
>         case Opt_lock_on_read:
> -               pctx->opts->lock_on_read = true;
> +               opts->lock_on_read = true;
>                 break;
>         case Opt_exclusive:
> -               pctx->opts->exclusive = true;
> +               opts->exclusive = true;
>                 break;
>         case Opt_notrim:
> -               pctx->opts->trim = false;
> +               opts->trim = false;
>                 break;
>         default:
> -               /* libceph prints "bad option" msg */
>                 return -EINVAL;
>         }
>
>         return 0;
> +
> +out_of_range:
> +       return invalf(NULL, "rbd: %s out of range", param->key);
>  }
>
>  static char* obj_op_name(enum obj_operation_type op_type)
> @@ -6438,22 +6417,85 @@ static inline size_t next_token(const char **buf)
>   *
>   * Note: uses GFP_KERNEL for allocation.
>   */
> -static inline char *dup_token(const char **buf, size_t *lenp)
> +static inline char *dup_token(const char **buf)
>  {
>         char *dup;
>         size_t len;
>
>         len = next_token(buf);
> -       dup = kmemdup(*buf, len + 1, GFP_KERNEL);
> -       if (!dup)
> -               return NULL;
> -       *(dup + len) = '\0';
> -       *buf += len;
> +       dup = kmemdup_nul(*buf, len, GFP_KERNEL);
> +       if (dup)
> +               *buf += len;
> +       return dup;
> +}
> +
> +/*
> + * Parse the parameter string.
> + */
> +static int rbd_parse_monolithic(struct ceph_config_context *ctx, size_t len,
> +                               const char *data)
> +{
> +       const char *sep, *key, *eq, *value;
> +       char key_buf[32];
> +       size_t size, klen;
> +       int ret = 0;
>
> -       if (lenp)
> -               *lenp = len;
> +       struct fs_parameter param = {
> +               .key    = key_buf,
> +               .type   = fs_value_is_string,
> +       };
>
> -       return dup;
> +       do {
> +               key = data;
> +               sep = strchr(data, ',');
> +               if (sep) {
> +                       data = sep + 1;
> +                       size = sep - key;
> +                       len -= size + 1;
> +               } else {
> +                       data = NULL;
> +                       size = len;
> +                       len -= size;
> +               }
> +
> +               if (!size)
> +                       continue;
> +
> +               eq = memchr(key, '=', size);
> +               if (eq) {
> +                       klen = eq - key;
> +                       if (klen == 0)
> +                               return invalf(NULL, "Invalid option \"\"");
> +                       value = eq + 1;
> +                       param.size = size - klen - 1;
> +               } else {
> +                       klen = size;
> +                       value = NULL;
> +                       param.size = 0;
> +               }
> +
> +               if (klen >= sizeof(key_buf))
> +                       return invalf(NULL, "Unknown option %*.*s",
> +                                     (int)klen, (int)klen, key);
> +               memcpy(key_buf, key, klen);
> +               key_buf[klen] = 0;
> +
> +               if (param.size > 0) {
> +                       param.string = kmemdup_nul(value, param.size,
> +                                                  GFP_KERNEL);
> +                       if (!param.string)
> +                               return -ENOMEM;
> +               } else {
> +                       param.string = NULL;
> +               }
> +
> +               ret = rbd_parse_param(ctx, &param);
> +               kfree(param.string);
> +               if (ret < 0)
> +                       break;
> +       } while (data);
> +
> +       return ret;
>  }
>
>  /*
> @@ -6497,18 +6539,11 @@ static inline char *dup_token(const char **buf, size_t *lenp)
>   *      created.  The image head is used if no snapshot id is
>   *      provided.  Snapshot mappings are always read-only.
>   */
> -static int rbd_add_parse_args(const char *buf,
> -                               struct ceph_options **ceph_opts,
> -                               struct rbd_options **opts,
> -                               struct rbd_spec **rbd_spec)
> +static int rbd_add_parse_args(const char *buf, struct ceph_config_context *ctx)
>  {
> -       size_t len;
> -       char *options;
> -       const char *mon_addrs;
> +       const char *options, *mon_addrs;
> +       size_t len, options_len, mon_addrs_size;
>         char *snap_name;
> -       size_t mon_addrs_size;
> -       struct parse_rbd_opts_ctx pctx = { 0 };
> -       struct ceph_options *copts;
>         int ret;
>
>         /* The first four tokens are required */
> @@ -6519,36 +6554,35 @@ static int rbd_add_parse_args(const char *buf,
>                 return -EINVAL;
>         }
>         mon_addrs = buf;
> -       mon_addrs_size = len + 1;
> +       mon_addrs_size = len;
>         buf += len;
>
> -       ret = -EINVAL;
> -       options = dup_token(&buf, NULL);
> -       if (!options)
> -               return -ENOMEM;
> -       if (!*options) {
> +       options_len = next_token(&buf);
> +       if (options_len == 0) {
>                 rbd_warn(NULL, "no options provided");
> -               goto out_err;
> +               return -EINVAL;
>         }
> +       options = buf;
> +       buf += options_len;
>
> -       pctx.spec = rbd_spec_alloc();
> -       if (!pctx.spec)
> -               goto out_mem;
> +       ctx->rbd_spec = rbd_spec_alloc();
> +       if (!ctx->rbd_spec)
> +               return -ENOMEM;
>
> -       pctx.spec->pool_name = dup_token(&buf, NULL);
> -       if (!pctx.spec->pool_name)
> -               goto out_mem;
> -       if (!*pctx.spec->pool_name) {
> +       ctx->rbd_spec->pool_name = dup_token(&buf);
> +       if (!ctx->rbd_spec->pool_name)
> +               return -ENOMEM;
> +       if (!*ctx->rbd_spec->pool_name) {
>                 rbd_warn(NULL, "no pool name provided");
> -               goto out_err;
> +               return -EINVAL;
>         }
>
> -       pctx.spec->image_name = dup_token(&buf, NULL);
> -       if (!pctx.spec->image_name)
> -               goto out_mem;
> -       if (!*pctx.spec->image_name) {
> +       ctx->rbd_spec->image_name = dup_token(&buf);
> +       if (!ctx->rbd_spec->image_name)
> +               return -ENOMEM;
> +       if (!*ctx->rbd_spec->image_name) {
>                 rbd_warn(NULL, "no image name provided");
> -               goto out_err;
> +               return -EINVAL;
>         }
>
>         /*
> @@ -6560,51 +6594,37 @@ static int rbd_add_parse_args(const char *buf,
>                 buf = RBD_SNAP_HEAD_NAME; /* No snapshot supplied */
>                 len = sizeof (RBD_SNAP_HEAD_NAME) - 1;
>         } else if (len > RBD_MAX_SNAP_NAME_LEN) {
> -               ret = -ENAMETOOLONG;
> -               goto out_err;
> +               return -ENAMETOOLONG;
>         }
> -       snap_name = kmemdup(buf, len + 1, GFP_KERNEL);
> +
> +       snap_name = kmemdup_nul(buf, len, GFP_KERNEL);
>         if (!snap_name)
> -               goto out_mem;
> -       *(snap_name + len) = '\0';
> -       pctx.spec->snap_name = snap_name;
> +               return -ENOMEM;
> +       ctx->rbd_spec->snap_name = snap_name;
>
>         /* Initialize all rbd options to the defaults */
>
> -       pctx.opts = kzalloc(sizeof(*pctx.opts), GFP_KERNEL);
> -       if (!pctx.opts)
> -               goto out_mem;
> -
> -       pctx.opts->read_only = RBD_READ_ONLY_DEFAULT;
> -       pctx.opts->queue_depth = RBD_QUEUE_DEPTH_DEFAULT;
> -       pctx.opts->alloc_size = RBD_ALLOC_SIZE_DEFAULT;
> -       pctx.opts->lock_timeout = RBD_LOCK_TIMEOUT_DEFAULT;
> -       pctx.opts->lock_on_read = RBD_LOCK_ON_READ_DEFAULT;
> -       pctx.opts->exclusive = RBD_EXCLUSIVE_DEFAULT;
> -       pctx.opts->trim = RBD_TRIM_DEFAULT;
> -
> -       copts = ceph_parse_options(options, mon_addrs,
> -                                  mon_addrs + mon_addrs_size - 1,
> -                                  parse_rbd_opts_token, &pctx);
> -       if (IS_ERR(copts)) {
> -               ret = PTR_ERR(copts);
> -               goto out_err;
> -       }
> -       kfree(options);
> +       ctx->rbd_opts = kzalloc(sizeof(*ctx->rbd_opts), GFP_KERNEL);
> +       if (!ctx->rbd_opts)
> +               return -ENOMEM;
>
> -       *ceph_opts = copts;
> -       *opts = pctx.opts;
> -       *rbd_spec = pctx.spec;
> +       ctx->rbd_opts->read_only = RBD_READ_ONLY_DEFAULT;
> +       ctx->rbd_opts->queue_depth = RBD_QUEUE_DEPTH_DEFAULT;
> +       ctx->rbd_opts->alloc_size = RBD_ALLOC_SIZE_DEFAULT;
> +       ctx->rbd_opts->lock_timeout = RBD_LOCK_TIMEOUT_DEFAULT;
> +       ctx->rbd_opts->lock_on_read = RBD_LOCK_ON_READ_DEFAULT;
> +       ctx->rbd_opts->exclusive = RBD_EXCLUSIVE_DEFAULT;
> +       ctx->rbd_opts->trim = RBD_TRIM_DEFAULT;
>
> -       return 0;
> -out_mem:
> -       ret = -ENOMEM;
> -out_err:
> -       kfree(pctx.opts);
> -       rbd_spec_put(pctx.spec);
> -       kfree(options);
> +       ctx->opt = ceph_alloc_options();
> +       if (!ctx->opt)
> +               return -ENOMEM;
>
> -       return ret;
> +       ret = ceph_parse_server_specs(ctx->opt, NULL, mon_addrs, mon_addrs_size);
> +       if (ret < 0)
> +               return ret;
> +
> +       return rbd_parse_monolithic(ctx, options_len, options);
>  }
>
>  static void rbd_dev_image_unlock(struct rbd_device *rbd_dev)
> @@ -7037,10 +7057,8 @@ static ssize_t do_rbd_add(struct bus_type *bus,
>                           const char *buf,
>                           size_t count)
>  {
> +       struct ceph_config_context ctx = {};
>         struct rbd_device *rbd_dev = NULL;
> -       struct ceph_options *ceph_opts = NULL;
> -       struct rbd_options *rbd_opts = NULL;
> -       struct rbd_spec *spec = NULL;
>         struct rbd_client *rbdc;
>         int rc;
>
> @@ -7048,33 +7066,34 @@ static ssize_t do_rbd_add(struct bus_type *bus,
>                 return -ENODEV;
>
>         /* parse add command */
> -       rc = rbd_add_parse_args(buf, &ceph_opts, &rbd_opts, &spec);
> +       rc = rbd_add_parse_args(buf, &ctx);
>         if (rc < 0)
>                 goto out;
>
> -       rbdc = rbd_get_client(ceph_opts);
> +       rbdc = rbd_get_client(ctx.opt);
>         if (IS_ERR(rbdc)) {
>                 rc = PTR_ERR(rbdc);
>                 goto err_out_args;
>         }
>
>         /* pick the pool */
> -       rc = ceph_pg_poolid_by_name(rbdc->client->osdc.osdmap, spec->pool_name);
> +       rc = ceph_pg_poolid_by_name(rbdc->client->osdc.osdmap,
> +                                   ctx.rbd_spec->pool_name);
>         if (rc < 0) {
>                 if (rc == -ENOENT)
> -                       pr_info("pool %s does not exist\n", spec->pool_name);
> +                       pr_info("pool %s does not exist\n", ctx.rbd_spec->pool_name);
>                 goto err_out_client;
>         }
> -       spec->pool_id = (u64)rc;
> +       ctx.rbd_spec->pool_id = (u64)rc;
>
> -       rbd_dev = rbd_dev_create(rbdc, spec, rbd_opts);
> +       rbd_dev = rbd_dev_create(rbdc, ctx.rbd_spec, ctx.rbd_opts);
>         if (!rbd_dev) {
>                 rc = -ENOMEM;
>                 goto err_out_client;
>         }
>         rbdc = NULL;            /* rbd_dev now owns this */
> -       spec = NULL;            /* rbd_dev now owns this */
> -       rbd_opts = NULL;        /* rbd_dev now owns this */
> +       ctx.rbd_spec = NULL;    /* rbd_dev now owns this */
> +       ctx.rbd_opts = NULL;    /* rbd_dev now owns this */
>
>         rbd_dev->config_info = kstrdup(buf, GFP_KERNEL);
>         if (!rbd_dev->config_info) {
> @@ -7139,8 +7158,9 @@ static ssize_t do_rbd_add(struct bus_type *bus,
>  err_out_client:
>         rbd_put_client(rbdc);
>  err_out_args:
> -       rbd_spec_put(spec);
> -       kfree(rbd_opts);
> +       rbd_spec_put(ctx.rbd_spec);
> +       kfree(ctx.rbd_opts);
> +       ceph_destroy_options(ctx.opt);
>         goto out;
>  }
>
> diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
> index b2ec29eeb4c4..20ce51d16f60 100644
> --- a/fs/ceph/cache.c
> +++ b/fs/ceph/cache.c
> @@ -7,7 +7,7 @@
>   */
>
>  #include <linux/ceph/ceph_debug.h>
> -
> +#include <linux/fs_context.h>
>  #include "super.h"
>  #include "cache.h"
>
> @@ -49,7 +49,7 @@ void ceph_fscache_unregister(void)
>         fscache_unregister_netfs(&ceph_cache_netfs);
>  }
>
> -int ceph_fscache_register_fs(struct ceph_fs_client* fsc)
> +int ceph_fscache_register_fs(struct fs_context *fc, struct ceph_fs_client* fsc)
>  {
>         const struct ceph_fsid *fsid = &fsc->client->fsid;
>         const char *fscache_uniq = fsc->mount_options->fscache_uniq;
> @@ -66,8 +66,8 @@ int ceph_fscache_register_fs(struct ceph_fs_client* fsc)
>                 if (uniq_len && memcmp(ent->uniquifier, fscache_uniq, uniq_len))
>                         continue;
>
> -               pr_err("fscache cookie already registered for fsid %pU\n", fsid);
> -               pr_err("  use fsc=%%s mount option to specify a uniquifier\n");
> +               errorf(fc, "fscache cookie already registered for fsid %pU\n", fsid);
> +               errorf(fc, "  use fsc=%%s mount option to specify a uniquifier\n");
>                 err = -EBUSY;
>                 goto out_unlock;
>         }
> @@ -95,7 +95,7 @@ int ceph_fscache_register_fs(struct ceph_fs_client* fsc)
>                 list_add_tail(&ent->list, &ceph_fscache_list);
>         } else {
>                 kfree(ent);
> -               pr_err("unable to register fscache cookie for fsid %pU\n",
> +               errorf(fc, "unable to register fscache cookie for fsid %pU\n",
>                        fsid);
>                 /* all other fs ignore this error */
>         }
> diff --git a/fs/ceph/cache.h b/fs/ceph/cache.h
> index e486fac3434d..f72328fd357b 100644
> --- a/fs/ceph/cache.h
> +++ b/fs/ceph/cache.h
> @@ -16,7 +16,7 @@ extern struct fscache_netfs ceph_cache_netfs;
>  int ceph_fscache_register(void);
>  void ceph_fscache_unregister(void);
>
> -int ceph_fscache_register_fs(struct ceph_fs_client* fsc);
> +int ceph_fscache_register_fs(struct fs_context *fc, struct ceph_fs_client* fsc);
>  void ceph_fscache_unregister_fs(struct ceph_fs_client* fsc);
>
>  void ceph_fscache_register_inode_cookie(struct inode *inode);
> @@ -88,7 +88,8 @@ static inline void ceph_fscache_unregister(void)
>  {
>  }
>
> -static inline int ceph_fscache_register_fs(struct ceph_fs_client* fsc)
> +static inline int ceph_fscache_register_fs(struct fs_context *fc,
> +                                          struct ceph_fs_client *fsc)
>  {
>         return 0;
>  }
> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
> index 03b63b1cd32c..5ccaec686eda 100644
> --- a/fs/ceph/super.c
> +++ b/fs/ceph/super.c
> @@ -9,7 +9,8 @@
>  #include <linux/in6.h>
>  #include <linux/module.h>
>  #include <linux/mount.h>
> -#include <linux/parser.h>
> +#include <linux/fs_context.h>
> +#include <linux/fs_parser.h>
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
> @@ -138,276 +139,305 @@ enum {
>         Opt_readdir_max_entries,
>         Opt_readdir_max_bytes,
>         Opt_congestion_kb,
> -       Opt_last_int,
> -       /* int args above */
>         Opt_snapdirname,
>         Opt_mds_namespace,
> -       Opt_fscache_uniq,
>         Opt_recover_session,
> -       Opt_last_string,
> -       /* string args above */
>         Opt_dirstat,
> -       Opt_nodirstat,
>         Opt_rbytes,
> -       Opt_norbytes,
>         Opt_asyncreaddir,
> -       Opt_noasyncreaddir,
>         Opt_dcache,
> -       Opt_nodcache,
>         Opt_ino32,
> -       Opt_noino32,
>         Opt_fscache,
> -       Opt_nofscache,
>         Opt_poolperm,
> -       Opt_nopoolperm,
>         Opt_require_active_mds,
> -       Opt_norequire_active_mds,
> -#ifdef CONFIG_CEPH_FS_POSIX_ACL
>         Opt_acl,
> -#endif
> -       Opt_noacl,
>         Opt_quotadf,
> -       Opt_noquotadf,
>         Opt_copyfrom,
> -       Opt_nocopyfrom,
> +       Opt_source,
>  };
>
> -static match_table_t fsopt_tokens = {
> -       {Opt_wsize, "wsize=%d"},
> -       {Opt_rsize, "rsize=%d"},
> -       {Opt_rasize, "rasize=%d"},
> -       {Opt_caps_wanted_delay_min, "caps_wanted_delay_min=%d"},
> -       {Opt_caps_wanted_delay_max, "caps_wanted_delay_max=%d"},
> -       {Opt_caps_max, "caps_max=%d"},
> -       {Opt_readdir_max_entries, "readdir_max_entries=%d"},
> -       {Opt_readdir_max_bytes, "readdir_max_bytes=%d"},
> -       {Opt_congestion_kb, "write_congestion_kb=%d"},
> -       /* int args above */
> -       {Opt_snapdirname, "snapdirname=%s"},
> -       {Opt_mds_namespace, "mds_namespace=%s"},
> -       {Opt_recover_session, "recover_session=%s"},
> -       {Opt_fscache_uniq, "fsc=%s"},
> -       /* string args above */
> -       {Opt_dirstat, "dirstat"},
> -       {Opt_nodirstat, "nodirstat"},
> -       {Opt_rbytes, "rbytes"},
> -       {Opt_norbytes, "norbytes"},
> -       {Opt_asyncreaddir, "asyncreaddir"},
> -       {Opt_noasyncreaddir, "noasyncreaddir"},
> -       {Opt_dcache, "dcache"},
> -       {Opt_nodcache, "nodcache"},
> -       {Opt_ino32, "ino32"},
> -       {Opt_noino32, "noino32"},
> -       {Opt_fscache, "fsc"},
> -       {Opt_nofscache, "nofsc"},
> -       {Opt_poolperm, "poolperm"},
> -       {Opt_nopoolperm, "nopoolperm"},
> -       {Opt_require_active_mds, "require_active_mds"},
> -       {Opt_norequire_active_mds, "norequire_active_mds"},
> -#ifdef CONFIG_CEPH_FS_POSIX_ACL
> -       {Opt_acl, "acl"},
> -#endif
> -       {Opt_noacl, "noacl"},
> -       {Opt_quotadf, "quotadf"},
> -       {Opt_noquotadf, "noquotadf"},
> -       {Opt_copyfrom, "copyfrom"},
> -       {Opt_nocopyfrom, "nocopyfrom"},
> -       {-1, NULL}
> +enum ceph_recover_session_mode {
> +       ceph_recover_session_no,
> +       ceph_recover_session_clean
> +};
> +
> +static const struct fs_parameter_enum ceph_param_enums[] = {
> +       { Opt_recover_session,  "no",           ceph_recover_session_no },
> +       { Opt_recover_session,  "clean",        ceph_recover_session_clean },
> +       {}
>  };
>
> -static int parse_fsopt_token(char *c, void *private)
> +static const struct fs_parameter_spec ceph_param_specs[] = {
> +       fsparam_flag_no ("acl",                         Opt_acl),
> +       fsparam_flag_no ("asyncreaddir",                Opt_asyncreaddir),
> +       fsparam_u32     ("caps_max",                    Opt_caps_max),
> +       fsparam_u32     ("caps_wanted_delay_max",       Opt_caps_wanted_delay_max),
> +       fsparam_u32     ("caps_wanted_delay_min",       Opt_caps_wanted_delay_min),
> +       fsparam_s32     ("write_congestion_kb",         Opt_congestion_kb),

I wonder why this is s32, while all other integer parameters are now
u32.  Anything less than 1024 is invalid here...

> +       fsparam_flag_no ("copyfrom",                    Opt_copyfrom),
> +       fsparam_flag_no ("dcache",                      Opt_dcache),
> +       fsparam_flag_no ("dirstat",                     Opt_dirstat),
> +       __fsparam       (fs_param_is_string, "fsc",     Opt_fscache,
> +                        fs_param_neg_with_no | fs_param_v_optional),
> +       fsparam_flag_no ("ino32",                       Opt_ino32),
> +       fsparam_string  ("mds_namespace",               Opt_mds_namespace),
> +       fsparam_flag_no ("poolperm",                    Opt_poolperm),
> +       fsparam_flag_no ("quotadf",                     Opt_quotadf),
> +       fsparam_u32     ("rasize",                      Opt_rasize),
> +       fsparam_flag_no ("rbytes",                      Opt_rbytes),
> +       fsparam_s32     ("readdir_max_bytes",           Opt_readdir_max_bytes),

Ditto, either 0 or >= PAGE_SIZE.

> +       fsparam_s32     ("readdir_max_entries",         Opt_readdir_max_entries),

Ditto, >= 1.

Thanks,

                Ilya
