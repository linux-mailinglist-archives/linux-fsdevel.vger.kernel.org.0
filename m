Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E1544603D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Nov 2021 08:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbhKEHqw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Nov 2021 03:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbhKEHqv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Nov 2021 03:46:51 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A219C061714
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Nov 2021 00:44:12 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id s13so47060uaj.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Nov 2021 00:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUDwBoW6j2VUF7iz7OubK1waaNG2NF5b2gQ7sCgWuZY=;
        b=bXGqMtMcq6IZ+qQ5xU1eW4xoahXX821aMQFMfs5+cr+Xhoa6eaXtdeHU8yN4Z5u1NN
         7l/Oh62YJ6Amwz3C7xmRiuaREwjW5jhtqrzJJhSJabR876hlJ5bIjmd0pVm+CgsRq/c5
         H8Lu0G7jL/rpQYWl5Z9M7g7TiEVlT7gRaDq9pZ2TOHDQ5OT1SXl5q9LKGC/wGue5bmlF
         m21XANXJ/9v6wdVitw7+X7uAAsaDDv3FMHJc7qCi95ManuY6vYRocirhFeGtcuqo8HqL
         KLq9qNhyTmIlFPx8vdr5ZUJwl1PNHS0AVL31lK/I9psDpQRossUpybJrckcSIFTBPmSd
         encg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUDwBoW6j2VUF7iz7OubK1waaNG2NF5b2gQ7sCgWuZY=;
        b=c6K+JNOC1s7pDMnuniM3UTwbz24J5/G76ta25bsa3XhcldS0gLu2K2Ywbw7dvY+AFq
         PGiL/1QlTO+1PPaLuBAvvRHU0nXhE7ycjgq8Jalw9qLz1dSUMCpPIcMfG626A5sDj88P
         kdEhhHicapBVXrW+uLf01qGjAzvg/+Dv7BEow3I/GabaTfmScS8MfLsU5d9sZgUH3sqy
         hnBKVyfnahOJ5/kRLZldIsKXSIwACSWnh2o4Yfwg+Ox0Nb39YsvMkO8izp2B6t+EnjMA
         VMXP0VvGZepKwd+NYbTvALRoSw9x8BPDUKuTWeQfXSBJ59X7ESii92V7DoQFKEadKijD
         iehg==
X-Gm-Message-State: AOAM531rr2tfN6zB25q20+bKen4IxMWI+53k1abSW7gAnDp+dyzn9LIU
        u+eMPEtljRJO9rJQ3ovhTBRQc1ZKhOBFV9Kfzcc2mPrTGqVz6w==
X-Google-Smtp-Source: ABdhPJxAZn7aPiltH1T+u9Q/1vZEvbm3DApj0+1FSlkQLeIZOwfldqFpjaOQuNeo02Q9tHYF0QQhFeuqfWG2AhBch2Q=
X-Received: by 2002:ab0:77c3:: with SMTP id y3mr39306774uar.67.1636098251710;
 Fri, 05 Nov 2021 00:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <20211103011527.42711-1-flyingpeng@tencent.com> <CAJfpeguWtPFG_daMNA7=T-kQmgkcTPugMj7HWhh2mu+cwRWbxw@mail.gmail.com>
In-Reply-To: <CAJfpeguWtPFG_daMNA7=T-kQmgkcTPugMj7HWhh2mu+cwRWbxw@mail.gmail.com>
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Fri, 5 Nov 2021 15:43:36 +0800
Message-ID: <CAPm50a+pu0hB0WwjSkaz+F=BJEhD5mEjFfe019cZ7AGdO0t2Ow@mail.gmail.com>
Subject: Re: [PATCH] fuse: fix possible write position calculation error
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 4, 2021 at 8:18 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, 3 Nov 2021 at 02:15, Peng Hao <flyingpenghao@gmail.com> wrote:
> >
> > The 'written' that generic_file_direct_write return through
> > filemap_write_and_wait_range is not necessarily sequential,
> > and its iocb->ki_pos has not been updated.
>
> I don't see the bug, but maybe I'm missing something.  Can you please
> explain in detail?
>
I think we shouldn't add "written" to variable pos.
generic_file_direct_write:
                ....
                written = filemap_write_and_wait_range(mapping, pos,
                                                        pos + write_len - 1);
                if (written)  //the number of writes here reflects the
amount of writeback data
                                 // in the previous page cache, and
iocb->ki_pos do not change and
                                //  no data in iocb is written.
                        goto out;
                ...
       out:
              return written;
> The patch looks good as a cleanup, but I'd very much like to know
> first if it fixes a bug or not.
>
When the direct read & write and cache read & write of different processes,
there is some synchronization in the user mode, but it is still found
that there
is data out of synchronization. Just analyze that there may be problems here.
Thanks.
> Thanks,
> Miklos
