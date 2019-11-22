Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7946C10685F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 09:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfKVIxi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 03:53:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53612 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbfKVIxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574412818;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jomAf0sKpYiRNsqTHSXc25VxWVvRPae0bV8Ihapht5Y=;
        b=WTIpiIubLh+XJpDBaadV1Etwq9GlYo3W2vxrTz6cPHIqbUedVvAr6IT29ELfIES5R/isOQ
        05mwlWiCBqfaP2p3HcgBvnWkn0uR6FY2aGFCz9vJehYUh/JxrVf7mu3CvXT1Ae9HMnogwQ
        5O5zgNd8Akqh7jaqF7ypqz63NWvafbM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-HHl1ELG7MlO3qoAOZt55rQ-1; Fri, 22 Nov 2019 03:53:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AB7B107ACC9;
        Fri, 22 Nov 2019 08:53:33 +0000 (UTC)
Received: from orion.redhat.com (unknown [10.40.205.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0162691A4;
        Fri, 22 Nov 2019 08:53:31 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, darrick.wong@oracle.com, sandeen@sandeen.net
Subject: [PATCH 5/5] fibmap: Reject negative block numbers
Date:   Fri, 22 Nov 2019 09:53:20 +0100
Message-Id: <20191122085320.124560-6-cmaiolino@redhat.com>
In-Reply-To: <20191122085320.124560-1-cmaiolino@redhat.com>
References: <20191122085320.124560-1-cmaiolino@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: HHl1ELG7MlO3qoAOZt55rQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FIBMAP receives an integer from userspace which is then implicitly converte=
d
into sector_t to be passed to bmap(). No check is made to ensure userspace
didn't send a negative block number, which can end up in an underflow, and
returning to userspace a corrupted block address.

As a side-effect, the underflow caused by a negative block here, will
trigger the WARN() in iomap_bmap_actor(), which is how this issue was
first discovered.

This is essentially a V2 of a patch I sent a while ago, reworded and
refactored to fit into this patchset.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 6b589c873bc2..6b365b3eff70 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -64,6 +64,9 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
 =09if (error)
 =09=09return error;
=20
+=09if (ur_block < 0)
+=09=09return -EINVAL;
+
 =09block =3D ur_block;
 =09error =3D bmap(inode, &block);
=20
--=20
2.23.0

