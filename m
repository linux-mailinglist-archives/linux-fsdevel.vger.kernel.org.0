Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8EB823A3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2019 19:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfHERFV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Aug 2019 13:05:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44518 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729941AbfHERFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Aug 2019 13:05:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id t14so36687687plr.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Aug 2019 10:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EpW+/zsfaWUWqnp/CzJ8iSD2ZsdUd34jJeLFlQmjMJk=;
        b=hgyWzkgSkWIkAiyvGZ+G+xjb4IZCoTupPLFm8KMlB2b4hKbMxa1b+uIr1iRdua+wqE
         QC4A3wju5EZMPMzUeRrpvG6gxy5MEYfQ82W1fGN8SHtXC5yuCxMcBGlIpCV6ZH3OP4zQ
         UMkuRWp/Da9107v0m9+9yab3KvcgH65HHQUcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EpW+/zsfaWUWqnp/CzJ8iSD2ZsdUd34jJeLFlQmjMJk=;
        b=ngXZKkV/NPQsfqKJG+qvTbcmC552wX1hl3n1qAurLW3VBh9bYJivwGOOclfIPIEC+d
         DhMz+JbHYcJjQxwzLpSTOWv2WzD8HDEI/TNW29xmJWpZzJb0BI4+NTxefnB16QZaJawi
         gsPkdLAWGbHlVJfb6EdMNW/HOCxabF6mwn7RJyfHmuzgpki6EVWu6laE2WhHgQbggdc3
         ixXb7JlhDMYB7a3nvjBhv3zkXHp91ch5XKNP3yLCHdAPbEPvxAvad3XTAogLuKwYci45
         JxdulApQ4ZKjxhSltHjxc63CAeqnHfoMf1FqWMRD0PqAOy1TttJD74JPcrdmCwNMPHMH
         nMXQ==
X-Gm-Message-State: APjAAAUQbwkiTccqTDkOTpS6h8rG0O2v30Jfe6Kf/pEuq1x14c+DGe/7
        DNnvPM+Vj/MxgPqhp/I+J1M=
X-Google-Smtp-Source: APXvYqza5nQrNDdoUqGT6kyvYnC1EmmsZrzblP42jhwdV0CyAlqgihwZyUT70kUG+iUloT382Cjx7g==
X-Received: by 2002:a17:902:9a95:: with SMTP id w21mr61715428plp.126.1565024719760;
        Mon, 05 Aug 2019 10:05:19 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p23sm89832934pfn.10.2019.08.05.10.05.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 10:05:19 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sandeep Patil <sspatil@google.com>,
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
        Michal Hocko <mhocko@suse.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: [PATCH v4 5/5] doc: Update documentation for page_idle virtual address indexing
Date:   Mon,  5 Aug 2019 13:04:51 -0400
Message-Id: <20190805170451.26009-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190805170451.26009-1-joel@joelfernandes.org>
References: <20190805170451.26009-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch updates the documentation with the new page_idle tracking
feature which uses virtual address indexing.

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Sandeep Patil <sspatil@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../admin-guide/mm/idle_page_tracking.rst     | 43 ++++++++++++++++---
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/idle_page_tracking.rst b/Documentation/admin-guide/mm/idle_page_tracking.rst
index df9394fb39c2..9eef32000f5e 100644
--- a/Documentation/admin-guide/mm/idle_page_tracking.rst
+++ b/Documentation/admin-guide/mm/idle_page_tracking.rst
@@ -19,10 +19,14 @@ It is enabled by CONFIG_IDLE_PAGE_TRACKING=y.
 
 User API
 ========
+There are 2 ways to access the idle page tracking API. One uses physical
+address indexing, another uses a simpler virtual address indexing scheme.
 
-The idle page tracking API is located at ``/sys/kernel/mm/page_idle``.
-Currently, it consists of the only read-write file,
-``/sys/kernel/mm/page_idle/bitmap``.
+Physical address indexing
+-------------------------
+The idle page tracking API for physical address indexing using page frame
+numbers (PFN) is located at ``/sys/kernel/mm/page_idle``.  Currently, it
+consists of the only read-write file, ``/sys/kernel/mm/page_idle/bitmap``.
 
 The file implements a bitmap where each bit corresponds to a memory page. The
 bitmap is represented by an array of 8-byte integers, and the page at PFN #i is
@@ -74,6 +78,31 @@ See :ref:`Documentation/admin-guide/mm/pagemap.rst <pagemap>` for more
 information about ``/proc/pid/pagemap``, ``/proc/kpageflags``, and
 ``/proc/kpagecgroup``.
 
+Virtual address indexing
+------------------------
+The idle page tracking API for virtual address indexing using virtual frame
+numbers (VFN) for a process ``<pid>`` is located at ``/proc/<pid>/page_idle``.
+It is a bitmap that follows the same semantics as
+``/sys/kernel/mm/page_idle/bitmap`` except that it uses virtual instead of
+physical frame numbers.
+
+This idle page tracking API does not deal with PFN so it does not require prior
+lookups of ``pagemap``. This is an advantage on some systems where looking up
+PFN is considered a security issue.  Also in some cases, this interface could
+be slightly more reliable to use than physical address indexing, since in
+physical address indexing, address space changes can occur between reading the
+``pagemap`` and reading the ``bitmap``, while in virtual address indexing, the
+process's ``mmap_sem`` is held for the duration of the access.
+
+To estimate the amount of pages that are not used by a workload one should:
+
+ 1. Mark all the workload's pages as idle by setting corresponding bits in
+    ``/proc/<pid>/page_idle``.
+
+ 2. Wait until the workload accesses its working set.
+
+ 3. Read ``/proc/<pid>/page_idle`` and count the number of bits set.
+
 .. _impl_details:
 
 Implementation Details
@@ -99,10 +128,10 @@ When a dirty page is written to swap or disk as a result of memory reclaim or
 exceeding the dirty memory limit, it is not marked referenced.
 
 The idle memory tracking feature adds a new page flag, the Idle flag. This flag
-is set manually, by writing to ``/sys/kernel/mm/page_idle/bitmap`` (see the
-:ref:`User API <user_api>`
-section), and cleared automatically whenever a page is referenced as defined
-above.
+is set manually, by writing to ``/sys/kernel/mm/page_idle/bitmap`` for physical
+addressing or by writing to ``/proc/<pid>/page_idle`` for virtual
+addressing (see the :ref:`User API <user_api>` section), and cleared
+automatically whenever a page is referenced as defined above.
 
 When a page is marked idle, the Accessed bit must be cleared in all PTEs it is
 mapped to, otherwise we will not be able to detect accesses to the page coming
-- 
2.22.0.770.g0f2c4a37fd-goog

