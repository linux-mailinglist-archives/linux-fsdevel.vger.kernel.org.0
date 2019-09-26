Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77777BF6C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 18:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfIZQds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 12:33:48 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:44971 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfIZQds (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:33:48 -0400
Received: by mail-yw1-f68.google.com with SMTP id u187so928513ywa.11;
        Thu, 26 Sep 2019 09:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2AZgX0guaiP5YgFLeTKAEfoSQ+3fPgtSsiI7KoX+/Q=;
        b=FWGPuI+7/ZX7ZYmJGgrTUtcL+w0oEWOJxyCatcLDxyC29RJOUcAfONG5JseEwxdoq1
         NvAW4Zo5Vh5pqBwYLPRF9rcx8Rhju0CaXcdNdOqNXa3HVRsLrQTY7KzMqXwt+vOPafBF
         H7m4M4KmOjSoKa7bUH8S5tmwN6H3yxU3awq9rPCgxfC7b5U2AApDenKMFTfZReu4nuVj
         jWhqxpZ+BKBO13H2N7V12z0h8yG58zZBD9JsUABOY55A4lGsIy2f2gUh0AoqEa0enb1E
         2A5ci87gTk05UErxPUrkQiVBl6AnEJUvtT1W1A6fQ96xZwk4Mou30Hbo1ElQmQ7Fs3Q6
         ok+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2AZgX0guaiP5YgFLeTKAEfoSQ+3fPgtSsiI7KoX+/Q=;
        b=ptGXqBOJovbWmPrCKdhlwlUVnlNWdN8HWSRx5m9Q9yaYMz4i7kDeLGDZWPB98Z5VSy
         oktdSrr5zYYvJlle8P57Znav6GD5fRg1l0J5vOOC/7TpYoFJlPGJ/wNRkmAkI2bN6lei
         qkAU9DGSo4Z4V7XMiwvu69P/Pzly6ovX+59ks0pn6GZOmOFQHZpBZvPVY+DH9Cd5+gqG
         y2q+obfWqATdxAMlHYcXQJ8mkEpK00V8M64pGKQIKRD79GPu/4E9DnbBoEFuZnDOtX4X
         Dw4XNgNBOBLiBPc7hTp/CQ53Tt1Rp+SO2qwmtSiUS608jWlbL6TRDdidhBueSGQ8ffbi
         euHg==
X-Gm-Message-State: APjAAAUjVqDsjEZuq0PbB8w6Cf4MREzAe5NL4tNtDQgd3gyw7CCCl574
        ajkD8SbNJRLu02S/aRT9yMvqywG2TjKl8f86Rac=
X-Google-Smtp-Source: APXvYqyO2JaguAhBThAB0WOaDDohuSGt0Uia1/0TAyF4+Rs7q55h/9Aw18lfKWK+oGw0GJ6WqRqfrIdNxWHSvpPTDrs=
X-Received: by 2002:a81:6c8:: with SMTP id 191mr3269887ywg.181.1569515626516;
 Thu, 26 Sep 2019 09:33:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190926155608.GC23296@dell5510> <20190926160432.GC9916@magnolia> <20190926161906.GD23296@dell5510>
In-Reply-To: <20190926161906.GD23296@dell5510>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 26 Sep 2019 19:33:35 +0300
Message-ID: <CAOQ4uxixSy7Wp7yWYOMpp8R5tFXD2SWR9t3koYO4jBE-Wnt8sQ@mail.gmail.com>
Subject: Re: copy_file_range() errno changes introduced in v5.3-rc1
To:     Petr Vorel <pvorel@suse.cz>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 26, 2019 at 7:19 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Darrick,
>
> > On Thu, Sep 26, 2019 at 05:56:08PM +0200, Petr Vorel wrote:
> > > Hi Amir,
>
> > > I'm going to fix LTP test copy_file_range02 before upcoming LTP release.
> > > There are some returning errno changes introduced in v5.3-rc1, part of commit 40f06c799539
> > > ("Merge tag 'copy-file-range-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux").
> > > These changes looks pretty obvious as wanted, but can you please confirm it they were intentional?
>
> > > * 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") started to return -EXDEV.

Started to return EXDEV?? quite the opposite.
But LTP tests where already adapted to that behavior AFAICT:
15cac7b46 syscalls/copy_file_range01: add cross-device test


> > > * 96e6e8f4a68d ("vfs: add missing checks to copy_file_range") started to return -EPERM, -ETXTBSY, -EOVERFLOW.
>
> > I'm not Amir, but by my recollection, yes, those are intentional. :)
> Thanks for a quick confirmation.
>

Which reminds me - I forgot to send the man pages patch out to maintainer:
https://lore.kernel.org/linux-fsdevel/20190529174318.22424-15-amir73il@gmail.com/

At least according to man page -EACCES is also possible.

Thanks,
Amir.
