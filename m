Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFE5242097
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 21:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgHKTuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 15:50:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54056 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgHKTue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:50:34 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k5aI2-0002GB-Ig; Tue, 11 Aug 2020 19:50:30 +0000
Date:   Tue, 11 Aug 2020 21:50:29 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
Message-ID: <20200811195029.cnowfkikr2xajhgo@wittgenstein>
References: <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
 <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <CAJfpegtWai+5Tzxi1_G+R2wEZz0q66uaOFndNE0YEQSDjq0f_A@mail.gmail.com>
 <CAHk-=wg_bfVf5eazwH2uXTG-auCYZUpq-xb1kDeNjY7yaXS7bw@mail.gmail.com>
 <CAJfpeguo5nAWcmduX4frknQGiRJeaj9Rdj018xUBrwqOJhVufw@mail.gmail.com>
 <20200811193105.GA228302@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200811193105.GA228302@gardel-login>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 09:31:05PM +0200, Lennart Poettering wrote:
> On Di, 11.08.20 20:49, Miklos Szeredi (miklos@szeredi.hu) wrote:
> 
> > On Tue, Aug 11, 2020 at 6:05 PM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >
> > > and then people do "$(srctree)/". If you haven't seen that kind of
> > > pattern where the pathname has two (or sometimes more!) slashes in the
> > > middle, you've led a very sheltered life.
> >
> > Oh, I have.   That's why I opted for triple slashes, since that should
> > work most of the time even in those concatenated cases.  And yes, I
> > know, most is not always, and this might just be hiding bugs, etc...
> > I think the pragmatic approach would be to try this and see how many
> > triple slash hits a normal workload gets and if it's reasonably low,
> > then hopefully that together with warnings for O_ALT would be enough.
> 
> There's no point. Userspace relies on the current meaning of triple
> slashes. It really does.
> 
> I know many places in systemd where we might end up with a triple
> slash. Here's a real-life example: some code wants to access the
> cgroup attribute 'cgroup.controllers' of the root cgroup. It thus
> generates the right path in the fs for it, which is the concatenation of
> "/sys/fs/cgroup/" (because that's where cgroupfs is mounted), of "/"
> (i.e. for the root cgroup) and of "/cgroup.controllers" (as that's the
> file the attribute is exposed under).
> 
> And there you go:
> 
>    "/sys/fs/cgroup/" + "/" + "/cgroup.controllers" → "/sys/fs/cgroup///cgroup.controllers"
> 
> This is a real-life thing. Don't break this please.

Taken from a log from a container:

lxc f4 20200810105815.742 TRACE    cgfsng - cgroups/cgfsng.c:cg_legacy_handle_cpuset_hierarchy:552 - "cgroup.clone_children" was already set to "1"
lxc f4 20200810105815.742 WARN     cgfsng - cgroups/cgfsng.c:mkdir_eexist_on_last:1152 - File exists - Failed to create directory "/sys/fs/cgroup/cpuset///lxc.monitor.f4"
lxc f4 20200810105815.743 INFO     cgfsng - cgroups/cgfsng.c:cgfsng_monitor_create:1366 - The monitor process uses "lxc.monitor.f4" as cgroup
lxc f4 20200810105815.743 DEBUG    storage - storage/storage.c:get_storage_by_name:211 - Detected rootfs type "dir"
lxc f4 20200810105815.743 TRACE    cgfsng - cgroups/cgfsng.c:cg_legacy_handle_cpuset_hierarchy:552 - "cgroup.clone_children" was already set to "1"
lxc f4 20200810105815.743 WARN     cgfsng - cgroups/cgfsng.c:mkdir_eexist_on_last:1152 - File exists - Failed to create directory "/sys/fs/cgroup/cpuset///lxc.payload.f4"
lxc f4 20200810105815.743 INFO     cgfsng - cgroups/cgfsng.c:cgfsng_payload_create:1469 - The container process uses "lxc.payload.f4" as cgroup
lxc f4 20200810105815.744 TRACE    start - start.c:lxc_spawn:1731 - Spawned container directly into target cgroup via cgroup2 fd 17 

Christian
