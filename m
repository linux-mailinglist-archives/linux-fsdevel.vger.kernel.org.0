Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF863AE595
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 11:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFUJHw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 05:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhFUJHv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 05:07:51 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C7EC061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 02:05:26 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id x12so1693715vsp.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 02:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5hhF+0lubDkdxK7fLznvmGfAxCh2FAmdrdpNuvpboZw=;
        b=mBqEgG6lgYyPYD2Um3RdoLeyCUZtxvKuvGkITHtq14q2qnqmkqr8R16iSRE3fqjjna
         EmhP6WyoybL5gfooamBsmQbv2hB/8Rbx04/ah0TNTG2eGl0FUrdD4dMWPIUCBawzHSm4
         riBY16DgB7UUBvdHaxMus+vXsJmx/RwqLMqGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5hhF+0lubDkdxK7fLznvmGfAxCh2FAmdrdpNuvpboZw=;
        b=inGgBJIUnvT/Xv6mJXJXhkh83w86tXesJS4unF+FW32bepNDD+oSxE1bjpXXlXJt5f
         qql6STq1fYVmsABOv8AMpaCoC06oox6nzUvOkn32AUB2ITx8OYdPZzrmcWLSXE8pwnQm
         GpFUiiUD4LCQekc55LTQPnWsViyIXB2zH8d1GrZtZwHmM1OvChKtKNP8j/kcTkaICJ4i
         Z+oQmrw21jIBdsL9FxZT6rDSjz+ANbh8EgaJi04+8q5JnccRXmfafoXu4BtAbJ3mazrs
         Td+hxaOM3WnnCHfu9pBqqFAZd4dxegNASd9ydLlQmTm/2p446oq+LEb1RpCD5i6EtXds
         ypbw==
X-Gm-Message-State: AOAM530GHl/kwjHlL5hZFcFXAzAW/42EZPnGvwdMFOV+XkyC3kZgORBM
        p+fcNTPJCCd2wuQxJmfM0+dCVRxSIBJL1OJA2VF3dQ==
X-Google-Smtp-Source: ABdhPJywAl4G7rsItL/aDZLfP6AkTwPauj+MT+YK9WTOfsWzCWJjfBMq+Eoi0bqzauwe7VFZXt3SCb93kqFOEyFEt98=
X-Received: by 2002:a67:e252:: with SMTP id w18mr3630714vse.9.1624266326023;
 Mon, 21 Jun 2021 02:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <fc097829-b4f1-5d8d-fd71-d204c79480dc@omp.ru>
In-Reply-To: <fc097829-b4f1-5d8d-fd71-d204c79480dc@omp.ru>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 21 Jun 2021 11:05:15 +0200
Message-ID: <CAJfpeguzZXB1d8PrtXA4Um6eFoDDpBpFtLiyogmTWOKB+ksiag@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix unfreezable tasks
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-fsdevel@vger.kernel.org,
        Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 18 Jun 2021 at 21:45, Sergey Shtylyov <s.shtylyov@omp.ru> wrote:
>
> From: Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
>
> It could be impossible to freeze the fuse task in request_wait_answer()
> when it calls wait_event_killable() with the FR_FINISHED flag because
> the fuse daemon could be frozen before the task, so it simply can't
> finish a request. E.g. it could be impossible to freeze while doing
> poll() on a fuse FS:
>
> [   90.468003] (0)[]Freezing of tasks aborted after 6.507 seconds
> [   90.468793] (0)[1649:kworker/u8:18]qtaround::mt::A D
> [   90.468830]    0  1590   1102 0x00400009
> [   90.468850] (0)[1649:kworker/u8:18]Call trace:
> [   90.468887] (0)[1649:kworker/u8:18][<ffffff82a7685a44>] __switch_to+0xd8/0xf4
> [   90.468929] (0)[1649:kworker/u8:18][<ffffff82a851fa9c>] __schedule+0x75c/0x964
> [   90.468964] (0)[1649:kworker/u8:18][<ffffff82a851fd14>] schedule+0x70/0x90
> [   90.468995] (0)[1649:kworker/u8:18][<ffffff82a79fec00>] __fuse_request_send+0x228/0x3a4
> [   90.469031] (0)[1649:kworker/u8:18][<ffffff82a79feeec>] fuse_simple_request+0x170/0x1c4
> [   90.469068] (0)[1649:kworker/u8:18][<ffffff82a7a070e0>] fuse_file_poll+0x164/0x1c8
> [   90.469107] (0)[1649:kworker/u8:18][<ffffff82a7851050>] do_sys_poll+0x2f4/0x5a0
> [   90.469142] (0)[1649:kworker/u8:18][<ffffff82a78518f4>] do_restart_poll+0x4c/0x90
> [   90.469178] (0)[1649:kworker/u8:18][<ffffff82a76bb32c>] sys_restart_syscall+0x18/0x20
> [   90.469213] (0)[1649:kworker/u8:18][<ffffff82a76835c0>] el0_svc_naked+0x34/0x38
> [   90.469457] (3)[647:dsme-server]Restarting tasks ...
>
> Use freezer_do_not_count() to tell freezer to ignore the task while it
> waits for event.
>
> [Sergey: added #include <linux/freezer.h>, cleaned up the patch description]
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=198879
> Fixes: 7d3a07fcb8a0 (fuse: don't mess with blocking signals)
> Signed-off-by: Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>
> ---
> This patch is against the Linus' repo -- I didn't find a tag suitable for
> the fixes in Miklos Szeredi's FUSE repo. :-(
>
>  fs/fuse/dev.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> Index: linux/fs/fuse/dev.c
> ===================================================================
> --- linux.orig/fs/fuse/dev.c
> +++ linux/fs/fuse/dev.c
> @@ -8,6 +8,7 @@
>
>  #include "fuse_i.h"
>
> +#include <linux/freezer.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/poll.h>
> @@ -386,9 +387,11 @@ static void request_wait_answer(struct f
>         }
>
>         if (!test_bit(FR_FORCE, &req->flags)) {
> +               freezer_do_not_count();
>                 /* Only fatal signals may interrupt this */
>                 err = wait_event_killable(req->waitq,
>                                         test_bit(FR_FINISHED, &req->flags));
> +               freezer_count();


This is just and open coded variant of
wait_event_freezekillable_unsafe() which comes with this warning:

/* DO NOT ADD ANY NEW CALLERS OF THIS FUNCTION */

This is a really old issue and unlikely to be properly solvable with a
quick hack...

Thanks,
Miklos
