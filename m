Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4289078CC90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 20:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbjH2S6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 14:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbjH2S6d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:58:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1781D7
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 11:58:30 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c3c8adb27so594842166b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 11:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693335509; x=1693940309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XptbQaF/TmqMzXqMFitdSA+1Ea5JhH7OV4FqHHSEswk=;
        b=MzOH9ntoAa4tre9LGFBbm0kW96r5U6m0Hbco+L7dUsgXWOvDQcwCIAeoavMJ8m0o8F
         ycLlIzAUfuv54nMVhIvc3ZWLr8U3ITmw2eFLzswjLhhs9NiFEzn6u9ynWuCobMDrtaqq
         9ZARfr6rUoH/mZ0FV3yft6KM0QmsdqImsO0Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693335509; x=1693940309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XptbQaF/TmqMzXqMFitdSA+1Ea5JhH7OV4FqHHSEswk=;
        b=kDu2iTlLXh5s8gOM1NO3yaO9w2PUFBguPhnKmWci2MgP3whOgbmlX0C6dOWl6N9N5i
         JfQ81U2vWpJ1iM7H6tOlsoHCYCYiCetuiP3ojKskjHc423DVNspOmSy4gdjYa5ylTWtr
         cTBAn9l62PZFKLOrZsiOWQbCIA3ZJyRq/epCiLsHF+6Q7fNuPri5jfagOoilmZC8XqzI
         Fl7qkUYdLBxRjFEKrcpODJNKdY2Uh3tzovrJ45Jy43q/vfawnKnktoPF5UR6ja2z4DhE
         xV5N9DqI0YgPI4hTJVh2utk3rbq7FZrTrPE0Uf7cViTelHF9mgkmFZauk2QqwedSrYfI
         q2aw==
X-Gm-Message-State: AOJu0YyV3e2HjXnxxaeDC1t5FsGlgz9jm/oR7iNby11eHuBqL95PYS0o
        ciEGEiOzA079diX93ikCPAre4dzn0mzPhikz/J2G3j8f
X-Google-Smtp-Source: AGHT+IGMbKKAyyGgCLqTyvASnxAHHsm4u06FL4HBbBAn5TXl0wveCxh4JmFLCwl6VRMTK2XK1m0E+w==
X-Received: by 2002:a17:907:a066:b0:9a2:200:b694 with SMTP id ia6-20020a170907a06600b009a20200b694mr12246537ejc.11.1693335509080;
        Tue, 29 Aug 2023 11:58:29 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709064b1000b00992e94bcfabsm6206985eju.167.2023.08.29.11.58.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 11:58:28 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-52a069edca6so6586488a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 11:58:28 -0700 (PDT)
X-Received: by 2002:a17:906:249:b0:9a1:cbe4:d033 with SMTP id
 9-20020a170906024900b009a1cbe4d033mr16078457ejl.53.1693335507850; Tue, 29 Aug
 2023 11:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230829103512.2245736-1-amir73il@gmail.com>
In-Reply-To: <20230829103512.2245736-1-amir73il@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Aug 2023 11:58:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVaYx8+S4KFK0h_PdvG_-WpTgUagTcmt70_13LbHas3g@mail.gmail.com>
Message-ID: <CAHk-=wiVaYx8+S4KFK0h_PdvG_-WpTgUagTcmt70_13LbHas3g@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 6.6
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
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

On Tue, 29 Aug 2023 at 03:35, Amir Goldstein <amir73il@gmail.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git overlayfs-next

Please send me a pull with signed tag, not a bare branch.

I know you can do that, since you've done that before...

               Linus
