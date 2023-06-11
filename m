Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A03072B249
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 16:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjFKOXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 10:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbjFKOXp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 10:23:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0996CE66
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jun 2023 07:23:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977c89c47bdso631046166b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 11 Jun 2023 07:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686493420; x=1689085420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FNpHb/rK3DJOtlxm059dJYOe2BFwARWc9T2ggd4nxq4=;
        b=IcM4sLIqORrdt7p8vF0Mtw75TENnEd882Xv2BSvVn1E/VBhkjbnMjdst+2o2jc3+QB
         qDxO+jy2hUZ43suYtmm5HQnGu94mevUc9Bt3V85IreX8Gv7hptK2mA9JBmkFoJhnPBHm
         chwNiTG5BHP2CqdsLNgjYn+pri1eWpds/qUnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686493420; x=1689085420;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNpHb/rK3DJOtlxm059dJYOe2BFwARWc9T2ggd4nxq4=;
        b=DoUTywPvyV4X1IV24y3625ED03RN2ugNREX8Q+v7nc+OAuU63DT0NoFc8TkKdWp0aD
         R/CrGbB/6G6kDxeavwZlXY/snAemxyi+Xf8eru0Bf2qD9qq0piN+sysUtNdU22V3vIZf
         86ZXjKhpdnbrhiED+ee3uDCemSB1Lqwpz0MmlZpG7VSVvFdfFpWBCsyXm9seoXaWyHVt
         0qYZP0fpeCZcVVFRBH2TOHKpwTwnzaKiyAzJg7SL5S7m+Ws0TqilnskuCdkKeo6MFqyu
         6Eo/4j1jYz8aF5wHdY4oWedyC+CtFvoEISX55KMlAQhYz441yQy1cXlFyvemteqAtM/6
         hVSQ==
X-Gm-Message-State: AC+VfDzMwmxozxGz6eAqkxVmSYK6LvCGZJ1WDULFbH+shqLoYayFzTEv
        r3TN5KlDy92yt3e+0gkP7kljmTZdrfCXtv01GTHOWg==
X-Google-Smtp-Source: ACHHUZ68aBPq1+pd8t7jJX+EikgTxFy44YswKZMA9jVNwx2/ny9mH7rXqoBjmsz++ePauCw4EoCy7xdPcGN+yGjyQIA=
X-Received: by 2002:a17:907:7f28:b0:97e:32e:c1e with SMTP id
 qf40-20020a1709077f2800b0097e032e0c1emr5284630ejc.55.1686493420389; Sun, 11
 Jun 2023 07:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230611132732.1502040-1-amir73il@gmail.com>
In-Reply-To: <20230611132732.1502040-1-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Sun, 11 Jun 2023 16:23:29 +0200
Message-ID: <CAJfpegugmTqJ5rWycxxeQpVBmGTxSHucnQjP7ZwT3K3jMXNcnA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Handle notifications on overlayfs fake path files
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 11 Jun 2023 at 15:27, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Miklos,
>
> The first solution that we discussed for removing FMODE_NONOTIFY
> from overlayfs real files using file_fake container got complicated.
>
> This alternative solution is less intrusive to vfs and all the vfs
> code should remian unaffected expect for the special fsnotify case
> that we want to fix.
>
> Thanks,
> Amir.
>
> Changes since v1:
> - Drop the file_fake container

Why?

Thanks,
Miklos
