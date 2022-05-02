Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296A2516B04
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 May 2022 09:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353644AbiEBHF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 May 2022 03:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238801AbiEBHF1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 May 2022 03:05:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D9C6460;
        Mon,  2 May 2022 00:01:58 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso15408208pjb.1;
        Mon, 02 May 2022 00:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7MLSEk1Zg4N4Mn5YyAWZbEoas0CNhuGYCu9wwnw6i0=;
        b=ahirv5dzvVouAXT8RwoOabSoKNJRRFLUSaFEEDTZHdRUVq8VW4Lg+/2s7OcTUPj+LF
         e/Gub+1gSkUehxRdDEmTx8QS4LhPhfbBlFWTAYI3NNvlq4OpoH6wDUAwjxQ0TzoUQVWQ
         zuawSMlfn12c9eNHRqiLgln342w45ahqetAY825Q4YzsyV/5IN0P1dZSgByv04NeM6cv
         1nj7oIwFez4xYH5gp8kvEvBPQxkacKDdCBPvha7MRShPSEtAphDqOZuWNx8tfp0J5+ZV
         k9njEY5PmaM/hWLDv4jjUwTmP98fgYJPWVSeU+wGwxGxns5rqc45RsuW7hqGpuindlCE
         YCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7MLSEk1Zg4N4Mn5YyAWZbEoas0CNhuGYCu9wwnw6i0=;
        b=kWQCx5yRvEI/Oyc+zvtGgn0pqhVUPi1wVtwhD30zr0xHSUEH0C8MHi1y5dWBcl1igP
         zoPeJgKiue7Kyd7dT6wHYD0Qhdo8M09ksu5KDQ6koPMW9B3hLXnrBf5QE2J8oEfy5rZ6
         zYJHE+VHtYHFYzTImdY01uPi3F1eZCGerj78sxr7nom3RTRJp1kZ0Vn+XM4u6tHedtIt
         1GE5q0BObwtZlGzvFishOIetdCSzNV51Eq6D90VDVJIvoNtP+c8BfqN23bUt1HbCCBER
         9+56WaMUXNGVZ2ZiGhE6hR6CGXI77MErDZkYXdRE90YeurN0mZlRnzifJXSbTiZosylH
         trog==
X-Gm-Message-State: AOAM532cG43wWpHctFpnAjABDzbZC7k01/MJRCPQSID0bO7n8fBAOA6X
        XLPTlkXRdzyM8wf8jTxzzJCsG6jqz/qlkczrKnlt9nvcM58VnQ==
X-Google-Smtp-Source: ABdhPJyLnXWeFBYfu0Jytog6gpjuXEhblMXCokzspuU4e1BS5ALMzpdzv00HDfvDy9mglADiTH0OmM5KUFbsINklhtk=
X-Received: by 2002:a17:90b:380b:b0:1dc:6d24:76ff with SMTP id
 mq11-20020a17090b380b00b001dc6d2476ffmr393653pjb.42.1651474917714; Mon, 02
 May 2022 00:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220415005015.525191-1-avagin@gmail.com>
In-Reply-To: <20220415005015.525191-1-avagin@gmail.com>
From:   Andrei Vagin <avagin@gmail.com>
Date:   Mon, 2 May 2022 00:01:46 -0700
Message-ID: <CANaxB-wcf0Py9eCeA8YKcBSnwzW6pKAD5edCDUadebmo=JLYhA@mail.gmail.com>
Subject: Re: [PATCH] fs: sendfile handles O_NONBLOCK of out_fd
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>, stable@kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andrew, could you take a look at this patch?

Here is a small reproducer for the problem:

#define _GNU_SOURCE /* See feature_test_macros(7) */
#include <fcntl.h>
#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/sendfile.h>


#define FILE_SIZE (1UL << 30)
int main(int argc, char **argv) {
        int p[2], fd;

        if (pipe2(p, O_NONBLOCK))
                return 1;

        fd = open(argv[1], O_RDWR | O_TMPFILE, 0666);
        if (fd < 0)
                return 1;
        ftruncate(fd, FILE_SIZE);

        if (sendfile(p[1], fd, 0, FILE_SIZE) == -1) {
                fprintf(stderr, "FAIL\n");
        }
        if (sendfile(p[1], fd, 0, FILE_SIZE) != -1 || errno != EAGAIN) {
                fprintf(stderr, "FAIL\n");
        }
        return 0;
}

It worked before b964bf53e540, it is stuck after b964bf53e540, and it
works again with this fix.

Thanks,
Andrei

On Thu, Apr 14, 2022 at 5:50 PM Andrei Vagin <avagin@gmail.com> wrote:
>
> sendfile has to return EAGAIN if out_fd is nonblocking and the write
> into it would block.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: stable@kernel.org
> Fixes: b964bf53e540 ("teach sendfile(2) to handle send-to-pipe directly")
> Signed-off-by: Andrei Vagin <avagin@gmail.com>
> ---
>  fs/read_write.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index e643aec2b0ef..ee59419cbf0f 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1247,6 +1247,9 @@ static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
>                                           count, fl);
>                 file_end_write(out.file);
>         } else {
> +               if (out.file->f_flags & O_NONBLOCK)
> +                       fl |= SPLICE_F_NONBLOCK;
> +
>                 retval = splice_file_to_pipe(in.file, opipe, &pos, count, fl);
>         }
>
> --
> 2.35.1
>
