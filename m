Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF3BF8239E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 19:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfHERFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 13:05:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38848 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730093AbfHERFQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:05:16 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so39969660pfn.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2019 10:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hfTT9Vyh4lJ/Mb9rTCTCYXmmzA+mBf4ub6OXNmSq8us=;
        b=MWgO4tm5GTritoxl53gt5qNjI6dHxFHD3f2tmoGq9OJgzbnGXd/y+DqsRAV4dJJOe8
         mYeyo0j3HZzU6Tao9ECna4T86NUvCDpvt4gexDupdIGfVRUQxbA+88ArezoiE9kyDdqN
         Lu/GqdUdfcjbf1HEszwyMIgGK8XfBF0rg6oXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hfTT9Vyh4lJ/Mb9rTCTCYXmmzA+mBf4ub6OXNmSq8us=;
        b=EwVotdh24ehuMYWNgtpisOFdlFyUHp2zQPdpQp/jAtXpPInaGomaxH5Qzo6AOtaYQf
         /lJBeISbKcvJCYdqwdMICCu/++vontna6ZNaia2o2+PsrTautWFsMR3Wm8XxprGqMtvH
         XhoJEym4lYs5YZzEZvnkpeseLxt50w3Hi7DbkXTBupgCPm4A4MQ//DXWqhZ+1dmeyGLO
         JKOZBpS8gKyySbk1Jtupj9NByjDlhradzFwvWZCub4SwyDT4sptuhUVYiPNUkXFtwGdz
         V0zMTsQJZHtu2N59+e2sbEjL3NcW/7hZs26fb1TC4V70FH88dW8SRCKfQtvri3LLjtdr
         vIzA==
X-Gm-Message-State: APjAAAU692CX7kM/aTuIJmS4ofRgvrIjIC4dbyA8opSrcTErULo6tb+k
        eEzbfNOm1ru6qAQx3LGWaKI=
X-Google-Smtp-Source: APXvYqwNN1t4bVbzgmwIXdCDQSshCIBMOslB9kNDo+lLtbCe0bb0+FNBd/Sai0oabP93PogQiVJHkw==
X-Received: by 2002:a62:770e:: with SMTP id s14mr71578047pfc.150.1565024716052;
        Mon, 05 Aug 2019 10:05:16 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p23sm89832934pfn.10.2019.08.05.10.05.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 10:05:15 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, joelaf@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: [PATCH v4 4/5] page_idle: Drain all LRU pagevec before idle tracking
Date:   Mon,  5 Aug 2019 13:04:50 -0400
Message-Id: <20190805170451.26009-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190805170451.26009-1-joel@joelfernandes.org>
References: <20190805170451.26009-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

During idle tracking, we see that sometimes faulted anon pages are in
pagevec but are not drained to LRU. Idle tracking considers pages only
on LRU. Drain all CPU's LRU before starting idle tracking.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/page_idle.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/page_idle.c b/mm/page_idle.c
index a5b00d63216c..2972367a599f 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -180,6 +180,8 @@ static ssize_t page_idle_bitmap_read(struct file *file, struct kobject *kobj,
 	unsigned long pfn, end_pfn;
 	int bit, ret;
 
+	lru_add_drain_all();
+
 	ret = page_idle_get_frames(pos, count, NULL, &pfn, &end_pfn);
 	if (ret == -ENXIO)
 		return 0;  /* Reads beyond max_pfn do nothing */
@@ -211,6 +213,8 @@ static ssize_t page_idle_bitmap_write(struct file *file, struct kobject *kobj,
 	unsigned long pfn, end_pfn;
 	int bit, ret;
 
+	lru_add_drain_all();
+
 	ret = page_idle_get_frames(pos, count, NULL, &pfn, &end_pfn);
 	if (ret)
 		return ret;
@@ -428,6 +432,8 @@ ssize_t page_idle_proc_generic(struct file *file, char __user *ubuff,
 	walk.private = &priv;
 	walk.mm = mm;
 
+	lru_add_drain_all();
+
 	down_read(&mm->mmap_sem);
 
 	/*
-- 
2.22.0.770.g0f2c4a37fd-goog

