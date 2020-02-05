Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2F11538D8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 20:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgBETQI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 14:16:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49818 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727162AbgBETQI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580930167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=rb7G4sCm0/kOn0JB7aa17eiASsOgtyGCK66O/DqQUSQ=;
        b=cXYqTi8xr6mRrE+zpaSSaPiyrs2lapglMas2iFcC20rCv7sHdTfHU6FPIM5i+vsIcrUTZW
        RZ/I8JQYmI9kuJfrPkTtqTVaDrj1njvAAeB05safAG4yt0/nXUglCnciJViv/rfQSpvKRS
        eXCw8dIgWEDGUwyxDg7JuzuGtrMwP0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-uSI5rDvVMdOiUhM9pxX_ow-1; Wed, 05 Feb 2020 14:16:01 -0500
X-MC-Unique: uSI5rDvVMdOiUhM9pxX_ow-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A036DBB1;
        Wed,  5 Feb 2020 19:16:00 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F2D0101D4B7;
        Wed,  5 Feb 2020 19:15:59 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     dan.j.williams@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        willy@infradead.org, jack@suse.cz
Subject: [patch] dax: pass NOWAIT flag to iomap_apply
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Wed, 05 Feb 2020 14:15:58 -0500
Message-ID: <x49r1z86e1d.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fstests generic/471 reports a failure when run with MOUNT_OPTIONS="-o
dax".  The reason is that the initial pwrite to an empty file with the
RWF_NOWAIT flag set does not return -EAGAIN.  It turns out that
dax_iomap_rw doesn't pass that flag through to iomap_apply.

With this patch applied, generic/471 passes for me.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/fs/dax.c b/fs/dax.c
index 1f1f0201cad1..0b0d8819cb1b 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1207,6 +1207,9 @@ dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
 		lockdep_assert_held(&inode->i_rwsem);
 	}
 
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		flags |= IOMAP_NOWAIT;
+
 	while (iov_iter_count(iter)) {
 		ret = iomap_apply(inode, pos, iov_iter_count(iter), flags, ops,
 				iter, dax_iomap_actor);

