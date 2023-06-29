Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91B5741F3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 06:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjF2Eal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 00:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjF2Eaj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 00:30:39 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4CB1FD8;
        Wed, 28 Jun 2023 21:30:37 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b5cf23b9fcso264981a34.0;
        Wed, 28 Jun 2023 21:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688013037; x=1690605037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D7XOqTSDZOtUVd5gsMuzF7HGyo4cC6+cHT9OFJOUkek=;
        b=mPuqJl5Qb/XufWeJFmcc82iCmTfEfUXqgTlO+I+tFbil4MLw8WIT0DAg3ipgGM36xu
         +Ufy1MtGmeV2rvGlvLq7ZH7LLHD7gZ7GQ+b141UYLAk10WvUZi8VbJkT+nfaWbOPZw8d
         ms26XtBCIdrt21+MhxVVt6B9wWaN/4SK4eBiFbqvQo2wHViOb8uAr6z4qb+hw1Ksuo51
         ROZehqJuk+VlQQZ4YOcR32yE3kOndsT7U9ypwwVVhbvqSSgkn7Mpb1ygFq/+Zo0ecYGQ
         /n6mdeXMQ2ObuBmwJnmEICN71lC6mibdUkI77rl859WED9f1D0cLIWfmx/LGj8jDfBrg
         3Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688013037; x=1690605037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7XOqTSDZOtUVd5gsMuzF7HGyo4cC6+cHT9OFJOUkek=;
        b=OqlR496inOxTv+FIExP9tg3wAmxviBjo4krsFDINopUWHVQLXWczd8CLGUmptAWEtA
         ZMoKJiH+48AEr3/glJm3Df2WB47pENNjBE4tmn/3Hu1tV7yaAs6CRRq2n76p2LS/7qEQ
         qAA0Sdtg+YZhC5uM6U9H0AdS8/9x+dgW/a0QHd8rR8/ejRJdKkiFn0haJV5qAC9LOBYz
         4YvHYr4ZRpXQ8hfvrW+nvg6rS+7S8QvBvdKnsL9NPF1eBB8iUHKlgp9CfNY4mWkeWHc0
         fZTN2zML+WKcPM7HPeUbZtvMBr0lc7rBpJ+F/dZ6BqsV6WbmqXAl91VOfKhFizIuIZbI
         R1mQ==
X-Gm-Message-State: AC+VfDzetBBcBFmrUKoQottyKOdf1mrssPR3acTfgckrhxvKbplKNL/A
        iovuwaJFT9g7TCUAbeqLlvQ2rnydq3nkW1/z
X-Google-Smtp-Source: ACHHUZ60fSJkgBgpVSXf1FHm6g3oMzY8AUXrN+28BZMUuQsVU5h5+titHQqnkP0ZvFsTLwXk+9xfUw==
X-Received: by 2002:a05:6871:3d1:b0:1b0:18e8:9536 with SMTP id a17-20020a05687103d100b001b018e89536mr13087156oag.52.1688013037125;
        Wed, 28 Jun 2023 21:30:37 -0700 (PDT)
Received: from sumitra.com ([117.199.159.11])
        by smtp.gmail.com with ESMTPSA id j22-20020a170902759600b001b3c892c367sm8345745pll.63.2023.06.28.21.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 21:30:36 -0700 (PDT)
Date:   Wed, 28 Jun 2023 21:30:31 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Fabio <fmdefrancesco@gmail.com>, Deepak R Varma <drv@mailo.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: Re: [PATCH] fs/vboxsf: Replace kmap() with kmap_local_{page, folio}()
Message-ID: <20230629043031.GA455425@sumitra.com>
References: <20230627135115.GA452832@sumitra.com>
 <ZJsg5GL79MIOzbRf@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJsg5GL79MIOzbRf@casper.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 06:48:20PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 27, 2023 at 06:51:15AM -0700, Sumitra Sharma wrote:
> > +++ b/fs/vboxsf/file.c
> > @@ -234,7 +234,7 @@ static int vboxsf_read_folio(struct file *file, struct folio *folio)
> >  	u8 *buf;
> >  	int err;
> >  
> > -	buf = kmap(page);
> > +	buf = kmap_local_folio(folio, off);
> 
> Did you test this?  'off' is the offset in the _file_.  Whereas
> kmap_local_folio() takes the offset within the _folio_.  They have
> different types (loff_t vs size_t) to warn you that they're different
> things.
>

Hi Matthew,

When creating this patch, I read and searched about the loff_t vs size_t.
By mistake, I implemented it in the wrong way.

Also, I did not test it and just compiled it. I apologise for doing so.

And for the other points you have put as feedback. I will take some time to understand
it. And would like to work on the changes you suggest.

Thanks & regards
Sumitra



