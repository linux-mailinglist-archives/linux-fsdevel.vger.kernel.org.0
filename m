Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BFB41F6A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 23:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhJAVLD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 17:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhJAVLC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 17:11:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E47FC061775;
        Fri,  1 Oct 2021 14:09:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x7so37908782edd.6;
        Fri, 01 Oct 2021 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/uOI/dIlL2jSFVGfxa0CMnXUrM5ghtKo2f0nyTLz6rY=;
        b=KAElGBvoxxCiDV6eDDOztUqfZw1MX32akFN0Gg92zTtY0knkfMYGlkmE8fN62ZoMFW
         pzBbKcXZmSJnrLXcncrGdV2OafSJIbn9LlECnZOy1U61/+vQz0HnK3XLjq3SylsObqjU
         XfkaCPcIf54lKrbKo97VkbzWEKakZobX2YatXdyhh0HNFguKycb/TB4zNQX+SdFtERR6
         U08BGsyXqr6IJdJOrAGRCd5f/fmrzNj2Vbl7fTSaoLD/sz+aIqY7GEphPv3ER8lzLP0I
         qilRPm7Om7ikgF3/UYAjKN/8ijuMBrMVPCJeKUJ/0t8UB9JDHt68jza9ISG7zYCYf1DU
         Y7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/uOI/dIlL2jSFVGfxa0CMnXUrM5ghtKo2f0nyTLz6rY=;
        b=pqwthDlhEm28kXN8bLA+kLYxcClo2Jw5OI0punrpLaosdOfGn7gf32yY7uVE2SQXJd
         S5FJBbUsU7c6zDQZi9EJeKI5PuyUS8x1oFvmwJVCrmv9YdZmGPBTAYEHzJIJKkKFxJrj
         I/5AWh+swGSeGnRBVUwh9sAxJwuNRfjB9kENkLziFInuis4QbLk9gX8kFpoa7h8aQlcx
         IMco0QJB3KvypLnBpxibQgZYmlcOj8jSn341VQhyRygivFUTs6/HOMPgOU0g0Ddn5Dv1
         ftvRn5cR+JCI7X+kNF04tZxahPIwsSL1DlzEiHfDg8gC8DCvRDzHU7DjWxaan98AXzBf
         zZXg==
X-Gm-Message-State: AOAM530r3X6Hdv6rqU9DxoPPhLXTxTll06fnd5Z2B3kHeY9NHNYzXP6J
        9c1EIubv3aSIxlX5oAIb7Bgh5bLK4J5wIj67l2E=
X-Google-Smtp-Source: ABdhPJy8t1ofGyfSnJ8rf+QKBPhgEssufWQSIO/Ht82I+TLAKHQ/Zs22w3FEN9u5jrI2h1DYGqH4/Bv6uDrDbu2BEx8=
X-Received: by 2002:a05:6402:16d2:: with SMTP id r18mr248583edx.363.1633122556737;
 Fri, 01 Oct 2021 14:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210930215311.240774-1-shy828301@gmail.com> <20210930215311.240774-6-shy828301@gmail.com>
 <20211001070611.GB1364952@u2004>
In-Reply-To: <20211001070611.GB1364952@u2004>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 1 Oct 2021 14:09:04 -0700
Message-ID: <CAHbLzkpVuZuiSBCT_2z7rsd1viv6dHCKHaM3nGbMMwJAKp0nVQ@mail.gmail.com>
Subject: Re: [v3 PATCH 5/5] mm: hwpoison: handle non-anonymous THP correctly
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 1, 2021 at 12:06 AM Naoya Horiguchi
<naoya.horiguchi@linux.dev> wrote:
>
> On Thu, Sep 30, 2021 at 02:53:11PM -0700, Yang Shi wrote:
> > Currently hwpoison doesn't handle non-anonymous THP, but since v4.8 THP
> > support for tmpfs and read-only file cache has been added.  They could
> > be offlined by split THP, just like anonymous THP.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

Thank you!
