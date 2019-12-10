Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D489118BED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 16:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbfLJPEJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 10:04:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26295 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727568AbfLJPEJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 10:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575990248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UYDIFuf79LZKoQTDE7/OB7qjCzWxPWfUHp/0RHRZbHo=;
        b=eHatNd3lIrcLdxddXP5t3BXZgCke2HcK285WDLV5CdqV6Rr2V9lFDNhhEYSp5eyu+v/0Hq
        hrIZkDdxiLnO1iyTa7BW78qpcmYYAjRhIdx6HrEo2wnZnIjZFgb5/VmdqW78pBqIfHIjJT
        ZOrrzg2BvxOBnf2ZWczgcedAyGL5bz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-RSvMkESDOQ6ZTh2xVWizog-1; Tue, 10 Dec 2019 10:04:07 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 808DE802CAF;
        Tue, 10 Dec 2019 15:04:06 +0000 (UTC)
Received: from orion.redhat.com (ovpn-205-230.brq.redhat.com [10.40.205.230])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A52241001925;
        Tue, 10 Dec 2019 15:04:05 +0000 (UTC)
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de
Subject: [PATCH 5/5] fibmap: Reject negative block numbers
Date:   Tue, 10 Dec 2019 16:03:44 +0100
Message-Id: <20191210150344.112181-6-cmaiolino@redhat.com>
In-Reply-To: <20191210150344.112181-1-cmaiolino@redhat.com>
References: <20191210150344.112181-1-cmaiolino@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: RSvMkESDOQ6ZTh2xVWizog-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 83f36feaf781..79468b5a6391 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -65,6 +65,9 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
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

