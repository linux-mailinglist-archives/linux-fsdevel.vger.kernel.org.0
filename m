Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F228198E16
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 10:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbgCaIPT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 04:15:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36301 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgCaIPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:15:18 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jJC3B-0000Od-Ku; Tue, 31 Mar 2020 08:15:09 +0000
Date:   Tue, 31 Mar 2020 10:15:07 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200331081507.f6an4x32cxwpxdpd@wittgenstein>
References: <1445647.1585576702@warthog.procyon.org.uk>
 <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 07:11:11AM +0200, Miklos Szeredi wrote:
> On Mon, Mar 30, 2020 at 11:17 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> 
> > Fwiw, putting down my kernel hat and speaking as someone who maintains
> > two container runtimes and various other low-level bits and pieces in
> > userspace who'd make heavy use of this stuff I would prefer the fd-based
> > fsinfo() approach especially in the light of across namespace
> > operations, querying all properties of a mount atomically all-at-once,
> 
> fsinfo(2) doesn't meet the atomically all-at-once requirement.  Sure,
> it's possible to check the various change counters before and after a
> batch of calls to check that the result is consistent.  Still, that's
> not an atomic all-at-once query, if you'd really require that, than
> fsinfo(2) as it currently stands would be inadequate.

It at all that's only true for batch requests.

> 
> > and safe delegation through fds. Another heavy user of this would be
> > systemd (Cced Lennart who I've discussed this with) which would prefer
> > the fd-based approach as well. I think pulling this into a filesystem
> > and making userspace parse around in a filesystem tree to query mount
> > information is the wrong approach and will get messy pretty quickly
> > especially in the face of mount and user namespace interactions and
> > various other pitfalls.
> 
> Have you actually looked at my proposed patch?   Do you have concrete

Yes. So have others, Al actively disliked and nacked it and no-one got
excited about it.

> issues or just vague bad feelings?

We have had that discussion on-list where I made my "vague bad feelings"
clear where you responded with the same dismissive style so I don't see
the point in repeating this experience.

Again, I want to make it clear that here I'm stating my preference as a
user of this api and as such I don't want to have to parse through a
filesystem to get complex information about filesystems. We've had
fruitful discussions [1] around how fsinfo() ties in with supervised
mounts and the rest of the mount api and its clear and simple especially
in the face of namespaces and implements a nice delegation model. So +1
from me.

Christian

[1]: https://youtu.be/LN2CUgp8deo?t=6840
