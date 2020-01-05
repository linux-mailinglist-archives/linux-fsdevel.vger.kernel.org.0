Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61BE5130575
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jan 2020 02:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgAEBlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jan 2020 20:41:31 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:46310 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgAEBlb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jan 2020 20:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578188489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PFbuxjhzkUeppz8ScPsjki0VOQ0QjZ2Z1MTS33+xgec=;
        b=h0h07MQVBtzIYS4m04pFIeBylTLEVdejJfCAE5flQ/zioFiB2ZKy8rPyZJExINaAZQo10A
        UaQ1OSWzZZOw9+lEPZTxxqWlpqTjEa+iIKhmy2L5aPpDvDLvz1yZ+PZMzOpzG8Yert3hVa
        +k5iHwSK3cUsmfgxRuPCMxh0nJoxtrQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-rPilglJfMeSLFR4wdkMzYw-1; Sat, 04 Jan 2020 20:41:26 -0500
X-MC-Unique: rPilglJfMeSLFR4wdkMzYw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A6515182B791;
        Sun,  5 Jan 2020 01:41:25 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3837C38A;
        Sun,  5 Jan 2020 01:41:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: move guard_bio_eod() after bio_set_op_attrs
Date:   Sun,  5 Jan 2020 09:41:14 +0800
Message-Id: <20200105014114.4824-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 85a8ce62c2ea ("block: add bio_truncate to fix guard_bio_eod")
adds bio_truncate() for handling bio EOD. However, bio_truncate()
doesn't use the passed 'op' parameter from guard_bio_eod's callers.

So bio_trunacate() may retrieve wrong 'op', and zering pages may
not be done for READ bio.

Fixes this issue by moving guard_bio_eod() after bio_set_op_attrs()
in submit_bh_wbc() so that bio_truncate() can always retrieve correct
op info.

Meantime remove the 'op' parameter from guard_bio_eod() because it isn't
used any more.

Cc: Carlos Maiolino <cmaiolino@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Fixes: 85a8ce62c2ea ("block: add bio_truncate to fix guard_bio_eod")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/buffer.c   | 8 ++++----
 fs/internal.h | 2 +-
 fs/mpage.c    | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index e94a6619464c..18a87ec8a465 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3031,7 +3031,7 @@ static void end_bio_bh_io_sync(struct bio *bio)
  * errors, this only handles the "we need to be able to
  * do IO at the final sector" case.
  */
-void guard_bio_eod(int op, struct bio *bio)
+void guard_bio_eod(struct bio *bio)
 {
 	sector_t maxsector;
 	struct hd_struct *part;
@@ -3095,15 +3095,15 @@ static int submit_bh_wbc(int op, int op_flags, st=
ruct buffer_head *bh,
 	bio->bi_end_io =3D end_bio_bh_io_sync;
 	bio->bi_private =3D bh;
=20
-	/* Take care of bh's that straddle the end of the device */
-	guard_bio_eod(op, bio);
-
 	if (buffer_meta(bh))
 		op_flags |=3D REQ_META;
 	if (buffer_prio(bh))
 		op_flags |=3D REQ_PRIO;
 	bio_set_op_attrs(bio, op, op_flags);
=20
+	/* Take care of bh's that straddle the end of the device */
+	guard_bio_eod(bio);
+
 	if (wbc) {
 		wbc_init_bio(wbc, bio);
 		wbc_account_cgroup_owner(wbc, bh->b_page, bh->b_size);
diff --git a/fs/internal.h b/fs/internal.h
index 4a7da1df573d..e3fa69544b66 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -38,7 +38,7 @@ static inline int __sync_blockdev(struct block_device *=
bdev, int wait)
 /*
  * buffer.c
  */
-extern void guard_bio_eod(int rw, struct bio *bio);
+extern void guard_bio_eod(struct bio *bio);
 extern int __block_write_begin_int(struct page *page, loff_t pos, unsign=
ed len,
 		get_block_t *get_block, struct iomap *iomap);
=20
diff --git a/fs/mpage.c b/fs/mpage.c
index a63620cdb73a..ccba3c4c4479 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -62,7 +62,7 @@ static struct bio *mpage_bio_submit(int op, int op_flag=
s, struct bio *bio)
 {
 	bio->bi_end_io =3D mpage_end_io;
 	bio_set_op_attrs(bio, op, op_flags);
-	guard_bio_eod(op, bio);
+	guard_bio_eod(bio);
 	submit_bio(bio);
 	return NULL;
 }
--=20
2.20.1

