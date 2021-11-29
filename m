Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CD546260F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Nov 2021 23:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhK2Wqu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Nov 2021 17:46:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbhK2WqV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:46:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3512C0F4B2F;
        Mon, 29 Nov 2021 12:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kOfFqqCWKmeBX4845bygWY0Crk0nQJ7uH+sMkN0wPLI=; b=joB6oqCAI4OKzA+aHqyvkh7pct
        KUxarkWFGRgkuPQT2GSTqjouZ1t0F9ZFrI3OGVFxu6dyWP3rhAQOxm978pCZTvdhGUT3NssGnTq1g
        8IM9IHmsNpeYx4KnJuVmJ9iDoKoWh4+YEx+sM85wDJbMuqJSOcFBJDC3jHlQhPZAxST3E716RCdHW
        fE9EmyrtKNF8oDZ1xtfaLd9q4V3OSMZEx0eHxx+ZaXP4VfuwPruaN9rVwqnIh4wnk+ntbnX2DMfXR
        sBfjzSTvvinG/Dtmjiu5RsUZ7ySHLKaAVfgOCWvfhzdFWKMU3rW+bIBfiz3oVhJTlplBO5RL9cAMx
        QDns3RKA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrngk-002XZT-Vc; Mon, 29 Nov 2021 20:55:50 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, steve@sk2.org,
        mcgrof@bombadil.infradead.org, mcgrof@kernel.org,
        andriy.shevchenko@linux.intel.com, jlayton@kernel.org,
        bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] sysctl: 4th set of kernel/sysctl cleanups
Date:   Mon, 29 Nov 2021 12:55:39 -0800
Message-Id: <20211129205548.605569-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 4th set of kernel/sysctl.c cleanups. These are being
pushed out for review for the first time. This is trying to move all
filesystem sysctl knobs out from kernel/sysctl.c to where they are
actually being used.

This is slimming down the fs uses of kernel/sysctl.c to the point
that the next step is to just get rid of the fs base directory for it
and move that elsehwere, so that next patch series starts dealing with
that to demo how we can end up cleaning up a full base directory from
kernel/sysctl.c, one at a time.

Luis Chamberlain (9):
  fs: move inode sysctls to its own file
  fs: move fs stat sysctls to file_table.c
  fs: move dcache sysctls to its own file
  sysctl: move maxolduid as a sysctl specific const
  fs: move shared sysctls to fs/sysctls.c
  fs: move locking sysctls where they are used
  fs: move namei sysctls to its own file
  fs: move fs/exec.c sysctls into its own file
  fs: move pipe sysctls to is own file

 fs/Makefile               |   1 +
 fs/dcache.c               |  32 ++++-
 fs/exec.c                 |  90 ++++++++++++++
 fs/file_table.c           |  47 +++++--
 fs/inode.c                |  31 ++++-
 fs/locks.c                |  34 ++++-
 fs/namei.c                |  58 ++++++++-
 fs/pipe.c                 |  64 +++++++++-
 fs/proc/proc_sysctl.c     |   2 +-
 fs/sysctls.c              |  38 ++++++
 include/linux/dcache.h    |  10 --
 include/linux/fs.h        |  13 --
 include/linux/pipe_fs_i.h |   4 -
 include/linux/sysctl.h    |   9 ++
 kernel/sysctl.c           | 255 ++------------------------------------
 15 files changed, 390 insertions(+), 298 deletions(-)
 create mode 100644 fs/sysctls.c

-- 
2.33.0

