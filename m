Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CC64C8840
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 10:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbiCAJl7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 04:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiCAJlz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:41:55 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A82C8BE06
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 01:41:13 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id t11so17772523ioi.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Mar 2022 01:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MU2HWPXy4mAk2gUeuMPfPjZpOmd7MfczuTjNa/BKYeM=;
        b=J5tf+w9wJrpI84ECFWJeCND7fgEugL1Y44J/PeJZI5J8YWiyX+HtHV4sQLIs8Lv9MP
         AiUX5b0cP+UUp70Ks5gg6JCXGhXNEB31VGMNwDkGqc4ab+pW5kH6WmTWwpL+CKmhYNqt
         hYeXF8Y3fWhW9T+GCnaXz+kYm7c1vnceiDEm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MU2HWPXy4mAk2gUeuMPfPjZpOmd7MfczuTjNa/BKYeM=;
        b=GKvG3m3Xyb1B0dKqCGfBqH1sStFslQ7LmCFYOAUseCKNplZQAL+g5jgG8VNX1cQPk9
         t10QEdY0gqi/CYHTZGJ7J2KHHGIrZWBQbVH1a4l0flfFqfQEKfsUke56zlICJuMyplk3
         UISflMphb+aU0HPcUKYueUpks6qvXnMm40n48DSjmkr+EwKswVZcORQ9UAJ5BpwToxh6
         wLVnCJyPGkurlEjiyzNXXYBmJEMMNTSKj7A09e1jPR5Hoij3jr/axJH4bEVkOk/pu7vA
         nbyXMxLyiIXFWZf1AeNSin6uAUtFlV7ctON0by1qGuCSklUNWuyu9TLSefWw+Ek689KB
         NdGg==
X-Gm-Message-State: AOAM530MmDiNs+1k6ktlvvgSKLxTRC8fODh+2srWcdC/VcmAnIwulX9j
        ixluNEtOMno0INx5m2RgOW2myXw55Ag/GzLgRFUWig==
X-Google-Smtp-Source: ABdhPJxj9kVmLDPb5TzfYODF4nrClsQQz+30NgAHek1PNbHF0Q1C9hdcWEyqYC4IdVu0LWbB+6deHxoZYu2hC0zKG8s=
X-Received: by 2002:a02:95a2:0:b0:30f:61cc:346f with SMTP id
 b31-20020a0295a2000000b0030f61cc346fmr20276611jai.273.1646127672760; Tue, 01
 Mar 2022 01:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20220227093434.2889464-1-jhubbard@nvidia.com> <20220227093434.2889464-7-jhubbard@nvidia.com>
 <CAJfpegsDkpdCQiPmfKfX_b4-bkkj5N5vRhseifEH6woJ7r0S6A@mail.gmail.com> <f0b158dc-5b01-67aa-1f49-331bf1ff2bfd@nvidia.com>
In-Reply-To: <f0b158dc-5b01-67aa-1f49-331bf1ff2bfd@nvidia.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 1 Mar 2022 10:41:01 +0100
Message-ID: <CAJfpegvcX4n3Ac5ekNNKGRh-cDGjSjX3CuS7+SOWvfksii-UEw@mail.gmail.com>
Subject: Re: [PATCH 6/6] fuse: convert direct IO paths to use FOLL_PIN
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     jhubbard.send.patches@gmail.com, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 28 Feb 2022 at 22:16, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2/28/22 07:59, Miklos Szeredi wrote:
> > On Sun, 27 Feb 2022 at 10:34, <jhubbard.send.patches@gmail.com> wrote:
> >>
> >> From: John Hubbard <jhubbard@nvidia.com>
> >>
> >> Convert the fuse filesystem to support the new iov_iter_get_pages()
> >> behavior. That routine now invokes pin_user_pages_fast(), which means
> >> that such pages must be released via unpin_user_page(), rather than via
> >> put_page().
> >>
> >> This commit also removes any possibility of kernel pages being handled,
> >> in the fuse_get_user_pages() call. Although this may seem like a steep
> >> price to pay, Christoph Hellwig actually recommended it a few years ago
> >> for nearly the same situation [1].
> >
> > This might work for O_DIRECT, but fuse has this mode of operation
> > which turns normal "buffered" I/O into direct I/O.  And that in turn
> > will break execve of such files.
> >
> > So AFAICS we need to keep kvec handing in some way.
> >
>
> Thanks for bringing that up! Do you have any hints for me, to jump start

How about just leaving that special code in place?   It bypasses page
refs and directly copies to the kernel buffer, so it should not have
any affect on the user page code.

> a deeper look? And especially, sample programs that exercise this?

Here's one:
# uncomment as appropriate:
#sudo dnf install fuse3-devel
#sudo apt install libfuse3-dev

cat <<EOF > fuse-dio-exec.c
#define FUSE_USE_VERSION 31
#include <fuse.h>
#include <errno.h>
#include <unistd.h>

static const char *filename = "/bin/true";

static int test_getattr(const char *path, struct stat *stbuf,
             struct fuse_file_info *fi)
{
    return lstat(filename, stbuf) == -1 ? -errno : 0;
}

static int test_open(const char *path, struct fuse_file_info *fi)
{
    int res;

    res = open(filename, fi->flags);
    if (res == -1)
        return -errno;

    fi->fh = res;
    fi->direct_io = 1;
    return 0;
}

static int test_read(const char *path, char *buf, size_t size, off_t offset,
              struct fuse_file_info *fi)
{
    int res = pread(fi->fh, buf, size, offset);
    return res == -1 ? -errno : res;
}

static int test_release(const char *path, struct fuse_file_info *fi)
{
    close(fi->fh);
    return 0;
}

static const struct fuse_operations test_oper = {
    .getattr    = test_getattr,
    .open        = test_open,
    .release    = test_release,
    .read        = test_read,
};

int main(int argc, char *argv[])
{
    return fuse_main(argc, argv, &test_oper, NULL);
}
EOF

gcc -W fuse-dio-exec.c `pkg-config fuse3 --cflags --libs` -o fuse-dio-exec
touch /tmp/true

#run test:
./fuse-dio-exec /tmp/true
/tmp/true
umount /tmp/true
