Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D41A60E018
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 13:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiJZL7H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 07:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbiJZL65 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:58:57 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21EAB1DF4
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Oct 2022 04:58:55 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v27so18765096eda.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Oct 2022 04:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iuKzCi0B1XJPd+CkqlA0IBXRciUSIxmq7GoO7KNmYdw=;
        b=RJYHZ00XqVVFiP00vEcA2KLr+zbQgz1mXTd0OQ52fKHjDFeY+i/PhoirIsGVm0r2Lk
         ym+KFAambGlWQ9D5zilbOCejKpOUyLUixCOc+NajoognuFj6SUvmM78+K4KuaXuDXleP
         MEBUvVb2I9PkcyUYur1wKoTecxudr9meSDTmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iuKzCi0B1XJPd+CkqlA0IBXRciUSIxmq7GoO7KNmYdw=;
        b=XgfEGP5JEtUaPP5uHXiqff0VQJQCmBdnsLmCYzDBBFR7p0qRp/4k/izX+QtppB2IpY
         ig8l19W0HvYTuz862Kluc+nhz9ACR8Ba05/ehr6ajOnSZ69VgvjVG1iCy/bfI2WKtgNZ
         iBlpLF21826rfVZ36j4XgAn6XEi4UByOE3Wo7BiYmsORDX9VQ9/eLbhvTNwxhIxlHHx1
         Qj/aVH0QUxm60H1K0TKQgZfB2zsbA1pyYuptKQo9UyDArn4DEcGX1JfCujj7EXg+NAfh
         zJ/eZLR8PoKG58vHaEmXg1bKj9EVeUhQBdFveE5jjbx71akqUbiRnXN7XIM+Vnjnu76U
         il+g==
X-Gm-Message-State: ACrzQf3tWTuGKFe2sKI1/aVJmNO+ZKBwHWStxquZpuuOE7/BLAQ/A8G4
        sqifkdHoZN2VdD5MpWkFNwAtlFmFWNJO0sPBT80Dig==
X-Google-Smtp-Source: AMsMyM7ncRMXGyK4TU7u73eO0IHI5gq8pOpFBbObsfXlQwTF2gdWNOM6/BgKBsVFJe2UQ7AFFzIUoaMugmmnmNZ4Rzk=
X-Received: by 2002:aa7:c61a:0:b0:461:c48d:effe with SMTP id
 h26-20020aa7c61a000000b00461c48deffemr14486812edq.7.1666785534078; Wed, 26
 Oct 2022 04:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <87mtaxt05z.fsf@vostro.rath.org> <CAJfpegv=1UjycheWyANxsoOM5oCf7DGs9OKNzhNw_dSETBDCVQ@mail.gmail.com>
 <7d293f21-c0b4-46eb-6822-4015560f787e@spawn.link>
In-Reply-To: <7d293f21-c0b4-46eb-6822-4015560f787e@spawn.link>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 26 Oct 2022 13:58:43 +0200
Message-ID: <CAJfpegt0bt6UDPy1Z2b=MZ1yAWg5xphDhTm6s-TjEnqy30xQCA@mail.gmail.com>
Subject: Re: Should FUSE set IO_FLUSHER for the userspace process?
To:     Antonio SJ Musumeci <trapexit@spawn.link>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        miklos <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 25 Oct 2022 at 17:39, Antonio SJ Musumeci <trapexit@spawn.link> wrote:
>
> On 9/19/22 05:20, Miklos Szeredi wrote:
> > On Sun, 18 Sept 2022 at 13:03, Nikolaus Rath <Nikolaus@rath.org> wrote:
> >> Hi,
> >>
> >> Should the FUSE kernel driver perhaps set PR_SET_IO_FLUSHER for the FUSE
> >> userspace process daemon when a connection is opened?
> >>
> >> If I understand correctly, this is necessary to avoid a deadlocks if the
> >> kernel needs to reclaim memory that has to be written back through FUSE.
> > The fuse kernel driver is careful to avoid such deadlocks.  When
> > memory reclaim happens, it copies data to temporary buffers and
> > immediately finishes the reclaim from the memory management
> > subsystem's point of view.   The temp buffers are then sent to
> > userspace and written back without having to worry about deadlocks.
> > There are lots of details missing from the above description, but this
> > is the essence of the writeback deadlock avoidance.
> >
> > Thanks,
> > Miklos
>
> Miklos, does this mean that FUSE servers shouldn't bother setting
> PR_SET_IO_FLUSHER? Are there any benefits to setting it explicitly or
> detriments to not setting it?

PR_SET_IO_FLUHSER internally sets the process flags PF_MEMALLOC_NOIO
and PF_LOCAL_THROTTLE.

The former is clear: don't try to initiate I/O when memory needs to be
reclaimed.  This could be detrimental in low memory situations, since
the kernel has less choice for freeing up memory.

PF_LOCAL_THROTTLE  seems to mean "don't throttle dirtying pages
(writes) by this process, since that would throttle the cleaning of
dirty pages."   This logic seems valid for fuse as well, but it also
upsets the normal dirty throttling mechanisms, so I'm not sure that
there aren't any side effects.

Thanks,
Miklos
