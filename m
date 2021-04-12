Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490D235C96D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 17:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242621AbhDLPJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 11:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237526AbhDLPJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:09:02 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DB2C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 08:08:44 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id z23so3143485uan.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Apr 2021 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1bLXXtn/sInxr42wR069i3XMC3oTpYxOTPRZIb4fmKU=;
        b=oY9yjkS1FrppbTvlvHCyp5rRI61lxpfIFVSJ+I4eIHxXCYxzRX1F4If4V+kRn705Dt
         sNE/nIhMmgdKOXkvVGXBNez+sqrtGp4KTWMGL+eiacWPEtWfkponUZVNRvLxVkVnJmjG
         eZ6mSSdhW3M3NjQejemsvqmtoQvDDvYbpOGps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1bLXXtn/sInxr42wR069i3XMC3oTpYxOTPRZIb4fmKU=;
        b=ceVLNVRhG1tnGa7QoN8mEFos8ylFOwgbTMH9SYYyVMFWnyM2g3tzYrgwti/PQuNpl+
         lF+w/zeuaeXGj71VZuuisQi7WIFbaFGf0Slt5ifVSXBYolM5OLmXeQCPPp8TBFH4XUkt
         0LOn2u78OHwwnBG9fbfEI2X6nUblyvtsmpwKdgMjEOgHM05uCfp5YpXwQd3C7CtSkhBM
         U/9HKP+zE+nebUhgFpa9qh/0v4juAMyt206oEZXnJHFgOC4S8TJ9tk7x6cZaRoFmkdxS
         OMhXQfEWG9B20nYf6kKbIpE9zRXh7vwbUaiZTVs3+eKCq4wh2/pXYgikzQQK8ozbof1a
         Pqzw==
X-Gm-Message-State: AOAM53022yDiHs3t0fyvJHP1lVmGm10P01dMb/aJL/SSxD1vq/R7whUr
        ixzFEakg9oWtrmCcHnVQJpc2B2V6kF1Yn30I240qcA==
X-Google-Smtp-Source: ABdhPJz8218kHP6eQ2nPsx4NsOzbxFpoVxnBM6obnMyRZ9T7/zBS7lSTfean/Ovipc83BDQTfhqgRbqbr2v4KJ4aeJM=
X-Received: by 2002:ab0:596f:: with SMTP id o44mr19669610uad.8.1618240117339;
 Mon, 12 Apr 2021 08:08:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210412145919.GE1184147@redhat.com>
In-Reply-To: <20210412145919.GE1184147@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 12 Apr 2021 17:08:26 +0200
Message-ID: <CAJfpegsaY05jSRNFTcquNFyMr+GMpPBMgoEO0YZcXxfqBi3g2A@mail.gmail.com>
Subject: Re: Query about fuse ->sync_fs and virtiofs
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     virtio-fs-list <virtio-fs@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>,
        Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Robert Krawitz <rkrawitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 12, 2021 at 4:59 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> Hi Miklos,
>
> Robert Krawitz drew attention to the fact that fuse does not seem to
> have a ->sync_fs implementation. That probably means that in case of
> virtiofs, upon sync()/syncfs(), host cache will not be written back
> to disk. And that's not something people expect.
>
> I read somewhere that fuse did not implement ->sync_fs because file
> server might not be trusted and it could block sync().
>
> In case of virtiofs, file server is trusted entity (w.r.t guest kernel),
> so it probably should be ok to implement ->sync_fs atleast for virtiofs?

Yes, that looks like a good idea.

Thanks,
Miklos
