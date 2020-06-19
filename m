Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9012201CA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 22:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391070AbgFSUrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 16:47:41 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39886 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390831AbgFSUri (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 16:47:38 -0400
Received: by mail-pf1-f196.google.com with SMTP id d66so4927060pfd.6;
        Fri, 19 Jun 2020 13:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jH2CPsvsaNzRGDf+QoUv0Reklj4c8N9GM5jBSfoalww=;
        b=EtMRTWjSA/XS/Sj0DF7zU5HchaXyxTbxxShmaD0xKI2F5Bwav1WbC/6+ykbZDAZpY5
         3F8TGjiOgxE6YEqxXA6Gpr+w+yeHcORkGlc1hW7eujvW2NK8ndMTJVkv67VtyFG8U722
         I5wU4dpAaMivjvD1RvZhRakdQL6zubdLzvz6oypQXckaKdx3y4WFFEedMXd9I+KbJlFw
         96GWjcugF+szq5tzOCxckol7oXOn0EmBmRh47+iUzDDbaM8U0bzGHkZxAwbfIH9Gp9QX
         OHLWXqnSqI5mVkDitD6GD7YIE+ckxFqt1Sr0H/7DeJDAlggMnx+A4NgXC8JQ1JWru15i
         GVOw==
X-Gm-Message-State: AOAM533EQ6oTZ6pqrWTvRuLZOguJQ71BtPhnXki9vIzFyliKVoQnhad5
        GUU45iVGXAP2OU8xfDE2nrg=
X-Google-Smtp-Source: ABdhPJw+rxutY1uGOaVhJTaFSz863dhub5gLBJTRgN2o19CWJtfQJo8NFso3QjofJ3IY9132mgZ6aQ==
X-Received: by 2002:aa7:981d:: with SMTP id e29mr727732pfl.298.1592599657521;
        Fri, 19 Jun 2020 13:47:37 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u14sm7353047pfk.211.2020.06.19.13.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 13:47:33 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 657E241DAA; Fri, 19 Jun 2020 20:47:32 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v7 4/8] blktrace: annotate required lock on do_blk_trace_setup()
Date:   Fri, 19 Jun 2020 20:47:26 +0000
Message-Id: <20200619204730.26124-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200619204730.26124-1-mcgrof@kernel.org>
References: <20200619204730.26124-1-mcgrof@kernel.org>
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

