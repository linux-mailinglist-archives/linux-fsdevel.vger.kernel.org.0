Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C446533D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Dec 2022 17:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiLUQQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Dec 2022 11:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbiLUQQi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:16:38 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0E2220F0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 08:16:37 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-143ffc8c2b2so19704867fac.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 08:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hsa6T3GulZ+3V9yadTNjqSGffTKaOIWWpdQCi5qCyYQ=;
        b=L/DfgXegMdR/EV/AaMV4u/NVGnEQaXOgFHypZOdnIsfFew73CI/qPbpNneTYaRR9UY
         atbbDIh3qekit0O5oviVJlLf8AczqZdbosdc2t+YE/eif2gRRSJXXRAu3NKsTh3lFjit
         QDtM56khL1hVvtaStQLRu8DxrVnl4dCaZ7BEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hsa6T3GulZ+3V9yadTNjqSGffTKaOIWWpdQCi5qCyYQ=;
        b=IttpzJDq2tnNWnH37CyzFllv7/hfbtNnbkH9u5aZeavD24jpfKZX2yQXwghPR2CgdO
         hBzjUkhmstP7FcWYX37apmEKYWDyGbywkCeFFe1s5/eDgiv84QBxjPBZksXX7uA1NFyF
         GbNU7OnS867YPfu3bqOZQm5nNKuLeblEfwque5GRzsqr60ackXOkZE8qF1pCxvyNy2nN
         D/9DzBOrZXUYv7vT4Ry7u5hcz+5bHZo7ROzxHTzXRO+lJfvUZ56FPBPdtgZLckMxYaex
         MlkfTW3xSQHyPHYglfGeoOQ+UvfBYHWms/IhD3opdBGajv7EwKhX8PJA6B2mBeJVbWQw
         cOhQ==
X-Gm-Message-State: AFqh2kqCaWPBaeK7TyBN0Y90/GRVB79XIcesC560Dp8+SEd6rj8mBLbc
        LXCYm3CBxE61+78PwTpgGo44Bz8oRBSfBfOa
X-Google-Smtp-Source: AMrXdXsHeU9nVw0178kEB2vH44TQxiMs2VSyuryYqcPK2yvjxaeAconAxxWYgrWvNkoFX2uivvrGXw==
X-Received: by 2002:a05:6871:a6a5:b0:14c:62fb:61f7 with SMTP id wh37-20020a056871a6a500b0014c62fb61f7mr920705oab.45.1671639395514;
        Wed, 21 Dec 2022 08:16:35 -0800 (PST)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com. [209.85.222.175])
        by smtp.gmail.com with ESMTPSA id de36-20020a05620a372400b006cf19068261sm11177621qkb.116.2022.12.21.08.16.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 08:16:32 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id e6so7010089qkl.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Dec 2022 08:16:32 -0800 (PST)
X-Received: by 2002:a05:620a:674:b0:6ff:a7de:ce22 with SMTP id
 a20-20020a05620a067400b006ffa7dece22mr76603qkh.72.1671639392425; Wed, 21 Dec
 2022 08:16:32 -0800 (PST)
MIME-Version: 1.0
References: <20221220141743.813176-1-brauner@kernel.org>
In-Reply-To: <20221220141743.813176-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Dec 2022 08:16:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=winz9C7v81xSboTO6P0H8aF8wAjM5vK6n2pKO2FmS5d7A@mail.gmail.com>
Message-ID: <CAHk-=winz9C7v81xSboTO6P0H8aF8wAjM5vK6n2pKO2FmS5d7A@mail.gmail.com>
Subject: Re: [GIT PULL] vfsuid fix for v6.2-rc1
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>
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

On Tue, Dec 20, 2022 at 6:18 AM Christian Brauner <brauner@kernel.org> wrote:
>
> This moves the ima specific vfs{g,u}id_t comparison helpers out of the header
> and into the one file in ima where they are used. We shouldn't incentivize
> people to use them by placing them into the header. As discussed and suggested
> by Linus in [1] let's just define them locally in the one file in ima where
> they are used.
>
> Link: https://lore.kernel.org/lkml/CAHk-=wj+tqv2nyUZ5T5EwYWzDAAuhxQ+-DA2nC9yYOTUo5NOPg@mail.gmail.com [1]

That wasn't actually the correct link...

              Linus
