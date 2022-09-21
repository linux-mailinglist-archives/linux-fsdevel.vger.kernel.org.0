Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8FA5C01A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 17:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIUPcQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Sep 2022 11:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIUPbv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:31:51 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B209DF85
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 08:28:28 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b35so9339818edf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Sep 2022 08:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+h6cqyYOcNMOTayESofm5ca4MdjtR2jYV85M+mzZzeA=;
        b=q+DL5sOWZrQZvNjJeuyx4WtQ/O4VCXFpHDL2T3cFHPKTY+nfrk9WLJ9eO6TnwiHL/8
         /2V+pMFtkOUcU3gxRTGIkPvoTgd4l6+52pfOFVrB6By/TU4zLAhEXCiNYWjrdwAT1YuP
         ZExsF+NdIFKoIIeThbfPOjL5rH9RcJWa1uJYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+h6cqyYOcNMOTayESofm5ca4MdjtR2jYV85M+mzZzeA=;
        b=zMkWnyIfFBgV6RMNXxMclxFW44/A1u1eMLA3nV/x9J6HpteCZ151ThvoaO8cs3rL30
         FJcODO9RvSuAIRvFq4VEBcgzjnPvuy/1F6vz3lXGMCerFycCKZsVtAPOnEOu71zxdiPW
         RX8naAnXCcfyRbL36k2/vJflEJTIdedTayzVTuZLsTehn+nAkCk4Q+KsyXWKp0JpWIV6
         qRQT1t6nEH9jDU3RP3McCFXRc3Is4YNK4j4gsVl+4Eb33mA38YQvwW5k5f+h+CjqjsGE
         w7GBhN1jqok6EC6AKL9MAXXGeuMdbV3ePT4nH2In2FOANDvl1CfNItyWgXeSjRMwmaH9
         f+uA==
X-Gm-Message-State: ACrzQf0rx4vt9UcVvQmVGewsCvLwu80WQjJtB+k78tpIs2XmLH9tyrMV
        PWzlqewC74EOe7ib4UDPWRE+cKU8RRy+xbFcHIBnVg==
X-Google-Smtp-Source: AMsMyM7PPDgLZkzOzGYH56ypltLpc2FBw2keSpcAQO1dD63vj6HemvrUhSLe+vCN+bfc4ZB+6lgHVMVydbRRRBhT4DE=
X-Received: by 2002:a50:ef03:0:b0:44e:82bf:28e6 with SMTP id
 m3-20020a50ef03000000b0044e82bf28e6mr24407128eds.270.1663774049965; Wed, 21
 Sep 2022 08:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220920193632.2215598-1-mszeredi@redhat.com> <20220920193632.2215598-9-mszeredi@redhat.com>
 <20220921090820.woijqimkphaf3qll@wittgenstein> <CAJfpegt8ZX88EbDqPci5ZOBDkrT-bZt=T+XWarw0=zpCAxkLwQ@mail.gmail.com>
 <20220921150750.grruzm3copwproyu@wittgenstein>
In-Reply-To: <20220921150750.grruzm3copwproyu@wittgenstein>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 21 Sep 2022 17:27:18 +0200
Message-ID: <CAJfpegtZwMUGQ+J+STD9V9rxjX=vCKD-YBtLgWpe+GAf75ffkw@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] vfs: open inside ->tmpfile()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
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

On Wed, 21 Sept 2022 at 17:08, Christian Brauner <brauner@kernel.org> wrote:
>
> On Wed, Sep 21, 2022 at 04:58:38PM +0200, Miklos Szeredi wrote:

> > file_dentry() is basically a hack for overlayfs's "fake path" thing.
> > It should only be used where strictly necessary.  At one point it
> > would be good to look again at cleaning this mess up.
>
> Yeah, that's what I was getting at. The file_dentry() helper would
> ideally just be as simple as file_inode() and then we'd have
> file_dentry_real() for the stacking filesystem scenarios.

Sure.  But that again belongs to a separate discussion, imo.

Thanks,
Miklos
