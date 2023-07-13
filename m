Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB80752C3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 23:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232593AbjGMVe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 17:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjGMVe5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 17:34:57 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452FD30EE
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 14:34:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-314313f127fso1340800f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Jul 2023 14:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689284069; x=1691876069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Z9ExxShnMFQ+6I5uZ5HSYqKDhYmMF4V08BZ/iO202I=;
        b=h96b3lCadCzWegH3hy0ZB2qQb2VZ9g0nshLIbNVzMENhuzrBxLTtfdh7mmX90L1hwe
         RZfzF4Aa5SynwDTuf1h66O484szaN5D9Kl6XuazI2Ihx4qpiFs3t5c/PsFAPpgQJOIGL
         X0GmfjEclYmAKt73DrMFCY70GggFKLYn2hzgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689284069; x=1691876069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Z9ExxShnMFQ+6I5uZ5HSYqKDhYmMF4V08BZ/iO202I=;
        b=aOzqeWvagedBsvcxKSTPaSdyCdXKhQmvSMjxIIhQ8gas5WNMvMlF6kIQwfqv/P7Chl
         rna+fZ3G7BRqEdvUqWqPWwsBHMOQILDrwXqGv6fvtuycHCzce1gnuYXcIv4wPcy8BOQH
         DlEebfam5K+opWSVPoC4t/bBZc1xCcvdpKKRHLYN7nky++d0Afy08+UfulIOhej+Nogw
         a4ZYrOKv6QEaRkRow//VtzPvKQj8kYhX4UGhegBxo2zcspmBPICNEd5bbQ0RWtAQxXBY
         NiqxQs8ES9AJO3TEBRjrk9IlfkSdb3P9ES3SgISnecdgG2qn5l+zFQOY+SlXk/nS4Ayx
         Mqfw==
X-Gm-Message-State: ABy/qLYsvzvNnLB9lEw+weY+4quVGtZmnjZx/52tMuKiUtd/4+9r69Fe
        19cNeOKa6MuoRPNQZlfE96Jzb2LgxUVZImcL3t4xvA==
X-Google-Smtp-Source: APBJJlEoBICt+M1o2fpsiTHu4cykBm4jfvf7AttkoM7qNKhXs+8mqzzxbWSkihKb2n+cgh1OVWaS8/sgVq5hlVOTAdA=
X-Received: by 2002:a05:6000:c2:b0:314:2fe5:b4cf with SMTP id
 q2-20020a05600000c200b003142fe5b4cfmr2116161wrx.53.1689284069583; Thu, 13 Jul
 2023 14:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230710183338.58531-1-ivan@cloudflare.com> <2023071039-negate-stalemate-6987@gregkh>
 <CABWYdi39+TJd1qV3nWs_eYc7XMC0RvxG22ihfq7rzuPaNvn1cQ@mail.gmail.com>
 <CAOQ4uxiFhkSM2pSNLCE6cLz6mhYOvk5D7vDsghVTqy9cDqeqew@mail.gmail.com>
 <CABWYdi26iboFTFz+Vex3VO0fzmFzyfOxgr-qc964mLiC3En7=A@mail.gmail.com> <CAOQ4uxgLp+gwJPTWj9uwhncx8RD5-mZY7qOaD2C6pbu7c4+srw@mail.gmail.com>
In-Reply-To: <CAOQ4uxgLp+gwJPTWj9uwhncx8RD5-mZY7qOaD2C6pbu7c4+srw@mail.gmail.com>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Thu, 13 Jul 2023 14:34:18 -0700
Message-ID: <CABWYdi2fTLnQeZnLG2uTCHyQkBnr1Z9OtfYhnzp_TtqiXyYd9A@mail.gmail.com>
Subject: Re: [PATCH] kernfs: attach uuid for every kernfs and report it in fsid
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, kernel-team@cloudflare.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 11, 2023 at 10:44=E2=80=AFPM Amir Goldstein <amir73il@gmail.com=
> wrote:
> > > I agree. I think it was a good decision.
> > > I have some followup questions though.
> > >
> > > I guess your use case cares about the creation of cgroups?
> > > as long as the only way to create a cgroup is via vfs
> > > vfs_mkdir() -> ... cgroup_mkdir()
> > > fsnotify_mkdir() will be called.
> > > Is that a correct statement?
> >
> > As far as I'm aware, this is the only way. We have the cgroups mailing
> > list CC'd to confirm.
> >
> > I checked systemd and docker as real world consumers and both use
> > mkdir and are visible in fanotify with this patch applied.
> >
> > > Because if not, then explicit fsnotify_mkdir() calls may be needed
> > > similar to tracefs/debugfs.
> > >
> > > I don't think that the statement holds for dieing cgroups,
> > > so explicit fsnotify_rmdir() are almost certainly needed to make
> > > inotify/fanotify monitoring on cgroups complete.
> > >
> > > I am on the fence w.r.t making the above a prerequisite to merging
> > > your patch.
> > >
> > > One the one hand, inotify monitoring of cgroups directory was already
> > > possible (I think?) with the mentioned shortcomings for a long time.
> > >
> > > On the other hand, we have an opportunity to add support to fanotify
> > > monitoring of cgroups directory only after the missing fsnotify hooks
> > > are added, making fanotify API a much more reliable option for
> > > monitoring cgroups.
> > >
> > > So I am leaning towards requiring the missing fsnotify hooks before
> > > attaching a unique fsid to cgroups/kernfs.
> >
> > Unless somebody responsible for cgroups says there's a different way
> > to create cgroups, I think this requirement doesn't apply.
> >
>
> I was more concerned about the reliability of FAN_DELETE for
> dieing cgroups without an explicit rmdir() from userspace.

I checked the code and cgroups are destroyed in cgroup_destroy_locked,
which is only called from two places:

* In cgroup_mkdir (only on failure)
* In cgroup_rmdir

See: https://elixir.bootlin.com/linux/v6.5-rc1/A/ident/cgroup_destroy_locke=
d

We should be covered here.
