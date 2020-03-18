Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA518A8F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 00:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCRXGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 19:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRXGO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 19:06:14 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E3B32076C;
        Wed, 18 Mar 2020 23:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584572773;
        bh=DS0D+tocJs2LDNye58/Gr+XbzFvirzr5jXysm6id+YE=;
        h=From:To:Cc:Subject:Date:From;
        b=M85x+4MJY+9uHCryuC4dwSYkCTvNZU4kfeoab+wimt2w+k5r1eP5+7bmAlUntlJ7A
         KUc52V7DnsXk2PgWvDZKj8MCs9E4Y1NfWuw1jdyenCgly0K56YSC/LsrH9ztWUsMMx
         3Q06aBaeK7nfQeJpTG9EX4sfVUnyIuoNPV6UrhRU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        NeilBrown <neilb@suse.com>
Subject: [PATCH v4 0/5] module autoloading fixes and cleanups
Date:   Wed, 18 Mar 2020 16:05:10 -0700
Message-Id: <20200318230515.171692-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series fixes a bug where request_module() was reporting success to
kernel code when module autoloading had been completely disabled via
'echo > /proc/sys/kernel/modprobe'.

It also addresses the issues raised on the original thread
(https://lkml.kernel.org/lkml/20200310223731.126894-1-ebiggers@kernel.org/T/#u)
by documenting the modprobe sysctl, adding a self-test for the empty
path case, and downgrading a user-reachable WARN_ONCE().

Changed since v3:
  - Added Fixes tag to the fs/filesystems.c patch, and mentioned why the
    warning is continued to be printed once only.

Changed since v2:
  - Adjusted the new documentation to avoid implicitly bringing up
    module aliases, which are a more complex topic.
  - Split the selftest patch into two patches, one to fix the test
    numbering bug and one to add the new tests.

Changed since v1:
  - Added patches to address the other issues raised on the thread.

Eric Biggers (5):
  kmod: make request_module() return an error when autoloading is
    disabled
  fs/filesystems.c: downgrade user-reachable WARN_ONCE() to
    pr_warn_once()
  docs: admin-guide: document the kernel.modprobe sysctl
  selftests: kmod: fix handling test numbers above 9
  selftests: kmod: test disabling module autoloading

 Documentation/admin-guide/sysctl/kernel.rst | 25 +++++++++++-
 fs/filesystems.c                            |  4 +-
 kernel/kmod.c                               |  4 +-
 tools/testing/selftests/kmod/kmod.sh        | 43 +++++++++++++++++++--
 4 files changed, 68 insertions(+), 8 deletions(-)


base-commit: 5076190daded2197f62fe92cf69674488be44175
-- 
2.25.1

