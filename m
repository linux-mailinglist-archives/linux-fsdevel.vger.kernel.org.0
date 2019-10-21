Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9E0DF78A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2019 23:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfJUVls (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Oct 2019 17:41:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52937 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728943AbfJUVlr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Oct 2019 17:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571694106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=IWeM12SnjaxnROOhjKG0uzMoH/1pwew4flz84hu3l0k=;
        b=EA8vKtU8iQd2X3J6MWu7z3azMx0YgPt7zpBAms3aKTuzXSvMutK5X7fjnJkQGkeivXxoj9
        7qCVfB5vLcvURXKOdKaH0RyvV9DvFKYZQIoUh22j9vXdGdcyUtR+V3L9vIxRNJrJ8tFKpp
        RCodsuiGw5rdWeFvmd0rOBGmhmR1UsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-WEhns1CVOLONzpz_CDZEpg-1; Mon, 21 Oct 2019 17:41:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B3CF2B6;
        Mon, 21 Oct 2019 21:41:40 +0000 (UTC)
Received: from rh2.redhat.com (ovpn-123-171.rdu2.redhat.com [10.10.123.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2A8560126;
        Mon, 21 Oct 2019 21:41:38 +0000 (UTC)
From:   Mike Christie <mchristi@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, martin@urbackup.org,
        Damien.LeMoal@wdc.com
Cc:     Mike Christie <mchristi@redhat.com>
Subject: [PATCH] Add prctl support for controlling PF_MEMALLOC V2
Date:   Mon, 21 Oct 2019 16:41:37 -0500
Message-Id: <20191021214137.8172-1-mchristi@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: WEhns1CVOLONzpz_CDZEpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are several storage drivers like dm-multipath, iscsi, tcmu-runner,
amd nbd that have userspace components that can run in the IO path. For
example, iscsi and nbd's userspace deamons may need to recreate a socket
and/or send IO on it, and dm-multipath's daemon multipathd may need to
send IO to figure out the state of paths and re-set them up.

In the kernel these drivers have access to GFP_NOIO/GFP_NOFS and the
memalloc_*_save/restore functions to control the allocation behavior,
but for userspace we would end up hitting a allocation that ended up
writing data back to the same device we are trying to allocate for.

This patch allows the userspace deamon to set the PF_MEMALLOC* flags
with prctl during their initialization so later allocations cannot
calling back into them.

Signed-off-by: Mike Christie <mchristi@redhat.com>
---

V2:
- Use prctl instead of procfs.
- Add support for NOFS for fuse.
- Check permissions.

 include/uapi/linux/prctl.h |  8 +++++++
 kernel/sys.c               | 44 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 7da1b37b27aa..6f6b3af6633a 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -234,4 +234,12 @@ struct prctl_mm_map {
 #define PR_GET_TAGGED_ADDR_CTRL=09=0956
 # define PR_TAGGED_ADDR_ENABLE=09=09(1UL << 0)
=20
+/* Control reclaim behavior when allocating memory */
+#define PR_SET_MEMALLOC=09=09=0957
+#define PR_GET_MEMALLOC=09=09=0958
+#define PR_MEMALLOC_SET_NOIO=09=09(1UL << 0)
+#define PR_MEMALLOC_CLEAR_NOIO=09=09(1UL << 1)
+#define PR_MEMALLOC_SET_NOFS=09=09(1UL << 2)
+#define PR_MEMALLOC_CLEAR_NOFS=09=09(1UL << 3)
+
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index a611d1d58c7d..34fedc9fc7e4 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2486,6 +2486,50 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, a=
rg2, unsigned long, arg3,
 =09=09=09return -EINVAL;
 =09=09error =3D GET_TAGGED_ADDR_CTRL();
 =09=09break;
+=09case PR_SET_MEMALLOC:
+=09=09if (!capable(CAP_SYS_ADMIN))
+=09=09=09return -EPERM;
+
+=09=09if (arg3 || arg4 || arg5)
+=09=09=09return -EINVAL;
+
+=09=09switch (arg2) {
+=09=09case PR_MEMALLOC_SET_NOIO:
+=09=09=09if (current->flags & PF_MEMALLOC_NOFS)
+=09=09=09=09return -EINVAL;
+
+=09=09=09current->flags |=3D PF_MEMALLOC_NOIO;
+=09=09=09break;
+=09=09case PR_MEMALLOC_CLEAR_NOIO:
+=09=09=09current->flags &=3D ~PF_MEMALLOC_NOIO;
+=09=09=09break;
+=09=09case PR_MEMALLOC_SET_NOFS:
+=09=09=09if (current->flags & PF_MEMALLOC_NOIO)
+=09=09=09=09return -EINVAL;
+
+=09=09=09current->flags |=3D PF_MEMALLOC_NOFS;
+=09=09=09break;
+=09=09case PR_MEMALLOC_CLEAR_NOFS:
+=09=09=09current->flags &=3D ~PF_MEMALLOC_NOFS;
+=09=09=09break;
+=09=09default:
+=09=09=09return -EINVAL;
+=09=09}
+=09=09break;
+=09case PR_GET_MEMALLOC:
+=09=09if (!capable(CAP_SYS_ADMIN))
+=09=09=09return -EPERM;
+
+=09=09if (arg2 || arg3 || arg4 || arg5)
+=09=09=09return -EINVAL;
+
+=09=09if (current->flags & PF_MEMALLOC_NOIO)
+=09=09=09error =3D PR_MEMALLOC_SET_NOIO;
+=09=09else if (current->flags & PF_MEMALLOC_NOFS)
+=09=09=09error =3D PR_MEMALLOC_SET_NOFS;
+=09=09else
+=09=09=09error =3D 0;
+=09=09break;
 =09default:
 =09=09error =3D -EINVAL;
 =09=09break;
--=20
2.20.1

