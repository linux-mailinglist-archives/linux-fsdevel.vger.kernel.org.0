Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3BB76A160
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 21:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjGaTk3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 15:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGaTk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:40:28 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52396199D;
        Mon, 31 Jul 2023 12:40:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so7975865e9.2;
        Mon, 31 Jul 2023 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690832426; x=1691437226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sy6unmAOZDl25dmGqDdgjGgEy7Fu7QkLZ+dEPeEHA3w=;
        b=YxP7d8TWxCj/8uRCfpev70zLJ8T6kn2yrBYF+HLOCBjzaOHt4NwNCVBvah7A0UklMg
         mwWGcrgmoahWw2R/NUUpoiob5wzBTIdDS8TKisYfpYbw9YVNLHekCJFmT0VWmqLzo1X+
         qbHGtlsCuBP2BCTt8II0U8tNT2mrvOb0J2TWuowGCQWJWDL8Zxg1RC1OjvhXj24jMRHQ
         BytEqC8bzLxlUYa73oF+xG5FFyM8dWWp15GpUNAa3eC/Y7Erif2T1Qh1+oJX92z5mFL2
         heCTlwjYVwsCvDk1KjCt1CLGBlRI/QM86OWtS1+QWWpNDTbI/DeEJo4pEGDA0Xu31unn
         FnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690832426; x=1691437226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sy6unmAOZDl25dmGqDdgjGgEy7Fu7QkLZ+dEPeEHA3w=;
        b=IzEi+WTT69Xn8cVm6g+od97aLjQrvzR94MEvXrUxUkOX3Y1S9u8eLZcU9hWlTkT7z9
         NpfAlX6rw+B4SnNGizDXHeEe+zCqA8hUbW5ccuULC9wMTJPh68vNU7OUwTQvHSfumiNp
         +jaoJidZN+Z3bgbLdTMcdNjD0HC1gDadDhtLbUQoi4DSRn8JIdWOXUIDqh0cbjfEfSgc
         GsNdKSZjVL2aasrfub7sokgXlwDoxTceKAYr3sQHnMNRp6ODx6oAImDzFIHHktuXM+6a
         d9i4jgHFs3Cr4pdzQKc2kvPRntshdYAA4mC4XKR4kAtHcvHVFySHUN5JS7zFjTVx4x+p
         pnCw==
X-Gm-Message-State: ABy/qLbbJ6z+W0MJDhs/K7Jobhhxe2PNt+/xvKPjrGtYH7fS9GgRyIxq
        utShGpPlxi9FZF46RjXmB/o=
X-Google-Smtp-Source: APBJJlHyxbZ3YfFVMVMFa8QzM/PIEhuoxubhFCWwG9Ka8E8RRQw7oYWoWGESWMBP2fP0bvQMoyFrsw==
X-Received: by 2002:a5d:6146:0:b0:314:dea:f1f8 with SMTP id y6-20020a5d6146000000b003140deaf1f8mr501942wrt.11.1690832425604;
        Mon, 31 Jul 2023 12:40:25 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id r8-20020adfe688000000b0031434c08bb7sm13861184wrm.105.2023.07.31.12.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 12:40:24 -0700 (PDT)
Date:   Mon, 31 Jul 2023 20:40:24 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Jiri Olsa <olsajiri@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v8 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Message-ID: <b8b05bb6-3d23-4e90-beb0-a256dbc32ef2@lucifer.local>
References: <cover.1679566220.git.lstoakes@gmail.com>
 <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
 <ZHc2fm+9daF6cgCE@krava>
 <ZLqMtcPXAA8g/4JI@MiWiFi-R3L-srv>
 <86fd0ccb-f460-651f-8048-1026d905a2d6@redhat.com>
 <f10f06d4-9c82-41d3-a62a-09c62f254cfc@lucifer.local>
 <32b8c5e4-c8e3-0244-1b1a-ca33bd44f38a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32b8c5e4-c8e3-0244-1b1a-ca33bd44f38a@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 09:24:50PM +0200, David Hildenbrand wrote:
> On 31.07.23 21:21, Lorenzo Stoakes wrote:
> > On Mon, Jul 24, 2023 at 08:23:55AM +0200, David Hildenbrand wrote:
> > > Hi,
> > >
> > > >
> > > > I met this too when I executed below command to trigger a kcore reading.
> > > > I wanted to do a simple testing during system running and got this.
> > > >
> > > >     makedumpfile --mem-usage /proc/kcore
> > > >
> > > > Later I tried your above objdump testing, it corrupted system too.
> > > >
> > >
> > > What do you mean with "corrupted system too" --  did it not only fail to
> > > dump the system, but also actually harmed the system?
> > >
> > > @Lorenzo do you plan on reproduce + fix, or should we consider reverting
> > > that change?
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >
> >
> > Apologies I mised this, I have been very busy lately not least with book :)
> >
> > Concerning, I will take a look as I get a chance. I think the whole series
> > would have to be reverted which would be... depressing... as other patches
> > in series eliminates the bounce buffer altogether.
> >
>
> I spotted
>
> https://lkml.kernel.org/r/069dd40aa71e634b414d07039d72467d051fb486.camel@gmx.de
>

Find that slightly confusing, they talk about just reveritng the patch but then
also add a kern_addr_valid()?

I'm also confused about people talking about just reverting the patch, as
4c91c07c93bb drops the bounce buffer altogether... presumably they mean
reverting both?

Clearly this is an arm64 thing (obviously), I have some arm64 hardware let me
see if I can repro...

Baoquan, Jiri - are you reverting more than just the one commit? And does doing
this go from not working -> working? Or from not working (worst case oops) ->
error?

> today, maybe that's related.
>
> --
> Cheers,
>
> David / dhildenb
>
