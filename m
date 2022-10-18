Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB30602687
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 10:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiJRINH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 04:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJRING (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:13:06 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4626760525
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 01:13:05 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a67so19284975edf.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 01:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XUCzpBnsF4bBzltQ79hhS9m1HldTl1/BRG4+rqtqWPU=;
        b=EzyPeZgHbp9ANOEOT1ui3f8cvEmUl/Y7y00IZz4UjAJMubxeazzBqhgy1+ojGHxws5
         qLJ2EToue5eRI1bm4jTu3ORpn7UZtxt0WRSts6Q/cyD/gUp9j0rvnkBmr2jpQf7lx1MY
         4Nyx1FyZv34tibfS4I/MwN9u21IOM48H+J6Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUCzpBnsF4bBzltQ79hhS9m1HldTl1/BRG4+rqtqWPU=;
        b=ca4xd5tcLnMh58U1tRtDZPIk3Nftg3ZLHEXoANq8w7oASmzMhCO/y6vfHVdi4UVUep
         fPrO0IRKByjVo5zG2XZxR71nhfi/FlQViMh1ehOwFbJRwPAOkLAzl+72MtTaUm3/+ylD
         c5SQ/JF3YeLpXZkt4o+2skg3QK7829fljKaZZftvYk2nF+6kZYPSEd0UVuEDnT3xL39t
         FrnIXVis4KbB9pymjnjq+4Mkw3+TZr/NW1iaMXU1W9giYg3wOIboGCQDZEKXLxqIePlb
         ApJTX3qcYUqWvc/671iMoWjzN7p3v6B2dbhaoqLDAbsSJwgWQ4FenI3ZgKp+zjyMqONs
         J/sg==
X-Gm-Message-State: ACrzQf1AZr++tcJS2UxHUcr2lFZxntBnEsPGswNGvP0kmAtj3sbwI35l
        Qs2RDl4YwmaeRcfbN0KuZOuoisF+nFBrNX44LC3QUg==
X-Google-Smtp-Source: AMsMyM7noFZc/Wb1iAmhpcLGqW/nIBM//F+/CeTVAVEbQBIYLm9w7t32U2O+PL3IOcS/Ge8BuAPQVqRQb+QYP4G2TJo=
X-Received: by 2002:a05:6402:11c7:b0:45d:9775:d423 with SMTP id
 j7-20020a05640211c700b0045d9775d423mr1537360edw.257.1666080782578; Tue, 18
 Oct 2022 01:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220922224027.59266-1-ivan@cloudflare.com> <20221017184700.e1e6944e743bfc38e9abd953@linux-foundation.org>
 <CABWYdi1UJsi1iGOAME1tW5eJdqvo3XJidWyO97ksxS85w3ZUPQ@mail.gmail.com>
In-Reply-To: <CABWYdi1UJsi1iGOAME1tW5eJdqvo3XJidWyO97ksxS85w3ZUPQ@mail.gmail.com>
From:   Frank Hofmann <fhofmann@cloudflare.com>
Date:   Tue, 18 Oct 2022 09:12:51 +0100
Message-ID: <CABEBQineydLjdHcc84+JuQnvEbGqkiXuVRXvcmk58bO=9X901Q@mail.gmail.com>
Subject: Re: [PATCH v2] proc: report open files as size in stat() for /proc/pid/fd
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 6:02 AM Ivan Babrou <ivan@cloudflare.com> wrote:
>
> On Mon, Oct 17, 2022 at 6:47 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > > +
> > > +             fdt = files_fdtable(p->files);
> > > +             size = fdt->max_fds;
> > > +
> > > +             for (i = size / BITS_PER_LONG; i > 0;)
> > > +                     open_fds += hweight64(fdt->open_fds[--i]);
> >
> > Could BITMAP_WEIGHT() or __bitmap_weight() or bitmap_weight() be used here?
>
> That's a great suggestion. I tested it with bitmap_weight() and it
> looks much cleaner while providing the same result.
>
> I just sent the v3 with this suggestion applied.

+1 from me on using bitmap_weight() - good spotting that.

FrankH.
