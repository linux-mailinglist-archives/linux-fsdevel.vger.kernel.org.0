Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755B836681C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Apr 2021 11:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbhDUJf4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Apr 2021 05:35:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238140AbhDUJfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Apr 2021 05:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618997722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mG4K0kyZWiYzHTdtxf9YChQqSb3olomVjvUoAVcTA+s=;
        b=gJPygx7GpcI0RKuCjo1Z3ZLszhAuyFTOw2F+qGCW6sg2SLA2IxACpRkQAl+D8pUGqHqAhW
        Z4eSSENEmLXCtSEiv1/VM067LS2wdCQVU4yAWmOe3dtTZhzhk87+W4DYmX5BRovM59tiL/
        uwqaRDDdE8GKk22mTfQ1nE83VRA0q7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-576-zI_wBCC-MTS2sdC5xB70Jg-1; Wed, 21 Apr 2021 05:35:18 -0400
X-MC-Unique: zI_wBCC-MTS2sdC5xB70Jg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7259E10054F6;
        Wed, 21 Apr 2021 09:35:15 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-224.ams2.redhat.com [10.36.113.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0C9D5DAA5;
        Wed, 21 Apr 2021 09:35:04 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Feng Tang <feng.tang@intel.com>,
        Don Zickus <dzickus@redhat.com>, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v1 1/3] perf: MAP_EXECUTABLE does not indicate VM_MAYEXEC
Date:   Wed, 21 Apr 2021 11:34:51 +0200
Message-Id: <20210421093453.6904-2-david@redhat.com>
In-Reply-To: <20210421093453.6904-1-david@redhat.com>
References: <20210421093453.6904-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before commit e9714acf8c43 ("mm: kill vma flag VM_EXECUTABLE and
mm->num_exe_file_vmas"), VM_EXECUTABLE indicated MAP_EXECUTABLE.
MAP_EXECUTABLE is nowadays essentially ignored by the kernel and does
not relate to VM_MAYEXEC.

Fixes: f972eb63b100 ("perf: Pass protection and flags bits through mmap2 interface")
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/events/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 03db40f6cba9..3dfd463f1831 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8186,8 +8186,6 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 
 	if (vma->vm_flags & VM_DENYWRITE)
 		flags |= MAP_DENYWRITE;
-	if (vma->vm_flags & VM_MAYEXEC)
-		flags |= MAP_EXECUTABLE;
 	if (vma->vm_flags & VM_LOCKED)
 		flags |= MAP_LOCKED;
 	if (is_vm_hugetlb_page(vma))
-- 
2.30.2

