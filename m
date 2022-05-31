Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581DE5396F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 May 2022 21:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346338AbiEaTYq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 15:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbiEaTYk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 15:24:40 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C8C9968A
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 12:24:39 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id c14so397716pgu.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=790ZGIWLu3M3fciHJnar3YBAhr4IOM5eNhb2rLFf0HQ=;
        b=ZlDjvw3Ht/bFFf8r0sW6FLU2cNvq5PNson53ZKFZtoLckRqYPs6XKmwKUSlfBheNPO
         9qDqCUTcvyoTfcE2Z9YxRa3Zx61lYn0c78qB+aSelPEiX/noLol7MJaf33lPvGph13mL
         I6A/9bhVBjvaoD6M+4/IwGj7Nz6/mcx9KNgNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=790ZGIWLu3M3fciHJnar3YBAhr4IOM5eNhb2rLFf0HQ=;
        b=xdZh6IbEZak5IYT4BMhI0OwKA0E/pgzT1KsmQSWojHYXkgVQe/qodPcGR7tRUjgUfD
         8WuOhdnjc7GMjGnbvtsdPe0e73rdkGUJWJrvBMuhd2oCJxBS+lJxid9+fiXxJos1KYmu
         2TjQXBHEAgM6V+jmKn7jyN2QpvDC5bifMWSjOW+AGvlnF+bC0DC5dTOwYEOgjh65ucH5
         SBOHQKlOn07BSB0zPYXB/lu6+Wrg7sb/fYtBkuUg4zB3Evn44QqP2J/uYSH687wzixyi
         OdTEBsb+H9/gZ+TynxOjvpf3yOOfaWCkE9Sw7FZI0YJv20twA1SnPq5gGrcgIs2Fs/Na
         Y68Q==
X-Gm-Message-State: AOAM532J1d03nNPaGFGCl7teWtXE8/LEZB7OvDGfumQj0w0tn3w6iY2R
        vpoevnssPJrxkR+CVEquq3Uyyg==
X-Google-Smtp-Source: ABdhPJwjahwm2XcxJzarB0bkFTPaJCZS6iCgNIpZLQNwb7hsy9A6fndnl0egtxKCatv7ANknoIeKrw==
X-Received: by 2002:a65:404c:0:b0:3c6:4018:ffbf with SMTP id h12-20020a65404c000000b003c64018ffbfmr54323134pgp.408.1654025078759;
        Tue, 31 May 2022 12:24:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fs24-20020a17090af29800b001e02073474csm2305234pjb.36.2022.05.31.12.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 12:24:38 -0700 (PDT)
Date:   Tue, 31 May 2022 12:24:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
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
Message-ID: <202205311219.725ED1C69@keescook>
References: <20211216112659.310979-1-brauner@kernel.org>
 <20211216112659.310979-2-brauner@kernel.org>
 <20211226133140.GA8064@mail.hallyn.com>
 <0e817424-51db-fe0b-a00e-ac7933e8ac1d@siemens.com>
 <20220530081358.b3tvgvo63mq5o2oo@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530081358.b3tvgvo63mq5o2oo@wittgenstein>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 30, 2022 at 10:13:58AM +0200, Christian Brauner wrote:
> On Sun, May 29, 2022 at 09:35:40PM +0200, Jan Kiszka wrote:
> > On 26.12.21 14:31, Serge E. Hallyn wrote:
> > > On Thu, Dec 16, 2021 at 12:26:59PM +0100, Christian Brauner wrote:
> > >> From: Christian Brauner <christian.brauner@ubuntu.com>
> > >>
> > >> Enable unprivileged sandboxes to create their own binfmt_misc mounts.
> > >> This is based on Laurent's work in [1] but has been significantly
> > >> reworked to fix various issues we identified in earlier versions.
> > >>
> > >> While binfmt_misc can currently only be mounted in the initial user
> > >> namespace, binary types registered in this binfmt_misc instance are
> > >> available to all sandboxes (Either by having them installed in the
> > >> sandbox or by registering the binary type with the F flag causing the
> > >> interpreter to be opened right away). So binfmt_misc binary types are
> > >> already delegated to sandboxes implicitly.
> > >>
> > >> However, while a sandbox has access to all registered binary types in
> > >> binfmt_misc a sandbox cannot currently register its own binary types
> > >> in binfmt_misc. This has prevented various use-cases some of which were
> > >> already outlined in [1] but we have a range of issues associated with
> > >> this (cf. [3]-[5] below which are just a small sample).
> > >>
> > >> Extend binfmt_misc to be mountable in non-initial user namespaces.
> > >> Similar to other filesystem such as nfsd, mqueue, and sunrpc we use
> > >> keyed superblock management. The key determines whether we need to
> > >> create a new superblock or can reuse an already existing one. We use the
> > >> user namespace of the mount as key. This means a new binfmt_misc
> > >> superblock is created once per user namespace creation. Subsequent
> > >> mounts of binfmt_misc in the same user namespace will mount the same
> > >> binfmt_misc instance. We explicitly do not create a new binfmt_misc
> > >> superblock on every binfmt_misc mount as the semantics for
> > >> load_misc_binary() line up with the keying model. This also allows us to
> > >> retrieve the relevant binfmt_misc instance based on the caller's user
> > >> namespace which can be done in a simple (bounded to 32 levels) loop.
> > >>
> > >> Similar to the current binfmt_misc semantics allowing access to the
> > >> binary types in the initial binfmt_misc instance we do allow sandboxes
> > >> access to their parent's binfmt_misc mounts if they do not have created
> > >> a separate binfmt_misc instance.
> > >>
> > >> Overall, this will unblock the use-cases mentioned below and in general
> > >> will also allow to support and harden execution of another
> > >> architecture's binaries in tight sandboxes. For instance, using the
> > >> unshare binary it possible to start a chroot of another architecture and
> > >> configure the binfmt_misc interpreter without being root to run the
> > >> binaries in this chroot and without requiring the host to modify its
> > >> binary type handlers.
> > >>
> > >> Henning had already posted a few experiments in the cover letter at [1].
> > >> But here's an additional example where an unprivileged container
> > >> registers qemu-user-static binary handlers for various binary types in
> > >> its separate binfmt_misc mount and is then seamlessly able to start
> > >> containers with a different architecture without affecting the host:
> > >>
> > >> root    [lxc monitor] /var/snap/lxd/common/lxd/containers f1
> > >> 1000000  \_ /sbin/init
> > >> 1000000      \_ /lib/systemd/systemd-journald
> > >> 1000000      \_ /lib/systemd/systemd-udevd
> > >> 1000100      \_ /lib/systemd/systemd-networkd
> > >> 1000101      \_ /lib/systemd/systemd-resolved
> > >> 1000000      \_ /usr/sbin/cron -f
> > >> 1000103      \_ /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
> > >> 1000000      \_ /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
> > >> 1000104      \_ /usr/sbin/rsyslogd -n -iNONE
> > >> 1000000      \_ /lib/systemd/systemd-logind
> > >> 1000000      \_ /sbin/agetty -o -p -- \u --noclear --keep-baud console 115200,38400,9600 vt220
> > >> 1000107      \_ dnsmasq --conf-file=/dev/null -u lxc-dnsmasq --strict-order --bind-interfaces --pid-file=/run/lxc/dnsmasq.pid --liste
> > >> 1000000      \_ [lxc monitor] /var/lib/lxc f1-s390x
> > >> 1100000          \_ /usr/bin/qemu-s390x-static /sbin/init
> > >> 1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-journald
> > >> 1100000              \_ /usr/bin/qemu-s390x-static /usr/sbin/cron -f
> > >> 1100103              \_ /usr/bin/qemu-s390x-static /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-ac
> > >> 1100000              \_ /usr/bin/qemu-s390x-static /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
> > >> 1100104              \_ /usr/bin/qemu-s390x-static /usr/sbin/rsyslogd -n -iNONE
> > >> 1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-logind
> > >> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud console 115200,38400,9600 vt220
> > >> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/0 115200,38400,9600 vt220
> > >> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/1 115200,38400,9600 vt220
> > >> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/2 115200,38400,9600 vt220
> > >> 1100000              \_ /usr/bin/qemu-s390x-static /sbin/agetty -o -p -- \u --noclear --keep-baud pts/3 115200,38400,9600 vt220
> > >> 1100000              \_ /usr/bin/qemu-s390x-static /lib/systemd/systemd-udevd
> > >>
> > >> [1]: https://lore.kernel.org/all/20191216091220.465626-1-laurent@vivier.eu
> > >> [2]: https://discuss.linuxcontainers.org/t/binfmt-misc-permission-denied
> > >> [3]: https://discuss.linuxcontainers.org/t/lxd-binfmt-support-for-qemu-static-interpreters
> > >> [4]: https://discuss.linuxcontainers.org/t/3-1-0-binfmt-support-service-in-unprivileged-guest-requires-write-access-on-hosts-proc-sys-fs-binfmt-misc
> > >> [5]: https://discuss.linuxcontainers.org/t/qemu-user-static-not-working-4-11
> > >>
> > >> Link: https://lore.kernel.org/r/20191216091220.465626-2-laurent@vivier.eu (origin)
> > >> Link: https://lore.kernel.org/r/20211028103114.2849140-2-brauner@kernel.org (v1)
> > >> Cc: Sargun Dhillon <sargun@sargun.me>
> > >> Cc: Serge Hallyn <serge@hallyn.com>
> > > 
> > > (one typo below)
> > > 
> > > Acked-by: Serge Hallyn <serge@hallyn.com>
> > > 
> > 
> > What happened to this afterwards? Any remaining issues?
> 
> Not that we know. I plan to queue this up for 5.20.

Hello!

Thanks for the thread-ping -- I hadn't had a chance to read through this
before, but since it's touching binfmt, it popped up on my radar. :)

I like it overall, though I'd rather see it split up more (there's
some refactoring built into the patches that would be nice to split out
just to make review easier), but since others have already reviewed it,
that's probably overkill.

I'd really like to see some self-tests for this, though. Especially
around the cred logic changes and the namespace fallback logic. I'd like
to explicitly document and test what the expectations are around the
mounts, etc.

Finally, I'd prefer this went via the execve tree.

-Kees

-- 
Kees Cook
