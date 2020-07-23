Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC0D22ACF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jul 2020 12:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgGWKtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jul 2020 06:49:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34466 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728254AbgGWKs6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595501336;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/t4+iUKpLzt+aOvBJmMOBKta6U+hH+7Er68Z96/hv80=;
        b=LscCrl0w/cS4kPd+KOeKT2PUVGtjUgPYmNatdXtimWL7YS7+bVk+61kwAOqyOvt1t1nuYT
        FPt4pjpYrzV31eKekzb7GKYSIjU4esNM6OKH+c5RkYdlWMN8by8dnrqVyy2fFDc7TDfOry
        KHvwCF/eLssyBJypeSwuPT2jeVEoBLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-_QffQg5NNOqTdslTZy_C3g-1; Thu, 23 Jul 2020 06:48:52 -0400
X-MC-Unique: _QffQg5NNOqTdslTZy_C3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BE0B57;
        Thu, 23 Jul 2020 10:48:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5A8269320;
        Thu, 23 Jul 2020 10:48:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
In-Reply-To: <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
References: <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com> <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk> <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute change notifications [ver #5]
From:   David Howells <dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1293240.1595501326.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 23 Jul 2020 11:48:46 +0100
Message-ID: <1293241.1595501326@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> On Wed, Mar 18, 2020 at 4:05 PM David Howells <dhowells@redhat.com> wrot=
e:
> >
> > Add a mount notification facility whereby notifications about changes =
in
> > mount topology and configuration can be received.  Note that this only
> > covers vfsmount topology changes and not superblock events.  A separat=
e
> > facility will be added for that.
> >
> > Every mount is given a change counter than counts the number of topolo=
gical
> > rearrangements in which it is involved and the number of attribute cha=
nges
> > it undergoes.  This allows notification loss to be dealt with.
> =

> Isn't queue overrun signalled anyway?
> =

> If an event is lost, there's no way to know which object was affected,
> so how does the counter help here?

An event may up the counter multiple times.  For example, imagine that you
do the following:

	mkdir /foo
	mount -t tmpfs none /foo
	mkdir /foo/b
	chroot /foo/b
	watch_mount("/")

now someone else comes along and does:

	mkdir /foo/a
	mkdir /foo/b/c
	mount -t tmpfs none /foo/a
	mount -o move /foo/a /foo/b/c

thereby moving a mount from outside your chroot window to inside of it.  T=
he
move will generate two events (move-from and move-to), but you'll only get=
 to
see one of them.  The usage on the mount at /foo, however, will be bumped =
by
2, not 1.

Also, if someone instead does this:

	mkdir /foo/a/d
	mkdir /foo/a/e
	mount -t tmpfs none /foo/a/d
	mount -o move /foo/a/e /foo/a/e

you won't get any notifications, but the counter still got bumped by 2.
You'll see an unusual bump in it at the next event, but you know you didn'=
t
miss any events that pertain to you and can keep your copy of the counter =
up
to date... provided there hasn't been an overrun.

If there has been an overrun, you ask fsinfo() for a list of
{mount_id,counter} and then you have to scan anything where the counter ha=
s
changed unexpectedly.  It gives you the chance to keep up to date more
readily.

Maybe putting the counter into the notification message isn't really
necessary, but it's cheap to do if the counter is available.

> >  Later
> > patches will provide a way to quickly retrieve this value, along with
> > information about topology and parameters for the superblock.
> =

> So?  If we receive a notification for MNT1 with change counter CTR1
> and then receive the info for MNT1 with CTR2, then we know that we
> either missed a notification or we raced and will receive the
> notification later.  This helps with not having to redo the query when
> we receive the notification with CTR2, but this is just an
> optimization, not really useful.

Are optimisations ever useful?

> > In this case, it would let me monitor the mount topology subtree roote=
d at
> > "/" for events.  Mount notifications propagate up the tree towards the
> > root, so a watch will catch all of the events happening in the subtree
> > rooted at the watch.
> =

> Does it make sense to watch a single mount?  A set of mounts?   A
> subtree with an exclusion list (subtrees, types, ???)?
> =

> Not asking for these to be implemented initially, just questioning
> whether the API is flexible enough to allow these cases to be
> implemented later if needed.

You can watch a single mount or a whole subtree.  I could make it possible=
 to
add exclusions into the filter list.

> >
> > After setting the watch, records will be placed into the queue when, f=
or
> > example, as superblock switches between read-write and read-only.  Rec=
ords
> > are of the following format:
> >
> >         struct mount_notification {
> >                 struct watch_notification watch;
> >                 __u32   triggered_on;
> >                 __u32   auxiliary_mount;
> =

> What guarantees that mount_id is going to remain a 32bit entity?

You think it likely we'd have >4 billion concurrent mounts on a system?  T=
hat
would require >1.2TiB of RAM just for the struct mount allocations.

But I can expand it to __u64.

> >                 __u32   topology_changes;
> >                 __u32   attr_changes;
> >                 __u32   aux_topology_changes;
> =

> Being 32bit this introduces wraparound effects.  Is that really worth it=
?

You'd have to make 2 billion changes without whoever's monitoring getting =
a
chance to update their counters.  But maybe it's not worth it putting them
here.  If you'd prefer, I can make the counters all 64-bit and just retrie=
ve
them with fsinfo().

> >         } *n;
> >
> > Where:
> >
> >         n->watch.type will be WATCH_TYPE_MOUNT_NOTIFY.
> >
> >         n->watch.subtype will indicate the type of event, such as
> >         NOTIFY_MOUNT_NEW_MOUNT.
> >
> >         n->watch.info & WATCH_INFO_LENGTH will indicate the length of =
the
> >         record.
> =

> Hmm, size of record limited to 112bytes?  Is this verified somewhere?
> Don't see a BUILD_BUG_ON() in watch_sizeof().

127 bytes now, including the header.  I can add a BUILD_BUG_ON().

> >         n->watch.info & NOTIFY_MOUNT_IS_RECURSIVE if true indicates th=
at
> >         the notifcation was generated by an event (eg. SETATTR) that w=
as
> >         applied recursively.  The notification is only generated for t=
he
> >         object that initially triggered it.
> =

> Unused in this patchset.  Please don't add things to the API which are n=
ot
> used.

Christian Brauner has patches for mount_setattr() that will need to use th=
is.

> >         n->watch.info & NOTIFY_MOUNT_IS_NOW_RO will be used for
> >         NOTIFY_MOUNT_READONLY, being set if the superblock becomes R/O=
, and
> >         being cleared otherwise,
> =

> Does this refer to mount r/o flag or superblock r/o flag?  Confused.

Sorry, that should be "mount".

> > and for NOTIFY_MOUNT_NEW_MOUNT, being set
> >         if the new mount is a submount (e.g. an automount).
> =

> Huh?  What has r/o flag do with being a submount?

That should read "if the new mount is readonly".

> >         n->watch.info & NOTIFY_MOUNT_IS_SUBMOUNT if true indicates tha=
t the
> >         NOTIFY_MOUNT_NEW_MOUNT notification is in response to a mount
> >         performed by the kernel (e.g. an automount).
> >
> >         n->triggered_on indicates the ID of the mount to which the cha=
nge
> >         was accounted (e.g. the new parent of a new mount).
> =

> For move there are two parents that are affected.  This doesn't look
> sufficient to reflect that.

You get up to two messages in that case:

	NOTIFY_MOUNT_MOVE_FROM	=3D 5, /* Mount moved from here */
	NOTIFY_MOUNT_MOVE_TO	=3D 6, /* Mount moved to here (compare op_id) */

but either message may get filtered because the event occurred outside of =
your
watched tree.

David

