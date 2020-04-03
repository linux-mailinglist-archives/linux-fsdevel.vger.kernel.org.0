Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9DB19D9A9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404021AbgDCPBp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 11:01:45 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:51982 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727431AbgDCPBp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:01:45 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 7C208E807B5;
        Fri,  3 Apr 2020 17:01:43 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 1E8C41614E3; Fri,  3 Apr 2020 17:01:43 +0200 (CEST)
Date:   Fri, 3 Apr 2020 17:01:43 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200403150143.GA34800@gardel-login>
References: <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <20200402143623.GB31529@gardel-login>
 <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
 <20200402152831.GA31612@gardel-login>
 <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
 <20200402155020.GA31715@gardel-login>
 <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
 <20200403110842.GA34663@gardel-login>
 <CAJfpegtYKhXB-HNddUeEMKupR5L=RRuydULrvm39eTung0=yRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpegtYKhXB-HNddUeEMKupR5L=RRuydULrvm39eTung0=yRg@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fr, 03.04.20 13:48, Miklos Szeredi (miklos@szeredi.hu) wrote:

> > > Does that make any sense?
> >
> > When all mounts in the init mount namespace are unmounted and all
> > remaining processes killed we switch root back to the initrd, so that
> > even the root fs can be unmounted, and then we disassemble any backing
> > complex storage if there is, i.e. lvm, luks, raid, …
>
> I think it could be done the other way round, much simpler:
>
>  - switch back to initrd
>  - umount root, keeping the tree intact (UMOUNT_DETACHED)
>  - kill all remaining processes, wait for all to exit

Nah. What I wrote above is drastically simplified. It's IRL more
complex. Specific services need to be killed between certain mounts
are unmounted, since they are a backend for another mount. NFS, or
FUSE or stuff like that usually has some processes backing them
around, and we need to stop the mounts they provide before these
services, and then the mounts these services reside on after that, and
so on. It's a complex dependency tree of stuff that needs to be done
in order, so that we can deal with arbitrarily nested mounts, storage
subsystems, and backing services.

Anyway, this all works fine in systemd, the dependency logic is
there. We want a more efficient way to watch mounts, that's
all. Subscribing and constantly reparsing /proc/self/mountinfo is
awful, that's all.

Lennart

--
Lennart Poettering, Berlin
