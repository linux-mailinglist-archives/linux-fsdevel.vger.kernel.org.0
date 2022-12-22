Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45156546CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Dec 2022 20:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiLVTpR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Dec 2022 14:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235667AbiLVTpO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:45:14 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39A118397
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 11:45:12 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id z23so622219uae.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Dec 2022 11:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g2pmAFCGG/GkprLUyNP1SWGbkG4SkcqSGKIUA+ilYYY=;
        b=lJQbq1cjQrhpT5gOQ48YcaZ99RlKBG8zn4rLrJViTnXXV0/N6DlHZaK/DnfSRGpvY6
         tbLfdqHJJElRh/9IegWQIZORipwpZYgdw53aYe5UgjrJwj9KBVnpyE1AEPZ2b7MHBhfB
         y84ZdO5dguqeoWcRy3bX07BSQWgoh36brbeTvDIFLjB3KnSx8LGOQGaaorhoZ75LAvrd
         dqWnQ4RAr+YV+7bkff2V1Z4zY9pN5gbu0c2O9raCZxubnCMcW2eSMuvXk3qkplHjXPX4
         jZjlhLjjnMBTWwpgkoTTYTX248jyEJ/+h/5MGi3vwMHZO3uJJVgxC3pGEdTc128vTLQA
         XxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g2pmAFCGG/GkprLUyNP1SWGbkG4SkcqSGKIUA+ilYYY=;
        b=QUoyd/HZYM1CSi9UWvOy/o7i/CmgA1cWJ6IVBe1J/Pl9OZ+Vl7K9JILjpEbJ7CYut2
         FxqG4zp6qXBZ2I+hnU6zLznEbYNQfHuY4WPoAteCPN/EGY850D13bZMSUCDYLJ1k5oUe
         XL9kS4uc7MWvchPokg2N0kh5jI+/qCfYMkB7VA/mFvTQcBNr11bL9nKcRNZFvGj2wfzz
         Zbx++mGWJpzLc+h4UZq9CCZ23+DmFYLkxb3K3wxF6p6mUCwAEqmobRPhnxzPrL49cMu7
         vuUjaJRait0bwW3TzgL7RduPbtPJbf7V6pn8x1xh2K/4vkjTdUxXcV7V1hGM8yCAocaZ
         EQ+g==
X-Gm-Message-State: AFqh2krmrZEX3KBc2jcxGe040ZW6MBbDgOvc1Y6VFN+cFxOYyNViixdF
        NqxdLt4ZNAUR919jw9DiMGgCy9fCIsrFFWFjNFc7wwIxvauTnFcu
X-Google-Smtp-Source: AMrXdXtY1Ct6Q0uN9UxGKowZcibIYrmSO2B+kzXShATRsXat7vZOWdyPlemKxIFu4aVKAno0xiCo82UWNO4TrTf5duI=
X-Received: by 2002:ab0:21c1:0:b0:3c7:9fbd:a455 with SMTP id
 u1-20020ab021c1000000b003c79fbda455mr713425uan.113.1671738311648; Thu, 22 Dec
 2022 11:45:11 -0800 (PST)
MIME-Version: 1.0
References: <20221222061341.381903-1-yuanchu@google.com> <20221222104937.795d2a134ac59c8244d9912c@linux-foundation.org>
In-Reply-To: <20221222104937.795d2a134ac59c8244d9912c@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 22 Dec 2022 12:44:35 -0700
Message-ID: <CAOUHufZpbfTCeqteEZt5k-kFZh3-++Gm0Wnc0-O=RFT-K9kzkw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: add vma_has_locality()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yuanchu Xie <yuanchu@google.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Steven Barrett <steven@liquorix.net>,
        Brian Geffon <bgeffon@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Suren Baghdasaryan <surenb@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Peter Xu <peterx@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 22, 2022 at 11:49 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 21 Dec 2022 22:13:40 -0800 Yuanchu Xie <yuanchu@google.com> wrote:
>
> > From: Yu Zhao <yuzhao@google.com>

This works; suggested-by probably works even better, since I didn't do
the follow-up work.

> > Currently in vm_flags in vm_area_struct, both VM_SEQ_READ and
> > VM_RAND_READ indicate a lack of locality in accesses to the vma. Some
> > places that check for locality are missing one of them. We add
> > vma_has_locality to replace the existing locality checks for clarity.
>
> I'm all confused.  Surely VM_SEQ_READ implies locality and VM_RAND_READ
> indicates no-locality?

Spatially, yes. But we focus more on the temporal criteria here, i.e.,
the reuse of an area within a relatively small duration. Both the
active/inactive LRU and MGLRU rely on this.

VM_SEQ_READ, while being a special case of spatial locality, fails the
temporal criteria. VM_RAND_READ fails both criterias, obviously.

Once an area passes the temporal criteria, MGLRU additionally exploits
spatial locality by lru_gen_look_around(), which is also touched in
this patch. This part is good to know but not really relevant here.
