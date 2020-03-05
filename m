Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D935A17A59C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 13:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgCEMsD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 07:48:03 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23578 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726036AbgCEMsD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:48:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583412481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZdVUZwTk1xr90gh/X9i80k8e/k13GnLzcjieuXwWAY=;
        b=gB0WoMMM/zfN4fVXWMk/3kCv5WN+0ZXsdoUnsiojRTYMZgrfDo7l9BkGkOYQtkyY//OI9c
        cTIs+I7m+hrKI/ry3QZoYZLJhqZCZi+nYqzhBVMQRfYT67xnML0x5bmolfvYtMCqbBDJOX
        /4bCIqmNkRgR8qh7Wd8pKig1B9uVQUM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-5pkyRX6kN12xGnP82OND4g-1; Thu, 05 Mar 2020 07:48:00 -0500
X-MC-Unique: 5pkyRX6kN12xGnP82OND4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23285107ACCA;
        Thu,  5 Mar 2020 12:47:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18B855D9C9;
        Thu,  5 Mar 2020 12:47:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200304192816.GI2935@paulmck-ThinkPad-P72>
References: <20200304192816.GI2935@paulmck-ThinkPad-P72> <3173159.1583343916@warthog.procyon.org.uk>
To:     paulmck@kernel.org
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        mszeredi@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: How to abuse RCU to scan the children of a mount?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3512174.1583412477.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Thu, 05 Mar 2020 12:47:57 +0000
Message-ID: <3512175.1583412477@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Paul E. McKenney <paulmck@kernel.org> wrote:

> o	The __attach_mnt() function adds a struct mount to its parent
> 	list, but in a non-RCU manner.	Unless there is some other
> 	safeguard, the list_add_tail() in this function needs to be
> 	list_add_tail_rcu().

Yeah.  I think the first time it appears on mnt_mounts so that we can see =
it
would have to be protected with an smp_store_release() barrier
(list_add_tail_rcu()), but thereafter it should be fine.  Freeing is stave=
d
off by holding the RCU read lock.

The fields that I'm interested in retrieving are all immutable IDs or atom=
ic
event counters.  That said, I do need to follow the mnt_sb pointer to the
superblock to retrieve more event counters, but mnt_sb is immutable also.

It might be possible to mirror the sb event counters into every mountpoint
that points to it, but that would mean that the sb event generator would h=
ave
to traverse that list - requiring appropriate locking there.

> 	So, do you need to add a check for child->mnt_child being in this
> 	self-referential state within fsinfo_generic_mount_children()?

I think what I would need is a counter on the specified mount that gets
incremented every time its child list gets rearranged in some way.  The
->mnt_topology_changes counter that I added would suffice for this, though=
 it
also notes if the specified mount itself got moved.

I would then need to note the counter value before the loop and abort the =
RCU
traversal if it changes during any iteration and switch to a locked traver=
al.

> 	Plus list_del_init() doesn't mark its stores, though
> 	some would argue that unmarked stores are OK in this situation.

That should be okay.  The next pointer still points *somewhere* valid.

> > 	m =3D real_mount(path->mnt);
> =

> What keeps the thing referenced by "m" from going away?  Presumably the
> caller has nailed it down somehow, but I have to ask...

That's just a container_of() wrapper.  path->mnt has to be pinned by the
caller.

> > 	rcu_read_lock();
> > 	do {
> > 		ctx->usage =3D 0;
> > 		read_seqbegin_or_lock(&mount_lock, &seq);
> =

> Aside: If there was an updater holding the lock along with a flood of
> readers, everyone would hereafter acquire the lock.  Or am I missing
> a trick here?  (I would have expected it to try a few times, and only
> then acquire the lock.  Yeah, I know, more state would be required.)

I think it would probably be more work than it's worth to do the extra
repetitions.

So how about the attached?  I've also made sure that all the calls to
notify_mount() (which updated the topology counter) are after the events
they're reporting on and I've made __attach_mnt() use list_add_tail_rcu() =
-
though there's a barrier in the preceding line that affects mnt_mountpoint=
.

Anyway, this is mostly theoretical.  I think Al would rather I just used a
lock.

David
---

/*
 * Store a mount record into the fsinfo buffer.
 */
static void fsinfo_store_mount(struct fsinfo_context *ctx, const struct mo=
unt *p,
			       unsigned int mnt_topology_changes)
{
	struct fsinfo_mount_child record =3D {};
	unsigned int usage =3D ctx->usage;

	if (ctx->usage >=3D INT_MAX)
		return;
	ctx->usage =3D usage + sizeof(record);

	if (ctx->buffer && ctx->usage <=3D ctx->buf_size) {
		record.mnt_unique_id	=3D p->mnt_unique_id;
		record.mnt_id		=3D p->mnt_id;
		record.notify_sum	=3D 0;
#ifdef CONFIG_SB_NOTIFICATIONS
		record.notify_sum +=3D
			atomic_read(&p->mnt.mnt_sb->s_change_counter) +
			atomic_read(&p->mnt.mnt_sb->s_notify_counter);
#endif
#ifdef CONFIG_MOUNT_NOTIFICATIONS
		record.notify_sum +=3D
			atomic_read(&p->mnt_attr_changes) +
			mnt_topology_changes +
			atomic_read(&p->mnt_subtree_notifications);
#endif
		memcpy(ctx->buffer + usage, &record, sizeof(record));
	}
}

/*
 * Return information about the submounts relative to path.
 */
int fsinfo_generic_mount_children(struct path *path, struct fsinfo_context=
 *ctx)
{
	struct mount *m, *child;
	bool rcu_mode =3D true, changed;
	int topology_check;

	m =3D real_mount(path->mnt);

	rcu_read_lock();

retry:
	topology_check =3D atomic_read(&m->mnt_topology_changes);

	ctx->usage =3D 0;
	list_for_each_entry_rcu(child, &m->mnt_mounts, mnt_child) {
		if (atomic_read(&m->mnt_topology_changes) !=3D topology_check)
			break;
		if (child->mnt_parent !=3D m)
			continue;
		fsinfo_store_mount(ctx, child,
				   atomic_read(&child->mnt_topology_changes));
	}

	changed =3D (atomic_read(&m->mnt_topology_changes) !=3D topology_check);
	if (rcu_mode) {
		rcu_read_unlock();
		if (changed) {
			rcu_mode =3D false;
			read_seqlock_excl(&mount_lock);
			goto retry;
		}
	} else {
		read_sequnlock_excl(&mount_lock);
		if (changed) {
			read_sequnlock_excl(&mount_lock);
			pr_err("Topology changed whilst lock held!\n");
			return -EAGAIN;
		}
	}

	/* End the list with a copy of the parameter mount's details so that
	 * userspace can quickly check for changes.  Note that we include the
	 * topology counter we got at the start of the function rather than the
	 * current value.
	 */
	fsinfo_store_mount(ctx, m, topology_check);
	return ctx->usage;
}

