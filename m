Return-Path: <linux-fsdevel+bounces-5451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C759280C198
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 07:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA681F20F77
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 06:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D21F616;
	Mon, 11 Dec 2023 06:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOaZFJJM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC959B
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 22:57:53 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67aa0f5855cso16811216d6.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 22:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702277872; x=1702882672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1zj4Vpt1TmaJrqeW9jebM34QoLvm8zKK0JY2Zl/jf8=;
        b=kOaZFJJMidEBgyO0glzMKUlEEKFDlZA4nzuox7f6pvYE/a5YPPjfPBCm3ppDV4MFTo
         JoEESSU3h0CG8nhI7wCzzbuiNt+JbOJinR0ZNSI1PqAnkwN0whH//ynKfQykjSZu0Bxo
         lBNN85lv6zI8snWdVpGtTrS+6YVhwF8XWTV6fGAF9HQiOXLNycmMrelATnHsGL+uuqVL
         qK46+vHTzGsw1EeaRtFKGzOIty2EjZaYLv0Jd0oEbLBltjlDRID8WFUvqjCGmDy6MKe0
         l9EZh98HHDJF2UXk3tZ1//lNv6TbacZJzypAPCT1VIz1W223GE0rAoxKGpVkxV1rR5lx
         kLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702277872; x=1702882672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1zj4Vpt1TmaJrqeW9jebM34QoLvm8zKK0JY2Zl/jf8=;
        b=Ws+omA9aCveE86AuisIDoCqVsBS8/qmfBUJWR/XwuQdPxZDPIVQPnMBNpG5Ry++7lh
         C1TyTJqpniVHtC+1qsGhunEMf+fMUcZ9bvmY3PmfzJMZWlRTBkgciCEfkEuZiDyRyD5w
         lCkxMvAp7ffHLbcGGm/ILcyteWzFqSV9YlDr0teNXtph+XsnMvhRagjFNyrWKInDRtXo
         jzuFbeDnwg2wHQmG6G+dbZWFCfnLpp3ByWUdsOpMtL+GBsM1c6gfkljDzLf0JuEXoNg+
         SCOeCbFYrjbpWt7tdqx1nVFGhm2/7S1ZMtrbXxtqYa577PxssuTDB+qo+gVyRgE1tWlU
         c4XQ==
X-Gm-Message-State: AOJu0YyKLWnprxsJ604/LIjNHOf+DWz88hRbzj8Mb2oq5L4sRgDShFAI
	coO+InquvjEkzeQAMWrpYasqaBlUGb0ZLcKQzzw=
X-Google-Smtp-Source: AGHT+IEWEYxb0ilQcCuJ+V8SdHc7SF51EJSt1wczuyOpOuoJn5rPljgnPRFsCKntm4gIVLNSrWR8YcbkagF+pBJsvJY=
X-Received: by 2002:a0c:ef0b:0:b0:67e:a9f1:78f4 with SMTP id
 t11-20020a0cef0b000000b0067ea9f178f4mr2062656qvr.122.1702277872332; Sun, 10
 Dec 2023 22:57:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231210141901.47092-1-amir73il@gmail.com> <20231210141901.47092-2-amir73il@gmail.com>
In-Reply-To: <20231210141901.47092-2-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 11 Dec 2023 08:57:41 +0200
Message-ID: <CAOQ4uxiKnBSg9DHuT4Ps4f35TYWFwQg9gofhTJFEibg30WV9jA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] splice: return type ssize_t from all helpers
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 10, 2023 at 4:19=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Not sure why some splice helpers return long, maybe historic reasons.
> Change them all to return ssize_t to conform to the splice methods and
> to the rest of the helpers.
>
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Link: https://lore.kernel.org/r/20231208-horchen-helium-d3ec1535ede5@brau=
ner/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/overlayfs/copy_up.c |  2 +-
>  fs/read_write.c        |  2 +-
>  fs/splice.c            | 62 +++++++++++++++++++++---------------------
>  include/linux/splice.h | 43 ++++++++++++++---------------
>  io_uring/splice.c      |  4 +--
>  5 files changed, 56 insertions(+), 57 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index 294b330aba9f..741d38058337 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -285,7 +285,7 @@ static int ovl_copy_up_file(struct ovl_fs *ofs, struc=
t dentry *dentry,
>
>         while (len) {
>                 size_t this_len =3D OVL_COPY_UP_CHUNK_SIZE;
> -               long bytes;
> +               ssize_t bytes;
>
>                 if (len < this_len)
>                         this_len =3D len;
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 01a14570015b..7783b8522693 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1214,7 +1214,7 @@ COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd=
,
>  #endif /* CONFIG_COMPAT */
>
>  static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
> -                          size_t count, loff_t max)
> +                          size_t count, loff_t max)
>  {
>         struct fd in, out;
>         struct inode *in_inode, *out_inode;
> diff --git a/fs/splice.c b/fs/splice.c
> index 7cda013e5a1e..6c1f12872407 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -932,8 +932,8 @@ static int warn_unsupported(struct file *file, const =
char *op)
>  /*
>   * Attempt to initiate a splice from pipe to file.
>   */
> -static long do_splice_from(struct pipe_inode_info *pipe, struct file *ou=
t,
> -                          loff_t *ppos, size_t len, unsigned int flags)
> +static ssize_t do_splice_from(struct pipe_inode_info *pipe, struct file =
*out,
> +                             loff_t *ppos, size_t len, unsigned int flag=
s)
>  {
>         if (unlikely(!out->f_op->splice_write))
>                 return warn_unsupported(out, "write");
> @@ -955,9 +955,9 @@ static void do_splice_eof(struct splice_desc *sd)
>   * Callers already called rw_verify_area() on the entire range.
>   * No need to call it for sub ranges.
>   */
> -static long do_splice_read(struct file *in, loff_t *ppos,
> -                          struct pipe_inode_info *pipe, size_t len,
> -                          unsigned int flags)
> +static size_t do_splice_read(struct file *in, loff_t *ppos,
> +                            struct pipe_inode_info *pipe, size_t len,
> +                            unsigned int flags)
>  {
>         unsigned int p_space;
>
> @@ -999,11 +999,11 @@ static long do_splice_read(struct file *in, loff_t =
*ppos,
>   * If successful, it returns the amount of data spliced, 0 if it hit the=
 EOF or
>   * a hole and a negative error code otherwise.
>   */
> -long vfs_splice_read(struct file *in, loff_t *ppos,
> -                    struct pipe_inode_info *pipe, size_t len,
> -                    unsigned int flags)
> +ssize_t vfs_splice_read(struct file *in, loff_t *ppos,
> +                       struct pipe_inode_info *pipe, size_t len,
> +                       unsigned int flags)
>  {
> -       int ret;
> +       ssize_t ret;
>
>         ret =3D rw_verify_area(READ, in, ppos, len);
>         if (unlikely(ret < 0))
> @@ -1030,7 +1030,7 @@ ssize_t splice_direct_to_actor(struct file *in, str=
uct splice_desc *sd,
>                                splice_direct_actor *actor)
>  {
>         struct pipe_inode_info *pipe;
> -       long ret, bytes;
> +       size_t ret, bytes;
>         size_t len;
>         int i, flags, more;
>
> @@ -1181,7 +1181,7 @@ static void direct_file_splice_eof(struct splice_de=
sc *sd)
>                 file->f_op->splice_eof(file);
>  }
>
> -static long do_splice_direct_actor(struct file *in, loff_t *ppos,
> +static ssize_t do_splice_direct_actor(struct file *in, loff_t *ppos,
>                                    struct file *out, loff_t *opos,
>                                    size_t len, unsigned int flags,
>                                    splice_direct_actor *actor)
> @@ -1226,8 +1226,8 @@ static long do_splice_direct_actor(struct file *in,=
 loff_t *ppos,
>   *
>   * Callers already called rw_verify_area() on the entire range.
>   */
> -long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
> -                     loff_t *opos, size_t len, unsigned int flags)
> +ssize_t do_splice_direct(struct file *in, loff_t *ppos, struct file *out=
,
> +                        loff_t *opos, size_t len, unsigned int flags)
>  {
>         return do_splice_direct_actor(in, ppos, out, opos, len, flags,
>                                       direct_splice_actor);
> @@ -1249,8 +1249,8 @@ EXPORT_SYMBOL(do_splice_direct);
>   *
>   * Callers already called rw_verify_area() on the entire range.
>   */
> -long splice_file_range(struct file *in, loff_t *ppos, struct file *out,
> -                      loff_t *opos, size_t len)
> +ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *ou=
t,
> +                         loff_t *opos, size_t len)
>  {
>         lockdep_assert(file_write_started(out));
>
> @@ -1280,12 +1280,12 @@ static int splice_pipe_to_pipe(struct pipe_inode_=
info *ipipe,
>                                struct pipe_inode_info *opipe,
>                                size_t len, unsigned int flags);
>
> -long splice_file_to_pipe(struct file *in,
> -                        struct pipe_inode_info *opipe,
> -                        loff_t *offset,
> -                        size_t len, unsigned int flags)
> +ssize_t splice_file_to_pipe(struct file *in,
> +                           struct pipe_inode_info *opipe,
> +                           loff_t *offset,
> +                           size_t len, unsigned int flags)

OOPS forgot to fix the declaration in fs/internal.h

>  {
> -       long ret;
> +       ssize_t ret;
>
>         pipe_lock(opipe);
>         ret =3D wait_for_space(opipe, flags);
> @@ -1300,13 +1300,13 @@ long splice_file_to_pipe(struct file *in,
>  /*
>   * Determine where to splice to/from.
>   */
> -long do_splice(struct file *in, loff_t *off_in, struct file *out,
> -              loff_t *off_out, size_t len, unsigned int flags)
> +ssize_t do_splice(struct file *in, loff_t *off_in, struct file *out,
> +                 loff_t *off_out, size_t len, unsigned int flags)
>  {
>         struct pipe_inode_info *ipipe;
>         struct pipe_inode_info *opipe;
>         loff_t offset;
> -       long ret;
> +       ssize_t ret;
>
>         if (unlikely(!(in->f_mode & FMODE_READ) ||
>                      !(out->f_mode & FMODE_WRITE)))
> @@ -1397,14 +1397,14 @@ long do_splice(struct file *in, loff_t *off_in, s=
truct file *out,
>         return ret;
>  }
>
> -static long __do_splice(struct file *in, loff_t __user *off_in,
> -                       struct file *out, loff_t __user *off_out,
> -                       size_t len, unsigned int flags)
> +static ssize_t __do_splice(struct file *in, loff_t __user *off_in,
> +                          struct file *out, loff_t __user *off_out,
> +                          size_t len, unsigned int flags)
>  {
>         struct pipe_inode_info *ipipe;
>         struct pipe_inode_info *opipe;
>         loff_t offset, *__off_in =3D NULL, *__off_out =3D NULL;
> -       long ret;
> +       ssize_t ret;
>
>         ipipe =3D get_pipe_info(in, true);
>         opipe =3D get_pipe_info(out, true);
> @@ -1634,7 +1634,7 @@ SYSCALL_DEFINE6(splice, int, fd_in, loff_t __user *=
, off_in,
>                 size_t, len, unsigned int, flags)
>  {
>         struct fd in, out;
> -       long error;
> +       ssize_t error;
>
>         if (unlikely(!len))
>                 return 0;
> @@ -1648,7 +1648,7 @@ SYSCALL_DEFINE6(splice, int, fd_in, loff_t __user *=
, off_in,
>                 out =3D fdget(fd_out);
>                 if (out.file) {
>                         error =3D __do_splice(in.file, off_in, out.file, =
off_out,
> -                                               len, flags);
> +                                           len, flags);
>                         fdput(out);
>                 }
>                 fdput(in);
> @@ -1962,7 +1962,7 @@ static int link_pipe(struct pipe_inode_info *ipipe,
>   * The 'flags' used are the SPLICE_F_* variants, currently the only
>   * applicable one is SPLICE_F_NONBLOCK.
>   */
> -long do_tee(struct file *in, struct file *out, size_t len, unsigned int =
flags)
> +ssize_t do_tee(struct file *in, struct file *out, size_t len, unsigned i=
nt flags)
>  {
>         struct pipe_inode_info *ipipe =3D get_pipe_info(in, true);
>         struct pipe_inode_info *opipe =3D get_pipe_info(out, true);
> @@ -2003,7 +2003,7 @@ long do_tee(struct file *in, struct file *out, size=
_t len, unsigned int flags)
>  SYSCALL_DEFINE4(tee, int, fdin, int, fdout, size_t, len, unsigned int, f=
lags)
>  {
>         struct fd in, out;
> -       int error;
> +       ssize_t error;
>
>         if (unlikely(flags & ~SPLICE_F_ALL))
>                 return -EINVAL;
> diff --git a/include/linux/splice.h b/include/linux/splice.h
> index 49532d5dda52..068a8e8ffd73 100644
> --- a/include/linux/splice.h
> +++ b/include/linux/splice.h
> @@ -68,31 +68,30 @@ typedef int (splice_actor)(struct pipe_inode_info *, =
struct pipe_buffer *,
>  typedef int (splice_direct_actor)(struct pipe_inode_info *,
>                                   struct splice_desc *);
>
> -extern ssize_t splice_from_pipe(struct pipe_inode_info *, struct file *,
> -                               loff_t *, size_t, unsigned int,
> -                               splice_actor *);
> -extern ssize_t __splice_from_pipe(struct pipe_inode_info *,
> -                                 struct splice_desc *, splice_actor *);
> -extern ssize_t splice_to_pipe(struct pipe_inode_info *,
> -                             struct splice_pipe_desc *);
> -extern ssize_t add_to_pipe(struct pipe_inode_info *,
> -                             struct pipe_buffer *);
> -long vfs_splice_read(struct file *in, loff_t *ppos,
> -                    struct pipe_inode_info *pipe, size_t len,
> -                    unsigned int flags);
> +ssize_t splice_from_pipe(struct pipe_inode_info *pipe, struct file *out,
> +                        loff_t *ppos, size_t len, unsigned int flags,
> +                        splice_actor *actor);
> +ssize_t __splice_from_pipe(struct pipe_inode_info *pipe,
> +                          struct splice_desc *sd, splice_actor *actor);
> +ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
> +                             struct splice_pipe_desc *spd);
> +ssize_t add_to_pipe(struct pipe_inode_info *pipe, struct pipe_buffer *bu=
f);
> +ssize_t vfs_splice_read(struct file *in, loff_t *ppos,
> +                       struct pipe_inode_info *pipe, size_t len,
> +                       unsigned int flags);
>  ssize_t splice_direct_to_actor(struct file *file, struct splice_desc *sd=
,
>                                splice_direct_actor *actor);
> -long do_splice(struct file *in, loff_t *off_in, struct file *out,
> -              loff_t *off_out, size_t len, unsigned int flags);
> -long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
> -                     loff_t *opos, size_t len, unsigned int flags);
> -long splice_file_range(struct file *in, loff_t *ppos, struct file *out,
> -                      loff_t *opos, size_t len);
> +ssize_t do_splice(struct file *in, loff_t *off_in, struct file *out,
> +                 loff_t *off_out, size_t len, unsigned int flags);
> +ssize_t do_splice_direct(struct file *in, loff_t *ppos, struct file *out=
,
> +                        loff_t *opos, size_t len, unsigned int flags);
> +ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *ou=
t,
> +                         loff_t *opos, size_t len);
>
> -extern long do_tee(struct file *in, struct file *out, size_t len,
> -                  unsigned int flags);
> -extern ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct fil=
e *out,
> -                               loff_t *ppos, size_t len, unsigned int fl=
ags);
> +ssize_t do_tee(struct file *in, struct file *out, size_t len,
> +              unsigned int flags);
> +ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
> +                        loff_t *ppos, size_t len, unsigned int flags);
>
>  /*
>   * for dynamic pipe sizing
> diff --git a/io_uring/splice.c b/io_uring/splice.c
> index 7c4469e9540e..3b659cd23e9d 100644
> --- a/io_uring/splice.c
> +++ b/io_uring/splice.c
> @@ -51,7 +51,7 @@ int io_tee(struct io_kiocb *req, unsigned int issue_fla=
gs)
>         struct file *out =3D sp->file_out;
>         unsigned int flags =3D sp->flags & ~SPLICE_F_FD_IN_FIXED;
>         struct file *in;
> -       long ret =3D 0;
> +       ssize_t ret =3D 0;
>
>         WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
>
> @@ -92,7 +92,7 @@ int io_splice(struct io_kiocb *req, unsigned int issue_=
flags)
>         unsigned int flags =3D sp->flags & ~SPLICE_F_FD_IN_FIXED;
>         loff_t *poff_in, *poff_out;
>         struct file *in;
> -       long ret =3D 0;
> +       ssize_t ret =3D 0;
>
>         WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
>
> --
> 2.34.1
>

