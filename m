Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C82D31D696
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 09:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhBQIaS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 03:30:18 -0500
Received: from raptor.unsafe.ru ([5.9.43.93]:60124 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231777AbhBQIaS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 03:30:18 -0500
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-94-113-225-162.net.upcbroadband.cz [94.113.225.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id C5B1C209D4;
        Wed, 17 Feb 2021 08:21:55 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Subject: [RESEND PATCH v4 0/3] proc: Relax check of mount visibility
Date:   Wed, 17 Feb 2021 09:21:40 +0100
Message-Id: <cover.1613550081.git.gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Wed, 17 Feb 2021 08:21:56 +0000 (UTC)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If only the dynamic part of procfs is mounted (subset=pid), then there is no
need to check if procfs is fully visible to the user in the new user namespace.

Changelog
---------
v4:
* Set SB_I_DYNAMIC only if pidonly is set.
* Add an error message if subset=pid is canceled during remount.

v3:
* Add 'const' to struct cred *mounter_cred (fix kernel test robot warning).

v2:
* cache the mounters credentials and make access to the net directories
  contingent of the permissions of the mounter of procfs.

--

Alexey Gladkov (3):
  proc: Relax check of mount visibility
  proc: Show /proc/self/net only for CAP_NET_ADMIN
  proc: Disable cancellation of subset=pid option

 fs/namespace.c          | 27 ++++++++++++++++-----------
 fs/proc/proc_net.c      |  8 ++++++++
 fs/proc/root.c          | 29 ++++++++++++++++++++++-------
 include/linux/fs.h      |  1 +
 include/linux/proc_fs.h |  1 +
 5 files changed, 48 insertions(+), 18 deletions(-)

-- 
2.29.2

