Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70177751136
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 21:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjGLT3H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 15:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbjGLT3G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:29:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFFDB7
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 12:29:05 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b9d80e33fbso24366675ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 12:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689190144; x=1691782144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ypEYRAxKX9wjqtokJh7uMn8SKPzOqWqHgPa8RjtYy3I=;
        b=GCtv1mduRILqPQZMqTkgP4b/++z33JztaahHM3vKTtDcPGQIYvQspEOX7DHl7j6Ymq
         dfEVyqMangmW7Q5mwsq61G/oco0NKHR3Dt13IY5VCIYEVAq95MnLUky6v0wc+aUuyUyp
         dUvksaqMo2/gQTYnz8Cvu6qj0Yqy3YxhL8VSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689190144; x=1691782144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypEYRAxKX9wjqtokJh7uMn8SKPzOqWqHgPa8RjtYy3I=;
        b=Fi5DW1nDVjV1Grx0KqF3HLH9bho70Cx/BkMLXhNnUXbT8GOOA4Zg86pLmCR62zwRH2
         K8uQ+CZpWkPwRHdNusKgcCw8Ik0KvwN/YeQ94VjaSvu1kI09h+IDsli0t6JU/UGjAVIm
         oL4wSaeNpM/XLITChWoDbjRN90CZ70TndOf2VZncuTPtwklPf50OMMj7q3MFwKgOBMWH
         ywyIjLIyTFt5WAtqRDaSc0vyvs7UCYdU6FviyP/wKMwwLj8YPajz1HiUEejpKdMmcru1
         6u1Q21JMwIOmnmvE1IoT/vdou5p9rPvuTAzIIGmIaSG/7nsfDUzhBA6wUq5ZJgu5bkWU
         TYaA==
X-Gm-Message-State: ABy/qLZ5sDV/jQ2JNZvtM3VOJAtkAET0JlOjGeHzYFuMVmwOiNYuMA1Q
        sDGEoY+66U83cfjFFgGJJDbGyg==
X-Google-Smtp-Source: APBJJlEFXRvsXgP5VRHhN+sh7ovEBJqVSJ1FXu8r1wOtAChoVYXMmVGfgvD89P+UHQhlhT8RyIudOg==
X-Received: by 2002:a17:903:110d:b0:1b3:d6c8:7008 with SMTP id n13-20020a170903110d00b001b3d6c87008mr19202953plh.57.1689190144573;
        Wed, 12 Jul 2023 12:29:04 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902eac200b001b03a1a3151sm4358817pld.70.2023.07.12.12.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:29:04 -0700 (PDT)
Date:   Wed, 12 Jul 2023 12:29:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Laurent Vivier <laurent@vivier.eu>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>,
        Henning Schild <henning.schild@siemens.com>,
        Andrei Vagin <avagin@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 2/2] binfmt_misc: enable sandboxed mounts
Message-ID: <202307121219.1BD273E@keescook>
References: <20211216112659.310979-1-brauner@kernel.org>
 <20211216112659.310979-2-brauner@kernel.org>
 <20211226133140.GA8064@mail.hallyn.com>
 <0e817424-51db-fe0b-a00e-ac7933e8ac1d@siemens.com>
 <20220530081358.b3tvgvo63mq5o2oo@wittgenstein>
 <202205311219.725ED1C69@keescook>
 <20220602104107.6b3d3udhslvhg6ew@wittgenstein>
 <08b4b0c8-3621-a970-d206-d24e6eb81355@siemens.com>
 <20230712185448.GA611149@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712185448.GA611149@mail.hallyn.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 12, 2023 at 01:54:48PM -0500, Serge E. Hallyn wrote:
> On Tue, Feb 28, 2023 at 07:20:28AM +0100, Jan Kiszka wrote:
> > On 02.06.22 12:41, Christian Brauner wrote:
> > > On Tue, May 31, 2022 at 12:24:37PM -0700, Kees Cook wrote:
> > >> On Mon, May 30, 2022 at 10:13:58AM +0200, Christian Brauner wrote:
> > >>> On Sun, May 29, 2022 at 09:35:40PM +0200, Jan Kiszka wrote:
> > >>>> On 26.12.21 14:31, Serge E. Hallyn wrote:
> > >>>>> On Thu, Dec 16, 2021 at 12:26:59PM +0100, Christian Brauner wrote:
> > >>>>>> From: Christian Brauner <christian.brauner@ubuntu.com>
> > >>>>>>
> > >>>>>> Enable unprivileged sandboxes to create their own binfmt_misc mounts.
> > >>>>>> This is based on Laurent's work in [1] but has been significantly
> > >>>>>> reworked to fix various issues we identified in earlier versions.
> > >>>>>>
> > >>>>>> While binfmt_misc can currently only be mounted in the initial user
> > >>>>>> namespace, binary types registered in this binfmt_misc instance are
> > >>>>>> available to all sandboxes (Either by having them installed in the
> > >>>>>> sandbox or by registering the binary type with the F flag causing the
> > >>>>>> interpreter to be opened right away). So binfmt_misc binary types are
> > >>>>>> already delegated to sandboxes implicitly.
> > >>>>>>
> > >>>>>> However, while a sandbox has access to all registered binary types in
> > >>>>>> binfmt_misc a sandbox cannot currently register its own binary types
> > >>>>>> in binfmt_misc. This has prevented various use-cases some of which were
> > >>>>>> already outlined in [1] but we have a range of issues associated with
> > >>>>>> this (cf. [3]-[5] below which are just a small sample).
> > >>>>>>
> > >>>>>> Extend binfmt_misc to be mountable in non-initial user namespaces.
> > >>>>>> Similar to other filesystem such as nfsd, mqueue, and sunrpc we use
> > >>>>>> keyed superblock management. The key determines whether we need to
> > >>>>>> create a new superblock or can reuse an already existing one. We use the
> > >>>>>> user namespace of the mount as key. This means a new binfmt_misc
> > >>>>>> superblock is created once per user namespace creation. Subsequent
> > >>>>>> mounts of binfmt_misc in the same user namespace will mount the same
> > >>>>>> binfmt_misc instance. We explicitly do not create a new binfmt_misc
> > >>>>>> superblock on every binfmt_misc mount as the semantics for
> > >>>>>> load_misc_binary() line up with the keying model. This also allows us to
> > >>>>>> retrieve the relevant binfmt_misc instance based on the caller's user
> > >>>>>> namespace which can be done in a simple (bounded to 32 levels) loop.
> > >>>>>>
> > >>>>>> Similar to the current binfmt_misc semantics allowing access to the
> > >>>>>> binary types in the initial binfmt_misc instance we do allow sandboxes
> > >>>>>> access to their parent's binfmt_misc mounts if they do not have created
> > >>>>>> a separate binfmt_misc instance.
> > >>>>>>
> > >>>>>> Overall, this will unblock the use-cases mentioned below and in general
> > >>>>>> will also allow to support and harden execution of another
> > >>>>>> architecture's binaries in tight sandboxes. For instance, using the
> > >>>>>> unshare binary it possible to start a chroot of another architecture and
> > >>>>>> configure the binfmt_misc interpreter without being root to run the
> > >>>>>> binaries in this chroot and without requiring the host to modify its
> > >>>>>> binary type handlers.
> > >>>>>>
> > >>>>>> Henning had already posted a few experiments in the cover letter at [1].
> > >>>>>> But here's an additional example where an unprivileged container
> > >>>>>> registers qemu-user-static binary handlers for various binary types in
> > >>>>>> its separate binfmt_misc mount and is then seamlessly able to start
> > >>>>>> containers with a different architecture without affecting the host:
> > >>>>>>
> > >>>>>> root    [lxc monitor] /var/snap/lxd/common/lxd/containers f1
> > >>>>>> 1000000  \_ /sbin/init
> > >>>>>> 1000000      \_ /lib/systemd/systemd-journald
> > >>>>>> 1000000      \_ /lib/systemd/systemd-udevd
> > >>>>>> 1000100      \_ /lib/systemd/systemd-networkd
> > >>>>>> 1000101      \_ /lib/systemd/systemd-resolved
> > >>>>>> 1000000      \_ /usr/sbin/cron -f
> > >>>>>> 1000103      \_ /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
> > >>>>>> 1000000      \_ /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
> > >>>>>> 1000104      \_ /usr/sbin/rsyslogd -n -iNONE
> > >>>>>> 1000000      \_ /lib/systemd/systemd-logind
> > >>>>>> 1000000      \_ /sbin/agetty -o -p -- \u --noclear --keep-baud console 115200,38400,9600 vt220
> > >>>>>> 1000107      \_ dnsmasq --conf-file=/dev/null -u lxc-dnsmasq --strict-order --bind-interfaces --pid-file=/run/lxc/dnsmasq.pid --liste
> > >>>>>> 1000000      \_ [lxc monitor] /var/lib/lxc f1-s390x
> > >>>>>> 1100000          \_ /usr/bin/qemu-s390x-static /sbin/init
> > >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-journald
> > >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /usr/sbin/cron -f
> > >>>>>> 1100103              \_ /usr/bin/qemu-s390x-static /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-ac
> > >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
> > >>>>>> 1100104              \_ /usr/bin/qemu-s390x-static /usr/sbin/rsyslogd -n -iNONE
> > >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-logind
> > >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud console 115200,38400,9600 vt220
> > >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/0 115200,38400,9600 vt220
> > >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/1 115200,38400,9600 vt220
> > >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/2 115200,38400,9600 vt220
> > >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/3 115200,38400,9600 vt220
> > >>>>>> 1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-udevd
> > >>>>>>
> > >>>>>> [1]: https://lore.kernel.org/all/20191216091220.465626-1-laurent@vivier.eu
> > >>>>>> [2]: https://discuss.linuxcontainers.org/t/binfmt-misc-permission-denied
> > >>>>>> [3]: https://discuss.linuxcontainers.org/t/lxd-binfmt-support-for-qemu-static-interpreters
> > >>>>>> [4]: https://discuss.linuxcontainers.org/t/3-1-0-binfmt-support-service-in-unprivileged-guest-requires-write-access-on-hosts-proc-sys-fs-binfmt-misc
> > >>>>>> [5]: https://discuss.linuxcontainers.org/t/qemu-user-static-not-working-4-11
> > >>>>>>
> > >>>>>> Link: https://lore.kernel.org/r/20191216091220.465626-2-laurent@vivier.eu (origin)
> > >>>>>> Link: https://lore.kernel.org/r/20211028103114.2849140-2-brauner@kernel.org (v1)
> > >>>>>> Cc: Sargun Dhillon <sargun@sargun.me>
> > >>>>>> Cc: Serge Hallyn <serge@hallyn.com>
> > >>>>>
> > >>>>> (one typo below)
> > >>>>>
> > >>>>> Acked-by: Serge Hallyn <serge@hallyn.com>
> > >>>>>
> > >>>>
> > >>>> What happened to this afterwards? Any remaining issues?
> > >>>
> > >>> Not that we know. I plan to queue this up for 5.20.
> > >>
> > >> Hello!
> > >>
> > >> Thanks for the thread-ping -- I hadn't had a chance to read through this
> > >> before, but since it's touching binfmt, it popped up on my radar. :)
> > >>
> > >> I like it overall, though I'd rather see it split up more (there's
> > >> some refactoring built into the patches that would be nice to split out
> > >> just to make review easier), but since others have already reviewed it,
> > >> that's probably overkill.
> > >>
> > >> I'd really like to see some self-tests for this, though. Especially
> > > 
> > > Yeah, I had started writing them but decoupled the upstreaming. Imho,
> > > you can start queueing this up. I'd like this to have very long exposure
> > > in -next. I'll follow up with selftests in the next weeks. (I'm out for
> > > a conference this week.)
> > > 
> > >> around the cred logic changes and the namespace fallback logic. I'd like
> > >> to explicitly document and test what the expectations are around the
> > >> mounts, etc.
> > >>
> > >> Finally, I'd prefer this went via the execve tree.
> > > 
> > > I mentioned this yesterday to you but just so there's a paper trail:
> > > The series and this iteration preceeds the maintainer entry. That's the
> > > only reason this originally wasn't aimed at that tree when the series
> > > was sent. You've been in Cc from the start though. :)
> > > I'd like to step up and maintain the binfmt_misc fs going forward. There
> > > are other tweaks it could use.
> > > 
> > 
> > Did anything happen after this? I'm not finding traced in lkml at least.
> > 
> > Jan
> 
> Looking at https://lore.kernel.org/all/20230630-hufen-herzallerliebst-fde8e7aecba0@brauner/
> looks like Christian was going to ping Kees about taking
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs.binfmt_misc

Ah yeah! I forgot all about this series. I can pull this into the execve
tree now for max linux-next testing.

-- 
Kees Cook
