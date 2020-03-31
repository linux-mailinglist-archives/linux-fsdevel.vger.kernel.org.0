Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72884198CED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 09:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCaH2z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 03:28:55 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:48338 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgCaH2z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 03:28:55 -0400
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Mar 2020 03:28:55 EDT
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id B5053E814E3;
        Tue, 31 Mar 2020 09:22:25 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id D3507160704; Tue, 31 Mar 2020 09:22:24 +0200 (CEST)
Date:   Tue, 31 Mar 2020 09:22:24 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, dray@redhat.com, kzak@redhat.com,
        mszeredi@redhat.com, swhiteho@redhat.com, jlayton@redhat.com,
        raven@themaw.net, andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cyphar@cyphar.com
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200331072224.GA27062@gardel-login>
References: <1445647.1585576702@warthog.procyon.org.uk>
 <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mo, 30.03.20 23:17, Christian Brauner (christian.brauner@ubuntu.com) wrote:

> Fwiw, putting down my kernel hat and speaking as someone who maintains
> two container runtimes and various other low-level bits and pieces in
> userspace who'd make heavy use of this stuff I would prefer the fd-based
> fsinfo() approach especially in the light of across namespace
> operations, querying all properties of a mount atomically all-at-once,
> and safe delegation through fds. Another heavy user of this would be
> systemd (Cced Lennart who I've discussed this with) which would prefer
> the fd-based approach as well. I think pulling this into a filesystem
> and making userspace parse around in a filesystem tree to query mount
> information is the wrong approach and will get messy pretty quickly
> especially in the face of mount and user namespace interactions and
> various other pitfalls. fsinfo() fits quite nicely with the all-fd-based
> approach of the whole mount api. So yes, definitely preferred from my
> end.

Christian is right. I think it's very important to have an API that
allows to query the state of fs attributes in a consistent state,
i.e. so that the attributes userspace is interested in can be queried
in a single call, so they all describe the very same point in
time. Distributing attributes onto multiple individual files just
sucks, because it's then guaranteed that you never can read them in a
way they actually fit together, some attributes you read will be
older, others newer. It's a big design flaw of sysfs (which is
structured like this) if you ask me.

I don't really care if the kernel API for this is binary or
textual. Slight preference for binary, but I don't care too much.

I think it would be wise to bind such APIs to fds, simply because it
always works. Doing path based stuff sucks, because you always need to
mount stuff and have a path tree set up, which is less ideal in a
world where namespacing is common, and namespaces are a shared concept
(at least with your other threads, if not with other processes). As a
maintainer of an init system I really dislike APIs that I can only use
after a mount structure has been set up, too often we want to do stuff
before that. Moreover, philosophically I find it questionnable to use
path based APIs to interface with the path object hierarchy itself. it
feels "too recursive". Just keep this separate: build stuff on top of
the fs that fits on top of the fs, but don't build fs APIs on top of
fs APIs that stem from the same layer.

Summary: atomic APIs rock, fd-based APIs rock. APIs built on
individual files one can only read individually suck. APIs of the path
layer exposed in the path layer suck.

Hope this makes some sense?

Lennart
