Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDBD242EF8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 21:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHLTPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 15:15:33 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49286 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgHLTPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:15:33 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id F3D3A20B4908;
        Wed, 12 Aug 2020 12:15:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F3D3A20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597259732;
        bh=Hiear1v4GobLaU9znuOPHWsMywwhRxx4MtQ6hAHBa2w=;
        h=From:To:Cc:Subject:Date:From;
        b=YVR+Tjshw4unUBqGDV6vCVki9iDJVhq87Gu7wRiW1Gje7qDYJE1i+5bnxU4BqRByy
         vlHX8g0C0V6Oxh47TKTBNvjHHEOXOJSOhOcbeuDO7uQDE48GtxHkidtluG0iHYa+77
         04KeUfm3G6y2eierew8AFycxKJ6lq66xeYuiTN5w=
From:   Daniel Burgener <dburgener@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, omosnace@redhat.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2 0/4] Update SELinuxfs out of tree and then swapover
Date:   Wed, 12 Aug 2020 15:15:21 -0400
Message-Id: <20200812191525.1120850-1-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v2: Clean up commit messages to accurately reflect current scope of
changes

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

 security/selinux/selinuxfs.c | 200 +++++++++++++++++++++++++++--------
 1 file changed, 158 insertions(+), 42 deletions(-)

-- 
2.25.4

