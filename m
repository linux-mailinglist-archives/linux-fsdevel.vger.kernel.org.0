Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA416B0469
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 11:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjCHKdD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 05:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCHKck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:32:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3828F9663A
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 02:31:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F28E6173A
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Mar 2023 10:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38163C433EF;
        Wed,  8 Mar 2023 10:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678271508;
        bh=acukuml7E0ASTRB3KT+o02YybP8uOupeBzEYKfC8MNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b13MWBGS9rtjIRM2AfUYFKlHlI5jlM5WLGdqDc88isr4W2HjgKokt7KrLFsN2xPyu
         AUDYB5+4bj1lE/8QFs5pR8nbOViKgxvoM6msNdB44P20sqwzg0vt9gH4Gve/Uk+jv0
         gGLOsoiv1ZG4R8xsrre3R19AwPCCKMs9nxpC8la6IudIu9ZvVdSeYTsraE5ht9ofSc
         2x16/3Nfy6H2/hC2vBSilnLl1Hfub9ZwklBOCFrRQfqIm1yIgSZXnWq8dnfKxDOXKI
         l0RGmmN1L1a0PV+atOAL6EFZzLSX5EDG39DL9aW6v42tiEieRfKqrfNItd6bR0MNbb
         SzGkIcB2IiM4w==
Date:   Wed, 8 Mar 2023 11:31:41 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     Alexander Larsson <alexl@redhat.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <sforshee@kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
Message-ID: <20230308103141.z3dzzyikge4oezz4@wittgenstein>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <ffe56605-6ef7-01b5-e613-7600165820d8@linux.alibaba.com>
 <20230307101548.6gvtd62zah5l3doe@wittgenstein>
 <CAL7ro1HuQnCJujCBq3W6SqM7GDs+Tyb7vRT60Q9EM++nsiRYVw@mail.gmail.com>
 <20230307151627.a4fkigatgdh5tp3v@wittgenstein>
 <87lek8qrue.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lek8qrue.fsf@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 07, 2023 at 08:33:29PM +0100, Giuseppe Scrivano wrote:
> Christian Brauner <brauner@kernel.org> writes:
> 
> > On Tue, Mar 07, 2023 at 01:09:57PM +0100, Alexander Larsson wrote:
> >> On Tue, Mar 7, 2023 at 11:16 AM Christian Brauner <brauner@kernel.org> wrote:
> >> >
> >> > On Fri, Mar 03, 2023 at 11:13:51PM +0800, Gao Xiang wrote:
> >> > > Hi Alexander,
> >> > >
> >> > > On 2023/3/3 21:57, Alexander Larsson wrote:
> >> > > > On Mon, Feb 27, 2023 at 10:22 AM Alexander Larsson <alexl@redhat.com> wrote:
> >> 
> >> > > > But I know for the people who are more interested in using composefs
> >> > > > for containers the eventual goal of rootless support is very
> >> > > > important. So, on behalf of them I guess the question is: Is there
> >> > > > ever any chance that something like composefs could work rootlessly?
> >> > > > Or conversely: Is there some way to get rootless support from the
> >> > > > overlay approach? Opinions? Ideas?
> >> > >
> >> > > Honestly, I do want to get a proper answer when Giuseppe asked me
> >> > > the same question.  My current view is simply "that question is
> >> > > almost the same for all in-kernel fses with some on-disk format".
> >> >
> >> > As far as I'm concerned filesystems with on-disk format will not be made
> >> > mountable by unprivileged containers. And I don't think I'm alone in
> >> > that view. The idea that ever more parts of the kernel with a massive
> >> > attack surface such as a filesystem need to vouchesafe for the safety in
> >> > the face of every rando having access to
> >> > unshare --mount --user --map-root is a dead end and will just end up
> >> > trapping us in a neverending cycle of security bugs (Because every
> >> > single bug that's found after making that fs mountable from an
> >> > unprivileged container will be treated as a security bug no matter if
> >> > justified or not. So this is also a good way to ruin your filesystem's
> >> > reputation.).
> >> >
> >> > And honestly, if we set the precedent that it's fine for one filesystem
> >> > with an on-disk format to be able to be mounted by unprivileged
> >> > containers then other filesystems eventually want to do this as well.
> >> >
> >> > At the rate we currently add filesystems that's just a matter of time
> >> > even if none of the existing ones would also want to do it. And then
> >> > we're left arguing that this was just an exception for one super
> >> > special, super safe, unexploitable filesystem with an on-disk format.
> >> >
> >> > Imho, none of this is appealing. I don't want to slowly keep building a
> >> > future where we end up running fuzzers in unprivileged container to
> >> > generate random images to crash the kernel.
> >> >
> >> > I have more arguments why I don't think is a path we will ever go down
> >> > but I don't want this to detract from the legitimate ask of making it
> >> > possible to mount trusted images from within unprivileged containers.
> >> > Because I think that's perfectly legitimate.
> >> >
> >> > However, I don't think that this is something the kernel needs to solve
> >> > other than providing the necessary infrastructure so that this can be
> >> > solved in userspace.
> >> 
> >> So, I completely understand this point of view. And, since I'm not
> >> really hearing any other viewpoint from the linux vfs developers it
> >> seems to be a shared opinion. So, it seems like further work on the
> >> kernel side of composefs isn't really useful anymore, and I will focus
> >> my work on the overlayfs side. Maybe we can even drop the summit topic
> >> to avoid a bunch of unnecessary travel?
> >> 
> >> That said, even though I understand (and even agree) with your
> >> worries, I feel it is kind of unfortunate that we end up with
> >> (essentially) a setuid helper approach for this. Because it feels like
> >> we're giving up on a useful feature (trustless unprivileged mounts)
> >> that the kernel could *theoretically* deliver, but a setuid helper
> >> can't. Sure, if you have a closed system you can limit what images can
> >> get mounted to images signed by a trusted key, but it won't work well
> >> for things like user built images or publically available images.
> >> Unfortunately practicalities kinda outweigh theoretical advantages.
> >
> > Characterzing this as a setuid helper approach feels a bit like negative
> > branding. :)
> >
> > But just in case there's a misunderstanding of any form let me clarify
> > that systemd doesn't produce set*id binaries in any form; never has,
> > never will.
> >
> > It's also good to remember that in order to even use unprivileged
> > containers with meaningful idmappings __two__ set*id binaries -
> > new*idmap - with an extremely clunky, and frankly unusable id delegation
> > policy expressed through these weird /etc/sub*id files have to be used.
> > Which apparently everyone is happy to use.
> >
> > What we're talking about here however is a first class system service
> > capable of expressing meaningful security policy (e.g., image signed by
> > a key in the kernel keyring, polkit, ...). And such well-scoped local
> > services are a good thing.
> 
> there are some disadvantages too:
> 
> - while the impact on system services is negligible, using the proposed
>   approach could slow down container startup.
>   It is somehow similar to the issue we currently have with cgroups,
>   where manually creating a cgroup is faster than going through dbus and
>   systemd.  IMHO, the kernel could easily verify the image signature

This will use varlink, dbus would be optional and only be involved if
a service wanted to use polkit for trust. Signatures would be the main
way. Efficiency is ofc something that is on the forefront.

That said, note that big chunks of mounting are serialized on namespace
lock (mount propagation et al) and mount lock (properties, parent-child
relationships, mountpoint etc.) already so it's not really that this a
particularly fast operation.

Mounting is expensive in the kernel especially with mount propagation in
the mix. If you have a thousand containers all calling mount at the same
time with mount propagation between them for a big mount tree that'll be
costly. IOW, the cost for mounting isn't paid in userspace.

>   without relying on an additional userland service when mounting it
>   from a user namespace.
> 
> - it won't be usable from a containerized build system.  It is common to
>   build container images inside of a container (so that they can be
>   built in a cluster).  To use the systemd approach, we'll need to
>   access systemd on the host from the container.

I don't see why that would be a problem I consider it the proper design
in fact. And I've explained in the earlier mail that we even have
nesting in mind right away.

As you've mentioned the cgroup delegation model above. This is a good
example. The whole stick of pressure stall information (PSI) for
example, for the memory controller is the realization that instead of
pushing the policy about how to handle memory pressure every deeper into
the kernel it's better to exposes the necessary infrastructure to
userspace which can then implement policies tailored to the workload.
The kernel isn't suited for expressing such fine-grained policies. And
eBPF for containers will end up being managed in a similar way with a
system service that implements the policy for attaching eBPF programs to
containers.

The mounting of filesystem images, network filesystems and so on is imho
a similar problem. The policy when a filesystem mount should be allowed
is something that at the end of the day belongs into a userspace system
level service. The use-cases are just too many, the filesystems too
distinct and too complex to be covered by the kernel. The advantage also
is that with the system level service we can extend this ability to all
filesystems at once and to regular users on the system.

In order to give the security and resource guarantees that a modern
system needs the various services need to integrate with one another and
that may involve asking for privileged operations to be performed.
