Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A07C3DB4C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 09:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbhG3H6G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 03:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbhG3H6F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:58:05 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A68DC061765
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:58:01 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id x15-20020a05683000cfb02904d1f8b9db81so8624921oto.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Ah5+LqI1Dziut4yM0LH3jQhWAKB3EiOL6LUittwAvkA=;
        b=PZSsLjQhcjyWAqzvgQshw7+5wZKOaT84MH5jTXoLyyI/aOKDQwtjaOC8rspyuwR40D
         CPEzyuE2oY1RLOrSY1DwOaWdrUFxPFQ7XZxVb/F45EKbtlDPwmk9NYUTYdHB6voKCv5J
         NWAVxgTmbC9AIVv1MulyF6w3VltvV+ZvFpaXGQ40tgHDAWtuqSTyD73X4oPShh5dvZ9o
         rh5oQ96rSEvCqs5JDkjnxTOZuAlSHA10NF8NHIR43vAsccP9TdV7QGyC2MwgJMJL/+Lv
         JQMF3kva96grq5CFt8QuFkcc04skiTeWZ44uu8EtK40TUyhev/AUzfBrw9bMK1QGwlha
         SMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Ah5+LqI1Dziut4yM0LH3jQhWAKB3EiOL6LUittwAvkA=;
        b=p07pMBEikxiqkpGSF4cvXXVK5Re6OgPUt2V6N41CCRRhG8YrU3FWUKAUPZoDyr3JrX
         Xm41SvAQYI9+OCZvsUacGJIm62f8Rx0TOIEdlV1G/CSeiT+nd6xXTyttKHEODoVkCpC3
         FLBWY/lxPazD++TI66om2FPB6Blz5AvHw1Xrid6ZSTRBx5UOOj2+OTrkYsNJyxPTd+WM
         Ga8Fpy7m5jJqqI6h5aE68OIRE8sC/D9nhA+caXfuChKpNweKxkOMXCVGaNmjDwsT0TJj
         woTciyk3Ozt/IzXm1gV2Iik2GI/M9CEUA8+8ruIMqjtXyYEacO5h0XGbTSCjhh+viL3p
         gpwA==
X-Gm-Message-State: AOAM530Ku4ccaC3k+LctGChzkd47jrn95qMaWavLbrHLNg8wWEzCdJyr
        TIEV+e7DvCnm2yXxCtFzme3vIg==
X-Google-Smtp-Source: ABdhPJyC6TATMzaci6gPPfYcCgBGVbL7XqE2Ve5WDt3z2Ltgzz9z2ISDZBfr8b91jrb3S/yU1QEXWA==
X-Received: by 2002:a9d:6f99:: with SMTP id h25mr1064541otq.113.1627631880857;
        Fri, 30 Jul 2021 00:58:00 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y19sm179786oia.22.2021.07.30.00.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 00:57:59 -0700 (PDT)
Date:   Fri, 30 Jul 2021 00:57:56 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 11/16] tmpfs: fcntl(fd, F_MEM_LOCKED) to test if memlocked
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <a4f03e42-14a3-8e1b-387e-6f18b57f1eb@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Though we have not yet found a compelling need to make the locked status
of a tmpfs file visible, and offer no tool to show it, the kernel ought
to be able to support such a tool: add the F_MEM_LOCKED fcntl, returning
-1 on failure (not tmpfs), 0 when not F_MEM_LOCKED, 1 when F_MEM_LOCKED.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 fs/fcntl.c                 | 1 +
 include/uapi/linux/fcntl.h | 1 +
 mm/shmem.c                 | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index a3534764b50e..0d8dc723732d 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -439,6 +439,7 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_NOHUGEPAGE:
 	case F_MEM_LOCK:
 	case F_MEM_UNLOCK:
+	case F_MEM_LOCKED:
 		err = shmem_fcntl(filp, cmd, arg);
 		break;
 	default:
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 21dc969df0fd..012585e8c9ab 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -88,6 +88,7 @@
  */
 #define F_MEM_LOCK		(F_LINUX_SPECIFIC_BASE + 17)
 #define F_MEM_UNLOCK		(F_LINUX_SPECIFIC_BASE + 18)
+#define F_MEM_LOCKED		(F_LINUX_SPECIFIC_BASE + 19)
 
 /*
  * Types of directory notifications that may be requested.
diff --git a/mm/shmem.c b/mm/shmem.c
index ba9b9900287b..6e53dabe658b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2299,6 +2299,9 @@ static int shmem_memlock_fcntl(struct file *file, unsigned int cmd)
 	bool cleanup_mapping = false;
 	int retval = 0;
 
+	if (cmd == F_MEM_LOCKED)
+		return !!info->mlock_ucounts;
+
 	inode_lock(inode);
 	if (cmd == F_MEM_LOCK) {
 		if (!info->mlock_ucounts) {
@@ -2762,6 +2765,7 @@ long shmem_fcntl(struct file *file, unsigned int cmd, unsigned long arg)
 		break;
 	case F_MEM_LOCK:
 	case F_MEM_UNLOCK:
+	case F_MEM_LOCKED:
 		error = shmem_memlock_fcntl(file, cmd);
 		break;
 	}
-- 
2.26.2

