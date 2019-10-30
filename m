Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD84EA19C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 17:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfJ3QS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 12:18:58 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36028 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3QS6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 12:18:58 -0400
Received: by mail-io1-f68.google.com with SMTP id d25so2415076ioc.3;
        Wed, 30 Oct 2019 09:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dwt32/Gx5HdaQ+zftvvpNO21bwdYc3mUPo3g9Pdn1Uo=;
        b=AD1FHJqU851yv7rL/plnmm+6KmBIGKww4UxUPkSMsgXTDId3k2SM2yRshjXjAlrhrr
         HZuTXgKfoL094aAUGkBtMnxyWhhgSuvCF82AnNRacuBolHVZr3X6s104efH7hqkhAjN0
         Or3qMTBE9vws5qn0qVhzZ1zCS/cqF/BkdQf5c7j6Y2qrScQQRYgL8n/296y5497FPdr5
         dbFn3L1m/6wlZTsAq7FnW4qYQGiJiU5rb/+ukqUGzmFc9QYaUav+N29DMOb2SfwKSMdk
         cP4GE5/1jLmtgwjn8z2pGKfPSHtkEtNvGDyJofGbIutP5whWMpiUh8xiWoWoMpvp+7Fu
         cbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dwt32/Gx5HdaQ+zftvvpNO21bwdYc3mUPo3g9Pdn1Uo=;
        b=jQ40kOLH7ioHuXQjg+KH6QmNdMg3fy4CWVknoj3AjZ+Ic5cvoxMrRAEQWZa0+dxSlK
         kwUx851kXa3BtQHGkliVmsedA6kIp1+QHdtEGWL4Qp4+2qdFBiK+FQUTVXD+nN0Wcmxl
         t4eWW1Z5t/exMyw9haZn63I9sEgesy4nZmiETUx58M0EkIx96IroYr+sIMY4tbkgSXcj
         4ljnPxILKlE1j4vm4Jtf00ILQxgGtTKVpOtLtwh9vSL46RD0nzrmqWvpFw779w3FJT8K
         +1Qh8yCxZ4nk8uyvyAH/ZtbXz07uWsYKx8doeTnCFmyHCrHUwFA4nrXFnZcjNckuUtmH
         gtMQ==
X-Gm-Message-State: APjAAAWxGGCzvnT8G+Bm4/H4aGAfd2wZfhbLAbuXzr5g6iTZ6N9yeID8
        7Nxux8tX8QayGaBAkGR6NS/msidYc/DzjUoIRZ8=
X-Google-Smtp-Source: APXvYqwbLOk2n5iHzKzzMmIhlfveeNHABqIlYpf0W2f9qUNfENTAV2B8vvyfzmAbXa7kdRi12GGt7jV2GC+y6mfumoA=
X-Received: by 2002:a5e:9741:: with SMTP id h1mr583194ioq.143.1572452336799;
 Wed, 30 Oct 2019 09:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk>
 <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
In-Reply-To: <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 30 Oct 2019 17:19:12 +0100
Message-ID: <CAOi1vP97DMX8zweOLfBDOFstrjC78=6RgxK3PPj_mehCOSeoaw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring,
 not cursor and length [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        nicolas.dichtel@6wind.com, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 11:49 AM David Howells <dhowells@redhat.com> wrote:
>
> Convert pipes to use head and tail pointers for the buffer ring rather than
> pointer and length as the latter requires two atomic ops to update (or a
> combined op) whereas the former only requires one.
>
>  (1) The head pointer is the point at which production occurs and points to
>      the slot in which the next buffer will be placed.  This is equivalent
>      to pipe->curbuf + pipe->nrbufs.
>
>      The head pointer belongs to the write-side.
>
>  (2) The tail pointer is the point at which consumption occurs.  It points
>      to the next slot to be consumed.  This is equivalent to pipe->curbuf.
>
>      The tail pointer belongs to the read-side.
>
>  (3) head and tail are allowed to run to UINT_MAX and wrap naturally.  They
>      are only masked off when the array is being accessed, e.g.:
>
>         pipe->bufs[head & mask]
>
>      This means that it is not necessary to have a dead slot in the ring as
>      head == tail isn't ambiguous.
>
>  (4) The ring is empty if "head == tail".
>
>      A helper, pipe_empty(), is provided for this.
>
>  (5) The occupancy of the ring is "head - tail".
>
>      A helper, pipe_occupancy(), is provided for this.
>
>  (6) The number of free slots in the ring is "pipe->ring_size - occupancy".
>
>      A helper, pipe_space_for_user() is provided to indicate how many slots
>      userspace may use.
>
>  (7) The ring is full if "head - tail >= pipe->ring_size".
>
>      A helper, pipe_full(), is provided for this.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  fs/fuse/dev.c             |   31 +++--
>  fs/pipe.c                 |  169 ++++++++++++++++-------------
>  fs/splice.c               |  188 ++++++++++++++++++++------------
>  include/linux/pipe_fs_i.h |   86 ++++++++++++++-
>  include/linux/uio.h       |    4 -
>  lib/iov_iter.c            |  266 +++++++++++++++++++++++++--------------------
>  6 files changed, 464 insertions(+), 280 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index dadd617d826c..1e4bc27573cc 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -703,7 +703,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
>                         cs->pipebufs++;
>                         cs->nr_segs--;
>                 } else {
> -                       if (cs->nr_segs == cs->pipe->buffers)
> +                       if (cs->nr_segs >= cs->pipe->ring_size)
>                                 return -EIO;
>
>                         page = alloc_page(GFP_HIGHUSER);
> @@ -879,7 +879,7 @@ static int fuse_ref_page(struct fuse_copy_state *cs, struct page *page,
>         struct pipe_buffer *buf;
>         int err;
>
> -       if (cs->nr_segs == cs->pipe->buffers)
> +       if (cs->nr_segs >= cs->pipe->ring_size)
>                 return -EIO;
>
>         err = unlock_request(cs->req);
> @@ -1341,7 +1341,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
>         if (!fud)
>                 return -EPERM;
>
> -       bufs = kvmalloc_array(pipe->buffers, sizeof(struct pipe_buffer),
> +       bufs = kvmalloc_array(pipe->ring_size, sizeof(struct pipe_buffer),
>                               GFP_KERNEL);
>         if (!bufs)
>                 return -ENOMEM;
> @@ -1353,7 +1353,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
>         if (ret < 0)
>                 goto out;
>
> -       if (pipe->nrbufs + cs.nr_segs > pipe->buffers) {
> +       if (pipe_occupancy(pipe->head, pipe->tail) + cs.nr_segs > pipe->ring_size) {
>                 ret = -EIO;
>                 goto out;
>         }
> @@ -1935,6 +1935,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
>                                      struct file *out, loff_t *ppos,
>                                      size_t len, unsigned int flags)
>  {
> +       unsigned int head, tail, mask, count;
>         unsigned nbuf;
>         unsigned idx;
>         struct pipe_buffer *bufs;
> @@ -1949,8 +1950,12 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
>
>         pipe_lock(pipe);
>
> -       bufs = kvmalloc_array(pipe->nrbufs, sizeof(struct pipe_buffer),
> -                             GFP_KERNEL);
> +       head = pipe->head;
> +       tail = pipe->tail;
> +       mask = pipe->ring_size - 1;
> +       count = head - tail;
> +
> +       bufs = kvmalloc_array(count, sizeof(struct pipe_buffer), GFP_KERNEL);
>         if (!bufs) {
>                 pipe_unlock(pipe);
>                 return -ENOMEM;
> @@ -1958,8 +1963,8 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
>
>         nbuf = 0;
>         rem = 0;
> -       for (idx = 0; idx < pipe->nrbufs && rem < len; idx++)
> -               rem += pipe->bufs[(pipe->curbuf + idx) & (pipe->buffers - 1)].len;
> +       for (idx = tail; idx < head && rem < len; idx++)
> +               rem += pipe->bufs[idx & mask].len;
>
>         ret = -EINVAL;
>         if (rem < len)
> @@ -1970,16 +1975,16 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
>                 struct pipe_buffer *ibuf;
>                 struct pipe_buffer *obuf;
>
> -               BUG_ON(nbuf >= pipe->buffers);
> -               BUG_ON(!pipe->nrbufs);
> -               ibuf = &pipe->bufs[pipe->curbuf];
> +               BUG_ON(nbuf >= pipe->ring_size);
> +               BUG_ON(tail == head);
> +               ibuf = &pipe->bufs[tail & mask];
>                 obuf = &bufs[nbuf];
>
>                 if (rem >= ibuf->len) {
>                         *obuf = *ibuf;
>                         ibuf->ops = NULL;
> -                       pipe->curbuf = (pipe->curbuf + 1) & (pipe->buffers - 1);
> -                       pipe->nrbufs--;
> +                       tail++;
> +                       pipe_commit_read(pipe, tail);
>                 } else {
>                         if (!pipe_buf_get(pipe, ibuf))
>                                 goto out_free;
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 8a2ab2f974bd..8a0806fe12d3 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -43,10 +43,11 @@ unsigned long pipe_user_pages_hard;
>  unsigned long pipe_user_pages_soft = PIPE_DEF_BUFFERS * INR_OPEN_CUR;
>
>  /*
> - * We use a start+len construction, which provides full use of the
> - * allocated memory.
> - * -- Florian Coosmann (FGC)
> - *
> + * We use head and tail indices that aren't masked off, except at the point of
> + * dereference, but rather they're allowed to wrap naturally.  This means there
> + * isn't a dead spot in the buffer, provided the ring size < INT_MAX.
> + * -- David Howells 2019-09-23.

Hi David,

Is "ring size < INT_MAX" constraint correct?

I've never had to implement this free running indices scheme, but
the way I've always visualized it is that the top bit of the index is
used as a lap (as in a race) indicator, leaving 31 bits to work with
(in case of unsigned ints).  Should that be

  ring size <= 2^31

or more precisely

  ring size is a power of two <= 2^31

or am I missing something?

Thanks,

                Ilya
