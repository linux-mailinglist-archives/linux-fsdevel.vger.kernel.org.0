Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827AD320E57
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 23:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhBUWmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 17:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhBUWmZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 17:42:25 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3143C061574;
        Sun, 21 Feb 2021 14:41:44 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDxQ6-00Gpaa-Kc; Sun, 21 Feb 2021 22:41:42 +0000
Date:   Sun, 21 Feb 2021 22:41:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>
Subject: [git pull] RCU-safe common_lsm_audit()
Message-ID: <YDLhphz/PfGLTXfx@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

	Making common_lsm_audit() non-blocking; we don't really need to grab/drop
dentry in there - rcu_read_lock() is enough.  There's a couple of followups
using that to simplify the logics in selinux, but those hadn't soaked in -next
yet, so they'll have to go in next window.

The following changes since commit d36a1dd9f77ae1e72da48f4123ed35627848507d:

  dump_common_audit_data(): fix racy accesses to ->d_name (2021-01-16 15:11:35 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.audit

for you to fetch changes up to 23d8f5b684fc30126b7708cad38b753eaa078b3e:

  make dump_common_audit_data() safe to be called from RCU pathwalk (2021-01-16 15:12:08 -0500)

----------------------------------------------------------------
Al Viro (2):
      new helper: d_find_alias_rcu()
      make dump_common_audit_data() safe to be called from RCU pathwalk

 fs/dcache.c            | 25 +++++++++++++++++++++++++
 include/linux/dcache.h |  2 ++
 security/lsm_audit.c   |  5 +++--
 3 files changed, 30 insertions(+), 2 deletions(-)
