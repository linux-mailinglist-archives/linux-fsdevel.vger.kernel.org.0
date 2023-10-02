Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D1E7B5496
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 16:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbjJBOGj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 10:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237568AbjJBOGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:06:37 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D19B7
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 07:06:34 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5334d78c5f6so22271667a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Oct 2023 07:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696255592; x=1696860392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VAUW2Ptp5fi9nS33M4QVhTdomfny1tX/0T0B0Bv24+E=;
        b=Le+f2bi555UHdJiUaczzOTiAPdr9bcw/o1CQEv7VuyRN+s8DOrtRhQxuOE9r9aHSuq
         GKv607hN5G1Kj9MmaMVxYGzRwCU8NXG5hg1r4wPnbUl0kqzWbNi5k0qqIlyjTssUg1h9
         Z2X0q/DUAkCXQMWMZNny7N/jgQ2mX3BRyDrLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696255592; x=1696860392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VAUW2Ptp5fi9nS33M4QVhTdomfny1tX/0T0B0Bv24+E=;
        b=B+VFhiUWycMnsPn8xmOqto+qrR2hpv8sad0DWQyZGH1KPKR94JEVMvFK4q5B3jo8Na
         XzNTqsDsqxVHvm5Jrt/dV9EQCz24J2qoKxZ+dM7PuDxCjpyjecjlcxX4rjf6IAgsTJGC
         uhpY1PELF41SSVNE/H2+cgvfmmGtpIAg5tt+ZXz9zzZ1wFtnY9oybfzNz2LsiMvou7/P
         9xk3OhZ++Ob/X4FYkFXOwz10wRdhH/xvXyQk0fT1oEpMz+JlUzokbX1zs5mY1Io+l9JJ
         R9fG9KN7NCVKElrHS7L0NG9nZHZRzlLsceqhvvfsAuci31cAgAG7XENB+RLgyIu5tORV
         SF2w==
X-Gm-Message-State: AOJu0YwS6EbR4epY4vhfgaNXTeyBprjjf3QSjZl8nmyo93ltjiE1OeZd
        5KBCevsMcMfp7RvRDdAcxOWeCJEJI2OCHocPgQM5PA==
X-Google-Smtp-Source: AGHT+IE/k6ZogsbwM1Fd76z6VuVtEfqC9nMU+wHRR5+ZViTk/+6X0EY9eyACzk4fTvCyTSK/2vgUBXR1qINsRuP6V3Q=
X-Received: by 2002:a17:906:31da:b0:9b2:ba66:bbb0 with SMTP id
 f26-20020a17090631da00b009b2ba66bbb0mr10451279ejf.28.1696255592421; Mon, 02
 Oct 2023 07:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231002120413.880734-1-amir73il@gmail.com>
In-Reply-To: <20231002120413.880734-1-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 2 Oct 2023 16:06:21 +0200
Message-ID: <CAJfpeguNPHW8x3uwqzB_kKt_NxyPdMNNJUkMOsfvtxoAtAa1Ug@mail.gmail.com>
Subject: Re: [PATCH] overlayfs: make use of ->layers safe in rcu pathwalk
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2 Oct 2023 at 14:04, Amir Goldstein <amir73il@gmail.com> wrote:
>
> ovl_permission() accesses ->layers[...].mnt; we can't have ->layers
> freed without an RCU delay on fs shutdown.
>
> Fortunately, kern_unmount_array() that is used to drop those mounts
> does include an RCU delay, so freeing is delayed; unfortunately, the
> array passed to kern_unmount_array() is formed by mangling ->layers
> contents and that happens without any delays.
>
> The ->layers[...].name string entries are used to store the strings to
> display in "lowerdir=..." by ovl_show_options().  Those entries are not
> accessed in RCU walk.
>
> Move the name strings into a separate array ofs->config.lowerdirs and
> reuse the ofs->config.lowerdirs array as the temporary mount array to
> pass to kern_unmount_array().
>
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/r/20231002023711.GP3389589@ZenIV/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Miklos,
>
> Please review my proposal to fix the RCU walk race pointed out by Al.
> I have already tested it with xfstests and I will queue it in ovl-fixes
> to get more exposure in linux-next.

Looks good.

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos
