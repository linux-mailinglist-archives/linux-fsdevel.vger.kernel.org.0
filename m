Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CD045D0F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 00:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352588AbhKXXS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 18:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343885AbhKXXSW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 18:18:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13D1C061746;
        Wed, 24 Nov 2021 15:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Fxmt17Vrui7KwJx26k3w18jjiyXBLFeliPHkymEoIEo=; b=z2cPFa8Obs3Z8C5CUvYgGEvLoB
        CoNe8+DhHGI4qxNT0FzlIiP/n75Oc5wQOFFSDcM8KoSWm0lJTzj+OPcR9u2CfVgXXdZSe/9Y2UaiG
        XJemiPtZLn9ZxOpc/boRZnWbE7huYqrbYD6hbiv9LVy+8ibF5sUgjHfyQjKwxgxDlbXSA8aPRIZAa
        2WoBYDsKItzOyyLtBye6FCSCqx6RFsC6bTISllZYNKB/sOqYpnSq3Ea0kJu7e5TdsFKZ/1iNSsPhq
        K3G0JlEuitR16U/exCq+QppEsm11EsWJwNMOzAhpjQD/6WGwsnRfHEx+6t4k3ZzlH4rb9p8rVcsfY
        Lu5lVLPA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mq1TI-0063yv-Ie; Wed, 24 Nov 2021 23:14:36 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, keescook@chromium.org,
        yzaikin@google.com, nixiaoming@huawei.com, ebiederm@xmission.com,
        steve@sk2.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        tytso@mit.edu, viro@zeniv.linux.org.uk, pmladek@suse.com,
        senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, dgilbert@interlog.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        linux-scsi@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] sysctl: 3rd set of kernel/sysctl cleanups
Date:   Wed, 24 Nov 2021 15:14:27 -0800
Message-Id: <20211124231435.1445213-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the third set of patches to help address cleaning the kitchen
seink in kernel/sysctl.c and to move sysctls away to where they are
actually implemented / used.

Note that Andrew Morton is staging these to get visibility into changes
in the various trees which might conflict. He already grabbed the
first two sets of patch sets, and so I think these changes are probably
best to be eventually considered to be merged through his tree, to
avoid conflicts.

On this v2 series since last year's v1 series has these changes:

  * extended commit log to clarify that in these cases, while we
    are not producing less lines of code we justify the move
    because otherwise the file kernel/sysctl.c gets way out of hand
    to maintain.

  * addressed 0-day complaints

  * the firmware loader changes requested by Greg KH were adopted

  * added the new sysctl mount point helper as suggested by
    Eric W. Biederman

Luis Chamberlain (3):
  sysctl: add helper to register a sysctl mount point
  fs: move binfmt_misc sysctl to its own file
  sysctl: share unsigned long const values

Xiaoming Ni (5):
  firmware_loader: move firmware sysctl to its own files
  random: move the random sysctl declarations to its own file
  printk: move printk sysctl to printk/sysctl.c
  scsi/sg: move sg-big-buff sysctl to scsi/sg.c
  stackleak: move stack_erasing sysctl to stackleak.c

 drivers/base/firmware_loader/fallback.c       |   7 +-
 drivers/base/firmware_loader/fallback.h       |  11 ++
 drivers/base/firmware_loader/fallback_table.c |  21 ++-
 drivers/char/random.c                         |  14 +-
 drivers/scsi/sg.c                             |  35 ++++-
 fs/binfmt_misc.c                              |   6 +-
 fs/proc/proc_sysctl.c                         |  16 +++
 include/linux/stackleak.h                     |   5 -
 include/linux/sysctl.h                        |  15 ++-
 include/scsi/sg.h                             |   4 -
 kernel/printk/Makefile                        |   5 +-
 kernel/printk/internal.h                      |   6 +
 kernel/printk/printk.c                        |   1 +
 kernel/printk/sysctl.c                        |  85 ++++++++++++
 kernel/stackleak.c                            |  26 +++-
 kernel/sysctl.c                               | 122 +-----------------
 16 files changed, 239 insertions(+), 140 deletions(-)
 create mode 100644 kernel/printk/sysctl.c

-- 
2.33.0

