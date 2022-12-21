Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F9F6534ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 18:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiLURS5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 12:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbiLURSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:18:17 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63A624F27;
        Wed, 21 Dec 2022 09:17:42 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c140so17222733ybf.11;
        Wed, 21 Dec 2022 09:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=obPoXeoGwnXe5CqGdFwqw1lMSLFBWN5B3Ufm/DPfw6U=;
        b=hBa2jQX+YX2How1HUjfStPdAV3ULq0M3X5sJVB0HPxl6WZtflb+yvVtaXKtIe03h11
         +tRUjiQl40NP+Na+qEt+ivcTx3vCoCewMUDQAaodyaKBDxh4if2ET1+dtz0F0pATAs5/
         +L4mco6VjT9x0iMoCnAkAkKUUKBfJPLV9gTwyqtrELDs7Y/weYhOLvFaP1C2bEOKjOtx
         ElNFX9E77xkLUqa81LUSQpLxsk9xGe2PR9HlZHkUYhvnxezZOzV18ENSfyIlqO2YKoah
         t421pTE9AJrZBgwKlx+QP1h0rrSizVfLngo4/ai8yZDwTdjCNkvxsGhYXECd+YjUOm/x
         WSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=obPoXeoGwnXe5CqGdFwqw1lMSLFBWN5B3Ufm/DPfw6U=;
        b=hCu8LJW/B/Nr++zemZkOXuNJrsuicaM5N+pRGSTgzomB0oZDENFF7phwbp5I0GI+Qd
         X7pxPyWtnTjr1FnJEyNkF1kGCTDp6k8mnoe+FiMJRWJJkjhawHDRQiSBEE6A/hiYepqe
         /eM/bJDNp91EKZObf+O9Im5JLOZcCkvRuCijKGsaCLqyOodvjhH5cCL7Zb7k62liV3hz
         PHtrDzmKduuKqWebOBiVywrFNFu6X00Sfebp0LNIT7RJVTllfgp0sP0/ZNTr0drAqRCv
         0G8vEeECpiXVRZ5NX5282VhQ1ihKeviC7raS8fRkSe7OyCEk5SCIwfY8QXf/rd24Lkcu
         dhsw==
X-Gm-Message-State: AFqh2kp8c+1qoy7T1wsjq+mHCq9F6+mtNU9ipK0pWRKDdKEAYWqTFT09
        HHm2PTpua3ghHs86VxPxpBpSHIH0IJl4kTbsUy0=
X-Google-Smtp-Source: AMrXdXtveEC2+hgy7ihrRHqxFTx3SQ7hEr55PWvD3HSbqv1EZNCaA/UJLaeerK30Q6U0Ho5qcXvBgkxSvXY5yoOTtr0=
X-Received: by 2002:a25:dd83:0:b0:758:65d6:915f with SMTP id
 u125-20020a25dd83000000b0075865d6915fmr188536ybg.582.1671643061860; Wed, 21
 Dec 2022 09:17:41 -0800 (PST)
MIME-Version: 1.0
References: <0a95ba7b-9335-ce03-0f47-5d9f4cce988f@kernel.org>
 <20221212191317.9730-1-vishal.moola@gmail.com> <6770f692-490e-34fc-46f8-4f65aa071f58@kernel.org>
 <Y5trNfldXrM4FIyU@casper.infradead.org>
In-Reply-To: <Y5trNfldXrM4FIyU@casper.infradead.org>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Wed, 21 Dec 2022 09:17:30 -0800
Message-ID: <CAOzc2pzoyBg=jgYNNfsmum9tKFOAy65zVsEyDE3vKoiti7FZDA@mail.gmail.com>
Subject: Re: [RFC PATCH] f2fs: Convert f2fs_write_cache_pages() to use filemap_get_folios_tag()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        fengnanchang@gmail.com, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 15, 2022 at 10:45 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Dec 15, 2022 at 09:48:41AM +0800, Chao Yu wrote:
> > On 2022/12/13 3:13, Vishal Moola (Oracle) wrote:
> > > +add_more:
> > > +                   pages[nr_pages] = folio_page(folio,idx);
> > > +                   folio_ref_inc(folio);
> >
> > It looks if CONFIG_LRU_GEN is not set, folio_ref_inc() does nothing. For those
> > folios recorded in pages array, we need to call folio_get() here to add one more
> > reference on each of them?
>
> static inline void folio_get(struct folio *folio)
> {
>         VM_BUG_ON_FOLIO(folio_ref_zero_or_close_to_overflow(folio), folio);
>         folio_ref_inc(folio);
> }
>
> That said, folio_ref_inct() is very much MM-internal and filesystems
> should be using folio_get(), so please make that modification in the
> next revision, Vishal.

Ok, I'll go through and fix all of those in the next version.
