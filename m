Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 073321A0C5F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Apr 2020 13:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgDGLAj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Apr 2020 07:00:39 -0400
Received: from mail.windriver.com ([147.11.1.11]:38362 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgDGLAi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Apr 2020 07:00:38 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 037B0UiY025449
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 7 Apr 2020 04:00:30 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Tue, 7 Apr 2020 04:00:28 -0700
From:   <zhe.he@windriver.com>
To:     <viro@zeniv.linux.org.uk>, <axboe@kernel.dk>, <bcrl@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-aio@kvack.org>,
        <linux-kernel@vger.kernel.org>, <zhe.he@windriver.com>
Subject: [PATCH 2/2] aio: Update calling to eventfd_signal_count with righ parameter
Date:   Tue, 7 Apr 2020 18:59:52 +0800
Message-ID: <1586257192-58369-2-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586257192-58369-1-git-send-email-zhe.he@windriver.com>
References: <1586257192-58369-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

eventfd_signal_count has been changed to take eventfd context as
parameter. Update the calling accordingly.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 fs/aio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index 5f3d3d8..c03c487 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1693,7 +1693,8 @@ static int aio_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 		list_del(&iocb->ki_list);
 		iocb->ki_res.res = mangle_poll(mask);
 		req->done = true;
-		if (iocb->ki_eventfd && eventfd_signal_count()) {
+		if (iocb->ki_eventfd &&
+		    eventfd_signal_count(iocb->ki_eventfd)) {
 			iocb = NULL;
 			INIT_WORK(&req->work, aio_poll_put_work);
 			schedule_work(&req->work);
-- 
2.7.4

