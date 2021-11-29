Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6595746250E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhK2Wev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbhK2WeL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:34:11 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA4DC09B196;
        Mon, 29 Nov 2021 13:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=x/zQypJPuTEP0Tjk66V8wyYvNmILMyia+VZFyUf2E84=; b=InTJS8JcKM32KTuZiXxsZwxc9g
        9xrDU0SA7DFTjHD4QMhh31k/iI0aC4idKkSIzSyKmjfO1Bp/CVTL9xnu8hWoFzn8aOpwuvscGkkGv
        HCJIRj7fyyvSwPMf8tSowOqiCAMb1O5R4fIJAR0AT1mItytXdtWaOhcoQEUNFbbpTGNkxNv4dz7t+
        jbp/B8dq8GZ83fWE30EwhfB+fM9DlKb2jGtoZKlt9Yj12x2qYuoKUUS6q6z8yClwfi5opJn5Vm3kF
        FlYci30kOc7lR3xEAc1wAo0sOC8otIJyS3IlxRXsIVfEalbmDtQudr9lOCNGqJ5xpoEs3hUc4MmKJ
        quqU04zg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mro3s-002gZt-JO; Mon, 29 Nov 2021 21:19:44 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        christian.brauner@ubuntu.com, ebiggers@google.com,
        naveen.n.rao@linux.ibm.com, davem@davemloft.net,
        mhiramat@kernel.org, anil.s.keshavamurthy@intel.com
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] sysctl: 5th set of kernel/sysctl cleanups
Date:   Mon, 29 Nov 2021 13:19:37 -0800
Message-Id: <20211129211943.640266-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is my 5th set of sysctl cleanups for kernel/sysctl. In this
patch series we start addressing base directories, and so we start
with the "fs" sysctls. The end goal is we end up completely moving
all "fs" sysctl knobs out from kernel/sysctl.

My queue of patches is done with this patch series, and so help from
others on trimming down kernel/sysctl.c further would be greatly
appreciated now that we have a path to move the rest of the stuff out.

Luis Chamberlain (3):
  sysctl: add and use base directory declarer and registration helper
  fs: move namespace sysctls and declare fs base directory
  kernel/sysctl.c: rename sysctl_init() to sysctl_init_bases()

Xiaoming Ni (3):
  printk: fix build warning when CONFIG_PRINTK=n
  fs/coredump: move coredump sysctls into its own file
  kprobe: move sysctl_kprobes_optimization to kprobes.c

 arch/arm/mm/alignment.c  |  2 +-
 arch/sh/mm/alignment.c   |  2 +-
 fs/Makefile              |  3 +-
 fs/coredump.c            | 66 ++++++++++++++++++++++++++++++++++++---
 fs/exec.c                | 55 ---------------------------------
 fs/namespace.c           | 24 +++++++++++++-
 fs/proc/proc_sysctl.c    | 13 ++++++--
 fs/sysctls.c             |  9 +++---
 include/linux/coredump.h | 10 +++---
 include/linux/kprobes.h  |  6 ----
 include/linux/mount.h    |  3 --
 include/linux/printk.h   |  4 ---
 include/linux/sysctl.h   | 25 ++++++++++++++-
 kernel/kprobes.c         | 30 +++++++++++++++---
 kernel/printk/internal.h |  2 ++
 kernel/printk/printk.c   |  3 +-
 kernel/sysctl.c          | 67 ++++++----------------------------------
 17 files changed, 173 insertions(+), 151 deletions(-)

-- 
2.33.0

