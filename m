Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623831F1DFE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 19:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgFHRBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 13:01:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34075 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730723AbgFHRBh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 13:01:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id z64so8815044pfb.1;
        Mon, 08 Jun 2020 10:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jH2CPsvsaNzRGDf+QoUv0Reklj4c8N9GM5jBSfoalww=;
        b=tsevuJV1Iihvy23O3EFYlzKUbVXwb4QEf7Ll3n9XuTNx0NcZXjhBhe13laHD9TIUXG
         d8UH92DdmnrlmalNeHw/dd5TBYgFFU7PlHt5C/4Lpddl8yE/o8/B4qktqd7gU9ZHHyzd
         Iu2rFcnaZkHufwgiE0uRlWseXVW7NCUPuM95GLHTT5dcZ+ifGsLU6UZfYCwokWbOeFOu
         c8WZoi6YeZyGxE6woJSKHmhd6uRE2VfDeuPFIhMirEHILLuIq3Rke7okFLbxPi8Wtz+4
         NctwLkQeVG1YuyDJNBJaH6hgXEtAuJKUIZpXZVW8O2wOld/3hhA9ocDXUPjaG3gpfSjH
         KRjQ==
X-Gm-Message-State: AOAM532ygqbZtZhG75G7gCPRc3yIHzTGV/kRabr2AATCCKzNsbNxtrlh
        Guh0eK0nLgX4fWke6YjtP9sfp92hbZE=
X-Google-Smtp-Source: ABdhPJwwBujS3U9PCsomBnrxJDGD76z2zyRa1W/F///y1VSt1LrxETfDgpsHrdXoXXBTG59fZ8Mfyg==
X-Received: by 2002:a63:6345:: with SMTP id x66mr20466636pgb.156.1591635694775;
        Mon, 08 Jun 2020 10:01:34 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x197sm7671771pfc.13.2020.06.08.10.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 10:01:32 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 6DF0E41D95; Mon,  8 Jun 2020 17:01:28 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v6 4/6] blktrace: annotate required lock on do_blk_trace_setup()
Date:   Mon,  8 Jun 2020 17:01:24 +0000
Message-Id: <20200608170127.20419-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200608170127.20419-1-mcgrof@kernel.org>
References: <20200608170127.20419-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure it is clear which lock is required on do_blk_trace_setup().

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/trace/blktrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 7f60029bdaff..7ff2ea5cd05e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -483,6 +483,8 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	struct dentry *dir = NULL;
 	int ret;
 
+	lockdep_assert_held(&q->blk_trace_mutex);
+
 	if (!buts->buf_size || !buts->buf_nr)
 		return -EINVAL;
 
-- 
2.26.2

