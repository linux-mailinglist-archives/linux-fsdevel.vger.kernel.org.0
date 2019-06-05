Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D0836642
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 23:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfFEVGT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Wed, 5 Jun 2019 17:06:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726528AbfFEVGS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 17:06:18 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 062F9C1EB1FB;
        Wed,  5 Jun 2019 21:06:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-173.rdu2.redhat.com [10.10.120.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D9356838D;
        Wed,  5 Jun 2019 21:06:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <f19dcdb4-f934-34c2-f625-95c2c928d576@schaufler-ca.com>
References: <f19dcdb4-f934-34c2-f625-95c2c928d576@schaufler-ca.com> <e4c19d1b-9827-5949-ecb8-6c3cb4648f58@schaufler-ca.com> <50c2ea19-6ae8-1f42-97ef-ba5c95e40475@schaufler-ca.com> <155966609977.17449.5624614375035334363.stgit@warthog.procyon.org.uk> <CALCETrWzDR=Ap8NQ5-YrVhXCEBgr+hwpjw9fBn0m2NkZzZ7XLQ@mail.gmail.com> <20192.1559724094@warthog.procyon.org.uk> <18357.1559753807@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Cc:     dhowells@redhat.com, Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, raven@themaw.net,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Rational model for UID based controls
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5392.1559768763.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 05 Jun 2019 22:06:03 +0100
Message-ID: <5393.1559768763@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 05 Jun 2019 21:06:18 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> Right. You're mixing the kind of things that can generate events,
> and that makes having a single policy difficult.

Whilst that's true, the notifications are clearly marked as to type, so it
should be possible to select different policies for different notification
types.

Question for you: what does the LSM *actually* need?  There are a bunch of
things available, some of which may be the same thing:

 (1) The creds of the process that created a watch_queue (ie. opened
     /dev/watch_queue).

 (2) The creds of the process that set a watch (ie. called sb_notify,
     KEYCTL_NOTIFY, ...);

 (3) The creds of the process that tripped the event (which might be the
     system).

 (4) The security attributes of the object on which the watch was set (uid,
     gid, mode, labels).

 (5) The security attributes of the object on which the event was tripped.

 (6) The security attributes of all the objects between the object in (5) and
     the object in (4), assuming we work from (5) towards (4) if the two
     aren't coincident (WATCH_INFO_RECURSIVE).

At the moment, when post_one_notification() wants to write a notification into
a queue, it calls security_post_notification() to ask if it should be allowed
to do so.  This is passed (1) and (3) above plus the notification record.

The only problem I really have is that for a destruction message you want to
get the creds of who did the last put on an object and caused it to be
destroyed - I think everything else probably gets the right creds, even if
they aren't even in the same namespaces (mount propagation, yuck).

However, that one is a biggie because close()/exit() must propagate it to
deferred-fput, which must propagate it to af_unix-cleanup, and thence back to
deferred-fput and thence to implicit unmount (dissolve_on_fput()[*]).

[*] Though it should be noted that if this happens, the subtree cannot be
    attached to the root of a namespace.

> > In any case, that's what I was referring to when I said I might need to call
> > inode_permission().  But UIDs don't exist for all filesystems, for example,
> > and there are no UIDs on superblocks, mount objects or hardware events.
> 
> If you open() or stat() a file on those filesystems the UID
> used in the access control comes from somewhere. Setting a watch
> on things with UIDs should use the access mode on the file,
> just like any other filesystem operation.

Another question for you: Do I need to let the LSM pass judgement on a watch
that a process is trying to set?  I think I probably do.  This would require
separate hooks for different object types:

	int security_watch_key(struct watch *watch, struct key *key);
	int security_watch_sb(struct watch *watch, struct path *path);
	int security_watch_mount(struct watch *watch, struct path *path);
	int security_watch_devices(struct watch *watch);

so that the LSM can see the object the watch is being placed on (the last has
a global queue, so there is no object).  

Further, do I need to put a "void *security" pointer in struct watch and
indicate to the LSM the object bring watched?  The watch could then be passed
to security_post_notification() instead of the watch queue creds (which I
could then dispense with).

	security_post_notification(const struct watch *watch,
				   const struct cred *trigger_cred,
				   struct watch_notification *n);


Also, should I let the LSM audit/edit the filter set by
IOC_WATCH_QUEUE_SET_FILTER?  Userspace can't retrieve the filter, so the LSM
could edit it to exclude certain things.  That might be a bit too complicated,
though.

> Things like superblocks are sticker because we don't generally
> think of them as objects. If you can do statfs(), you should be
> able to set a watch on the filesystem metadata.
> 
> How would you specify a watch for a hardware event? If you say
> you have to open /dev/mumble to sent a watch for mumbles, you're
> good there, too.

That's not how that works at the moment.  There's a global watch list for
device events.  I've repurposed it to carry any device's events - so it will
carry blockdev events (I/O errors only at the moment) and usb events
(add/remove device, add/remove bus, reset device at the moment).

> > Now, I could see that you ignore UIDs on things like keys and
> > hardware-triggered events, but how does this interact with things like mount
> > watches that see directories that have UIDs?
> >
> > Are you advocating making it such that process B can only see events
> > triggered by process A if they have the same UID, for example?
> 
> It's always seemed arbitrary to me that you can't open your process up to
> get signals from other users. What about putting mode bits on your ring
> buffer? By default you could only accept your own events, but you could do a
> rb_chmod(0222) and let all events through.

Ummm...  This mechanism is pretty much about events generated by others.
Depend on what you mean by 'you' and 'your own events', it might be considered
that you would know what events you were directly causing and wouldn't need a
notification system for it.

> Subject to LSM addition restrictions, of course. That would require the cred
> of the process that triggered the event or a system cred for "hardware"
> events.  If you don't like mode bits you could use an ACL for fine
> granularity or a single "let'em all in" bit for coarse.

I'm not entirely sure how an ACL would help.  If someone creates a watch
queue, sets an ACL with only a "let everything in" ACE, we're back to the
situation we're in now.

As I understand it, the issue you have is stopping them getting events that
they're willing to accept that you think they shouldn't be allowed.

> I'm not against access, I'm against uncontrolled access in conflict with
> basic system policy.

David
