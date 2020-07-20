Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1887F226928
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbgGTP7M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 11:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732140AbgGTP7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A30C0619D2;
        Mon, 20 Jul 2020 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ATjmBzjI/n6oxkwr3gKzLrXKn2KIaLRJvHCblp/KGMo=; b=ieVgzSIF0/MnWX86vE7znh0SaZ
        +w0UOnDHJfs6ucW7fJdERo7h+KGK27CyD70XmHEWC5JSJFGpreOWoAdQ+gBBUDX5ugIIaBassftAg
        N4zRCBYNIJeD+uIp9cTApbCgkSAXCgWaRElPc4HL3jDQsMz4xPYlgFhCkw677jPNvSOserBfWSPoT
        geQZ1Ai/Vye5Knk6VdPjP9WUOXPPFVA3I6JJ/bR9I/IPO64MPHvk++2Dse1hZyED9cCs5WKLPtcnN
        O4x+psI9RMnV4uaIkuNb3I0w3kYNz1djswFGsVGs2bI6UYEII16DHee6rPnQOqShAk6C2h9TotZm7
        7gK2+Zdw==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYBz-0007mY-7z; Mon, 20 Jul 2020 15:59:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: add file system helpers that take kernel pointers for the init code
Date:   Mon, 20 Jul 2020 17:58:38 +0200
Message-Id: <20200720155902.181712-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

currently a lot of the file system calls in the early in code (and the
devtmpfs kthread) rely on the implicit set_fs(KERNEL_DS) during boot.
This is one of the few last remaining places we need to deal with to kill
off set_fs entirely, so this series adds new helpers that take kernel
pointers.  That is mostly done by pushing the getname() call further up
the stack so that we can add variants using getname_kernel() without
duplicating code.

The series sits on top of my previous

  "decruft the early init / initrd / initramfs code v2"

series.


Git tree:

    git://git.infradead.org/users/hch/misc.git kern_path

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/kern_path


Diffstat:
 drivers/base/devtmpfs.c    |    8 +-
 drivers/md/md-autodetect.c |    2 
 fs/coredump.c              |    2 
 fs/fs_parser.c             |    1 
 fs/internal.h              |   12 ---
 fs/namei.c                 |  166 +++++++++++++++++++++++++++++++--------------
 fs/namespace.c             |  134 +++++++++++++++++++++---------------
 fs/open.c                  |  149 ++++++++++++++++++++++++++++------------
 fs/stat.c                  |   92 ++++++++++++------------
 fs/utimes.c                |   19 +++--
 include/linux/fs.h         |   39 +++++-----
 include/linux/syscalls.h   |   82 ----------------------
 init/do_mounts.c           |   12 +--
 init/do_mounts.h           |    4 -
 init/do_mounts_initrd.c    |   26 +++----
 init/do_mounts_rd.c        |    2 
 init/initramfs.c           |   27 +++----
 init/main.c                |    9 --
 init/noinitramfs.c         |    9 +-
 kernel/uid16.c             |   15 ----
 20 files changed, 434 insertions(+), 376 deletions(-)
