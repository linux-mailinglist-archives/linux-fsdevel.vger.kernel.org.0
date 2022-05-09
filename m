Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A1451F2CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 05:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiEIDMV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 23:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiEIDJy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 23:09:54 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617F68933D
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 20:06:00 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id d15so13054726lfk.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 May 2022 20:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPCLl0WNrEQ8X7TZbGk9F5F3Xw31TIAi53cscMQsEGE=;
        b=6xJ96j3c30HoyM2X0hOy9P1hGJLuH0A96qdPaznCYucEVe+8Xjgjzl3k4EkeeiMsJR
         k1bhgngPuoX8XuhqFShJQsQz+g1JmAAB6xf2xZzUwZwZnDoPfJdfEbBFttzjIVk1FdSK
         MIW9Ospi1Tz9i3tuZxlNEOl6D52+nCsQ33Gm9u3S4X57eBETIq0sXb6ZRNrDZWt9Zmco
         xiyJyXaRHhXHIa2rRHeotUBAHkx8rajzRRXFjMcyAeqxkvVmkYhOu04r7r49U0WOh41a
         CUEoJESUx7KT8KrEDnZRRMAv3vf0tuo9a8nLA+BGGuXdQMG/SOXC3luvwLcyhmCB2f0k
         Z4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPCLl0WNrEQ8X7TZbGk9F5F3Xw31TIAi53cscMQsEGE=;
        b=218ltLvgWQNMsr8pwhDdMgcwB3doIIK5O4zjC5jrBW20I9LHREHmrvi3WPeprO2UPl
         N73KSz7JYZxbm0cY9U0GwlSAb2Rc1JokgN0i/aYdJib20gRd6Zirj0eukaZozraZ+PP4
         gxDTAYX9d/QDzpPtgIb1p/cMGjzGbS1l9aioHujvaIm7dUJCYPbLIY3LrkF0mJUNAPOa
         4oOWOXxqa396cyGohO6ELkp0xStsiM70thVgEzJk+yN+C+VfAXI/wsBLmkt7pZH3/0u5
         1vr1WhzQfJkRRMkW/G7kz65OaMDtDw6ChN9eSebQaAkMNgV8EpyswUd8GoW8TO6Lc3f8
         uvTA==
X-Gm-Message-State: AOAM533gXrn8JuKo01zrasUncgAEyMnRX2/zTAIoegeWPuO//EUh76E+
        FlN/VcRdxDx5E3BFeCp8iO5iDWKnlx9tNJnqD29PfQ==
X-Google-Smtp-Source: ABdhPJylEsq2ZJj98ROOaWvCI5t7ScvLOENldeObjFe7fZFxjD/+x6tUKQL2zAuBGgq3+2z6PXGp7OAUYFJuce5ib0g=
X-Received: by 2002:a05:6512:13a3:b0:474:2642:d00e with SMTP id
 p35-20020a05651213a300b004742642d00emr2476580lfa.328.1652065558196; Sun, 08
 May 2022 20:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220507083154.18226-1-yinxin.x@bytedance.com> <dfcbda24-3969-f374-b209-81c3818246c1@linux.alibaba.com>
In-Reply-To: <dfcbda24-3969-f374-b209-81c3818246c1@linux.alibaba.com>
From:   Xin Yin <yinxin.x@bytedance.com>
Date:   Mon, 9 May 2022 11:05:47 +0800
Message-ID: <CAK896s68f5Snrip8TYPfDbObOpNoTtWW+0WBXzTiJbadAShGrg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] erofs: change to use asyncronous io for
 fscache readpage/readahead
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     hsiangkao@linux.alibaba.com, dhowells@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 7, 2022 at 9:08 PM JeffleXu <jefflexu@linux.alibaba.com> wrote:
>
>
>
> On 5/7/22 4:31 PM, Xin Yin wrote:
> > Use asyncronous io to read data from fscache may greatly improve IO
> > bandwidth for sequential buffer read scenario.
> >
> > Change erofs_fscache_read_folios to erofs_fscache_read_folios_async,
> > and read data from fscache asyncronously. Make .readpage()/.readahead()
> > to use this new helper.
> >
> > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > ---
>
> s/asyncronous/asynchronous/
> s/asyncronously/asynchronously/
>
Thanks for pointing this out , I will fix it.

> BTW, "convert to asynchronous readahead" may be more concise?
>
You mean the title of this patch?  But, actually we also change to use
this asynchronous io helper for .readpage() now , so I think we need
to point this in the title. right ?

Thanks,
Xin Yin
> Apart from that, LGTM
>
> Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
>
>
> --
> Thanks,
> Jeffle
