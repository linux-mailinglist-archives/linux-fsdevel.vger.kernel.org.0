Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2425921F1BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 14:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgGNMpJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 08:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727886AbgGNMpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:45:07 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05439C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 05:45:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so21590274ejq.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 05:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1I0HAegT4r/446CzgZG+DkAzDcM+MzQfjx73vwQdRM=;
        b=CQJLmeA+xaZZtJF5b0Wo0lD5+aCoZG1R80srNwsCUjS76gLGuxfUW4TWyhqjgQ7ver
         SPR896yyEgiAOZBSYYcMMtrRuMKty152p9lVN1GuCkKIwX1fLqDjELomw5gPGQcHjxJL
         /QQLP2+0F4wJo1q8ejn97Hzff4QxDGsVczbuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1I0HAegT4r/446CzgZG+DkAzDcM+MzQfjx73vwQdRM=;
        b=EkqXwyr8HTbelUOzVZEP0WW1n4nyocdowh2bHfJCpxf5S9xT1ynKzChGP66Y8iGHkF
         DunhFEHsvNX8J88zlfRDTtJviJHOc6Wqq6LmctEbRmUaT+1PAf9aEee65oQCrJ780Zej
         ByAgnwQ56zburS09uhEJcFvXkk5uUKLqKM6DSUdQ6lDZaOALW0YVKGPLZ3XvPvfEO5Kc
         9CW1Z7U6jAuaXD3CvXDKHbUQlpRksESS7nt1xyvcbxnM8/74maAjEg2lZawEs67ENcBF
         RtkKsmeabNy6fcvA7itmBYbgshVX+m4HGP7lU9eToidLiTr1z8/iX2vZ1qbmOeIDuEI0
         c8Lg==
X-Gm-Message-State: AOAM532PNQYOb/n4r1VOELLo6rroMgg+XpvzyfPDEamZgtnZcZrtxLms
        bWdEW1rgMSQVkgviJSaRKEzFTETwvVU0/a6s25XEwg==
X-Google-Smtp-Source: ABdhPJzgPCDFfwq8iNZU/sqh44HMtCTq9RHyO/4YCVra0P+Tw+3f+dR5jwQ//Ejs/ZWSUL9JourMwf9sQGQL8is3i7U=
X-Received: by 2002:a17:906:1c05:: with SMTP id k5mr4174938ejg.320.1594730705729;
 Tue, 14 Jul 2020 05:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com> <be5341bf-6631-d039-7377-2c0c77fd8be3@virtuozzo.com>
In-Reply-To: <be5341bf-6631-d039-7377-2c0c77fd8be3@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 14 Jul 2020 14:44:54 +0200
Message-ID: <CAJfpegtHkZPky_rvBhtgpWrSZdzhWNw0YLiH4C_GHm9TdChs=w@mail.gmail.com>
Subject: Re: [PATCH] fuse_writepages ignores errors from fuse_writepages_fill
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 25, 2020 at 11:39 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> fuse_writepages() ignores some errors taken from fuse_writepages_fill()
> I believe it is a bug: if .writepages is called with WB_SYNC_ALL
> it should either guarantee that all data was successfully saved
> or return error.
>
> Fixes: 26d614df1da9 ("fuse: Implement writepages callback")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Applied.  Thanks.

Miklos
