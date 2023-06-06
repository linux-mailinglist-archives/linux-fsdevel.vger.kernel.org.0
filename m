Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054DB723CBB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 11:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbjFFJOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 05:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237396AbjFFJNq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:13:46 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391491733
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 02:13:34 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id ada2fe7eead31-439494cbfedso1415652137.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 02:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686042813; x=1688634813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWTcec7jTp/wYWaNdMk+QKsRIfuHBLjZHjPXCTAnLQA=;
        b=JL8sri7E+Jras2UQlSl2vpZ+pH95Ouo9NN37PXlgYdDA+2zTJU8Zl0r77kFndtH81g
         vhR1qp80Tv+f3Si/T/HCqXVLllzF/h4wlWOeVt23D7P7rhAB5k9zpfP3Yxmig1pu0NPH
         JYg2iObMK4VS9OJp3Q/phFgRsXeIJiJN991InhISvPBed0N8b/+HHNuiaLHRJ0VK8mg0
         oFd+k/U7L3AKY+mnQfJ739LfAXx/CfoqsJmgG0ve4Z68I26Moc4NqpEPXPUr4KDJ9NAT
         ujm0TsgqHIwEalaA+0DLG6pFu79/lKn6Lug8fVhzbFGhd3VAqCqr3x5BpYLXMM7V3E4c
         ijPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686042813; x=1688634813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWTcec7jTp/wYWaNdMk+QKsRIfuHBLjZHjPXCTAnLQA=;
        b=ORo5wm1xlMy8kjTuqOS4f+RQoUlE1lrqmXGqvT0T1uGGin+lFnXxChH65wn55K+t6B
         56AVzmdd/rikHe3Ivw2+eSFtb7uSzpFP4d4blMjAShHGfxKqyk2FluYe78kCFKoomO9u
         pBN3nsrR3kQeVXfFFRiPSIAzwaTMDs1pnShjF1JjyRwsz2PwGysAE69a6KGXckSjKFT2
         gmIk68JyeRIHVNgphqmdWQFT9c1SXG9ufkWLPoGcjyJGdVVp1qJVTLBdUchUVl8GVSUg
         D8EskiaOwpF/OgUIwUooMzwoeU0l+fYFtfm3PtvdXbgmepLagTnGpwanvmE62N6ihY6d
         jIKA==
X-Gm-Message-State: AC+VfDx2X++4gzeZlYi5CDwamSRofxzncFqmCQZIKmpskUOdOBcf6PfU
        4joIPFFCA75QnauW2635GCCCjskRjc3XS1JUBCE=
X-Google-Smtp-Source: ACHHUZ5uEEFiA6sjZOwFTb3tfKPBRD3DQ9m2Q62rntnyI8zLZYmnNT+VfPIc/oN2/gancuAXKveOgrSw4bUaN8AipAw=
X-Received: by 2002:a67:eb4f:0:b0:43b:5250:4f1a with SMTP id
 x15-20020a67eb4f000000b0043b52504f1amr766138vso.28.1686042813294; Tue, 06 Jun
 2023 02:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com>
In-Reply-To: <20230519125705.598234-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 6 Jun 2023 12:13:22 +0300
Message-ID: <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 19, 2023 at 3:57=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Miklos,
>
> This patch set addresses your review feedback on Alesio's V12 patch set
> from 2021 [1] as well as other bugs that I have found since.
> This patch set uses refcounted backing files as we discussed recently [2]=
.
>
> I am posting this for several possible outcomes:
>
> 1. Either FUSE-BPF develpers can use this as a reference implementation
>    for their 1st phase of "backing file passthrough"
> 2. Or they can tell me which API changes need to made to this patch set
>    so the API is flexible enough to extend to "backing inode passthrough"
>    and to "BPF filters" later on
> 3. We find there is little overlap in the APIs and merge this as is
>
> These patches are available on github [3] along with libfuse patches [4].
> I tested them by running xfstests (./check -fuse -g quick.rw) with latest
> libfuse xfstest support.
>
> Without FOPEN_PASSTHROUGH, one test in this group fails (generic/451)
> which tests mixed buffered/aio writes.
> With FOPEN_PASSTHROUGH, this test also passes.
>
> This revision does not set any limitations on the number of backing files
> that can be mapped by the server.  I considered several ways to address
> this and decided to try a different approach.
>
> Patch 10 (with matching libfuse patch) is an RFC patch for an alternative
> API approach. Please see my comments on that patch.
>

Miklos,

I wanted to set expectations w.r.t this patch set and the passthrough
feature development in general.

So far I've seen comments from you up to path 5/10, so I assume you
did not get up to RFC patch 10/10.

The comments about adding max stack depth to protocol and about
refactoring overlayfs common code are easy to do.

However, I feel that there are still open core design questions that need
to be spelled out, before we continue.

Do you find the following acceptable for first implementation, or do you
think that those issues must be addressed before merging anything?

1. No lsof visibility of backing files (if server closes them)
2. Derived backing files resource limit (cannot grow beyond nr of fuse file=
s)
3. No data consistency guaranty between different fd to the same inode
    (i.e. backing is per fd not per inode)

Depending on your answers, I will decide if I have the bandwidth to carry
this patch set to the finish line or wait for the Android team to post a mo=
re
comprehensive patch set that deals with all of the above.

Thanks,
Amir.
