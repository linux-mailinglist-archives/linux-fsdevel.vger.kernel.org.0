Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A484628C6CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 03:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgJMBeU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 21:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgJMBeU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 21:34:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EA8C0613D0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 18:34:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y12so16468903wrp.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2020 18:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m0fVYo23z5sDnIdO7CmhPP5/mdbbm0UqpjwBNjbmzHo=;
        b=KdByimeexhgK1iSMzLpxP57NJAb2JWybo82tdWaJCPrSR7jPuYXzi7z6AI04ExzEDF
         rns0T5/jh1vW9+BXPef9x3z9htEdn/PF5Z7GFYPlz549XuaDu8sz7EK1eqPynqoTEMlT
         v9uozVeynaN7X7iAGyN1HO2j6/3NfcDmew2EU6yiRPSZDRG6mO/CPAWUN45x5PBNiqy3
         0MirEi4xSdE7tG1kqjYNTiqVfEnwYmGNEoTLyOvJZST9etlU2L2kE1ZYKtLEvCDJhA46
         9axx2nBVhBGLTW2YrUl7rO628XbQLNS5Y96xHh/B7ifPka+9/LJfE0iiuP9shnRstOda
         sl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m0fVYo23z5sDnIdO7CmhPP5/mdbbm0UqpjwBNjbmzHo=;
        b=bLW4ijcaXP6pLu6CzqMMi1hkhGfK8i+Uqskjxv276psw4WX3vmhtkDa5fFpWvqyQon
         8s+Cwzwo/quA8k6WCaoHjG8UQ5oOT0WSbmWwU86vhTlEcPz+m30A6b4/Wz+olUmnB3Ot
         yU1ID4jCPMcBZGJL/TXMrnq60whLsOZQT4T3bFtUtFzhqVw+Kco3SQlYy2sXlc1yWvBH
         bmJHiF3WmMih+JWx5wSEcKzHzKffFSfEvdG1aMuZ5mA2uFyJuIZfb9pYUFKNZ2JUInsg
         WMkXYILSurUaF7/fE6opRfsDnlsMxmN3lvvHEIU+4FGmWVxIxVUXhX3u681f6IAt0Bhw
         qHoQ==
X-Gm-Message-State: AOAM533OwogWdPrPeDp2OmOD2oaQJnxMxDPyvGmcHsYPWyZzPieO9MYd
        sG88h/bfArz31S+65ISXgAxYqw==
X-Google-Smtp-Source: ABdhPJylxMFP/0l6plAG1lC4wZxbS5FXIxuQm/csHMG5nqpO55kqKEuOOVOpMKsiWO9QwuFzHnQgrQ==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr33017560wrr.304.1602552858954;
        Mon, 12 Oct 2020 18:34:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id d23sm24825325wmb.6.2020.10.12.18.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 18:34:18 -0700 (PDT)
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
Subject: [PATCH 0/6] mremap: move_vma() fixes
Date:   Tue, 13 Oct 2020 02:34:10 +0100
Message-Id: <20201013013416.390574-1-dima@arista.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

1 - seems to be historical issue on a rarely taken path
2,3 - fixes related to the new mremap() flag
5 - dax device/hugetlbfs possible issue

4,6 - refactoring

As those seems to be actual issues, sending this during the merge-window.

(Changes to architecture code are in the 6 patch, but Cc'ing
maintainers on cover for the context, I hope it's fine).

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>

Cc: linux-aio@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org

Dmitry Safonov (6):
  mm/mremap: Account memory on do_munmap() failure
  mm/mremap: For MREMAP_DONTUNMAP check security_vm_enough_memory_mm()
  mremap: Don't allow MREMAP_DONTUNMAP on special_mappings and aio
  vm_ops: Rename .split() callback to .may_split()
  mremap: Check if it's possible to split original vma
  mm: Forbid splitting special mappings

 arch/arm/kernel/vdso.c                    |  9 ----
 arch/arm64/kernel/vdso.c                  | 41 ++-----------------
 arch/mips/vdso/genvdso.c                  |  4 --
 arch/s390/kernel/vdso.c                   | 11 +----
 arch/x86/entry/vdso/vma.c                 | 17 --------
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  2 +-
 drivers/dax/device.c                      |  4 +-
 fs/aio.c                                  |  5 ++-
 include/linux/mm.h                        |  5 ++-
 ipc/shm.c                                 |  8 ++--
 mm/hugetlb.c                              |  2 +-
 mm/mmap.c                                 | 22 ++++++++--
 mm/mremap.c                               | 50 +++++++++++------------
 13 files changed, 63 insertions(+), 117 deletions(-)


base-commit: bbf5c979011a099af5dc76498918ed7df445635b
-- 
2.28.0

