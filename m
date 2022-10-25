Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5694B60D3C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 20:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiJYSog (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Oct 2022 14:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiJYSof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Oct 2022 14:44:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510A9D2DA
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 11:44:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a67so37686348edf.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Oct 2022 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zecUBmaI9PgC41i43sLomBgRMf4lJ2WJueLyjCsQE94=;
        b=GrpYgqsXMIgui8uqNCF3FndCtXTpG2IOEK9KoQql6JDLzVaWmiibzo5T2OSVNUVIqr
         utrd6ZBEOlZkcyKpthDlnr9lzYi0dDCa+rrBe+FV/dKxwJr6CBNOosM5bFY44SDtG4xr
         //cgXIz8QHaymHQowERHA/QPrePkGfO/PzvjQ1qNAoZmAUQkqLK0IzuuaOG1WHEUR/+v
         QMerdEXMGlvln/2gQz733PfcsLVG6LzlMrauRfVmITC7xpEnKv2IMHcHVAbemNgrqKfC
         0vqJZ97L9FIcoygG7zGR2eZ2z0ybM8DXHBjPFP+DgJNCoEICeSh+HUeDlmn7gC2sQnQq
         5o7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zecUBmaI9PgC41i43sLomBgRMf4lJ2WJueLyjCsQE94=;
        b=DQHleGaMQYSoFLXIR0LfHWRWbbEFnJ4DceaS627JHlXwjiQH/NZdtKJaSIzyVQfO4l
         nJ0r3hVzTgdwKtftEthafuu6wcQaCVhPicMMa2mxW4sARsYRm+3gNQ0LrmjACBVU9XNB
         ZUNDxcnpZl3xpkQK+nymFJPwp4oqKgd8wc5ibWFYma+5VTSGMUrIPwqbsw9dBURJ9MZv
         ZzYJFtfMjhe0+c8wmYX9u8D2cXT9KX9A//FEebWJ+egrNz9W2QKXy/xLS4aoOmPORE7R
         IbvWTuYa45bjMj0bitQqKiXsudUvD/fHdinwpHfIc2pT64DdKVFX9FfZEll9+Ju5D0MJ
         r6NQ==
X-Gm-Message-State: ACrzQf3fS+XVg0yvM2Cdk6JvcwA+AsVJ8kBuVHKgh6l79+y80HVM+/Da
        zzB/WhvRmdh3P7yjR1MXTwMZmd2SqoToPF4xV+lEsA==
X-Google-Smtp-Source: AMsMyM4ZkPUJKPqq8WU62lmoXS/vK4yvPpPYvxqfRbAacNAnUf+3fk754O069p+m96XChAq4xX1LThIIrsHaeGlaODY=
X-Received: by 2002:aa7:df94:0:b0:461:aff8:d3e1 with SMTP id
 b20-20020aa7df94000000b00461aff8d3e1mr13166171edy.10.1666723471729; Tue, 25
 Oct 2022 11:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221025182149.3076870-1-axelrasmussen@google.com>
In-Reply-To: <20221025182149.3076870-1-axelrasmussen@google.com>
From:   Lokesh Gidra <lokeshgidra@google.com>
Date:   Tue, 25 Oct 2022 11:44:20 -0700
Message-ID: <CA+EESO6-W7SidFxz8+5FL-Jqu5L4pUZTpYVJ+2xdktxXgwXE5Q@mail.gmail.com>
Subject: Re: [PATCH] userfaultfd: wake on unregister for minor faults as well
 as missing
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks for fixing this issue.

On Tue, Oct 25, 2022 at 11:21 AM Axel Rasmussen
<axelrasmussen@google.com> wrote:
>
> This was an overlooked edge case when minor faults were added. In
> general, minor faults have the same rough edge here as missing faults:
> if we unregister while there are waiting threads, they will just remain
> waiting forever, as there is no way for userspace to wake them after
> unregistration. To work around this, userspace needs to carefully wake
> everything before unregistering.
Actually, WAKE ioctl doesn't check if the provided range is registered
with userfaultfd or not. So, it's possible to wake the waiting threads
after unregisteration.

But, in this context, missing faults are the same as minor faults (and
wp too?). Therefore, waking the waiting threads as part of
unregistration is expected.
>
> So, wake for minor faults just like we already do for missing faults as
> part of the unregistration process.
>
> Cc: stable@vger.kernel.org
> Fixes: 7677f7fd8be7 ("userfaultfd: add minor fault registration mode")
> Reported-by: Lokesh Gidra <lokeshgidra@google.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  fs/userfaultfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index 07c81ab3fd4d..7daee4b9481c 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -1606,7 +1606,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
>                         start = vma->vm_start;
>                 vma_end = min(end, vma->vm_end);
>
> -               if (userfaultfd_missing(vma)) {
> +               if (userfaultfd_missing(vma) || userfaultfd_minor(vma)) {
>                         /*
>                          * Wake any concurrent pending userfault while
>                          * we unregister, so they will not hang
> --
> 2.38.0.135.g90850a2211-goog
>
