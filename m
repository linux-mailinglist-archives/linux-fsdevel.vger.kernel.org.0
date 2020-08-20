Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE9E124BFDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 15:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbgHTN4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 09:56:04 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:41962 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbgHTN4B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:56:01 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 510982052E;
        Thu, 20 Aug 2020 13:55:50 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 0/2] proc: Relax check of mount visibility
Date:   Thu, 20 Aug 2020 15:53:32 +0200
Message-Id: <cover.1597931457.git.gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Thu, 20 Aug 2020 13:55:54 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If only the dynamic part of procfs is mounted (subset=pid), then there is no
need to check if procfs is fully visible to the user in the new user namespace.

Changelog
---------

v3:
* Add 'const' to struct cred *mounter_cred (fix kernel test robot warning).

v2:
* cache the mounters credentials and make access to the net directories
  contingent of the permissions of the mounter of procfs.

Alexey Gladkov (2):
  proc: Relax check of mount visibility
  Show /proc/self/net only for CAP_NET_ADMIN

 fs/namespace.c          | 27 ++++++++++++++++-----------
 fs/proc/proc_net.c      |  8 ++++++++
 fs/proc/root.c          | 21 +++++++++++++++------
 include/linux/fs.h      |  1 +
 include/linux/proc_fs.h |  1 +
 5 files changed, 41 insertions(+), 17 deletions(-)

-- 
2.25.4

