Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0AD6C6873
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 13:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjCWMfl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 08:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjCWMfk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:35:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED9625B95
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 05:35:37 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id cy23so85750276edb.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Mar 2023 05:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1679574935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3QOrYAgvj8kusP0/AhT75cB9Z53B9qRITxx/b6REMhI=;
        b=TasKnGAG6bSFdw29iAUqdv/hFXWl7QYGA+OvIvSIgzqg29wTFprksxjyeWJGiT3YLy
         RbwgOjpOoxYBUU3gucANEDgRu+9CmZkUuS+Ib9yEZRgmPyNC2bsGJJawBz6SD1vB+T7c
         k6asgH9Bt8iinYsomgwFCX1UwVYYEyH8BAa+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679574935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3QOrYAgvj8kusP0/AhT75cB9Z53B9qRITxx/b6REMhI=;
        b=4NnfbYLWinbNpb7BggI8pWVxa/6o2mtKUQbHV9UgfqHuBNoN1ZXDtna/99K5gBSlsj
         tdryb0j7HTiuT9EerwzVWqffHF8xSM1MCsdVJnWNaFw02neUqUtag7sTulvm5FHgdg4s
         Nt68XQBUMeXdYUobtsLTmPIeydRAxhiXF0e9JZgJocWI+lWOMWEK9R9yihNbZmYb2mpD
         6U2A3NW6HGle7kS6tObqkJsq2oGirTCEBnuseRViTste+/HPWGmzt0LQGYZHz6KjGDVB
         1zYaUc+RsIvTatt3n8UgHKrMGqm8lzV0gLVF07SresG4YADXCl33U6kS8aHJgARcDOni
         4f5w==
X-Gm-Message-State: AO0yUKWKy3VAWRWiGpnbRYi+Gozw7lU6SDmL0hIpwCOrJM1se3HfIaKR
        6p6dvR1TpycISC3GZX1DBr5ojq9kJ9qDCTe5B4mmfQ==
X-Google-Smtp-Source: AK7set8BHAqlQuCZs/lGfvchp6TYXu+vep4KZbkMUpu2vi4Dr6mc0aQrPhSIkgGOsk8Gtpwrfklx+XyQAl8z+GXUhxg=
X-Received: by 2002:a17:906:95d6:b0:932:6a2:ba19 with SMTP id
 n22-20020a17090695d600b0093206a2ba19mr4937602ejy.14.1679574935600; Thu, 23
 Mar 2023 05:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230321011047.3425786-1-bschubert@ddn.com> <20230321011047.3425786-7-bschubert@ddn.com>
 <CAJfpegs6z6pvepUx=3zfAYqisumri=2N-_A-nsYHQd62AQRahA@mail.gmail.com> <28a74cb4-57fe-0b21-8663-0668bf55d283@ddn.com>
In-Reply-To: <28a74cb4-57fe-0b21-8663-0668bf55d283@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 23 Mar 2023 13:35:24 +0100
Message-ID: <CAJfpeguvCNUEbcy6VQzVJeNOsnNqfDS=LyRaGvSiDTGerB+iuw@mail.gmail.com>
Subject: Re: [PATCH 06/13] fuse: Add an interval ring stop worker/monitor
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Dharmendra Singh <dsingh@ddn.com>,
        Amir Goldstein <amir73il@gmail.com>,
        "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
        Ming Lei <ming.lei@redhat.com>,
        Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 23 Mar 2023 at 12:04, Bernd Schubert <bschubert@ddn.com> wrote:
>
> Thanks for looking at these patches!
>
> I'm adding in Ming Lei, as I had taken several ideas from ublkm I guess
> I also should also explain in the commit messages and code why it is
> done that way.
>
> On 3/23/23 11:27, Miklos Szeredi wrote:
> > On Tue, 21 Mar 2023 at 02:11, Bernd Schubert <bschubert@ddn.com> wrote:
> >>
> >> This adds a delayed work queue that runs in intervals
> >> to check and to stop the ring if needed. Fuse connection
> >> abort now waits for this worker to complete.
> >
> > This seems like a hack.   Can you explain what the problem is?
> >
> > The first thing I notice is that you store a reference to the task
> > that initiated the ring creation.  This already looks fishy, as the
> > ring could well survive the task (thread) that created it, no?
>
> You mean the currently ongoing work, where the daemon can be restarted?
> Daemon restart will need some work with ring communication, I will take
> care of that once we have agreed on an approach. [Also added in Alexsandre].
>
> fuse_uring_stop_mon() checks if the daemon process is exiting and and
> looks at fc->ring.daemon->flags & PF_EXITING - this is what the process
> reference is for.

Okay, so you are saying that the lifetime of the ring is bound to the
lifetime of the thread that created it?

Why is that?

I'ts much more common to bind a lifetime of an object to that of an
open file.  io_uring_setup() will do that for example.

It's much easier to hook into the destruction of an open file, than
into the destruction of a process (as you've observed). And the way
you do it is even more confusing as the ring is destroyed not when the
process is destroyed, but when a specific thread is destroyed, making
this a thread specific behavior that is probably best avoided.

So the obvious solution would be to destroy the ring(s) in
fuse_dev_release().  Why wouldn't that work?

Thanks,
Miklos
