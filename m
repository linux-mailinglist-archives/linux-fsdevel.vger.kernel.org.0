Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBB477D369
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Aug 2023 21:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239867AbjHOTeC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 15:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbjHOTd5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:33:57 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5961980
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 12:33:49 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe7e67cc77so9472201e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Aug 2023 12:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1692128028; x=1692732828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xmf+TGMCsXuzPEbAST4gOM2mzvHg6+6qPwW2xotInzI=;
        b=JzVgoDbVKWvJGusTAwlta4g1wIpmuOcaH434Fpl3W63sHqcUiwiXcq9sJlIVTld96R
         BentIhF76E5Et23XX14HWLjjiKEZJ4GHQJ8mArUysn2sSpqYP5RSg1AjF39pVtvkbW7m
         hFEYGINz3Joa9+1hPAOXx52VuTabSFQ3nWzlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692128028; x=1692732828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xmf+TGMCsXuzPEbAST4gOM2mzvHg6+6qPwW2xotInzI=;
        b=QIrYdoxLb+U9t4Gxf0Gwrg4A/mx8ULY3n6JG7dG77L2zDE66bohi6S+cmJQ1QQgGZ5
         jExsHGkwCkqSlbDFfLr/rtx+cX9KJa//TqqO2wBodl6jnba9XL2r+PSLAa7uKVgvDUT6
         bCm7TohIX2noxvc+hlvv+2M6Q8fqJ4uQqfPc37GOUqdHJzntxoFHzJsMh4nQ9so26Omr
         alcZvkhDkEHa+q8vcoIvwljQdNbjREnJoYT0XRYFi0KCHThl5piwcsrZi/d/0/LRlZD6
         fo5mPtOOBCOvouBCztZ38TyY0mdlvMrcu5ovkabQCDnDnCjyCBpbvP32tSL89oWPFgZ4
         9oJg==
X-Gm-Message-State: AOJu0Yz6kRXViCbYfrPV6QHCM8FzJFMeYqL7bHaC8cz5+Uy+UQiz7+hX
        L5JA49aT86uSIAKHJGI8kUmuGeGsWRR+GjMYa4Jd6AURN832awammOQ=
X-Google-Smtp-Source: AGHT+IF78oX0Ns9rJuvtWxTxnEYf4TyE1TSp60Nb6jLwXSZZ0irCCrOubq0Sl5dZP2gUGHittrDmhDAcMV7LklCQFLY=
X-Received: by 2002:a05:6512:70c:b0:4fa:ad2d:6c58 with SMTP id
 b12-20020a056512070c00b004faad2d6c58mr7738597lfs.61.1692128027394; Tue, 15
 Aug 2023 12:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230811183752.2506418-1-bschubert@ddn.com> <20230811183752.2506418-4-bschubert@ddn.com>
 <CAJfpegtsCPZ_c2J7o08kgT8z9UNkTJ0BD5R1yT2_fT+ZPH+Q_w@mail.gmail.com> <9a8170ea-fc4d-f8f9-9726-8cc46f545e0d@ddn.com>
In-Reply-To: <9a8170ea-fc4d-f8f9-9726-8cc46f545e0d@ddn.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 15 Aug 2023 21:33:36 +0200
Message-ID: <CAJfpegsP6AnwdzMc6o4dFeLKkE_yaxL=-ejD+S7tqvuLpXBaRA@mail.gmail.com>
Subject: Re: [PATCH 3/6] [RFC] Allow atomic_open() on positive dentry
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "bernd.schubert@fastmail.fm" <bernd.schubert@fastmail.fm>,
        "fuse-devel@lists.sourceforge.net" <fuse-devel@lists.sourceforge.net>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dharmendra Singh <dsingh@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 15 Aug 2023 at 11:56, Bernd Schubert <bschubert@ddn.com> wrote:
>
> On 8/15/23 10:03, Miklos Szeredi wrote:
> > On Fri, 11 Aug 2023 at 20:38, Bernd Schubert <bschubert@ddn.com> wrote:
> >>
> >> From: Miklos Szeredi <miklos@szeredi.hu>
> >>
> >> atomic_open() will do an open-by-name or create-and-open
> >> depending on the flags.
> >>
> >> If file was created, then the old positive dentry is obviously
> >> stale, so it will be invalidated and a new one will be allocated.
> >>
> >> If not created, then check whether it's the same inode (same as in
> >> ->d_revalidate()) and if not, invalidate & allocate new dentry.
> >>
> >> Changes from Miklos initial patch (by Bernd):
> >> - LOOKUP_ATOMIC_REVALIDATE was added and is set for revalidate
> >>    calls into the file system when revalidate by atomic open is
> >>    supported - this is to avoid that ->d_revalidate() would skip
> >>    revalidate and set DCACHE_ATOMIC_OPEN, although vfs
> >>    does not supported it in the given code path (for example
> >>    when LOOKUP_RCU is set)).
> >
> > I don't get it.   We don't get so far as to set DCACHE_ATOMIC_OPEN if
> > LOOKUP_RCU is set.
>
>
> See lookup_fast, there are two calls to d_revalidate() that have
> LOOKUP_ATOMIC_REVALIDATE and one in RCU mode that does not.
> With the new flag LOOKUP_ATOMIC_REVALIDATE we tell ->revalidate()
> that we are in code path that supports revalidating atomically.
>
> Sure, ror RCU we can/should always return -ECHILD in fuse_dentry_revalidate when
> LOOKUP_RCU is set.  But then it is also easy to miss that - at a minimum we
> need to document that DCACHE_ATOMIC_OPEN must not be set in RCU mode.

I wouldn't say "must not".  Setting DCACHE_ATOMIC_OPEN would result in
ATOMIC_OPEN being used instead of plain OPEN.  This may be less
optimal in cases when the dentry didn't need to be revalidated, but
AFAICS it wouldn't result in a bug.

BTW I don't see DCACHE_ATOMIC_OPEN being cleared in this patchset,
which just shows that it's quite safe ;)

I'm not at all sure that DCACHE_ATOMIC_OPEN is the best mechanism for
this job.  Returning a specific value from ->d_revalidate might be
better.

Thanks,
Miklos
