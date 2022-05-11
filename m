Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE579522FB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 11:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiEKJn4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 05:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244026AbiEKJmJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 05:42:09 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D817A26555
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 02:41:12 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id m20so2830166ejj.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 02:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m0rKCtYWChKn67KUygwJk8Gq46fVsoVyqlFOLEWYRWU=;
        b=TeWleuC25TI3U2UqoBqmnhTyrGAxfabSM2EnxHHqcAMjy/gpq8WgbWvjWWzenqfJvI
         KhChVKX5sRQfrmarq20QMbTDOWenRR6knwUO/Zz+ESlF9djucufVKCCkjHf+tY9/d5Nq
         7T8MhctInyM0LXJGblFoBhch7p9zgThu5sLEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m0rKCtYWChKn67KUygwJk8Gq46fVsoVyqlFOLEWYRWU=;
        b=ecQrCG0S9UJ+RDePT1wXU9kO4UWw8mSrMSK08b1q2c8T4+h2kJ7hdWT8npbqilPNlI
         OHIlW3xAp1sHkjUHZnypCra2RKLqFqkj9rS8jj4lfFJH6Sxf3raAQDnw0YpehpwGQyig
         yfW416OrOzAATgSnTuiUhNxp7wT8UGlyNpSoJRTrRt7313NPJEPqqsPyyKG5SFC+OQjW
         OVfsZuf2Ovpomqeab6cFvVsY0LkWszhb4SsWCYVkvcCku0FsR5Dg6VYBalaORLslXs4f
         838QnG2Ti6DR3bGozB99BsuqDDmHD1ga49ZTVVaAlg/FIPd+xHvv+HhyKc4heKcBqVMK
         gVfQ==
X-Gm-Message-State: AOAM533ylxbwFQOGPLEpEouOCMGegCL8q3Oaa4WZ6GtqYhR4FZoN+pW2
        NcxCpStArJCoZTYHq0/pTcPJFXt9RgwDHZEqGcY/Uw==
X-Google-Smtp-Source: ABdhPJzEs5wOirJoUjRohPu2Nu5O2fRdKW703nAvdWb0P4NRYWnqd2+VtbPGyOZktRLlt3x5BXJrdDXXwJI6pWqUb2U=
X-Received: by 2002:a17:906:8982:b0:6f3:95f4:4adf with SMTP id
 gg2-20020a170906898200b006f395f44adfmr23250807ejc.524.1652262070760; Wed, 11
 May 2022 02:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220502102521.22875-1-dharamhans87@gmail.com>
 <YnLRnR3Xqu0cYPdb@redhat.com> <CACUYsyEsRph+iFC_fj3F6Ceqhq7NCTuFPH3up8R6C+_bGHktZg@mail.gmail.com>
 <YnPI6f2fRZUXbCFP@redhat.com> <882fbf7f-a56b-1e82-a158-9e2186ec7c4c@ddn.com> <YnQsizX5Q1sMnlI2@redhat.com>
In-Reply-To: <YnQsizX5Q1sMnlI2@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 11 May 2022 11:40:59 +0200
Message-ID: <CAJfpegseGaWHkjdQj7XiR=TQNFpPZzDF_rTXces2oRz=x0N7OA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] FUSE: Implement atomic lookup + open/create
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Bernd Schubert <bschubert@ddn.com>,
        Dharmendra Hans <dharamhans87@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 5 May 2022 at 21:59, Vivek Goyal <vgoyal@redhat.com> wrote:

> Oh, I have no issues with the intent. I will like to see cut in network
> traffic too (if we can do this without introducing problems). My primary
> interest is that this kind of change should benefit virtiofs as well.

One issue with that appears to be checking permissions.   AFAIU this
patchset only enables the optimization if default_permissions is
turned off (i.e. all permission checking is done by the server).  But
virtiofs uses the default_permissions model.

I'm not quite sure about this limitation, guessing that it's related
to the fact that the permissions may be stale at the time of checking?

Thanks,
Miklos
