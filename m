Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE40207794
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 17:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404055AbgFXPfu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 11:35:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40965 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390702AbgFXPfu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:35:50 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jo7RB-0002AJ-VA; Wed, 24 Jun 2020 15:35:46 +0000
Date:   Wed, 24 Jun 2020 17:35:45 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>
Subject: Re: overlayfs regression
Message-ID: <20200624153545.ixamvyahayzuokl7@wittgenstein>
References: <20200624144846.jtpolkxiqmery3uy@wittgenstein>
 <CAOQ4uxhkiWKt2As5kMWt6PNrRwY8QbqXKiHkz_1UFb0Za+BEuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhkiWKt2As5kMWt6PNrRwY8QbqXKiHkz_1UFb0Za+BEuw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 06:25:55PM +0300, Amir Goldstein wrote:
> On Wed, Jun 24, 2020 at 5:48 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > Hey Miklosz,
> > hey Amir,
> >
> > We've been observing regressions in our containers test-suite with
> > commit:
> >
> > Author: Miklos Szeredi <mszeredi@redhat.com>
> > Date:   Tue Mar 17 15:04:22 2020 +0100
> >
> >     ovl: separate detection of remote upper layer from stacked overlay
> >
> >     Following patch will allow remote as upper layer, but not overlay stacked
> >     on upper layer.  Separate the two concepts.
> >
> >     This patch is doesn't change behavior.
> >
> >     Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> >
> 
> Are you sure this is the offending commit?
> Look at it. It is really moving a bit of code around and should not
> change logic.
> There are several other commits in 5.7 that could have gone wrong...

Yeah, most likely. I can do a bisect but it might take a little until I
get around to it. Is that ok?

> 
> > It suddenly consistently reports:
> > [2422.695340] overlayfs: filesystem on '/home/lxcunpriv/.local/share/lxc/c2/overlay/delta' not supported as upperdir
> > in dmesg where it used to work fine for basically 6 years when we added
> > that test. The test creates a container c2 that uses the rootfs of
> > another container c1 (normal directory on an ext4 filesystem). Here you
> > can see the full mount options:
> >
> > Invalid argument - Failed to mount "/home/lxcunpriv/.local/share/lxc/c1/rootfs" on "/usr/lib/x86_64-linux-gnu/lxc" with options "upperdir=/home/lxcunpriv/.local/share/lxc/c2/overlay/delta,lowerdir=/home/lxcunpriv/.local/share/lxc/c1/rootfs,workdir=/home/lxcunpriv/.local/share/lxc/c2/overlay/work"
> >
> 
> /home/lxcunpriv/.local/share/lxc/c2/overlay/delta' is ext4?

Yeah, so what we do is:

lower -> /foo/c1/rootfs

then we create the directory for the new container:

mkdir_p(/foo/c2)
mkdir_p(/foo/c2/rootfs)
mkdir_p(/foo/c2/overlay)
mkdir_p(/foo/c2/overlay/delta)
mkdir_p(/foo/c2/overlay/workdir)

ensuring that delta + work are on the same mount and that workdir is
empty. The we perform the mount you see above.

Christian
