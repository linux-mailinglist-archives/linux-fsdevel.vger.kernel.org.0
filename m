Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2956960BC54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 23:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJXViq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 17:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiJXVi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 17:38:29 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EB91C8419
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 12:46:18 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g11so6272678qts.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 12:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JBAZHyd5XgygP1+md+qYdTHi+gwkM0InAuquo+/p7pw=;
        b=WBTb2zVyYxNOefcbYu3yHqG/UB1C+xJGDwXHwakVh38aS5ZuDINwt8jsxNEAQqvkEi
         XrcSmdHK+SpPVQiz7c1X4aBcmHBv21rx1vohljqxcxvdc1TQj/sdvazdSXaHo0IYXHLv
         2TH61pa0fSCvroXIW67FQ2PDONkPgzt3hTCwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBAZHyd5XgygP1+md+qYdTHi+gwkM0InAuquo+/p7pw=;
        b=rczQugpqHqQ0zWT/hIYBfw9foAZgKwNaoyrgoXXjb/gi98MKGVGgssLdLStXDsuv1M
         BzZj/qK2mry9E6EFpHX0PXXlLLkSFwBlfKdxeu0WTvxquBaeX4BeEnp+NWd038I+f+71
         VmbhAb28/n9fEskUn1sBmduVl2q+JF4RVpcP6cUu7UkdLsKjBev2pEU2TqcoAdCMOubf
         4rcE1jAAAWGZPINOHGoAYB4zZ4p904uZWMcBpl/h7T9mW1SUSt0JYedp8tbzrm+PNeQM
         BbOLWCSGW7crnN1I6yne/ajhHDTN+u9eYnjt3sbnrplvSd/GelIrWsmBNFA+uKphZQnQ
         NUWg==
X-Gm-Message-State: ACrzQf04jbJ7qEacP62uiz2K62UW7xdb38mJH1dCmwenI0XBUgwZuVD9
        7Mqlrb9WMX5KUxiVbkY2QvMZ+5A0JB7tjA==
X-Google-Smtp-Source: AMsMyM6rvKUZl0qcnQuZtcgPH3gH88mYwJpIReSv7G1+nRelVNMsVUfLddh5Lad2Zbx1mqpR0/GmlQ==
X-Received: by 2002:a05:622a:18a:b0:39a:ffaf:6c9d with SMTP id s10-20020a05622a018a00b0039affaf6c9dmr27916564qtw.253.1666640618061;
        Mon, 24 Oct 2022 12:43:38 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id y14-20020a05620a44ce00b006ce76811a07sm558375qkp.75.2022.10.24.12.43.36
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 12:43:36 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-35befab86a4so94726317b3.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Oct 2022 12:43:36 -0700 (PDT)
X-Received: by 2002:a81:2544:0:b0:360:c270:15a1 with SMTP id
 l65-20020a812544000000b00360c27015a1mr29252227ywl.67.1666640616299; Mon, 24
 Oct 2022 12:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <YjDj3lvlNJK/IPiU@bfoster> <YjJPu/3tYnuKK888@casper.infradead.org>
 <YjM88OwoccZOKp86@bfoster> <YjSTq4roN/LJ7Xsy@bfoster> <YjSbHp6B9a1G3tuQ@casper.infradead.org>
 <CAHk-=wh6V6TZjjnqBvktbaho_wqfjZYQ9zcKJTV8EP2Kygn0uQ@mail.gmail.com>
 <6350a5f07bae2_6be12944c@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHk-=wizsHtGa=7dESxXd6VNU2mdHqhvCv88FB3xcWb3o3iJMw@mail.gmail.com> <feb89e52675ed630e52dc8aacfa66feb6f19fd3a.camel@linux.intel.com>
In-Reply-To: <feb89e52675ed630e52dc8aacfa66feb6f19fd3a.camel@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 12:43:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7y5AJKGWExD3TmNj=kOhaJN2Or1p5VXC=P0-YPv97NQ@mail.gmail.com>
Message-ID: <CAHk-=wj7y5AJKGWExD3TmNj=kOhaJN2Or1p5VXC=P0-YPv97NQ@mail.gmail.com>
Subject: Re: writeback completion soft lockup BUG in folio_wake_bit()
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
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

On Mon, Oct 24, 2022 at 12:39 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> I do think that the original locked page on migration problem was fixed
> by commit 9a1ea439b16b. Unfortunately the customer did not respond to
> us when we asked them to test their workload when that patch went
> into the mainline.

Oh well.

> I don't have objection to Matthew's fix to remove the bookmark code,
> now that it is causing problems with this scenario that I didn't
> anticipate in my original code.

I'd really like to avoid *another* "we can't actually verify that this
helps" change in this area, so I'm hoping that the reporter that Dan
was talking to could test that patch.

Otherwise we're kind of going back-and-forth based on "this might fix
things", which just feels really fragile and reminds me of the bad old
days when we had the "one step forward, two steps back" dance with
some of the suspend/resume issues.

I realize that this code needs some extreme loads (and likely pretty
special hardware too) to actually become problematic, so testing is
_always_ going to be a bit of a problem, but still...

               Linus
