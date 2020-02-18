Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5244A162171
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 08:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgBRHSl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 02:18:41 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:43091 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgBRHSk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:18:40 -0500
Received: by mail-il1-f195.google.com with SMTP id o13so7535579ilg.10;
        Mon, 17 Feb 2020 23:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DotFBEFegWe/53aoZkpyF/YGhqc9ZwrlCKIp+/h//nw=;
        b=C+7S4OU/Giki914nuXaSF3kdDCYipLrCgWZB+6WjgccMu6+udX1+xxtoUu6WIerlz3
         iPqluFG3Zre0Y+niIfKv244wq+B4t+miMlYCYqvoZFts3syAbaE/9OgDd9iq5mR8Ab5c
         6FUCibdBRLm9+M0QuD3WLZpEg9HbzIPGyrU+2TcyyrThlmoY23O6xJ1+rx4QkYPR3cwU
         t81X9c973M5zLtRX9Wv3n7O674Bo6r3fz8aUcLCPHyj3XIDH2iJr9wEPO8X2tLUObxOp
         Kn3N8xNnlCM1uCoDYSABZHbqhEdJQxdu3Lt5s+SBkc7T23QNDoGSpweWpPODH3YhEqRR
         vEzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DotFBEFegWe/53aoZkpyF/YGhqc9ZwrlCKIp+/h//nw=;
        b=FyZt9AD/26oud30+BDc/ig62Z5nLBF3kc+H8c4GWA+vpFeJzg26slcQQJ2z9axcy9G
         z1CfEUoJV9ey9ZZZSb8/8Dzh7fNG1tzYpF+5xjmdCrjf5qO9fCIFuY+8/AwhLIomI5hp
         1pVUnJ0QMHEUxBLC4geP6RTFl2j+LSXOBtkTfF+fcnd0/Kt/jMrlzxTaK9hprjtT+npp
         LAZK55Xw8mRZarYW743bYheOgZQA4T/lpzMzeeXLhHS00TMBgItL3TD29sLNUDXcD2yX
         A+TFLILwHXnrjXPlPq8QU8dotKMUPHfYkYeO87hGxeP+P4mhFMJdCXiKOpdcs543SM+0
         70mA==
X-Gm-Message-State: APjAAAVBdVv0nOITErL4Ny5cYr9PrhGK0WlkfeifeVPlddOxYjRIEQwp
        iVWkWO/wPFcjE+N2NY1fwJCiv40jcsfrGCerUrUTBw==
X-Google-Smtp-Source: APXvYqwHIQOlawliW8SfXrz7VbsexUdkmJC5YwBV7IjrxY7pNbbKSnnnq5aAtzQP5rTz4WwUcfdMrZR4hHrx+5Q8LHs=
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr19008419ilg.137.1582010319940;
 Mon, 17 Feb 2020 23:18:39 -0800 (PST)
MIME-Version: 1.0
References: <20200217205307.32256-1-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200217205307.32256-1-James.Bottomley@HansenPartnership.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Feb 2020 09:18:28 +0200
Message-ID: <CAOQ4uxjtp7d_xL20pGwvbFKqgAbyQhE=Pbw+e9Kj24wqF2hPfQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] introduce a uid/gid shifting bind mount
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <seth.forshee@canonical.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Linux Containers <containers@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:56 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> The object of this series is to replace shiftfs with a proper uid/gid
> shifting bind mount instead of the shiftfs hack of introducing
> something that looks similar to an overlay filesystem to do it.
>
> The VFS still has the problem that in order to tell what vfsmount a
> dentry belongs to, struct path would have to be threaded everywhere
> struct dentry currently is.  However, this patch is structured only to
> require a rethreading of notify_change.  The rest of the knowledge
> that a shift is in operation is carried in the task structure by
> caching the unshifted credentials.
>
> Note that although it is currently dependent on the new configfd
> interface for bind mounts, only patch 3/3 relies on this, and the
> whole thing could be redone as a syscall or any other mechanism
> (depending on how people eventually want to fix the problem with the
> new fsconfig mechanism being unable to reconfigure bind mounts).
>
> The changes from v2 are I've added Amir's reviewed-by for the
> notify_change rethreading and I've implemented Serge's request for a
> base offset shift for the image.  It turned out to be much harder to
> implement a simple linear shift than simply to do it through a
> different userns, so that's how I've done it.  The userns you need to
> set up for the offset shifted image is one where the interior uid
> would see the shifted image as fake root.  I've introduced an
> additional "ns" config parameter, which must be specified when
> building the allow shift mount point (so it's done by the admin, not
> by the unprivileged user).  I've also taken care that the image
> shifted to zero (real root) is never visible in the filesystem.  Patch
> 3/3 explains how to use the additional "ns" parameter.
>
>

James,

To us common people who do not breath containers, your proposal seems
like a competing implementation to Christian's proposal [1]. If it were a
competing implementation, I think Christian's proposal would have won by
points for being less intrusive to VFS.

But it is not really a competing implementation, is it? Your proposals meet
two different, but very overlapping, set of requirements. IMHO, none of you
did a really good job of explaining that in the cover latter, let
alone, refer to
each others proposals (I am referring to your v3 posting of course).

IIUC, Christian's proposal deals with single shared image per
non-overlapping groups of containers. And it deals with this use case very
elegantly IMO. From your comments on Christian's post, it does not
seem that you oppose to his proposal, except that it does not meet the
requirements for all of your use cases.

IIUC, your proposal can deal with multiple shared images per overlapping
groups of containers and it adds an element of "auto-reverse-mapping",
which reduces the administration overhead of this to be nightmare
of orchestration.

It seems to me, that you should look into working your patch set on
top of fsid mapping and try to make use of it as much as possible.
And to make things a bit more clear to the rest of us, you should probably
market your feature as "auto back shifting mount" or something like that
and explain the added value of the feature on top of plain fsid mapping.

Thanks,
Amir.


[1] https://lore.kernel.org/linux-fsdevel/20200214183554.1133805-1-christian.brauner@ubuntu.com/
