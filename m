Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D3A600658
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 07:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJQFer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 01:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiJQFeo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:34:44 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FE12317C;
        Sun, 16 Oct 2022 22:34:43 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bu25so15883957lfb.3;
        Sun, 16 Oct 2022 22:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FbGjBODuQ2aXd0SxGNOvscm2oLYVXviHbbZBm/YkLLI=;
        b=WmlvmBDXm0Zg0nD0h/VDt7tmRL2ZZOsHNGNIlOFNuMXPEktuQyJaKBT+JrFnE9jZVc
         UkdCK3V/YQzAazPVDvs5CAdWbLq+4SfjipHveGsms9K6YK849CLDfEhz7tBRC6i7zK/Q
         m1v/5IIv7rdDoMXbcOqVKSXg+QCPIZbZAbL1GX8NFiYk30DiWqS/Z+U/XGBeTt9adgye
         MJ2Op4VqgbhyRCvVBcQ/tfgeeBB3p1Z7X3lawXI2yOxNnApPbUSjbFnI4PILBrPy6H3/
         K5k7d50pri3imhOk55WvjUQzhXFHXOTvULrERTOrv02/Qb/XvJaIoVKy86HZQeSdRIQb
         Yumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbGjBODuQ2aXd0SxGNOvscm2oLYVXviHbbZBm/YkLLI=;
        b=z22xgjpARX1O0SmVTuavB2q4WI/oRuBN8BAuzh0HinA/wySxUihQKx5htToCX7iVx7
         2CfPvRxkkydWtovdRbrIKsy3pjinbw1qZnj8mVtmPTNQMpWGi9xN1ypcLvYiGCDG1n/e
         s7nIWKRvSAp4jWF7wDekYfXfGcXKbuDCgwSnMbw1XwKWHDLa3AHNSa4ZOocY7+jNcZLr
         r1g9ahcxj4Ffrfir0FXiLc183/6pFPl+KBPttyRfEm7fszwuue9IlhpIyL/yidKiWniP
         XSVYON42AtqgECNlabckVveXaM0lWqKwCIGQBF+iOB99YSuHZTPrKlfsfZ3eitOtLqO/
         +sTg==
X-Gm-Message-State: ACrzQf0IzgRx9d/49ovDDieaEqTlYahnF+/+cJ7zBdE5DdioYeA7FP1c
        mU6hRPwSeUgdNZW0E/Le162E2J1bFg/SpnwTIfd17r2ohsU=
X-Google-Smtp-Source: AMsMyM5g7nhgl+u9DmZEBWIvXoHJssCFJkbsMC88BnPI1GPO4J70FVEDMb6R5M8MpukkxBkTs10c9ojlKokmOGe2Lxo=
X-Received: by 2002:a05:6512:224d:b0:4a2:7710:9b8b with SMTP id
 i13-20020a056512224d00b004a277109b8bmr3109060lfu.128.1665984881754; Sun, 16
 Oct 2022 22:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <1665725448-31439-1-git-send-email-zhaoyang.huang@unisoc.com> <Y0lSChlclGPkwTeA@casper.infradead.org>
In-Reply-To: <Y0lSChlclGPkwTeA@casper.infradead.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 17 Oct 2022 13:34:13 +0800
Message-ID: <CAGWkznG=_A-3A8JCJEoWXVcx+LUNH=gvXjLpZZs0cRX4dhUJfQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: move xa forward when run across zombie page
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com, baocong.liu@unisoc.com,
        linux-fsdevel@vger.kernel.org
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

On Fri, Oct 14, 2022 at 8:12 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Oct 14, 2022 at 01:30:48PM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Bellowing RCU stall is reported where kswapd traps in a live lock when shrink
> > superblock's inode list. The direct reason is zombie page keeps staying on the
> > xarray's slot and make the check and retry loop permanently. The root cause is unknown yet
> > and supposed could be an xa update without synchronize_rcu etc. I would like to
> > suggest skip this page to break the live lock as a workaround.
>
> No, the underlying bug should be fixed.
>
> >       if (!folio || xa_is_value(folio))
> >               return folio;
> >
> > -     if (!folio_try_get_rcu(folio))
> > +     if (!folio_try_get_rcu(folio)) {
> > +             xas_advance(xas, folio->index + folio_nr_pages(folio) - 1);
> >               goto reset;
> > +     }
>
> You can't do this anyway.  To call folio_nr_pages() and to look at
> folio->index, you must have a refcount on the page, and this is the
> path where we failed to get the refcount.
OK, could I move the xas like below?

+     if (!folio_try_get_rcu(folio)) {
+             xas_next_offset(xas);
              goto reset;
+     }
