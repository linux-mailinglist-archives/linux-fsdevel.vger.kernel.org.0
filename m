Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE124D7B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 16:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgHUOyN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 10:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgHUOyL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:54:11 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBCEC061573
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 07:54:11 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b2so1661602edw.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P8JqJ7RITgIzurlji1LRRQPoo/Vlt5Iw5NORag7G42Q=;
        b=PF5nQ0yhXqC6cdiS0QHJ/VuBLy6pv4wFad2TzgpHPe0m9/AbF0MrCgH7ZOwn839T+y
         ppa1BeyMv/4m6dQWPy5WScRu3mg4ShtrpD90yzFBkHvYXjWaDXOr3+0X49jXWBs4g6zL
         D2vhDiA+A+4B1xcKULWc9V5Jv3RkCK4fDM8aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P8JqJ7RITgIzurlji1LRRQPoo/Vlt5Iw5NORag7G42Q=;
        b=OvY3ZF/1DKTYFVtFKArl84kp7WXdYyGWzp2BLsUqLh75upxOCvwg5XT8FLfqWh8i1I
         DRHXqP7AGYD/4EQzG8Y4bAuDUsfE+9Lfrut0Dck3Yg8oJXrSs0IanX9I4U0G+hN5TEBl
         pQ/GfvvT5a7JlxkUnBloGKFforU9ITJlwyt5daOXns/lMrbYZZFtTau/SlEMGuN50BD9
         olxLfOAElrwG0AefSTPPzDVJkKBKDu5ShxESIBplfKjQ0cLzzdtbh9Bgv4trlmqr0FgV
         7aSj1jtgEPwJ329Y0z/SNioBLd1PU+0AL0BbImKqcKz16K4mb2G9YsaAe9QJIB6N1vzJ
         1xaA==
X-Gm-Message-State: AOAM531i8jUhkvYoWjQERxCvBE0uL6Ze8hpmVKlOwl1Tf52ju/orNoSj
        4KKoCqX03uwXUDW+j+lY1LCr0unJCNRltWqeMoDjMg==
X-Google-Smtp-Source: ABdhPJzomExR6LM2W4ELJOVvg6ukzO5x+V45QeLrj3TBnzmA85z0YuQMA4zUCx2tCu3Da0aCaHiEmk+COKW3nbZ/omE=
X-Received: by 2002:aa7:d5d0:: with SMTP id d16mr3099450eds.212.1598021649997;
 Fri, 21 Aug 2020 07:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183812.19573-1-vgoyal@redhat.com> <20200724183812.19573-4-vgoyal@redhat.com>
In-Reply-To: <20200724183812.19573-4-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 Aug 2020 16:53:59 +0200
Message-ID: <CAJfpeguvMvc9rXChGrSuQsO9__Ln7exozmMWVY_1B8DrsV4rpQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] fuse: Add a flag FUSE_SETATTR_KILL_PRIV
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 24, 2020 at 8:38 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> With handle_killpriv_v2, server needs to kill suid/sgid on truncate (setattr)
> but it does not know if caller has CAP_FSETID or not. So like write, send
> killpriv information in fuse_setattr_in and add a flag FUSE_SETATTR_KILL_PRIV.
>
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>

[...]

> +/**
> + * Setattr flags
> + * FUSE_SETATTR_KILL_PRIV: kill suid and sgid bits. sgid should be killed
> + * only if group execute bit (S_IXGRP) is set. Meant to be used together
> + * with FUSE_HANDLE_KILLPRIV_V2.
> + */
> +#define FUSE_SETATTR_KILL_PRIV (1 << 0)

Why not a FATTR_KILL_PRIV set in fuse_setattr_in.valid?

Thanks,
Miklos
