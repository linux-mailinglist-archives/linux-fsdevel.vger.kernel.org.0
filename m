Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F5F1C8467
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 May 2020 10:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgEGIK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 May 2020 04:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgEGIK2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 May 2020 04:10:28 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA9CC061A10
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2020 01:10:27 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id a8so2484637ybs.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2020 01:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8Cu6HxLa77jfVaZq3CgdIap4XuJaTdN0YbC0ZBDI6M=;
        b=HHTWe/aw3WAO0yhwglTuWvnXtft80GNiSghWxIrZ8pm3zAl6YWCPBliDTGEgkmScPn
         GRXl7egcPPz7vscL5sn1MgH+ZlgS20+7153v5mN3c8Sv5/SOt/jdmqkdfKiaabkOmQmY
         JkkTTl0/M/DXPC/fmTCboG4vGxTAISZ/GlWe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8Cu6HxLa77jfVaZq3CgdIap4XuJaTdN0YbC0ZBDI6M=;
        b=Mjy4DmpyXi9iIag0KDQHIEOJRP64Hy87gLAbLL2D4zT65CrrX6O+7yzE5jfGOPPH2w
         yUiZ5m2rVUMjvf3PNaXjGPIpbRpw/mTPTcZxNqrNvOKFa5YnI+2KIasEEMu3ibwOb+Rp
         LqDatyONTyk75JUctGooWFpau7qHvPT07shE7faV/IOTKrLEzGu8PW/L/WZGwwf/8Hbg
         V+dIxg59SeI9zePILKLCmTsz8y/j0zwujtHDg5az3X3tsoS9/uywzBBzmzk7z3j46LLA
         A8wYHsF0TtnBDjBKMEibkWd57+CGHTX9Bu19bHTgLWIIaX9garMwB6exx8l9tc0U3y2P
         266A==
X-Gm-Message-State: AGi0PuZFloRrASaJ34SdD6BP26cSz4/MpkPSwM/Mx2td44Srz4BioW/p
        s6qwY017d4DKaolYV5ZZOD8UUzGYfBsoGWlS0s5wow==
X-Google-Smtp-Source: APiQypJCQTdVxRjuBFFsXs0gT1xdcUYEcYrD4ZAzch0VY2vs2mJSoKpfKRsJM7D1YGqA0M/kjdDVOVS3+4q+aOuqDx0=
X-Received: by 2002:a25:448a:: with SMTP id r132mr22208820yba.277.1588839026841;
 Thu, 07 May 2020 01:10:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200424062540.23679-1-chirantan@chromium.org>
 <20200424062540.23679-2-chirantan@chromium.org> <20200427151934.GB1042399@stefanha-x1.localdomain>
 <CAJFHJrr2DAgQC9ZWx78OudX1x6A57_vpLf4rJu80ceR6bnpbaQ@mail.gmail.com> <20200501154752.GA222606@stefanha-x1.localdomain>
In-Reply-To: <20200501154752.GA222606@stefanha-x1.localdomain>
From:   Chirantan Ekbote <chirantan@chromium.org>
Date:   Thu, 7 May 2020 17:10:15 +0900
Message-ID: <CAJFHJrpdbVKWyGuJJCBATVaYZsPLeg6JzpZmGFDsUcF_a4gcMA@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: virtiofs: Add basic multiqueue support
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>, slp@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 2, 2020 at 12:48 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Fri, May 01, 2020 at 04:14:38PM +0900, Chirantan Ekbote wrote:
> > On Tue, Apr 28, 2020 at 12:20 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > Instead of modifying the guest driver, please implement request
> > > parallelism in your device implementation.
> >
> > Yes, we have tried this already [1][2].  As I mentioned above, having
> > additional threads in the server actually made performance worse.  My
> > theory is that when the device only has 2 cpus, having additional
> > threads on the host that need cpu time ends up taking time away from
> > the guest vcpu.  We're now looking at switching to io_uring so that we
> > can submit multiple requests from a single thread.
>
> The host has 2 CPUs?  How many vCPUs does the guest have?  What is the
> physical storage device?  What is the host file system?

The host has 2 cpus.  The guest has 1 vcpu.  The physical storage
device is an internal ssd.  The file system is ext4 with directory
encryption.


>
> io_uring's vocabulary is expanding.  It can now do openat2(2), close(2),
> statx(2), but not mkdir(2), unlink(2), rename(2), etc.
>
> I guess there are two options:
> 1. Fall back to threads for FUSE operations that cannot yet be done via
>    io_uring.
> 2. Process FUSE operations that cannot be done via io_uring
>    synchronously.
>

I'm hoping that using io_uring for just the reads and writes should
give us a big enough improvement that we can do the rest of the
operations synchronously.

Chirantan
