Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483F7419E5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 20:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbhI0Sgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbhI0Sgx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:36:53 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB653C061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 11:35:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y26so42111377lfa.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 11:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+jIsaeZxB9iIHx2Xlr4ffwG7DDOBE7KZeGUWD2K48eI=;
        b=DGnGiVsWgNqibsS1Ab5nKqt7YSbGTS5Tcr0kHz7SyALq+hN2DJXB66SHS6HvDYU2RC
         wX6Jz58IJLYRva+k9kqC0ZdmYbOQu/f6gkWyrVI5GZXHj+f/rVDt+ctTpvanz5gi9wji
         /kiqtD3eiPtfH8Ab50k3VlieyRneSVxG+cw9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+jIsaeZxB9iIHx2Xlr4ffwG7DDOBE7KZeGUWD2K48eI=;
        b=fSmPZcqv3GCr66Duo6k/24Zeda95DUY3SdQkhRP2yy7KqXF2G4+isGoV8rxvAQRwTI
         5VgeM4weePeJhD5WWsoBak/BdVQIUj/SqgvNNo6zXBQdwbvVyWdRxOdxyy8uVu5F3LaE
         D9qLWbJGk4ijQBkEXJUgjTd4WXSgN4CQCuC+AsNwNqDRRy55uLwpF2KwFNnVr9VmOcB7
         vu1kgHSB+KCLLTVLDQO/RAd3/detE418f2jN8uMPDnTsMIpN02kUc0rb4hdiUN2nCJwG
         zf+4wAoqCJzz6WScGAPr9Ih4wmO5il6cdtlzqb4Yt7wuBPvPfkjeuLTB/7WpXCqiPBVN
         Rl9Q==
X-Gm-Message-State: AOAM531/zgYk31kPVdLjywZS1USgvv0JFX65EbXSO9sjLsBzimFzYdn8
        YTnTJoVmdyJF+fHSssGhEpsJccYoyeF71iBbIhE=
X-Google-Smtp-Source: ABdhPJxRjyMR9MpDUHiT0KUygLJd/yiEA9I2WfuHsW8FRaKFdYpRlV2PP0NFcIVof/V3nB/wYltLNA==
X-Received: by 2002:a05:6512:360e:: with SMTP id f14mr1231207lfs.646.1632767712895;
        Mon, 27 Sep 2021 11:35:12 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id n19sm2078413ljc.11.2021.09.27.11.35.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Sep 2021 11:35:11 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id e15so81656872lfr.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Sep 2021 11:35:11 -0700 (PDT)
X-Received: by 2002:a2e:bc1e:: with SMTP id b30mr1347010ljf.191.1632767710543;
 Mon, 27 Sep 2021 11:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <YUvWm6G16+ib+Wnb@moria.home.lan> <bc22b4d0-ba63-4559-88d9-a510da233cad@suse.cz>
 <YVIFNf/xZwlrWstK@moria.home.lan>
In-Reply-To: <YVIFNf/xZwlrWstK@moria.home.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Sep 2021 11:34:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjaL3xcv6LL=1+WdaicaDngvNOTCYU5c9UF_MTsibWBSw@mail.gmail.com>
Message-ID: <CAHk-=wjaL3xcv6LL=1+WdaicaDngvNOTCYU5c9UF_MTsibWBSw@mail.gmail.com>
Subject: Re: Struct page proposal
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 27, 2021 at 10:54 AM Kent Overstreet
<kent.overstreet@gmail.com> wrote:
>
> That list_head is the problematic one. Why do we need to be able to take a page
> from the middle of a freelist?

At least for the merging with the buddy page case.

          Linus
