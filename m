Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA296AF60A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 20:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCGTpv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 14:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbjCGTou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:44:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701A08C97F
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 11:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678217616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WqB3flvF0rxXghGSrvE8lwW+UrNsKALEelzw1rVsvdg=;
        b=VL5LEIT9+kCiAUd2QsyWWMWswyt7WeofVIR1fozu2zFYwQ+GXX+FfvJZouriGHuNj46JUC
        v4WHqJ0YpAJL3wP9VljO4dVZg4HulbhzdrW/wphnkqNn77Z/RlHjTS7CueZ6LFdTpEN3RI
        G+VSWg9gyAxfkol3oSiQO09P0rZDYTk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-ksZvPup1O06Pg5O8ehnhWQ-1; Tue, 07 Mar 2023 14:33:32 -0500
X-MC-Unique: ksZvPup1O06Pg5O8ehnhWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50FCD18E0AC1;
        Tue,  7 Mar 2023 19:33:32 +0000 (UTC)
Received: from localhost (unknown [10.39.194.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C10C24024CA3;
        Tue,  7 Mar 2023 19:33:31 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Larsson <alexl@redhat.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <sforshee@kernel.org>
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
        <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
        <ffe56605-6ef7-01b5-e613-7600165820d8@linux.alibaba.com>
        <20230307101548.6gvtd62zah5l3doe@wittgenstein>
        <CAL7ro1HuQnCJujCBq3W6SqM7GDs+Tyb7vRT60Q9EM++nsiRYVw@mail.gmail.com>
        <20230307151627.a4fkigatgdh5tp3v@wittgenstein>
Date:   Tue, 07 Mar 2023 20:33:29 +0100
In-Reply-To: <20230307151627.a4fkigatgdh5tp3v@wittgenstein> (Christian
        Brauner's message of "Tue, 7 Mar 2023 16:16:27 +0100")
Message-ID: <87lek8qrue.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

> On Tue, Mar 07, 2023 at 01:09:57PM +0100, Alexander Larsson wrote:
>> On Tue, Mar 7, 2023 at 11:16=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
>> >
>> > On Fri, Mar 03, 2023 at 11:13:51PM +0800, Gao Xiang wrote:
>> > > Hi Alexander,
>> > >
>> > > On 2023/3/3 21:57, Alexander Larsson wrote:
>> > > > On Mon, Feb 27, 2023 at 10:22=E2=80=AFAM Alexander Larsson <alexl@=
redhat.com> wrote:
>>=20
>> > > > But I know for the people who are more interested in using compose=
fs
>> > > > for containers the eventual goal of rootless support is very
>> > > > important. So, on behalf of them I guess the question is: Is there
>> > > > ever any chance that something like composefs could work rootlessl=
y?
>> > > > Or conversely: Is there some way to get rootless support from the
>> > > > overlay approach? Opinions? Ideas?
>> > >
>> > > Honestly, I do want to get a proper answer when Giuseppe asked me
>> > > the same question.  My current view is simply "that question is
>> > > almost the same for all in-kernel fses with some on-disk format".
>> >
>> > As far as I'm concerned filesystems with on-disk format will not be ma=
de
>> > mountable by unprivileged containers. And I don't think I'm alone in
>> > that view. The idea that ever more parts of the kernel with a massive
>> > attack surface such as a filesystem need to vouchesafe for the safety =
in
>> > the face of every rando having access to
>> > unshare --mount --user --map-root is a dead end and will just end up
>> > trapping us in a neverending cycle of security bugs (Because every
>> > single bug that's found after making that fs mountable from an
>> > unprivileged container will be treated as a security bug no matter if
>> > justified or not. So this is also a good way to ruin your filesystem's
>> > reputation.).
>> >
>> > And honestly, if we set the precedent that it's fine for one filesystem
>> > with an on-disk format to be able to be mounted by unprivileged
>> > containers then other filesystems eventually want to do this as well.
>> >
>> > At the rate we currently add filesystems that's just a matter of time
>> > even if none of the existing ones would also want to do it. And then
>> > we're left arguing that this was just an exception for one super
>> > special, super safe, unexploitable filesystem with an on-disk format.
>> >
>> > Imho, none of this is appealing. I don't want to slowly keep building a
>> > future where we end up running fuzzers in unprivileged container to
>> > generate random images to crash the kernel.
>> >
>> > I have more arguments why I don't think is a path we will ever go down
>> > but I don't want this to detract from the legitimate ask of making it
>> > possible to mount trusted images from within unprivileged containers.
>> > Because I think that's perfectly legitimate.
>> >
>> > However, I don't think that this is something the kernel needs to solve
>> > other than providing the necessary infrastructure so that this can be
>> > solved in userspace.
>>=20
>> So, I completely understand this point of view. And, since I'm not
>> really hearing any other viewpoint from the linux vfs developers it
>> seems to be a shared opinion. So, it seems like further work on the
>> kernel side of composefs isn't really useful anymore, and I will focus
>> my work on the overlayfs side. Maybe we can even drop the summit topic
>> to avoid a bunch of unnecessary travel?
>>=20
>> That said, even though I understand (and even agree) with your
>> worries, I feel it is kind of unfortunate that we end up with
>> (essentially) a setuid helper approach for this. Because it feels like
>> we're giving up on a useful feature (trustless unprivileged mounts)
>> that the kernel could *theoretically* deliver, but a setuid helper
>> can't. Sure, if you have a closed system you can limit what images can
>> get mounted to images signed by a trusted key, but it won't work well
>> for things like user built images or publically available images.
>> Unfortunately practicalities kinda outweigh theoretical advantages.
>
> Characterzing this as a setuid helper approach feels a bit like negative
> branding. :)
>
> But just in case there's a misunderstanding of any form let me clarify
> that systemd doesn't produce set*id binaries in any form; never has,
> never will.
>
> It's also good to remember that in order to even use unprivileged
> containers with meaningful idmappings __two__ set*id binaries -
> new*idmap - with an extremely clunky, and frankly unusable id delegation
> policy expressed through these weird /etc/sub*id files have to be used.
> Which apparently everyone is happy to use.
>
> What we're talking about here however is a first class system service
> capable of expressing meaningful security policy (e.g., image signed by
> a key in the kernel keyring, polkit, ...). And such well-scoped local
> services are a good thing.

there are some disadvantages too:

- while the impact on system services is negligible, using the proposed
  approach could slow down container startup.
  It is somehow similar to the issue we currently have with cgroups,
  where manually creating a cgroup is faster than going through dbus and
  systemd.  IMHO, the kernel could easily verify the image signature
  without relying on an additional userland service when mounting it
  from a user namespace.

- it won't be usable from a containerized build system.  It is common to
  build container images inside of a container (so that they can be
  built in a cluster).  To use the systemd approach, we'll need to
  access systemd on the host from the container.

> This mentality of shoving ever more functionality under
> unshare --user --map-root needs to really take a good hard look at
> itself. Because it fundamentally assumes that unshare --user --map-root
> is a sufficiently complex security policy to cover everything from
> exposing complex network settings to complex filesystem settings to
> unprivileged users.
>
> To this day I'm not even sure if having ramfs mountable by unprivileged
> users isn't just a trivial dos vector that just nobody really considers
> important enough.
>
> (This is not aimed in any form at you because I used to think that this
> is a future worth building in the past myself but I think it's become
> sufficiently clear that this just doesn't work especially when our
> expectations around security and integrity become ever greater.)
>
> Fwiw, Lennart is in the middle of implementing this so we can showcase
> this asap.

