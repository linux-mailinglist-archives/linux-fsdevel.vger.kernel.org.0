Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CD157293D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jul 2022 00:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiGLWY0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jul 2022 18:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbiGLWYZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:24:25 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB60B45072
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 15:24:23 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-31d85f82f0bso59852967b3.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Jul 2022 15:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYnmwW7KM7eSMK60O2MVDAmJuJD1iNrDhmXfLQOWhUo=;
        b=YuwrgdZDcGuDBD1ffmB+K+wUNZvSNDWk9s9daZGp5K86jbMwbYTZ0RZU6isUxnHFl2
         frbUhfluQkhMWz/6Zg9+Ife5C9JFobpBGe3RB8bumuHTjc9SkxDAfKqqlH0CocLf5L2N
         wBjDJZPytZpG1mnTVLwukpXUSZ3HEWXKRTryY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYnmwW7KM7eSMK60O2MVDAmJuJD1iNrDhmXfLQOWhUo=;
        b=N5fJhHMGexB2FhUEPuzbjO8zAlRZwY4x6g7H5K8TQnGrMw1tSYeM5fpkIL5oqGKqdJ
         0pSRQvPJeQHEu7jAWF//uCca7K8ZVOpPRt3lwqKyobXoEw+UflEIg8fa82DHhdqNHBOJ
         +yKphJ0DcqhWxT4UIHV8yQTqKLlTnxIYGuMF9Uj0SutRNDExfpwHsFP1cBozaUBcbpaO
         LPqgUlXEqizXNnYc5L1dWSm8rP540QIPGDVJx9CyX5+bHm6Upc4ttk94HlVIYRdNSoCn
         QcTEyqK+ihS6kuXHVqOCC96svs6/ttlNoITRx9u8zT6H+bxu/j51qEbyT/VooSg7RhDq
         8j0A==
X-Gm-Message-State: AJIora9v8Y6NyiqqxaSeveSBX7GJc41VDpNFMJAq0JW7Id9DDRl2NrI+
        51NIRkaOUWrLHMcfb67bD7yljBR6OqPXDgV9O01V3Q==
X-Google-Smtp-Source: AGRyM1sWlghpg8wmCBdiAr1Tsgqxc8Xnx1SF3AMy8mJwQU6SprqJ48M39Vme5B6zeX0OLabvtjfuCwD9phRcbVdF8c0=
X-Received: by 2002:a81:46c4:0:b0:31c:8a9d:beaa with SMTP id
 t187-20020a8146c4000000b0031c8a9dbeaamr610466ywa.103.1657664663225; Tue, 12
 Jul 2022 15:24:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220601011103.12681-1-dlunev@google.com> <20220601111059.v4.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
In-Reply-To: <20220601111059.v4.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Wed, 13 Jul 2022 08:24:11 +1000
Message-ID: <CAONX=-faZGmOe_=y_kG=erkQOR6fYdwXuF0HoFJVwMUdemxk0g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] FUSE: Retire superblock on force unmount
To:     miklos@szeredi.hu
Cc:     linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        Daniil Lunev <dlunev@google.com>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        hch@infradead.org, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Miklos,
Can you please take a look at the current patchset and see if you are
ok with it?
Thanks,
Daniil

On Wed, Jun 1, 2022 at 11:11 AM Daniil Lunev <dlunev@chromium.org> wrote:
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
>  }
>
>  static void fuse_send_destroy(struct fuse_mount *fm)
> --
> 2.31.0
>
