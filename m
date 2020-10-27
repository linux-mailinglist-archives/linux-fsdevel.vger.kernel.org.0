Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C086429A667
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 09:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894578AbgJ0ITk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Oct 2020 04:19:40 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42265 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894575AbgJ0ITi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:19:38 -0400
Received: by mail-io1-f68.google.com with SMTP id k21so566887ioa.9;
        Tue, 27 Oct 2020 01:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5mX2s+th5lC6g4CEXYsNUnv6UwhXFGsRLGsXt/YxXUM=;
        b=GgizP4IL7s9FBIvTOcdYkajGXihko3u85gfPZ+soYu9Zb9/qFmdmeyA0BZwVh1TDMa
         WgS8ZYly+Gy6R0F3Ga1CDepVtgvrFan40LMDYWiVxtR4lgDYMYcXwzuCGvURpjTXvBhm
         cPI0Wav4l696vT2klw4W/yBB/STrZBsF4Gvmulr4ggA17oQgva7B1h8giFx3znTSNkHK
         gavZGpPLjYkEJiSaziVQTRyVif33fwLqNSAH7GFjmAl/85+rHHAPCWIeE5JhQNveReXn
         HbOwjKIsXxj+60c3UqOd5H0OctWm0KH3lsklVEZtZn/x3hhzRIf1deQjabbuTuAXsc3e
         rvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mX2s+th5lC6g4CEXYsNUnv6UwhXFGsRLGsXt/YxXUM=;
        b=uBZa9VdO41eBAC+bzlhCpi3tx3BWk1OXlf1nX+5NVI00P0UCMAB5j4rAndv9eQPSqG
         JtCo1H4MVF9UnLzbyivXgRvbbsXo+S5hVwwawxqXwxRoT1Z71p4P4jPo+8hORPTgXj4p
         J5Zas7y0ocVf0w//YhdULwvQmfysIbCKitlzT6kxEDOMdZZ1CYGJ7A67Vsda/lOHV09B
         qM5NxwlLZFEufEIV2SAMAQq62RBlfyvSVt9O1+UVVPPdBGznIeLx+CZWYaAa56s09Flj
         hNi5Mq5dUCZg87fdZBsiab8tVwI/2HKZCDi7RNWzd8Z3baRQkYEEsTSaYVqDLCigg6Ua
         wYoQ==
X-Gm-Message-State: AOAM532S5BcV/iFOP/3C6KwTL2PVicRFLk7rtMUWVW3OcvwmhaaoKWgW
        KAqw5kl2OLBpKxVE4ouMPTKJEjOfyIMTIHiu7Dg=
X-Google-Smtp-Source: ABdhPJwOL+JEC/XqGLjWxbfrbJTGGpn1WKIl5PWGoYC1vJtB/IO4aZvin3hqcglfvTkFZyTpZJeQI3meMhrbONCMwNM=
X-Received: by 2002:a05:6638:1351:: with SMTP id u17mr1200064jad.120.1603786776036;
 Tue, 27 Oct 2020 01:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201026204418.23197-1-longman@redhat.com>
In-Reply-To: <20201026204418.23197-1-longman@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Oct 2020 10:19:25 +0200
Message-ID: <CAOQ4uxiejMYqFXUSU8YSsvtAADwHWTGdhT80-51yFjJGSR3bTw@mail.gmail.com>
Subject: Re: [PATCH] inotify: Increase default inotify.max_user_watches limit
 to 1048576
To:     Waiman Long <longman@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Luca BRUNO <lucab@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:44 PM Waiman Long <longman@redhat.com> wrote:
>
> The default value of inotify.max_user_watches sysctl parameter was set
> to 8192 since the introduction of the inotify feature in 2005 by
> commit 0eeca28300df ("[PATCH] inotify"). Today this value is just too
> small for many modern usage. As a result, users have to explicitly set
> it to a larger value to make it work.
>
> After some searching around the web, these are the
> inotify.max_user_watches values used by some projects:
>  - vscode:  524288
>  - dropbox support: 100000
>  - users on stackexchange: 12228
>  - lsyncd user: 2000000
>  - code42 support: 1048576
>  - monodevelop: 16384
>  - tectonic: 524288
>  - openshift origin: 65536
>
> Each watch point adds an inotify_inode_mark structure to an inode to be
> watched. Modeled after the epoll.max_user_watches behavior to adjust the
> default value according to the amount of addressable memory available,
> make inotify.max_user_watches behave in a similar way to make it use
> no more than 1% of addressable memory within the range [8192, 1048576].
>
> For 64-bit archs, inotify_inode_mark should have a size of 80 bytes. That
> means a system with 8GB or more memory will have the maximum value of
> 1048576 for inotify.max_user_watches. This default should be big enough
> for most of the use cases.
>

Alas, the memory usage contributed by inotify watches is dominated by the
directory inodes that they pin to cache.

In effect, this change increases the ability of a given user to use:

1048576(max_user_watches)*~1024(fs inode size) = ~1GB

Surely, inotify watches are not the only way to pin inodes to cache, but
other ways are also resource controlled, for example:
<noproc hardlimit>*<nofile hardlimit>

I did not survey distros for hard limits of noproc and nofile.
On my Ubuntu it's pretty high (63183*1048576). I suppose other distros
may have a lower hard limit by default.

But in any case, open files resource usage has high visibility (via procfs)
and sysadmins and tools are aware of it.

I am afraid this may not be the case with inotify watches. They are also visible
via the inotify fdinfo procfs files, but less people and tools know about them.

In the end, it's a policy decision, but if you want to claim that your change
will not use more than 1% of addressable memory, it might be better to
use 2*sizeof(struct inode) as a closer approximation of the resource usage.

I believe this conservative estimation will result in a default that covers the
needs of most of the common use cases. Also, in general, a system with
a larger filesystem is likely to have more RAM for caching files anyway.

An anecdote: I started developing the fanotify filesystem watch as replacement
to inotify (merged in v5.9) for a system that needs to watch many millions of
directories and pinning all inodes to cache was not an option.

Thanks,
Amir.
