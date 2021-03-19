Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3B7341E91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 14:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhCSNk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 09:40:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46574 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbhCSNkr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:40:47 -0400
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1lNFMq-0007Qv-5z; Fri, 19 Mar 2021 13:40:44 +0000
Date:   Fri, 19 Mar 2021 14:40:43 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
Message-ID: <20210319134043.c2wcpn4lbefrkhkg@wittgenstein>
References: <20210304112921.3996419-1-amir73il@gmail.com>
 <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz>
 <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210317174532.cllfsiagoudoz42m@wittgenstein>
 <CAOQ4uxjCjapuAHbYuP8Q_k0XD59UmURbmkGC1qcPkPAgQbQ8DA@mail.gmail.com>
 <20210318143140.jxycfn3fpqntq34z@wittgenstein>
 <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 06:48:11PM +0200, Amir Goldstein wrote:
> [...]
> 
> I understand the use case.
> 
> > I'd rather have something that allows me to mirror
> >
> > /home/jdoe
> >
> > recursively directly. But maybe I'm misunderstanding fanotify and it
> > can't really help us but I thought that subtree watches might.
> >
> 
> There are no subtree watches. They are still a holy grale for fanotify...
> There are filesystem and mnt watches and the latter support far fewer
> events (only events for operations that carry the path argument).
> 
> With filesystem watches, you can get events for all mkdirs and you can
> figure out the created path, but you'd have to do all the filtering in
> userspace.
> 
> What I am trying to create is "filtered" filesystem watches and the filter needs
> to be efficient enough so the watcher will not incur too big of a penalty
> on all the operations in the filesystem.
> 
> Thanks to your mnt_userns changes, implementing a filter to intercept
> (say) mkdir calles on a specific mnt_userns should be quite simple, but
> filtering by "path" (i.e. /home/jdoe/some/path) will still need to happen in
> userspace.
> 
> This narrows the problem to the nested container manager that will only
> need to filter events which happened via mounts under its control.
> 
> [...]
> 
> > > there shouldn't be a problem to setup userns filtered watches in order to
> > > be notified on all the events that happen via those idmapped mounts
> > > and filtering by "subtree" is not needed.
> > > I am clearly far from understanding the big picture.
> >
> > I think I need to refamiliarize myself with what "subtree" watches do.
> > Maybe I misunderstood what they do. I'll take a look.
> >
> 
> You will not find them :-)

Heh. :)

> 
> [...]
> 
> > > Currently, (upstream) only init_userns CAP_SYS_ADMIN can setup
> > > fanotify watches.
> > > In linux-next, unprivileged user can already setup inode watches
> > > (i.e. like inotify).
> >
> > Just to clarify: you mean "unprivileged" as in non-root users in
> > init_user_ns and therefore also users in non-init userns. That's what
> 
> Correct.
> 
> > inotify allows you. This would probably allows us to use fanotify
> > instead of the hand-rolled recursive notify watching we currently do and
> > that I linked to above.
> >
> 
> The code that sits in linux-next can give you pretty much a drop-in
> replacement of inotify and nothing more. See example code:
> https://github.com/amir73il/inotify-tools/commits/fanotify_name_fid

This is really great. Thank you for doing that work this will help quite
a lot of use-cases and make things way simpler. I created a TODO to port
our path-hotplug to this once this feature lands.

> 
> > > If you think that is useful and you want to play with this feature I can
> > > provide a WIP branch soon.
> >
> > I would like to first play with the support for unprivileged fanotify
> > but sure, it does sound useful!
> 
> Just so you have an idea what I am talking about, this is a very early
> POC branch:
> https://github.com/amir73il/linux/commits/fanotify_userns

Thanks!  I'll try to pull this and take a look next week. I hope that's
ok.

Christian
