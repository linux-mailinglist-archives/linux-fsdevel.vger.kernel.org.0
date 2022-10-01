Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24635F1A62
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 08:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJAGyP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 02:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJAGyN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 02:54:13 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE191919A6;
        Fri, 30 Sep 2022 23:54:12 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id k14so3301211vkk.0;
        Fri, 30 Sep 2022 23:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=VOOiIsdAj9Fy3/tGDBq6Hw66p9qNw0hMPiKBsradvWs=;
        b=jEFnR8qV1kkx4c/YXldZqnioh8LeAX1tKj7/Oxv3YkPnZEb/7xrMAQkdUXB4RsR9ai
         CLd1C18Bq23tAbPr++6dKhFpgdSAn6Be/T4heP7NYt0bdwQlkruOwcEVODLa7cGg5YzG
         PfNsk1ouiNOlrsBekODRPK6oCzTI5mTD1YY0u/5wx9PThiQuFtVkn191JOdJ1WwRwVOg
         RpAOk6qImFzpQxmdyrneMCEkwDsynennDNRxup3kaK/fyEBWMUwmjU+R/gAPZH5/5oK8
         /dGr3emhr0jBvIyCUQaLwr7aH+0zkoep1sVhMJRKPwgt1MSyzwJMv6ufoK+RrcAteYVn
         X9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VOOiIsdAj9Fy3/tGDBq6Hw66p9qNw0hMPiKBsradvWs=;
        b=RYBcJQmuZGd/92f9eUzNaANlBjgl/Z/EqOb4q0T6OHi4vy/TSKWMMWcp2TgfmxQL5w
         px+7lL1ra/BsMivfzaRBxs6bvKkTxVQS5bMRkDIEAD76lfdSa1Yfhos01z6ag10YDLjv
         Ig0W+eIt1cqLlzbgFPocpF7zP/JtRQCTflAFhtEmJR0th5Y1b1yQwiplwF31m4+LBt9J
         S2H9/hl4Ae3V9PFibFFDqAHErLQ9La3NH/X66McsTNZhvNHAXZj3mmJvHMR0ICLJG0QB
         iBmOmewNv/kxvzgq6O36ai7JmBdev328Av2/BEryqgTwA2tBD0yZpnfSey8V6s8vMqcy
         LHPA==
X-Gm-Message-State: ACrzQf2Yznib4oaAPLh7NDuRYkZC6gOWFY/0plaGJOfsZuaO45JYD9du
        JVuiyh4qumfya9D+bfhDgHkqboIozrzPqxaaaxg=
X-Google-Smtp-Source: AMsMyM63HdCoijFAgy7dvhoNqJCYn/NU160eYlfJTvMQUqKUfWyDej5/3pwntF6xNAm6RPvKdMw8bH7nAyw8tQSFdKM=
X-Received: by 2002:a1f:b292:0:b0:3a3:e51b:80c6 with SMTP id
 b140-20020a1fb292000000b003a3e51b80c6mr6167412vkf.11.1664607251341; Fri, 30
 Sep 2022 23:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220926231822.994383-1-drosen@google.com> <20220926231822.994383-16-drosen@google.com>
In-Reply-To: <20220926231822.994383-16-drosen@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 1 Oct 2022 09:53:59 +0300
Message-ID: <CAOQ4uxjssUfKxoTzzervqGaHNPcz1sK-JAVAXFE7=gEdkcYhvQ@mail.gmail.com>
Subject: Re: [PATCH 15/26] fuse-bpf: Add support for read/write iter
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@google.com>,
        David Anderson <dvander@google.com>,
        Sandeep Patil <sspatil@google.com>,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 2:46 AM Daniel Rosenberg <drosen@google.com> wrote:
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> Signed-off-by: Paul Lawrence <paullawrence@google.com>
> ---
>  fs/fuse/backing.c | 291 ++++++++++++++++++++++++++++++++++++++++++++++
>  fs/fuse/control.c |   2 +-
>  fs/fuse/file.c    |  28 +++++
>  fs/fuse/fuse_i.h  |  42 ++++++-
>  fs/fuse/inode.c   |  13 +++
>  5 files changed, 374 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index 1fe61177cdfb..cf4ad9f4fe10 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -12,6 +12,47 @@
>  #include <linux/namei.h>
>  #include <linux/bpf_fuse.h>
>
> +#define FUSE_BPF_IOCB_MASK (IOCB_APPEND | IOCB_DSYNC | IOCB_HIPRI | IOCB_NOWAIT | IOCB_SYNC)
> +
> +struct fuse_bpf_aio_req {
> +       struct kiocb iocb;
> +       refcount_t ref;
> +       struct kiocb *iocb_orig;
> +};
> +
> +static struct kmem_cache *fuse_bpf_aio_request_cachep;
> +
> +static void fuse_file_accessed(struct file *dst_file, struct file *src_file)
> +{
> +       struct inode *dst_inode;
> +       struct inode *src_inode;
> +
> +       if (dst_file->f_flags & O_NOATIME)
> +               return;
> +
> +       dst_inode = file_inode(dst_file);
> +       src_inode = file_inode(src_file);
> +
> +       if ((!timespec64_equal(&dst_inode->i_mtime, &src_inode->i_mtime) ||
> +            !timespec64_equal(&dst_inode->i_ctime, &src_inode->i_ctime))) {
> +               dst_inode->i_mtime = src_inode->i_mtime;
> +               dst_inode->i_ctime = src_inode->i_ctime;
> +       }
> +
> +       touch_atime(&dst_file->f_path);
> +}
> +
> +static void fuse_copyattr(struct file *dst_file, struct file *src_file)
> +{
> +       struct inode *dst = file_inode(dst_file);
> +       struct inode *src = file_inode(src_file);
> +
> +       dst->i_atime = src->i_atime;
> +       dst->i_mtime = src->i_mtime;
> +       dst->i_ctime = src->i_ctime;
> +       i_size_write(dst, i_size_read(src));
> +}
> +
>  struct bpf_prog *fuse_get_bpf_prog(struct file *file)
>  {
>         struct bpf_prog *bpf_prog = ERR_PTR(-EINVAL);
> @@ -469,6 +510,241 @@ int fuse_lseek_finalize(struct bpf_fuse_args *fa, loff_t *out,
>         return 0;
>  }
>
> +static inline void fuse_bpf_aio_put(struct fuse_bpf_aio_req *aio_req)
> +{
> +       if (refcount_dec_and_test(&aio_req->ref))
> +               kmem_cache_free(fuse_bpf_aio_request_cachep, aio_req);
> +}
> +
> +static void fuse_bpf_aio_cleanup_handler(struct fuse_bpf_aio_req *aio_req)
> +{
> +       struct kiocb *iocb = &aio_req->iocb;
> +       struct kiocb *iocb_orig = aio_req->iocb_orig;
> +
> +       if (iocb->ki_flags & IOCB_WRITE) {
> +               __sb_writers_acquired(file_inode(iocb->ki_filp)->i_sb,
> +                                     SB_FREEZE_WRITE);
> +               file_end_write(iocb->ki_filp);
> +               fuse_copyattr(iocb_orig->ki_filp, iocb->ki_filp);
> +       }
> +       iocb_orig->ki_pos = iocb->ki_pos;
> +       fuse_bpf_aio_put(aio_req);
> +}
> +
> +static void fuse_bpf_aio_rw_complete(struct kiocb *iocb, long res)
> +{
> +       struct fuse_bpf_aio_req *aio_req =
> +               container_of(iocb, struct fuse_bpf_aio_req, iocb);
> +       struct kiocb *iocb_orig = aio_req->iocb_orig;
> +
> +       fuse_bpf_aio_cleanup_handler(aio_req);
> +       iocb_orig->ki_complete(iocb_orig, res);
> +}
> +
> +int fuse_file_read_iter_initialize_in(struct bpf_fuse_args *fa, struct fuse_file_read_iter_io *fri,
> +                                     struct kiocb *iocb, struct iov_iter *to)
> +{
> +       struct file *file = iocb->ki_filp;
> +       struct fuse_file *ff = file->private_data;
> +
> +       fri->fri = (struct fuse_read_in) {
> +               .fh = ff->fh,
> +               .offset = iocb->ki_pos,
> +               .size = to->count,
> +       };
> +
> +       /* TODO we can't assume 'to' is a kvec */
> +       /* TODO we also can't assume the vector has only one component */
> +       *fa = (struct bpf_fuse_args) {
> +               .opcode = FUSE_READ,
> +               .nodeid = ff->nodeid,
> +               .in_numargs = 1,
> +               .in_args[0].size = sizeof(fri->fri),
> +               .in_args[0].value = &fri->fri,
> +               /*
> +                * TODO Design this properly.
> +                * Possible approach: do not pass buf to bpf
> +                * If going to userland, do a deep copy
> +                * For extra credit, do that to/from the vector, rather than
> +                * making an extra copy in the kernel
> +                */
> +       };
> +
> +       return 0;
> +}
> +
> +int fuse_file_read_iter_initialize_out(struct bpf_fuse_args *fa, struct fuse_file_read_iter_io *fri,
> +                                      struct kiocb *iocb, struct iov_iter *to)
> +{
> +       fri->frio = (struct fuse_read_iter_out) {
> +               .ret = fri->fri.size,
> +       };
> +
> +       fa->out_numargs = 1;
> +       fa->out_args[0].size = sizeof(fri->frio);
> +       fa->out_args[0].value = &fri->frio;
> +
> +       return 0;
> +}
> +
> +int fuse_file_read_iter_backing(struct bpf_fuse_args *fa, ssize_t *out,
> +                               struct kiocb *iocb, struct iov_iter *to)
> +{
> +       struct fuse_read_iter_out *frio = fa->out_args[0].value;
> +       struct file *file = iocb->ki_filp;
> +       struct fuse_file *ff = file->private_data;
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
> +               *out = vfs_iter_read(ff->backing_file, to, &iocb->ki_pos,
> +                               iocb_to_rw_flags(iocb->ki_flags, FUSE_BPF_IOCB_MASK));
> +       } else {
> +               struct fuse_bpf_aio_req *aio_req;
> +
> +               *out = -ENOMEM;
> +               aio_req = kmem_cache_zalloc(fuse_bpf_aio_request_cachep, GFP_KERNEL);
> +               if (!aio_req)
> +                       goto out;
> +
> +               aio_req->iocb_orig = iocb;
> +               kiocb_clone(&aio_req->iocb, iocb, ff->backing_file);
> +               aio_req->iocb.ki_complete = fuse_bpf_aio_rw_complete;
> +               refcount_set(&aio_req->ref, 2);
> +               *out = vfs_iocb_iter_read(ff->backing_file, &aio_req->iocb, to);
> +               fuse_bpf_aio_put(aio_req);
> +               if (*out != -EIOCBQUEUED)
> +                       fuse_bpf_aio_cleanup_handler(aio_req);
> +       }
> +
> +       frio->ret = *out;
> +
> +       /* TODO Need to point value at the buffer for post-modification */
> +
> +out:
> +       fuse_file_accessed(file, ff->backing_file);
> +
> +       return *out;
> +}
> +
> +int fuse_file_read_iter_finalize(struct bpf_fuse_args *fa, ssize_t *out,
> +                                struct kiocb *iocb, struct iov_iter *to)
> +{
> +       struct fuse_read_iter_out *frio = fa->out_args[0].value;
> +
> +       *out = frio->ret;
> +
> +       return 0;
> +}
> +
> +int fuse_file_write_iter_initialize_in(struct bpf_fuse_args *fa,
> +                                      struct fuse_file_write_iter_io *fwio,
> +                                      struct kiocb *iocb, struct iov_iter *from)
> +{
> +       struct file *file = iocb->ki_filp;
> +       struct fuse_file *ff = file->private_data;
> +
> +       *fwio = (struct fuse_file_write_iter_io) {
> +               .fwi.fh = ff->fh,
> +               .fwi.offset = iocb->ki_pos,
> +               .fwi.size = from->count,
> +       };
> +
> +       /* TODO we can't assume 'from' is a kvec */
> +       *fa = (struct bpf_fuse_args) {
> +               .opcode = FUSE_WRITE,
> +               .nodeid = ff->nodeid,
> +               .in_numargs = 2,
> +               .in_args[0].size = sizeof(fwio->fwi),
> +               .in_args[0].value = &fwio->fwi,
> +               .in_args[1].size = fwio->fwi.size,
> +               .in_args[1].value = from->kvec->iov_base,
> +       };
> +
> +       return 0;
> +}
> +
> +int fuse_file_write_iter_initialize_out(struct bpf_fuse_args *fa,
> +                                       struct fuse_file_write_iter_io *fwio,
> +                                       struct kiocb *iocb, struct iov_iter *from)
> +{
> +       /* TODO we can't assume 'from' is a kvec */
> +       fa->out_numargs = 1;
> +       fa->out_args[0].size = sizeof(fwio->fwio);
> +       fa->out_args[0].value = &fwio->fwio;
> +
> +       return 0;
> +}
> +
> +int fuse_file_write_iter_backing(struct bpf_fuse_args *fa, ssize_t *out,
> +                                struct kiocb *iocb, struct iov_iter *from)
> +{
> +       struct file *file = iocb->ki_filp;
> +       struct fuse_file *ff = file->private_data;
> +       struct fuse_write_iter_out *fwio = fa->out_args[0].value;
> +
> +       if (!iov_iter_count(from))
> +               return 0;
> +
> +       /* TODO This just plain ignores any change to fuse_write_in */
> +       /* TODO uint32_t seems smaller than ssize_t.... right? */
> +       inode_lock(file_inode(file));
> +
> +       fuse_copyattr(file, ff->backing_file);
> +
> +       if (is_sync_kiocb(iocb)) {
> +               file_start_write(ff->backing_file);
> +               *out = vfs_iter_write(ff->backing_file, from, &iocb->ki_pos,
> +                                          iocb_to_rw_flags(iocb->ki_flags, FUSE_BPF_IOCB_MASK));
> +               file_end_write(ff->backing_file);
> +
> +               /* Must reflect change in size of backing file to upper file */
> +               if (*out > 0)
> +                       fuse_copyattr(file, ff->backing_file);

Regarding attribute cache, things can get a tad more complicated
when the inode is not purely passthrough.

To put things in context, the reason that ovl_copyattr() is correct
in ovl_write_iter() is because the overlayfs inode is purely passthrough
to the backing inode, that is, all operations are passthrough.
The only incident when backing inode changes (copy up) takes
care of copying inode attributes.

This is not the case with FUSE passthrough.
Not in Alessio's FUSE_PASSTHROUGH patches and not in
this proposal.

With FUSE passthrough, every inode is hybrid, some operations
can be served from the backing inode and some operations served
from the server.

My FUSE passthrough branch [1] has two fixes on top of Allesio's patches
to fix two issues regarding attribute caches (size and times).

[1] https://github.com/amir73il/linux/commits/linux-5.10.y-fuse-passthrough

This problem is not unique to FUSE.
It also exists for attribute caches of NFS clients and the NFS protocol
has several techniques to deal with this problem, but it is certainly not
a trivial issue.

As a matter of fact, I found the problems fixed in my branch above
by running the nfstest_posix [2] tests on the FUSE passthrough code.

[2] https://wiki.linux-nfs.org/wiki/index.php/NFStest#nfstest_posix_-_POSIX_file_system_level_access_tests

The easiest way out is to declare one of the copies (backing or remote)
the authoritative copy w.r.t. attributes (like noac nfs mount option).
Declaring the remote attribute copy authoritative (as FUSE usually does)
has performance implications.

I guess if FUSE-bpf attaches a backing inode to FUSE inode on lookup
then the option of making the backing inode attributes authoritative
(like in overlayfs) is valid, but I think this needs to be spelled out.

Thanks,
Amir.
