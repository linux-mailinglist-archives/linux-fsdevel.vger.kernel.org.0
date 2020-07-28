Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746F5230FE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731900AbgG1Qgb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbgG1QeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:34:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D09AC061794;
        Tue, 28 Jul 2020 09:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=kVQtb0EC5zPxTA2ayYfBJx4HY/CNxKUjYbbIch9w8To=; b=mspBTjUWtgpPb4qLvI5PjYWwOM
        4xZNHTabFfBvssqH7c/39Sc1ekp+M5+SqBDUYBkt2ucniLwNBWaq94zkkYOoIAPj/UaRMf4mtx3YK
        W0L5iZg+7xHA9TiFXC8u5fc6fYHDe6CT6b15J8Oesifa05gXH7hnFa0iYkc8g+AcyI/0rNI4O8Ox0
        obSdlxKChKraUYqMq1yyafpl/in4CI0Hav66IYrJPtqDtGUSPZR2/x9DBfWbuLTlo8NYaOgCPZqJD
        OvUuAnCvA43Twt/6GA+RD8XxJ33FRrI6T32fxA0LxAHyvgCch5i6HSuh9FxyNeJUH2sjVKeCH7mvP
        Ev8vTchw==;
Received: from [2001:4bb8:180:6102:fd04:50d8:4827:5508] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0SYV-0006wk-6T; Tue, 28 Jul 2020 16:34:19 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: add file system helpers that take kernel pointers for the init code v4
Date:   Tue, 28 Jul 2020 18:33:53 +0200
Message-Id: <20200728163416.556521-1-hch@lst.de>
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


Changes since v3:
 - rename fs/for_init.c to fs/init.c
 - document the purpose of the routines in fs/init.c with a comment
 - don't mark devtmpfs __init as that will cause it to get overwritten
   by initmem poisoning
 - add an init_dup helper to make Al more happy than with the version
   commit to the "decruft the early init / initrd / initramfs code v2"
   series

Changes since v2:
 - move to fs/for_init.c
 - reuse the init routines in devtmpfs after refactoring devtmpfsd
   (and thus the broken error handling in the previous version)
 - actually use kern_path in a place where user_path_at sneaked back in

Changes since v1:
 - avoid most core VFS changes
 - renamed the functions and move them to init/ and devtmpfs
 - drop a bunch of cleanups that can be submitted independently now


Diffstat:
