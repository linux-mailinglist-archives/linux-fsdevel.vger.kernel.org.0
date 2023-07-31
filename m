Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D6576A1FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 22:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjGaUep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 16:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjGaUeo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:34:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ADD1BEF;
        Mon, 31 Jul 2023 13:34:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-316feb137a7so5151334f8f.1;
        Mon, 31 Jul 2023 13:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690835664; x=1691440464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=erOfK/Ywaqu4GQR7DM2S2Q8N9sM102JexPWTiAvOnR8=;
        b=qs3pfJOVNqZT9vEauebmmM5fpl2ScFPDUEnkBr1B0ZgufKpemdRuSao3iArmSKc9gj
         NN+AA65G9yv9pdF8X4MX73cSZFYYNJA3vo+6xkwE8+umPrjKM0ztlaw7LLjXFxOwnO0D
         lQc49OdQejgfnDkS34NJhgtxhOFwSQGNHU6DZgpvjBpdzrpvnby3/KChrG5w+Z/icn9g
         wT8MG/wX6cLQePXDfoNqg6+qV32QM+jm5I6xCUaJWrlvABhbj8j+iTGM655TNHfRlMSl
         JM8W1Prrr1m2hrPCG+wPPzY0krbT8Ilmi2DAoz45oMRhbsc3/xlWTNutASJCXXKWc7xb
         DWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690835664; x=1691440464;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=erOfK/Ywaqu4GQR7DM2S2Q8N9sM102JexPWTiAvOnR8=;
        b=BQpeQNfkPPzHMIDxgVhzuIwxtna69u4nRnzOaCRslryi3EQgRJiNnzHDtg/ic2PUu2
         nYRVN47mN7YMYYfbyzqUGpyR2fGTKU2hvOpLnII4zKe1Qb83EE5qBrPcSz63sI21n4Le
         NP4Z5iFrgQ4HIkkb011cguwfZHio3SzgkjHknlrsoyVMSsUKbY6fgzkQ3kSiHy94tsrj
         vPi3gG1v5RfIWV9XGlI1/03W+uwBLf19LwQrb4PNiQQvDzapx0oq1k2TWNoid7CfZYL4
         yhfutWfM0NO67h/+smY3382nwpsUq92reWb8saQlSytoWNE6jTbxH3df28vQAFf7E7fY
         cShw==
X-Gm-Message-State: ABy/qLboJiRVtoMf9mcJiwvQMuMUbjvmYuzlrFau3TumMaXijwUmcIMT
        ni1gBkKCvNYiHNPjE/3f+/w=
X-Google-Smtp-Source: APBJJlHv67washl2dS7E0c58n9ODVHLgwkCmP7urrHQMWwYPoR68/ZAARgq0+fSXEzoVv+k7PD7VMQ==
X-Received: by 2002:a5d:62c7:0:b0:315:ad00:e628 with SMTP id o7-20020a5d62c7000000b00315ad00e628mr545972wrv.47.1690835664138;
        Mon, 31 Jul 2023 13:34:24 -0700 (PDT)
Received: from krava ([83.240.60.220])
        by smtp.gmail.com with ESMTPSA id f11-20020adff58b000000b003143aa0ca8asm14000342wro.13.2023.07.31.13.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 13:34:23 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Mon, 31 Jul 2023 22:34:21 +0200
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>,
        Jiri Olsa <olsajiri@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v8 1/4] fs/proc/kcore: avoid bounce buffer for ktext data
Message-ID: <ZMgazd69Dj6Idy6H@krava>
References: <cover.1679566220.git.lstoakes@gmail.com>
 <fd39b0bfa7edc76d360def7d034baaee71d90158.1679566220.git.lstoakes@gmail.com>
 <ZHc2fm+9daF6cgCE@krava>
 <ZLqMtcPXAA8g/4JI@MiWiFi-R3L-srv>
 <86fd0ccb-f460-651f-8048-1026d905a2d6@redhat.com>
 <f10f06d4-9c82-41d3-a62a-09c62f254cfc@lucifer.local>
 <32b8c5e4-c8e3-0244-1b1a-ca33bd44f38a@redhat.com>
 <b8b05bb6-3d23-4e90-beb0-a256dbc32ef2@lucifer.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b05bb6-3d23-4e90-beb0-a256dbc32ef2@lucifer.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 08:40:24PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jul 31, 2023 at 09:24:50PM +0200, David Hildenbrand wrote:
> > On 31.07.23 21:21, Lorenzo Stoakes wrote:
> > > On Mon, Jul 24, 2023 at 08:23:55AM +0200, David Hildenbrand wrote:
> > > > Hi,
> > > >
> > > > >
> > > > > I met this too when I executed below command to trigger a kcore reading.
> > > > > I wanted to do a simple testing during system running and got this.
> > > > >
> > > > >     makedumpfile --mem-usage /proc/kcore
> > > > >
> > > > > Later I tried your above objdump testing, it corrupted system too.
> > > > >
> > > >
> > > > What do you mean with "corrupted system too" --  did it not only fail to
> > > > dump the system, but also actually harmed the system?
> > > >
> > > > @Lorenzo do you plan on reproduce + fix, or should we consider reverting
> > > > that change?
> > > >
> > > > --
> > > > Cheers,
> > > >
> > > > David / dhildenb
> > > >
> > >
> > > Apologies I mised this, I have been very busy lately not least with book :)
> > >
> > > Concerning, I will take a look as I get a chance. I think the whole series
> > > would have to be reverted which would be... depressing... as other patches
> > > in series eliminates the bounce buffer altogether.
> > >
> >
> > I spotted
> >
> > https://lkml.kernel.org/r/069dd40aa71e634b414d07039d72467d051fb486.camel@gmx.de
> >
> 
> Find that slightly confusing, they talk about just reveritng the patch but then
> also add a kern_addr_valid()?
> 
> I'm also confused about people talking about just reverting the patch, as
> 4c91c07c93bb drops the bounce buffer altogether... presumably they mean
> reverting both?
> 
> Clearly this is an arm64 thing (obviously), I have some arm64 hardware let me
> see if I can repro...

I see the issue on x86

> 
> Baoquan, Jiri - are you reverting more than just the one commit? And does doing
> this go from not working -> working? Or from not working (worst case oops) ->
> error?

yes, I used to revert all 4 patches

I did quick check and had to revert 2 more patches to get clean revert

38b138abc355 Revert "fs/proc/kcore: avoid bounce buffer for ktext data"
e2c3b418d365 Revert "fs/proc/kcore: convert read_kcore() to read_kcore_iter()"
d8bc432cb314 Revert "iov_iter: add copy_page_to_iter_nofault()"
bf2c6799f68c Revert "iov_iter: Kill ITER_PIPE"
ccf4b2c5c5ce Revert "mm: vmalloc: convert vread() to vread_iter()"
de400d383a7e Revert "mm/vmalloc: replace the ternary conditional operator with min()"

jirka
