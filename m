Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CFB3AC4B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 09:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhFRHMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 03:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFRHMr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:12:47 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBFCC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 00:10:39 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id j15so4437891vsf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 00:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/P+/ggAPSr24ov6nRiNVSQ5taQcSMFYDfL5d6r0zMg=;
        b=cdFtlqQOBKGRRFMuJt2T7KNnJNiiudCPxDc4hIMbbDI5Oj3VVixU0rnC4phphiKlD1
         joGTwcqMliL3/1JeB3JfPvapBDFboviCEHROvUBGIElJrC/LmTLCbrFL3AfkEZWFac/c
         qIQFl04jxZO/nql+K5hlwUGs1PkLeClmhxR7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/P+/ggAPSr24ov6nRiNVSQ5taQcSMFYDfL5d6r0zMg=;
        b=jDitpFu/3wep7JXsfd2tB0Ppiin2mOLtgJ3lMjuzfXm8aE1vICwsawvedpICNwL21Q
         Bo+e2dp+egzdbawhoLg8+PmXZK65VSKX9QK9Qtcx/qGaQxBKE5OwwT7PFt2ILQ0d+cHi
         fiqzVoRDUkPziYBGQ4EDp2aMS64rt8XiiZWkiS88s12crfdVV/b6KEzgO1kfmE/qM4gg
         DHAv94GoxEj7/nq0tDJ855/199SbaeP6Ki8ecLQxHMaGbteY4VZgZRx7GBuGegc+dRLw
         amh6NfNTYfXY8z8ioqpFmkYDnxlm5KTIXAuZYj51iY3SF0/pc0dsK0bC+doDdULunXUF
         XpRg==
X-Gm-Message-State: AOAM5319Nbdf71eMLJKn/xZRoQ9gYRz4Vy4XL7hy27enzP/tLCNSjHuw
        WhnMhvvy08mLyPnjpGDaijSAqY+v9FBjGtjlIXWlXw==
X-Google-Smtp-Source: ABdhPJx8zijHh9D1B4HhPILz7S2jPJn3Pd7CK8/a+MknvSjR6PEXM3OpFg59RKtSK/xic8OpU4FNFgsqh/RTIobqOT8=
X-Received: by 2002:a67:cd19:: with SMTP id u25mr1658215vsl.47.1624000238154;
 Fri, 18 Jun 2021 00:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210615064155.911-1-jzp0409@163.com>
In-Reply-To: <20210615064155.911-1-jzp0409@163.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Jun 2021 09:10:27 +0200
Message-ID: <CAJfpegsDP7C_8O5_pPKSwLz20-=JpEMzq7U+kwKGG9Fku==g3Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: set limit size
To:     jzp0409 <jzp0409@163.com>
Cc:     linux-fsdevel@vger.kernel.org,
        "edison.jiang" <jiangzhipeng@yulong.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 15 Jun 2021 at 08:41, jzp0409 <jzp0409@163.com> wrote:
>
> From: "edison.jiang" <jiangzhipeng@yulong.com>
>
> Android-R /sdcard mount FUSE filesystem type,
> use "dd" command to filli up /sdcard dir,
> Android will not boot normal,
> becase this system need at least 128M userspace.
>
> Test: open adb port,
>       adb shell "dd if=dev/zero of=sdcard/ae bs=1024000 count=xxx"
>
> Result: if not limit size,Android system  can not boot normal.

Without understanding the specifics, this does not look like a kernel
issue at all.

Why can't the fuse server do the limiting?

Thanks,
Miklos
