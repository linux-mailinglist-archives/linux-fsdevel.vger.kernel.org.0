Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5A47243B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 15:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238013AbjFFNHd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 09:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238025AbjFFNHZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:07:25 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B810172B
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 06:07:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-977cf86aae5so415517066b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jun 2023 06:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1686056801; x=1688648801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdcAHdcfevDGcVfHZvMqdM90hrjxBWSTRshUWMpX00w=;
        b=OLLsOOHX7r7LCPDVHJbMzNBQkNiZ9X/7EOcCz56WGOPdyC2dntTTFukrhFyHwrSAXu
         W+xGvn7PiQLWt5hUwfjq1mFlr3hCi7tkdq1kLAeUXzPBkZ0HV4U2PkR2B7KQRvxPbcf2
         MjfmPPFqTHm/yliN3/+0VpGHYn+oHhJGO5ZJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686056801; x=1688648801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdcAHdcfevDGcVfHZvMqdM90hrjxBWSTRshUWMpX00w=;
        b=gEGdBEgukUTNLQF0ZJszxLKLWv8QtnR9k5Qyn6yyVPKbt2sC6tv2jHYwy7leHmVqnW
         JB3J3APILb3Cm7hq9+lrR1lE/cOtdDwO6i9qVqGH9OeZyLBtEOHwmK1NLAUenrq0KvV3
         oIKVscguIOoSz/iXisP1Jtg8PBxp6zcq2mcMy99cKiyl5Ne1di+O+x5YxKErefZOlW3A
         4TrkidkjY3G4DzW/wXrwuK7itwLKwxVVqUlcmnKjrjNS0gUB+dIQcqq/f2wAOr/9RNLb
         iX4iyl1/mg42hLh5rkDkpxzpGLU9B6ilJdv+MAiaP+SxNZrDPmHanbYNaVcusbs5sqc5
         jePg==
X-Gm-Message-State: AC+VfDyj9MLMxW4frTzho4+ZRHOg1xWFdgns8cpwyMjNB7YR6e1G6uP/
        w86G9dQi6sJW3ClCcktgIFsG/5gXMpzv+oH+B29w8w==
X-Google-Smtp-Source: ACHHUZ45D4b8IA+yec4ZpUOTn/vBlVGJD/LERu2OBA/3VxqknBizp0oEd9lFYFce0XbpzioPxs0G7W6Zth0rzFj9XlU=
X-Received: by 2002:a17:907:9620:b0:978:6be4:7efa with SMTP id
 gb32-20020a170907962000b009786be47efamr2596335ejc.18.1686056800861; Tue, 06
 Jun 2023 06:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230519125705.598234-1-amir73il@gmail.com> <CAOQ4uxibuwUwaLaJNKSifLHBm9G-Tgn67k_TKWKcN1+A4Rw-zg@mail.gmail.com>
 <CAJfpegucD6S=yUTzpQGsR6C3E64ve+bgG_4TGP7Y+0NicqyQ_g@mail.gmail.com> <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
In-Reply-To: <CAOQ4uxjGWHnwd5fcp8VwHk59q=BftAhw0uYbdR-KmJCq3fpnDg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 6 Jun 2023 15:06:29 +0200
Message-ID: <CAJfpegu2+aMaEmUCjem7em0om8ZWr0ENfvihxXMkSsoV-vLKrw@mail.gmail.com>
Subject: Re: [PATCH v13 00/10] fuse: Add support for passthrough read/write
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>,
        Paul Lawrence <paullawrence@google.com>,
        Alessio Balsini <balsini@android.com>,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 6 Jun 2023 at 13:19, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Jun 6, 2023 at 12:49=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu=
> wrote:
> >
> > On Tue, 6 Jun 2023 at 11:13, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Fri, May 19, 2023 at 3:57=E2=80=AFPM Amir Goldstein <amir73il@gmai=
l.com> wrote:
> > > >
> > > > Miklos,
> > > >
> > > > This patch set addresses your review feedback on Alesio's V12 patch=
 set
> > > > from 2021 [1] as well as other bugs that I have found since.
> > > > This patch set uses refcounted backing files as we discussed recent=
ly [2].
> > > >
> > > > I am posting this for several possible outcomes:
> > > >
> > > > 1. Either FUSE-BPF develpers can use this as a reference implementa=
tion
> > > >    for their 1st phase of "backing file passthrough"
> > > > 2. Or they can tell me which API changes need to made to this patch=
 set
> > > >    so the API is flexible enough to extend to "backing inode passth=
rough"
> > > >    and to "BPF filters" later on
> > > > 3. We find there is little overlap in the APIs and merge this as is
> > > >
> > > > These patches are available on github [3] along with libfuse patche=
s [4].
> > > > I tested them by running xfstests (./check -fuse -g quick.rw) with =
latest
> > > > libfuse xfstest support.
> > > >
> > > > Without FOPEN_PASSTHROUGH, one test in this group fails (generic/45=
1)
> > > > which tests mixed buffered/aio writes.
> > > > With FOPEN_PASSTHROUGH, this test also passes.
> > > >
> > > > This revision does not set any limitations on the number of backing=
 files
> > > > that can be mapped by the server.  I considered several ways to add=
ress
> > > > this and decided to try a different approach.
> > > >
> > > > Patch 10 (with matching libfuse patch) is an RFC patch for an alter=
native
> > > > API approach. Please see my comments on that patch.
> > > >
> > >
> > > Miklos,
> > >
> > > I wanted to set expectations w.r.t this patch set and the passthrough
> > > feature development in general.
> > >
> > > So far I've seen comments from you up to path 5/10, so I assume you
> > > did not get up to RFC patch 10/10.
> > >
> > > The comments about adding max stack depth to protocol and about
> > > refactoring overlayfs common code are easy to do.
> > >
> > > However, I feel that there are still open core design questions that =
need
> > > to be spelled out, before we continue.
> > >
> > > Do you find the following acceptable for first implementation, or do =
you
> > > think that those issues must be addressed before merging anything?
> > >
> > > 1. No lsof visibility of backing files (if server closes them)
> > > 2. Derived backing files resource limit (cannot grow beyond nr of fus=
e files)
> > > 3. No data consistency guaranty between different fd to the same inod=
e
> > >     (i.e. backing is per fd not per inode)
> >
> > I think the most important thing is to have the FUSE-BPF team onboard.
>
> Yeh, I'd love to get some feedback from you guys.
>
> >    I'm not sure that the per-file part of this is necessary, doing
> > everything per-inode should be okay.   What are the benefits?
> >
>
> I agree that semantics are simpler with per-inode.
> The only benefit I see to per-file is the lifetime of the mapping.
>
> It is very easy IMO to program with a mapping scope of
> open-to-close that is requested by FOPEN_PASSTHROUGH
> and FOPEN_PASSTHROUGH_AUTO_CLOSE.

Right, and this case the resource limiting is also easy to think about.

I'm not worried about consistency, fuse server can do whatever it
wants with the data anyway.  I am worried about the visibility of the
mapping.  One idea would be to create a kernel thread for each fuse sb
instance and install mapped files into that thread's file table.  In
theory this should be trivial as the VFS has all the helpers that can
do this safely.

>
> But I think the same lifetime can still be achieved with per-inode
> mapping. I hand waved how I think that could be done in response
> to patch 10/10 review.

Yeah, but it's just complicating things further.


>
> I think if I can make this patch set work per-inode, the roadmap
> from here to FUSE-BPF would be much more clear.

One advantage of per-inode non-autoclose would be that open could be
done without a roundtrip to the server.   However the resource
limiting becomes harder to think about.

So it might make sense to just create two separate modes:

 - per-open unmap-on-release (autoclose)
 - per-inode unmap-on-forget (non-autoclose, mapping can be torn down
explicitly)

We also should at least consider (even if not supported in the first
version) the block-fuse case where the backing file(s) contain the
disk image.  In this case the backing fd registration would be per-fs
not per-inode, and the mapping would contain the
backing_fd/backing_offset pair.

>
> > Not having visibility and resource limits would be okay for a first
> > version, as long as it's somehow constrained to privileged use.  But
> > I'm not sure it would be worth it that way.
> >
>
> Speaking on behalf of my own use case for FUSE passthrough (HSM),
> FUSE is used for "do something that does not belong in the kernel",
> but running as unprivileged user is a non-requirement.
> So I can say with confidence of paying customers that passthrough is
> useful and essential even with privileged user constraint.
>
> In summary, I will try to come up with v14 that is:
> - privileged user only
> - no resource limitation
> - per-inode mapping

Okay, that's a logical first step.

Thanks,
Miklos
