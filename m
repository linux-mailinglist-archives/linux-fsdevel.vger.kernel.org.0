Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3567BFF57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Oct 2023 16:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjJJObt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Oct 2023 10:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjJJObs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:31:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FC7B8
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 07:31:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53829312d12so14671642a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Oct 2023 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696948305; x=1697553105; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cuS8bKZtMp63zZ8KV8AdM2I8l9o+/2U0omiUDSwjZzA=;
        b=YCEDKlFrUEYn0R47ccEFsW0KezlKX4tuQshYPo8htur4NUatmfTeddQ2fch62jAbaR
         3btDLOCm3sj5+qvLS4BLL+/pdhr7Yt3sMJoETg0MBOAu/OlyiBi3nJnXTcufVDEm3vul
         CImmMEAvor6GrFoGBz4oKEwcAeSTpgOSb8ufQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696948305; x=1697553105;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cuS8bKZtMp63zZ8KV8AdM2I8l9o+/2U0omiUDSwjZzA=;
        b=phss1rf+rs5XLz+lKNebkKJQu3oLgwFjP7riiHn6bIf+Nl7UsP5Ny0d8RIMfIuuPgU
         kyCZti0NU991d4BzYtQgE8iXiN7mwXcmf9Wg6MZLrDIQ4xAZnumQfWHiC2IWXevVIx02
         KHaKa5plKcmvJN0/UP0seM510vq5seOFXOW2rW2ueDafYnf/9YO/qH6t+qEQE5sWr9Cy
         9Q/lMLc3GXQAOaEsu35U9IHCCTORgUF5DkQ807FGMckr0ii9bnccAwaGS7oQNvTU0UC9
         eif4tFo15F5OsMpla+9RdJmM28JMX9ufYbJ+MYwzuiAWZB8lgkgi43FpM946wOkI21ja
         cQXw==
X-Gm-Message-State: AOJu0YxEXuIj1InQwx+HVeAN8RxvhSQUpq7DAVsR5vvIbc1MDZoZQxuD
        A7VKNyTTLIg3fxfXw/A5EBwUzVSV3HtxxSOIiNzOWcQFC69IBws2
X-Google-Smtp-Source: AGHT+IFOEG7SDwF5lIZuXl7UqKaXB8GF0D0LbrZkUBUftr14D+iKvJxSFr/qgCYy7Dh0V3Sk5KvHjwPfRa1Qrgop/C8=
X-Received: by 2002:a17:906:2dd3:b0:9b2:bdbb:f145 with SMTP id
 h19-20020a1709062dd300b009b2bdbbf145mr13891867eji.34.1696948305253; Tue, 10
 Oct 2023 07:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com>
 <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
 <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
 <CAOQ4uxgySnycfgqgNkZ83h5U4k-m4GF2bPvqgfFuWzerf2gHRQ@mail.gmail.com>
 <CAOQ4uxi_Kv+KLbDyT3GXbaPHySbyu6fqMaWGvmwqUbXDSQbOPA@mail.gmail.com>
 <CAJfpegvRBj8tRQnnQ-1doKctqM796xTv+S4C7Z-tcCSpibMAGw@mail.gmail.com>
 <CAOQ4uxjBA81pU_4H3t24zsC1uFCTx6SaGSWvcC5LOetmWNQ8yA@mail.gmail.com>
 <CAJfpegs1DB5qwobtTky2mtyCiFdhO_Au0cJVbkHQ4cjk_+B9=A@mail.gmail.com>
 <CAOQ4uxgpLvATavet1pYAV7e1DfaqEXnO4pfgqx37FY4-j0+Zzg@mail.gmail.com>
 <CAJfpegvS_KPprPCDCQ-HyWfaVoM7M2ioJivrKYNqy0P0GbZ1ww@mail.gmail.com>
 <CAOQ4uxhkcZ8Qf+n1Jr0R8_iGoi2Wj1-ZTQ4SNooryXzxxV_naw@mail.gmail.com>
 <CAJfpegstwnUSCX1vf2VsRqE_UqHuBegDnYmqt5LmXdR5CNLAVg@mail.gmail.com>
 <CAOQ4uxhu0RXf7Lf0zthfMv9vUzwKM3_FUdqeqANxqUsA5CRa7g@mail.gmail.com> <CAOQ4uxjQx3nBPuWiS0upV_q9Qe7xW=iJDG8Wyjq+rZfvWC3NWw@mail.gmail.com>
In-Reply-To: <CAOQ4uxjQx3nBPuWiS0upV_q9Qe7xW=iJDG8Wyjq+rZfvWC3NWw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 10 Oct 2023 16:31:33 +0200
Message-ID: <CAJfpegtLAxY+vf18Yht+NPztv+wO9S28wyJp9MB_=yuAOSbCDA@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 8 Oct 2023 at 19:53, Amir Goldstein <amir73il@gmail.com> wrote:

> Ok, posted your original suggestion for opt-in to fake path:
> https://lore.kernel.org/linux-fsdevel/20231007084433.1417887-1-amir73il@gmail.com/
>
> Now the problem is that on FUSE_DEV_IOC_BACKING_OPEN ioctl,
> the fake (fuse) path is not known.
>
> We can set the fake path on the first FOPEN_PASSTHROUGH response,
> but then the whole concept of a backing id that is not bound to a
> single file/inode
> becomes a bit fuzzy.
>
> One solution is to allocate a backing_file container per fuse file on
> FOPEN_PASSTHROUGH response.

Right.   How about the following idea:

 - mapping request is done with an O_PATH fd.
 - fuse_open() always opens a backing file (just like overlayfs)

The disadvantage is one more struct file (the third).  The advantage
is that the server doesn't have to care about open flags, hence the
mapping can always be per-inode.

Thanks,
Miklos
