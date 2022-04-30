Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58184515A47
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Apr 2022 06:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240750AbiD3EPn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Apr 2022 00:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbiD3EPl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Apr 2022 00:15:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE0A2E6AC
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 21:12:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id i19so18668514eja.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Apr 2022 21:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Vsl9fBbDiZaNj5gkawt9MnMD0R9jBqp7SNnGBxr6Bo=;
        b=fLipD6xUhgO8jV+y4c0swUYG5hhtXPiB/Nh6jtom0twAhnwVnQib42QlQ1HwYVK7gu
         3vVFmQXUFvNeH1sixHUJNLvEWNh1YjtA1IqQGhAAWa1eC4YqSGzLA6JNQdVcEP9Q3WZ0
         XUPPRTdgO0/u4GfetBxBUFWiFk9ecEmyVGiQ2vwcK/IcMYFn5VTmHkS4rADnbmG2Gz04
         zuhAALSnn1lH5jVukibCv1Sb+WpzbOkaxTCicKRZ51CiKVOJZVdRAyKzxhEGjgfmlD3O
         WYfwPtEcUE+NdE8ZNfEAE6F6VjwDyhUTnsgpnZE5D1qTedCqOGbu9uD0z8QjQFLTaK5D
         Z4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Vsl9fBbDiZaNj5gkawt9MnMD0R9jBqp7SNnGBxr6Bo=;
        b=Le/7Y2HCd1oU4S3zC3l7mioNUXPnlVswKA33e168h/9vg50it6XpqIyZHyrly4CEFc
         n9sZHLLeMUIo9UIjJR0sBMoZhvn5ZENiKf4FVkYiQjFwYt+15N0GEsYaO2xUadimTWPK
         2OQnIHfM7mnJY7U4A0JViwNrHqNR1AlNNzPU/bn/HH5r6A7PTYhZlaS0VomMl54OqbCT
         jPp+a17uCQ9X+p4kV5QrqmFfp1IezqCic28Zovyc6PzKorVQ7/5pkJUI+c04/xvrYJjp
         Qiye2I/JkucZ9wxtRUjZBY7kscfr0kHBJduNQHTt3rM+TEU7p1UcHotO1PxZQkCIgNGf
         3y/Q==
X-Gm-Message-State: AOAM531rKbVd7So9dpTVIHrk/keGRjxPKYF2f18Bi+O6y2DYxrSpQm6y
        vvSY0OgV41HF9saNzZbtvFQpsMyliKQpr6PWXPOOAw5d4rE=
X-Google-Smtp-Source: ABdhPJzQAc1nST3/8DKHihvhQZYCpMzcWzgo+dHnb4uccNwZKWjoNTTMZyhp0hdkCCRI0cLops288zV728H4Wo4p+AY=
X-Received: by 2002:a17:907:6e25:b0:6f3:bb98:4dd2 with SMTP id
 sd37-20020a1709076e2500b006f3bb984dd2mr2361167ejc.265.1651291939217; Fri, 29
 Apr 2022 21:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220423032348.1475539-1-cccheng@synology.com> <877d7axvsp.fsf@mail.parknet.co.jp>
In-Reply-To: <877d7axvsp.fsf@mail.parknet.co.jp>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Sat, 30 Apr 2022 12:12:08 +0800
Message-ID: <CAHuHWtn8NWgds5X5SrNO=OEHmuzJ+675z7SVSEKb3jtp1=+p2A@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] fat: split fat_truncate_time() into separate functions
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, kernel@cccheng.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > +void fat_truncate_atime(struct msdos_sb_info *sbi, struct timespec64 *ts,
> > +                     struct timespec64 *atime)
> > +void fat_truncate_crtime(struct msdos_sb_info *sbi, struct timespec64 *ts,
> > +                      struct timespec64 *crtime)
> > +void fat_truncate_mtime(struct msdos_sb_info *sbi, struct timespec64 *ts,
> > +                     struct timespec64 *mtime)
>
> Small stuff and not strong opinion though, those are better to return
> timespec64, instead of taking pointer? Because we can
>
>         mtime = ctime = fat_truncate_mtime(sbi, &ts);

It's ok. I can change them to this style.

Thanks.
