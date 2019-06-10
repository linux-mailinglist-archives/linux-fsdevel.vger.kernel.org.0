Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7BA3BF2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 00:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfFJWIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jun 2019 18:08:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728674AbfFJWIC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jun 2019 18:08:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7E933082E20;
        Mon, 10 Jun 2019 22:07:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-126.rdu2.redhat.com [10.10.120.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49AEA19C59;
        Mon, 10 Jun 2019 22:07:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <25d88489-9850-f092-205e-0a4fc292f41b@schaufler-ca.com>
References: <25d88489-9850-f092-205e-0a4fc292f41b@schaufler-ca.com> <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk> <be966d9c-e38d-7a30-8d80-fad5f25ab230@tycho.nsa.gov> <0cf7a49d-85f6-fba9-62ec-a378e0b76adf@schaufler-ca.com> <CALCETrX5O18q2=dUeC=hEtK2=t5KQpGBy9XveHxFw36OqkbNOg@mail.gmail.com> <dac74580-5b48-86e4-8222-cac29a9f541d@schaufler-ca.com> <E0925E1F-E5F2-4457-8704-47B6E64FE3F3@amacapital.net> <4b7d02b2-2434-8a7c-66cc-7dbebc37efbc@schaufler-ca.com> <CALCETrU+PKVbrKQJoXj9x_5y+vTZENMczHqyM_Xb85ca5YDZuA@mail.gmail.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, Andy Lutomirski <luto@kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Al Viro <viro@zeniv.linux.org.uk>,
        USB list <linux-usb@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        raven@themaw.net, Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Subject: Re: [RFC][PATCH 00/13] Mount, FS, Block and Keyrings notifications [ver #4]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <29009.1560204466.1@warthog.procyon.org.uk>
Date:   Mon, 10 Jun 2019 23:07:46 +0100
Message-ID: <29010.1560204466@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 10 Jun 2019 22:08:02 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> Process A and process B both open /dev/null.
> A and B can write and read to their hearts content
> to/from /dev/null without ever once communicating.
> The mutual accessibility of /dev/null in no way implies that
> A and B can communicate. If A can set a watch on /dev/null,
> and B triggers an event, there still has to be an access
> check on the delivery of the event because delivering an event
> to A is not an action on /dev/null, but on A.

If a process has the privilege, it appears that fanotify() allows that process
to see others accessing /dev/null (FAN_ACCESS, FAN_ACCESS_PERM).  There don't
seem to be any LSM checks there either.

On the other hand, the privilege required is CAP_SYS_ADMIN,

> > The mount tree can't be modified by unprivileged users, unless a
> > privileged user very carefully configured it as such.
> 
> "Unless" means *is* possible. In which case access control is
> required. I will admit to being less then expert on the extent
> to which mounts can be done without privilege.

Automounts in network filesystems, for example.

The initial mount of the network filesystem requires local privilege, but then
mountpoints are managed with remote privilege as granted by things like
kerberos tickets.  The local kernel has no control.

If you have CONFIG_AFS_FS enabled in your kernel, for example, and you install
the keyutils package (dnf, rpm, apt, etc.), then you should be able to do:

	mount -t afs none /mnt -o dyn
	ls /afs/grand.central.org/software/

for example.  That will go through a couple of automount points.  Assuming you
don't have a kerberos login on those servers, however, you shouldn't be able
to add new mountpoints.

Someone watching the mount topology can see events when an automount is
enacted and when it expires, the latter being an event with the system as the
subject since the expiry is done on a timeout set by the kernel.

David
