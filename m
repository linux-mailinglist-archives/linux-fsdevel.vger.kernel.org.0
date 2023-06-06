Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF63723E3C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 11:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236874AbjFFJto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 05:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjFFJth (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:49:37 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D871DE7A
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 02:49:16 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-977d4a1cf0eso341455766b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 02:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686044955; x=1688636955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TpBBFDZE7NXoIwrI7NNl5J1j6FinLKliLX9XSZwulI=;
        b=ZxzeqLI9rnEiMcmgBNMFYtUgjk0GF5on/7gs/3MZ6fRCIizEgQJEJst2YHGYnxAfnR
         B7XhtCSSW6nkwaI9RC86D9D/UQzDB372LzuAGgQf2HYgDnIkb3JU6gElCd4Fxi4AfbcH
         c+6AIR2rAMEM7IbxFhpdvfdMF5gaTUf7DT1xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686044955; x=1688636955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TpBBFDZE7NXoIwrI7NNl5J1j6FinLKliLX9XSZwulI=;
        b=JA/GnmSl7c+zX7afa3fPCvZITVEjRyhZJy3ofNsrH6kOYSLeEKp1jhikESNwWhhjX2
         iUBIB2HeItKA1q7Da2bXNJ3/qgWtJMqWvmOelsh5fPWWaPK7inashn0ZN7KWyVMevAY7
         HWyTQ2+6fOz2/IzpyEeeGG8tgW/1nERyLI+DPoKY+jReB1QDYHQAQoOH+xie7BA8LwHm
         Ip54a94lXMBfh7zMsVq58jzSX7vyQAMmUcF5WuVbHYJBAIwwauD3f18rhPzFBU+xY+lO
         Q1LXyarAORk30yHSCfpM5CVUr21v9rcPdT0NRU/shZP3kYlG1h5H0zaLV922HhOpjlq+
         A7kQ==
X-Gm-Message-State: AC+VfDwgCF6btDb36zJb4Hf9AIPJyg+I48+Ex7Q65WMtSogM2thLIew/
        bGHlbjv+we8RVIiKNeyO0kkeJrDJp4kthXGXURZFZQ==
X-Google-Smtp-Source: ACHHUZ62s+JyrOhlo5FytoEXjB5yAo79/xFnLkSkoVpgRFtBuvslchlDzdSi3CqInmBJxCYfO2109l0MNs3lt709ELk=
X-Received: by 2002:a17:907:3189:b0:974:625d:183f with SMTP id
 xe9-20020a170907318900b00974625d183fmr1711883ejb.36.1686044955403; Tue, 06
 Jun 2023 02:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
In-Reply-To: <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 6 Jun 2023 11:49:04 +0200
Message-ID: <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 6 Jun 2023 at 11:13, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, May 19, 2023 at 3:57=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > Miklos,
> >
> > This patch set addresses your review feedback on Alesio's V12 patch set
> > from 2021 [1] as well as other bugs that I have found since.
> > This patch set uses refcounted backing files as we discussed recently [=
2].
> >
> > I am posting this for several possible outcomes:
> >
> > 1. Either FUSE-BPF develpers can use this as a reference implementation
> >    for their 1st phase of "backing file passthrough"
> > 2. Or they can tell me which API changes need to made to this patch set
> >    so the API is flexible enough to extend to "backing inode passthroug=
h"
> >    and to "BPF filters" later on
> > 3. We find there is little overlap in the APIs and merge this as is
> >
> > These patches are available on github [3] along with libfuse patches [4=
].
> > I tested them by running xfstests (./check -fuse -g quick.rw) with late=
st
> > libfuse xfstest support.
> >
> > Without FOPEN_PASSTHROUGH, one test in this group fails (generic/451)
> > which tests mixed buffered/aio writes.
> > With FOPEN_PASSTHROUGH, this test also passes.
> >
> > This revision does not set any limitations on the number of backing fil=
es
> > that can be mapped by the server.  I considered several ways to address
> > this and decided to try a different approach.
> >
> > Patch 10 (with matching libfuse patch) is an RFC patch for an alternati=
ve
> > API approach. Please see my comments on that patch.
> >
>
> Miklos,
>
> I wanted to set expectations w.r.t this patch set and the passthrough
> feature development in general.
>
> So far I've seen comments from you up to path 5/10, so I assume you
> did not get up to RFC patch 10/10.
>
> The comments about adding max stack depth to protocol and about
> refactoring overlayfs common code are easy to do.
>
> However, I feel that there are still open core design questions that need
> to be spelled out, before we continue.
>
> Do you find the following acceptable for first implementation, or do you
> think that those issues must be addressed before merging anything?
>
> 1. No lsof visibility of backing files (if server closes them)
> 2. Derived backing files resource limit (cannot grow beyond nr of fuse fi=
les)
> 3. No data consistency guaranty between different fd to the same inode
>     (i.e. backing is per fd not per inode)

I think the most important thing is to have the FUSE-BPF team onboard.
   I'm not sure that the per-file part of this is necessary, doing
everything per-inode should be okay.   What are the benefits?

Not having visibility and resource limits would be okay for a first
version, as long as it's somehow constrained to privileged use.  But
I'm not sure it would be worth it that way.

Thanks,
Miklos
