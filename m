Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3C25FC113
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Oct 2022 09:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJLHIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Oct 2022 03:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJLHIk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Oct 2022 03:08:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4436527C
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 00:08:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a67so13861656edf.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Oct 2022 00:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RY4EHlELhE/Ndf6I6eULMXjsg1nT+7PDxVCZ2yG0c5A=;
        b=XM1kf9+4A4wYgwpzvnT9F3mJayr4U4NUKnkm6hKCNf+Myf7+61Vtktx4OHAe/cZ5O0
         YaqqjPk5dRtJUE6uWUOZLULA8ydR9JLsyd70vja6ebl60IxPqPRlR0dnKd98uz7AIRLW
         UnaNaJ1f2wxVZIw/9T0MtR0ZDGAnI4Re2PVys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RY4EHlELhE/Ndf6I6eULMXjsg1nT+7PDxVCZ2yG0c5A=;
        b=UGe7Gf4Bzu/BR/Gh0ULMgyyt/NzQ9U5S734ZSfpa+g8BrvkQDTSB4TJoPJpHHcI9gl
         D9TxrPqIY1McGD630Mx086VAfVaP8MKvhD6aDH8r6DqL2O4juceMj7QBbs44eBgzfrd7
         N/akFa7Agqco+KJwe6+Z7x5kGarBwZ5ZGy9sKfkiaGhkTHFcEU+b2fxuYfAOGYcffYNM
         3unclU2n5+iVRhgxQsYVB/YED70uDcfZlVOCESxerzka/XGnJTqOTTJD7kKRPoILqExY
         E9ZdGJ75FxSra/mtVHuGXg3xMljfN8wGx80kThffM4AIu6+mocwmPDP979/B2z8PrzQj
         YyOw==
X-Gm-Message-State: ACrzQf2cIliJCV0pWIcWZZJJl8uepgP5DxYlyFsG8FKeRIDdbaM32y1x
        ZX065R6aNFfyieMO6vJ3LGrYIU70omcf9M2qmt3zdA==
X-Google-Smtp-Source: AMsMyM6NlIbggFZYRHjEPik5TH7xsTvj5wzqfsmgkAE8/I+Icu1uGMyTK4mS6w+0qiwmGip6ye7XCbdKbLLCPAdNxNQ=
X-Received: by 2002:a05:6402:448:b0:45c:8de5:4fc with SMTP id
 p8-20020a056402044800b0045c8de504fcmr4914676edw.133.1665558515113; Wed, 12
 Oct 2022 00:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <Y0Wv6qe3r8/Djt7s@ZenIV> <CAJfpegsgtke1X7FGpMSgTGdDsOxU7kqPqf2JbOAnqgMj0XFoSQ@mail.gmail.com>
 <5a5a92423c8bac5b275c213ed1ce3fa59cafda4f.camel@redhat.com>
In-Reply-To: <5a5a92423c8bac5b275c213ed1ce3fa59cafda4f.camel@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 Oct 2022 09:08:24 +0200
Message-ID: <CAJfpegsD_hLxCq=z7eAyHT3+e5MN4tgWBqhjOPBPywnqjotQRQ@mail.gmail.com>
Subject: Re: [RFC] fl_owner_t and use of filp_close() in nfs4_free_lock_stateid()
To:     Jeff Layton <jlayton@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 11 Oct 2022 at 22:45, Jeff Layton <jlayton@redhat.com> wrote:

> The NFS client maintains lock records in the local VFS.

This is what fuse does, unless server explicitly requests remote posix
locking with the FUSE_POSIX_LOCKS init flag.  Not sure how many real
fuse filesystem out there actually implement this, probably not a lot.

>  When a file is
> closed, the VFS issues a whole file unlock. You're probably getting
> bitten by this in locks_remove_posix:
>
>         ctx =  smp_load_acquire(&inode->i_flctx);
>         if (!ctx || list_empty(&ctx->flc_posix))
>                 return;
>
> Because FUSE doesn't set any locks in the local kernel, that final
> unlock never occurs.

Fuse doesn't care, because if remote posix locks are enabled, then
unlocking should be done in the FUSE_FLUSH request.

> There are a couple of options here: You could have FUSE start setting
> local lock records, or you could look at pushing the above check down
> into the individual ->lock ops.

I don't remember the details, but setting local locks wasn't a good option.

Thanks,
Miklos
