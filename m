Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1497E307335
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 10:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhA1Jxh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 04:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhA1Jxc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 04:53:32 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834D1C061573
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 01:52:52 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z6so4670410wrq.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Jan 2021 01:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOnRPtszV3PaUWg2pyJqFO41MhBKeHyNAsRjEwvHkC0=;
        b=tDCPeWK1QWM9E1Za6fnY1S1SxWvoWPBZyhd5Pp6WsnhkRdcWyG32A1C826+1DTYrns
         doj6dhlpQ1uyNvIR70PW5YdnGZ/kkvHIYtskI0Yo2VH1q7GflE35p2Ho5qgbXO0D/uQ0
         /69suVYb3VotOiyEHZXI7Nun0wSC5qfcpI1OMCR1jtynq2su/mqm0iKqsQ1EjAQBec/9
         VyhlTNE6XmqBVPiU+0b0Cuqo7q1mdHXmGsuP3lyJsKfQRi6SOJOaLgBgZOZXvnU0T/kS
         UW/m9Rv8aNLySIipWgDQU9cz8IncsKn0SIgzmnc6GCRqGaq4DU5412WXvl4J4R+XaMQJ
         B6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOnRPtszV3PaUWg2pyJqFO41MhBKeHyNAsRjEwvHkC0=;
        b=meV3XyhqymPgn+gA4agJhSNYOu4KAAlDBcUy7FKEt20Jnqw+8LgC+c1xTjnMemRtdt
         +U096uRPIQJZwnEJ0+5F9HTLWq5bFkwXSaeGKCR6tpVnTsbdl4abfFVqnRXQkOjMRFKZ
         ML5pC97/E5WE20US/NZ0e8At+pvhp0hgtkbXnf2jhrP+O0dL3ywp9A0+W/+BNXq7B0tp
         ic4mh7C3BJ4kOM1n4v0i54mas7zxqxBYOQXXw2KvMqdTNh0j1kyIk8t1QmoO7O/hPqPc
         6lg1GK0P3hIbDJ0hQyk3zg+AL0smSoSdQqRGWBUXGfGiPIZOi8+2xDyIaYhjRuVD+qNr
         qaRg==
X-Gm-Message-State: AOAM5318AbVuPZ1mUv8ql6mygOVjWdLv0MTtXMuPnUQKD5plWiBHkeEP
        0v6W1lTeUITeYIsf2FTxkRIECW/AxkVmZfhV+KP0dGu91aAY7Q==
X-Google-Smtp-Source: ABdhPJwHETQJvwhUbgSeS4QIEKD5IvRwVjZI//YrF1rIab9o79Tvfqo/xz+jIY8t8FIJmZx+RIWn01qCuURxcn7La7g=
X-Received: by 2002:a5d:4a0d:: with SMTP id m13mr15441223wrq.395.1611827570762;
 Thu, 28 Jan 2021 01:52:50 -0800 (PST)
MIME-Version: 1.0
References: <91568e002fed69425485c17de223bef0ff660f3a.1611313420.git.lucien.xin@gmail.com>
In-Reply-To: <91568e002fed69425485c17de223bef0ff660f3a.1611313420.git.lucien.xin@gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Thu, 28 Jan 2021 17:52:39 +0800
Message-ID: <CADvbK_eJA5ZaEK928k+jt9QxHAYjZm5Xg7JUG5rCwTSfuGbisA@mail.gmail.com>
Subject: Re: [PATCH] seq_read: move count check against iov_iter_count after
 calling op show
To:     linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     NeilBrown <neilb@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Anyone working on reviewing this?
Neil?

On Fri, Jan 22, 2021 at 7:03 PM Xin Long <lucien.xin@gmail.com> wrote:
>
> In commit 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code
> and interface"), it broke a behavior: op show() is always called when op
> next() returns an available obj.
>
> This caused a refcnt leak in net/sctp/proc.c, as of the seq_operations
> sctp_assoc_ops, transport obj is held in op next() and released in op
> show().
>
> Here fix it by moving count check against iov_iter_count after calling
> op show() so that op show() can still be called when op next() returns
> an available obj.
>
> Note that m->index needs to increase so that op start() could go fetch
> the next obj in the next round.
>
> Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code and interface")
> Reported-by: Prijesh <prpatel@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  fs/seq_file.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 03a369c..da304f7 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -264,8 +264,6 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>                 }
>                 if (!p || IS_ERR(p))    // no next record for us
>                         break;
> -               if (m->count >= iov_iter_count(iter))
> -                       break;
>                 err = m->op->show(m, p);
>                 if (err > 0) {          // ->show() says "skip it"
>                         m->count = offs;
> @@ -273,6 +271,10 @@ ssize_t seq_read_iter(struct kiocb *iocb, struct iov_iter *iter)
>                         m->count = offs;
>                         break;
>                 }
> +               if (m->count >= iov_iter_count(iter)) {
> +                       m->index++;
> +                       break;
> +               }
>         }
>         m->op->stop(m, p);
>         n = copy_to_iter(m->buf, m->count, iter);
> --
> 2.1.0
>
