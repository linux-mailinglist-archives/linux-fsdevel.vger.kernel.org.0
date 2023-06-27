Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F002740214
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 19:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjF0RXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjF0RXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:23:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80526BC;
        Tue, 27 Jun 2023 10:23:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B082611D1;
        Tue, 27 Jun 2023 17:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E11C433C8;
        Tue, 27 Jun 2023 17:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687886597;
        bh=YHqC3AkIjMcI+zZQb7xY54+8KynOZ1FmAl0y11vUJyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwjKtzg06tHfoQiroLS0nj5i+HAz8qy8eTCGpTVWBUGGS/is8kNjYC2Thf2NxjYu5
         /AGVHt2yYFDLbqUUkgnmyopy7jrIbagKSXQhl0lqqMk/0PZtXKBjRI6MK82T/y3vUA
         4L/6Z1nS5KXyXlab6LC0HVZqUNXD4a1jjWx/bVTilwrcrnxhD8fHlg6HU2u0xdbKCM
         IWd2OPqbEakWOkaBKEt1qE/ucbI5pgPB8ZFzTRPKFRK7BYK4Np42Ow8jgP2E6rtsd8
         m3y1ra6aPE4hhjJbY0+tVRWKO2eeHPpniv3M5mc/KzN5J/ov5WDRYrzPFpyZ6ElSvC
         zRLbBhzlbZttA==
Date:   Tue, 27 Jun 2023 19:23:10 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, tj@kernel.org,
        peterz@infradead.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/2] kernfs: add kernfs_ops.free operation to free
 resources tied to the file
Message-ID: <20230627-zujubeln-umwandeln-b99f443dae73@brauner>
References: <20230626201713.1204982-1-surenb@google.com>
 <2023062757-hardening-confusion-6f4e@gregkh>
 <CAJuCfpGUTMP2FTzzx+bq9_5KZjo1r_qspHYZXK2Ors-yU3XhqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGUTMP2FTzzx+bq9_5KZjo1r_qspHYZXK2Ors-yU3XhqQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:03:15AM -0700, Suren Baghdasaryan wrote:
> On Mon, Jun 26, 2023 at 11:25 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jun 26, 2023 at 01:17:12PM -0700, Suren Baghdasaryan wrote:
> > > kernfs_ops.release operation can be called from kernfs_drain_open_files
> > > which is not tied to the file's real lifecycle. Introduce a new kernfs_ops
> > > free operation which is called only when the last fput() of the file is
> > > performed and therefore is strictly tied to the file's lifecycle. This
> > > operation will be used for freeing resources tied to the file, like
> > > waitqueues used for polling the file.
> >
> > This is confusing, shouldn't release be the "last" time the file is
> > handled and then all resources attached to it freed?  Why do we need
> > another callback, shouldn't release handle this?
> 
> That is what I thought too but apparently kernfs_drain_open_files()
> can also cause ops->release to be called while the file keeps on
> living (see details here:
> https://lore.kernel.org/all/CAJuCfpFZ3B4530TgsSHqp5F_gwfrDujwRYewKReJru==MdEHQg@mail.gmail.com/#t).
> 
> >
> >
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >  fs/kernfs/file.c       | 8 +++++---
> > >  include/linux/kernfs.h | 5 +++++
> > >  2 files changed, 10 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> > > index 40c4661f15b7..acc52d23d8f6 100644
> > > --- a/fs/kernfs/file.c
> > > +++ b/fs/kernfs/file.c
> > > @@ -766,7 +766,7 @@ static int kernfs_fop_open(struct inode *inode, struct file *file)
> > >
> > >  /* used from release/drain to ensure that ->release() is called exactly once */
> > >  static void kernfs_release_file(struct kernfs_node *kn,
> > > -                             struct kernfs_open_file *of)
> > > +                             struct kernfs_open_file *of, bool final)
> >
> > Adding flags to functions like this are a pain, now we need to look it
> > up every time to see what that bool means.
> >
> > And when we do, we see that it is not documented here so we have no idea
> > of what it is :(
> >
> > This is not going to be maintainable as-is, sorry.
> 
> It's a static function with only two places it's used in the same
> file. I can add documentation too if that helps.
> 
> >
> > >  {
> > >       /*
> > >        * @of is guaranteed to have no other file operations in flight and
> > > @@ -787,6 +787,8 @@ static void kernfs_release_file(struct kernfs_node *kn,
> > >               of->released = true;
> > >               of_on(of)->nr_to_release--;
> > >       }
> > > +     if (final && kn->attr.ops->free)
> > > +             kn->attr.ops->free(of);
> > >  }
> > >
> > >  static int kernfs_fop_release(struct inode *inode, struct file *filp)
> > > @@ -798,7 +800,7 @@ static int kernfs_fop_release(struct inode *inode, struct file *filp)
> > >               struct mutex *mutex;
> > >
> > >               mutex = kernfs_open_file_mutex_lock(kn);
> > > -             kernfs_release_file(kn, of);
> > > +             kernfs_release_file(kn, of, true);
> > >               mutex_unlock(mutex);
> > >       }
> > >
> > > @@ -852,7 +854,7 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
> > >               }
> > >
> > >               if (kn->flags & KERNFS_HAS_RELEASE)
> > > -                     kernfs_release_file(kn, of);
> > > +                     kernfs_release_file(kn, of, false);
> >
> > Why isn't this also the "last" time things are touched here?  why is it
> > false?
> 
> Because it's called from the context of the process doing rmdir() and
> if another process has the file in the directory opened it will have
> that file alive until it calls the last fput(). These are the call
> paths:
> 
> do_rmdir
>   cgroup_rmdir
>     kernfs_drain_open_files
>       kernfs_release_file(..., false)
>         kn->attr.ops->release(), of->released=true

This seems weird to me. Why would that trigger a ->release() call. In
general, calling ->release() kinda betrays the name.
So imho, this really wants to be a separate ->drain() or ->shutdown()
call (and seems conceptually related to f_op->flush()).

> 
> fput()
>   kernfs_fop_release()
>     kernfs_release_file(..., true), of->released==true,
> kn->attr.ops->release() is not called.
