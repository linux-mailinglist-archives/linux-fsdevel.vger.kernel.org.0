Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831E938C728
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 14:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbhEUMzg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 08:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhEUMxn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 08:53:43 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F2AC06138A
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 05:52:08 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id j12so5252337vsq.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0bcwMa3PXE6BxBVKmr7yJhO3MpudMurDafu1kpNh8o=;
        b=egbbFhgbpZilJQP2aMecSiEeWjHfKV1nE/juvi4hnZl1Si+xJsytEUN8Vq0BBuhhQl
         mPJ9wt6fa38LLItKxFiLWEVBxPGc5+81u3RLfBZ3Tb3/kj6NTcAuaHcgJFk/f+Ha97wR
         K7P6QP+r2fsm8Jtw76LQ5gTjF+elCuvYTal0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0bcwMa3PXE6BxBVKmr7yJhO3MpudMurDafu1kpNh8o=;
        b=DYGaYuz6dEAI4y+lYS2/MhZM8W2FJ2G+SElvADpeL7lRKNZUpO6Z6R/rIRm4GuhKIq
         6iBye/bbmvV3pXwVvKPo/EMnDK6uFE+/ByB61/9SbPp/RGazxVpCEVaWeZUcGTChV9LS
         OGlXGxeNO05bZA0zTohKLCraLjVV25qrfVxWqiC/vQBC8xJVb2mzpKxPKfO/YFXwFZ+9
         M8ENymD0OthrJoAkitrHLiKtJdsz5RncfoguSMVOBN1AtEo2sjhuaDCcPQEOGHQstVRf
         zDLTi4FbFcLcg46g7rcDKYiojfUuq9sxHNVX1hQZKPUpkTdr/Lx9ESSUQo+MmNa7uNWN
         ZaIg==
X-Gm-Message-State: AOAM532M03Vu1Zo9ag5RvITFLHCcCikpftPct6hPRjO07FtnjQRhOQMq
        nMZNjAD/QSwEwOJwQoUXjuAn/e90Ht5F9G6H7j347Q==
X-Google-Smtp-Source: ABdhPJxU0pW7Uhz6WcVvZjuacmVeklxRBiZXZr+5W12DcHtWDJ3NDWg/omTWvlSaYYcMZqIEoCKTvpQnIaZaM7Jg7SA=
X-Received: by 2002:a67:68c5:: with SMTP id d188mr10309413vsc.0.1621601527453;
 Fri, 21 May 2021 05:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210520154654.1791183-1-groug@kaod.org> <20210520154654.1791183-6-groug@kaod.org>
 <20210521120840.4658d42c@bahia.lan>
In-Reply-To: <20210521120840.4658d42c@bahia.lan>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 May 2021 14:51:56 +0200
Message-ID: <CAJfpegtgPMw-MwWEJVt_=jc76032FShFon0xXUNyWb=zJBypbg@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] virtiofs: propagate sync() to file server
To:     Greg Kurz <groug@kaod.org>
Cc:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Reitz <mreitz@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Robert Krawitz <rlk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 21 May 2021 at 12:09, Greg Kurz <groug@kaod.org> wrote:

> If it looks good to you, maybe you can just merge it and
> I'll re-post the fixes separately ?

Looks good, applied.

Thanks,
Miklos
