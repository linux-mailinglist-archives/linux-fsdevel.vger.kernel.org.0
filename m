Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA726F7809
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 May 2023 23:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjEDV2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 May 2023 17:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjEDV2G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 May 2023 17:28:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4934C13845;
        Thu,  4 May 2023 14:28:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f4000ec74aso7594125e9.3;
        Thu, 04 May 2023 14:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683235683; x=1685827683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVvS/g9TQZhbyJ0eYwxV/bq9pypwHnS3KxbZ3TakH0A=;
        b=nDqaT9jTn1xS/73an8X8CZx5lEdAkbbCfNc3aHqQJY0MVaAq0rKXw3Hl7EMh/PsKaw
         KjyDymSUIa5lvaOxTxYcZSbLRrSnGQzJhrU33LOy4zs4CYIrEBerOvyOsdbMlCNDO4dL
         4gY+0oFUzAdGI9dIz6XS+VdORUSXJ7h5O/+xBztBvos5R5Dp5BwIfaMrSxDXjkraVAb3
         GqetQj/TybYu3/KEm0PfEL08hp229jk6gotjF2Jewejdv6Rzc52IcDKptRklcWfBNEck
         NXllxEh+8zHWwya/9Vrmo0A+7JwnwYxL3tCYQhtxtoBkNw/T+kFfCUInMF5IfH12dFgK
         6QdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683235683; x=1685827683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVvS/g9TQZhbyJ0eYwxV/bq9pypwHnS3KxbZ3TakH0A=;
        b=D/LJkI0ab6qG2i6Ol1kbzEHieOqdUo4BupE/mvajpQIgTtBk1l5JohuNbEMYYTVj61
         JnEtub7F40aVOco/Or1h6xEDF9nin+MnppSqgRGb+l1fQ0iw3Gzh5ryaU5dsJSiVXczL
         E//1+qCpZSzCzDGHdLGKq69zqKc86vZq6AWxnngl4eXNUeI6WWuqRABoeOrfhiy20Yui
         Mk+oKNu4qyjZp/0wDUcYH5M+jKUCofmZvEZhokfT4/iY8v1UG55VcbrcP6lul++NLWX/
         QDdbcOET6/EtY2UmbxxJKeXqNaHcmNE6Vzx4Qt24RaBbEAVQcPDjU44zKVy9k8DEvcIG
         aiug==
X-Gm-Message-State: AC+VfDxoycTh9Lx14VvgXmj3peRFLfa01pSijWMa8IOWPAU7rBDanxOY
        WmI29VzQfjz3PkQSDcJeexQ=
X-Google-Smtp-Source: ACHHUZ7OkkaKrVwLmJGvJfx2GtQ/hBrq0xkNESgtAjZZX9WIor0cxYkB1uwQpjW6k8RY3NIvur5rlA==
X-Received: by 2002:a1c:f30d:0:b0:3f1:7ba6:d5ab with SMTP id q13-20020a1cf30d000000b003f17ba6d5abmr580330wmq.36.1683235683276;
        Thu, 04 May 2023 14:28:03 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id h15-20020a05600c314f00b003f1978bbcd6sm51617562wmo.3.2023.05.04.14.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 14:28:02 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Topel <bjorn@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Mika Penttila <mpenttil@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Peter Xu <peterx@redhat.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v9 2/3] mm/gup: disallow FOLL_LONGTERM GUP-nonfast writing to file-backed mappings
Date:   Thu,  4 May 2023 22:27:52 +0100
Message-Id: <7282506742d2390c125949c2f9894722750bb68a.1683235180.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1683235180.git.lstoakes@gmail.com>
References: <cover.1683235180.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Writing to file-backed mappings which require folio dirty tracking using
GUP is a fundamentally broken operation, as kernel write access to GUP
mappings do not adhere to the semantics expected by a file system.

A GUP caller uses the direct mapping to access the folio, which does not
cause write notify to trigger, nor does it enforce that the caller marks
the folio dirty.

The problem arises when, after an initial write to the folio, writeback
results in the folio being cleaned and then the caller, via the GUP
interface, writes to the folio again.

As a result of the use of this secondary, direct, mapping to the folio no
write notify will occur, and if the caller does mark the folio dirty, this
will be done so unexpectedly.

For example, consider the following scenario:-

1. A folio is written to via GUP which write-faults the memory, notifying
   the file system and dirtying the folio.
2. Later, writeback is triggered, resulting in the folio being cleaned and
   the PTE being marked read-only.
3. The GUP caller writes to the folio, as it is mapped read/write via the
   direct mapping.
4. The GUP caller, now done with the page, unpins it and sets it dirty
   (though it does not have to).

This results in both data being written to a folio without writenotify, and
the folio being dirtied unexpectedly (if the caller decides to do so).

This issue was first reported by Jan Kara [1] in 2018, where the problem
resulted in file system crashes.

This is only relevant when the mappings are file-backed and the underlying
file system requires folio dirty tracking. File systems which do not, such
as shmem or hugetlb, are not at risk and therefore can be written to
without issue.

Unfortunately this limitation of GUP has been present for some time and
requires future rework of the GUP API in order to provide correct write
access to such mappings.

However, for the time being we introduce this check to prevent the most
egregious case of this occurring, use of the FOLL_LONGTERM pin.

These mappings are considerably more likely to be written to after
folios are cleaned and thus simply must not be permitted to do so.

This patch changes only the slow-path GUP functions, a following patch
adapts the GUP-fast path along similar lines.

[1]:https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz/

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Mika Penttilä <mpenttil@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/gup.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index ff689c88a357..0ea9ebec9547 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -959,16 +959,54 @@ static int faultin_page(struct vm_area_struct *vma,
 	return 0;
 }
 
+/*
+ * Writing to file-backed mappings which require folio dirty tracking using GUP
+ * is a fundamentally broken operation, as kernel write access to GUP mappings
+ * do not adhere to the semantics expected by a file system.
+ *
+ * Consider the following scenario:-
+ *
+ * 1. A folio is written to via GUP which write-faults the memory, notifying
+ *    the file system and dirtying the folio.
+ * 2. Later, writeback is triggered, resulting in the folio being cleaned and
+ *    the PTE being marked read-only.
+ * 3. The GUP caller writes to the folio, as it is mapped read/write via the
+ *    direct mapping.
+ * 4. The GUP caller, now done with the page, unpins it and sets it dirty
+ *    (though it does not have to).
+ *
+ * This results in both data being written to a folio without writenotify, and
+ * the folio being dirtied unexpectedly (if the caller decides to do so).
+ */
+static bool writable_file_mapping_allowed(struct vm_area_struct *vma,
+					  unsigned long gup_flags)
+{
+	/*
+	 * If we aren't pinning then no problematic write can occur. A long term
+	 * pin is the most egregious case so this is the case we disallow.
+	 */
+	if ((gup_flags & (FOLL_PIN | FOLL_LONGTERM)) !=
+	    (FOLL_PIN | FOLL_LONGTERM))
+		return true;
+
+	/*
+	 * If the VMA does not require dirty tracking then no problematic write
+	 * can occur either.
+	 */
+	return !vma_needs_dirty_tracking(vma);
+}
+
 static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 {
 	vm_flags_t vm_flags = vma->vm_flags;
 	int write = (gup_flags & FOLL_WRITE);
 	int foreign = (gup_flags & FOLL_REMOTE);
+	bool vma_anon = vma_is_anonymous(vma);
 
 	if (vm_flags & (VM_IO | VM_PFNMAP))
 		return -EFAULT;
 
-	if (gup_flags & FOLL_ANON && !vma_is_anonymous(vma))
+	if ((gup_flags & FOLL_ANON) && !vma_anon)
 		return -EFAULT;
 
 	if ((gup_flags & FOLL_LONGTERM) && vma_is_fsdax(vma))
@@ -978,6 +1016,10 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		return -EFAULT;
 
 	if (write) {
+		if (!vma_anon &&
+		    !writable_file_mapping_allowed(vma, gup_flags))
+			return -EFAULT;
+
 		if (!(vm_flags & VM_WRITE)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
-- 
2.40.1

