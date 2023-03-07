Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6703A6AE464
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Mar 2023 16:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCGPTS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 10:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjCGPSv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:18:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D077B9A4
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 07:16:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 419846145C
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Mar 2023 15:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132E5C433A1;
        Tue,  7 Mar 2023 15:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678202196;
        bh=EC04nH6ksmhpjJn5nWKn4LP66gg5WMmgep3ssxxv+4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWUfSWVRJst3K/7WBynhnakjdZjCXbg9GTX+SEr1Ly6nZwJo6rezSv80W1hHgYgoX
         c38qGbvPuJFzgqm1EXHxd7uSNZ1jPobDDqDKKcxHVoCJbchOaiKPFkFcRo1yusi8Ck
         nBtQ2SnI96wHcD8AeZGueUCxo4o7MV07JqXqKZX9Zr371sduzaohVbruj2SWFS836Q
         3Adf3Thx6yxbwpoGehQ2jXccJzURn5pYI6DpacprCGDqePLHnAWkktuXMdlKSYGdkp
         qjRxbKcmRSF/mJ1LAlGsRKQ/XgXhFj+IlNIkm7X7rHne2z9l3Myw/U+CEuGBkZupSh
         Gl+5QRdNZdrPQ==
Date:   Tue, 7 Mar 2023 16:16:27 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Alexander Larsson <alexl@redhat.com>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <sforshee@kernel.org>
Subject: Re: [LSF/MM/BFP TOPIC] Composefs vs erofs+overlay
Message-ID: <20230307151627.a4fkigatgdh5tp3v@wittgenstein>
References: <e84d009fd32b7a02ceb038db5cf1737db91069d5.camel@redhat.com>
 <CAL7ro1E7KY5yUJOLu6TY0RtAC5304sM3Lvk=zSCrqDrxTPW2og@mail.gmail.com>
 <ffe56605-6ef7-01b5-e613-7600165820d8@linux.alibaba.com>
 <20230307101548.6gvtd62zah5l3doe@wittgenstein>
 <CAL7ro1HuQnCJujCBq3W6SqM7GDs+Tyb7vRT60Q9EM++nsiRYVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL7ro1HuQnCJujCBq3W6SqM7GDs+Tyb7vRT60Q9EM++nsiRYVw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 07, 2023 at 01:09:57PM +0100, Alexander Larsson wrote:
> On Tue, Mar 7, 2023 at 11:16 AM Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Fri, Mar 03, 2023 at 11:13:51PM +0800, Gao Xiang wrote:
> > > Hi Alexander,
> > >
> > > On 2023/3/3 21:57, Alexander Larsson wrote:
> > > > On Mon, Feb 27, 2023 at 10:22 AM Alexander Larsson <alexl@redhat.com> wrote:
> 
> > > > But I know for the people who are more interested in using composefs
> > > > for containers the eventual goal of rootless support is very
> > > > important. So, on behalf of them I guess the question is: Is there
> > > > ever any chance that something like composefs could work rootlessly?
> > > > Or conversely: Is there some way to get rootless support from the
> > > > overlay approach? Opinions? Ideas?
> > >
> > > Honestly, I do want to get a proper answer when Giuseppe asked me
> > > the same question.  My current view is simply "that question is
> > > almost the same for all in-kernel fses with some on-disk format".
> >
> > As far as I'm concerned filesystems with on-disk format will not be made
> > mountable by unprivileged containers. And I don't think I'm alone in
> > that view. The idea that ever more parts of the kernel with a massive
> > attack surface such as a filesystem need to vouchesafe for the safety in
> > the face of every rando having access to
> > unshare --mount --user --map-root is a dead end and will just end up
> > trapping us in a neverending cycle of security bugs (Because every
> > single bug that's found after making that fs mountable from an
> > unprivileged container will be treated as a security bug no matter if
> > justified or not. So this is also a good way to ruin your filesystem's
> > reputation.).
> >
> > And honestly, if we set the precedent that it's fine for one filesystem
> > with an on-disk format to be able to be mounted by unprivileged
> > containers then other filesystems eventually want to do this as well.
> >
> > At the rate we currently add filesystems that's just a matter of time
> > even if none of the existing ones would also want to do it. And then
> > we're left arguing that this was just an exception for one super
> > special, super safe, unexploitable filesystem with an on-disk format.
> >
> > Imho, none of this is appealing. I don't want to slowly keep building a
> > future where we end up running fuzzers in unprivileged container to
> > generate random images to crash the kernel.
> >
> > I have more arguments why I don't think is a path we will ever go down
> > but I don't want this to detract from the legitimate ask of making it
> > possible to mount trusted images from within unprivileged containers.
> > Because I think that's perfectly legitimate.
> >
> > However, I don't think that this is something the kernel needs to solve
> > other than providing the necessary infrastructure so that this can be
> > solved in userspace.
> 
> So, I completely understand this point of view. And, since I'm not
> really hearing any other viewpoint from the linux vfs developers it
> seems to be a shared opinion. So, it seems like further work on the
> kernel side of composefs isn't really useful anymore, and I will focus
> my work on the overlayfs side. Maybe we can even drop the summit topic
> to avoid a bunch of unnecessary travel?
> 
> That said, even though I understand (and even agree) with your
> worries, I feel it is kind of unfortunate that we end up with
> (essentially) a setuid helper approach for this. Because it feels like
> we're giving up on a useful feature (trustless unprivileged mounts)
> that the kernel could *theoretically* deliver, but a setuid helper
> can't. Sure, if you have a closed system you can limit what images can
> get mounted to images signed by a trusted key, but it won't work well
> for things like user built images or publically available images.
> Unfortunately practicalities kinda outweigh theoretical advantages.

Characterzing this as a setuid helper approach feels a bit like negative
branding. :)

But just in case there's a misunderstanding of any form let me clarify
that systemd doesn't produce set*id binaries in any form; never has,
never will.

It's also good to remember that in order to even use unprivileged
containers with meaningful idmappings __two__ set*id binaries -
new*idmap - with an extremely clunky, and frankly unusable id delegation
policy expressed through these weird /etc/sub*id files have to be used.
Which apparently everyone is happy to use.

What we're talking about here however is a first class system service
capable of expressing meaningful security policy (e.g., image signed by
a key in the kernel keyring, polkit, ...). And such well-scoped local
services are a good thing.

This mentality of shoving ever more functionality under
unshare --user --map-root needs to really take a good hard look at
itself. Because it fundamentally assumes that unshare --user --map-root
is a sufficiently complex security policy to cover everything from
exposing complex network settings to complex filesystem settings to
unprivileged users.

To this day I'm not even sure if having ramfs mountable by unprivileged
users isn't just a trivial dos vector that just nobody really considers
important enough.

(This is not aimed in any form at you because I used to think that this
is a future worth building in the past myself but I think it's become
sufficiently clear that this just doesn't work especially when our
expectations around security and integrity become ever greater.)

Fwiw, Lennart is in the middle of implementing this so we can showcase
this asap.
