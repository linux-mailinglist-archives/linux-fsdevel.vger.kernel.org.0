Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE16B54CB75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 16:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiFOOhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 10:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiFOOhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:37:38 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93ED6EB7
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 07:37:37 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-31332df12a6so63372307b3.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jun 2022 07:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=1L875HB2891PfPTiRfpgrWU9o4RsmbqFGyMf6TOpDh0=;
        b=h0L8hDbAx91p6ZQXR4l3DL1A8baHYfLLtxoVXYfATxbBT2ijyC87JaNnnLcmlm8UME
         NVLljotF5JTx1PHOJ8nSxBRr+gEESpMdpMrRwlRrgvqr3K691BBjTUVE+PqrvBYSfsJ0
         gd+3YJD+DuDeMOJ618KhaHlhH38m9CmbctHixAaWx3eG2k3Nf48XwdqumNuNvv4CuUDd
         N4F0KTruNcVUgFS/0BgkJlkMdZw1JlaC/ZmUJbkaTBCr/tWVXbmrVIjiCoWnDoJO4oVv
         +wvGsLMCy/UJFGt7fmOxffUMgCvekpcBdQpaRS49LC1xFZU+3jJKA/dUqFeJAerWOXmK
         tjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=1L875HB2891PfPTiRfpgrWU9o4RsmbqFGyMf6TOpDh0=;
        b=vYiHjbYOwxLFvnHc0i6pGK7zvHSiMDdnKkEcCp9GT/4C2OwzYcy0f1a5bUrptsod6t
         PStz6yQNDfGs/ad6V7ipgrCZRb4OjCm0xo/5Je8CocbMKqzLq9HqhvN+aRvAKccfden9
         nj3qw1J3cQ9hocoPCeiLVgkD9iYKqjpvuPpaxmfrTgFzPjXOypyaCIQG5L2cTQG6Gd5K
         KzYTtCRMR0QjUKhtzEpwSzxKxpBK3G5iffxh5Be2tzDAuhye0AJo4Kw2WZ6vEvT2YjkD
         anNd7uTkzxEZqWW1vwtpN7K1eMiU6Pp/tZHQ9h06WrSIhrWNgNmxcfjI4IBFJRZ21LUA
         k4KA==
X-Gm-Message-State: AJIora8MMbHEsO2KpoLddjDC1he3LtwiGdNyoPBI1Lc0BKgeIJcFJI9R
        /CTDrMMohH2ONUcshJ0sMNoo3Vf3MVqvt31mKbca+rTj
X-Google-Smtp-Source: AGRyM1uIXkL5lRVUyhlpHHnpEgPCEPJ56jkDqNPJIXnMunrzVmL/NNIkHJDyaSiB9eqa1yszcjyP4hOIlig1c8cvodk=
X-Received: by 2002:a0d:e601:0:b0:313:ffa6:2f6e with SMTP id
 p1-20020a0de601000000b00313ffa62f6emr11892803ywe.420.1655303856637; Wed, 15
 Jun 2022 07:37:36 -0700 (PDT)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 15 Jun 2022 20:07:25 +0530
Message-ID: <CAOuPNLgroO6GsVwmbUhegrWJqp=a==LxNB11CvYeCrv5=3MXSA@mail.gmail.com>
Subject: Reserving a dedicated space inside UBI volume
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@free-electrons.com,
        marek.vasut@gmail.com, Richard Weinberger <richard@nod.at>,
        cyrille.pitchen@wedev4u.fr
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

We have a requirement where we need to reserve a space (say 100MB,
just like RAM) for a specific folder inside a UBI partition/volume.
This space will be used for a specific purpose only and  not
accessible by others.
Something like the reserved area for bad block management.

Is there a way to achieve this from the user space application at runtime ?

One option is to create a dedicated volume and operate, but we are
looking for a reserve-folder within the existing ubi volume itself (if
possible).

Regards,
Pintu
