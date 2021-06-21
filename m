Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E17993AE4BE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 10:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhFUIaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 04:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbhFUI3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:29:52 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABB7C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 01:27:04 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id p9so6047028uar.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 01:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nLuy59A8PMwLhpgDGZXgcrV7ZMJJmmat7Q8wB6T7lcs=;
        b=VoGeBo628y2FREohTV7mjqkFeTdK5lIrqZn/zJWPIjrRvUmGElbTINfxBxAjVgI3Pu
         +Km7vM/lPHpFPtnKMiNb6+hYAKFrkbuPqRvDWxk5aGZZCRxf7xg/2Qj5hCQbWl9SlkmW
         70Y1LxP+pSCugL3BIMwZ0SY1O/7HW+EnP2vpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nLuy59A8PMwLhpgDGZXgcrV7ZMJJmmat7Q8wB6T7lcs=;
        b=YEStixgjw8IVjVkz3RkZjWRrfeRtXEtgDffxhuuq+5FT566mVGOk9ykZ4gltAgC32v
         88G5SoVwgwg4NvMCVemOYeXO70RkRciDDHfjxlet9aSYvTdL9bqlsI/Md9OT13M71C+e
         pfu3Cv78+ZWzAydkxMQrK6D2o6bkZ2prkKTejU9e5XbHfRCXouf7rphiEPnML/Lpvb5W
         Jog0ZRDnMLn4C5vmJn9a2ME0Hp1N1CsA1yVaJ9+qAKsAo0NCZnbN1hzR2+msN0v5sxI8
         OIxQBF61rswndbXUQzWYdYliu3+hxxLXOxDv7XZ2Xwv/r7kwEngmVB5mNS//XfMcX/4G
         ghhQ==
X-Gm-Message-State: AOAM5326aFsSDADqUp4dwOqkwf2ufCQUc4xTrVhpCmMcTICGaRXJ8rSS
        HiwMpOUfSnfwjjbffM0kyWpsKS2LmQp95QC9Ey45FQ==
X-Google-Smtp-Source: ABdhPJyCyHjO5agNFI9f6KyDk4d5nVl9SK+W+k1J8lkmwB3vka3xV9O/3exMBXZwkimpRefHNFeMhvmx0fnPbVAX2Fc=
X-Received: by 2002:ab0:23c3:: with SMTP id c3mr607783uan.11.1624264022971;
 Mon, 21 Jun 2021 01:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210423151919.195033-1-ckuehl@redhat.com>
In-Reply-To: <20210423151919.195033-1-ckuehl@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Jun 2021 10:26:52 +0200
Message-ID: <CAJfpegsXXGcZDbbtDoXG8sQqHrAS1fs-TsRz5ndQ62sse1Av_w@mail.gmail.com>
Subject: Re: [PATCH] fuse: Send FUSE_WRITE_KILL_SUIDGID for killpriv v1
To:     Connor Kuehl <ckuehl@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 23 Apr 2021 at 17:19, Connor Kuehl <ckuehl@redhat.com> wrote:
>
> FUSE doesn't seem to be adding the FUSE_WRITE_KILL_SUIDGID flag on write
> requests for FUSE connections that support FUSE_HANDLE_KILLPRIV but not
> FUSE_HANDLE_KILLPRIV_V2.
>
> However, the FUSE userspace header states:
>
>         FUSE_HANDLE_KILLPRIV: fs handles killing suid/sgid/cap on
>         write/chown/trunc
>         ^^^^^
>
> To improve backwards compatibility with file servers that don't support
> FUSE_HANDLE_KILLPRIV_V2, add the FUSE_WRITE_KILL_SUIDGID flag to write
> requests if FUSE_HANDLE_KILLPRIV has been negotiated -OR- if the
> conditions for FUSE_HANDLE_KILLPRIV_V2 support are met.


If server does not support FUSE_HANDLE_KILLPRIV_V2, then it does not
support FUSE_WRITE_KILL_SUIDGID either.  The two were introduced
together and the latter is only meaningful if the
FUSE_HANDLE_KILLPRIV_V2 feature was negotiated.

What am I missing?

Thanks,
Miklos
