Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C127058A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 22:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjEPUVt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 16:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjEPUVr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 16:21:47 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA4B76BE;
        Tue, 16 May 2023 13:21:32 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-44f98c344d3so36870e0c.1;
        Tue, 16 May 2023 13:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684268491; x=1686860491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0vuRMkHo9VzGxNh45a0eb6OVj7N+H3/Q5hAL0JLBu9o=;
        b=OYr5qKaMhs2v+KE9qt0tcH/jMzxgxUlfWbO5w1I3YaCuhdvJrOFRoJ7Me7ek3jq/KX
         dFlExgmkDKzI5pMihDl1uh1DTS1VQfDnkJHnwVqtjjdXWZEXK/xshEQDa8OkQw3mNIjS
         HsogFXHHn3OBXo2fQiO8QVTOjzqHZ0tzO2tFLIj7zs8aLPywUixaSGrbsDz0fcAPxh5f
         C7Pkwi/YSwrLtiDOc3q/319GVDG5xLkAOKj8Elr37lg9BENmt6T0urLTAGYvCW/l4B2k
         1WvF36gnmMIDJU9TKEHCIcLi9o70wxA4RUNtub6BhPeL189U3+M7P+A37NJsbK38nEfK
         BSvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684268491; x=1686860491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vuRMkHo9VzGxNh45a0eb6OVj7N+H3/Q5hAL0JLBu9o=;
        b=hEyyg+zcwuQ1ZQQvT8caHybEyw+jwrW6cx56ZFbkAzZnFUbqolNbb1ktwC/o9duTPx
         7IedW1gn9I3+QJ7hLPo5YzPV0Z/nGDViyllPQi5VpJ5DAAKpmWkFB9yFJ8EYcZbzm3B2
         WYnnRFb4IyqZ/rhchdgA3rCEKnZ9X7JnjR1vXqOOAe5e1oEqIfNtMH8VSWQt+8pXp+Ml
         throaBu9Csb3Ux7ryANdCeMCvzoNvGp4L44deVQDJtdv4nuiQHCviZhQjP5rbh/Ge5QB
         N6jwNZZtnpADCPoyP/z/s+mBNsxkTWixr73CyRAH4aNBNXjpfmjrrjELpJ9GuN6P8oLN
         q8Nw==
X-Gm-Message-State: AC+VfDxXHBX3PGrKEl3tWx5/lmNkJlG1V7P34nsdA35vG9i2p8vz/zDW
        xud5RghOLDFyR52J7L36MYfMG1JSl1TBKC10hRk=
X-Google-Smtp-Source: ACHHUZ6wbraww5r68QV9w/sRokQQroSqwHaqoh7iCJutwL3bPI8jhnZAgyINu8uOqAHptYn/8S9An2F4zcWvrgRWl5Q=
X-Received: by 2002:a05:6102:382:b0:436:160e:9d56 with SMTP id
 m2-20020a056102038200b00436160e9d56mr12501091vsq.10.1684268491328; Tue, 16
 May 2023 13:21:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230418014037.2412394-1-drosen@google.com> <20230418014037.2412394-18-drosen@google.com>
In-Reply-To: <20230418014037.2412394-18-drosen@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 16 May 2023 23:21:20 +0300
Message-ID: <CAOQ4uxjsTjMtOdQQrZOyv+ZcvFy1CJoB9Ot9jcGwguCBLMZQnA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 17/37] fuse-bpf: Add support for read/write iter
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
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
        Mykola Lysenko <mykolal@fb.com>, kernel-team@android.com,
        Paul Lawrence <paullawrence@google.com>
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

On Tue, Apr 18, 2023 at 4:41=E2=80=AFAM Daniel Rosenberg <drosen@google.com=
> wrote:
>
> Adds backing support for FUSE_READ and FUSE_WRITE
>
> This includes adjustments from Amir Goldstein's patch to FUSE
> Passthrough
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> Signed-off-by: Paul Lawrence <paullawrence@google.com>
> ---
>  fs/fuse/backing.c         | 371 ++++++++++++++++++++++++++++++++++++++
>  fs/fuse/control.c         |   2 +-
>  fs/fuse/file.c            |   8 +
>  fs/fuse/fuse_i.h          |  19 +-
>  fs/fuse/inode.c           |  13 ++
>  include/uapi/linux/fuse.h |  10 +
>  6 files changed, 421 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index c6ef10aeec15..c7709a880e9c 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -11,6 +11,7 @@
>  #include <linux/file.h>
>  #include <linux/fs_stack.h>
>  #include <linux/namei.h>
> +#include <linux/uio.h>
>
>  /*
>   * expression statement to wrap the backing filter logic
> @@ -76,6 +77,89 @@
>         handled;                                                        \
>  })
>
> +#define FUSE_BPF_IOCB_MASK (IOCB_APPEND | IOCB_DSYNC | IOCB_HIPRI | IOCB=
_NOWAIT | IOCB_SYNC)
> +
> +struct fuse_bpf_aio_req {
> +       struct kiocb iocb;
> +       refcount_t ref;
> +       struct kiocb *iocb_orig;
> +       struct timespec64 pre_atime;
> +};
> +
> +static struct kmem_cache *fuse_bpf_aio_request_cachep;
> +
> +static void fuse_file_accessed(struct file *dst_file, struct file *src_f=
ile)
> +{
> +       struct inode *dst_inode;
> +       struct inode *src_inode;
> +
> +       if (dst_file->f_flags & O_NOATIME)
> +               return;
> +
> +       dst_inode =3D file_inode(dst_file);
> +       src_inode =3D file_inode(src_file);
> +
> +       if ((!timespec64_equal(&dst_inode->i_mtime, &src_inode->i_mtime) =
||
> +            !timespec64_equal(&dst_inode->i_ctime, &src_inode->i_ctime))=
) {
> +               dst_inode->i_mtime =3D src_inode->i_mtime;
> +               dst_inode->i_ctime =3D src_inode->i_ctime;
> +       }
> +
> +       touch_atime(&dst_file->f_path);
> +}
> +
> +static void fuse_copyattr(struct file *dst_file, struct file *src_file)
> +{
> +       struct inode *dst =3D file_inode(dst_file);
> +       struct inode *src =3D file_inode(src_file);
> +
> +       dst->i_atime =3D src->i_atime;
> +       dst->i_mtime =3D src->i_mtime;
> +       dst->i_ctime =3D src->i_ctime;
> +       i_size_write(dst, i_size_read(src));
> +       fuse_invalidate_attr(dst);
> +}
> +
> +static void fuse_file_start_write(struct file *fuse_file, struct file *b=
acking_file,
> +                                 loff_t pos, size_t count)
> +{
> +       struct inode *inode =3D file_inode(fuse_file);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +
> +       if (inode->i_size < pos + count)
> +               set_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
> +
> +       file_start_write(backing_file);
> +}
> +
> +static void fuse_file_end_write(struct file *fuse_file, struct file *bac=
king_file,
> +                               loff_t pos, size_t res)
> +{
> +       struct inode *inode =3D file_inode(fuse_file);
> +       struct fuse_inode *fi =3D get_fuse_inode(inode);
> +
> +       file_end_write(backing_file);
> +
> +       if (res > 0)
> +               fuse_write_update_attr(inode, pos, res);
> +
> +       clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
> +       fuse_invalidate_attr(inode);

This part is a bit out-of-date (was taken from my old branch)
FWIW, I pushed a more recent version of these patches to:
https://github.com/amir73il/linux/commits/fuse-passthrough-fd
(only compile tested)

> +}
> +
> +static void fuse_file_start_read(struct file *backing_file, struct times=
pec64 *pre_atime)
> +{
> +       *pre_atime =3D file_inode(backing_file)->i_atime;
> +}
> +
> +static void fuse_file_end_read(struct file *fuse_file, struct file *back=
ing_file,
> +                         struct timespec64 *pre_atime)
> +{
> +       /* Mimic atime update policy of passthrough inode, not the value =
*/
> +       if (!timespec64_equal(&file_inode(backing_file)->i_atime, pre_ati=
me))
> +               fuse_invalidate_atime(file_inode(fuse_file));
> +}
> +
>  static void fuse_get_backing_path(struct file *file, struct path *path)
>  {
>         path_get(&file->f_path);
> @@ -664,6 +748,277 @@ int fuse_bpf_lseek(loff_t *out, struct inode *inode=
, struct file *file, loff_t o
>                                 file, offset, whence);
>  }
>
> +static inline void fuse_bpf_aio_put(struct fuse_bpf_aio_req *aio_req)
> +{
> +       if (refcount_dec_and_test(&aio_req->ref))
> +               kmem_cache_free(fuse_bpf_aio_request_cachep, aio_req);
> +}
> +
> +static void fuse_bpf_aio_cleanup_handler(struct fuse_bpf_aio_req *aio_re=
q, long res)
> +{
> +       struct kiocb *iocb =3D &aio_req->iocb;
> +       struct kiocb *iocb_orig =3D aio_req->iocb_orig;
> +       struct file *filp =3D iocb->ki_filp;
> +       struct file *fuse_filp =3D iocb_orig->ki_filp;
> +
> +       if (iocb->ki_flags & IOCB_WRITE) {
> +               __sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
> +                                     SB_FREEZE_WRITE);
> +               fuse_file_end_write(iocb_orig->ki_filp, iocb->ki_filp, io=
cb->ki_pos, res);
> +       } else {
> +               fuse_file_end_read(fuse_filp, filp, &aio_req->pre_atime);
> +       }
> +       iocb_orig->ki_pos =3D iocb->ki_pos;
> +       fuse_bpf_aio_put(aio_req);
> +}
> +
> +static void fuse_bpf_aio_rw_complete(struct kiocb *iocb, long res)
> +{
> +       struct fuse_bpf_aio_req *aio_req =3D
> +               container_of(iocb, struct fuse_bpf_aio_req, iocb);
> +       struct kiocb *iocb_orig =3D aio_req->iocb_orig;
> +
> +       fuse_bpf_aio_cleanup_handler(aio_req, res);
> +       iocb_orig->ki_complete(iocb_orig, res);
> +}
> +
> +struct fuse_file_read_iter_args {
> +       struct fuse_read_in in;
> +       struct fuse_read_iter_out out;
> +};
> +
> +static int fuse_file_read_iter_initialize_in(struct bpf_fuse_args *fa, s=
truct fuse_file_read_iter_args *args,
> +                                            struct kiocb *iocb, struct i=
ov_iter *to)
> +{
> +       struct file *file =3D iocb->ki_filp;
> +       struct fuse_file *ff =3D file->private_data;
> +
> +       args->in =3D (struct fuse_read_in) {
> +               .fh =3D ff->fh,
> +               .offset =3D iocb->ki_pos,
> +               .size =3D to->count,
> +       };
> +
> +       /* TODO we can't assume 'to' is a kvec */
> +       /* TODO we also can't assume the vector has only one component */
> +       *fa =3D (struct bpf_fuse_args) {
> +               .info =3D (struct bpf_fuse_meta_info) {
> +                       .opcode =3D FUSE_READ,
> +                       .nodeid =3D ff->nodeid,
> +               },              .in_numargs =3D 1,
> +               .in_args[0].size =3D sizeof(args->in),
> +               .in_args[0].value =3D &args->in,
> +               /*
> +                * TODO Design this properly.
> +                * Possible approach: do not pass buf to bpf
> +                * If going to userland, do a deep copy
> +                * For extra credit, do that to/from the vector, rather t=
han
> +                * making an extra copy in the kernel
> +                */
> +       };
> +
> +       return 0;
> +}
> +
> +static int fuse_file_read_iter_initialize_out(struct bpf_fuse_args *fa, =
struct fuse_file_read_iter_args *args,
> +                                             struct kiocb *iocb, struct =
iov_iter *to)
> +{
> +       args->out =3D (struct fuse_read_iter_out) {
> +               .ret =3D args->in.size,
> +       };
> +
> +       fa->out_numargs =3D 1;
> +       fa->out_args[0].size =3D sizeof(args->out);
> +       fa->out_args[0].value =3D &args->out;
> +
> +       return 0;
> +}
> +
> +static int fuse_file_read_iter_backing(struct bpf_fuse_args *fa, ssize_t=
 *out,
> +                                      struct kiocb *iocb, struct iov_ite=
r *to)
> +{
> +       struct fuse_read_iter_out *frio =3D fa->out_args[0].value;
> +       struct file *file =3D iocb->ki_filp;
> +       struct fuse_file *ff =3D file->private_data;
> +
> +       if (!iov_iter_count(to))
> +               return 0;
> +
> +       if ((iocb->ki_flags & IOCB_DIRECT) &&
> +           (!ff->backing_file->f_mapping->a_ops ||
> +            !ff->backing_file->f_mapping->a_ops->direct_IO))
> +               return -EINVAL;
> +
> +       /* TODO This just plain ignores any change to fuse_read_in */
> +       if (is_sync_kiocb(iocb)) {
> +               struct timespec64 pre_atime;
> +
> +               fuse_file_start_read(ff->backing_file, &pre_atime);
> +               *out =3D vfs_iter_read(ff->backing_file, to, &iocb->ki_po=
s,
> +                               iocb_to_rw_flags(iocb->ki_flags, FUSE_BPF=
_IOCB_MASK));
> +               fuse_file_end_read(file, ff->backing_file, &pre_atime);
> +       } else {
> +               struct fuse_bpf_aio_req *aio_req;
> +
> +               *out =3D -ENOMEM;
> +               aio_req =3D kmem_cache_zalloc(fuse_bpf_aio_request_cachep=
, GFP_KERNEL);
> +               if (!aio_req)
> +                       goto out;
> +
> +               aio_req->iocb_orig =3D iocb;
> +               fuse_file_start_read(ff->backing_file, &aio_req->pre_atim=
e);
> +               kiocb_clone(&aio_req->iocb, iocb, ff->backing_file);
> +               aio_req->iocb.ki_complete =3D fuse_bpf_aio_rw_complete;
> +               refcount_set(&aio_req->ref, 2);
> +               *out =3D vfs_iocb_iter_read(ff->backing_file, &aio_req->i=
ocb, to);
> +               fuse_bpf_aio_put(aio_req);
> +               if (*out !=3D -EIOCBQUEUED)
> +                       fuse_bpf_aio_cleanup_handler(aio_req, *out);
> +       }
> +
> +       frio->ret =3D *out;
> +
> +       /* TODO Need to point value at the buffer for post-modification *=
/
> +
> +out:
> +       fuse_file_accessed(file, ff->backing_file);

fuse_file_accessed() looks redundant and less subtle what
fuse_file_end_read() already does.

> +
> +       return *out;
> +}
> +
> +static int fuse_file_read_iter_finalize(struct bpf_fuse_args *fa, ssize_=
t *out,
> +                                       struct kiocb *iocb, struct iov_it=
er *to)
> +{
> +       struct fuse_read_iter_out *frio =3D fa->out_args[0].value;
> +
> +       *out =3D frio->ret;
> +
> +       return 0;
> +}
> +
> +int fuse_bpf_file_read_iter(ssize_t *out, struct inode *inode, struct ki=
ocb *iocb, struct iov_iter *to)
> +{
> +       return bpf_fuse_backing(inode, struct fuse_file_read_iter_args, o=
ut,
> +                               fuse_file_read_iter_initialize_in,
> +                               fuse_file_read_iter_initialize_out,
> +                               fuse_file_read_iter_backing,
> +                               fuse_file_read_iter_finalize,
> +                               iocb, to);
> +}
> +
> +struct fuse_file_write_iter_args {
> +       struct fuse_write_in in;
> +       struct fuse_write_iter_out out;
> +};
> +
> +static int fuse_file_write_iter_initialize_in(struct bpf_fuse_args *fa,
> +                                             struct fuse_file_write_iter=
_args *args,
> +                                             struct kiocb *iocb, struct =
iov_iter *from)
> +{
> +       struct file *file =3D iocb->ki_filp;
> +       struct fuse_file *ff =3D file->private_data;
> +
> +       *args =3D (struct fuse_file_write_iter_args) {
> +               .in.fh =3D ff->fh,
> +               .in.offset =3D iocb->ki_pos,
> +               .in.size =3D from->count,
> +       };
> +
> +       /* TODO we can't assume 'from' is a kvec */
> +       *fa =3D (struct bpf_fuse_args) {
> +               .info =3D (struct bpf_fuse_meta_info) {
> +                       .opcode =3D FUSE_WRITE,
> +                       .nodeid =3D ff->nodeid,
> +               },
> +               .in_numargs =3D 1,
> +               .in_args[0].size =3D sizeof(args->in),
> +               .in_args[0].value =3D &args->in,
> +       };
> +
> +       return 0;
> +}
> +
> +static int fuse_file_write_iter_initialize_out(struct bpf_fuse_args *fa,
> +                                              struct fuse_file_write_ite=
r_args *args,
> +                                              struct kiocb *iocb, struct=
 iov_iter *from)
> +{
> +       /* TODO we can't assume 'from' is a kvec */
> +       fa->out_numargs =3D 1;
> +       fa->out_args[0].size =3D sizeof(args->out);
> +       fa->out_args[0].value =3D &args->out;
> +
> +       return 0;
> +}
> +
> +static int fuse_file_write_iter_backing(struct bpf_fuse_args *fa, ssize_=
t *out,
> +                                       struct kiocb *iocb, struct iov_it=
er *from)
> +{
> +       struct file *file =3D iocb->ki_filp;
> +       struct fuse_file *ff =3D file->private_data;
> +       struct fuse_write_iter_out *fwio =3D fa->out_args[0].value;
> +       ssize_t count =3D iov_iter_count(from);
> +
> +       if (!count)
> +               return 0;
> +
> +       /* TODO This just plain ignores any change to fuse_write_in */
> +       /* TODO uint32_t seems smaller than ssize_t.... right? */
> +       inode_lock(file_inode(file));
> +
> +       fuse_copyattr(file, ff->backing_file);

fuse_copyattr() looks redundant and less subtle than what
fuse_file_end_write() already does.

Thanks,
Amir.
