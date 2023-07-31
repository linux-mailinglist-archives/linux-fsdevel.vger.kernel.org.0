Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2E676A277
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 23:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjGaVMU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 17:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGaVMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:12:15 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A067B12B;
        Mon, 31 Jul 2023 14:12:11 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso17827305e9.0;
        Mon, 31 Jul 2023 14:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690837930; x=1691442730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cvkb1F7VeYbirXxnx/x7mD/WcXLmaxSiQihg0hXEQQg=;
        b=n6g/Ss/sQPMvbjMnTYF1MCm9NoGwZgq3AjRvB60EV0FmBknxJfICpj44Pem09ppRkq
         qa4NY/S6KJcLWi7LxkIYsEU4g8rC5AbvkESnrRTLhmqwCwskgG8wHfk4EnCUzxvbM2MV
         vjjGgiW6tZ2dFXnwyr3vgm6ZVeFQJ/pgYDV5Wa+tBA6mRJ98WL1IOAORLRi6wds8DW6W
         N4DmL2+PAgJ9HYqR7MsGyIxV4f9u7675wZiWx/crev+xl7+uq5P4mbdsbD5uUs3cSP0b
         r8RwVS2Qo1oEzDTaV4BOk/2HL+2m9LbZCj3MebBKFb+ya633bL71ddA5H9aLd28l9pQW
         SFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690837930; x=1691442730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cvkb1F7VeYbirXxnx/x7mD/WcXLmaxSiQihg0hXEQQg=;
        b=BdwBb7Dwjw1eGxspUbV4Gyg6ES/d/7qU866dh67m9nHkQCM/7FLFmzp7ML1UIMTQkn
         RQMhLUk3yXEDU2cOCVDq8HoSuG8G5uw1nOUbj6v56JMYxMI4W6sLLK+nrsbxwgz57wfJ
         xitDDcW7AuqaLX7A1g6nsGLGvzZVYlyJo9wwKI2GbVs0VSP8wBHnjxphvI4upBbt2w2x
         KoP72T3QZK6gzxFRq1ctqnBZ37cH0KKSHI06Bk52KVzBfV+Tty18R7TuPlUMU1Oaxv7b
         Dg7aGHRaQeyyEnpZnNbipykmMYyoz+pB+crcFD12pHnGDgq1T9DkBw1es9Wkt51IG/wI
         /zoQ==
X-Gm-Message-State: ABy/qLZnhUxJuDeCrLYqxp3IrGK3NlQjDQOirNjeaC3QrbiYSqo/Vs0O
        N2f4vDGlds/cyaD9FPTGHjI=
X-Google-Smtp-Source: APBJJlFMnVUrPHPp6WA73ZZia48T89g5i5rzrlvGXpGuYDrSD6cjZj2jDc2G7hW1ghXlOExCwxVujA==
X-Received: by 2002:a1c:741a:0:b0:3fd:29cf:20c5 with SMTP id p26-20020a1c741a000000b003fd29cf20c5mr935074wmc.7.1690837929823;
        Mon, 31 Jul 2023 14:12:09 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:8213:500:1aa9:44da])
        by smtp.gmail.com with ESMTPSA id v25-20020a05600c215900b003fc02a410d0sm14815152wml.48.2023.07.31.14.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 14:12:09 -0700 (PDT)
Date:   Mon, 31 Jul 2023 22:12:08 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v8 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Message-ID: <ZMgjqJycJFsgvWOD@murray>
References: <cover.1679566220.git.lstoakes@gmail.com>
 <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
 <ZHc2fm+9daF6cgCE@krava>
 <ZLqMtcPXAA8g/4JI@MiWiFi-R3L-srv>
 <86fd0ccb-f460-651f-8048-1026d905a2d6@redhat.com>
 <f10f06d4-9c82-41d3-a62a-09c62f254cfc@lucifer.local>
 <32b8c5e4-c8e3-0244-1b1a-ca33bd44f38a@redhat.com>
 <b8b05bb6-3d23-4e90-beb0-a256dbc32ef2@lucifer.local>
 <ZMgazd69Dj6Idy6H@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMgazd69Dj6Idy6H@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:34:21PM +0200, Jiri Olsa wrote:
> On Mon, Jul 31, 2023 at 08:40:24PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Jul 31, 2023 at 09:24:50PM +0200, David Hildenbrand wrote:
> > > On 31.07.23 21:21, Lorenzo Stoakes wrote:
> > > > On Mon, Jul 24, 2023 at 08:23:55AM +0200, David Hildenbrand wrote:
> > > > > Hi,
> > > > >
> > > > > >
> > > > > > I met this too when I executed below command to trigger a kcore reading.
> > > > > > I wanted to do a simple testing during system running and got this.
> > > > > >
> > > > > >     makedumpfile --mem-usage /proc/kcore
> > > > > >
> > > > > > Later I tried your above objdump testing, it corrupted system too.
> > > > > >
> > > > >
> > > > > What do you mean with "corrupted system too" --  did it not only fail to
> > > > > dump the system, but also actually harmed the system?
> > > > >
> > > > > @Lorenzo do you plan on reproduce + fix, or should we consider reverting
> > > > > that change?
> > > > >
> > > > > --
> > > > > Cheers,
> > > > >
> > > > > David / dhildenb
> > > > >
> > > >
> > > > Apologies I mised this, I have been very busy lately not least with book :)
> > > >
> > > > Concerning, I will take a look as I get a chance. I think the whole series
> > > > would have to be reverted which would be... depressing... as other patches
> > > > in series eliminates the bounce buffer altogether.
> > > >
> > >
> > > I spotted
> > >
> > > https://lkml.kernel.org/r/069dd40aa71e634b414d07039d72467d051fb486.camel@gmx.de
> > >
> >
> > Find that slightly confusing, they talk about just reveritng the patch but then
> > also add a kern_addr_valid()?
> >
> > I'm also confused about people talking about just reverting the patch, as
> > 4c91c07c93bb drops the bounce buffer altogether... presumably they mean
> > reverting both?
> >
> > Clearly this is an arm64 thing (obviously), I have some arm64 hardware let me
> > see if I can repro...
>
> I see the issue on x86

Ummmm what? I can't! What repro are you seeing on x86, exactly?

>
> >
> > Baoquan, Jiri - are you reverting more than just the one commit? And does doing
> > this go from not working -> working? Or from not working (worst case oops) ->
> > error?
>
> yes, I used to revert all 4 patches
>
> I did quick check and had to revert 2 more patches to get clean revert
>
> 38b138abc355 Revert "fs/proc/kcore: avoid bounce buffer for ktext data"
> e2c3b418d365 Revert "fs/proc/kcore: convert read_kcore() to read_kcore_iter()"
> d8bc432cb314 Revert "iov_iter: add copy_page_to_iter_nofault()"
> bf2c6799f68c Revert "iov_iter: Kill ITER_PIPE"
> ccf4b2c5c5ce Revert "mm: vmalloc: convert vread() to vread_iter()"
> de400d383a7e Revert "mm/vmalloc: replace the ternary conditional operator with min()"
>
> jirka

That's quite a few more reverts and obviously not an acceptable solution here.

Looking at
https://lore.kernel.org/all/CAA5enKaUYehLZGL3abv4rsS7caoUG-pN9wF3R+qek-DGNZufbA@mail.gmail.com
a parallel thread on this, it looks like the issue is that we are no longer
using a no-fault kernel copy in KCORE_TEXT path and arm64 doesn't map everything
in the text range.

Solution would be to reinstate the bounce buffer in this case (ugh). Longer term
solution I think would be to create some iterator helper that does no fault
copies from the kernel.

I will try to come up with a semi-revert that keeps the iterator stuff but
keeps a hideous bounce buffer for the KCORE_TEXT bit with a comment
explaining why...
