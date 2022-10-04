Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE07A5F3A7E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 02:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiJDAU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 20:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJDAUX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:20:23 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73F212D34
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Oct 2022 17:20:22 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id r136-20020a4a378e000000b004755953bc6cso7799139oor.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Oct 2022 17:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KDirZKludynJAQMkevqVYFO9iXAJsphavJFWStzbFqw=;
        b=S/SQ9Q+AQduFC8tL8YQbDrp+oISUO260VFWdJo+rwPI/o8Lh0vhX0Dsre8it2u+6t3
         WmcIZTOLFS3I8Aghe89U6F2WcLrG7GIg09Nrc0ebZf4q0+AoBpqA2xEYbVC9ITUilxxS
         fpv+gFLsoSPyiYScbLvABZ6SlEsPhgW431nA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KDirZKludynJAQMkevqVYFO9iXAJsphavJFWStzbFqw=;
        b=KB6dmyFbFkhoyBa887drIRhQ/geBwT90vWjV2BF06rEwXU7GpnRvaS+uJZzLPqxY+9
         SK4WNXHu6kAxbgxfEnyj6n78/2azQMXnY2tdOJO0pmWWtRgFrDD32IXKv9k9o8OyhMX0
         37K017yjh9bRAUW3YfA4fxNJjrkSRobEfgK83f1VZWkZIWFpu/73O1UGtEB04RAisZcx
         G+2naOv4G1DN5864YC/ham/kRW+PFNTDESfq8yZIvXXThCPQYGY9KLEp+E7YFJLks1n6
         4wudJf82pweiROKVjgQ3Kc9Xa0Y7O5+it+6+bkaDtGmk0NmULwLhyScWX5y3IRPjohVJ
         AFCA==
X-Gm-Message-State: ACrzQf1y7re4FqqexVP7BXIZYUgSQWGfP69tB9S0znfyMcd9tujrI2/o
        5aYYBTSyQW1HJun8ct6DXY+bQwK4D8xsCg==
X-Google-Smtp-Source: AMsMyM6+Q92TLYMR+0xLfjmLeGN8TnZ/dsXzGz8HMrg8Lkclmis8tImU8Nomtfn+b5PR5aWhKD8wzA==
X-Received: by 2002:a9d:2948:0:b0:65c:1cb7:d349 with SMTP id d66-20020a9d2948000000b0065c1cb7d349mr8936700otb.158.1664842821519;
        Mon, 03 Oct 2022 17:20:21 -0700 (PDT)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com. [209.85.167.180])
        by smtp.gmail.com with ESMTPSA id f18-20020a9d5f12000000b00659579f505fsm2680237oti.64.2022.10.03.17.20.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 17:20:20 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id o64so12911864oib.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Oct 2022 17:20:20 -0700 (PDT)
X-Received: by 2002:aca:b957:0:b0:351:4ecf:477d with SMTP id
 j84-20020acab957000000b003514ecf477dmr5055919oif.126.1664842820161; Mon, 03
 Oct 2022 17:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <YzN+ZYLjK6HI1P1C@ZenIV> <YzSSl1ItVlARDvG3@ZenIV>
 <YzpcXU2WO8e22Cmi@iweiny-desk3> <7714.1664794108@jrobl> <Yzs4mL3zrrC0/vN+@iweiny-mobl>
 <YztfvaAFOe2kGvDz@ZenIV> <4011.1664837894@jrobl> <YztyLFZJKKTWcMdO@ZenIV>
In-Reply-To: <YztyLFZJKKTWcMdO@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Oct 2022 17:20:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsOyuRhjmUQ5c1dBQYt1E4ANhObAbEspWtUyt+Pq=Kmw@mail.gmail.com>
Message-ID: <CAHk-=whsOyuRhjmUQ5c1dBQYt1E4ANhObAbEspWtUyt+Pq=Kmw@mail.gmail.com>
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on kmap_local_page()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "J. R. Okajima" <hooanon05g@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 3, 2022 at 4:37 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> One variant would be to revert the original patch, put its
> (hopefully) fixed variant into -next and let it sit there for
> a while.  Another is to put this incremental into -next and
> merge it into mainline once it gets a sane amount of testing.

Just do the incremental fix. It looks obvious enough ("oops, we need
to get the pos _after_ we've done any skip-lseeks on the core file")
that I think it would be just harder to follow a "revert and follow up
with a fix".

I don't think it needs a ton of extra testing, with Okajima having
already confirmed it fixes his problem case..

                Linus
