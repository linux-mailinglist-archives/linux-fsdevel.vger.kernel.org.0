Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE742742D98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 21:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjF2Tby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 15:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjF2TbW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:31:22 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA2935A0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 12:31:02 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so676946a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1688067062; x=1690659062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8F1B3A6YBGocTh6JWRcZA7ZAv57Ow7+qsKGwKLKBL80=;
        b=AZV/nFPwpbp9tmOjiaCNrM/OqIH+VdAARmeEAZelxyzOT+aXl1M0pk/vnDzsDrabxK
         pOj7e0OdkqTpx3Hbmd/8ofqSyiGVXHf5ST8sjlqm6pgSMDBzzv7w1Azmc67ws3xinbyW
         KQbKAHNsC0D6IDfE6e7GH/78Pnbe80p1icg1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688067062; x=1690659062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8F1B3A6YBGocTh6JWRcZA7ZAv57Ow7+qsKGwKLKBL80=;
        b=H6ZnWETxKqFRcmxKej02FjTFFwQBX5NIA/fhLLtw1yZQAU8bssXizUxlRjfcbkx53U
         n9uOltrR6Z6oTqLn5dvze9UxflL6JU8f1Yd1gy+fiLX38mZWRRbyTFVdwH8jMDeFWNMN
         DEGYfHlW5ohwzb5OdLM+gcTbvxyjly3wVTrEb759nl0jaa+ft+hzaLxKGhNMYOZJffOc
         XOA834CpZoaqoaJHnecDx2r6eC4nQ04yZN+ia+mv4KRUv/tgqtMa1Nfk9OCQ15Oi0yES
         3b5Zp0S5o0czXvhI8UWkZqVO3ZdvFTgRL8DoisOql7MSmSoXQn/nFraWL4js7qMoRNJo
         m7tQ==
X-Gm-Message-State: AC+VfDwG/W5/LHJDlNVA12zdmjc4JKhJBbkeEcy5yBN8tv/cZIMQpOmS
        ad4eQMg36M1Q7CEyuU/VsYBQMizi7uLoVok/Xkkz8g==
X-Google-Smtp-Source: ACHHUZ7wguVE94NKRZ84Unidpb5tCu0r9SGdVVvwwN9SHkGpv/NTN6cLthHHsGFtdx2ISZba9lNSBfgvAU9DIGBq15k=
X-Received: by 2002:a05:6a20:734c:b0:117:19d1:8385 with SMTP id
 v12-20020a056a20734c00b0011719d18385mr916301pzc.20.1688067062136; Thu, 29 Jun
 2023 12:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <CA+wXwBRdcjHW2zxDABdFU3c26mc1u+g6iWG7HrXJRL7Po3Qp0w@mail.gmail.com>
 <ZJ2yeJR5TB4AyQIn@casper.infradead.org> <20230629181408.GM11467@frogsfrogsfrogs>
In-Reply-To: <20230629181408.GM11467@frogsfrogsfrogs>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Thu, 29 Jun 2023 20:30:50 +0100
Message-ID: <CALrw=nFwbp06M7LB_Z0eFVPe29uFFUxAhKQ841GSDMtjP-JdXA@mail.gmail.com>
Subject: Re: Backporting of series xfs/iomap: fix data corruption due to stale
 cached iomap
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Daniel Dao <dqminh@cloudflare.com>,
        Dave Chinner <david@fromorbit.com>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-fsdevel@vger.kernel.org,
        Chandan Babu R <chandanrlinux@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Leah Rumancik <lrumancik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 7:14=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> [add the xfs lts maintainers]
>
> On Thu, Jun 29, 2023 at 05:34:00PM +0100, Matthew Wilcox wrote:
> > On Thu, Jun 29, 2023 at 05:09:41PM +0100, Daniel Dao wrote:
> > > Hi Dave and Derrick,
> > >
> > > We are tracking down some corruptions on xfs for our rocksdb workload=
,
> > > running on kernel 6.1.25. The corruptions were
> > > detected by rocksdb block checksum. The workload seems to share some
> > > similarities
> > > with the multi-threaded write workload described in
> > > https://lore.kernel.org/linux-fsdevel/20221129001632.GX3600936@dread.=
disaster.area/
> > >
> > > Can we backport the patch series to stable since it seemed to fix dat=
a
> > > corruptions ?
> >
> > For clarity, are you asking for permission or advice about doing this
> > yourself, or are you asking somebody else to do the backport for you?
>
> Nobody's officially committed to backporting and testing patches for
> 6.1; are you (Cloudflare) volunteering?

Yes, we have applied them on top of 6.1.36, will be gradually
releasing to our servers and will report back if we see the issues go
away

> --D
