Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE5D50DAE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 10:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiDYINV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 04:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237319AbiDYINH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:13:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3667B6454
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 01:10:02 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kq17so4906408ejb.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Apr 2022 01:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V/9MryFXBUk9FF6YyMTYHMUXvrP3+Xkf/wgXTlKPLPs=;
        b=b9ebbhTzeZ8GuXZ/4ewnCjrEVlORIdL0XUxOo9bMSsPvDWWFp0xk66m7Na7Rlcvkxd
         rrAlS4sHcIdZiajhw6o6YX5O0+hvm8vKAtjMbd09q+HbwUpOp6B1yTdwUpcBRme6+PPg
         z25KzYDyGOZD9MIKQYW2REovkmW3jXrXeLUDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V/9MryFXBUk9FF6YyMTYHMUXvrP3+Xkf/wgXTlKPLPs=;
        b=aO9NwFZmUtXE3mnRDcIU++dCQAZdK2fUn2bvAXOrioIstWWMa70ZTEb9Mh8Vf6a5H9
         W5MQxXnTBauvbvXQtl6vzM0RnQKycQPnxDYEuehNGBozui9hE/pkzORslpgy0JRxukEM
         M7AYRd9vAXbrVp7TTWiY3KPNiinibC/wfSVhRSjkcHYXdSbPQmEIhUJ5DVvmDDeVFHxS
         8lRvGO/t4yEk5OqS/CDe2TvfyFFh2ReQk/3bgPr5HaT5FceYI5CTA0ys7+2f1EZNqv+8
         O8NuQG4j5WfRkNGiWpQU3OgEm4U1LQXrYw1A5WedeGqYVcobqY9pVfL7tMyGlhbEWgSw
         yYyA==
X-Gm-Message-State: AOAM533orqa4vU3BYHRItJD7lsnor9ve+H+7DfHM455nS9en0gF31JJM
        CN9jF8Ox5bh69TSidplA7eKS1gaVi7+TWOXDKst5Wg==
X-Google-Smtp-Source: ABdhPJw75OpIGEOXMANMEVZpoEzu+YYZ1j0DQTLMZx3GYh/4QD+CHjbpUUK4YHFGw2prVElyPb/dBddmOb8t8kj+wM0=
X-Received: by 2002:a17:906:280b:b0:6ce:f3c7:688f with SMTP id
 r11-20020a170906280b00b006cef3c7688fmr15024444ejc.468.1650874200249; Mon, 25
 Apr 2022 01:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <165002363635.1457422.5930635235733982079.stgit@localhost>
 <CAJfpegs=_bzBrmPSv_V3yQWaW7NR_f9CviuUTwfbcx9Wzudoxg@mail.gmail.com> <YmUKZQKNAGimupv7@redhat.com>
In-Reply-To: <YmUKZQKNAGimupv7@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Apr 2022 10:09:48 +0200
Message-ID: <CAJfpegsUfANp4a4gmAKLjenkdjoA-Gppja=LmwdF_1Gh3wdL4g@mail.gmail.com>
Subject: Re: [PATCH] fuse: Apply flags2 only when userspace set the
 FUSE_INIT_EXT flag
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Dharmendra Singh <dsingh@ddn.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        German Maglione <gmaglione@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 24 Apr 2022 at 10:29, Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Thu, Apr 21, 2022 at 05:36:02PM +0200, Miklos Szeredi wrote:
> > On Fri, 15 Apr 2022 at 13:54, Bernd Schubert <bschubert@ddn.com> wrote:
> > >
> > > This is just a safety precaution to avoid checking flags
> > > on memory that was initialized on the user space side.
> > > libfuse zeroes struct fuse_init_out outarg, but this is not
> > > guranteed to be done in all implementations. Better is to
> > > act on flags and to only apply flags2 when FUSE_INIT_EXT
> > > is set.
> > >
> > > There is a risk with this change, though - it might break existing
> > > user space libraries, which are already using flags2 without
> > > setting FUSE_INIT_EXT.
> > >
> > > The corresponding libfuse patch is here
> > > https://github.com/libfuse/libfuse/pull/662
> > >
> > >
> > > Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> >
> > Agreed, this is a good change.  Applied.
> >
> > Just one comment: please consider adding  "Fixes:" and "Cc:
> > <stable@....>" tags next time.   I added them now.
>
> I am afraid that this probably will break both C and rust version of
> virtiofsd. I had a quick look and I can't seem to find these
> implementations setting INIT_EXT flag in reply to init.
>
> I am travelling. Will check it more closely when I return next week.
> If virtiofsd implementations don't set INIT_EXT, I would rather prefer
> to not do this change and avoid breaking it.

Okay, let's postpone this kernel patch until libfuse and virtiofsd
implementations are updated.

Thanks,
Miklos
