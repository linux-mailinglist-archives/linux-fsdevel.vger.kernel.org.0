Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D063E5F0CCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 15:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiI3NyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 09:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiI3NyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:54:03 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0B8157FDA
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 06:53:59 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c30so6087119edn.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 06:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=oZ1cYWbsiZwnlcXnkO22f7DP/bqRfobBGFUYgj3MHIk=;
        b=cLiRpWsBrvolZZzC5sS5jFy0oenkw7m9pG/JlHYXvnBcqg7270Pv68OYTu4g0jydR8
         zMfTKER5qfEmqcUbp4nHnIA619FbUDMKfNXN3XfmtxnNSjAHIuLO3DR/uxuz1z3CUNTO
         tud9WtRz2kNaU3KfFfTunhrCKF7IHy8luMjMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oZ1cYWbsiZwnlcXnkO22f7DP/bqRfobBGFUYgj3MHIk=;
        b=kgXI5A1yOqjoCn1/jdIehyEYMqOPs6RomXmoly4cyFROvALhQpNUb91fgIdFRpI+H3
         /+f5bNnoCHJkdi3OaRgisN4pf99eY5TLHjtip70iW3cLmOHH3jlCGr3p6Ox1ckKS1IDh
         kYEDxkTlNDl0JujcPC7Itn1z+O0XwoLfqAomXhFiIR5Oti9OT9uAjD0v7JygAWX+3EgA
         BCj/ukNEwW58Mj699WQc8XWxMoJ+mdBeCgtNYGaNYHJtUOgnyiiiTjoQOMyoGwu/fJTF
         FnIrZyS5yCkm19ajlO+lEz1tLsd8Hq/jxZaNS4eqLAd+wAg8gJIdS0s5+CCUHkOvvgvg
         rEtA==
X-Gm-Message-State: ACrzQf1jO4tG3+f3o3bSlBBOnz/XBWyk+LqxWTMDrtybDOaPvMCC90DJ
        P0nh41QVlpQDFYftvR3y6/uCVYQLR35yexz5l8Ehzw==
X-Google-Smtp-Source: AMsMyM4iMVty4++0iEUyvPtgzPySWUYabD0rh87Sf8s/IqeXm7odxbqE0PbEoc9W0Qvshl10oNNd55YnxImIxO257Ug=
X-Received: by 2002:a50:fc0a:0:b0:458:73c0:7e04 with SMTP id
 i10-20020a50fc0a000000b0045873c07e04mr3704377edr.270.1664546038020; Fri, 30
 Sep 2022 06:53:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220922084442.2401223-1-mszeredi@redhat.com> <20220922084442.2401223-6-mszeredi@redhat.com>
 <3533150.1664441085@warthog.procyon.org.uk>
In-Reply-To: <3533150.1664441085@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 30 Sep 2022 15:53:47 +0200
Message-ID: <CAJfpegt7OiGnXC8ut9yth8z_OhqDK8v+pN81e3F1tgkZftjMEA@mail.gmail.com>
Subject: Re: [PATCH v4 05/10] cachefiles: use vfs_tmpfile_open() helper
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 29 Sept 2022 at 10:45, David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> > -             path.dentry = vfs_tmpfile(&init_user_ns, fan, S_IFREG, O_RDWR);
>
> Is there any point passing S_IFREG in to vfs_tmpfile()?  Can you actually make
> a tmpfile that isn't a regular file?

No, it can't.  The argument is for the create mode, not the type.

Seems like the open(O_TMPFILE) path masks out the type in
build_open_how(), so passing zero here would make sense.

Thanks,
Miklos
