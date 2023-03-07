Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E426B6ADE74
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 13:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCGMLj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 07:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjCGMLA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:11:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AFC574E3
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 04:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678191010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6IzXCAeP6Dubq95EPa2mh3fTeDRte3vj+v+ckpx6XqI=;
        b=JUUTMLGLnm+eI5dN6aFHVbD3ImNCKoWJJIy7/jAfZjkkkdJOE26rq/wpj5DlNwV6CP3fBK
        vjvTElFQGPH9p47iNWX9+85LqvuPw7T604n/obKXbomu1kPwVgg8qok/4wXaQHAa+ZUqpX
        yNqeYCD2U0hdNbGOsCaOI2m12r1EcqA=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-tnUeQA9KO5OlTWnCJh3a1w-1; Tue, 07 Mar 2023 07:10:09 -0500
X-MC-Unique: tnUeQA9KO5OlTWnCJh3a1w-1
Received: by mail-io1-f72.google.com with SMTP id v10-20020a056602058a00b007076e06ba3dso6946599iox.20
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Mar 2023 04:10:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678191008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6IzXCAeP6Dubq95EPa2mh3fTeDRte3vj+v+ckpx6XqI=;
        b=xGvkobSLSTmFlRYYvAg0Q2m4ljjhhEWHTOMgwmvfkwtPVj/aVRNT8bi34fJFy71Svl
         eW1B5etWceFT+xjyRySq09BaS2SHSqudLwUWAX9T3sTqhX+wjP6EPDCF1GqjwOMDtVry
         QHl4paO4qtZovP7Ips2yuugwl5DloiqFrIxWNkR9tjOCuqg+ddzllqKyf8FSrCg5EGMA
         hPTtkOz+dptKOP4ewygPKFVeGSsVQkL5xeFarvRl4uTkkaun47urAD76qaQO39FMvxU/
         UfcGe0kkz3YK5npImE7HhUCgCo7RmlvjgHdZSGwaINzrtLA2TqQ75BT1GMofabgqF1SP
         mYrQ==
X-Gm-Message-State: AO0yUKWL26RdnBTOp7cR5vWxdymBZCi3LQ5NXgMz0jfwukf53cxlj6F9
        f4dJg3x2bwztvYcqFvdNJAsq3Z1mKG/HJ9wRCQNwjwXQLmXoe4AHjN0uHZYzWGQ7/DdHWQOmi5j
        TfmnSRvRneESinQRfo83dKV61N3o2PJmjd2eo5ysKag==
X-Received: by 2002:a5e:c903:0:b0:745:5dec:be5a with SMTP id z3-20020a5ec903000000b007455decbe5amr6761064iol.1.1678191008535;
        Tue, 07 Mar 2023 04:10:08 -0800 (PST)
X-Google-Smtp-Source: AK7set8+pSksGkCoZOqcZWFRKJujJ0gcoA2/pt8H1EPn0ODMn5Uyegf0pbZQvyxqBg1HmymJ6CacaVcf9tF797RKrAk=
X-Received: by 2002:a5e:c903:0:b0:745:5dec:be5a with SMTP id
 z3-20020a5ec903000000b007455decbe5amr6761052iol.1.1678191008277; Tue, 07 Mar
 2023 04:10:08 -0800 (PST)
MIME-Version: 1.0
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <ffe56605-6ef7-01b5-e613-7600165820d8@linux.alibaba.com> <20230307101548.6gvtd62zah5l3doe@wittgenstein>
In-Reply-To: <20230307101548.6gvtd62zah5l3doe@wittgenstein>
From:   Alexander Larsson <alexl@redhat.com>
Date:   Tue, 7 Mar 2023 13:09:57 +0100
Message-ID: <CAL7ro1HuQnCJujCBq3W6SqM7GDs+Tyb7vRT60Q9EM++nsiRYVw@mail.gmail.com>
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
To:     Christian Brauner <brauner@kernel.org>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 7, 2023 at 11:16=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Mar 03, 2023 at 11:13:51PM +0800, Gao Xiang wrote:
> > Hi Alexander,
> >
> > On 2023/3/3 21:57, Alexander Larsson wrote:
> > > On Mon, Feb 27, 2023 at 10:22=E2=80=AFAM Alexander Larsson <alexl@red=
hat.com> wrote:

> > > But I know for the people who are more interested in using composefs
> > > for containers the eventual goal of rootless support is very
> > > important. So, on behalf of them I guess the question is: Is there
> > > ever any chance that something like composefs could work rootlessly?
> > > Or conversely: Is there some way to get rootless support from the
> > > overlay approach? Opinions? Ideas?
> >
> > Honestly, I do want to get a proper answer when Giuseppe asked me
> > the same question.  My current view is simply "that question is
> > almost the same for all in-kernel fses with some on-disk format".
>
> As far as I'm concerned filesystems with on-disk format will not be made
> mountable by unprivileged containers. And I don't think I'm alone in
> that view. The idea that ever more parts of the kernel with a massive
> attack surface such as a filesystem need to vouchesafe for the safety in
> the face of every rando having access to
> unshare --mount --user --map-root is a dead end and will just end up
> trapping us in a neverending cycle of security bugs (Because every
> single bug that's found after making that fs mountable from an
> unprivileged container will be treated as a security bug no matter if
> justified or not. So this is also a good way to ruin your filesystem's
> reputation.).
>
> And honestly, if we set the precedent that it's fine for one filesystem
> with an on-disk format to be able to be mounted by unprivileged
> containers then other filesystems eventually want to do this as well.
>
> At the rate we currently add filesystems that's just a matter of time
> even if none of the existing ones would also want to do it. And then
> we're left arguing that this was just an exception for one super
> special, super safe, unexploitable filesystem with an on-disk format.
>
> Imho, none of this is appealing. I don't want to slowly keep building a
> future where we end up running fuzzers in unprivileged container to
> generate random images to crash the kernel.
>
> I have more arguments why I don't think is a path we will ever go down
> but I don't want this to detract from the legitimate ask of making it
> possible to mount trusted images from within unprivileged containers.
> Because I think that's perfectly legitimate.
>
> However, I don't think that this is something the kernel needs to solve
> other than providing the necessary infrastructure so that this can be
> solved in userspace.

So, I completely understand this point of view. And, since I'm not
really hearing any other viewpoint from the linux vfs developers it
seems to be a shared opinion. So, it seems like further work on the
kernel side of composefs isn't really useful anymore, and I will focus
my work on the overlayfs side. Maybe we can even drop the summit topic
to avoid a bunch of unnecessary travel?

That said, even though I understand (and even agree) with your
worries, I feel it is kind of unfortunate that we end up with
(essentially) a setuid helper approach for this. Because it feels like
we're giving up on a useful feature (trustless unprivileged mounts)
that the kernel could *theoretically* deliver, but a setuid helper
can't. Sure, if you have a closed system you can limit what images can
get mounted to images signed by a trusted key, but it won't work well
for things like user built images or publically available images.
Unfortunately practicalities kinda outweigh theoretical advantages.

--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

