Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC4842DA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2019 19:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfFLRl3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jun 2019 13:41:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfFLRl3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:41:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1899231628E2;
        Wed, 12 Jun 2019 17:41:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-109.rdu2.redhat.com [10.10.120.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 058825D9CA;
        Wed, 12 Jun 2019 17:41:18 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <9c41cd56-af21-f17d-ab54-66615802f30e@schaufler-ca.com>
References: <9c41cd56-af21-f17d-ab54-66615802f30e@schaufler-ca.com> <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk> <31009.1560262869@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     dhowells@redhat.com, Stephen Smalley <sds@tycho.nsa.gov>,
        Andy Lutomirski <luto@kernel.org>, viro@zeniv.linux.org.uk,
        linux-usb@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: What do LSMs *actually* need for checks on notifications?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14575.1560361278.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: 8BIT
Date:   Wed, 12 Jun 2019 18:41:18 +0100
Message-ID: <14576.1560361278@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 12 Jun 2019 17:41:28 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Casey Schaufler <casey@schaufler-ca.com> wrote:

> >  (4) The security attributes of the object on which the watch was set (uid,
> >      gid, mode, labels).
> 
> Smack needs this to set a watch on the named object (file, key, ...).
> I am going to say that if you can't access an object you can't watch it.

So for the things I've so far defined:

 (*) Keys/keyrings require View permission, but it could be Read permission
     instead - though that may get disabled if the key type does not support
     KEYCTL_READ.

 (*) Mount/superblock watches - I've made these require execute permission on
     the specified directory.  Could be read permission instead.

 (*) Device events (block/usb) don't require any permissions, but currently
     only deliver hardware notifications.

> I think that read access is sufficient provided that no one else can
> see what watches I've created.

You can't find out what watches exist.

> > At the moment, when post_one_notification() wants to write a notification
> > into a queue, it calls security_post_notification() to ask if it should be
> > allowed to do so.  This is passed (1) and (3) above plus the notification
> > record.
> 
> Is "current" (2)? Smack needs (2) for the event delivery access check.

(2) was current_cred() when watch_sb(), KEYCTL_NOTIFY, etc. was called, but
isn't necessarily current_cred() at the point post_one_notification() is
called.  The latter is called at the point the event is generated and
current_cred() is the creds of whatever thread that is called in (which may be
a work_queue thread if it got deferred).

At the moment, I'm storing the creds of whoever opened the queue (ie. (1)) and
using that, but I could cache the creds of whoever created each watch
(ie. (2)) and pass that to post_one_notification() instead.

However, it should be noted that (1) is the creds of the buffer owner.

> >  (e) All the points at which we walk over an object in a chain from (c) to
> >      find the watch on which we can effect (d) (eg. we walk rootwards from a
> >      mountpoint to find watches on a branch in the mount topology).
> 
> Smack does not require anything beyond existing checks.

I'm glad to hear that, as this might be sufficiently impractical as to render
it unusable with Smack.  Calling i_op->permissions() a lot would suck.

> >  (y) What checks should be done on object destruction after final put and
> >      what contexts need to be supplied?
> 
> Classically there is no such thing as filesystem object deletion.
> By making it possible to set a watch on that you've inadvertently
> added a security relevant action to the security model. :o

That wasn't my original intention - I intended fsmount(2) to mount directly as
mount(2) does, but Al had other ideas.

Now fsmount(2) produces a file descriptor referring to a new mount object that
can be mounted into by move_mount(2) before being spliced into the mount
topology by move_mount(2).  However, if the fd is closed before the last step,
close() will destroy the mount subtree attached to it (kind of quasi-unmount).

That wouldn't be a problem, except that the fd from fsmount(2) can be used
anywhere an O_PATH fd can be used - including watch_mount(2), fchdir(2), ...
Further, FMODE_NEED_UNMOUNT gets cleared if the mount is spliced in at least
once.

Okay, having tried it you don't get an unmount event (since there's no actual
unmount), but you do get an event to say that your watch got deleted (if the
directory on which the watch was placed got removed from the system).

So...  does the "your watch got deleted" message need checking?  In my
opinion, it shouldn't get discarded because then the watcher doesn't know
their watch went away.

David
