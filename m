Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1289213090D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 17:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgAEQXZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jan 2020 11:23:25 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49262 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgAEQXZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jan 2020 11:23:25 -0500
Received: from [172.58.27.182] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1io8gQ-0005Xy-HA; Sun, 05 Jan 2020 16:23:19 +0000
Date:   Sun, 5 Jan 2020 17:23:13 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2 0/6] introduce configfd as generalisation of fsconfig
Message-ID: <20200105162311.sufgft6kthetsz7q@wittgenstein>
References: <20200104201432.27320-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200104201432.27320-1-James.Bottomley@HansenPartnership.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 04, 2020 at 12:14:26PM -0800, James Bottomley wrote:
> fsconfig is a very powerful configuration mechanism except that it
> only works for filesystems with superblocks.  This patch series
> generalises the useful concept of a multiple step configurational
> mechanism carried by a file descriptor.  The object of this patch
> series is to get bind mounts to be configurable in the same way that
> superblock based ones are, but it should have utility beyond the
> filesytem realm.  Patch 4 also reimplements fsconfig in terms of
> configfd, but that's not a strictly necessary patch, it is merely a
> useful demonstration that configfd is a superset of the properties of
> fsconfig.

Thanks for the patch. I'm glad fsconfig() is picked back up; either by
you or by David. We will need this for sure.
But the configfd approach does not strike me as a great idea.
Anonymous inode fds provide an abstraction mechanism for kernel objects
which we built around fds such as timerfd, pidfd, mountfd and so on.
When you stat an anonfd you get ANON_INODE_FS_MAGIC and you get the
actual type by looking at fdinfo, or - more common - by parsing out
/proc/<pid>/fd/<nr> and discovering "[fscontext]". So it's already a
pretty massive abstraction layer we have. But configfd would be yet
another fd abstraction based on anonfds.
The idea has been that a new fd type based on anonfds comes with an api
specific to that type of fd. That seems way nicer from an api design
perspective than implementing new apis as part of yet another generic
configfd layer.

Another problem is that these syscalls here would be massive
multiplexing syscalls. If they are ever going to be used outside of
filesystem use-cases (which is doubtful) they will quickly rival
prctl(), seccomp(), and ptrace(). That's not a great thing. Especially,
since we recently (a few months ago with Linus chiming in too) had long
discussions with the conclusion that multiplexing syscalls are
discouraged, from a security and api design perspective. Especially when
they are not tied to a specific API (e.g. seccomp() and bpf() are at least
tied to a specific API). libcs such as glibc and musl had reservations
in that regard as well.

This would also spread the mount api across even more fd types than it
already does now which is cumbersome for userspace.

A generic API like that also makes it hard to do interception in
userspace which is important for brokers such as e.g. used in Firefox or
what we do in various container use-cases.

So I have strong reservations about configfd and would strongly favor
the revival of the original fsconfig() patchset.

Christian
