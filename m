Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB7C719B29
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 13:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjFALvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 07:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjFALvF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:51:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA43A129
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Jun 2023 04:51:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-969f90d71d4so97835766b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Jun 2023 04:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1685620260; x=1688212260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JHH9IVRD4RODTPYwIZs5ad4p+1OI1MrFohdy2mmlmv8=;
        b=IN19eBp+DEeoqg2XE3wKTDWjGbsG4E2KNoB2aEX766YoWgKA5CpYwPPoxpoztZ9Fpl
         WUWG0JRY71wtP+xz5w7u2QTm6kGmsMCfvpwHC+NThMX9S1A8QimqaZCBr3qEarGkexDQ
         eHK9T9MtAr+da9LKKJuHYvVyKwlJVNAhM5Cak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685620260; x=1688212260;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JHH9IVRD4RODTPYwIZs5ad4p+1OI1MrFohdy2mmlmv8=;
        b=GIQbGBRuKBFNt35ZEdlUi5V+wDJbyGdrOxosWWSTDrg+s8z4xMEfePiS5erdlIo7vV
         YxduGhXO3i5d+dcGuvzqQCyNFRhndZYeg9uTvEsIXxI4fDJzsiNX6OLIuTXfhnvn7f3F
         cA6QI3FfjwrKjvCizBmd6yTprDkrsj4zQd6hSn7deS1FSpseBZJC/wiLPzP1wfNZyssW
         xr79C8h0hkpOk68N0BiVzTzBliwp692pGLcT4AoCQNrnOY98houJD1DAz8/lU4o3NLCt
         UzkC475gL/VfaVzxBeXrp/49LhU1QooymfRRiIbp9sJbrSN6WskjWjO/wYtRSuSSf91q
         URhA==
X-Gm-Message-State: AC+VfDxxgVaw1vMgEk6QWWCtKigkm/isQsx6IxEF440HuXVClqqcgwkO
        /XW/Dt5NTncLX2LbI1nA9OQqhCDTvRZcuXRKyw1Wxw==
X-Google-Smtp-Source: ACHHUZ6GzqNSjjLy11eX+Vkvt1lkOi6DgWQU0H8gFw+h4Bq5Ajn3ojurLfNPoI7xR/CrpxFOCqb4csnLnz8httonUjY=
X-Received: by 2002:a17:907:7291:b0:96f:4ee4:10d4 with SMTP id
 dt17-20020a170907729100b0096f4ee410d4mr7779167ejc.43.1685620260403; Thu, 01
 Jun 2023 04:51:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220517100744.26849-1-dharamhans87@gmail.com>
 <CAJfpegsDxsMsyfP4a_5H1q91xFtwcEdu9-WBnzWKwjUSrPNdmw@mail.gmail.com> <ccfd2c96-35c7-8e33-9c5e-a1623d969f39@ddn.com>
In-Reply-To: <ccfd2c96-35c7-8e33-9c5e-a1623d969f39@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 1 Jun 2023 13:50:49 +0200
Message-ID: <CAJfpegswePPhVrDrwjZHbHb91iOkbfObnxFqzJU88U7pH86Row@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] FUSE: Implement atomic lookup + open/create
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Dharmendra Singh <dharamhans87@gmail.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Horst Birthelmer <horst@birthelmer.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 1 Jun 2023 at 13:17, Bernd Schubert <bschubert@ddn.com> wrote:
>
> Hi Miklos,
>
> On 5/19/22 11:39, Miklos Szeredi wrote:
> > On Tue, 17 May 2022 at 12:08, Dharmendra Singh <dharamhans87@gmail.com> wrote:
> >>
> >> In FUSE, as of now, uncached lookups are expensive over the wire.
> >> E.g additional latencies and stressing (meta data) servers from
> >> thousands of clients. These lookup calls possibly can be avoided
> >> in some cases. Incoming three patches address this issue.
> >>
> >>
> >> Fist patch handles the case where we are creating a file with O_CREAT.
> >> Before we go for file creation, we do a lookup on the file which is most
> >> likely non-existent. After this lookup is done, we again go into libfuse
> >> to create file. Such lookups where file is most likely non-existent, can
> >> be avoided.
> >
> > I'd really like to see a bit wider picture...
> >
> > We have several cases, first of all let's look at plain O_CREAT
> > without O_EXCL (assume that there were no changes since the last
> > lookup for simplicity):
> >
> > [not cached, negative]
> >     ->atomic_open()
> >        LOOKUP
> >        CREATE
> >
>
> [...]
>
> > [not cached]
> >     ->atomic_open()
> >         OPEN_ATOMIC
>
> new patch version is eventually going through xfstests (and it finds
> some issues), but I have a question about wording here. Why
> "OPEN_ATOMIC" and not "ATOMIC_OPEN". Based on your comment  @Dharmendra
> renamed all functions and this fuse op "open atomic" instead of "atomic
> open" - for my non native English this sounds rather weird. At best it
> should be "open atomically"?

FUSE_OPEN_ATOMIC is a specialization of FUSE_OPEN.  Does that explain
my thinking?

Thanks,
Miklos
