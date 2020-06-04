Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F141EEB7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jun 2020 22:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgFDUEf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jun 2020 16:04:35 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:54018 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729571AbgFDUEf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:04:35 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 6BDB5209AF;
        Thu,  4 Jun 2020 20:04:31 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 0/2] proc: use subset option to hide some top-level procfs entries
Date:   Thu,  4 Jun 2020 22:04:11 +0200
Message-Id: <20200604200413.587896-1-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Thu, 04 Jun 2020 20:04:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greetings!

Preface
-------
This patch set can be applied over:

git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git d35bec8a5788

Overview
--------
Directories and files can be created and deleted by dynamically loaded modules.
Not all of these files are virtualized and safe inside the container.

However, subset=pid is not enough because many containers wants to have
/proc/meminfo, /proc/cpuinfo, etc. We need a way to limit the visibility of
files per procfs mountpoint.

Introduced changes
------------------
Allow to specify the names of files and directories in the subset= parameter and
thereby make a whitelist of top-level permitted names.


Alexey Gladkov (2):
  proc: use subset option to hide some top-level procfs entries
  docs: proc: update documentation about subset= parameter

 Documentation/filesystems/proc.rst |  6 +++
 fs/proc/base.c                     | 15 +++++-
 fs/proc/generic.c                  | 75 +++++++++++++++++++++------
 fs/proc/inode.c                    | 18 ++++---
 fs/proc/internal.h                 | 12 +++++
 fs/proc/root.c                     | 81 ++++++++++++++++++++++++------
 include/linux/proc_fs.h            | 11 ++--
 7 files changed, 175 insertions(+), 43 deletions(-)

-- 
2.25.4

