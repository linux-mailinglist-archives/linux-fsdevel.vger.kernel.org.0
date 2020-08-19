Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91E2324A750
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 21:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgHST7m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 15:59:42 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39324 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHST7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:59:42 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id C5D8620B4908;
        Wed, 19 Aug 2020 12:59:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5D8620B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597867181;
        bh=J2L+Z0jTl2KqUCnQVGdnqWFslScIDnVerECXRgcn3+o=;
        h=From:To:Cc:Subject:Date:From;
        b=ek8H9M4ataWyd0ga7FdtVy/XTjX452X0XsRq3rL3HewlsL3klIOr77U3JAZtLcp17
         z5ixAqnyDdipUZukOW4jcfYivYjRoGW1mFyEi4IFaUVtfw5jBMvtqkKg/NNjdC1/hk
         QjpdGFxRU4F8l1EavXEdPOo6akaSb8fhGV6bG4FQ=
From:   Daniel Burgener <dburgener@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, omosnace@redhat.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH v3 0/4] Update SELinuxfs out of tree and then swapover
Date:   Wed, 19 Aug 2020 15:59:31 -0400
Message-Id: <20200819195935.1720168-1-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v2: Clean up commit messages to accurately reflect current scope of
changes
v3: Remove all policy_capabilities directory manipulation.  Switch from
vfs_rename() to d_exchange() for directory exchanging.  Use appropriate
comment style.  Reuse inodes for temporary directories.

In the current implementation, on policy load /sys/fs/selinux is updated
by deleting the previous contents of
/sys/fs/selinux/{class,booleans} and then recreating them.  This means
that there is a period of time when the contents of these directories do
not exist which can cause race conditions as userspace relies on them for
information about the policy.  In addition, it means that error recovery
in the event of failure is challenging.

This patch series follows the design outlined by Al Viro in a previous
e-mail to the list[1].  This approach is to first create the new
directory structures out of tree, then to perform the swapover, and
finally to delete the old directories.  Not handled in this series is
error recovery in the event of failure.

Error recovery in the selinuxfs recreation is unhandled in the current
code, so this series will not cause any regression in this regard.
Handling directory recreation in this manner is a prerequisite to make
proper error handling possible.

In order to demonstrate the race condition that this series fixes, you
can use the following commands:

while true; do cat /sys/fs/selinux/class/service/perms/status
>/dev/null; done &
while true; do load_policy; done;

In the existing code, this will display errors fairly often as the class
lookup fails.  (In normal operation from systemd, this would result in a
permission check which would be allowed or denied based on policy settings
around unknown object classes.) After applying this patch series you
should expect to no longer see such error messages.

This series is relative to https://patchwork.kernel.org/patch/11705743/,
Stephen Smalley's series to split policy loading into a prep and commit.

[1] https://lore.kernel.org/selinux/20181002155810.GP32577@ZenIV.linux.org.uk/

Daniel Burgener (4):
  selinux: Create function for selinuxfs directory cleanup
  selinux: Refactor selinuxfs directory populating functions
  selinux: Standardize string literal usage for selinuxfs directory
    names
  selinux: Create new booleans and class dirs out of tree

 security/selinux/selinuxfs.c | 190 +++++++++++++++++++++++++++--------
 1 file changed, 148 insertions(+), 42 deletions(-)

-- 
2.25.4

