Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA873CE92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388770AbfFKOVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 10:21:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbfFKOVT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:21:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1E922308218D;
        Tue, 11 Jun 2019 14:21:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-126.rdu2.redhat.com [10.10.120.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9956611AA;
        Tue, 11 Jun 2019 14:21:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Andy Lutomirski <luto@kernel.org>
Cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk,
        linux-usb@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: What do LSMs *actually* need for checks on notifications?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <31008.1560262869.1@warthog.procyon.org.uk>
Date:   Tue, 11 Jun 2019 15:21:09 +0100
Message-ID: <31009.1560262869@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 11 Jun 2019 14:21:19 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To see if we can try and make progress on this, can we try and come at this
from another angle: what do LSMs *actually* need to do this?  And I grant that
each LSM might require different things.

-~-

[A] There are a bunch of things available, some of which may be coincident,
depending on the context:

 (1) The creds of the process that created a watch_queue (ie. opened
     /dev/watch_queue).

 (2) The creds of the process that set a watch (ie. called watch_sb,
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


[B] There are a number of places I can usefully potentially add hooks:

 (a) The point at which a watch queue is created (ie. /dev/watch_queue is
     opened).

 (b) The point at which a watch is set (ie. watch_sb).

 (c) The point at which a notification is generated (ie. an automount point is
     tripped).

 (d) The point at which a notification is delivered (ie. we write the message
     into the queue).

 (e) All the points at which we walk over an object in a chain from (c) to
     find the watch on which we can effect (d) (eg. we walk rootwards from a
     mountpoint to find watches on a branch in the mount topology).


[C] Problems that need to be resolved:

 (x) Do I need to put a security pointer in struct watch for the active LSM to
     fill in?  If so, I presume this would need passing to
     security_post_notification().

 (y) What checks should be done on object destruction after final put and what
     contexts need to be supplied?

     This one is made all the harder because the creds that are in force when
     close(), exit(), exec(), dup2(), etc. close a file descriptor might need
     to be propagated to deferred-fput, which must in turn propagate them to
     af_unix-cleanup, and thence back to deferred-fput and thence to implicit
     unmount (dissolve_on_fput()[*]).

     [*] Though it should be noted that if this happens, the subtree cannot be
     	 attached to the root of a namespace.

     Further, if several processes are sharing a file object, it's not
     predictable as to which process the final notification will come from.

 (z) Do intermediate objects, say in a mount topology notification, actually
     need to be checked against the watcher's creds?  For a mount topology
     notification, would this require calling inode_permission() for each
     intervening directory?

     Doing that might be impractical as it would probably have to be done
     outside of of the RCU read lock and the filesystem ->permission() hooks
     might want to sleep (to touch disk or talk to a server).

David
