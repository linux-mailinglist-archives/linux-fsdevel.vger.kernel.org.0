Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83121FF3AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 15:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgFRNtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 09:49:15 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32694 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727921AbgFRNtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592488152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=DUQ6ngZQh7gXiB43u6OrO1UGnUYbS+2l9T1n8YlMUQ0=;
        b=CQ/+X5vbbYjyxDrffpr7SHIYhPQcJ9nMjgMJ4z6BYhvJKXEqNv6ub3C2iV+jkhKQR6epsn
        I8CgqhI9F4tvHiRB25FQW/Bq74JD2AgrsANJrn937IOf/88giDIO9vC6BOE04SKrLxs0HN
        glsJO+saofmRqT8dIfNIxSqQ2kwkkHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-929ZvOwgOPOcHf0IkOhyBg-1; Thu, 18 Jun 2020 09:49:09 -0400
X-MC-Unique: 929ZvOwgOPOcHf0IkOhyBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AD08107ACF4;
        Thu, 18 Jun 2020 13:49:05 +0000 (UTC)
Received: from dcbz.redhat.com (ovpn-112-197.ams2.redhat.com [10.36.112.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6837D1E2264;
        Thu, 18 Jun 2020 13:48:51 +0000 (UTC)
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
Subject: [PATCH v3 0/3] capabilities: Introduce CAP_CHECKPOINT_RESTORE
Date:   Thu, 18 Jun 2020 15:48:22 +0200
Message-Id: <20200618134825.487467-1-areber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is v3 of the 'Introduce CAP_CHECKPOINT_RESTORE' patchset. There
is only one change from v2:

 * made if condition easier to read as requested by Cyrill

Besides that there were no further comments on the changes proposed in
this patchset.

There was the discussion from Andrei that PTRACE_O_SUSPEND_SECCOMP is
also needed for checkpointing. CRIU already has the possibility to
detect if a process is using seccomp and could so tell the user that
it cannot checkpoint a process if the process is using seccomp. As
seccomp has not come up in the requests from users to use CRIU as
non-root so far and as there was some push back from Christian to allow
PTRACE_O_SUSPEND_SECCOMP if CAP_CHECKPOINT_RESTORE is set I would like
to leave this open for the future.

Another discussion was around relaxing the existing map_files check from
capable() to ns_capable() or even completely removing it. Even if this
happens we still need CAP_CHECKPOINT_RESTORE and the removal or change
to ns_capable() is not blocked by this patchset.

Besides that there was nothing speaking against CAP_CHECKPOINT_RESTORE
during the v2 discussions.

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


base-commit: 5fcb9628fd1227a5f11d87171cb1b8b5c414d9d9
-- 
2.26.2

