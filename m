Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371F523CD1F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 19:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgHERUt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 13:20:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38988 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728495AbgHERSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7dizVWiIXd9zC97fZn3S5tjxTFtcwUz/YOaFNcDsaNo=;
        b=dGp6JrlikQJ5bObcSBC86bFo7WkJigMXS7eqhbPkazSDNkb/JtvOwbQEUTNUjg8Z42zDCJ
        q1Xk89ngC6ILBr7KPPvus+SCDqV4rqFrRfCsZN7GTLh/VH0ZDuHSkeTAUTqW8TEA2aAPcb
        DcKIPMeNqar8tC2O7s47jqv92nLPvt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-iDJLuTjkO4KTzKuCgAPGSg-1; Wed, 05 Aug 2020 09:59:47 -0400
X-MC-Unique: iDJLuTjkO4KTzKuCgAPGSg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 819D718C63C0;
        Wed,  5 Aug 2020 13:59:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-32.rdu2.redhat.com [10.10.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E9CD1002382;
        Wed,  5 Aug 2020 13:59:45 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <cb34df80-d6af-507d-9935-1685b787f7a3@infradead.org>
References: <cb34df80-d6af-507d-9935-1685b787f7a3@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     dhowells@redhat.com,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH -next] fs: mount_notify.c: fix build without CONFIG_FSINFO
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2303938.1596635984.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 05 Aug 2020 14:59:44 +0100
Message-ID: <2303939.1596635984@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Randy,

> From: Randy Dunlap <rdunlap@infradead.org>
> =

> Fix mount_notify.c build errors when CONFIG_FSINFO is not set/enabled:
> =

> ../fs/mount_notify.c:94:28: error: 'struct mount' has no member named 'm=
nt_unique_id'; did you mean 'mnt_group_id'?
> ../fs/mount_notify.c:109:28: error: 'struct mount' has no member named '=
mnt_unique_id'; did you mean 'mnt_group_id'?
> =

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org

That's not quite the right solution.  I'm going to use the attached instea=
d.

David
---
commit 830d864747b00d979914f15adaad58ccb9fd77f6
Author: Randy Dunlap <rdunlap@infradead.org>
Date:   Wed Aug 5 06:11:32 2020 -0700

    fs: mount_notify.c: fix build without CONFIG_FSINFO
    =

    Fix mount_notify.c build errors when CONFIG_FSINFO is not set/enabled:
    =

    ../fs/mount_notify.c:94:28: error: 'struct mount' has no member named =
'mnt_unique_id'; did you mean 'mnt_group_id'?
    ../fs/mount_notify.c:109:28: error: 'struct mount' has no member named=
 'mnt_unique_id'; did you mean 'mnt_group_id'?
    =

    [DH: Fix this to use mnt_id if CONFIG_FSINFO=3Dn rather than not setti=
ng
    anything]
    =

    Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
    Cc: David Howells <dhowells@redhat.com>
    Cc: Alexander Viro <viro@zeniv.linux.org.uk>
    Cc: linux-fsdevel@vger.kernel.org
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/fs/mount_notify.c b/fs/mount_notify.c
index 57995c27ca88..254090b6d5ac 100644
--- a/fs/mount_notify.c
+++ b/fs/mount_notify.c
@@ -91,7 +91,11 @@ void notify_mount(struct mount *trigger,
 	n.watch.type	=3D WATCH_TYPE_MOUNT_NOTIFY;
 	n.watch.subtype	=3D subtype;
 	n.watch.info	=3D info_flags | watch_sizeof(n);
+#ifdef CONFIG_FSINFO
 	n.triggered_on	=3D trigger->mnt_unique_id;
+#else
+	n.triggered_on	=3D trigger->mnt_id;
+#endif
 =

 	smp_wmb(); /* See fsinfo_generic_mount_info(). */
 =

@@ -106,7 +110,11 @@ void notify_mount(struct mount *trigger,
 	case NOTIFY_MOUNT_UNMOUNT:
 	case NOTIFY_MOUNT_MOVE_FROM:
 	case NOTIFY_MOUNT_MOVE_TO:
+#ifdef CONFIG_FSINFO
 		n.auxiliary_mount =3D aux->mnt_unique_id;
+#else
+		n.auxiliary_mount =3D aux->mnt_id;
+#endif
 		atomic_long_inc(&trigger->mnt_topology_changes);
 		atomic_long_inc(&aux->mnt_topology_changes);
 		break;

