Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF55F569E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Oct 2022 16:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiJEOkY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Oct 2022 10:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiJEOkX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:40:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C6C30F78
        for <linux-fsdevel@vger.kernel.org>; Wed,  5 Oct 2022 07:40:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id l22so21827802edj.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Oct 2022 07:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1npcSRBJ7PO3bk52I4TiZZqyr2go37XvM6M7pRWaQTU=;
        b=ge2MeuQpUWKgYk1cf2md+tnifiDoAYsSdFbyramvwFt9I228RAJMOPPgT14IHn9v12
         6C1F5/zc8hHCGVyPobdykrXJ+hmwdW/U/FyZmUcPqy9sDk4EmuIFNu1jNRk6tQ+1cekk
         /soa3ZK3ItTEar/SWs3SDskDERwazsnM+c498=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1npcSRBJ7PO3bk52I4TiZZqyr2go37XvM6M7pRWaQTU=;
        b=dprweiFY9Cxy62pBBdVmV4I3vhPxseZojwRQbjKvc0Pqfavw2sNC+SeqhMacIxmJ1D
         QXlNeTCffFp3GoDTVSRInM7qB7S1hEEnyb491837b0fAm6WfxRrIoCMXuYC7sZzS1D+k
         RlRZXjuuXTzwt8YeXAcohvSFUkqjStICVZyfjCyz19sC1//m4KexzZknIsDBnJ2DqwVO
         mV9Fw+Ongxzte0AHANRZXxHKABICwLdNK/5QU4wyk+b2meKS2DRVEdb6DXCYw+Gt1/Ru
         PVMbUPXnXo+joprpVoXqgR3mRsoPPyhyiXfG23hl612eWR9YwsgNOwXLnPSsUpF0KR4T
         9wdQ==
X-Gm-Message-State: ACrzQf2rx53ZBqWB+9KHMstfXO1vZooI/8q+WwtwHmcEOPruOTNEb7yr
        I97TsPXZmer3hD1bRaPFVIt+vxUpqfrD/kPxVh+qmw==
X-Google-Smtp-Source: AMsMyM721GWiaiYF8Wds1lYCp6FGX4CmgL78gc2lSi2/xr5DmVQS4VGO0Opvb3UKTjBBqh1xL1cl8xTz7+glpMDh4Ew=
X-Received: by 2002:a50:fc0a:0:b0:458:73c0:7e04 with SMTP id
 i10-20020a50fc0a000000b0045873c07e04mr86310edr.270.1664980821039; Wed, 05 Oct
 2022 07:40:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221003123040.900827-1-amir73il@gmail.com> <20221003123040.900827-3-amir73il@gmail.com>
In-Reply-To: <20221003123040.900827-3-amir73il@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 5 Oct 2022 16:40:10 +0200
Message-ID: <CAJfpeguiGqdSZVwsx_MrLd2MLvLMAkz58NjCMHZehpWZCK5fFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] ovl: remove privs in ovl_fallocate()
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 3 Oct 2022 at 14:30, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Underlying fs doesn't remove privs because fallocate is called with
> privileged mounter credentials.
>
> This fixes some failure in fstests generic/683..687.
>
> Fixes: aab8848cee5e ("ovl: add ovl_fallocate()")
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Christian, please feel free to take these if you already have a bunch
of related patches.

Thanks,
Miklos
