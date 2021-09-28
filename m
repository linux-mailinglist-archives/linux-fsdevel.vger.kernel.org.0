Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055DA41A98E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 09:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbhI1HTO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 03:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239062AbhI1HTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:19:14 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E07C061740
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 00:17:35 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id 66so16985875vsd.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Sep 2021 00:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5VZceE/dQmU6bLvl6P5d+DLar0Sw2Dsq3q/ylCWAUVI=;
        b=DIATSXRBLGAqa+xswEPNBQnleXtV60+haTfFNrEmgJvJaoAll70jM44RaWWm8u0qYt
         82EyP2C1R1uHBrniA+rW8Rbfsf5K2erg6ezXvTLWSqE0CEqXv+12jhh+0+1EeEL8pjIh
         OTL3Ixk0I9sDGkcH3RFolHamWqvWcV3ocipko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5VZceE/dQmU6bLvl6P5d+DLar0Sw2Dsq3q/ylCWAUVI=;
        b=bESO1X8OVyUa7FHAnfgxbyyGDgINJOgMLBH8BQONZIHK6azCZgqBvkfJ190IHIxL9V
         ssT+O20Zks2GT3dpdraQjxyedIrCx+FW03Hrn2FgZRPw4ikHGVxinXfaYru5YX0N9x5b
         l5luq6fFlF3AFtJ1bQ/HjeeuMk6ewyzUSpHE+gOl/mxHdcd+07T72jJNSFcCTqIo98SD
         sI9ERlC59wCCDT8sCvhcUAO6H/PwnCiKSGNLyysfvjm65CRtAbiTZPiIKvM2KG6wEks9
         dVTy3HV1zfLGWVGVTGiDyCb6NZVzmRn8+yhytEM2sGiwSoDE+M544Tyduf9wHhRC7lOT
         i4jg==
X-Gm-Message-State: AOAM531ceaUscApbcmk+j+wmFAYBlnYKuwbHtc4hBgoMaDTsM4KRqg2T
        xirUX1UYYMGkRFasURMUC9KsyPx1J11R1NwW/ggMeA==
X-Google-Smtp-Source: ABdhPJztRVRW3/QmckVYl4Qyku7NmhVkrLWgQRHozwyB7+hutqJ0fbJjiOdFJW0pTwJfle0znxSG5gl3KIkHsykSZyo=
X-Received: by 2002:a05:6102:3c3:: with SMTP id n3mr3785865vsq.19.1632813454116;
 Tue, 28 Sep 2021 00:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <9ef909de-1854-b4be-d272-2b4cda52329f@oppo.com>
 <20210922072326.3538-1-huangjianan@oppo.com> <e42a183f-274c-425f-2012-3ff0003e1fcb@139.com>
 <919e929d-6af7-b729-9fd2-954cd1e52999@oppo.com> <314324e7-02d7-dc43-b270-fb8117953549@139.com>
 <CAJfpegs_T5BQ+e79T=1fqTScjfaOyAftykmzK6=hdS=WhVvWsg@mail.gmail.com>
 <YVGRMoRTH4oJpxWZ@miu.piliscsaba.redhat.com> <97977a2c-28d5-1324-fb1e-3e23ab4b1340@oppo.com>
In-Reply-To: <97977a2c-28d5-1324-fb1e-3e23ab4b1340@oppo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 28 Sep 2021 09:17:23 +0200
Message-ID: <CAJfpegsim-qtM4yaYdWo9P+QOP4UD_NrFTKADQky-HwOR=SPyQ@mail.gmail.com>
Subject: Re: [PATCH v3] ovl: fix null pointer when filesystemdoesn'tsupportdirect
 IO
To:     Huang Jianan <huangjianan@oppo.com>
Cc:     Chengguang Xu <cgxu519@139.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        guoweichao@oppo.com, yh@oppo.com, zhangshiming@oppo.com,
        guanyuwei@oppo.com, jnhuang95@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 28 Sept 2021 at 09:01, Huang Jianan <huangjianan@oppo.com> wrote:
>
> =E5=9C=A8 2021/9/27 17:38, Miklos Szeredi =E5=86=99=E9=81=93:
> > On Wed, Sep 22, 2021 at 04:00:47PM +0200, Miklos Szeredi wrote:
> >
> >> First let's fix the oops: ovl_read_iter()/ovl_write_iter() must check
> >> real file's ->direct_IO if IOCB_DIRECT is set in iocb->ki_flags and
> >> return -EINVAL if not.
> > And here's that fix.  Please test.
>
> This patch can fix the oops.
>
> Tested-by: Huang Jianan <huangjianan@oppo.com>

Thanks for testing!

Miklos
