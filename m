Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F711AFDAB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Apr 2020 21:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgDSTpy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 15:45:54 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50993 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbgDSTpw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 15:45:52 -0400
Received: by mail-pj1-f68.google.com with SMTP id t9so1475946pjw.0;
        Sun, 19 Apr 2020 12:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JI0MWD+QJRNLm9H/ySGaj7rD32bWrmPpBuBR7vXM0po=;
        b=FSJ85UrLjGmYQeyidAk9RbNmDPLXhoqbhpyk9DXkl8GmFnUNmj6xK9avazoX7e+v2a
         yubrmnSJcrelYPc79zjTQnVncHM8t9RnTAcFcLnmBXNDTK5srsNIouENQhvr6qzX6DtS
         mrO+foTLSt0khki2wpQsT4J1B9cgafDpTodUZePybyYZHO3aHc1HbREzoXsYTXMN2/+U
         HNhM1sN7aDHazQ+GfLsFwVwzfC5g7Shj/cxZRnlgvJ8wAwgVYhSk8JDAske7GsuM3bgO
         i4rG34RlZKPB4djq8QpVVh35J9lOyRXh7B/EVLhXtOMlGeYICVE6kr+9ZeGwpq9QaAgb
         hgLA==
X-Gm-Message-State: AGi0PubTppbpnuwqowBk7Hh7pCAZaZyBJg8BE0ax5eG9NyRi4WMjBBUA
        J7FpEAurtWDS8qSWwoXhS6A=
X-Google-Smtp-Source: APiQypI5CAO7B1a2nLDOtdLnxkI6y2BKcHcPj3NYYswPtP9sWC/TtH2DZACqpYblnpzrNGt00D3cQA==
X-Received: by 2002:a17:90a:b10f:: with SMTP id z15mr15705940pjq.188.1587325551767;
        Sun, 19 Apr 2020 12:45:51 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id 1sm4588pff.151.2020.04.19.12.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 12:45:43 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1D0CD42309; Sun, 19 Apr 2020 19:45:39 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 10/10] block: put_device() if device_add() fails
Date:   Sun, 19 Apr 2020 19:45:29 +0000
Message-Id: <20200419194529.4872-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200419194529.4872-1-mcgrof@kernel.org>
References: <20200419194529.4872-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Through code inspection I've found that we don't put_device() if
device_add() fails, and this must be done to decrement its refcount.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 06b642b23a07..c52095a74792 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -721,8 +721,10 @@ static void register_disk(struct device *parent, struct gendisk *disk,
 		WARN_ON(ddev->groups);
 		ddev->groups = groups;
 	}
-	if (device_add(ddev))
+	if (device_add(ddev)) {
+		put_device(ddev);
 		return;
+	}
 	if (!sysfs_deprecated) {
 		err = sysfs_create_link(block_depr, &ddev->kobj,
 					kobject_name(&ddev->kobj));
-- 
2.25.1

