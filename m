Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED653393CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 17:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhCLQmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 11:42:40 -0500
Received: from raptor.unsafe.ru ([5.9.43.93]:49754 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232949AbhCLQmE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:42:04 -0500
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-94-113-225-162.net.upcbroadband.cz [94.113.225.162])
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 3173340C98;
        Fri, 12 Mar 2021 16:42:00 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v6 0/5] proc: subset=pid: Relax check of mount visibility
Date:   Fri, 12 Mar 2021 17:41:43 +0100
Message-Id: <cover.1615567183.git.gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.29.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (raptor.unsafe.ru [0.0.0.0]); Fri, 12 Mar 2021 16:42:01 +0000 (UTC)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow to mount procfs with subset=pid option even if the entire procfs
is not fully accessible to the mounter.

Changelog
---------
v6:
* Add documentation about procfs mount restrictions.
* Reorder commits for better review.

v4:
* Set SB_I_DYNAMIC only if pidonly is set.
* Add an error message if subset=pid is canceled during remount.

v3:
* Add 'const' to struct cred *mounter_cred (fix kernel test robot warning).

v2:
* cache the mounters credentials and make access to the net directories
  contingent of the permissions of the mounter of procfs.

--

Alexey Gladkov (5):
  docs: proc: add documentation about mount restrictions
  proc: subset=pid: Show /proc/self/net only for CAP_NET_ADMIN
  proc: Disable cancellation of subset=pid option
  proc: Relax check of mount visibility
  docs: proc: add documentation about relaxing visibility restrictions

 Documentation/filesystems/proc.rst | 15 +++++++++++++++
 fs/namespace.c                     | 30 ++++++++++++++++++------------
 fs/proc/proc_net.c                 |  8 ++++++++
 fs/proc/root.c                     | 24 +++++++++++++++++++-----
 include/linux/fs.h                 |  1 +
 include/linux/proc_fs.h            |  1 +
 6 files changed, 62 insertions(+), 17 deletions(-)

-- 
2.29.3

