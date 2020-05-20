Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003EE1DB327
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 14:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgETM0w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 08:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETM0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 08:26:52 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5707C061A0E
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 05:26:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id bs4so2868167edb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 May 2020 05:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=McMZFOEJApCVKvLlRF0WXyD2whtx730/Zkke9IfZqYs=;
        b=W4giJ65Y6zhy5gAoGGYOAnUIhr7wiJywxZbW2FgtF2XmiGYw6j7mF/AX9rpxkx0OZz
         ktMhNgoPD8mIdRuzBfYiWZ/wrZ1Vz5lEV3m48sQ249eEm9dT+exPl1oZoPeQjHTd6yML
         YLQFAhu0bXuYxsENYcTRo2yi8GY0HvWrDHMc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=McMZFOEJApCVKvLlRF0WXyD2whtx730/Zkke9IfZqYs=;
        b=m+QeEOf2VwOb8BrJ2Lz/1txvzmiOh//kK1WdNrLwUEekooOJYMcOaBsCr1YW7qAHlF
         gNRMV+B8WZ2NyHiK1obXQCxt9wfCJsFFZ0AiQ73u/rTslSQJJ7ay5lCcLG5bCUx+K1T8
         zKwZYgtDAWHXBDuz104FGnlCnzbHavZgy0RixBByfEQjGRo3mmesU3Qom4yB7f79hgtE
         hmLSgdqAE0nwxL4A5up9GHJYK3970wddGFgnPqiJU3+bQJF1XW8862xCZ0XQ5ZmV/Ggn
         RJbTGPGbPYGtbg8Q5OXyrqQyl7OCeWaH+iyWgXox3q1y3N/MOpKSXe/LFeow+PpFj0SK
         TlYA==
X-Gm-Message-State: AOAM531pC3Nj7XR3sTn6dUHQRKNMi/i2U1FUpgvtMBoBTtQrjlGnb29O
        f7Fdu/a/AhgUi5N36YXaiHI+vxxAc07QgLrYiZojKA==
X-Google-Smtp-Source: ABdhPJwP6mMja9Zs3GE104+EzGCultDkU2pSZQWhOYxGLN6zP2cc7JCzbXLJZlhcVNqruXUfsVTbGd0jiVZFJEdGtMU=
X-Received: by 2002:a05:6402:b06:: with SMTP id bm6mr3285872edb.17.1589977609839;
 Wed, 20 May 2020 05:26:49 -0700 (PDT)
MIME-Version: 1.0
References: <846ae13f-acd9-9791-3f1b-855e4945012a@9livesdata.com>
 <CAJfpegs+auq0TQ4SaFiLb7w9E+ksWHCzgBoOhCCFGF6R9DMFdA@mail.gmail.com> <d9459e74-92b4-187b-4b73-bd807e79d813@9livesdata.com>
In-Reply-To: <d9459e74-92b4-187b-4b73-bd807e79d813@9livesdata.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 20 May 2020 14:26:38 +0200
Message-ID: <CAJfpegt8HjHRNEWw9KVasP4eANduDK6v0S-V09JavHRMdP7hzw@mail.gmail.com>
Subject: Re: fuse_notify_inval_inode() may be ineffective when getattr request
 is in progress
To:     Krzysztof Rusek <rusek@9livesdata.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 20, 2020 at 2:24 PM Krzysztof Rusek <rusek@9livesdata.com> wrote:
>
> Hi Miklos,
>
> I've checked that after applying the patch, the problem no longer occurs.
>
> Since I'm running tests on RedHat 7.7, I had to slightly modify the
> patch, because on that kernel version locking around attr_version is
> done differently. I'm attaching modified patch, just in case.

Hi Krzysztof,

Thanks for the report and testing!

Miklos
