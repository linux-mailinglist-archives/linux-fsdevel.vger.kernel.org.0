Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD6B33054D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 01:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbhCHAZM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Mar 2021 19:25:12 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:34910 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbhCHAZD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Mar 2021 19:25:03 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lJ3BA-003qHP-4O; Sun, 07 Mar 2021 23:51:20 +0000
Date:   Sun, 7 Mar 2021 23:51:20 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
Cc:     Ian Kent <raven@themaw.net>, Matthew Wilcox <willy@infradead.org>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, autofs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ross Zwisler <zwisler@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biggers <ebiggers@google.com>,
        Mattias Nissler <mnissler@chromium.org>,
        linux-fsdevel@vger.kernel.org, alexander@mihalicyn.com
Subject: Re: [RFC PATCH] autofs: find_autofs_mount overmounted parent support
Message-ID: <YEVm+KH/R5y2rU7K@zeniv-ca.linux.org.uk>
References: <20210303152931.771996-1-alexander.mikhalitsyn@virtuozzo.com>
 <832c1a384dc0b71b2902accf3091ea84381acc10.camel@themaw.net>
 <20210304131133.0ad93dee12a17f41f4052bcb@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304131133.0ad93dee12a17f41f4052bcb@virtuozzo.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 04, 2021 at 01:11:33PM +0300, Alexander Mikhalitsyn wrote:

> That problem connected with CRIU (Checkpoint-Restore in Userspace) project.
> In CRIU we have support of autofs mounts C/R. To acheive that we need to use
> ioctl's from /dev/autofs to get data about mounts, restore mount as catatonic
> (if needed), change pipe fd and so on. But the problem is that during CRIU
> dump we may meet situation when VFS subtree where autofs mount present was
> overmounted as whole.
> 
> Simpliest example is /proc/sys/fs/binfmt_misc. This mount present on most
> GNU/Linux distributions by default. For instance on my Fedora 33:
> 
> trigger automount of binfmt_misc
> $ ls /proc/sys/fs/binfmt_misc
> 
> $ cat /proc/1/mountinfo | grep binfmt
> 35 24 0:36 / /proc/sys/fs/binfmt_misc rw,relatime shared:16 - autofs systemd-1 rw,...,direct,pipe_ino=223
> 632 35 0:56 / /proc/sys/fs/binfmt_misc rw,...,relatime shared:315 - binfmt_misc binfmt_misc rw
> 
> $ sudo unshare -m -p --fork --mount-proc sh
> # cat /proc/self/mountinfo | grep "/proc"
> 828 809 0:23 / /proc rw,nosuid,nodev,noexec,relatime - proc proc rw
> 829 828 0:36 / /proc/sys/fs/binfmt_misc rw,relatime - autofs systemd-1 rw,...,direct,pipe_ino=223
> 943 829 0:56 / /proc/sys/fs/binfmt_misc rw,...,relatime - binfmt_misc binfmt_misc rw
> 949 828 0:57 / /proc rw...,relatime - proc proc rw
> 
> As we can see now autofs mount /proc/sys/fs/binfmt_misc is inaccessible.
> If we do something like:
> 
> struct autofs_dev_ioctl *param;
> param = malloc(...);
> devfd = open("/dev/autofs", O_RDONLY);
> init_autofs_dev_ioctl(param);
> param->size = size;
> strcpy(param->path, "/proc/sys/fs/binfmt_misc");
> param->openmount.devid = 36;
> err = ioctl(devfd, AUTOFS_DEV_IOCTL_OPENMOUNT, param)
> 
> now we get err = -ENOENT.

Where does that -ENOENT come from?  AFAICS, pathwalk ought to succeed and
return you the root of overmounting binfmt_misc.  Why doesn't the loop in
find_autofs_mount() locate anything it would accept?

I really dislike the patch - the whole "normalize path" thing is fundamentally
bogus, not to mention the iterator over all mounts, etc., so I would like to
understand what the hell is going on before even thinking of *not* NAKing
it on sight.
