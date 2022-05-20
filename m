Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CCE52E535
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 08:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbiETGoz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 02:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345947AbiETGow (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 02:44:52 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFE014CA36
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 23:44:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f9so13919388ejc.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 23:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jpmMiOSokR783MBFN4XwJMiX4Y41HGkz11vamI6lPmw=;
        b=AiN0/cmcE3f9lLZ3iVlBLy7thiVIgBwcTauUWQgpGwNivNu6kANRYFLzl321wDT+fP
         BemTFBGTOs61Srx5fAst5Gp+Dwj4OQflye6xZWgLcGAM/5Dzh4kd/H9N5rDxwybYpMbB
         NNCM0UDWRMg/6BlToh/QBUuwZLwVJ5Izl7vhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jpmMiOSokR783MBFN4XwJMiX4Y41HGkz11vamI6lPmw=;
        b=lNH0vp5ZrDi39zgRWjJw1FyrYhm7EmtGq9R8D/8TxUzwM1fwdmY9TUuNFOPEi09R6p
         ifFiHhFOKSmdcc8sqZ/zZI4lePC/c2ZHrgVjiw8Z0IArT2bQ2WcKyAmBAmOljZLmgOoB
         8x/S0i/doQSZeS6HTGHKSsf5nAr3yCJBbIWufs6D/riadDW/qXL7bzMXBrgl+/xt5zt0
         2JgyszPlGEJCLTjy+KTiKmPmpX9JySaMPIyFUBc1rEH7GBegLeGq2CeBEYwW7pg5am2m
         t1zif69K4UGG06w+bh7p1T8pUNjmVOik/hX3hq/pGbY5CqrVaALF6qzPH30Ng44xSuas
         f6lQ==
X-Gm-Message-State: AOAM530sSV43N9/o+sCgF74k64hoeP7PrC69HVgpps66e5RnWY7gSfSc
        ws5fBguogIYTgw1vTsn+l7vqxp2QIzAlEkZFs93QNfQIQ/JA7Q==
X-Google-Smtp-Source: ABdhPJz+C8eGg09C1m0KVGRkSSHC3ScqU6iNmeCq0eCBNX1oLoKKDZQoLL7hOI2v0qm3Kfl4HV4l4cZmM0BmtVNGLb4=
X-Received: by 2002:a17:907:6e9e:b0:6fe:8d81:b4a3 with SMTP id
 sh30-20020a1709076e9e00b006fe8d81b4a3mr7330356ejc.748.1653029087636; Thu, 19
 May 2022 23:44:47 -0700 (PDT)
MIME-Version: 1.0
References: <YoZXro9PoYAPUeh5@miu.piliscsaba.redhat.com> <YocT+9pebi3ZBHdn@zeniv-ca.linux.org.uk>
In-Reply-To: <YocT+9pebi3ZBHdn@zeniv-ca.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 20 May 2022 08:44:35 +0200
Message-ID: <CAJfpegu4Pa+XUnooZn4g9OCK9Kyh9UTSROvah=E57zvg=+53Ww@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: allow ->atomic_open() on positive
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dharmendra Singh <dharamhans87@gmail.com>,
        Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 20 May 2022 at 06:07, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, May 19, 2022 at 04:43:58PM +0200, Miklos Szeredi wrote:
> > Hi Al,
> >
> > Do you see anything bad with allowing ->atomic_open() to take a positive dentry
> > and possibly invalidate it after it does the atomic LOOKUP/CREATE+OPEN?
> >
> > It looks wrong not to allow optimizing away the roundtrip associated with
> > revalidation when we do allow optimizing away the roundtrip for the initial
> > lookup in the same situation.
>
> Details, please - what will your ->atomic_open() do in that case?

It will do an open-by-name or create-and-open depending on the flags.
It will return whether the file was created or not.

If created, then the old positive is obviously stale, so it will be
invalidated and a new one allocated.

If not created, then check whether it's the same inode (same as in
->d_revalidate()) and if not, invalidate & allocate new dentry.

Thanks,
Miklos
