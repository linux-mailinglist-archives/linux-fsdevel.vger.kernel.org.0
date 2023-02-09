Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BE169116B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Feb 2023 20:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjBITg0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Feb 2023 14:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjBITgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Feb 2023 14:36:25 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6347140C1
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Feb 2023 11:36:23 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j25so2913285wrc.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Feb 2023 11:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WY1X/c7e5Z92+OMmg4xbOvYoJirbhLhMQkOVuZxTbAc=;
        b=HpNataVxmxBBguwOhOWdkBLvuG7E72utIRmGrRWfumQf/7LSHKz2DmnbWLl7i7CwIa
         kubb6cZfJqtTPz4iOILzRcOsFWYWstwg/DAwK0/5WnU8e6BtpUALpxd611815udXP0Bz
         pHSLnZDLlYJY0wrv4dfF/rWX7DHdrmcoWXY5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WY1X/c7e5Z92+OMmg4xbOvYoJirbhLhMQkOVuZxTbAc=;
        b=rDcPD4T4mOUMOYkJZwnHljrEgWpzauRDR1wqAOC7C4PlMF5jMcm3wHi6YifPqsmjTL
         MXdCud8AnS0mq/CdX++SEiKi2ppJsXd5Y2d9rIplHFqq2bKwxI8uP0Dng2oF7IsOfY/b
         Xctpi3IOV2yy8b/kQLlKRraFZAOZ6DDNy1UAvVNsRIiUgxMpWXlz+ZrDd72bvM/D2H+d
         oF+kaC0tNKza7CWkNidkOfle7GIp/vinRysgO5pnTThq3gDuGpJ9G8rQVAnXAfyRHdlX
         bnQ17OTZoc7vp3HE7zSmil/oN9dkXM54hDkiCYKuCzd1YQB6IlGuculPzUTlUy0xvdun
         VHAg==
X-Gm-Message-State: AO0yUKXjCBRNBac2X8/IVTo5Cva3F7ym85fDmbh9TcTsB0DIat3c4upS
        Sz2LRW1NiN1IYuSWpy9CrAQm1NSC6OoViih+wHk=
X-Google-Smtp-Source: AK7set++aoCDB4Ghq3ziADReBt8nT3ubfxmrJEYp3Srfzezoo8KJI6IWX71cXny9r1xRG3Eu4Vgl1A==
X-Received: by 2002:adf:f5c8:0:b0:2c3:ed14:8319 with SMTP id k8-20020adff5c8000000b002c3ed148319mr12846955wrp.14.1675971381565;
        Thu, 09 Feb 2023 11:36:21 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id g12-20020a5d540c000000b002bff1de8d4bsm1926993wrv.49.2023.02.09.11.36.20
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 11:36:21 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id dr8so9559936ejc.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Feb 2023 11:36:20 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr2445413ejw.78.1675971380625; Thu, 09 Feb
 2023 11:36:20 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com> <f6c6d42e-337a-bbab-0d36-cfcc915d26c6@samba.org>
In-Reply-To: <f6c6d42e-337a-bbab-0d36-cfcc915d26c6@samba.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Feb 2023 11:36:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=widtNT9y-9uGMnAgyR0kzyo0XjTkExSMoGpbZgeU=+vng@mail.gmail.com>
Message-ID: <CAHk-=widtNT9y-9uGMnAgyR0kzyo0XjTkExSMoGpbZgeU=+vng@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
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

On Thu, Feb 9, 2023 at 11:17 AM Stefan Metzmacher <metze@samba.org> wrote:
>
> Any comment about the idea of having a preadv2() flag that
> asks for a dma copy with something like async_memcpy() instead
> of the default that ends up in copy_user_enhanced_fast_string()?

I guarantee that you will only slow things down with some odd async_memcpy.

There are zero DMA engines that do memory copying better than memcpy -
the only way you can do better if is the destination isn't memory in
the first place but the final device, and then we just call it "dma".

                Linus
