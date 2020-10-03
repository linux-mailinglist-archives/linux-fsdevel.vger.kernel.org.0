Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A9728209F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 04:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbgJCCzj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 22:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgJCCzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:55:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294B6C0613D0
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 19:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=DGR+5R6KgnX3F5fS1JsEMAGQ6hwXUzIviFihF5AfRt4=; b=QodbkNJoF+o7m4DH+7zQOnsc3V
        CinUa4Aq6fzGJhKwBL9avCB9dkr5E0NOcHxK0yjNSDHRcY1rcydapCgZn4LNaWRAUTUDFLavoKAzB
        wuLBy/6SQBS/DgRnMzGY2eT5aOPjgFVR54x82ihRAZ/xs+N9NFNJcbmz/GbFItyRq3HWOxp2eJg0A
        e/Livk+61ww/PN0yfXsrzI/0YJqJV3pr+SEsghsX94dIR01aOEI5jTRpIDo63nUwL0GbQaOq/W8hO
        V3LTlivmUom/2h5O+CZcJZfC/H0AVQnm+x4Oi0DlwbP0r9o0as8BnRd6x1JjaoLERBH23+AQ90WP/
        vWmvqGcg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOXhv-0005UV-Lp; Sat, 03 Oct 2020 02:55:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/13] Clean up kernel_read/kernel_write
Date:   Sat,  3 Oct 2020 03:55:21 +0100
Message-Id: <20201003025534.21045-1-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus asked that NULL pos be allowed to kernel_write() / kernel_read().
This set of patches (against Al's for-next tree) does that in the first
two patches, and then converts many of the users of kernel_write() /
kernel_read() to use a NULL pointer.  I test-compiled as many as I could.

Matthew Wilcox (Oracle) (13):
  fs: Allow a NULL pos pointer to __kernel_write
  fs: Allow a NULL pos pointer to __kernel_read
  fs/acct: Pass a NULL pointer to __kernel_write
  um/mconsole: Pass a NULL pointer to kernel_read
  x86/aout: Pass a NULL pointer to kernel_read
  aout: Pass a NULL pointer to kernel_read
  binfmt_flat: Pass a NULL pointer to kernel_read
  exec: Pass a NULL pointer to kernel_read
  bpfilter: Pass a NULL pointer to kernel_read and kernel_write
  keys: Pass a NULL pointer to kernel_read and kernel_write
  target: Pass a NULL pointer to kernel_write
  proc: Pass a NULL pointer to kernel_write
  usermode: Pass a NULL pointer to kernel_write

 arch/um/drivers/mconsole_kern.c   |  3 +--
 arch/x86/ia32/ia32_aout.c         |  3 +--
 drivers/target/target_core_alua.c |  3 +--
 drivers/target/target_core_pr.c   |  3 +--
 fs/binfmt_aout.c                  |  3 +--
 fs/binfmt_flat.c                  |  3 +--
 fs/exec.c                         |  4 +---
 fs/proc/proc_sysctl.c             |  3 +--
 fs/read_write.c                   | 10 ++++++----
 kernel/acct.c                     |  4 +---
 kernel/usermode_driver.c          |  3 +--
 net/bpfilter/bpfilter_kern.c      |  7 ++-----
 security/keys/big_key.c           |  7 ++-----
 13 files changed, 20 insertions(+), 36 deletions(-)

-- 
2.28.0

