Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C95C81796F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 18:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgCDRpY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 12:45:24 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24808 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728537AbgCDRpX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583343923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iaaiWLuaHN+kNtHS6G7Rs58xRGJK6gknbfLQodvsGQg=;
        b=JLH3IcGYEzrrmL7ZIIEhButlOIlabUWPcS2znoeS6CQFH8pza7UJQoMPp077ZjK3OUCqnC
        UxTe+HORHEeabKaU+kjahStRdlN29wB5IqVObdBQ7LICYvlOemHyDvGpwLCL+yyXbyfRjn
        C3SYtCHo1VvYb5tefc+ldUc03JzeZgU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-wWvtt4vfNTiLdsrL2Kj6bw-1; Wed, 04 Mar 2020 12:45:19 -0500
X-MC-Unique: wWvtt4vfNTiLdsrL2Kj6bw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38B6FDBA3;
        Wed,  4 Mar 2020 17:45:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FC2C27088;
        Wed,  4 Mar 2020 17:45:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        mszeredi@redhat.com, linux-fsdevel@vger.kernel.org
Subject: How to abuse RCU to scan the children of a mount?
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3173158.1583343916.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 04 Mar 2020 17:45:16 +0000
Message-ID: <3173159.1583343916@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Paul,

As part of trying to implement a filesystem information querying system ca=
ll,
I need to be able to return a list of child mounts of a mount.  Children,
however, may be moved with "mount --move", which means that the list can't=
 be
accessed with normal RCU practices.

For reference, I'm dealing with struct mount and mnt_mounts and mnt_child =
and
struct mount is released via call_rcu().

What does rcu_dereference() guarantee, exactly?  It's just that the next h=
op
is set up when you follow the pointer, right?

Can I do something like the attached?  The mount 'm' is pinned, but I need=
 to
trawl m->mnt_mounts.  mount_lock is a seqlock that ticks when mount topolo=
gy
is rearranged.  I *think* it covers ->mnt_mounts.  Whilst trawling in
non-locked mode, I keep an eye on the seq counter and if it changes, the l=
ist
may have been altered and I need to get the real lock and restart.

The objects shouldn't disappear or be destroyed, so I think I'm safe.

Thanks,
David
---

int fsinfo_generic_mount_children(struct path *path, struct fsinfo_context=
 *ctx)
{
	struct fsinfo_mount_child record =3D {};
	struct mount *m, *child;
	int seq =3D 0;

	m =3D real_mount(path->mnt);

	rcu_read_lock();
	do {
		ctx->usage =3D 0;
		read_seqbegin_or_lock(&mount_lock, &seq);
		list_for_each_entry_rcu(child, &m->mnt_mounts, mnt_child) {
			if (need_seqretry(&mount_lock, seq))
				break;
			if (child->mnt_parent !=3D m)
				continue;
			record.mnt_unique_id =3D child->mnt_unique_id;
			record.mnt_id =3D child->mnt_id;
			record.notify_sum =3D 0;
#ifdef CONFIG_SB_NOTIFICATIONS
			record.notify_sum +=3D
				atomic_read(&child->mnt.mnt_sb->s_change_counter) +
				atomic_read(&child->mnt.mnt_sb->s_notify_counter);
#endif
#ifdef CONFIG_MOUNT_NOTIFICATIONS
			record.notify_sum +=3D
				atomic_read(&child->mnt_attr_changes) +
				atomic_read(&child->mnt_topology_changes) +
				atomic_read(&child->mnt_subtree_notifications);
#endif
			store_mount_fsinfo(ctx, &record);
		}
	} while (need_seqretry(&mount_lock, seq));
	done_seqretry(&mount_lock, seq);

	rcu_read_unlock();

	/* End the list with a copy of the parameter mount's details so that
	 * userspace can quickly check for changes.
	 */
	record.mnt_unique_id =3D m->mnt_unique_id;
	record.mnt_id =3D m->mnt_id;
	record.notify_sum =3D 0;
#ifdef CONFIG_SB_NOTIFICATIONS
	record.notify_sum +=3D
		atomic_read(&m->mnt.mnt_sb->s_change_counter) +
		atomic_read(&m->mnt.mnt_sb->s_notify_counter);
#endif
#ifdef CONFIG_MOUNT_NOTIFICATIONS
	record.notify_sum +=3D
		atomic_read(&m->mnt_attr_changes) +
		atomic_read(&m->mnt_topology_changes) +
		atomic_read(&m->mnt_subtree_notifications);
#endif
	store_mount_fsinfo(ctx, &record);
	return ctx->usage;
}

