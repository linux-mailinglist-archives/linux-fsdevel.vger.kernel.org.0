Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561DA352AB5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 14:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhDBMhS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 08:37:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhDBMhR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 08:37:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 942DC61106;
        Fri,  2 Apr 2021 12:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617367036;
        bh=Ivt0HnRHYx0uDRC8a+8SL6lxAK6xFC5gTFvzh+BG1nk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CqUPY8rknlU69046VzfLqstx09GPQCMuqGmeS9YXIr1vN+H63hw+p9AzjqErCfros
         AwO/zZ2Nvr029WB4As0HiMdrEi9yT3wqav547tv4QpjXAbltjs2k2Sc0Q0pxjORH7Z
         SiTr9HilYyGbnqpfPF4+WAY0BGJXlSmwNIl1B4fjZEU5x0h7JRlkUtMLFFSgSV+Vb5
         tAcVC4O3WASLuMJGfoTeFNofxg50eUMfPw1TsnIyBZA5gC4jDOwuN3EMu0XBy005nl
         uEWcVXH0725AfVVMbZNbV9K5xSgcW3viuTUoUlOHjZfHdHyEZRaeAz+7auvcPmnIfq
         V6dkK4HZoSKZQ==
From:   Christian Brauner <brauner@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/3] file: fix and simplify close_range()
Date:   Fri,  2 Apr 2021 14:35:45 +0200
Message-Id: <20210402123548.108372-1-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <00000000000069c40405be6bdad4@google.com>
References: <00000000000069c40405be6bdad4@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Hey,

This fixes the syzbot report that Dmitry took time to give a better
reproducer for. Debugging this showed we didn't recalculate the
current maximum fd number for CLOSE_RANGE_UNSHARE | CLOSE_RANGE_CLOEXEC
after we unshared the file descriptors table. So max_fd could exceed the
current fdtable maximum causing us to set excessive bits. As a concrete
example, let's say the user requested everything from fd 4 to ~0UL to be
closed and their current fdtable size is 256 with their highest open fd
being 4. With CLOSE_RANGE_UNSHARE the caller will end up with a new
fdtable which has room for 64 file descriptors since that is the lowest
fdtable size we accept. But now max_fd will still point to 255 and needs
to be adjusted.
Fix this and simplify the logic in close_range(), getting rid of the
double-checking of max_fd and the convoluted logic around that.
(There some data on how close_range() is currently used in userspace
 which I've mentioned in the original thread. It's interesting as most
 users have switched to CLOSE_RANGE_CLOEXEC pretty quickly apart from
 those where a lot of fds need to be closed and it isn't clear when or
 if exec happens (e.g. systemd and the massive amounts of fds it can
 inherit due to socket activation).)
I've stuffed it in a branch at 
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=fs/close_range

I just didn't have time to get back to tweak the fix sooner than today.
A version of this has been sitting in linux-next for a while though.
If there's no braino from my side I'd like to get this to Linus rather
sooner than later so the bug is fixed as it's been some time now.

Thanks!
Christian

Christian Brauner (3):
  file: fix close_range() for unshare+cloexec
  file: let pick_file() tell caller it's done
  file: simplify logic in __close_range()

 fs/file.c | 85 +++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 28 deletions(-)


base-commit: 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b
-- 
2.27.0

