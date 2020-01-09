Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90904135A26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 14:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbgAINbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 08:31:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53936 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729114AbgAINbG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 08:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578576666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xhZuXS6DjAtohpYRcSN6Kdi6FwqV/yhcW8ynmM4QQiM=;
        b=i55h4EVmzoqmtnuvcnTd47GCvQDLrjAMgKkOBU6tjySkwD+PQasY+HUyO+JU5GW2XmKkMm
        CXzI2DUYd8MEQsh/JZ+/JL+miUNflT2eHaNyqVTGfVkNTAQ9E/tHaPwuU1GcnMA6JFGX8g
        BWMSxcLOXXELX0VUfoMR1f04rk9xupA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423--wXv5TMYNiiyb0xlx-UT4A-1; Thu, 09 Jan 2020 08:31:02 -0500
X-MC-Unique: -wXv5TMYNiiyb0xlx-UT4A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 296E0107ACC5;
        Thu,  9 Jan 2020 13:31:01 +0000 (UTC)
Received: from orion.redhat.com (ovpn-205-210.brq.redhat.com [10.40.205.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 180EF60C88;
        Thu,  9 Jan 2020 13:30:59 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, viro@zeniv.linux.org.uk
Subject: [PATCH 5/5] fibmap: Reject negative block numbers
Date:   Thu,  9 Jan 2020 14:30:45 +0100
Message-Id: <20200109133045.382356-6-cmaiolino@redhat.com>
In-Reply-To: <20200109133045.382356-1-cmaiolino@redhat.com>
References: <20200109133045.382356-1-cmaiolino@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FIBMAP receives an integer from userspace which is then implicitly conver=
ted
into sector_t to be passed to bmap(). No check is made to ensure userspac=
e
didn't send a negative block number, which can end up in an underflow, an=
d
returning to userspace a corrupted block address.

As a side-effect, the underflow caused by a negative block here, will
trigger the WARN() in iomap_bmap_actor(), which is how this issue was
first discovered.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 0ed5fb2d6c19..72d6848fb6ad 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -65,6 +65,9 @@ static int ioctl_fibmap(struct file *filp, int __user *=
p)
 	if (error)
 		return error;
=20
+	if (ur_block < 0)
+		return -EINVAL;
+
 	block =3D ur_block;
 	error =3D bmap(inode, &block);
=20
--=20
2.23.0

