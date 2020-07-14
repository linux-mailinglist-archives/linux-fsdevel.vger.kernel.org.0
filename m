Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B499C21FC1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgGNTGn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729917AbgGNTGl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:06:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B2C061755;
        Tue, 14 Jul 2020 12:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3mOaoD/B/fJiX289qQjOUZtXOEZ2+n+0JbvjRMjxJao=; b=IDR/vZd4vo7XbrQ3tTdWn6EOsA
        fGgy5xPMuRkYm1IvorwX2tRu+QVFD9THWEEz/F7SKv0ODpJrJMTqvujD8fMBgR+96UDHuQwN1+ukr
        3qVqC2NlQi310NumxiqTfX1xt6lAECmhhBdKCE3mcgN/+qR+ms56Vesqe3YU2AGA/LA3p2p0nnLrd
        sYTfvUSptdqcle1kCtdQ/Lf/QWY9HbbtZN3C0tcqN9qKYaffJlbVIRy3pkXa2OiVMbc0MfMitchUT
        fQdG5vK6q4WfYqnrTWI7pCNgpRqBwnjERK3xS8X1sDu1AC3nRIsCBnvsPI5n3q4cJPCekNSVi6O7z
        h7IBwuxA==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQGE-0005cy-Vv; Tue, 14 Jul 2020 19:06:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: decruft the early init / initrd / initramfs code v2
Date:   Tue, 14 Jul 2020 21:04:04 +0200
Message-Id: <20200714190427.4332-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
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

Changes since v2:
 - add vfs_fchown and vfs_fchmod helpers and use them for initramfs
   unpacking
 - split patches up a little more
 - fix a commit log typo
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
 b/fs/ioctl.c                    |    7 -
 b/fs/open.c                     |   56 +++++----
 b/fs/read_write.c               |    2 
 b/fs/readdir.c                  |   11 -
 b/include/linux/fs.h            |    3 
 b/include/linux/initrd.h        |    6 -
 b/include/linux/raid/detect.h   |    8 +
 b/include/linux/syscalls.h      |   17 --
 b/init/Makefile                 |    1 
 b/init/do_mounts.c              |   70 +----------
 b/init/do_mounts.h              |   21 ---
 b/init/do_mounts_initrd.c       |   13 --
 b/init/do_mounts_rd.c           |  102 +++++++----------
 b/init/initramfs.c              |  103 +++++------------
 b/init/main.c                   |   16 +-
 include/linux/raid/md_u.h       |   13 --
 26 files changed, 279 insertions(+), 473 deletions(-)
