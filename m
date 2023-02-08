Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A880868F222
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 16:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjBHPir (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 10:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjBHPiq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:38:46 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3454615D
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Feb 2023 07:38:45 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso1753797wms.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Feb 2023 07:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ldS/9lgbAryUlzaEqo027FaU3ababbmuo6baFKv9sM=;
        b=GMKcvLbWgYYOV8D3gsJ1NLFPsx/+rb4QbvXLP5DPdEX/7OtnyJYn0eSEvrkIK19zWo
         BjCy3lR5nl3V/D+qx2u/4QrQu2ABYM65YPAlg3ZH+V2JzoEt7pgPNZH7lJ1yMN2zh5qx
         oiCs2/g3lnxsmmeEgvnZSDKkH0EEM32NJxdQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ldS/9lgbAryUlzaEqo027FaU3ababbmuo6baFKv9sM=;
        b=CVwmX8ClONRyoeT9X1dPc9If+zuI+7GvUZ4ZZ7zt2BAa6+bTmzibsqq/HvNwQpui9d
         aP6LDiIe9zVD4BWVY2zLOzR0hDH7e6B8Ti8WztZMdPWSpSBsciWcrQVDcgI5fCMGfAU1
         60zKUjo8gdIvaAMBXGwltwLKDK0jnY5fhZ1m0F8kOVdHiqDR/lf4YH3fnNY4E7mauJMO
         eRAY58V9VJQ+Wjhm6oueIx8j9kzF6rkiUxmd/PWcLjsW6aOsB+oCpe0NmPyxlLMpHG4x
         pkYFuqT+yi1iWQdNMF4EF5DUXj3lMDZ1C4NSk/LayzrZPKJyfqg+8oytavkktcxRj2oC
         oSFQ==
X-Gm-Message-State: AO0yUKWh+tgDnr8w8ff0mF00yiWEVb5FewtRu4qQzQ1iysKkNYG8LwTp
        t5jgZZz1r+4lK9TGk8jC+lz0Ckgt4DHOdIv2ozHQ9Q==
X-Google-Smtp-Source: AK7set9bB3auN/O9gFWEgHuGzRP0+xrQNktQIfaDcM0Z+PDa5lOxoJlikvYNWeD3zONudhoTuW63jw==
X-Received: by 2002:a05:600c:4483:b0:3d3:49db:9b25 with SMTP id e3-20020a05600c448300b003d349db9b25mr7036896wmo.26.1675870723529;
        Wed, 08 Feb 2023 07:38:43 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c1c1700b003dc1a525f22sm2314237wms.25.2023.02.08.07.38.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 07:38:42 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id q19so21036988edd.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Feb 2023 07:38:42 -0800 (PST)
X-Received: by 2002:a50:d0db:0:b0:4a2:6562:f664 with SMTP id
 g27-20020a50d0db000000b004a26562f664mr1769251edf.5.1675870722462; Wed, 08 Feb
 2023 07:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20230208062107.199831-1-ebiggers@kernel.org>
In-Reply-To: <20230208062107.199831-1-ebiggers@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Feb 2023 07:38:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=5AqsG_1Td_bOMpFE8odKhsT9Mb3s4Wp+qq_X1Z6gqQ@mail.gmail.com>
Message-ID: <CAHk-=wg=5AqsG_1Td_bOMpFE8odKhsT9Mb3s4Wp+qq_X1Z6gqQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add the test_dummy_encryption key on-demand
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
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

On Tue, Feb 7, 2023 at 10:21 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> I was going back and forth between this solution and instead having ext4
> and f2fs call fscrypt_destroy_keyring() on ->fill_super failure.  (Or
> using Linus's suggestion of adding the test dummy key as the very last
> step of ->fill_super.)  It does seem ideal to add the key at mount time,
> but I ended up going with this solution instead because it reduces the
> number of things the individual filesystems have to handle.

Well, the diffstat certainly looks nice:

>  8 files changed, 34 insertions(+), 51 deletions(-)

with that

>  fs/super.c                  |  1 -

removing the offending line that made Dan's static detection tool so
unhappy, so this all looks lovely to me.

Thanks,
             Linus
