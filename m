Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0C228C6D3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 03:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgJMBea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 21:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgJMBe2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 21:34:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E797C0613D7
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 18:34:28 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h7so21863856wre.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 18:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+hT7zzmskqvyrywNbGv1SqYy6yeRy0QTDltdgYSbdc=;
        b=CYzWXkjHBNX+YU71eO5qpuuPH6qwUIdqJ/91p3uYMEMCdZAKCSTrNpq5TVbhmE0CD3
         I/VxDj5wkbfpz7t0kQmbILNl/5EseAGLKDK8dCemcemqrzP3b56toQhhE3rNbnkWmkmm
         AICs1qLVVt2lax+VdQCmztePp5r0dg4+rFYAPJGdEALV5rSwyMg9LJiqUmL79gPixms9
         ntjlR6MHQ1kYOjnTSbioqJvPiK4/DfA2peP3dpqJYRhN6pOfIolRGMfCAz3AdiWY+SBD
         Hjd8PJdjC3spCD+xAvw0TX9aA0hdWnJyRznCUfgv2rcesWONvNxkVjwNeIhJxKvga2lq
         sbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+hT7zzmskqvyrywNbGv1SqYy6yeRy0QTDltdgYSbdc=;
        b=J77cXi8Nj2SPPJ8IbDEuDFCncsaKR4+91byrf2GHVix5f1Xw/WkTGREOsrSeKkIAab
         yq3pi6TESEymjUCOTxYqVZFbQ/61/AxV4famaCIOpUbk/Kr7AjHy+dzi/m1881604kKL
         6QkV1yxbUvkwBPULUyziISSCcBkoI7XJDFCG2koydieSW1220sxVtWPUusltJU1I2F2/
         f9iNlGnxvw+rpdYrqgJ1SUFCbI6jOkibLt8R92mdPjtwg1BYOGBotYL3/iCqu9tt/hJ0
         nguYfGh910w3pge+dt9cO6B6GZAa/MF7DHXPTZOjV/tGJ/aND/yiGvgrjjGgtb3tIkIs
         SG3w==
X-Gm-Message-State: AOAM533UpmfZgu8rmRqE+OriEjFzvgFeWNh2SAnUIxZjOnalVSv+5ffA
        J4oIyNJeKL0jJ/sLFmxAtZ+6IA==
X-Google-Smtp-Source: ABdhPJx/eA0xaURdD39kuIvNIumfP2FJFkk5wEpy22MoNkD2iAsN3onMEMvZoLmBi3z0b1VkhtsO1w==
X-Received: by 2002:a5d:4c8d:: with SMTP id z13mr16731759wrs.412.1602552866741;
        Mon, 12 Oct 2020 18:34:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id d23sm24825325wmb.6.2020.10.12.18.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 18:34:26 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 5/6] mremap: Check if it's possible to split original vma
Date:   Tue, 13 Oct 2020 02:34:15 +0100
Message-Id: <20201013013416.390574-6-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013013416.390574-1-dima@arista.com>
References: <20201013013416.390574-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If original VMA can't be split at the desired address, do_munmap() will
fail and leave both new-copied VMA and old VMA. De-facto it's
MREMAP_DONTUNMAP behaviour, which is unexpected.

Currently, it may fail such way for hugetlbfs and dax device mappings.

Minimize such unpleasant situations to OOM by checking .may_split()
before attempting to create a VMA copy.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 mm/mremap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 898e9818ba6d..3c4047c23673 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -343,7 +343,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	unsigned long excess = 0;
 	unsigned long hiwater_vm;
 	int split = 0;
-	int err;
+	int err = 0;
 	bool need_rmap_locks;
 
 	/*
@@ -353,6 +353,15 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (mm->map_count >= sysctl_max_map_count - 3)
 		return -ENOMEM;
 
+	if (vma->vm_ops && vma->vm_ops->may_split) {
+		if (vma->vm_start != old_addr)
+			err = vma->vm_ops->may_split(vma, old_addr);
+		if (!err && vma->vm_end != old_addr + old_len)
+			err = vma->vm_ops->may_split(vma, old_addr + old_len);
+		if (err)
+			return err;
+	}
+
 	/*
 	 * Advise KSM to break any KSM pages in the area to be moved:
 	 * it would be confusing if they were to turn up at the new
-- 
2.28.0

