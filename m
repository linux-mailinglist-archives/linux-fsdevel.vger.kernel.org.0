Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B43F6554A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Dec 2022 22:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiLWVFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Dec 2022 16:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLWVFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Dec 2022 16:05:20 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF941EC46;
        Fri, 23 Dec 2022 13:05:18 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id d13so3848089qvj.8;
        Fri, 23 Dec 2022 13:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5cP42GPh1Zd1V9Znr6XVS1D8/g9HXjBYYIctavT/gQE=;
        b=ntfPXLEQ98DTmZCxfWRqVZKh1b8I9EdCWJTQ6iv6u3NDz5lDturwpU0hJ2L4OI+7UQ
         xbcKnZjz80c7t+BKvMQJympJhGFHpdLAst4ORx6ccO5+3KufdbW1bdwaNp6gyGm/1+2M
         NjgmY3KKFXoDZVixtAJU5xDLQFYFokaD2SsrQzt2fH1l4yqjtPDrn3rM8jFZ1Uv12pDh
         sNtG2jtogyLwu2jKt6Umq+SWwOM6MbItmN3rj/t7byd+4KBTRl4l0WnR9Td/ZB8yDc11
         8YuVAZYoLADJs0zXNuY5inhaaMXm7PLaqyHLPRIV18COSPW98eyu/w9gAaXM3LnpriTS
         4+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cP42GPh1Zd1V9Znr6XVS1D8/g9HXjBYYIctavT/gQE=;
        b=p7t4XoZf6AzWJej3hgGBHmIIK+TndVR6Ppao6nNwvF4dq0X3qN7RUMde37++bQpJvm
         S+WveBbViWs5UsCC9gEhKQAEgq6zIuc67U6TB0cWzXikIOBAJ/+LtvcTBIhQZMurFE9v
         pd1WTOiv0D6ePrubn18PeMVD5QlnCIo98kKCqnFnmsA7bJN2LonZvh+IZ9x7h86Jxw1M
         CMCEHeFG410TxoEC9MgzsaKU/bQXcgde4lTd+9kmGrHXuSpCFaSq/WYd/4fHh+ZyrWnh
         XoXQKZJbhQDdNfnc8wlMLiSeDmNZuW7RaDp4aaJFA6bzt3sHwMHTghZnQQlaSk1ffd6P
         0sig==
X-Gm-Message-State: AFqh2kr2JHzo62NVxJPTpdU5XsDVgGRlH4E/Pz47hjtnINgEmAJbXB9f
        UCY1i6/PR+hbASXydG6gCsxFVj7OrLVWiZZX6LEGD2N8/0HyyQ==
X-Google-Smtp-Source: AMrXdXuEfLjy3xae/nHYRmmwDCDruWBczLKaHB7Vrtu6MmdFuY4+mXm1BqlI7fQcBsYsgp2lNHDLUzqnEROi9BOP1iM=
X-Received: by 2002:a0c:c3c9:0:b0:530:970b:b95e with SMTP id
 p9-20020a0cc3c9000000b00530970bb95emr31681qvi.2.1671829517992; Fri, 23 Dec
 2022 13:05:17 -0800 (PST)
MIME-Version: 1.0
References: <20221216150626.670312-1-agruenba@redhat.com> <20221216150626.670312-5-agruenba@redhat.com>
 <Y6XDhb2IkNOdaT/t@infradead.org>
In-Reply-To: <Y6XDhb2IkNOdaT/t@infradead.org>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 23 Dec 2022 22:05:05 +0100
Message-ID: <CAHpGcMLzTrn3ZUB4S8gjpz+aGj+R1hAu38m-PL5rVj-W-0G2ZA@mail.gmail.com>
Subject: Re: [RFC v3 4/7] iomap: Add iomap_folio_prepare helper
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cluster-devel@redhat.com
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

Am Fr., 23. Dez. 2022 um 16:22 Uhr schrieb Christoph Hellwig
<hch@infradead.org>:
> > +struct folio *iomap_folio_prepare(struct iomap_iter *iter, loff_t pos)
> > +{
> > +     unsigned fgp = FGP_LOCK | FGP_WRITE | FGP_CREAT | FGP_STABLE | FGP_NOFS;
> > +
> > +     if (iter->flags & IOMAP_NOWAIT)
> > +             fgp |= FGP_NOWAIT;
> > +
> > +     return __filemap_get_folio(iter->inode->i_mapping, pos >> PAGE_SHIFT,
> > +                     fgp, mapping_gfp_mask(iter->inode->i_mapping));
> > +}
> > +EXPORT_SYMBOL(iomap_folio_prepare);
>
> I'd name this __iomap_get_folio to match __filemap_get_folio.

I was looking at it from the filesystem point of view: this helper is
meant to be used in ->folio_prepare() handlers, so
iomap_folio_prepare() seemed to be a better name than
__iomap_get_folio().

> And all iomap exports are EXPORT_SYMBOL_GPL.

Sure.

Thanks,
Andreas
