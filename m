Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EF776A358
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 23:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjGaVub (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 17:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjGaVu3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:50:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3527B1718;
        Mon, 31 Jul 2023 14:50:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so14920735e9.0;
        Mon, 31 Jul 2023 14:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690840224; x=1691445024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfZo16Tt9kvpNfsLlO4ki6ZdRkbvVDogdV8NnQudSyc=;
        b=KPdLIRgbDvS/UkjfhhaOrpJGjubdJRib5xeU+gS66Y5Otf5FZZ30bopbJn7HJ8i1Qe
         Kv1HCyAtQdna5OHQ/GhvjvBrU+aI93TDBV7vftufjYH6/XfRMM55at6Oq3hy+CSgVPd3
         ZAKjHu19h4wu4alrJrHUHbxEPs8yyNhwm/U/LEaCwU7i0aSgSToKHS/FwFDSkA2C1yFx
         zRpywd9CgIuJAqESFCHjWp8FaxIZL65RiVMnsyPdAWNCtOyhCX3vzcwKEb7oBieiLbOT
         k17vv2O2dkvW+iqwTjdMCrgZlj3G6m4QiVAnkbyScauCspmoz/V762dUV72akBEWJHkC
         8VAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690840224; x=1691445024;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfZo16Tt9kvpNfsLlO4ki6ZdRkbvVDogdV8NnQudSyc=;
        b=WbE4NV62k71yv7Kug9eDSQxJERB4z6kiT9CfqGc0A648Dbykr7HSVLe1O3BzM62dKT
         LzjlzXWA/uP/W7VoQC2h6G9Rgq8R3/U7B2frbCzikrzm95oWpGJyEy4CMqc9aPoLkzfI
         5Qm2L6AvJ2D6nOxgdb2YVPSI4/Q4jxeASqQ0WRhNvELOq/RzcF982MhahEV5MymD0l2F
         nb+LVvwPQahw9hN/7dGAN2v3KH7bRl1Bj59zlr7joOM24MnhtCExITz/ZE+PhYuXN0n/
         qi9afJw6kNFHTjW7uzEXhiZj74WWT8bjfy+1cgv7ADJshPBG5Oz3sk7FQDZGBVjbyRmt
         b/zA==
X-Gm-Message-State: ABy/qLafdQ1d1g97293Rpo1SBPkFRKfvkwAEFU+HNJYzBrp6PVV6Oz65
        VQXNnt6acQa7rG2ftTMA73I=
X-Google-Smtp-Source: APBJJlFaRkxW/ieEkekJ3sX1GE84qtRUOLcKzOhbbtSysFsdIn08kU/mBuJlOnNyXLPA0gLwsqxKsQ==
X-Received: by 2002:a1c:f202:0:b0:3f9:b430:199b with SMTP id s2-20020a1cf202000000b003f9b430199bmr909451wmc.15.1690840224278;
        Mon, 31 Jul 2023 14:50:24 -0700 (PDT)
Received: from krava ([83.240.60.220])
        by smtp.gmail.com with ESMTPSA id hn8-20020a05600ca38800b003fe29dc0ff2sm118333wmb.21.2023.07.31.14.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 14:50:23 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 31 Jul 2023 23:50:22 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Baoquan He <bhe@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v8 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Message-ID: <ZMgsnkax+SAt1zbl@krava>
References: <cover.1679566220.git.lstoakes@gmail.com>
 <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
 <ZHc2fm+9daF6cgCE@krava>
 <ZLqMtcPXAA8g/4JI@MiWiFi-R3L-srv>
 <86fd0ccb-f460-651f-8048-1026d905a2d6@redhat.com>
 <f10f06d4-9c82-41d3-a62a-09c62f254cfc@lucifer.local>
 <32b8c5e4-c8e3-0244-1b1a-ca33bd44f38a@redhat.com>
 <b8b05bb6-3d23-4e90-beb0-a256dbc32ef2@lucifer.local>
 <ZMgazd69Dj6Idy6H@krava>
 <ZMgjqJycJFsgvWOD@murray>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMgjqJycJFsgvWOD@murray>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 10:12:08PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jul 31, 2023 at 10:34:21PM +0200, Jiri Olsa wrote:
> > On Mon, Jul 31, 2023 at 08:40:24PM +0100, Lorenzo Stoakes wrote:
> > > On Mon, Jul 31, 2023 at 09:24:50PM +0200, David Hildenbrand wrote:
> > > > On 31.07.23 21:21, Lorenzo Stoakes wrote:
> > > > > On Mon, Jul 24, 2023 at 08:23:55AM +0200, David Hildenbrand wrote:
> > > > > > Hi,
> > > > > >
> > > > > > >
> > > > > > > I met this too when I executed below command to trigger a kcore reading.
> > > > > > > I wanted to do a simple testing during system running and got this.
> > > > > > >
> > > > > > >     makedumpfile --mem-usage /proc/kcore
> > > > > > >
> > > > > > > Later I tried your above objdump testing, it corrupted system too.
> > > > > > >
> > > > > >
> > > > > > What do you mean with "corrupted system too" --  did it not only fail to
> > > > > > dump the system, but also actually harmed the system?
> > > > > >
> > > > > > @Lorenzo do you plan on reproduce + fix, or should we consider reverting
> > > > > > that change?
> > > > > >
> > > > > > --
> > > > > > Cheers,
> > > > > >
> > > > > > David / dhildenb
> > > > > >
> > > > >
> > > > > Apologies I mised this, I have been very busy lately not least with book :)
> > > > >
> > > > > Concerning, I will take a look as I get a chance. I think the whole series
> > > > > would have to be reverted which would be... depressing... as other patches
> > > > > in series eliminates the bounce buffer altogether.
> > > > >
> > > >
> > > > I spotted
> > > >
> > > > https://lkml.kernel.org/r/069dd40aa71e634b414d07039d72467d051fb486.camel@gmx.de
> > > >
> > >
> > > Find that slightly confusing, they talk about just reveritng the patch but then
> > > also add a kern_addr_valid()?
> > >
> > > I'm also confused about people talking about just reverting the patch, as
> > > 4c91c07c93bb drops the bounce buffer altogether... presumably they mean
> > > reverting both?
> > >
> > > Clearly this is an arm64 thing (obviously), I have some arm64 hardware let me
> > > see if I can repro...
> >
> > I see the issue on x86
> 
> Ummmm what? I can't! What repro are you seeing on x86, exactly?

# cat /proc/kallsyms | grep ksys_read
ffffffff8151e450 T ksys_read

# objdump -d  --start-address=0xffffffff8151e450 --stop-address=0xffffffff8151e460 /proc/kcore 

/proc/kcore:     file format elf64-x86-64

objdump: Reading section load1 failed because: Bad address


jirka

> 
> >
> > >
> > > Baoquan, Jiri - are you reverting more than just the one commit? And does doing
> > > this go from not working -> working? Or from not working (worst case oops) ->
> > > error?
> >
> > yes, I used to revert all 4 patches
> >
> > I did quick check and had to revert 2 more patches to get clean revert
> >
> > 38b138abc355 Revert "fs/proc/kcore: avoid bounce buffer for ktext data"
> > e2c3b418d365 Revert "fs/proc/kcore: convert read_kcore() to read_kcore_iter()"
> > d8bc432cb314 Revert "iov_iter: add copy_page_to_iter_nofault()"
> > bf2c6799f68c Revert "iov_iter: Kill ITER_PIPE"
> > ccf4b2c5c5ce Revert "mm: vmalloc: convert vread() to vread_iter()"
> > de400d383a7e Revert "mm/vmalloc: replace the ternary conditional operator with min()"
> >
> > jirka
> 
> That's quite a few more reverts and obviously not an acceptable solution here.
> 
> Looking at
> https://lore.kernel.org/all/CAA5enKaUYehLZGL3abv4rsS7caoUG-pN9wF3R+qek-DGNZufbA@mail.gmail.com
> a parallel thread on this, it looks like the issue is that we are no longer
> using a no-fault kernel copy in KCORE_TEXT path and arm64 doesn't map everything
> in the text range.
> 
> Solution would be to reinstate the bounce buffer in this case (ugh). Longer term
> solution I think would be to create some iterator helper that does no fault
> copies from the kernel.
> 
> I will try to come up with a semi-revert that keeps the iterator stuff but
> keeps a hideous bounce buffer for the KCORE_TEXT bit with a comment
> explaining why...
