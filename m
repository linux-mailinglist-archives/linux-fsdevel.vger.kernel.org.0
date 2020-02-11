Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4AD159AC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Feb 2020 21:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbgBKU4P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 15:56:15 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44487 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgBKU4P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:56:15 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so14153086oia.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Feb 2020 12:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8CmYe462WzzksuPoSriUQOLEMXkyrL5p8rPiP/wqsQE=;
        b=oSTwn0d967GW3bvPpoBPc4xhMNU+afmUYTMc5sQAtO/Ma8lCfPJAv7HDesC+gIohzv
         DkMgSufBV3LkIlRnO8ywR8ElxhA0xazO1a2X1EbTK9CPzmmDGuVdsOscmiYi9VuWm70X
         X4QugCq1j+ND5muENF+hw/7uZsm0+pB5emMxJt5J03IBuPoLcY5imni1oxNwtN0QogdK
         WAEagflmLFa9Wa5QWR/mFSJKRXQpW/pCGiRZEZdFevJ2+fsXxxJwszGEIlweNqHKaZQR
         OT/n2MH+QFAJl9CN6AifWx4rVch6UDYBcDpoOITmpCYfCzaqslfwsQD44XYhI2I7wpvH
         apqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8CmYe462WzzksuPoSriUQOLEMXkyrL5p8rPiP/wqsQE=;
        b=r1OUP0uo45w3+BAl+bWbheOcra84J3OndKgOO/jUjD1wATVnhD8H7pXW39r7BMLuWL
         RCxPOtU0d7Hw6isnRwU7G24Zrkdu7MwpOKDkJAVXMaZllNujQJxWnSleGBC/e0ZnWdvP
         mY+cUMi3HVs+XgnLjVJt65q9+nKPl/wagtdnRUnn1RztJDbbCtpYfrpqKuI8tq6ukMhp
         FpkXTeY2iBA//IX9zpw8crrQHMsZQkzAr6fZiDPdFIR4SxMqdRQ3dDVlF62e7FAmVcsy
         5VfW1lGIUopluFilaSgsR6rDcgeNuvrcXMwhjlZRDhkHk1bg/AkBNYVLmzfPp7FDjIgy
         vZDg==
X-Gm-Message-State: APjAAAVfAiOGj4uwx80jXGnTEzR8IySKWuBjALLhnUnKvJ2rdCd3Gnt3
        mL3wkdbkr3XsjkKBP9G0eBWyE1/ImMHW2+m5e7wjIA==
X-Google-Smtp-Source: APXvYqwwlaPw3WuE7pvp2R5+l4ejpzIZmHKNHqXHYwDJ9Aqnqi8TIPcj6j2+bVdD0QcpNjFx5mAc4EwEtqlmtCOsHEY=
X-Received: by 2002:aca:b187:: with SMTP id a129mr4153590oif.175.1581454572660;
 Tue, 11 Feb 2020 12:56:12 -0800 (PST)
MIME-Version: 1.0
References: <20200211165753.356508-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200211165753.356508-1-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 11 Feb 2020 21:55:46 +0100
Message-ID: <CAG48ez1GKOfXDZFD7-hGGjT8L9YEojn94DU5_=W8HL3pzdrCgg@mail.gmail.com>
Subject: Re: [PATCH 00/24] user_namespace: introduce fsid mappings
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>, smbarber@chromium.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 11, 2020 at 5:59 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> This is the implementation of shiftfs which was cooked up during lunch at
> Linux Plumbers 2019 the day after the container's microconference. The
> idea is a design-stew from St=C3=A9phane, Aleksa, Eric, and myself. Back =
then
> we all were quite busy with other work and couldn't really sit down and
> implement it. But I took a few days last week to do this work, including
> demos and performance testing.
> This implementation does not require us to touch the vfs substantially
> at all. Instead, we implement shiftfs via fsid mappings.
> With this patch, it took me 20 mins to port both LXD and LXC to support
> shiftfs via fsid mappings.
>
> For anyone wanting to play with this the branch can be pulled from:
> https://github.com/brauner/linux/tree/fsid_mappings
> https://gitlab.com/brauner/linux/-/tree/fsid_mappings
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=
=3Dfsid_mappings
>
> The main use case for shiftfs for us is in allowing shared writable
> storage to multiple containers using non-overlapping id mappings.
> In such a scenario you want the fsids to be valid and identical in both
> containers for the shared mount. A demo for this exists in [3].
> If you don't want to read on, go straight to the other demos below in
> [1] and [2].

I guess essentially this means that you want to have UID separation
between containers to prevent the containers - or their owners - from
interfering between each other, but for filesystem access, you don't
want to isolate them from each other using DAC controls on the files
and folders inside the containers' directory hierarchies, instead
relying on mode-0700 parent directories to restrict access to the
container owner? Or would you still have separate UIDs for e.g. the
container's UID range 0-65535, and then map the shared UID range at
100000, or something like that?

> People not as familiar with user namespaces might not be aware that fsid
> mappings already exist. Right now, fsid mappings are always identical to
> id mappings. Specifically, the kernel will lookup fsuids in the uid
> mappings and fsgids in the gid mappings of the relevant user namespace.

That's a bit like saying that a kernel without CONFIG_USER_NS still
has user ID mappings, they just happen to be identity mappings. :P

> With this patch series we simply introduce the ability to create fsid
> mappings that are different from the id mappings of a user namespace.
>
> In the usual case of running an unprivileged container we will have
> setup an id mapping, e.g. 0 100000 100000. The on-disk mapping will
> correspond to this id mapping, i.e. all files which we want to appear as
> 0:0 inside the user namespace will be chowned to 100000:100000 on the
> host. This works, because whenever the kernel needs to do a filesystem
> access it will lookup the corresponding uid and gid in the idmapping
> tables of the container.
> Now think about the case where we want to have an id mapping of 0 100000
> 100000 but an on-disk mapping of 0 300000 100000 which is needed to e.g.
> share a single on-disk mapping with multiple containers that all have
> different id mappings.
> This will be problematic. Whenever a filesystem access is requested, the
> kernel will now try to lookup a mapping for 300000 in the id mapping
> tables of the user namespace but since there is none the files will
> appear to be owned by the overflow id, i.e. usually 65534:65534 or
> nobody:nogroup.
>
> With fsid mappings we can solve this by writing an id mapping of 0
> 100000 100000 and an fsid mapping of 0 300000 100000. On filesystem
> access the kernel will now lookup the mapping for 300000 in the fsid
> mapping tables of the user namespace. And since such a mapping exists,
> the corresponding files will have correct ownership.

Sorry to bring up something as disgusting as setuid execution, but:
What happens when there's a setuid root file with ->i_uid=3D=3D300000? I
guess the only way to make that work inside the containers would be
something like make_kuid(current_user_ns(),
from_kfsuid(current_user_ns(), inode->i_uid)) in the setuid execve
path?

> A note on proc (and sys), the proc filesystem is special in sofar as it
> only has a single superblock that is (currently but might be about to
> change) visible in all user namespaces (same goes for sys). This means
> it has special semantics in many ways, including how file ownership and
> access works. The fsid mapping implementation does not alter how proc
> (and sys) ownership works. proc and sys will both continue to lookup
> filesystem access in id mapping tables.

In your example, a process with namespaced UID set (0, 0, 0, 0) will
have kernel UIDs (100000, 100000, 100000, 300000), right? And then if
I want to open /proc/$pid/personality of another process with the same
UIDs, may_open() will call inode_permission() -> do_inode_permission()
-> generic_permission() -> acl_permission_check(), which will compare
current_fsuid() (which is 300000) against inode->i_uid. But
inode->i_uid was filled by proc_pid_make_inode()->task_dump_owner(),
which set inode->i_uid to 100000, right?

Also, e.g. __ptrace_may_access() uses cred->fsuid for a comparison
with another task's real/effective/saved UID.

[...]
> # Demos
> [1]: Create a container with different id and fsid mappings.
>      https://asciinema.org/a/300233
> [2]: Create a container with id mappings but without fsid mappings.
>      https://asciinema.org/a/300234
> [3]: Share storage between multiple containers with non-overlapping id
>      mappings.
>      https://asciinema.org/a/300235

(I really dislike this asciinema thing; if you want to quickly glance
through the output instead of reading at the same speed as it was
typed, a simple pastebin works much better unless you absolutely have
to show things that use stuff like ncurses UI.)
