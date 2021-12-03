Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF435466E5D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 01:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhLCASX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 19:18:23 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60072 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbhLCASX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:18:23 -0500
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Dec 2021 19:18:23 EST
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id D16D91F953;
        Fri,  3 Dec 2021 00:05:34 +0000 (UTC)
Date:   Fri, 3 Dec 2021 00:05:34 +0000
From:   Eric Wong <normalperson@yhbt.net>
To:     fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: per-inode locks in FUSE (kernel vs userspace)
Message-ID: <20211203000534.M766663@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all, I'm working on a new multi-threaded FS using the
libfuse3 fuse_lowlevel.h API.  It looks to me like the kernel
already performs the necessary locking on a per-inode basis to
save me some work in userspace.

In particular, I originally thought I'd need pthreads mutexes on
a per-inode (fuse_ino_t) basis to protect userspace data
structures between the .setattr (truncate), .fsync, and
.write_buf userspace callbacks.

However upon reading the kernel, I can see fuse_fsync,
fuse_{cache,direct}_write_iter in fs/fuse/file.c all use
inode_lock.  do_truncate also uses inode_lock in fs/open.c.

So it's look like implementing extra locking in userspace would
do nothing useful in my case, right?

Thanks.
