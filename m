Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84700FFD12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2019 03:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfKRCYo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Nov 2019 21:24:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33672 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfKRCYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Nov 2019 21:24:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id 71so13141347qkl.0;
        Sun, 17 Nov 2019 18:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0PODx413zWYXfSobH+0+CB4Ms3JTa4kjwkVV1cKBF0I=;
        b=rmjEArZt+40+6whHrw6ndvflf4Colo6cGXVekvJlkeRrMjkUod5apJCONqqT4UVuey
         KJHpoxmAd2B/w6sVOUPRXpmHgQQSh2FsaQ28m6shiAZ7OKPzEhS/0Ilq3/1NEEhVC29k
         zbTYIPnDmR4GKiYbWR/73N1wgIrjxq77uMlJ+7LNVmYLSfY3XW7CiK0ke66ner0HGenJ
         0LuVUcu5jgnsLsEDYwCgL9Bi6qwDZZ49awAZahqJarg0niTRKSw0x0hu63HgmNeix3oZ
         wbYcmFMFlDXC5Fu84M+oQbKneXjPl3JXfAuEVX5ktGKLobIoyZuT+X/qfByP7FMKlH3V
         Rf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0PODx413zWYXfSobH+0+CB4Ms3JTa4kjwkVV1cKBF0I=;
        b=g/jv/OrVDJH5GXpcrEj5KwV3M3/autmmPPgBPYR6xmk2VubGFGpoBEqyzycGqYOl1K
         Hw9UxENL58bPb0U4LsCGAcqChRhTBcN+h/yUWz1U3wF1Ks9BlD7xu0LKyfJFk3kttXnq
         doJDbX82t3zpsNeldPRTWMz6y9EHFWivw4OajjAGdqjeYNONuWjPg/EJRprBYfib+wZ2
         cDsHUeBfDn7uZdSwOhr/deiR/Q4nsoMzdbOrzUnIY79FqbD8Fbb92uZHgI/UscYGAvAD
         WlMzmBAvx1Z/Tyd/kr8yAwLsR7PUGyXjqKk2VIklELHXoKHiUwnTG5N+mUz/ImeMmyMq
         drNg==
X-Gm-Message-State: APjAAAUp1t0xBXTyTdd65mUFyS93jAX1Rlq1MNnHsb1PC56zHaKpk3dA
        y1na+9Kz1yltjNG8ZBaU6g==
X-Google-Smtp-Source: APXvYqyck54SgVxduwvF2JuxnOVAELdcvpnIQqSktS7SoxNdd0A13dSN4e4J0HtjJBHoykci9Yv0Nw==
X-Received: by 2002:a05:620a:159c:: with SMTP id d28mr21918417qkk.466.1574043882984;
        Sun, 17 Nov 2019 18:24:42 -0800 (PST)
Received: from gabell.redhat.com (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id w15sm9687938qtk.43.2019.11.17.18.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 18:24:42 -0800 (PST)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com
Subject: [PATCH] fuse: Fix the return code of fuse_direct_IO() to deal with the error for aio
Date:   Sun, 17 Nov 2019 21:24:10 -0500
Message-Id: <20191118022410.21023-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

exit_aio() is sometimes stuck in wait_for_completion() after aio is issued
with direct IO and the task receives a signal.

That is because kioctx in mm->ioctx_table is in use by aio_kiocb.
aio_kiocb->ki_refcnt is 1 at that time. That means iocb_put() isn't
called correctly.

fuse_get_req() returns as -EINTR when it's blocked and receives a signal.
fuse_direct_IO() deals with the -EINTER as -EIOCBQUEUED and returns as
-EIOCBQUEUED even though the aio isn't queued.
As the result, aio_rw_done() doesn't handle the error, so iocb_put() isn't
called via aio_complete_rw(), which is the callback.

The flow is something like as:

  io_submit
    aio_get_req
      refcount_set(&req->ki_refcnt, 2)
    __io_submit_one
      aio_read
      ...
        fuse_direct_IO # return as -EIOCBQUEUED
          __fuse_direct_read
          ...
            fuse_get_req # return as -EINTR
        aio_rw_done
          # Nothing to do because ret is -EIOCBQUEUED...
    iocb_put
      refcount_dec_and_test(&iocb->ki_refcnt) # 2->1

Return as the error code of fuse_direct_io() or __fuse_direct_read() in
fuse_direct_IO() so that aio_rw_done() can handle the error and call
iocb_put().

This issue is trucked as a virtio-fs issue:
https://gitlab.com/virtio-fs/qemu/issues/14

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 fs/fuse/file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index db48a5cf8620..87b151aec8f2 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3115,8 +3115,12 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		fuse_aio_complete(io, ret < 0 ? ret : 0, -1);
 
 		/* we have a non-extending, async request, so return */
-		if (!blocking)
-			return -EIOCBQUEUED;
+		if (!blocking) {
+			if (ret >= 0)
+				return -EIOCBQUEUED;
+			else
+				return ret;
+		}
 
 		wait_for_completion(&wait);
 		ret = fuse_get_res_by_io(io);
-- 
2.18.1

