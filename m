Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0034617D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 15:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243432AbhK2OUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 09:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243561AbhK2OSP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 09:18:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D998FC08EAF1;
        Mon, 29 Nov 2021 04:55:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A474CB810A1;
        Mon, 29 Nov 2021 12:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5832C004E1;
        Mon, 29 Nov 2021 12:55:30 +0000 (UTC)
Date:   Mon, 29 Nov 2021 13:55:27 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>,
        Henning Schild <henning.schild@siemens.com>,
        Andrei Vagin <avagin@gmail.com>,
        Laurent Vivier <laurent@vivier.eu>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, containers@lists.linux.dev
Subject: Re: [PATCH 2/2] binfmt_misc: enable sandboxed mounts
Message-ID: <20211129125527.fcljhmg4hfpdnseu@wittgenstein>
References: <20211028103114.2849140-1-brauner@kernel.org>
 <20211028103114.2849140-2-brauner@kernel.org>
 <20211105043000.GA25244@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211105043000.GA25244@mail.hallyn.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 04, 2021 at 11:30:00PM -0500, Serge Hallyn wrote:
> On Thu, Oct 28, 2021 at 12:31:14PM +0200, Christian Brauner wrote:
> > From: Laurent Vivier <laurent@vivier.eu>
> > 
> > Enable unprivileged sandboxes to create their own binfmt_misc mounts.
> > This is based on Laurent's work in [1] but has been significantly
> > reworked to fix various issues we identified in earlier versions.
> > 
> > While binfmt_misc can currently only be mounted in the initial user
> > namespace, binary types registered in this binfmt_misc instance are
> > available to all sandboxes (Either by having them installed in the
> > sandbox or by registering the binary type with the F flag causing the
> > interpreter to be opened right away). So binfmt_misc binary types are
> > already delegated to sandboxes implicitly.
> > 
> > However, while a sandbox has access to all registered binary types in
> > binfmt_misc a sandbox cannot currently register its own binary types
> > in binfmt_misc. This has prevented various use-cases some of which were
> > already outlined in [1] but we have a range of issues associated with
> > this (cf. [3]-[5] below which are just a small sample).
> > 
> > Extend binfmt_misc to be mountable in non-initial user namespaces.
> > Similar to other filesystem such as nfsd, mqueue, and sunrpc we use
> > keyed superblock management. The key determines whether we need to
> > create a new superblock or can reuse an already existing one. We use the
> > user namespace of the mount as key. This means a new binfmt_misc
> > superblock is created once per user namespace creation. Subsequent
> > mounts of binfmt_misc in the same user namespace will mount the same
> > binfmt_misc instance. We explicitly do not create a new binfmt_misc
> > superblock on every binfmt_misc mount as the semantics for
> > load_misc_binary() line up with the keying model. This also allows us to
> > retrieve the relevant binfmt_misc instance based on the caller's user
> > namespace which can be done in a simple (bounded to 32 levels) loop.
> > 
> > Similar to the current binfmt_misc semantics allowing access to the
> > binary types in the initial binfmt_misc instance we do allow sandboxes
> > access to their parent's binfmt_misc mounts if they do not have created
> > a separate binfmt_misc instance.
> > 
> > Overall, this will unblock the use-cases mentioned below and in general
> > will also allow to support and harden execution of another
> > architecture's binaries in tight sandboxes. For instance, using the
> > unshare binary it possible to start a chroot of another architecture and
> > configure the binfmt_misc interpreter without being root to run the
> > binaries in this chroot and without requiring the host to modify its
> > binary type handlers.
> > 
> > Henning had already posted a few experiments in the cover letter at [1].
> > But here's an additional example where an unprivileged container
> > registers qemu-user-static binary handlers for various binary types in
> > its separate binfmt_misc mount and is then seamlessly able to start
> > containers with a different architecture without affecting the host:
> > 
> > [lxc monitor] /var/lib/lxc imp2
> >  \_ /sbin/init
> >      \_ /lib/systemd/systemd-journald
> >      \_ /lib/systemd/systemd-udevd
> >      \_ /lib/systemd/systemd-networkd
> >      \_ /usr/sbin/cron -f -P
> >      \_ @dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
> >      \_ /usr/bin/python3 /usr/bin/networkd-dispatcher --run-startup-triggers
> >      \_ /usr/sbin/rsyslogd -n -iNONE
> >      \_ /lib/systemd/systemd-logind
> >      \_ /lib/systemd/systemd-resolved
> >      \_ dnsmasq --conf-file=/dev/null -u lxc-dnsmasq --strict-order --bind-interfaces --pid-file=/run/lxc/dnsmasq.pid --liste
> >      \_ /sbin/agetty -o -p -- \u --noclear --keep-baud console 115200,38400,9600 vt220
> >      \_ /sbin/agetty -o -p -- \u --noclear --keep-baud pts/0 115200,38400,9600 vt220
> >      \_ /sbin/agetty -o -p -- \u --noclear --keep-baud pts/1 115200,38400,9600 vt220
> >      \_ /sbin/agetty -o -p -- \u --noclear --keep-baud pts/2 115200,38400,9600 vt220
> >      \_ /sbin/agetty -o -p -- \u --noclear --keep-baud pts/3 115200,38400,9600 vt220
> >      \_ [lxc monitor] /var/lib/lxc alp1
> >          \_ /usr/libexec/qemu-binfmt/ppc64le-binfmt-P /sbin/init /sbin/init
> >              \_ /usr/libexec/qemu-binfmt/ppc64le-binfmt-P /lib/systemd/systemd-journald /lib/systemd/systemd-journald
> >              \_ /usr/libexec/qemu-binfmt/ppc64le-binfmt-P /lib/systemd/systemd-udevd /lib/systemd/systemd-udevd
> >              \_ /usr/libexec/qemu-binfmt/ppc64le-binfmt-P /usr/sbin/cron /usr/sbin/cron -f -P
> >              \_ /usr/libexec/qemu-binfmt/ppc64le-binfmt-P /lib/systemd/systemd-resolved /lib/systemd/systemd-resolved
> >              \_ /usr/libexec/qemu-binfmt/ppc64le-binfmt-P /lib/systemd/systemd-logind /lib/systemd/systemd-logind
> > 
> > Link: https://lore.kernel.org/r/20191216091220.465626-2-laurent@vivier.eu
> > [1]: https://lore.kernel.org/all/20191216091220.465626-1-laurent@vivier.eu
> > [2]: https://discuss.linuxcontainers.org/t/binfmt-misc-permission-denied
> > [3]: https://discuss.linuxcontainers.org/t/lxd-binfmt-support-for-qemu-static-interpreters
> > [4]: https://discuss.linuxcontainers.org/t/3-1-0-binfmt-support-service-in-unprivileged-guest-requires-write-access-on-hosts-proc-sys-fs-binfmt-misc
> > [5]: https://discuss.linuxcontainers.org/t/qemu-user-static-not-working-4-11
> > Cc: Sargun Dhillon <sargun@sargun.me>
> > Cc: Serge Hallyn <serge@hallyn.com>
> 
> I *think* this is ok.  I'm still trying to convince myself that there is
> no way for evict_inode() to run after the kfree(ns->binfmt_misc), but
> it doesn't look like there is.
> 
> Does this memory (as the number of register entries grows) need to be
> accounted for and/or limited ?

Good point. We should pass GFP_KERNEL_ACCOUNT andor use a cache with
SLAB_ACCOUNT. I'll fix that up.

Christian
