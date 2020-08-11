Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC7B242074
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 21:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgHKTkV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 15:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgHKTkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:40:19 -0400
X-Greylist: delayed 547 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Aug 2020 12:40:19 PDT
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5679C06174A;
        Tue, 11 Aug 2020 12:40:19 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id D6BA2E814E3;
        Tue, 11 Aug 2020 21:31:06 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 3596D16081D; Tue, 11 Aug 2020 21:31:06 +0200 (CEST)
Date:   Tue, 11 Aug 2020 21:31:05 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20200811193105.GA228302@gardel-login>
References: <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
 <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <CAJfpegtWai+5Tzxi1_G+R2wEZz0q66uaOFndNE0YEQSDjq0f_A@mail.gmail.com>
 <CAHk-=wg_bfVf5eazwH2uXTG-auCYZUpq-xb1kDeNjY7yaXS7bw@mail.gmail.com>
 <CAJfpeguo5nAWcmduX4frknQGiRJeaj9Rdj018xUBrwqOJhVufw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfpeguo5nAWcmduX4frknQGiRJeaj9Rdj018xUBrwqOJhVufw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Di, 11.08.20 20:49, Miklos Szeredi (miklos@szeredi.hu) wrote:

> On Tue, Aug 11, 2020 at 6:05 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>
> > and then people do "$(srctree)/". If you haven't seen that kind of
> > pattern where the pathname has two (or sometimes more!) slashes in the
> > middle, you've led a very sheltered life.
>
> Oh, I have.   That's why I opted for triple slashes, since that should
> work most of the time even in those concatenated cases.  And yes, I
> know, most is not always, and this might just be hiding bugs, etc...
> I think the pragmatic approach would be to try this and see how many
> triple slash hits a normal workload gets and if it's reasonably low,
> then hopefully that together with warnings for O_ALT would be enough.

There's no point. Userspace relies on the current meaning of triple
slashes. It really does.

I know many places in systemd where we might end up with a triple
slash. Here's a real-life example: some code wants to access the
cgroup attribute 'cgroup.controllers' of the root cgroup. It thus
generates the right path in the fs for it, which is the concatenation of
"/sys/fs/cgroup/" (because that's where cgroupfs is mounted), of "/"
(i.e. for the root cgroup) and of "/cgroup.controllers" (as that's the
file the attribute is exposed under).

And there you go:

   "/sys/fs/cgroup/" + "/" + "/cgroup.controllers" → "/sys/fs/cgroup///cgroup.controllers"

This is a real-life thing. Don't break this please.

Lennart

--
Lennart Poettering, Berlin
