Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F3B1E3638
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 05:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbgE0DHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 May 2020 23:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgE0DHm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 May 2020 23:07:42 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A995CC061A0F;
        Tue, 26 May 2020 20:07:41 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c20so22643120ilk.6;
        Tue, 26 May 2020 20:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NoLQZ4xLsmiigYDKwkyKj0BqR8pGmA2XjKXfyOFiOGQ=;
        b=ecfBllBPvCa8XsDJLnfADTkGN6+8/grXE/wm7/P7v6KQSOnpvILfr+A6G3RD8gSt1V
         bcG0w7NqoMDFPFyROpM8wFf1TYhiaV8A/yQdMf9lkSv2kwCGRV5h7KxRLIdClrUbpvPy
         Z6M31H9tEWows4qRtj1lW1QCP3kCmsDMg3qLw7KmFS9Pc78lBjjoNaVC2JVWePQNm4ly
         Tidg8o08isU+NfUD2ZB/3QCYh3eoTB5tJsct5E8/E1FGNgWlwWvgNzZltULIrNilc3rv
         IGxIk+BMAQxjIZ0ACpSWUyfugyumeGFBCfSjXGxQ2ryIa+/Q00dCx2AwZR+HOHTOxdHK
         8Teg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NoLQZ4xLsmiigYDKwkyKj0BqR8pGmA2XjKXfyOFiOGQ=;
        b=IlVUS3JGcm6yv//f30wWqtRqgLJqg0oM/QYlqDL8UQNBnd7paJR8IKrAgTtcgjnzbY
         a1n+L1jHDRitLBT3YhNbSE6psnlfPgIWDI7d1yqYmVpMARtlDLFtLPtm3UeJJrMpz9dZ
         h3B3FsbBGu9HfxWCMr/DD1RuQK2d3PWj3zVwz2r83MUpVhKagl7iMCg1GMi/oQkjCneR
         oTItvoAGeDGximB7EBK3sPR+N68/J8fHaEO/bNaz4rh2E6CkL6cYTBqdSCF57M8sDLU5
         /t/lVRi3bw96BRABNTbwpFMqDsJ6c3xXi3VV532oYHdVqO75XYW3Z08Gz8aiQesLc4qx
         wMew==
X-Gm-Message-State: AOAM530DV6W6SLZlEunsNyi2wiqnupHOfVtXmI6CQHgBUrPmO06n8Rc6
        ZA4xGqjRAJn9ZoS9B6l2pFzr3kd1RbEjBr1b2yc=
X-Google-Smtp-Source: ABdhPJxoQlLUksMMTrEeJnBpX7aUmXahzXq+87mU2xG6zjv9GcII3cRppMGcRbjSLU7EEh3E31xctx4o5xAsG0rwNZg=
X-Received: by 2002:a92:1b86:: with SMTP id f6mr2004630ill.9.1590548860893;
 Tue, 26 May 2020 20:07:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200526205322.23465-1-mic@digikod.net> <20200526205322.23465-8-mic@digikod.net>
In-Reply-To: <20200526205322.23465-8-mic@digikod.net>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 May 2020 06:07:29 +0300
Message-ID: <CAOQ4uxibpDTyjCJWLGG9jr-Gv9PwO==o50b9O8HGQeUfVMDFag@mail.gmail.com>
Subject: Re: [PATCH v18 07/12] landlock: Support filesystem access-control
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 27, 2020 at 3:36 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
>
> Thanks to the Landlock objects and ruleset, it is possible to identify
> inodes according to a process's domain.  To enable an unprivileged
> process to express a file hierarchy, it first needs to open a directory
> (or a file) and pass this file descriptor to the kernel through
> landlock(2).  When checking if a file access request is allowed, we walk
> from the requested dentry to the real root, following the different
> mount layers.  The access to each "tagged" inodes are collected
> according to their rule layer level, and ANDed to create access to the
> requested file hierarchy.  This makes possible to identify a lot of
> files without tagging every inodes nor modifying the filesystem, while
> still following the view and understanding the user has from the
> filesystem.
>

Hi Mickael,

Nice work! I am interested in the problem of system wide file access
rules based on directory hierarchy [1][2]. Not the same problem, but
with obvious overlaps.

I sketched this untested POC [2] a while ago -
It introduces the concept of "border control" LSM hooks to avoid the
need to check which sections in the hierarchy an inode belongs to
on every syscall.

With this, you could cache a topology with id's per section and
cache the section id + topology generation in the inode's security state.
When inode crosses border control hooks, it's section id is updated.
When directory hierarchy topology changes, some or all of the cached
section id's are invalidated and rules <-> sections relations may need
to be changed.

Do you think something like that could be useful for landlock?

Note that the POC is using d_mountpoint() as the only type of "fence"
mark. It is sufficient for controlling rename in and out of containers, so
I just used an already available dentry flag for "fence".
If the border control hook concept is useful, this could be extended to
a more generic d_border_passing(), with some internal kernel API
to manage it and with all the bike shedding that comes with it...

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhBVhyyJv0+xSFQiGQEj60AbD3S=
ADfKK40uAiC4GF2p9Q@mail.gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgn=3DYNj8cJuccx2KqxEVGZy1z=
3DBVYXrD=3DMc7Dc=3DJe+-w@mail.gmail.com/
[3] https://github.com/amir73il/linux/commits/rename_xmnt
