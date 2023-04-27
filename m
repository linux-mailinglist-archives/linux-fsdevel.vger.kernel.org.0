Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC246F001F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Apr 2023 06:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240955AbjD0ES1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Apr 2023 00:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjD0ES0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Apr 2023 00:18:26 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D9C2D69;
        Wed, 26 Apr 2023 21:18:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50a145a0957so2926111a12.1;
        Wed, 26 Apr 2023 21:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682569102; x=1685161102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywLAlcqyQvHluUwFQO9OTiWkldgfOgI7xaqjeiQU70k=;
        b=eP3PsRBh4LThfm/B2qHH9aUGW3ldl4xCr3zvo1x0nlhzfn5AipMCJ8Z+vx/rgvii79
         PuFXVkKvX2zHKnaZjK7dLBLa9PJeDYZ7TSGbv5wf3sauylor4tVTQqOYNzJaAP6htHWa
         8jfcs5F4PlmgFylirtX8MpT2Nc8TcmHdRN5fHSm3mWGAGCj/zY1UR//xvlF882Uw5qAv
         AGB2m6FmAH5QG3KzvQJbeDLeydcQM7OVcDH1zUm/YILaWWhg5EZROYKqJ7ZItxixUGsK
         ODTvak+0J7QRd1nYThzhR1HXjKT+lATUD8SWW11DhpdTKRwpGTYgvZQ2cNHrpHgMOry8
         WprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682569102; x=1685161102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywLAlcqyQvHluUwFQO9OTiWkldgfOgI7xaqjeiQU70k=;
        b=V4uYcjnxK5mxoGyPHRx9GxE0lbLViIi+q1rfmFl7aAvm1PtxJ7QyZsOe44BvyLW/mv
         snz8g4VFD/0ntJQkw7bfwFKXOEqGhkunAB62Os5oi5CkcYFwkdK/Ksf+CyPv6NnJN+mO
         i4fE044wgi2HeEEziSzfyTXQI/c9a8Uq/T+6ZcSX56M4/SJTlCIQ3VooV5T0enq33VmR
         fI19WMrjkjP4RAeifKLuf0kFTfiS4q9i/jxUzRTi/64Bge++3rOBFeU6h/VudLkSWE8I
         k27+qWWMoJb6MSAKlVnYIFwW8yJWlaOKC13xcV8oeae6cp5M4KfzzgWqGvXF+EpQLzzM
         gnBQ==
X-Gm-Message-State: AC+VfDxJDzk/HzLe2a2eMir1EUhbvUV3NquV6b7XVrQQRknk9YtgNl+t
        tr1eTiKMS4WsQU3CIB6XjCOwdXLus0JZb2egxfE=
X-Google-Smtp-Source: ACHHUZ4gx0yHaEwwJfiMfzICPenX+Bjye26qFFKc4ujV3oc0Qo6zexrpA3fYqHHVSPmIEFQw4nTpvnStqk0H8b9ciE0=
X-Received: by 2002:aa7:d559:0:b0:504:8a2b:b3c7 with SMTP id
 u25-20020aa7d559000000b005048a2bb3c7mr447016edr.11.1682569101604; Wed, 26 Apr
 2023 21:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com> <20230418014037.2412394-29-drosen@google.com>
In-Reply-To: <20230418014037.2412394-29-drosen@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 26 Apr 2023 21:18:09 -0700
Message-ID: <CAEf4Bzb+suNcvM_tXBmYMzG0j9EH9kPW4F_x1s6ZEM118=tAAw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 28/37] WIP: bpf: Add fuse_ops struct_op programs
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 17, 2023 at 6:42=E2=80=AFPM Daniel Rosenberg <drosen@google.com=
> wrote:
>
> This introduces a new struct_op type: fuse_ops. This program set
> provides pre and post filters to run around fuse-bpf calls that act
> directly on the lower filesystem.
>
> The inputs are either fixed structures, or struct fuse_buffer's.
>
> These programs are not permitted to make any changes to these fuse_buffer=
s
> unless they create a dynptr wrapper using the supplied kfunc helpers.
>
> Fuse_buffers maintain additional state information that FUSE uses to
> manage memory and determine if additional set up or checks are needed.
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  include/linux/bpf_fuse.h          | 189 +++++++++++++++++++++++
>  kernel/bpf/Makefile               |   4 +
>  kernel/bpf/bpf_fuse.c             | 241 ++++++++++++++++++++++++++++++
>  kernel/bpf/bpf_struct_ops_types.h |   4 +
>  kernel/bpf/btf.c                  |   1 +
>  kernel/bpf/verifier.c             |   9 ++
>  6 files changed, 448 insertions(+)
>  create mode 100644 kernel/bpf/bpf_fuse.c
>
> diff --git a/include/linux/bpf_fuse.h b/include/linux/bpf_fuse.h
> index ce8b1b347496..780a7889aea2 100644
> --- a/include/linux/bpf_fuse.h
> +++ b/include/linux/bpf_fuse.h
> @@ -30,6 +30,8 @@ struct fuse_buffer {
>  #define BPF_FUSE_MODIFIED      (1 << 3) // The helper function allowed w=
rites to the buffer
>  #define BPF_FUSE_ALLOCATED     (1 << 4) // The helper function allocated=
 the buffer
>
> +extern void *bpf_fuse_get_writeable(struct fuse_buffer *arg, u64 size, b=
ool copy);
> +
>  /*
>   * BPF Fuse Args
>   *
> @@ -81,4 +83,191 @@ static inline unsigned bpf_fuse_arg_size(const struct=
 bpf_fuse_arg *arg)
>         return arg->is_buffer ? arg->buffer->size : arg->size;
>  }
>
> +struct fuse_ops {
> +       uint32_t (*open_prefilter)(const struct bpf_fuse_meta_info *meta,
> +                               struct fuse_open_in *in);
> +       uint32_t (*open_postfilter)(const struct bpf_fuse_meta_info *meta=
,
> +                               const struct fuse_open_in *in,
> +                               struct fuse_open_out *out);
> +
> +       uint32_t (*opendir_prefilter)(const struct bpf_fuse_meta_info *me=
ta,
> +                               struct fuse_open_in *in);
> +       uint32_t (*opendir_postfilter)(const struct bpf_fuse_meta_info *m=
eta,
> +                               const struct fuse_open_in *in,
> +                               struct fuse_open_out *out);
> +
> +       uint32_t (*create_open_prefilter)(const struct bpf_fuse_meta_info=
 *meta,
> +                               struct fuse_create_in *in, struct fuse_bu=
ffer *name);
> +       uint32_t (*create_open_postfilter)(const struct bpf_fuse_meta_inf=
o *meta,
> +                               const struct fuse_create_in *in, const st=
ruct fuse_buffer *name,
> +                               struct fuse_entry_out *entry_out, struct =
fuse_open_out *out);
> +
> +       uint32_t (*release_prefilter)(const struct bpf_fuse_meta_info *me=
ta,
> +                               struct fuse_release_in *in);
> +       uint32_t (*release_postfilter)(const struct bpf_fuse_meta_info *m=
eta,
> +                               const struct fuse_release_in *in);
> +
> +       uint32_t (*releasedir_prefilter)(const struct bpf_fuse_meta_info =
*meta,
> +                               struct fuse_release_in *in);
> +       uint32_t (*releasedir_postfilter)(const struct bpf_fuse_meta_info=
 *meta,
> +                               const struct fuse_release_in *in);
> +
> +       uint32_t (*flush_prefilter)(const struct bpf_fuse_meta_info *meta=
,
> +                               struct fuse_flush_in *in);
> +       uint32_t (*flush_postfilter)(const struct bpf_fuse_meta_info *met=
a,
> +                               const struct fuse_flush_in *in);
> +
> +       uint32_t (*lseek_prefilter)(const struct bpf_fuse_meta_info *meta=
,
> +                               struct fuse_lseek_in *in);
> +       uint32_t (*lseek_postfilter)(const struct bpf_fuse_meta_info *met=
a,
> +                               const struct fuse_lseek_in *in,
> +                               struct fuse_lseek_out *out);
> +
> +       uint32_t (*copy_file_range_prefilter)(const struct bpf_fuse_meta_=
info *meta,
> +                               struct fuse_copy_file_range_in *in);
> +       uint32_t (*copy_file_range_postfilter)(const struct bpf_fuse_meta=
_info *meta,
> +                               const struct fuse_copy_file_range_in *in,
> +                               struct fuse_write_out *out);
> +
> +       uint32_t (*fsync_prefilter)(const struct bpf_fuse_meta_info *meta=
,
> +                               struct fuse_fsync_in *in);
> +       uint32_t (*fsync_postfilter)(const struct bpf_fuse_meta_info *met=
a,
> +                               const struct fuse_fsync_in *in);
> +
> +       uint32_t (*dir_fsync_prefilter)(const struct bpf_fuse_meta_info *=
meta,
> +                               struct fuse_fsync_in *in);
> +       uint32_t (*dir_fsync_postfilter)(const struct bpf_fuse_meta_info =
*meta,
> +                               const struct fuse_fsync_in *in);
> +
> +       uint32_t (*getxattr_prefilter)(const struct bpf_fuse_meta_info *m=
eta,
> +                               struct fuse_getxattr_in *in, struct fuse_=
buffer *name);
> +       // if in->size > 0, use value. If in->size =3D=3D 0, use out.
> +       uint32_t (*getxattr_postfilter)(const struct bpf_fuse_meta_info *=
meta,
> +                               const struct fuse_getxattr_in *in, const =
struct fuse_buffer *name,
> +                               struct fuse_buffer *value, struct fuse_ge=
txattr_out *out);
> +
> +       uint32_t (*listxattr_prefilter)(const struct bpf_fuse_meta_info *=
meta,
> +                               struct fuse_getxattr_in *in);
> +       // if in->size > 0, use value. If in->size =3D=3D 0, use out.
> +       uint32_t (*listxattr_postfilter)(const struct bpf_fuse_meta_info =
*meta,
> +                               const struct fuse_getxattr_in *in,
> +                               struct fuse_buffer *value, struct fuse_ge=
txattr_out *out);
> +
> +       uint32_t (*setxattr_prefilter)(const struct bpf_fuse_meta_info *m=
eta,
> +                               struct fuse_setxattr_in *in, struct fuse_=
buffer *name,
> +                                       struct fuse_buffer *value);
> +       uint32_t (*setxattr_postfilter)(const struct bpf_fuse_meta_info *=
meta,
> +                               const struct fuse_setxattr_in *in, const =
struct fuse_buffer *name,
> +                                       const struct fuse_buffer *value);
> +
> +       uint32_t (*removexattr_prefilter)(const struct bpf_fuse_meta_info=
 *meta,
> +                               struct fuse_buffer *name);
> +       uint32_t (*removexattr_postfilter)(const struct bpf_fuse_meta_inf=
o *meta,
> +                               const struct fuse_buffer *name);
> +
> +       /* Read and Write iter will likely undergo some sort of change/ad=
dition to handle changing
> +        * the data buffer passed in/out. */
> +       uint32_t (*read_iter_prefilter)(const struct bpf_fuse_meta_info *=
meta,
> +                               struct fuse_read_in *in);
> +       uint32_t (*read_iter_postfilter)(const struct bpf_fuse_meta_info =
*meta,
> +                               const struct fuse_read_in *in,
> +                               struct fuse_read_iter_out *out);
> +
> +       uint32_t (*write_iter_prefilter)(const struct bpf_fuse_meta_info =
*meta,
> +                               struct fuse_write_in *in);
> +       uint32_t (*write_iter_postfilter)(const struct bpf_fuse_meta_info=
 *meta,
> +                               const struct fuse_write_in *in,
> +                               struct fuse_write_iter_out *out);
> +
> +       uint32_t (*file_fallocate_prefilter)(const struct bpf_fuse_meta_i=
nfo *meta,
> +                               struct fuse_fallocate_in *in);
> +       uint32_t (*file_fallocate_postfilter)(const struct bpf_fuse_meta_=
info *meta,
> +                               const struct fuse_fallocate_in *in);
> +
> +       uint32_t (*lookup_prefilter)(const struct bpf_fuse_meta_info *met=
a,
> +                               struct fuse_buffer *name);
> +       uint32_t (*lookup_postfilter)(const struct bpf_fuse_meta_info *me=
ta,
> +                               const struct fuse_buffer *name,
> +                               struct fuse_entry_out *out, struct fuse_b=
uffer *entries);
> +
> +       uint32_t (*mknod_prefilter)(const struct bpf_fuse_meta_info *meta=
,
> +                               struct fuse_mknod_in *in, struct fuse_buf=
fer *name);
> +       uint32_t (*mknod_postfilter)(const struct bpf_fuse_meta_info *met=
a,
> +                               const struct fuse_mknod_in *in, const str=
uct fuse_buffer *name);
> +
> +       uint32_t (*mkdir_prefilter)(const struct bpf_fuse_meta_info *meta=
,
> +                               struct fuse_mkdir_in *in, struct fuse_buf=
fer *name);
> +       uint32_t (*mkdir_postfilter)(const struct bpf_fuse_meta_info *met=
a,
> +                               const struct fuse_mkdir_in *in, const str=
uct fuse_buffer *name);
> +
> +       uint32_t (*rmdir_prefilter)(const struct bpf_fuse_meta_info *meta=
,
> +                               struct fuse_buffer *name);
> +       uint32_t (*rmdir_postfilter)(const struct bpf_fuse_meta_info *met=
a,
> +                               const struct fuse_buffer *name);
> +
> +       uint32_t (*rename2_prefilter)(const struct bpf_fuse_meta_info *me=
ta,
> +                               struct fuse_rename2_in *in, struct fuse_b=
uffer *old_name,
> +                               struct fuse_buffer *new_name);
> +       uint32_t (*rename2_postfilter)(const struct bpf_fuse_meta_info *m=
eta,
> +                               const struct fuse_rename2_in *in, const s=
truct fuse_buffer *old_name,
> +                               const struct fuse_buffer *new_name);
> +
> +       uint32_t (*rename_prefilter)(const struct bpf_fuse_meta_info *met=
a,
> +                               struct fuse_rename_in *in, struct fuse_bu=
ffer *old_name,
> +                               struct fuse_buffer *new_name);
> +       uint32_t (*rename_postfilter)(const struct bpf_fuse_meta_info *me=
ta,
> +                               const struct fuse_rename_in *in, const st=
ruct fuse_buffer *old_name,
> +                               const struct fuse_buffer *new_name);
> +
> +       uint32_t (*unlink_prefilter)(const struct bpf_fuse_meta_info *met=
a,
> +                               struct fuse_buffer *name);
> +       uint32_t (*unlink_postfilter)(const struct bpf_fuse_meta_info *me=
ta,
> +                               const struct fuse_buffer *name);
> +
> +       uint32_t (*link_prefilter)(const struct bpf_fuse_meta_info *meta,
> +                               struct fuse_link_in *in, struct fuse_buff=
er *name);
> +       uint32_t (*link_postfilter)(const struct bpf_fuse_meta_info *meta=
,
> +                               const struct fuse_link_in *in, const stru=
ct fuse_buffer *name);
> +
> +       uint32_t (*getattr_prefilter)(const struct bpf_fuse_meta_info *me=
ta,
> +                               struct fuse_getattr_in *in);
> +       uint32_t (*getattr_postfilter)(const struct bpf_fuse_meta_info *m=
eta,
> +                               const struct fuse_getattr_in *in,
> +                               struct fuse_attr_out *out);
> +
> +       uint32_t (*setattr_prefilter)(const struct bpf_fuse_meta_info *me=
ta,
> +                               struct fuse_setattr_in *in);
> +       uint32_t (*setattr_postfilter)(const struct bpf_fuse_meta_info *m=
eta,
> +                               const struct fuse_setattr_in *in,
> +                               struct fuse_attr_out *out);
> +
> +       uint32_t (*statfs_prefilter)(const struct bpf_fuse_meta_info *met=
a);
> +       uint32_t (*statfs_postfilter)(const struct bpf_fuse_meta_info *me=
ta,
> +                               struct fuse_statfs_out *out);
> +
> +       //TODO: This does not allow doing anything with path
> +       uint32_t (*get_link_prefilter)(const struct bpf_fuse_meta_info *m=
eta,
> +                               struct fuse_buffer *name);
> +       uint32_t (*get_link_postfilter)(const struct bpf_fuse_meta_info *=
meta,
> +                               const struct fuse_buffer *name);
> +
> +       uint32_t (*symlink_prefilter)(const struct bpf_fuse_meta_info *me=
ta,
> +                               struct fuse_buffer *name, struct fuse_buf=
fer *path);
> +       uint32_t (*symlink_postfilter)(const struct bpf_fuse_meta_info *m=
eta,
> +                               const struct fuse_buffer *name, const str=
uct fuse_buffer *path);
> +
> +       uint32_t (*readdir_prefilter)(const struct bpf_fuse_meta_info *me=
ta,
> +                               struct fuse_read_in *in);
> +       uint32_t (*readdir_postfilter)(const struct bpf_fuse_meta_info *m=
eta,
> +                               const struct fuse_read_in *in,
> +                               struct fuse_read_out *out, struct fuse_bu=
ffer *buffer);
> +
> +       uint32_t (*access_prefilter)(const struct bpf_fuse_meta_info *met=
a,
> +                               struct fuse_access_in *in);
> +       uint32_t (*access_postfilter)(const struct bpf_fuse_meta_info *me=
ta,
> +                               const struct fuse_access_in *in);
> +
> +       char name[BPF_FUSE_NAME_MAX];
> +};

Have you considered grouping this huge amount of callbacks into a
smaller set of more generic callbacks where each callback would get
enum argument specifying what sort of operation it is called for? This
has many advantages, starting from not having to deal with struct_ops
limits, ending with not needing to instantiate dozens of individual
BPF programs.

E.g., for a lot of operations the difference between pre- and
post-filter is in having in argument as read-only and maybe having
extra out argument for post-filter. One way to unify such post/pre
filters into one callback would be to record whether in has to be
read-only  or read-write and not allow to create r/w dynptr for the
former case. Pass bool or enum specifying if it's post or pre filter.
For that optional out argument, you can simulate effectively the same
by always supplying it, but making sure that out parameter is
read-only and zero-sized, for example.

That would cut the number of callbacks in two, which I'd say still is
not great :) I think it would be better still to have even larger
groups of callbacks for whole families of operations with the same (or
"unifiable") interface (domain experts like you would need to do an
analysis here to see what makes sense to group, of course).

We'll probably touch on that tomorrow at BPF office hours, but I
wanted to point this out beforehand, so that you have time to think
about it.

> +
>  #endif /* _BPF_FUSE_H */
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 1d3892168d32..26a2e741ef61 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile

[...]

> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +                  "Global kfuncs as their definitions will be in BTF");
> +void bpf_fuse_get_rw_dynptr(struct fuse_buffer *buffer, struct bpf_dynpt=
r_kern *dynptr__uninit, u64 size, bool copy)

not clear why size is passed from outside instead of instantiating
dynptr with buffer->size? See [0] for bpf_dynptr_adjust and
bpf_dynptr_clone that allow you to adjust buffer as necessary.

As for the copy parameter, can you elaborate on the idea behind it?

  [0] https://patchwork.kernel.org/project/netdevbpf/list/?series=3D741584&=
state=3D*

> +{
> +       buffer->data =3D bpf_fuse_get_writeable(buffer, size, copy);
> +       bpf_dynptr_init(dynptr__uninit, buffer->data, BPF_DYNPTR_TYPE_LOC=
AL, 0, buffer->size);
> +}
> +
> +void bpf_fuse_get_ro_dynptr(const struct fuse_buffer *buffer, struct bpf=
_dynptr_kern *dynptr__uninit)

these kfuncs probably should be more consistently named as
bpf_dynptr_from_fuse_buffer_{ro,rw}() ?

> +{
> +       bpf_dynptr_init(dynptr__uninit, buffer->data, BPF_DYNPTR_TYPE_LOC=
AL, 0, buffer->size);
> +       bpf_dynptr_set_rdonly(dynptr__uninit);
> +}
> +
> +uint32_t bpf_fuse_return_len(struct fuse_buffer *buffer)
> +{
> +       return buffer->size;

you should be able to get this with bpf_dynptr_size() (once you create
it from fuse_buffer).

> +}
> +__diag_pop();
> +BTF_SET8_START(fuse_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_fuse_get_rw_dynptr)
> +BTF_ID_FLAGS(func, bpf_fuse_get_ro_dynptr)
> +BTF_ID_FLAGS(func, bpf_fuse_return_len)
> +BTF_SET8_END(fuse_kfunc_set)
> +
> +static const struct btf_kfunc_id_set bpf_fuse_kfunc_set =3D {
> +       .owner =3D THIS_MODULE,
> +       .set =3D &fuse_kfunc_set,
> +};
> +
> +static int __init bpf_fuse_kfuncs_init(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> +                                        &bpf_fuse_kfunc_set);
> +}
> +
> +late_initcall(bpf_fuse_kfuncs_init);
> +
> +static const struct bpf_func_proto *bpf_fuse_get_func_proto(enum bpf_fun=
c_id func_id,
> +                                                             const struc=
t bpf_prog *prog)
> +{
> +       switch (func_id) {
> +       default:
> +               return bpf_base_func_proto(func_id);
> +       }
> +}
> +
> +static bool bpf_fuse_is_valid_access(int off, int size,
> +                                   enum bpf_access_type type,
> +                                   const struct bpf_prog *prog,
> +                                   struct bpf_insn_access_aux *info)
> +{
> +       return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +
> +const struct btf_type *fuse_buffer_struct_type;
> +
> +static int bpf_fuse_btf_struct_access(struct bpf_verifier_log *log,
> +                                       const struct bpf_reg_state *reg,
> +                                       int off, int size)
> +{
> +       const struct btf_type *t;
> +
> +       t =3D btf_type_by_id(reg->btf, reg->btf_id);
> +       if (t =3D=3D fuse_buffer_struct_type) {
> +               bpf_log(log,
> +                       "direct access to fuse_buffer is disallowed\n");
> +               return -EACCES;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct bpf_verifier_ops bpf_fuse_verifier_ops =3D {
> +       .get_func_proto         =3D bpf_fuse_get_func_proto,

you probably should be fine with just using bpf_tracing_func_proto as is

> +       .is_valid_access        =3D bpf_fuse_is_valid_access,

similarly, why custom no-op callback?

> +       .btf_struct_access      =3D bpf_fuse_btf_struct_access,
> +};
> +
> +static int bpf_fuse_check_member(const struct btf_type *t,
> +                                  const struct btf_member *member,
> +                                  const struct bpf_prog *prog)
> +{
> +       //if (is_unsupported(__btf_member_bit_offset(t, member) / 8))
> +       //      return -ENOTSUPP;
> +       return 0;
> +}
> +
> +static int bpf_fuse_init_member(const struct btf_type *t,
> +                                 const struct btf_member *member,
> +                                 void *kdata, const void *udata)
> +{
> +       const struct fuse_ops *uf_ops;
> +       struct fuse_ops *f_ops;
> +       u32 moff;
> +
> +       uf_ops =3D (const struct fuse_ops *)udata;
> +       f_ops =3D (struct fuse_ops *)kdata;
> +
> +       moff =3D __btf_member_bit_offset(t, member) / 8;
> +       switch (moff) {
> +       case offsetof(struct fuse_ops, name):
> +               if (bpf_obj_name_cpy(f_ops->name, uf_ops->name,
> +                                    sizeof(f_ops->name)) <=3D 0)
> +                       return -EINVAL;
> +               //if (tcp_ca_find(utcp_ca->name))
> +               //      return -EEXIST;
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
> +static int bpf_fuse_init(struct btf *btf)
> +{
> +       s32 type_id;
> +
> +       type_id =3D btf_find_by_name_kind(btf, "fuse_buffer", BTF_KIND_ST=
RUCT);
> +       if (type_id < 0)
> +               return -EINVAL;
> +       fuse_buffer_struct_type =3D btf_type_by_id(btf, type_id);
> +

see BTF_ID and BTF_ID_LIST uses for how to get ID for your custom
well-known type

> +       return 0;
> +}
> +
> +static struct bpf_fuse_ops_attach *fuse_reg =3D NULL;
> +

[...]
