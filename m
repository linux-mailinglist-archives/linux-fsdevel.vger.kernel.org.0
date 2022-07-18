Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B922B577F1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jul 2022 11:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbiGRJ4c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jul 2022 05:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiGRJ4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:56:31 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06A31A05E
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 02:56:29 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id m13so4342392edc.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jul 2022 02:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EUG2Bl6auG4euKWbKCVfTQIsL72qesYuYx+oA0TLXYA=;
        b=cg5+u12elLlpSxw3zBnGpBIdLV4ULJ+lK4j7a2Vev65lyzIlATOSd8n5BjaNPJVE+Z
         Ro3kg6lD3KBtLbjuyrfp3MwPHJ6Nf2i2nIZ1XYoVYC8qgHVN7KCKPRYjaIRiWVcpiS/L
         1ZAbIDtBWP5aW9TvBDocEY2oz9hrdSOxVrrIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EUG2Bl6auG4euKWbKCVfTQIsL72qesYuYx+oA0TLXYA=;
        b=qDOqNl4I2Pd7aa766FbSuYuRzFUt5eSuRytXG7BChIZNQGwgSlzFDK/0i+VAsjbMrz
         Mxo8ZlwzAqLKjBCOxBdawd56YyeqD1yhHbkNvKZAJsR5iCoVgggoOH/6Dn/04f0Ndn9s
         pbrZOgCi7dvuaFmwu2xX0hqTAE6v3sMOA+c2lipsvTOwBjFb4kDavrAugw9M5caJ/N3n
         RojYLtvWwCT3lSyLmlrVKn9U3PbE+qgvW86eaH5dPMxC3wUEJjQq6TR6XB6/p+vkm0Uf
         ljqQCcJSMqO2jiohBXIZvea5d3eswWrAH7bXFPATKXj7XSZtTOACYVyquk3bdoEHBvbv
         +wig==
X-Gm-Message-State: AJIora8Jg+nIc2FyKyBXveiWl4EwL42yVMxYpFj1hS792PeFR4XM3lo1
        EdBvG93uXeQPD0XUZGooqEPnjiHJCLIVKY7kI+ZVzw==
X-Google-Smtp-Source: AGRyM1siVaVBPENz8Hu3bRiVVYnwdDIPhJO1Dl29/Uf8jdEBsgt3QTxxZTllwS0pUhnOqW9n8zkC3tCxOzTTfQgM/O8=
X-Received: by 2002:a05:6402:e96:b0:43a:f21f:42a0 with SMTP id
 h22-20020a0564020e9600b0043af21f42a0mr36554601eda.382.1658138188528; Mon, 18
 Jul 2022 02:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220601011103.12681-1-dlunev@google.com> <20220601111059.v4.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
In-Reply-To: <20220601111059.v4.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Jul 2022 11:56:17 +0200
Message-ID: <CAJfpegsitwAnrU3H3ig3a7AWKknTZNo0cFc5kPm09KzZGgO-bQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] FUSE: Retire superblock on force unmount
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        Daniil Lunev <dlunev@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 1 Jun 2022 at 03:11, Daniil Lunev <dlunev@chromium.org> wrote:
>
> From: Daniil Lunev <dlunev@chromium.org>
>
> Force unmount of FUSE severes the connection with the user space, even
> if there are still open files. Subsequent remount tries to re-use the
> superblock held by the open files, which is meaningless in the FUSE case
> after disconnect - reused super block doesn't have userspace counterpart
> attached to it and is incapable of doing any IO.
>
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
>
> Signed-off-by: Daniil Lunev <dlunev@google.com>

Why the double sign-off?

> ---
>
> (no changes since v3)
>
> Changes in v3:
> - No changes
>
> Changes in v2:
> - Use an exported function instead of directly modifying superblock
>
>  fs/fuse/inode.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 8c0665c5dff88..8875361544b2a 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -476,8 +476,11 @@ static void fuse_umount_begin(struct super_block *sb)
>  {
>         struct fuse_conn *fc = get_fuse_conn_super(sb);
>
> -       if (!fc->no_force_umount)
> -               fuse_abort_conn(fc);
> +       if (fc->no_force_umount)
> +               return;
> +
> +       fuse_abort_conn(fc);
> +       retire_super(sb);

And this is called for both block and non-block supers.  Which means
that the bdi will be unregistered, yet the sb could still be reused
(see fuse_test_super()).

Thanks,
Miklos
