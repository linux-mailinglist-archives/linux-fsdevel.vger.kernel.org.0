Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEDB347407
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 09:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbhCXI5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 04:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbhCXI5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:57:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F26EC0613DE
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 01:57:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k10so31569486ejg.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Mar 2021 01:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bGrFoUWO78DHinCnOm8Cd58bA9eS8nD5CEjgHc47CWU=;
        b=xkodvHDrCcm1mswly1za4QGf6ZYnOgQE5f2au/oESMx8I5h2ptJirNaU0N1uFCDLxE
         e0BNzu7HuM/ULiCLPYp76cMv3qtgpd3RgyVcP6sABo8hVer4WQHhq7spzcrjK6etWmI+
         KqPmMymhqALvhT5mQgHHVySBkZ8GCjT9yMsA6PsPIGc4csqsTNrPEEvItlctaD1of15B
         k0NeSlSpm2mAUYeoie9NR1PAK0wxuuLaK7bzAW3WrpXPfvpaHm1Eg7+JDDxseYG6hjVh
         4jL3ifJ2S3VxMTJIS4uem4cC9e7gaOiVGYtsFCCtnukKZlol9aIAnE6nsYIjG/sfjgxM
         lc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bGrFoUWO78DHinCnOm8Cd58bA9eS8nD5CEjgHc47CWU=;
        b=T3mLEmiF1uINsvi4qZkVuGCrHBsOVo+IqU55iFH+1UBgwacMJq/yYXaBPZFqlCaxUm
         n5jY9lMbon2Lhtvfc9ATbowKB5UhJwxgDHJXoJl8PQRwG0fSIbz32TTzyH9ehlZGQiKR
         As0jW870mSIXvwyWDdrPOHfU5yLB1bmnoTMI+hxC2yfreEZ2O/8fowlC/do8EvYdTfXo
         LCqjYClGd6+EAkZ9O4UoycO5pi5QzrBMfwyU+8iUo/if6BgZkw24kaLokaU2CGZ3sRjz
         cFgPxYfmBNHFbYFbv6XdtwLn93qqpvl1dErptTrL0zIK1zpwU23kw1SFrojNULwE2hM5
         TRwA==
X-Gm-Message-State: AOAM531ZDRvDKhoJQDWAp+HMy5KmY31TKLDZWOu0/iRzbnDQ2a7ycu9x
        ck8GqqHg7TAQXRgrPKPKF5r33ehPwA/JvH+zhmot
X-Google-Smtp-Source: ABdhPJy1amFIC8PhAf53lebi6UrN3nLJlRvNr8nkHWtZ1LH1vCCA+ReclSL3bXScIhTgASF5pFEXwnHMDawdZcwejYQ=
X-Received: by 2002:a17:907:a042:: with SMTP id gz2mr2474707ejc.174.1616576229395;
 Wed, 24 Mar 2021 01:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210315053721.189-1-xieyongji@bytedance.com> <20210315053721.189-11-xieyongji@bytedance.com>
 <9a2835b1-1f0e-5646-6c77-524e6ccdc613@redhat.com>
In-Reply-To: <9a2835b1-1f0e-5646-6c77-524e6ccdc613@redhat.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 24 Mar 2021 16:56:58 +0800
Message-ID: <CACycT3uosBGNwTEaW7h8GdDvHjoXWR1Se_kszQJ5Vubjp5C8MA@mail.gmail.com>
Subject: Re: Re: [PATCH v5 10/11] vduse: Add config interrupt support
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Parav Pandit <parav@nvidia.com>, Bob Liu <bob.liu@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, bcrl@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 12:45 PM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2021/3/15 =E4=B8=8B=E5=8D=881:37, Xie Yongji =E5=86=99=E9=81=93=
:
> > This patch introduces a new ioctl VDUSE_INJECT_CONFIG_IRQ
> > to support injecting config interrupt.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
>
> I suggest to squash this into path 9.
>

Will do it in v6.

Thanks,
Yongji
