Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E003EF9C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 07:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhHRFJM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 01:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhHRFJK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 01:09:10 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA2DC061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 22:08:36 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id s19so993305vsl.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UnXThZRC3fAssEX0f0mLCZ6Q9w2tlCC2Smhk9kY/6CA=;
        b=gCuCVqPtp3VcrqtAtdQ9/T1hLISv/SoLG3FxW0WozJv9qF+VkP6lJy5+8o4RK3PHGe
         B/zhH0L3cY3+1C7tiCUx+apwtps1Hr63DN6B7vtkdtGE4R8dIUDR/DOrbruYk3WODqTS
         rS+LP7odFUxNB+5/Y04KwmguxE/ql3g3O/SRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UnXThZRC3fAssEX0f0mLCZ6Q9w2tlCC2Smhk9kY/6CA=;
        b=P9Lbt9VG67ofdC9oECtNY2O9GozW9+1/fCSCM8BOglMfPjszWbuEpCfHj3nClCj2/V
         57qM10W+fL23HH/26HocFC6PDoXiybjf1gbSyjczdV3FgOlwQeBTAmQhyDCuPubXI+LD
         Fs4ADM6hXdl/U0bu06y9f54SVIfKqt2SpMe76IlUkiluoFZWuUwqJ59+JvGdY1XVgqCZ
         45H4AjpYMVPw/3afhg1pd4XydlHhJsvoPeft8DeMYko8RdcdR0i94wvKq2OldBIRgzif
         tNhp3iPZdfZ9YqJ6AlCzRzkCkHfo92ijll9DztcZXqdz4ypqk4qWi4W3srG2J0IjCSFZ
         PbNg==
X-Gm-Message-State: AOAM531sB/cAFMCR4nzgc7/+VH2RT84x2Js+UMy8tfEChAoCM9hKwr2y
        czRUnH+Ju+jBtOUzfUd1sKGDwY9ZjgMPL4dX8k0SGrK0idE=
X-Google-Smtp-Source: ABdhPJwwzsw1fw1YBDJLxjFxkuCGfq67iXSTVfBq6nF0q13DJIhPofNJc6jdv4S5vqn0kEPMQ9X7LN1beeitaFiS0Rw=
X-Received: by 2002:a67:c009:: with SMTP id v9mr6217355vsi.47.1629263315510;
 Tue, 17 Aug 2021 22:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
 <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
 <YRut5sioYfc2M1p7@redhat.com> <6043c0b8-0ff1-2e11-0dd0-e23f9ff6b952@linux.alibaba.com>
 <CAJfpegv01k5hEyJ3LPDWJoqB+vL8hwTan9dLu1pkkD0xoRuFzw@mail.gmail.com> <1100b711-012d-d68b-7078-20eea6fa4bab@linux.alibaba.com>
In-Reply-To: <1100b711-012d-d68b-7078-20eea6fa4bab@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 18 Aug 2021 07:08:24 +0200
Message-ID: <CAJfpegsdX1H_=ZMORA-9YiBGdszG0WVmAjFY2QSZPa0iLUEjXw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 18 Aug 2021 at 05:40, JeffleXu <jefflexu@linux.alibaba.com> wrote:

> I'm not sure if I fully understand your idea. Then in this case, host
> daemon only prepares 4KB while guest thinks that the whole DAX window
> (e.g., 2MB) has been fully mapped. Then when guest really accesses the
> remained part (2MB - 4KB), page fault is triggered, and now host daemon
> is responsible for downloading the remained part?

Yes.  Mapping an area just means setting up the page tables, it does
not result in actual data transfer.

Thanks,
Miklos
