Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75D4347AC1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 15:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbhCXOcv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 10:32:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236335AbhCXOcf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 10:32:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18EA961963;
        Wed, 24 Mar 2021 14:32:32 +0000 (UTC)
Date:   Wed, 24 Mar 2021 15:32:30 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
Message-ID: <20210324143230.y36hga35xvpdb3ct@wittgenstein>
References: <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210317174532.cllfsiagoudoz42m@wittgenstein>
 <CAOQ4uxjCjapuAHbYuP8Q_k0XD59UmURbmkGC1qcPkPAgQbQ8DA@mail.gmail.com>
 <20210318143140.jxycfn3fpqntq34z@wittgenstein>
 <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
 <20210319134043.c2wcpn4lbefrkhkg@wittgenstein>
 <CAOQ4uxhLYdWOUmpWP+c_JzVeGDbkJ5eUM+1-hhq7zFq23g5J1g@mail.gmail.com>
 <CAOQ4uxhetKeEZX=_iAcREjibaR0ZcOdeZyR8mFEoHM+WRsuVtg@mail.gmail.com>
 <CAOQ4uxhfx012GtvXMfiaHSk1M7+gTqkz3LsT0i_cHLnZLMk8nw@mail.gmail.com>
 <CAOQ4uxhFU=H8db35JMhfR+A5qDkmohQ01AWH995xeBAKuuPhzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhFU=H8db35JMhfR+A5qDkmohQ01AWH995xeBAKuuPhzA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 03:57:12PM +0200, Amir Goldstein wrote:
> > > Now tested FAN_MARK_FILESYSTEM watch on tmpfs mounted
> > > inside userns and works fine, with two wrinkles I needed to iron:
> > >
> > > 1. FAN_REPORT_FID not supported on tmpfs because tmpfs has
> > >     zero f_fsid (easy to fix)
> > > 2. open_by_handle_at() is not userns aware (can relax for
> > >     FS_USERNS_MOUNT fs)
> > >
> > > Pushed these two fixes to branch fanotify_userns.
> >
> > Pushed another fix to mnt refcount bug in WIP and another commit to
> > add the last piece that could make fanotify usable for systemd-homed
> > setup - a filesystem watch filtered by mnt_userns (not tested yet).
> >
> 
> Now I used mount-idmapped (from xfstest) to test that last piece.
> Found a minor bug and pushed a fix.
> 
> It is working as expected, that is filtering only the events generated via
> the idmapped mount. However, because the listener I tested is capable in
> the mapped userns and not in the sb userns, the listener cannot
> open_ny_handle_at(), so the result is not as useful as one might hope.

This is another dumb question probably but in general, are you saying
that someone watching a mount or directory and does _not_ want file
descriptors from fanotify to be returned has no other way of getting to
the path they want to open other than by using open_by_handle_at()?

> 
> I guess we will also need to make open_by_handle_at() idmapped aware
> and use a variant of vfs_dentry_acceptable() that validates that the opened
> path is legitimately accessible via the idmapped mount.

So as a first step, I think there's a legitimate case to be made for
open_by_handle_at() to be made useable inside user namespaces. That's a
change worth to be made independent of fanotify. For example, nowadays
cgroups have a 64 bit identifier that can be used with open_by_handle_at
to map a cgrp id to a path and back:
https://lkml.org/lkml/2020/12/2/1126
Right now this can't be used in user namespaces because of this
restriction but it is genuinely useful to have this feature available
since cgroups are FS_USERNS_MOUNT and that identifier <-> path mapping
is very convenient.
Without looking at the code I'm not super sure how name_to_handle_at()
and open_by_handle_at() behave in the face of mount namespaces so that
would need looking into to. But it would be a genuinely useful change, I
think.

> 
> I think I will leave this complexity to you should you think the userns filtered
> watch is something worth the effort.

Fair enough!

Thanks!
Christian
