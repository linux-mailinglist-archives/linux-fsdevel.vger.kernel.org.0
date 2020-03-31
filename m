Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2697619890B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 02:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgCaAyM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Mar 2020 20:54:12 -0400
Received: from icp-osb-irony-out4.external.iinet.net.au ([203.59.1.220]:54738
        "EHLO icp-osb-irony-out4.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729019AbgCaAyM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:54:12 -0400
X-SMTP-MATCH: 0
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2C1BAA4lIJe/+im0XZmHgELHIFwC4I?=
 =?us-ascii?q?pgUAhEoREj04BAQEJizKFFIo+gXsKAQEBAQEBAQEBGxkBAgQBAYREgjQkNgc?=
 =?us-ascii?q?OAhABAQEFAQEBAQEFAwFthQpYhhpWKA0CGA4CSRaGESSteIEyGgKKKYEOKow?=
 =?us-ascii?q?xGnmBB4FHgTaCagGGW4JeBI1bGAyCd4cPRYEAliR3gkaXFR2PQgOMJ6cehX8?=
 =?us-ascii?q?JKYFYTS4KgyhPGI5Cjj03gTYBAY0mXwEB?=
X-IPAS-Result: =?us-ascii?q?A2C1BAA4lIJe/+im0XZmHgELHIFwC4IpgUAhEoREj04BA?=
 =?us-ascii?q?QEJizKFFIo+gXsKAQEBAQEBAQEBGxkBAgQBAYREgjQkNgcOAhABAQEFAQEBA?=
 =?us-ascii?q?QEFAwFthQpYhhpWKA0CGA4CSRaGESSteIEyGgKKKYEOKowxGnmBB4FHgTaCa?=
 =?us-ascii?q?gGGW4JeBI1bGAyCd4cPRYEAliR3gkaXFR2PQgOMJ6cehX8JKYFYTS4KgyhPG?=
 =?us-ascii?q?I5Cjj03gTYBAY0mXwEB?=
X-IronPort-AV: E=Sophos;i="5.72,326,1580745600"; 
   d="scan'208";a="238809157"
Received: from unknown (HELO mickey.themaw.net) ([118.209.166.232])
  by icp-osb-irony-out4.iinet.net.au with ESMTP; 31 Mar 2020 08:54:08 +0800
Subject: [PATCH v2 0/4] Fix stat() family ping/pong on expiring autofs mounts
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Mar 2020 08:54:07 +0800
Message-ID: <158561511964.23197.716188410829525903.stgit@mickey.themaw.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch series is meant to fix a case were a stat() family system
call is being done at the same time a mount point dentry is being
expired.

When this happens it results in a ping/pong of returning the stat() of
the mounted file system and stat() of the autofs file system.

What needs to be done here is ensure a consistent stat() return based
on the state of the mount at the time.

There are actually a number of cases and, unavoidably, there remains
inconsistency because stat family system calls are not meant to trigger
mounts to avoid mount storms. So they will still return the stat of the
autofs file system if not mounted and the stat of the mounted file
system if they are, including if they are being expired at the time of
the stat() call.

Some of these patches are based on other work that I'm doing as a
result of our recent discussions on the autofs kernel module. For
example the removal do_expire_wait() from autofs_d_manage() and
simplifying the called functions. And the last patch which adds
comments about cases of the autofs_mountpoint_changed() function.
In fact, as you though, there's not much left in autofs_d_manage()
in the endi. 

But I'm not finished with the series yet and I need to get this bug 
fixed.

Changes since v1.
- fix several grammatical mistakes.

---

Ian Kent (4):
      autofs: dont call do_expire_wait() in autofs_d_manage()
      autofs: remove rcu_walk parameter from autofs_expire_wait()
      vfs: check for autofs expiring dentry in follow_automount()
      autofs: add comment about autofs_mountpoint_changed()


 fs/autofs/autofs_i.h  |    2 +-
 fs/autofs/dev-ioctl.c |    2 +-
 fs/autofs/expire.c    |    5 +---
 fs/autofs/root.c      |   58 ++++++++++++++++++++++++++++++++-----------------
 fs/namei.c            |   13 +++++++++--
 5 files changed, 52 insertions(+), 28 deletions(-)

--
Ian
