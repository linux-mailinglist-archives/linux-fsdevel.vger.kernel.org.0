Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C88323C407
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 05:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgHEDkt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 23:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHEDks (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:40:48 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F0EC06174A;
        Tue,  4 Aug 2020 20:40:48 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so15048379pfh.3;
        Tue, 04 Aug 2020 20:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=rzzRqXjFEunIT1yZSSg1CKlJvEECBfp+MgDWsFWjUvI=;
        b=iY9JbyNSBtjDkkcBBtYVJi6/b9GolFcvDtU5KawfaZyA0+9dTCDa1AK05EKbNQITlD
         XTfONIbcJTPP3ZlXxb4BOXtL6LD1cZLatdjtewM/9xZyu7gJFP9niti9X8PGmvHJYE64
         iXQCVANYc8YQwGDsJ+JxDHMKno8uNzqF/czmj2ldHbVJ5aXtDjugL+Z+QkoIlcS9X0xq
         eZi8mAl5v78paw8vu84acHnxcbZ+nIiFJZ8khS7u56z0GW6mN5Zpxv4fhZJ1fVqX5OVD
         q/XxF4V7t825zQNceionDeEusM3nNlgIB3dlA/JeDXfRMIkVUrClZTIjBV6NOUWRHJ0x
         b5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=rzzRqXjFEunIT1yZSSg1CKlJvEECBfp+MgDWsFWjUvI=;
        b=jNy8FOZoQUWBjJmJc5T/4TZ+ccfovBxWiQFhDA5NpEVAZ22ShJa/AYhkekrJbYKa4p
         M8R/ujcDobwBWertH4YsZsbrC7LxtD5wxJ3sSdsmU1DdDy8mlb+oNfc6KGeNCh3xv8Ul
         AoqabSqRf7RMcr1qcRv3/zvIN1tosZZ2iwj4HBD28TcaKBpRI3SfgN872cKk5WZ8V57K
         QuwuTWzPR6N/nsqoMJXJn4B8LSDjjSG9JSUvI2V0XH8XwhbEFKFUBWhdRJXIwZKXDeUd
         Sirl2DDAY+vh2g35Fc21YPIv5IdHbhedn6+JYySefxeTPpeI9G8p/0CPdUU6/4Diw7lW
         s3AA==
X-Gm-Message-State: AOAM530e/CWrEsgAxlW4dAFTK3Rn9Vf93tTSpeFH/iFykv++SZO+aEd1
        S+9Ixv3WD1LpNJh9FUjUqNO7+VF0ned95w==
X-Google-Smtp-Source: ABdhPJx1HdDmTQsmnl2GToZoJYpx9vzI2MF9PZc28RwIEtemGRYvTPfbA+FHPNR1D3IEHrHbsCiJ5A==
X-Received: by 2002:aa7:810c:: with SMTP id b12mr1449191pfi.69.1596598847760;
        Tue, 04 Aug 2020 20:40:47 -0700 (PDT)
Received: from localhost ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id fh14sm810632pjb.38.2020.08.04.20.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 20:40:47 -0700 (PDT)
Date:   Tue, 4 Aug 2020 20:40:42 -0700
From:   Guoyu Huang <hgy5945@gmail.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring: Fix use-after-free in io_sq_wq_submit_work()
Message-ID: <20200805034042.GA29805@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

when ctx->sqo_mm is zero, io_sq_wq_submit_work() frees 'req'
without deleting it from 'task_list'. After that, 'req' is
accessed in io_ring_ctx_wait_and_kill() which lead to
a use-after-free.

Signed-off-by: Guoyu Huang <hgy5945@gmail.com>
---
 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e0200406765c..4b5ac381c67f 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2242,6 +2242,7 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 		if (io_sqe_needs_user(sqe) && !cur_mm) {
 			if (!mmget_not_zero(ctx->sqo_mm)) {
 				ret = -EFAULT;
+				goto end_req;
 			} else {
 				cur_mm = ctx->sqo_mm;
 				use_mm(cur_mm);
--
2.25.1

