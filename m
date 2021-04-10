Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248EB35AD49
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Apr 2021 14:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234392AbhDJMa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Apr 2021 08:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234262AbhDJMa5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Apr 2021 08:30:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51FD9611AE;
        Sat, 10 Apr 2021 12:30:40 +0000 (UTC)
Date:   Sat, 10 Apr 2021 14:30:37 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <brauner@kernel.org>,
        Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 2/3] ecryptfs: use private mount in path
Message-ID: <20210410123037.qlfjyv55ncdjpwn3@wittgenstein>
References: <20210409162422.1326565-1-brauner@kernel.org>
 <20210409162422.1326565-3-brauner@kernel.org>
 <YHDxxunCKNuV34Oz@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YHDxxunCKNuV34Oz@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 10, 2021 at 12:31:02AM +0000, Al Viro wrote:
> On Fri, Apr 09, 2021 at 06:24:21PM +0200, Christian Brauner wrote:
> 
> > Reading through the codebase of ecryptfs it currently takes path->mnt
> > and then retrieves that path whenever it needs to perform operations in
> > the underlying filesystem. Simply drop the old path->mnt once we've
> > created a private mount and place the new private mnt into path->mnt.
> > This should be all that is needed to make this work since ecryptfs uses
> > the same lower path's vfsmount to construct the paths it uses to operate
> > on the underlying filesystem.
> 
> > +	mnt = clone_private_mount(&path);
> 
> Incidentally, why is that thing anything other than a trivial wrapper
> for mnt_clone_internal() (if that - I'm not convinced that the check of
> unbindable is the right thing to do here).  Miklos?

The unbindable check is irrelevant at least for both ecryptfs and for
the corresponding cachefiles change I sent out since they don't care
about it.
In practice it doesn't matter to be honest. MS_UNBINDABLE is wildly
esoteric in userspace (We had a glaring bug with that some time ago that
went completely unnoticed for years.). Especially unlikely to be used
for a users home directory (ecryptfs) or /var/cache/fscache
(cachefiles). So even by leaving this check in it's very unlikely for
any regressions to appear.

I hadn't seen mnt_clone_internal() but it's different in so far as it
sets MNT_INTERNAL whereas clone_private_mount() uses MNT_NS_INTERNAL.
Which points me to another potential problem here:
clone_private_mount() seems to want kern_unmount() to be called instead
of just a simple mntput()?

If that's relevant then I think the unbindable check should probably
move out of clone_private_mount() and into overlayfs itself but the rest
be kept.
