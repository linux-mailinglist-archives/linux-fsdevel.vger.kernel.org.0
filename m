Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233503AC4B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 09:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbhFRHPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 03:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhFRHPL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 03:15:11 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2756C06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 00:13:01 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id t22so1430543uar.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 00:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTT5ZsIEPC31rh2i5dgbNFLjOHADYWpb81q5A6MltNs=;
        b=QR982XZHnvKy0kMVowEg8rOWXN3rOElV6H+cTm4PjI9w0oOdLfamzCj9dL/yidpq1X
         7Xs46nImgGkredeeD9pjVwid8kuLSWEB0mE+k7amBb5nZl7hf9LZ4bd7u+QkgnMhnio4
         cxn9+gUdcxReUj/ikV9V3irRVGgQkPIh3QQnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTT5ZsIEPC31rh2i5dgbNFLjOHADYWpb81q5A6MltNs=;
        b=Ff9/z5gbyjI9+M+uudPjm3H+JZQ/c7ki952pSr8SkpoamLWESII2zGhIE6cFkhF9QN
         jfxXApM/avC9ZfzE1W5OhvaZ5wqaB+Gaf8Ygnwd64gr5jNn8+ihMwo5k9KocaoUWHkgQ
         VT5I5BB6Ok60fLohWbQ10FShDUc1eDWFm/C5qm6XOnJ42m7i8nLSYoy5c8WW1/rFeC/Z
         l58zF39xn0mxT1fonKN6nswIKyYlFtPOg3VUAmzh4fhw07YnNFinuf0NAmoan9PMCOEH
         Cb40EAbuWC8OLqUjTlgrGX50G9t+aSYXeWdsGX8tG3D7P0fqgz+V/o0uzIdaJ1oX9cyI
         z9NQ==
X-Gm-Message-State: AOAM531FoYLJuyU+g49nfjlVLkyY4Bq8ILaLGh77/TU4vLIBKWpjWVWA
        vrMQCOY5RyeOWz0Y4qY/t2kF5O5PxU+pLERv1ZSAQQ==
X-Google-Smtp-Source: ABdhPJxllpxOra45K65lwZpKCY+dEU2zRZr2ziz7XoQ5lV4m+GwBGb6yoVY47QiteupuFAOi00da4FGaGtwVFYv5mB8=
X-Received: by 2002:ab0:2690:: with SMTP id t16mr10545968uao.9.1624000380770;
 Fri, 18 Jun 2021 00:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210512161848.3513818-1-rjones@redhat.com> <20210512161848.3513818-2-rjones@redhat.com>
 <CAJfpegv=C-tUwbAi+JMWrNb+pai=HiAU8YCDunE5yUZB7qMK1g@mail.gmail.com> <20210615103357.GP26415@redhat.com>
In-Reply-To: <20210615103357.GP26415@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 18 Jun 2021 09:12:49 +0200
Message-ID: <CAJfpegv6c6xR-ye9hj0AAiw_OsoYpHqTjH=jwAWPj4R2Wb6-1g@mail.gmail.com>
Subject: Re: [PATCH v4] fuse: Allow fallocate(FALLOC_FL_ZERO_RANGE)
To:     "Richard W.M. Jones" <rjones@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        eblake@redhat.com, libguestfs@redhat.com,
        Shachar Sharon <synarete@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 15 Jun 2021 at 12:34, Richard W.M. Jones <rjones@redhat.com> wrote:
>
> On Tue, May 18, 2021 at 03:56:25PM +0200, Miklos Szeredi wrote:
> > On Wed, 12 May 2021 at 18:19, Richard W.M. Jones <rjones@redhat.com> wrote:
> > >
> > > The current fuse module filters out fallocate(FALLOC_FL_ZERO_RANGE)
> > > returning -EOPNOTSUPP.  libnbd's nbdfuse would like to translate
> > > FALLOC_FL_ZERO_RANGE requests into the NBD command
> > > NBD_CMD_WRITE_ZEROES which allows NBD servers that support it to do
> > > zeroing efficiently.
> > >
> > > This commit treats this flag exactly like FALLOC_FL_PUNCH_HOLE.
> >
> > Thanks, applied.
>
> Hi Miklos, did this patch get forgotten?

It's in my internal patch queue.   Will push to fuse.git#for-next in a few days.

Thanks,
Miklos
