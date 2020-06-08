Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E0C1F1D46
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 18:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbgFHQ2B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 12:28:01 -0400
Received: from m15111.mail.126.com ([220.181.15.111]:54020 "EHLO
        m15111.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgFHQ2B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:28:01 -0400
X-Greylist: delayed 1897 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jun 2020 12:27:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=DMG1x6PUP5eE1dmHHA
        dR6SfyvqYK7zNd6DIJ1Bsh6lI=; b=cWdlGqhAptDsUTxrixJL7jSXjxjmpdsXSB
        7L8MY54VG8LlSC4x7LdC7PgSGc7wlS0SHILWbdVuBS+sL+qlS2elPauHMSl9CJQL
        oeM4o7pLK45ST8g8bmhqmVvKYLJXXmzS/4WX0CcRreIefJChXGh/Ku2KJYcuhG/y
        sxHlft+os=
Received: from 192.168.137.250 (unknown [112.10.75.37])
        by smtp1 (Coremail) with SMTP id C8mowAD3Mh2hX95e45kmGQ--.43847S3;
        Mon, 08 Jun 2020 23:56:19 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] direct-io: pass correct argument to dio_complete
Date:   Mon,  8 Jun 2020 11:56:17 -0400
Message-Id: <1591631777-9708-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: C8mowAD3Mh2hX95e45kmGQ--.43847S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw45KFyxtr4ktw17ur4xCrg_yoW5CrWkpF
        yjg3y7KFWavas2yw1UAF4xZF4xWrWkGF4UWrWF9w17Ary3Jrn7tF4rKryfAr4UJrn3try2
        qr409rW5J3WqyaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrManUUUUU=
X-Originating-IP: [112.10.75.37]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbiwQM9pFpD+k1vMgAAso
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When submit async direct-io write operation in function
do_blockdev_direct_IO, 'struct dio' records the info of all bios,
initial value of dio->refcount is set to 1, 'dio->refcount++' is
executed in dio_bio_submit when submit one bio, 'dio->refcount--'
is executed in bio completion handler dio_bio_end_aio.

In do_blockdev_direct_IO, it also calls drop_refcount to do
'dio->refcount--', then judge if dio->refcount is 0, if yes, it
will call dio_complete to complete the dio:
    if (drop_refcount(dio) == 0) {
          retval = dio_complete(dio, retval, DIO_COMPLETE_INVALIDATE);
    } else

dio_bio_end_aio and drop_refcount will race to judge if dio->refcount
is 0:
1, if dio_bio_end_aio finds dio->refcount is 0, it will queue work if
   defer_completion is set, work handler
   dio_aio_complete_work->dio_complete will be called:
      dio_complete(dio, 0,
                    DIO_COMPLETE_ASYNC | DIO_COMPLETE_INVALIDATE);
   if defer_completion not set, it will call:
      dio_complete(dio, 0, DIO_COMPLETE_ASYNC);
   In above two cases, because DIO_COMPLETE_ASYNC is passed to
   dio_complete. So in dio_complete, it will call aio completion handler:
      dio->iocb->ki_complete(dio->iocb, ret, 0);
   As ki_complete is set to aio_complete for async io, which will fill
   an event to ring buffer, then user can use io_getevents to get this
   event.
2, if drop_refcount finds dio->refcount is 0, it will call:
      dio_complete(dio, retval, DIO_COMPLETE_INVALIDATE);
   As no DIO_COMPLETE_ASYNC is passed to dio_complete. So in dio_complete,
   ki_complete(aio_complete) will not be called. Eventually, no one fills
   the completion event to ring buffer, so user can't get the completion
   event via io_getevents.

Currently, we doesn't meet above issue with existing kernel code,
I think because do_blockdev_direct_IO is called in bio submission path,
it will be quickly completed before all aync bios completion in almost
all cases, so when drop_refcounng is executing, it finds dio->refcount is
not 0 after 'dio->refcount--'. But when the last bio completed,
dio_bio_end_aio will be called, which will find dio->refcount is 0,
then below code will be executed and the async events ring buffer getting
to be filled:
      dio_complete(dio, 0, DIO_COMPLETE_ASYNC | DIO_COMPLETE_INVALIDATE);
      or
      dio_complete(dio, 0, DIO_COMPLETE_ASYNC);

Make the code logically with this patch and cover above scenario.

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 fs/direct-io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index 1543b5a..552459f 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1345,7 +1345,9 @@ static inline int drop_refcount(struct dio *dio)
 		dio_await_completion(dio);
 
 	if (drop_refcount(dio) == 0) {
-		retval = dio_complete(dio, retval, DIO_COMPLETE_INVALIDATE);
+		retval = dio_complete(dio, retval, dio->is_async ?
+				DIO_COMPLETE_ASYNC | DIO_COMPLETE_INVALIDATE :
+				DIO_COMPLETE_INVALIDATE);
 	} else
 		BUG_ON(retval != -EIOCBQUEUED);
 
-- 
1.8.3.1

