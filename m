Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9181864BDE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 21:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237959AbiLMU12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 15:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbiLMU1E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:27:04 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F4725C5A
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 12:21:50 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id a16so810894qtw.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 12:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NbCY+fI/Ey+phMuttTwF7rYe8wV2xh87eNL3820Wga0=;
        b=K7Pol+pT5qqsHR2uFM19q6jdnDugRrXLSIGAfCJ6QK0S5IL2QZo0BWUiI/rh3+nnFZ
         DMN5o82+7dLHvUziq+k53MO8sTx2H0OdtYtwMRBOklT6DxJ1R6c9T4juXnN1uhZfTMkQ
         8ebBLut6ULAC68VuTlLhqVjWAOHQ9uRz1tfRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbCY+fI/Ey+phMuttTwF7rYe8wV2xh87eNL3820Wga0=;
        b=OxQYA6p/HzG4nQOHCm2epWMIfbMW4WXpbxSDVJyqVgeJdFNA9GF+nluV5mLECE/OQt
         7NQoPxjNu/NT3aiCQhIVUn/+lROvb4VT+e9CoZWj95IQak3wIt2F7QhJiWLF4RmTQUfw
         KtZIBRjhMkDkJM2S3OIYASn4hdDtdgTGgLi5QTpvNPPGewvH8QNLOhz1ZOEirb6yXkG0
         Oq2hZIGXvZ+hifrDV79kYkR7vjrQD+sTBymESAuvWiqIDa6RVs8yiI+UbyYsSF7s6A8R
         mI3K+p+ccb0425mKEEzilvpRqkqUbgIpIPfJZxiRzgXHLdHFdwAoxs7w7XgaEtjsJrWr
         ZW3A==
X-Gm-Message-State: ANoB5pllA+hgAt+3G0Joxa16M7B6CmJ0lSGnTLe9VVVyzydzv6Pcgue6
        RxnXGRzgw2pYu2mqRudqEJdfY66SaOXr5X6p
X-Google-Smtp-Source: AA0mqf61JiYf80mkEX/MrKUDMeFsT49pCGPaImhsUUuh2H/jgcu98jPzeJtWvHBPAysSnqFwDsHZkA==
X-Received: by 2002:ac8:4251:0:b0:3a8:1ef2:7c6b with SMTP id r17-20020ac84251000000b003a81ef27c6bmr7337760qtm.13.1670962909691;
        Tue, 13 Dec 2022 12:21:49 -0800 (PST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id l14-20020ac84cce000000b0038b684a1642sm456310qtv.32.2022.12.13.12.21.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 12:21:48 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id h16so858104qtu.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 12:21:48 -0800 (PST)
X-Received: by 2002:a05:622a:5a87:b0:3a5:47de:a214 with SMTP id
 fz7-20020a05622a5a8700b003a547dea214mr71129549qtb.304.1670962908425; Tue, 13
 Dec 2022 12:21:48 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wj+tqv2nyUZ5T5EwYWzDAAuhxQ+-DA2nC9yYOTUo5NOPg@mail.gmail.com>
 <20221213115427.286063-1-brauner@kernel.org>
In-Reply-To: <20221213115427.286063-1-brauner@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Dec 2022 12:21:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjgCDh98SKyPytCi0r=w+RMRD6wq-FV-HZ6iQGpbAvGcA@mail.gmail.com>
Message-ID: <CAHk-=wjgCDh98SKyPytCi0r=w+RMRD6wq-FV-HZ6iQGpbAvGcA@mail.gmail.com>
Subject: Re: [PATCH] mnt_idmapping: move ima-only helpers to ima
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org
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

On Tue, Dec 13, 2022 at 3:54 AM Christian Brauner <brauner@kernel.org> wrote:
>
> The vfs{g,u}id_{gt,lt}_* helpers are currently not needed outside of
> ima and we shouldn't incentivize people to use them by placing them into
> the header. Let's just define them locally in the one file in ima where
> they are used.

Thanks, LGTM.

                Linus
