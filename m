Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F15F591D4A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Aug 2022 02:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbiHNAjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Aug 2022 20:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiHNAje (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Aug 2022 20:39:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF7B30F60
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Aug 2022 17:39:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id y13so7859250ejp.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Aug 2022 17:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wnDNfE9RbpplWt9K+hUgd+FEnAuo2qI606ZZ01nKEW8=;
        b=hb1eEUp6mJ8boevTR2EMZfGw1A9rJsvBnvgvb17p6GXmf+NJr+PDy+J+HVQJeneMQA
         PeRFK7sTKiFP2pDFdpeP/C4n/YKyFwICBvM2Rf6/1LedAcixAZ9sBxiDAEP6XlAAZt0f
         ByJeyGt3inviUVQGNC2l/oWD090cduU/aagmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wnDNfE9RbpplWt9K+hUgd+FEnAuo2qI606ZZ01nKEW8=;
        b=grgCXGt/5y9S8bYZxqpNpIOPYcaNIbpnXAJ+0C6myMf1SFqqDvMXEObp924rMAjcmT
         mqs9l6xqyx380/LQit7vvVoWWFQoX1Hb6paZSK7UVGrcmcFv4ctcP3JM9p21zVsMVrxd
         xUakWVEIhyYMVWM4z2gMfkRibzzjffOT6YsRWnkiJwiImSHiWbCVZHyFwkdBJOJKNoxO
         1HzLaCt15DRnIldtLAveCHZt0ZCostxeRiXM9BNBh1DS9wy89glos6KBotbYJb7hEanP
         v9Du/6nIXtKc1G3U8JFAaHzJB9CpaH5JMDdkcW5q0ulZtVQJHd1AY8nQJYKgWVFtuE7O
         iGCQ==
X-Gm-Message-State: ACgBeo2+7ehkMHvaizEY32780WulGS3AyvYseK5ZGUq9g0KUQ3I/4o0R
        Lk/aUUULlCKRvuvtXvU46Pg7XGsfNTir7BJX
X-Google-Smtp-Source: AA6agR5ed1lzeJ1pKb/PHn767zQgVUeUv6p3ZOgYvbTUNXAnK4mQYW1yp6rowP9STu9L5LBwmBCN+A==
X-Received: by 2002:a17:906:5a71:b0:730:aaa1:a9ec with SMTP id my49-20020a1709065a7100b00730aaa1a9ecmr6561338ejc.440.1660437572351;
        Sat, 13 Aug 2022 17:39:32 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id la13-20020a170907780d00b0072637b9c8c0sm2401128ejc.219.2022.08.13.17.39.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 17:39:32 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id j1so5081950wrw.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Aug 2022 17:39:31 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr5333411wru.193.1660437571585; Sat, 13
 Aug 2022 17:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <YvhAZYm1T4ni+y01@ZenIV>
In-Reply-To: <YvhAZYm1T4ni+y01@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Aug 2022 17:39:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whwCrp6Mok6fccY1uXQQEUCcyPSjNvsHYrnaaL90-85sw@mail.gmail.com>
Message-ID: <CAHk-=whwCrp6Mok6fccY1uXQQEUCcyPSjNvsHYrnaaL90-85sw@mail.gmail.com>
Subject: Re: [git pull] vfs.git #work.misc
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 13, 2022 at 5:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>       vfs: escape hash as well

That didn't parse at all for me - when talking about hashes in the
kernel, we basically never talk about the hash _character_ ('#'), and
your pull request message just made me go all "Whaa?"

Next time, can we agree to talk about either 'hash character' or just say '#'?

Just to avoid the confusion with all the normal hashing we do in the kernel.

            Linus
