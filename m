Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C3740CD29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 21:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhIOT1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 15:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbhIOT1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 15:27:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F28C061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 12:26:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m3so6775529lfu.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6P9z1QCvAbv+k1VCp+BJZaSRLDdYfJBGVDJTbeRLGGs=;
        b=RYKWs9AXUkHcdaPvDhM9IiyTnFbvdFnNl9EWvWcjqUXDqr2f/hZEtv9pQp1KoMWL0A
         scCYipyvVNdf7qZYFLlaqanfBGdt7EngTZ41qZmuWN9jpiOJrrXi7I+JbbNaCtBplC5S
         jdU29T018/5bOfc5OAMr+9gI+XuB3QtFda90I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6P9z1QCvAbv+k1VCp+BJZaSRLDdYfJBGVDJTbeRLGGs=;
        b=ZrlvSkI+HvzM28XBDhq5y7To868vRTxW/u/G/di0i0o9NW3a/2vzUnzsLvhnTbrbqR
         dnlYsGj1S/h3GsOfOAoZVkNCmc08TLcVRdPv8WuNtj8o02ohUPfkl0pHdAjthV0WOb+2
         1b4vgwR8RQ/ylhGRBUPCf8aZdquvWKvcSXFJTnyO4rMgZPA8p0Xe3qegtc/lEW4983IV
         bjYBtxtqv3lmMSa9zf+OLw42qmv+KBfRAI07skM5SExRDvFk2cejNrEfzudyktNyPk3j
         +dBgMDbdaRxsAx92P5xY7O0oNHZyM1JqvfwD2PJQZpHPQQtst0RUXbKkjNrRrQgX6kag
         x4sg==
X-Gm-Message-State: AOAM530+9Gz+XcNlgQtMIzU1KIvAsiHCQ+oqeH5wVEZQnrHtWS97IX32
        rA235tYbcq1+ZOWiqE+3MHCk8DY1/kc+OCaW72c=
X-Google-Smtp-Source: ABdhPJyG6MtOk3+2/dBX4tUxvyEdwu6RCM6xlcHf0Ff+78zkec4tIKkgJs0GD/GXj22aKeu9qh3j6A==
X-Received: by 2002:a05:6512:1396:: with SMTP id p22mr1120773lfa.189.1631733992427;
        Wed, 15 Sep 2021 12:26:32 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id v138sm39500lfa.120.2021.09.15.12.26.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 12:26:31 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id i4so8626809lfv.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Sep 2021 12:26:31 -0700 (PDT)
X-Received: by 2002:a2e:7f1c:: with SMTP id a28mr1419825ljd.56.1631733991308;
 Wed, 15 Sep 2021 12:26:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210915162937.777002-1-axboe@kernel.dk> <CAHk-=wgtROzcks4cozeEYG33UU1Q3T4RM-k3kv-GqrdLKFMoLw@mail.gmail.com>
 <8c7c8aa0-9591-a50f-35ee-de0037df858a@kernel.dk>
In-Reply-To: <8c7c8aa0-9591-a50f-35ee-de0037df858a@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Sep 2021 12:26:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3dsQMK4y-EeMD1Zyod7=Sv68UqrND-GYgHXx6wNRawA@mail.gmail.com>
Message-ID: <CAHk-=wj3dsQMK4y-EeMD1Zyod7=Sv68UqrND-GYgHXx6wNRawA@mail.gmail.com>
Subject: Re: [PATCHSET v3 0/3] Add ability to save/restore iov_iter state
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 11:46 AM Jens Axboe <axboe@kernel.dk> wrote:
>
>    The usual tests
> do end up hitting the -EAGAIN path quite easily for certain device
> types, but not the short read/write.

No way to do something like "read in file to make sure it's cached,
then invalidate caches from position X with POSIX_FADV_DONTNEED, then
do a read that crosses that cached/uncached boundary"?

To at least verify that "partly synchronous, but partly punted to async" case?

Or were you talking about some other situation?

            Linus
