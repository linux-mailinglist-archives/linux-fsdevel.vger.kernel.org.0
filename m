Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589EC2A9742
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 14:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgKFNzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 08:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgKFNzX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 08:55:23 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535FCC0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2020 05:55:23 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id t8so700027vsr.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2020 05:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TX2xvwAupq4mo3tJRD0vhjuXrlkWZa6Kdrd3xp27LiM=;
        b=PA2UaxG5F0GOxbAEFJ4NwShLZHnOijdUhSZ9dW22rET5aSh6EUBHOgrSiP/RWH/3Vt
         E9mE8tCdxV74eaMBeFLLF7IkvXczpmuEzml8C7ArZwtUsdU8k7Aq3BySM8vOAhHNqZ3e
         1acrITqu75SL1YIJAIixB9qTnqDqmjKpaYcpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TX2xvwAupq4mo3tJRD0vhjuXrlkWZa6Kdrd3xp27LiM=;
        b=Y68bRBacZYvV8Un3THqGdX2BnmviOZ+OmRYZNK/j2G1P/03NgOo/qo1/OFu1EWUUI4
         BgcOUl0UbJeO5U6noehwJik8YXwh03bgHCpbP05/295Xppu103heEDnc0a/PUrmE7vHO
         fZnfLnCw6ICQ03tpC8zBDDBkwcxq+D/zT1/AijrkRNJ+SUuKGaWQ7MNlprLFGduY5WGm
         u1cl/gAKdSPiGZ6L/TuxqvChVAJ/XXSdVeM4IlUnIhLBuef1HlMGNyZSlxaEuvk901hO
         WslB8VbRypj7FjvU2gDTTvUsGlADHznbgDLPd8/tzJTSV/ra8qO/0Pil9nEBo6Pj/Q5t
         J76A==
X-Gm-Message-State: AOAM531SewCAhRmFUSivQuv8iguf2ya2o2qWckgWm+2UGYYsRzM2XlLy
        5N6Ovg9LKdxcEXkHrTzbAmjQVR6GuqBcmSEWn/Lcow==
X-Google-Smtp-Source: ABdhPJytsB2NVeljUXC9S/jBb7a67t+cwJqC9GUnYvy/T7gqf1tpWsLywemgnPuefzg91vuit6AQYkuEpwLzCZ9qqhU=
X-Received: by 2002:a67:2b47:: with SMTP id r68mr1006280vsr.7.1604670922468;
 Fri, 06 Nov 2020 05:55:22 -0800 (PST)
MIME-Version: 1.0
References: <20201009181512.65496-1-vgoyal@redhat.com> <20201009181512.65496-6-vgoyal@redhat.com>
In-Reply-To: <20201009181512.65496-6-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Nov 2020 14:55:11 +0100
Message-ID: <CAJfpegvhK+5-Zze7qZFrXkUkXbN_4M1CpEqyL9Rq9UNOtb2ckg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] fuse: Add a flag FUSE_OPEN_KILL_PRIV for open() request
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 9, 2020 at 8:16 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> With FUSE_HANDLE_KILLPRIV_V2 support, server will need to kill
> suid/sgid/security.capability on open(O_TRUNC), if server supports
> FUSE_ATOMIC_O_TRUNC.
>
> But server needs to kill suid/sgid only if caller does not have
> CAP_FSETID. Given server does not have this information, client
> needs to send this info to server.
>
> So add a flag FUSE_OPEN_KILL_PRIV to fuse_open_in request which tells
> server to kill suid/sgid(only if group execute is set).

This is needed for FUSE_CREATE as well (which may act as a normal open
in case the file exists, and no O_EXCL was specified), right?

I can edit the patch, if you agree.

Thanks,
Miklos
