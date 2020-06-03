Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8CB1ED43A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 18:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgFCQYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 12:24:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53514 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726090AbgFCQYX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 12:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591201462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=K/e5rx/iSdIPyyr6wHaDjY9+WjqdNoTwnBgR1lFZZNw=;
        b=cn6HxHR/pDsnhIMBNnmS6ah+9MtFOWWsmypvfrje2CrKTu50/AzFRQMyGwX5ASxNskDmJt
        aSxop4wmNTDB9V4VDdJWY+u7SJMQBQgmnKpR/BKHxTbBxW+PmbRcbXG4mkKJfzZYGUBCRx
        dioW0IiTI+HjHaN6FqwL1HnQboVVxC8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-8L99PjuHMAmWPrd2pPycnA-1; Wed, 03 Jun 2020 12:24:20 -0400
X-MC-Unique: 8L99PjuHMAmWPrd2pPycnA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2FE1EC1B1;
        Wed,  3 Jun 2020 16:24:17 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-113-67.ams2.redhat.com [10.36.113.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CF2B19C71;
        Wed,  3 Jun 2020 16:24:07 +0000 (UTC)
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
Subject: [PATCH v2 0/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Date:   Wed,  3 Jun 2020 18:23:25 +0200
Message-Id: <20200603162328.854164-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is v2 of the 'Introduce CAP_CHECKPOINT_RESTORE' patchset. The
difference from v1 are:

 * Renamed CAP_RESTORE to CAP_CHECKPOINT_RESTORE
 * Added a test
 * Added details about CRIU's use of map_files
 * Allow changing /proc/self/exe link with CAP_CHECKPOINT_RESTORE

The biggest difference is that the patchset now provides all the
changes, which are necessary to use CRIU to checkpoint and restore a
process as non-root if CAP_CHECKPOINT_RESTORE is set.

Adrian Reber (2):
  capabilities: Introduce CAP_CHECKPOINT_RESTORE
  selftests: add clone3() CAP_CHECKPOINT_RESTORE test

Nicolas Viennot (1):
  prctl: Allow ptrace capable processes to change exe_fd

 fs/proc/base.c                                |   8 +-
 include/linux/capability.h                    |   6 +
 include/uapi/linux/capability.h               |   9 +-
 kernel/pid.c                                  |   2 +-
 kernel/pid_namespace.c                        |   2 +-
 kernel/sys.c                                  |  21 +-
 security/selinux/include/classmap.h           |   5 +-
 tools/testing/selftests/clone3/Makefile       |   4 +-
 .../clone3/clone3_cap_checkpoint_restore.c    | 203 ++++++++++++++++++
 9 files changed, 245 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c


base-commit: 48f99181fc118d82dc8bf6c7221ad1c654cb8bc2
-- 
2.26.2

