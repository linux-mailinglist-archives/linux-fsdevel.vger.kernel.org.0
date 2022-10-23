Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691DF609710
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 00:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJWWif (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Oct 2022 18:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJWWie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Oct 2022 18:38:34 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EB55720C
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 15:38:33 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id s3so4778916qtn.12
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 15:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/UZTxhTvsbmMSOgEXTH+zor/VLnuGIVlDQauO0NokYw=;
        b=LaiaDOv7LosGQH8OAA/CL1Kep0uh24JOI4avmJJz/WFxiE13j8DCwkLK2zTx8EHmUd
         4aAjNWmftEw55A1hvqz6OedrOo3y8KfnuZS7DdJ/GJ4GlPYe5vpei5/jEcSLRjIXtfe8
         dZvMtCbGCS9QFrIeS/y2poVrLgiIgghmqw+OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UZTxhTvsbmMSOgEXTH+zor/VLnuGIVlDQauO0NokYw=;
        b=0d0GpCUi3MMF2plOVwfzZYSyBkBgu/PD9HwXVr7KSdCwsal7ooLuEzgGQd55aOZU7a
         /fz9Irtb5H2R1wQZ6zFDg9W6jLyA3qToZXojYb5t5cO/w9VarLei1Z+1GgfjCQsh5w77
         YUg1S+h31BdvqcfM2rt+nLsb8Wfg3COyCMvHVwz6koj45OCfcVRSAtmw70BrxUgv0GGD
         gvzZvGk48zPy3+B3OrJB7yqx9XKVwyCUdEN4bddo0/FVaNsqEJ7lHTyPjJKMZtBLJncD
         6Af/bnLoJBbIgomsCekI4l+nW4GEgk1vgdp0n+SMHPKVLG7vnImAymI81dlxh8Kz5aPv
         iKgg==
X-Gm-Message-State: ACrzQf2OztfBgZxWeY60aulBDBuzpVaY4VJEZgvSN1Ss2sAd0+9GGdtO
        b2kQYIOdt4/uUIzYg7IOZfNFGNzW4Kxs6g==
X-Google-Smtp-Source: AMsMyM7r7UXCedPcJlNcAdhA5NNSElfdD5s0XXoG9K2KNsRhtsilbAcJR5MaWEp6fPtaPJ9oAQoNRw==
X-Received: by 2002:a05:622a:2cf:b0:39c:e120:4acc with SMTP id a15-20020a05622a02cf00b0039ce1204accmr25401899qtx.152.1666564712561;
        Sun, 23 Oct 2022 15:38:32 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id f7-20020a05620a280700b006dfa0891397sm14141137qkp.32.2022.10.23.15.38.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 15:38:30 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-36cbcda2157so14476587b3.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Oct 2022 15:38:30 -0700 (PDT)
X-Received: by 2002:a81:d34c:0:b0:349:1e37:ce4e with SMTP id
 d12-20020a81d34c000000b003491e37ce4emr26546851ywl.112.1666564710035; Sun, 23
 Oct 2022 15:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <YjDj3lvlNJK/IPiU@bfoster> <YjJPu/3tYnuKK888@casper.infradead.org>
 <YjM88OwoccZOKp86@bfoster> <YjSTq4roN/LJ7Xsy@bfoster> <YjSbHp6B9a1G3tuQ@casper.infradead.org>
 <CAHk-=wh6V6TZjjnqBvktbaho_wqfjZYQ9zcKJTV8EP2Kygn0uQ@mail.gmail.com> <6350a5f07bae2_6be12944c@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <6350a5f07bae2_6be12944c@dwillia2-xfh.jf.intel.com.notmuch>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 23 Oct 2022 15:38:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizsHtGa=7dESxXd6VNU2mdHqhvCv88FB3xcWb3o3iJMw@mail.gmail.com>
Message-ID: <CAHk-=wizsHtGa=7dESxXd6VNU2mdHqhvCv88FB3xcWb3o3iJMw@mail.gmail.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 19, 2022 at 6:35 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> A report from a tester with this call trace:
>
>  watchdog: BUG: soft lockup - CPU#127 stuck for 134s! [ksoftirqd/127:782]
>  RIP: 0010:_raw_spin_unlock_irqrestore+0x19/0x40 [..]

Whee.

> ...lead me to this thread. This was after I had them force all softirqs
> to run in ksoftirqd context, and run with rq_affinity == 2 to force
> I/O completion work to throttle new submissions.
>
> Willy, are these headed upstream:
>
> https://lore.kernel.org/all/YjSbHp6B9a1G3tuQ@casper.infradead.org
>
> ...or I am missing an alternate solution posted elsewhere?

Can your reporter test that patch? I think it should still apply
pretty much as-is.. And if we actually had somebody who had a
test-case that was literally fixed by getting rid of the old bookmark
code, that would make applying that patch a no-brainer.

The problem is that the original load that caused us to do that thing
in the first place isn't repeatable because it was special production
code - so removing that bookmark code because we _think_ it now hurts
more than it helps is kind of a big hurdle.

But if we had some hard confirmation from somebody that "yes, the
bookmark code is now hurting", that would make it a lot more palatable
to just remove the code that we just _think_ that probably isn't
needed any more..

                  Linus
