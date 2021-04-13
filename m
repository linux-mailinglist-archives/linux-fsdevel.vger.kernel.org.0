Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C460835DA40
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 10:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243029AbhDMIn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 04:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242957AbhDMIn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 04:43:58 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF837C061756
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Apr 2021 01:43:38 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id f4so5068241uad.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Apr 2021 01:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CJTfxw+7T+FVtf/ZtoDIPSgRwAfJ87Xex1gXOvrotkg=;
        b=KPTes4bLsDcgFD2oHlgu+gfedwOnhP/gsDS/PcoU5t7cE8/zPxqpf7pmG2PCWiAosD
         UPs+6nVeZnJWAZtrphx8oAtjP/UeMJ7+QS1Arun3o+sFaFce8Q4G8YMEq9qvFnATaWmr
         cBEZb9zhn1FDM2dbKOiz5gimWqISrkY7SOQDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CJTfxw+7T+FVtf/ZtoDIPSgRwAfJ87Xex1gXOvrotkg=;
        b=dJs8VWO1ysODKOPjZIIZvAUn79o/lZIoewX1jgzwSN0eB7PfdgVzz/vMPfwJeIcPbe
         884jBgnFS8FVfJ2l7z0nl9AFUJPyPoV+WsqOoSh578gh8jqHdyjLPR3hmLKJ7ACLwa4r
         ucOpFKEfVjeVpCf7GQpOidqlP8DVsdaGaOsG2+Om5BvNl6qoOQFkUhPt763ouoioB46d
         6c4MCqoSYhDV7wNXwjtkYQvEgO/D3x/HVfdI6rwzXox5mzPXmqbybkvV/uLiKAvejYWk
         Eliwy0AJtatG+IzZjdlyhhkRWx9ybxI5QZV7y280UmQ5+RZbvOBiZ9mk7uB1R8l51vkJ
         cYLA==
X-Gm-Message-State: AOAM530prCd3yUSEKQ+O4f1gRNDhmxs0T7nnnC+qhJVLtMwT+H433Fud
        0G7sO2uwNAEne80SeeJd2tbBlEDXpGadRgxMirmzdQ==
X-Google-Smtp-Source: ABdhPJxf/jIC/3VGIYg9aumcXX/Hfbj7+H0VyKvsphMSy5GaTiEb+ozMw2EVHFtGRzrysJV/3wpSrOnSVlq2XCpzuzQ=
X-Received: by 2002:ab0:596f:: with SMTP id o44mr22269909uad.8.1618303417875;
 Tue, 13 Apr 2021 01:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201113065555.147276-1-cgxu519@mykernel.net> <20201113065555.147276-8-cgxu519@mykernel.net>
 <CAJfpegtpD5012YQsmFEbkj__x52N4QrV0jSi=7iZtREqVf3tcA@mail.gmail.com> <178c901d7ad.fdc7d65c21509.6849935952336944935@mykernel.net>
In-Reply-To: <178c901d7ad.fdc7d65c21509.6849935952336944935@mykernel.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 13 Apr 2021 10:43:27 +0200
Message-ID: <CAJfpegvM86YEzvFCdHm4a0h3_yNeqfS94c5hArQj7=fgaBARmA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 7/9] ovl: cache dirty overlayfs' inode
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 13, 2021 at 4:14 AM Chengguang Xu <cgxu519@mykernel.net> wrote:
>
>  ---- =E5=9C=A8 =E6=98=9F=E6=9C=9F=E4=BA=94, 2021-04-09 21:50:35 Miklos S=
zeredi <miklos@szeredi.hu> =E6=92=B0=E5=86=99 ----
>  > On Fri, Nov 13, 2020 at 7:57 AM Chengguang Xu <cgxu519@mykernel.net> w=
rote:
>  > >
>  > > Now drop overlayfs' inode will sync dirty data,
>  > > so we change to only drop clean inode.
>  >
>  > I don't understand what happens here.  Please add more explanation.
>
> In iput_final(), clean overlayfs inode will directly drop as the same as =
before,
> dirty overlayfs inode will keep in the cache to wait writeback to sync di=
rty data
> and then add to lru list to wait reclaim.
>
> The purpose of doing this is to keep compatible behavior with original on=
e,
> because without this series, dropping overlayfs inode will not trigger sy=
ncing
> underlying dirty inode.

I get it now.  Can you please update the patch header with this description=
?

Thanks,
Miklos
