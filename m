Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FCB22DC8C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 09:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgGZHOC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 03:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgGZHOC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:14:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAEDC0619D2;
        Sun, 26 Jul 2020 00:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=fGf+qSjLbZzodelUPagTscOoGuAaHiLzBDim0f5g4Ow=; b=Qsa8OvuKB3jr+n70HNOY96eEeD
        fismT6fWrOOgNIqz/mVybBthRGeVzcYM4YH+nrai3LiCOZVV+5lol3nhzoGWSCrEHcwjHQzYGhJh6
        FfawKunah9bsJb+W+kNMsd2IC1c0KcEo0l1/AvvnHRbrgX22UbpPh+qUEGSqsjdMrifGJGuV07BUy
        3LtuwFAqCyroV05Exkxd2TaxJ1C6i0sh/Pg+Ok2k3QRu+ljAV9SnoziLPVi3jpyanDeDU0kfLiM1e
        PoxhQ+hSAdUvYu054wRlIVUeoGsZuWKTdVlw4wZnw0pkDvMjbAwpFlPdXQozpA5vHN1ElqOun28SO
        oeAgopug==;
Received: from [2001:4bb8:18c:2acc:5ff1:d0b0:8643:670e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzar7-0002Nr-MG; Sun, 26 Jul 2020 07:13:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: add file system helpers that take kernel pointers for the init code v3
Date:   Sun, 26 Jul 2020 09:13:35 +0200
Message-Id: <20200726071356.287160-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al and Linus,

currently a lot of the file system calls in the early in code (and the
devtmpfs kthread) rely on the implicit set_fs(KERNEL_DS) during boot.
This is one of the few last remaining places we need to deal with to kill
off set_fs entirely, so this series adds new helpers that take kernel
pointers.  These helpers are in init/ and marked __init and thus will
be discarded after bootup.  A few also need to be duplicated in devtmpfs,
though unfortunately.

The series sits on top of my previous

  "decruft the early init / initrd / initramfs code v2"

series.


Git tree:

    git://git.infradead.org/users/hch/misc.git init_path

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/init_path


Changes since v2:
 - move to fs/for-init.c
 - reuse the init routines in devtmpfs after refactoring devtmpfsd
   (and thus the broken error handling in the previous version)
 - actually use kern_path in a place where user_path_at sneaked back in

Changes since v1:
 - avoid most core VFS changes
 - renamed the functions and move them to init/ and devtmpfs
 - drop a bunch of cleanups that can be submitted independently now


Diffstat:
 drivers/base/devtmpfs.c       |   54 +++++----
 drivers/md/md-autodetect.c    |    3 
 fs/Makefile                   |    2 
 fs/for_init.c                 |  249 ++++++++++++++++++++++++++++++++++++++++++
 fs/internal.h                 |   19 +--
 fs/namei.c                    |   20 +--
 fs/namespace.c                |  107 ++++++++----------
 fs/open.c                     |   22 +--
 include/linux/init_syscalls.h |   18 +++
 include/linux/syscalls.h      |   66 -----------
 init/do_mounts.c              |   12 +-
 init/do_mounts.h              |    7 -
 init/do_mounts_initrd.c       |   26 ++--
 init/do_mounts_rd.c           |    2 
 init/initramfs.c              |   29 ++--
 init/main.c                   |   10 -
 init/noinitramfs.c            |    8 -
 17 files changed, 423 insertions(+), 231 deletions(-)
