Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BB144F717
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Nov 2021 08:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbhKNHSc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Nov 2021 02:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhKNHSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Nov 2021 02:18:22 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB42C061570
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Nov 2021 23:15:28 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id r12so56620060edt.6
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Nov 2021 23:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDLqVMD46uiMsWehvbC08aW5fVyYhTP1JwwUyTmh/Z8=;
        b=yLVowLrs6mCkTdQfHv7zS1ONJi082eZCq1Aari0B2GrOvsxpws3h8DvcOPkHOb3EiH
         vSYXNoDoBnHjgy7Yy7DqqH+u/jv5zPGmaHF6NdQOiQNjOepnrHS6DlBn0rl+SfHah3RL
         5z3IH6fZzC1MJLrPW2sWizYzIhYb3zvL+8n/UVpDmLHiPj2nb+8Fy2xpM9ZQSjUEv31r
         Ad3lwsvy3z1x5AsZZ/qEi4ug7qebXz/Rdp73+EcEiggDfy5zELRWD4LbeWABVlFo6huQ
         +gwyNzupKmYw6hQBfysEHiZzWKj1uQeN8URhmAKX2Zf16ASRx0xfl3uME8yUKPmb/IdO
         GNgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDLqVMD46uiMsWehvbC08aW5fVyYhTP1JwwUyTmh/Z8=;
        b=yLCq8motym7kLmWZc28hT0/FC7QVVh2QSKdSJt2aCu6X8GBYyUXlTobpqXbXL+5/di
         TaRxfzI5Fpi5U+EzVel1cNwTy6Txl9Tp9X+9Sn3IBHHh2+UhKSHDKZjc1oL8ectCCIOX
         JAgPvi6yNxgSVPqrlLJ8J/YIvlwgf+SNI+uN21Ql+xxIGdKt66LT+lE9/l7NTubKBF2X
         0GxPXs+puW2quESS9SA+10MsnG35TcHAbysbGyl+xLZjEOdMaJStivEPVpPMJAqcrpWH
         m454qfmuxeWmrXZtaBaw1NrEqL1y6TRkJfoXS4RY+GPx7H9JW8sQ8OGfLhW60BrBTKiu
         Z1bA==
X-Gm-Message-State: AOAM530HLoH9wRui0tWbRaUu+Jp7fPluiUDWyRS/sgS5akSciM3VymUu
        rT2jnLf+dqhTfAu+jZiuUmkBrhfjnUeZxL41sYDp
X-Google-Smtp-Source: ABdhPJwys5QCeONa+O77IsHuk8ZQoANDuLgPaz85EZaoDnCk2VJAxVAqGJNqA9Cx1ehqJo7gDi6VvDKgP5gZtUM2+SI=
X-Received: by 2002:aa7:d80d:: with SMTP id v13mr14429309edq.7.1636874126935;
 Sat, 13 Nov 2021 23:15:26 -0800 (PST)
MIME-Version: 1.0
References: <20210913111928.98-1-xieyongji@bytedance.com>
In-Reply-To: <20210913111928.98-1-xieyongji@bytedance.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Sun, 14 Nov 2021 15:15:17 +0800
Message-ID: <CACycT3ugx-wwPVb+Euzhj6hWn0fXO+jvfsUCew6v1iBaB8SZsQ@mail.gmail.com>
Subject: Re: [PATCH] aio: Fix incorrect usage of eventfd_signal_allowed()
To:     bcrl@kvack.org, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ping

On Mon, Sep 13, 2021 at 7:20 PM Xie Yongji <xieyongji@bytedance.com> wrote:
>
> We should defer eventfd_signal() to the workqueue when
> eventfd_signal_allowed() return false rather than return
> true.
>
> Fixes: b542e383d8c0 ("eventfd: Make signal recursion protection a task bit")
> Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
> ---
>  fs/aio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index 51b08ab01dff..8822e3ed4566 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -1695,7 +1695,7 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
>                 list_del(&iocb->ki_list);
>                 iocb->ki_res.res = mangle_poll(mask);
>                 req->done = true;
> -               if (iocb->ki_eventfd && eventfd_signal_allowed()) {
> +               if (iocb->ki_eventfd && !eventfd_signal_allowed()) {
>                         iocb = NULL;
>                         INIT_WORK(&req->work, aio_poll_put_work);
>                         schedule_work(&req->work);
> --
> 2.11.0
>
