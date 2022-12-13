Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6E664ADF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 03:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbiLMC5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 21:57:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiLMC5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:57:18 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995C51B1E9
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 18:57:17 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id h10so9567412qvq.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 18:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tX77HP0QHLpr3cKm85qCHM8IpEChV7xCFgi6dZ8AJTc=;
        b=FWwrj6dBz0lP3LMXUBKtg+/REjLgScBPOVyHpMVxzQvBkXgGh3ilhnCzBHZohhHBIf
         N3SkVB2fFbKOw1hjQkeGnSJavm4o4syxXltU73rtEcOVE7jLTkYAhidILigVZloYXY1M
         N51CFmGr6cpPwmHbqgnLaUlepwWfaQe7MyicA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tX77HP0QHLpr3cKm85qCHM8IpEChV7xCFgi6dZ8AJTc=;
        b=av4z/a7RYwXtx5fB2fOzUPHbE+klVfVT7ZbIJFkg4ulWx8SEdv3PclTTw/S5UYn6oz
         +4kT5Vgtbl2Z3Uu08TByx863dZEhzmb1qvLO0pr3EEtD4bJVB9Q99QyuUdxoyjHCU1KW
         ta+rjm1CJwepxpwrhD1KzSQ1IIijDG4bieNH4qkc1uUE2mAU9YA17/mXdXsWK4jYD0fR
         RP/sjDB57EnXW8fbZjTxrp9HyCTpDg+rHVxCh2BoUbjtXNVzLsNbBGjH5SPQzZ3Lml59
         rX0eJUOs5Ri+rS5IP+h9128jTx/R5Hr5RbdGQwOx9/ZpjOf7eXiGIhOzRXDPifxRbCBQ
         VFeg==
X-Gm-Message-State: ANoB5pmEZxVZMA77ALtdo9RS2h0lsqnPNI4HmMo6rBVuqUblHRvf59C6
        LOimiCVc8BdB2ep9FlmPpBk3OpHe9FSY2/RU
X-Google-Smtp-Source: AA0mqf7IRuupdWaPqCTNgPCYTZ8H1GuXY4p8Q4wseOoWY3UIQ8BubzdVz0pl00ppnvFm5meBrMTN9Q==
X-Received: by 2002:ad4:4247:0:b0:4c7:7a6:a4d1 with SMTP id l7-20020ad44247000000b004c707a6a4d1mr27287172qvq.9.1670900236242;
        Mon, 12 Dec 2022 18:57:16 -0800 (PST)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com. [209.85.219.53])
        by smtp.gmail.com with ESMTPSA id h19-20020a05620a245300b006cebda00630sm7153279qkn.60.2022.12.12.18.57.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 18:57:15 -0800 (PST)
Received: by mail-qv1-f53.google.com with SMTP id s14so9559335qvo.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Dec 2022 18:57:15 -0800 (PST)
X-Received: by 2002:ad4:4101:0:b0:4b1:856b:4277 with SMTP id
 i1-20020ad44101000000b004b1856b4277mr70676848qvp.129.1670900235313; Mon, 12
 Dec 2022 18:57:15 -0800 (PST)
MIME-Version: 1.0
References: <20221212111919.98855-1-brauner@kernel.org>
In-Reply-To: <20221212111919.98855-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Dec 2022 18:56:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=witvjWrYOqbgURdeH7cv7bkVT5O2wd_HcoY6L-3_3yK8A@mail.gmail.com>
Message-ID: <CAHk-=witvjWrYOqbgURdeH7cv7bkVT5O2wd_HcoY6L-3_3yK8A@mail.gmail.com>
Subject: Re: [GIT PULL] acl updates for v6.2
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Dec 12, 2022 at 3:19 AM Christian Brauner <brauner@kernel.org> wrote:
>
>    For a long and detailed
> explanation for just some of the issues [1] provides a good summary.

There is no link [1].

> A few implementation details:
>
> * The series makes sure to retain exactly the same security and integrity module
>   permission checks. See [2] for annotated callchains.

There is no link [2].

This was an extensive changelog for my merge commit, so it's all fine
and I've pulled it, but it does look like some pieces were either
missing, or there was a bit of a cut-and-paste from previous
explanations without the links..

              Linus
