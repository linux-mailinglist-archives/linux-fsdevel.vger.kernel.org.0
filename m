Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DB375ED39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jul 2023 10:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjGXIS4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jul 2023 04:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGXISz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:18:55 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB61D93;
        Mon, 24 Jul 2023 01:18:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9926623e367so723726366b.0;
        Mon, 24 Jul 2023 01:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690186732; x=1690791532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7buxcMDQbXYavYttmKzovI7MVKRmkAiMGJ3Ho5r5lNY=;
        b=K+gsHI9j9r5lM9XR5WMABpbPvZlKmXj9i8awMb9HkIEa50nkUIRf2zcqCu/VonB6pr
         PsFFF9JmFN6t32dktfPlGOi4b0/k6/hsfQr73Zgn4fW1Dkt5My77WJsXR9Ipc/JeVokw
         ko5Awlouhbsuwp1TtlL+dGDxGLvZC3M3aN7VKH8K4hHO0QMwYE84iv8mOwJ43pIaHnzE
         j4z+wYwstI9IMtOWD9M8vuQuEFyhjSLqm8uS6gurwmoxQ1dY6JSi5/bLG6Y4zKFZQwhU
         24zHhYW3fGOSqIZU4AVeJgPt4gI32ED6/cBUcsMB5rYdLAgJ6EHi22z5tkgwdAW/1rrK
         zYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690186732; x=1690791532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7buxcMDQbXYavYttmKzovI7MVKRmkAiMGJ3Ho5r5lNY=;
        b=YfJ7zXSvFlMTl2XOpXBO7fHTCzEAQrFbj1lH7TUFuZ+z+gP9Dsl05kwmGANKQoq89d
         N7vuJWC8nvEw95UKNF98F+2veuMuZiGnIW3V/j+nJiizbU9HfA+9KMPf5/DnkyXgsSLs
         US+x8QGpWg0n2leBHaqLt7gyDEgoJ+VpD7bbbO//jwC56ru33VEG9gWhzMbj0ADkZu5s
         BGeFPY+6CnwyYmhhGwrBo2lkIDoVkrousYTeY4RnD0X62i2xej/RwYz/FG1k4hDgrx53
         MUcsxRrO/5uWvESNDleLxk7Q04YtjBTomEusR2hxEPqLnEIYDLmf1jcvAgI8kyWB6f9L
         qfKg==
X-Gm-Message-State: ABy/qLa4sy1qSdhVqrllKeHBe5u2VFA58ZP/AIFI2UURGyLucAZtrCc1
        ZfSDXOqM1WtlUaImS06S694Hxk6Zyac=
X-Google-Smtp-Source: APBJJlGho1sN/bOHW+RH6k1NPxhZen/9JhFicpH04PsIewBGNWPrEjS7LDmgv8rz/WQW9yb2ay9KJw==
X-Received: by 2002:a17:907:7758:b0:988:a578:4d65 with SMTP id kx24-20020a170907775800b00988a5784d65mr9049507ejc.32.1690186732037;
        Mon, 24 Jul 2023 01:18:52 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id kg8-20020a17090776e800b0099329b3ab67sm6337302ejc.71.2023.07.24.01.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:18:51 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 24 Jul 2023 10:18:48 +0200
To:     Baoquan He <bhe@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v8 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Message-ID: <ZL4z6LVzrbMvXwyl@krava>
References: <cover.1679566220.git.lstoakes@gmail.com>
 <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
 <ZHc2fm+9daF6cgCE@krava>
 <ZLqMtcPXAA8g/4JI@MiWiFi-R3L-srv>
 <86fd0ccb-f460-651f-8048-1026d905a2d6@redhat.com>
 <ZL4xif/LX6ZhRqtf@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL4xif/LX6ZhRqtf@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 24, 2023 at 04:08:41PM +0800, Baoquan He wrote:
> On 07/24/23 at 08:23am, David Hildenbrand wrote:
> > Hi,
> > 
> > > 
> > > I met this too when I executed below command to trigger a kcore reading.
> > > I wanted to do a simple testing during system running and got this.
> > > 
> > >    makedumpfile --mem-usage /proc/kcore
> > > 
> > > Later I tried your above objdump testing, it corrupted system too.
> > > 
> > 
> > What do you mean with "corrupted system too" --  did it not only fail to
> > dump the system, but also actually harmed the system?
> 
> From my testing, reading kcore will cause system panic, then reboot. Not
> sure if Jiri saw the same phenomenon.

it did not crash for me, just the read error
could you get console output from that?

jirka

> 
> > 
> > @Lorenzo do you plan on reproduce + fix, or should we consider reverting
> > that change?
> 
> When tested on a arm64 system, the reproducution is stable. I will have
> a look too to see if I have some finding this week.
> 
