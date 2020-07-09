Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3B3A21A365
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 17:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgGIPSU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 11:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgGIPST (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:18:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD01C08C5CE;
        Thu,  9 Jul 2020 08:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=s9fW2QPvoy1mcA7ve1JdCIVHxc5trSIbAV9MvcAFbd0=; b=OP1+pQE6Je/IEH9QagnzBdZsnv
        8Zd8zpznJtYY95rcFrqrlh045tWdcsSB9gLuzaPIKOxhVm/ay2tGjuw8YrD8mKvcJNgxOLx1J3Aa+
        TZF0j1rewa8MmFS57NyFUiBNGN4yCaYiWff0rUZVnJLJndbgy7gEzep5wZlA83xtIxOI5dmV1YNQQ
        HhxSMPSM743PeP0i5U86Ork8rv0NaQeZJIbvFJk8IcRnZRdL2kJMSA7hhRsY+VKtA3X2RSZaAf8SM
        4X2xe9L7SDbf5aOtVmCg3iSiBXATxKhYgUqQ5YdWwX59Tp5r3u1ACWrfbMrEErSQMam9ujXzHr05x
        DzNJtdVg==;
Received: from [2001:4bb8:188:5f50:7053:304b:bf82:82cf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtYJT-0005Jr-6A; Thu, 09 Jul 2020 15:18:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: decruft the early init / initrd / initramfs code v2
Date:   Thu,  9 Jul 2020 17:17:57 +0200
Message-Id: <20200709151814.110422-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

this series starts to move the early init code away from requiring
KERNEL_DS to be implicitly set during early startup.  It does so by
first removing legacy unused cruft, and the switches away the code
from struct file based APIs to our more usual in-kernel APIs.

There is no really good tree for this, so if there are no objections
I'd like to set up a new one for linux-next.


Git tree:

    git://git.infradead.org/users/hch/misc.git init-user-pointers

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/init-user-pointers


Changes since v1:
 - add a patch to deprecated "classic" initrd support

Diffstat:
 b/arch/arm/kernel/atags_parse.c |    2 
 b/arch/sh/kernel/setup.c        |    2 
 b/arch/sparc/kernel/setup_32.c  |    2 
 b/arch/sparc/kernel/setup_64.c  |    2 
 b/arch/x86/kernel/setup.c       |    2 
 b/drivers/md/Makefile           |    3 
 b/drivers/md/md-autodetect.c    |  239 ++++++++++++++++++----------------------
 b/drivers/md/md.c               |   34 +----
 b/drivers/md/md.h               |   10 +
 b/fs/file.c                     |    7 -
 b/fs/open.c                     |   18 +--
 b/fs/read_write.c               |    2 
 b/fs/readdir.c                  |   11 -
 b/include/linux/initrd.h        |    6 -
 b/include/linux/raid/detect.h   |    8 +
 b/include/linux/syscalls.h      |   16 --
 b/init/Makefile                 |    1 
 b/init/do_mounts.c              |   70 +----------
 b/init/do_mounts.h              |   21 ---
 b/init/do_mounts_initrd.c       |   13 --
 b/init/do_mounts_rd.c           |  102 +++++++----------
 b/init/initramfs.c              |  103 +++++------------
 b/init/main.c                   |   16 +-
 include/linux/raid/md_u.h       |   13 --
 24 files changed, 251 insertions(+), 452 deletions(-)
