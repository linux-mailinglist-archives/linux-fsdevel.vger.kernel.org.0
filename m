Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE33F22510F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jul 2020 12:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGSKFf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 06:05:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27305 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726012AbgGSKFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 06:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595153133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BU4zHRLNeLmtJp1vQ0m3cQQlG87+5cFcTzYcoDBrgTc=;
        b=JXBeYFSDkgJD/VF77gm/vn58nil5qpe6Dl6YxzgT4izEwcSZoDxTJfgE1WHk8TEk8HI7Mc
        S4Jy/PuHs/czi8jokbPTnEUB9OeIIJlwrjz+NJIIekynvp+6AiDfXbdbQvi406au489NbT
        mGl9NaCbRFlwBL2zaKKyohV53EJQtIg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-tTZzcga0No-9970HV4U0bA-1; Sun, 19 Jul 2020 06:05:31 -0400
X-MC-Unique: tTZzcga0No-9970HV4U0bA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3053F107ACCA;
        Sun, 19 Jul 2020 10:05:28 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-112-10.ams2.redhat.com [10.36.112.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C36AC710A8;
        Sun, 19 Jul 2020 10:05:16 +0000 (UTC)
From:   Adrian Reber <areber@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        =?UTF-8?q?Micha=C5=82=20C=C5=82api=C5=84ski?= 
        <mclapinski@google.com>, Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Adrian Reber <areber@redhat.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Serge Hallyn <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v6 0/7] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Date:   Sun, 19 Jul 2020 12:04:10 +0200
Message-Id: <20200719100418.2112740-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is v6 of the 'Introduce CAP_CHECKPOINT_RESTORE' patchset. The
changes to v5 are:

 * split patch dealing with /proc/self/exe into two patches:
   * first patch to enable changing it with CAP_CHECKPOINT_RESTORE
     and detailed history in the commit message
   * second patch changes -EINVAL to -EPERM
 * use kselftest_harness.h infrastructure for test
 * replace if (!capable(CAP_SYS_ADMIN) || !capable(CAP_CHECKPOINT_RESTORE))
   with if (!checkpoint_restore_ns_capable(&init_user_ns))

Adrian Reber (5):
  capabilities: Introduce CAP_CHECKPOINT_RESTORE
  pid: use checkpoint_restore_ns_capable() for set_tid
  pid_namespace: use checkpoint_restore_ns_capable() for ns_last_pid
  proc: allow access in init userns for map_files with
    CAP_CHECKPOINT_RESTORE
  selftests: add clone3() CAP_CHECKPOINT_RESTORE test

Nicolas Viennot (2):
  prctl: Allow local CAP_CHECKPOINT_RESTORE to change /proc/self/exe
  prctl: exe link permission error changed from -EINVAL to -EPERM

 fs/proc/base.c                                |   8 +-
 include/linux/capability.h                    |   6 +
 include/uapi/linux/capability.h               |   9 +-
 kernel/pid.c                                  |   2 +-
 kernel/pid_namespace.c                        |   2 +-
 kernel/sys.c                                  |  13 +-
 security/selinux/include/classmap.h           |   5 +-
 tools/testing/selftests/clone3/.gitignore     |   1 +
 tools/testing/selftests/clone3/Makefile       |   4 +-
 .../clone3/clone3_cap_checkpoint_restore.c    | 177 ++++++++++++++++++
 10 files changed, 212 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c

base-commit: d31958b30ea3b7b6e522d6bf449427748ad45822
-- 
2.26.2

