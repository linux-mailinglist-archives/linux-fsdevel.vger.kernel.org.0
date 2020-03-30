Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15C3319863A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 23:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgC3VRO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 17:17:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46119 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbgC3VRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:17:14 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jJ1mI-0008Ex-KZ; Mon, 30 Mar 2020 21:17:02 +0000
Date:   Mon, 30 Mar 2020 23:17:00 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        dray@redhat.com, kzak@redhat.com, mszeredi@redhat.com,
        swhiteho@redhat.com, jlayton@redhat.com, raven@themaw.net,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lennart@poettering.net, cyphar@cyphar.com
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
References: <1445647.1585576702@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1445647.1585576702@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Cc Lennart and Aleksa, both of which maintain projects too that would
make use of this]

On Mon, Mar 30, 2020 at 02:58:22PM +0100, David Howells wrote:
> 
> Hi Linus,
> 
> I have three sets of patches I'd like to push your way, if you (and Al) are
> willing to consider them.
> 
>  (1) General notification queue plus key/keyring notifications.
> 
>      This adds the core of the notification queue built on pipes, and adds
>      the ability to watch for changes to keys.
> 
>  (2) Mount and superblock notifications.
> 
>      This builds on (1) to provide notifications of mount topology changes
>      and implements a framework for superblock events (configuration
>      changes, I/O errors, quota/space overruns and network status changes).
> 
>  (3) Filesystem information retrieval.
> 
>      This provides an extensible way to retrieve informational attributes
>      about mount objects and filesystems.  This includes providing
>      information intended to make recovering from a notification queue
>      overrun much easier.
> 
> We need (1) for Gnome to efficiently watch for changes in kerberos
> keyrings.  Debarshi Ray has patches ready to go for gnome-online-accounts
> so that it can make use of the facility.
> 
> Sets (2) and (3) can make libmount more efficient.  Karel Zak is working on
> making use of this to avoid reading /proc/mountinfo.
> 
> We need something to make systemd's watching of the mount topology more
> efficient, and (2) and (3) can help with this by making it faster to narrow
> down what changed.  I think Karel has this in his sights, but hasn't yet
> managed to work on it.
> 
> Set (2) should be able to make it easier to watch for mount options inside
> a container, and set (3) should make it easier to examine the mounts inside
> another mount namespace inside a container in a way that can't be done with
> /proc/mounts.  This is requested by Christian Brauner.
> 
> Jeff Layton has a tentative addition to (3) to expose error state to
> userspace, and Andres Freund would like this for Postgres.
> 
> Set (3) further allows the information returned by such as statx() and
> ioctl(FS_IOC_GETFLAGS) to be qualified by indicating which bits are/aren't
> supported.
> 
> Further, for (3), I also allow filesystem-specific overrides/extensions to
> fsinfo() and have a use for it to AFS to expose information about server
> preference for a particular volume (something that is necessary for
> implementing the toolset).  I've provided example code that does similar
> for NFS and some that exposes superblock info from Ext4.  At Vault, Steve
> expressed an interest in this for CIFS and Ted Ts'o expressed a possible
> interest for Ext4.
> 
> Notes:
> 
>  (*) These patches will conflict with apparently upcoming refactoring of
>      the security core, but the fixup doesn't look too bad:
> 
> 	https://lore.kernel.org/linux-next/20200330130636.0846e394@canb.auug.org.au/T/#u
> 
>  (*) Miklós Szeredi would much prefer to implement fsinfo() as a magic
>      filesystem mounted on /proc/self/fsinfo/ whereby your open fds appear
>      as directories under there, each with a set of attribute files
>      corresponding to the attributes that fsinfo() would otherwise provide.
>      To examine something by filename, you'd have to open it O_PATH and
>      then read the individual attribute files in the corresponding per-fd
>      directory.  A readfile() system call has been mooted to elide the
>      {open,read,close} sequence to make it more efficient.

Fwiw, putting down my kernel hat and speaking as someone who maintains
two container runtimes and various other low-level bits and pieces in
userspace who'd make heavy use of this stuff I would prefer the fd-based
fsinfo() approach especially in the light of across namespace
operations, querying all properties of a mount atomically all-at-once,
and safe delegation through fds. Another heavy user of this would be
systemd (Cced Lennart who I've discussed this with) which would prefer
the fd-based approach as well. I think pulling this into a filesystem
and making userspace parse around in a filesystem tree to query mount
information is the wrong approach and will get messy pretty quickly
especially in the face of mount and user namespace interactions and
various other pitfalls. fsinfo() fits quite nicely with the all-fd-based
approach of the whole mount api. So yes, definitely preferred from my
end.

Christian
