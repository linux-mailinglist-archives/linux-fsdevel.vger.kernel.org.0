Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEC47B6B99
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 16:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240073AbjJCOar (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 10:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234771AbjJCOaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:30:46 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDA0B8;
        Tue,  3 Oct 2023 07:30:43 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57b9193b1aeso2216056eaf.0;
        Tue, 03 Oct 2023 07:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696343442; x=1696948242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZstzgmbCrRGGMKdRCSRnIclBiZWzyYp4laelZbLL3yw=;
        b=Ph/T9/4yYUXKOJVumOuHLwic5jQOO4mgokwvs6bENkgEMQPTVwpnvJCYb6t308pTa2
         EMVs+S+ppfTi2dc8YukIpWQgXlZfZTn6fh/RjYolmqKexSZ2wrBIcBnc23oVVptFQFfp
         u4PBsGVFpvrFlwFQWErzVQ8d3QbWIiqjogX/R1fdGBLfoLgudN7MmWpwYe6L2km/S/I7
         Xr+Mqf/46SA1UZCHXImwXYQ5n+I3tkdB0O/LuO0ZB28bRPX+9+5fc07GdgLg9GeXpmkM
         o8N7nskYFXEGjwNDwt56et5k0onh7xeHijGqXQU/LMZba1PbodkwN/OJzo26q/7dju3V
         ArWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696343442; x=1696948242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZstzgmbCrRGGMKdRCSRnIclBiZWzyYp4laelZbLL3yw=;
        b=E/eJgvepXtYUiP8XHs+p2q72p8s6FzQa8D1fmV7MDNdSQFxxDojsI+3keWZR+rlHOl
         Pc2zbQO4WuZqMepMtI2n0jprB1WYouc4TkgfLJ9LumjzF2CjxOPiKDFIJE8oDdpqlng0
         hl5JRpn0dFyTyq2KajjUmecJZO57wqphL5lemjxtq2vBRf0UN9kqApaOosB5h2UtXRTs
         rsLcuG+mHHf34bRODE+KAc2zcMPVLJUhnY9Kw7RJBUDZmWB31MdLyaJvnXJH1yDKEslA
         8Te2thZT5431oajz3Q4mTujg8GTyNrthOX5vqJ9LoECC2wHYhSW0tYpzm5H6WplDB2Xf
         byWQ==
X-Gm-Message-State: AOJu0YwKvenBQGSYrE3PPy7RBJJf3HlMuDs1Mp2iyGXCujrreKULKvRZ
        W/M/Bt+oWvp4CcnYl/M3aY2nP3sYDGS78f316cA=
X-Google-Smtp-Source: AGHT+IGevci/5HJowvgG2jQWYPBEjrm3GBqGe2+WKPqkm8/eoWfupkx7ZuH4Uq1Sh1zAE91zKHa+9sENOnJ9wfnMrIU=
X-Received: by 2002:a05:6870:91d2:b0:1c8:c9ca:7092 with SMTP id
 c18-20020a05687091d200b001c8c9ca7092mr1476751oaf.11.1696343442442; Tue, 03
 Oct 2023 07:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230930050033.41174-1-wedsonaf@gmail.com> <20230930050033.41174-7-wedsonaf@gmail.com>
In-Reply-To: <20230930050033.41174-7-wedsonaf@gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 3 Oct 2023 16:30:29 +0200
Message-ID: <CAOi1vP_ew49EJZwasWQ3rhOs_ZUhnSVCWOSwVemV3f5yPdva5A@mail.gmail.com>
Subject: Re: [PATCH 06/29] ceph: move ceph_xattr_handlers to .rodata
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Xiubo Li <xiubli@redhat.com>, Jeff Layton <jlayton@kernel.org>,
        ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 30, 2023 at 7:01=E2=80=AFAM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This makes it harder for accidental or malicious changes to
> ceph_xattr_handlers at runtime.
>
> Cc: Xiubo Li <xiubli@redhat.com>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> Cc: ceph-devel@vger.kernel.org
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  fs/ceph/super.h | 2 +-
>  fs/ceph/xattr.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 3bfddf34d488..b40be1a0f778 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -1089,7 +1089,7 @@ ssize_t __ceph_getxattr(struct inode *, const char =
*, void *, size_t);
>  extern ssize_t ceph_listxattr(struct dentry *, char *, size_t);
>  extern struct ceph_buffer *__ceph_build_xattrs_blob(struct ceph_inode_in=
fo *ci);
>  extern void __ceph_destroy_xattrs(struct ceph_inode_info *ci);
> -extern const struct xattr_handler *ceph_xattr_handlers[];
> +extern const struct xattr_handler * const ceph_xattr_handlers[];
>
>  struct ceph_acl_sec_ctx {
>  #ifdef CONFIG_CEPH_FS_POSIX_ACL
> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> index 806183959c47..0350d7465bbb 100644
> --- a/fs/ceph/xattr.c
> +++ b/fs/ceph/xattr.c
> @@ -1416,7 +1416,7 @@ void ceph_release_acl_sec_ctx(struct ceph_acl_sec_c=
tx *as_ctx)
>   * List of handlers for synthetic system.* attributes. Other
>   * attributes are handled directly.
>   */
> -const struct xattr_handler *ceph_xattr_handlers[] =3D {
> +const struct xattr_handler * const ceph_xattr_handlers[] =3D {
>         &ceph_other_xattr_handler,
>         NULL,
>  };
> --
> 2.34.1
>

Acked-by: Ilya Dryomov <idryomov@gmail.com>

Thanks,

                Ilya
