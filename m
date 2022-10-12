Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AE25FC6B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 15:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJLNqV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 09:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJLNqT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:46:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62987B9785
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 06:46:18 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qw20so37494810ejc.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6spuubBZPMae2KH0MSDLc1QYT4H++OxwkE+WifF21RI=;
        b=p72rHA9cbLgi17z4uAJ/PM0KlXaJFxUA5op94F0cDL+w1zvPL0D+JfSRE3n3AKpdQk
         H/aWc7cQEC+scz8S7Q+03GyOtOyhOikepVm1I2GaMBEqfr3mKbVgGRVS/06KuSPESb9M
         AGTbpCtU63hWdB6EtKhA56WpuGmpAD6gRMpmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6spuubBZPMae2KH0MSDLc1QYT4H++OxwkE+WifF21RI=;
        b=CptWkr1yhZy9j1WrjoLRdm+CXT8HpkzcaoxNaSbI/OM0a3AFEMUHt0bDT+8cHjnRtC
         zmNwfOi+RcxtnRVsvqZgwfZjZvkYik88wwvRW3lEP5W8WdRyC6xbNqzYlZhAm7o+iplF
         vs3mLwL5d4cUWdQn2dy3ttgjtUDptlA6SK1J1jZ6D4Eg8VParyjMxqW7AqgUvKJ2gpGC
         l2rHg4njXwIrcGmQPwfvPT9MfIJaAca7tKE/CEem1F9cBn6+z4ODsLY+VdgssCquZ8nv
         22Vt1PhHW2QY7WOQmsF0lS8BDAYZHquq4jzeBS/7Hwf5VX72siUbjix8TTfyM+zgtDeP
         liFQ==
X-Gm-Message-State: ACrzQf2hnZEtXkYm2ti5BOI17ug5R4yGibvvjYyEeErA/mrM9b+eoNVA
        j2b+z6ZH4yCqbuwp2yOS1q+7ThHr0CvPQ530Upvbgw==
X-Google-Smtp-Source: AMsMyM4gO1Qr7n6O37HwwouesWkCNAAHFX/9bBxS3E3xd4O3QGKsOAs7e/uWYy1U6778LF81rv28AI/+ZDfGMuh+LNc=
X-Received: by 2002:a17:907:86a7:b0:78d:f741:7f9a with SMTP id
 qa39-20020a17090786a700b0078df7417f9amr1838481ejc.8.1665582377009; Wed, 12
 Oct 2022 06:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220914142632.2016571-1-jannh@google.com>
In-Reply-To: <20220914142632.2016571-1-jannh@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Oct 2022 15:46:06 +0200
Message-ID: <CAJfpegsncvnDtTHEv=qT0dGoD4B4L=cukyFwwVtaq8MKiWFQjw@mail.gmail.com>
Subject: Re: [PATCH] fuse: Remove user_ns check for FUSE_DEV_IOC_CLONE
To:     Jann Horn <jannh@google.com>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 14 Sept 2022 at 16:27, Jann Horn <jannh@google.com> wrote:
>
> Commit 8ed1f0e22f49e ("fs/fuse: fix ioctl type confusion") fixed a type
> confusion bug by adding an ->f_op comparison.
>
> Based on some off-list discussion back then, another check was added to
> compare the f_cred->user_ns. This is not for security reasons, but was
> based on the idea that a FUSE device FD should be using the UID/GID
> mappings of its f_cred->user_ns, and those translations are done using
> fc->user_ns, which matches the f_cred->user_ns of the initial
> FUSE device FD thanks to the check in fuse_fill_super().
> See also commit 8cb08329b0809 ("fuse: Support fuse filesystems outside of
> init_user_ns").
>
> But FUSE_DEV_IOC_CLONE is, at a higher level, a *cloning* operation that
> copies an existing context (with a weird API that involves first opening
> /dev/fuse, then tying the resulting new FUSE device FD to an existing FUSE
> instance). So if an application is already passing FUSE FDs across
> userns boundaries and dealing with the resulting ID mapping complications
> somehow, it doesn't make much sense to block this cloning operation.
>
> I've heard that this check is an obstacle for some folks, and I don't see
> a good reason to keep it, so remove it.
>
> Signed-off-by: Jann Horn <jannh@google.com>

I see no issues with this.   f_cred seems to be unused by the VFS, so
this should have zero effect on anything other than rejecting or
allowing FUSE_DEV_IOC_CLONE.

Applied.

Thanks,
Miklos
