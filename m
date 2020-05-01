Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2A21C0E82
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgEAHOw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 03:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728246AbgEAHOv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 03:14:51 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65778C035494
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 00:14:50 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id d197so4548325ybh.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2020 00:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MV/Q7EwkQ764+aYA9y8KigZ49kNY6VR5runzo9HRXAI=;
        b=YEsJ68kG67HFUSEVoa4ShQkuTQXVsgWgNJnujwjFmqlO4tae8gECHz+YXcWwCiDBC+
         YLqHC3qQXaRzDO7F3ICHjwSHE14kYBfZ1yL4lBRLcTwFpx4R/vsXaPPcE8w0a9/dcrYN
         PETEIzETn8rgkDpHd4NyRr3SEAw3Hm8bv7aNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MV/Q7EwkQ764+aYA9y8KigZ49kNY6VR5runzo9HRXAI=;
        b=VdG7JlVu0oyVLNurxsRvsOluzkHuNkzSP83aq0LtfoqjaqHSUgB4pZAM0xmuVF3b8i
         I7RlTbX+uC1bFIl7T1EjYM20QO5zRW4sAhw/LjR7YBk6dUgpxsfQAzn7a+o3iMe26fU0
         A2sIbXsVAE+dThYpReormiOVlLSqS7FqYL0iOUT9vtmlvuIFGlvIIG5TUkfXEQLuULiQ
         AO4ExnbXl+dGX5HRnWkIE8eY1ZzZwGmJnsFdBsO7MVbXbbFy+6W6bY2ug3rOYhcL5zFD
         53ytOF+yKiszN23t7a2w2f694fkoDuNXVbLlaLHHemxQMrX9ftKO/BX04Bp/VPx7dhbc
         lfjw==
X-Gm-Message-State: AGi0PuawRL78IyEmtSCjnPCfL6ktZpRW2Lv0zg94qteibLzorHyTnPZH
        dFNsY1kDbxWG+KIfQoygH9wyCxtpgzUkKe8FKljqtuVwlZo=
X-Google-Smtp-Source: APiQypIYVMuMKifV1ecxXPi5tHp0NXdnMAM1mHYO52lnx/fDdZMv2hdLQRAhAZKluEZa5hnDutyrUx0kDepH6NQWZvg=
X-Received: by 2002:a5b:351:: with SMTP id q17mr4355861ybp.428.1588317289222;
 Fri, 01 May 2020 00:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200424062540.23679-1-chirantan@chromium.org>
 <20200424062540.23679-2-chirantan@chromium.org> <20200427151934.GB1042399@stefanha-x1.localdomain>
In-Reply-To: <20200427151934.GB1042399@stefanha-x1.localdomain>
From:   Chirantan Ekbote <chirantan@chromium.org>
Date:   Fri, 1 May 2020 16:14:38 +0900
Message-ID: <CAJFHJrr2DAgQC9ZWx78OudX1x6A57_vpLf4rJu80ceR6bnpbaQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: virtiofs: Add basic multiqueue support
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        virtio-fs@redhat.com, Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>, slp@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Stefan,

On Tue, Apr 28, 2020 at 12:20 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Fri, Apr 24, 2020 at 03:25:40PM +0900, Chirantan Ekbote wrote:
> > Use simple round-robin scheduling based on the `unique` field of the
> > fuse request to spread requests across multiple queues, if supported by
> > the device.
>
> Multiqueue is not intended to be used this way and this patch will
> reduce performance*.  I don't think it should be merged.
>
> * I know it increases performance for you :) but hear me out:
>

It actually doesn't increase performance for me :-(.  It did increase
performance when I tested it on my 96-core workstation but on our
actual target devices, which only have 2 cores, using multiqueue or
having additional threads in the server actually made performance
worse.

> The purpose of multiqueue is for SMP scalability.  It allows queues to
> be processed with CPU/NUMA affinity to the vCPU that submitted the
> request (i.e. the virtqueue processing thread runs on a sibling physical
> CPU core).  Each queue has its own MSI-X interrupt so that completion
> interrupts can be processed on the same vCPU that submitted the request.
>
> Spreading requests across queues defeats all this.  Virtqueue processing
> threads that are located in the wrong place will now process the
> requests.  Completion interrupts will wake up a vCPU that did not submit
> the request and IPIs are necessary to notify the vCPU that originally
> submitted the request.
>

Thanks for the explanation.  I wasn't aware of this aspect of using
multiple queues but it makes sense now why we wouldn't want to spread
the requests across different queues.

> Even if you don't care about SMP performance, using multiqueue as a
> workaround for missing request parallelism still won't yield the best
> results.  The guest should be able to submit up to the maximum queue
> depth of the physical storage device.  Many Linux block drivers have max
> queue depths of 64.  This would require 64 virtqueues (plus the queue
> selection algorithm would have to utilize each one) and shows how
> wasteful this approach is.
>

I understand this but in practice unlike the virtio-blk workload,
which is nothing but reads and writes to a single file, the virtio-fs
workload tends to mix a bunch of metadata operations with data
transfers.  The metadata operations should be mostly handled out of
the host's file cache so it's unlikely virtio-fs would really be able
to fully utilize the underlying storage short of reading or writing a
really huge file.

> Instead of modifying the guest driver, please implement request
> parallelism in your device implementation.

Yes, we have tried this already [1][2].  As I mentioned above, having
additional threads in the server actually made performance worse.  My
theory is that when the device only has 2 cpus, having additional
threads on the host that need cpu time ends up taking time away from
the guest vcpu.  We're now looking at switching to io_uring so that we
can submit multiple requests from a single thread.

The multiqueue change was small and I wasn't aware of the SMP
implications, which is why I sent this patch.

Thanks,
Chirantan

[1] https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/2103602
[2] https://chromium-review.googlesource.com/c/chromiumos/platform/crosvm/+/2103603
