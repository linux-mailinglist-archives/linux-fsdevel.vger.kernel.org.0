Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79036197DB3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Mar 2020 15:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgC3N6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 09:58:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40390 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbgC3N6g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585576714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=J/xbcR+U5sZqN3KnB8Gi4wExsJ+uq2zk4m3be9exSUA=;
        b=iVc4MwcZwWNx6f+CJ1u+vav1i9bN3rPdmbqSsYl6l/yYi4rmcBUumVOtNkSyj608j6eSZJ
        +iYls7iLXoqYV4fuIcjYwwlR1kEvJZVKc8cyhVaBzkAP6zIHhk8pxr2WkaRVwa85tnIuiO
        rlJdo17IGWgkLfs0aMxfhqwPcp4t7I4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-twlqjcaNOvCWPrwhwVyXtQ-1; Mon, 30 Mar 2020 09:58:27 -0400
X-MC-Unique: twlqjcaNOvCWPrwhwVyXtQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE8E2149CA;
        Mon, 30 Mar 2020 13:58:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-66.rdu2.redhat.com [10.10.112.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E104E5DA66;
        Mon, 30 Mar 2020 13:58:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
cc:     dhowells@redhat.com, viro@zeniv.linux.org.uk, dray@redhat.com,
        kzak@redhat.com, mszeredi@redhat.com, swhiteho@redhat.com,
        jlayton@redhat.com, raven@themaw.net, andres@anarazel.de,
        christian.brauner@ubuntu.com, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Upcoming: Notifications, FS notifications and fsinfo()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 30 Mar 2020 14:58:22 +0100
Message-ID: <1445647.1585576702@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Hi Linus,

I have three sets of patches I'd like to push your way, if you (and Al) are
willing to consider them.

 (1) General notification queue plus key/keyring notifications.

     This adds the core of the notification queue built on pipes, and adds
     the ability to watch for changes to keys.

 (2) Mount and superblock notifications.

     This builds on (1) to provide notifications of mount topology changes
     and implements a framework for superblock events (configuration
     changes, I/O errors, quota/space overruns and network status changes).

 (3) Filesystem information retrieval.

     This provides an extensible way to retrieve informational attributes
     about mount objects and filesystems.  This includes providing
     information intended to make recovering from a notification queue
     overrun much easier.

We need (1) for Gnome to efficiently watch for changes in kerberos
keyrings.  Debarshi Ray has patches ready to go for gnome-online-accounts
so that it can make use of the facility.

Sets (2) and (3) can make libmount more efficient.  Karel Zak is working on
making use of this to avoid reading /proc/mountinfo.

We need something to make systemd's watching of the mount topology more
efficient, and (2) and (3) can help with this by making it faster to narrow
down what changed.  I think Karel has this in his sights, but hasn't yet
managed to work on it.

Set (2) should be able to make it easier to watch for mount options inside
a container, and set (3) should make it easier to examine the mounts inside
another mount namespace inside a container in a way that can't be done with
/proc/mounts.  This is requested by Christian Brauner.

Jeff Layton has a tentative addition to (3) to expose error state to
userspace, and Andres Freund would like this for Postgres.

Set (3) further allows the information returned by such as statx() and
ioctl(FS_IOC_GETFLAGS) to be qualified by indicating which bits are/aren't
supported.

Further, for (3), I also allow filesystem-specific overrides/extensions to
fsinfo() and have a use for it to AFS to expose information about server
preference for a particular volume (something that is necessary for
implementing the toolset).  I've provided example code that does similar
for NFS and some that exposes superblock info from Ext4.  At Vault, Steve
expressed an interest in this for CIFS and Ted Ts'o expressed a possible
interest for Ext4.

Notes:

 (*) These patches will conflict with apparently upcoming refactoring of
     the security core, but the fixup doesn't look too bad:

	https://lore.kernel.org/linux-next/20200330130636.0846e394@canb.auug.org.a=
u/T/#u

 (*) Mikl=C3=B3s Szeredi would much prefer to implement fsinfo() as a magic
     filesystem mounted on /proc/self/fsinfo/ whereby your open fds appear
     as directories under there, each with a set of attribute files
     corresponding to the attributes that fsinfo() would otherwise provide.
     To examine something by filename, you'd have to open it O_PATH and
     then read the individual attribute files in the corresponding per-fd
     directory.  A readfile() system call has been mooted to elide the
     {open,read,close} sequence to make it more efficient.

 (*) James Bottomley would like to deprecate fsopen(), fspick(), fsconfig()
     and fsmount() in favour of a more generic configfs with dedicated
     open, set-config and action syscalls, with an additional get-config
     syscall that would be used instead of fsinfo() - though, as I
     understand it, you'd have to create a config (fspick-equivalent)
     before you could use get-config.

 (*) I don't think Al has particularly looked at fsinfo() or the fs
     notifications patches yet.

 (*) I'm not sure what *your* opinion of fsinfo() is yet.  If you don't
     dislike it too, um, fragrantly, would you be willing to entertain part
     of it for now and prefer the rest to stew a bit longer?  I can drop
     some of the pieces.

Anyway, I'm going to formulate a pull request for each of them.

Thanks,
David

