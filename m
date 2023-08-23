Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41938785387
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 11:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjHWJKY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 05:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235304AbjHWJHx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:07:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A381BF2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 02:02:02 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c1c66876aso711818266b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Aug 2023 02:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692781314; x=1693386114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=htSMjdk85wELugVDXAhr8cuhpjEm2Q5vyQ8twDUxEyk=;
        b=hG3ilkGGJUfAI8sRdQkgGVOuFHUn22bI04fyKmmYAttiVJlkyoYN3afCusCr4PMbkA
         pNfZSGNZXoSy2v14RslrgQtlmPD00F52wpUwPUo+INhkkkDq8S5TgiTaX1OmH6cwxhvM
         K+2F0DAHY0lZgmYME1PI3mNPKJN0EmsDIGstw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692781314; x=1693386114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htSMjdk85wELugVDXAhr8cuhpjEm2Q5vyQ8twDUxEyk=;
        b=d+UGYao4o/z0mb5KjjzrF1w4HFgA3g8Fvre6vcuN5ILm6luPJQtZJZ0eUY3XpumyKH
         8XDYNBAJsp+V7ehr7dYncn0nRv1ZoQu4t1Mk4kSI6GkXde1gL0gC649QDm+AccO6yXEc
         H8qww5PV59mKSqkre2vArSa4kbt4vtoESYY1W61jw2harB9B8WblYPyg8wi7xMbsW0fO
         yd01ZrYO1T+X14KbYONXSVv0bj8qxyM52ev3jcjpNe5tsSwuksgAAtOK9gMIXD+d19uB
         cmZPBOSxe8jfklMGdDQAJlLhtVvRw43u7Pc4nlUkfJTePlmDDUACY+6sFcibnr+zuGwE
         smNQ==
X-Gm-Message-State: AOJu0YyHCVP0L/Cw0LjnSn4fV73P7I3SXGSCtOVKH0ogHYzntO10+w2u
        PH2tR8s8qtZxOlsHQtOoNCwUJvg8fw/yky8iWc54hQ==
X-Google-Smtp-Source: AGHT+IETRpv9wXDM4ZeEVu1LHXQq7WY3Gxn4hHYL3/vW0KawK2WFCTMwX7ltbe/FKT2CNlG4aOJ/vzL7dF8Br1Y5zzw=
X-Received: by 2002:a17:906:1d9:b0:991:b554:e64b with SMTP id
 25-20020a17090601d900b00991b554e64bmr10551621ejj.54.1692781313930; Wed, 23
 Aug 2023 02:01:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com> <20230711043405.66256-4-zhangjiachen.jaycee@bytedance.com>
In-Reply-To: <20230711043405.66256-4-zhangjiachen.jaycee@bytedance.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 23 Aug 2023 11:01:42 +0200
Message-ID: <CAJfpegtocWjfqVUpdnct-1-pq_DYJXUuvkBWey2N5q6+K=pL_w@mail.gmail.com>
Subject: Re: [PATCH 3/5] fuse: add FOPEN_INVAL_ATTR
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        me@jcix.top
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 11 Jul 2023 at 06:36, Jiachen Zhang
<zhangjiachen.jaycee@bytedance.com> wrote:
>
> Add FOPEN_INVAL_ATTR so that the fuse daemon can ask kernel to invalidate
> the attr cache on file open.
>
> The fi->attr_version should be increased when handling FOPEN_INVAL_ATTR.
> Because if a FUSE request returning attributes (getattr, setattr, lookup,
> and readdirplus) starts before a FUSE_OPEN replying FOPEN_INVAL_ATTR, but
> finishes after the FUSE_OPEN, staled attributes will be set to the inode
> and falsely clears the inval_mask.
>
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> ---
>  fs/fuse/file.c            | 10 ++++++++++
>  include/uapi/linux/fuse.h |  2 ++
>  2 files changed, 12 insertions(+)
>
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index de37a3a06a71..412824a11b7b 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -215,6 +215,16 @@ void fuse_finish_open(struct inode *inode, struct file *file)
>                 file_update_time(file);
>                 fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
>         }
> +
> +       if (ff->open_flags & FOPEN_INVAL_ATTR) {
> +               struct fuse_inode *fi = get_fuse_inode(inode);
> +
> +               spin_lock(&fi->lock);
> +               fi->attr_version = atomic64_inc_return(&fc->attr_version);

No need to add locking or change fi->attr_version.  This will be done
next time the attributes are updated.

Thanks,
Miklos
