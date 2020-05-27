Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055421E4012
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 13:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgE0L3z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 07:29:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgE0L3y (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 07:29:54 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B748208C3;
        Wed, 27 May 2020 11:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590578994;
        bh=tv2Km+njjIRyeTVL9eEojM928rYv6nfC4WtJm+JtuiI=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=LH33kOmAF5kk8gmaROPq2T1PO9AWcn0dS6sc9wnkwnvHXR5of1jCcDm2EZrucB1Fw
         TAriG0VFzKEpMdkkoEnvoWgqj8AoFUiFGS6Wpuowf+LD2BMlaQD4DC0+z7z0yewJ9z
         5UbkYLC1vs1PK3QH2Areo6ZogOd6XAmJwGOhRo5w=
Received: by mail-oo1-f50.google.com with SMTP id v3so274532oot.1;
        Wed, 27 May 2020 04:29:54 -0700 (PDT)
X-Gm-Message-State: AOAM5333IOkhghmpuI9Qyz22P8XRkjoEEMMrheEIlSLeubvJQXD3FQNG
        l03qUzVeEX/p8dw/bcsNuclA0NV3gqfLLzyv8Qo=
X-Google-Smtp-Source: ABdhPJxT/GGyKfZwUSiQU/29oQ2xsMJEn0EZtn3uGx9cTHxQWAcbn/bFOrcrmiEWjddGbsYK3GbAIu+KjlncEncWMYw=
X-Received: by 2002:a4a:7ac2:: with SMTP id a185mr2726927ooc.84.1590578993346;
 Wed, 27 May 2020 04:29:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:1d8:0:0:0:0:0 with HTTP; Wed, 27 May 2020 04:29:52 -0700 (PDT)
In-Reply-To: <TY1PR01MB15784E70CEACDA05F688AE6790B10@TY1PR01MB1578.jpnprd01.prod.outlook.com>
References: <CGME20200520075735epcas1p269372d222e25f3fd51b7979f5b7cdc61@epcas1p2.samsung.com>
 <20200520075641.32441-1-kohada.tetsuhiro@dc.mitsubishielectric.co.jp>
 <055a01d63306$82b13440$88139cc0$@samsung.com> <TY1PR01MB15784E70CEACDA05F688AE6790B10@TY1PR01MB1578.jpnprd01.prod.outlook.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 27 May 2020 20:29:52 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_oG6dc7CNiHszKmhabHd2zrN_VOaNYaWRPES=7hRu+pA@mail.gmail.com>
Message-ID: <CAKYAXd_oG6dc7CNiHszKmhabHd2zrN_VOaNYaWRPES=7hRu+pA@mail.gmail.com>
Subject: Re: [PATCH] exfat: optimize dir-cache
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.mitsubishielectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.mitsubishielectric.co.jp>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kohada.t2@gmail.com" <kohada.t2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

2020-05-27 17:00 GMT+09:00,
Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp
<Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>:
> Thank you for your comment.
>
>  >> +    for (i = 0; i < es->num_bh; i++) {
>  >> +            if (es->modified)
>  >> +                    exfat_update_bh(es->sb, es->bh[i], sync);
>  >
>  > Overall, it looks good to me.
>  > However, if "sync" is set, it looks better to return the result of
> exfat_update_bh().
>  > Of course, a tiny modification for exfat_update_bh() is also required.
>
>  I thought the same, while creating this patch.
>  However this patch has changed a lot and I didn't add any new error
> checking.
>  (So, the same behavior will occur even if an error occurs)
>
>  >> +struct exfat_dentry *exfat_get_dentry_cached(
>  >> +    struct exfat_entry_set_cache *es, int num) {
>  >> +    int off = es->start_off + num * DENTRY_SIZE;
>  >> +    struct buffer_head *bh = es->bh[EXFAT_B_TO_BLK(off, es->sb)];
>  >> +    char *p = bh->b_data + EXFAT_BLK_OFFSET(off, es->sb);
>  >
>  > In order to prevent illegal accesses to bh and dentries, it would be
> better to check validation for num and bh.
>
>  There is no new error checking for same reason as above.
>
>  I'll try to add error checking to this v2 patch.
>  Or is it better to add error checking in another patch?
The latter:)
Thanks!
>
> BR
> ---
> Kohada Tetsuhiro <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
