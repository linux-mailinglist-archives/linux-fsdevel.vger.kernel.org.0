Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA261DF47E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 May 2020 06:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbgEWEHq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 May 2020 00:07:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36903 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726065AbgEWEHq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 May 2020 00:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590206865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F1bhCGQtRl8cBs0zYrkz/5FLXJrqBYq5wZlx9jEG8Uc=;
        b=Do/2XryEjbVWZpL7OTuXVJu/mp33opSIiMLK8i/Cxtedy2/YeQzuXj/f6F3zJOzc+B8Lz/
        zdVZekomj90/phLYp7bnaQlXrsXH9TL1gQJ91I/L04X1F0VxLOkFusT60fjlInKeH5K7J1
        JztILyaVLdzNmKc2ij9IkZYkwYWaL7o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-4m5kSomCMTavDXH7L-4JDQ-1; Sat, 23 May 2020 00:07:40 -0400
X-MC-Unique: 4m5kSomCMTavDXH7L-4JDQ-1
Received: by mail-qk1-f199.google.com with SMTP id n187so694552qkd.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2020 21:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1bhCGQtRl8cBs0zYrkz/5FLXJrqBYq5wZlx9jEG8Uc=;
        b=Urflm91NySlG0JHxyUG6idXA7YQhQGQHj4bzSvohSXS9EMT44EsL+jBTwB8V7hE1M1
         N4h7o44dzh7bNRz3QI4iwtanh/D3CvX9S58aAgoAiMgL6D848GzNRhCogCGfWptbxiKk
         Ergicr5b4BUS0MZ8L3Xkjau2iNfcJZsAcXPSwq+oAxm1TiWl3MkoRYK7QxvabojkFodt
         DaQ+YpGoJH/2DxfC9JknKLO71R5DACpP7JduOw1vZuK7LfazBQ58iRGqpCPr5rWWZ9qs
         bHAMLpVdjVQe/75In7uiar2sx69DdVhvm5j8gCQino11WANQbIpF4y1Grm3MWu1BOgSa
         4NXQ==
X-Gm-Message-State: AOAM5304k4zLdRRK7ttJQWlj2egjjbwI6RMwGgkRYN+dhgmE8/3u6zlA
        ek4ssjUwmurjFZDrzOzJBFSBUNFzsUmYlBB5QPRynsunqoyni8lll6x5hFcObi20ihwkCpCqzjh
        7Y+xMsClv+antmpnfK/DYK5ZL+k+LGboFfJTwFKs1vw==
X-Received: by 2002:a37:270a:: with SMTP id n10mr17623767qkn.288.1590206860004;
        Fri, 22 May 2020 21:07:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqucE/BLDWAWbsUb5BS4pFv+/cIpYb0lPmqP/rcpvyVgWQsH8wbXFsAUfUqER06Q9HPajqCxqlT56dHPAxYvs=
X-Received: by 2002:a37:270a:: with SMTP id n10mr17623751qkn.288.1590206859751;
 Fri, 22 May 2020 21:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200522085723.29007-1-mszeredi@redhat.com> <20200522160815.GT23230@ZenIV.linux.org.uk>
 <CAOssrKcpQwYh39JpcNmV3JiuH2aPDJxgT5MADQ9cZMboPa9QaQ@mail.gmail.com>
 <CAOQ4uxi80CFLgeTYbnHvD7GbY_01z0uywP1jF8gZe76_EZYiug@mail.gmail.com>
 <CAOssrKfXgpRykVN94EiEy8xT4j+HCedN96i31j9iHomtavFaLA@mail.gmail.com> <20200522195626.GV23230@ZenIV.linux.org.uk>
In-Reply-To: <20200522195626.GV23230@ZenIV.linux.org.uk>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Sat, 23 May 2020 06:07:28 +0200
Message-ID: <CAOssrKcpWj=ACbNfy0iBjGDRogouDZAv-LT3P91XaXY3HD=jBA@mail.gmail.com>
Subject: Re: [PATCH] ovl: make private mounts longterm
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 22, 2020 at 9:56 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, May 22, 2020 at 08:53:49PM +0200, Miklos Szeredi wrote:

> > Right, we should just get rid of ofs->upper_mnt and ofs->upperdir_trap
> > and use ofs->layers[0] to store those.
>
> For that you'd need to allocate ->layers before you get to ovl_get_upper(),
> though.  I'm not saying it's a bad idea - doing plain memory allocations
> before anything else tends to make failure exits cleaner; it's just that
> it'll take some massage.  Basically, do ovl_split_lowerdirs() early,
> then allocate everything you need, then do lookups, etc., filling that
> stuff.

That was exactly the plan I set out.

> Regarding this series - the points regarding the name choice and the
> need to document the calling conventions change still remain.

Agreed.

Thanks,
Miklos

