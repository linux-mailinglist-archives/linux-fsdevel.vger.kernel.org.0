Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0CF4D3DDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Mar 2022 01:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbiCJAHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 19:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbiCJAHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:07:16 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A58F9552
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Mar 2022 16:06:17 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id p17so3366118plo.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Mar 2022 16:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQJaIhmi/QzFmALiltJXNjf6ckrS2EgY1Uh0aPn7MYs=;
        b=gHn6uRZhcwc/1/iluj+hvVI/tjLthpe0Akd+MQKuvfdxMcu9PCDly6aCrg472eEh3m
         TjX0NOdopbKbRdKaTnbzERgZdM/mueEx2YG8+M+5257GEhp393PupeQgUlkt7oFEvDNE
         3oK0YaD8xaVKZQHhdXj8we5uTjgvoB98hHYuntfbhhJEs/08fC7MpT6rEISUbYY/ic66
         WSvO3h2xy30LL3YTP0oNjR8eybS0lFiAfsfYGA4HOD3rEng97uK2wZ6VlssMAfKNTXSz
         EKoRjaRuHELjmnQMxekNcgSoQf+ZMttBSndyI4apgf7t9m0BmZJQgb+1OpttRu0tnJ2D
         9JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQJaIhmi/QzFmALiltJXNjf6ckrS2EgY1Uh0aPn7MYs=;
        b=0D/ctEMiZ7w4yGLsYJrzFHo66VDxgrwfDsYLBzGyCYeuU6DzGWFcd7frHa9/7Pr4Ay
         CbrEoD3pP8+eLDimRLHcqjFh8xMoBmr8lcvS9+7EBhqmR3BwiIoHReAGOhiYg0roRI7C
         juvkgyMbj4LEAbaCQJdw4xafesXyvZWYRuoli7AicmHZkLm/kQD2U+I3rsdQSugwJPjB
         3tNrGhNB2b96t2jdfNAad1cymwyBZApWqU0Fqq7jroBVZNXoh/g7us9qeEsJ+FjDplqG
         E38Dv7lWhOe0NPKbuUaK0QRXTnj9ICPj0WB3kiGdAHmUxBsHcW+RVHpdkZJaJ9Beho1H
         fEyQ==
X-Gm-Message-State: AOAM530WtMEYYio/QXeHoqzci8DClPwhxj2Sp3G8TvJcyyzreiD7HTH3
        wkE1zyAGS1UgS8eHUbEVEn3rxcVFjy/C0YD6FSJiTQ==
X-Google-Smtp-Source: ABdhPJwb9kJQ7QI7FmWPhygsP7CpEdP0qVgYwpDcpFWyZG/Qf8Jpi7IliqWagwPdOiBZnW2yD9cno3XpwTf/bXrgthc=
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id
 d22-20020a170902729600b0014b4bc60e81mr2305234pll.132.1646870776595; Wed, 09
 Mar 2022 16:06:16 -0800 (PST)
MIME-Version: 1.0
References: <20220302082718.32268-1-songmuchun@bytedance.com> <20220302082718.32268-3-songmuchun@bytedance.com>
In-Reply-To: <20220302082718.32268-3-songmuchun@bytedance.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Mar 2022 16:06:05 -0800
Message-ID: <CAPcyv4j7rn8OzWKydcCJNXdrhXm6h6Vq5n7uLzP5BSMJ_qSZgg@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] dax: fix cache flush on PMD-mapped pages
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Hugh Dickins <hughd@google.com>, xiyuyang19@fudan.edu.cn,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, duanxiongchun@bytedance.com,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 2, 2022 at 12:29 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The flush_cache_page() only remove a PAGE_SIZE sized range from the cache.
> However, it does not cover the full pages in a THP except a head page.
> Replace it with flush_cache_range() to fix this issue.

This needs to clarify that this is just a documentation issue with the
respect to properly documenting the expected usage of cache flushing
before modifying the pmd. However, in practice this is not a problem
due to the fact that DAX is not available on architectures with
virtually indexed caches per:

d92576f1167c dax: does not work correctly with virtual aliasing caches

Otherwise, you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
