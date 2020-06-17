Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2591FCB0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 12:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgFQKlZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 06:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgFQKlY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:41:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6198EC06174E;
        Wed, 17 Jun 2020 03:41:23 -0700 (PDT)
Received: from [5.158.153.53] (helo=g2noscherz.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jlVVJ-00073K-M2; Wed, 17 Jun 2020 12:41:13 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] fs: remove retry loop
Date:   Wed, 17 Jun 2020 12:46:57 +0206
Message-Id: <20200617104058.14902-1-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

This patch removes the last retry loop in VFS. It is partially
reverting

   commit d3ef3d7351cc ("fs: mnt_want_write speedup")

by re-introducing per-cpu spinlocks for each mount. The patch
includes benchmark results in the diffstat section to show that the
previous optimization work is not undone.

I would have liked to use a percpu_rw_semaphore per mount instead
of the many spinlocks. However, percpu_rw_semaphore can sleep, which
is a problem for sb_prepare_remount_readonly() since it needs to
take the spinlock in @mount_lock in order to iterate @sb->s_mounts.
Perhaps using a mutex to sychronize @sb->s_mounts is an option. I am
not sure. That is why this is an RFC.

I am suggesting this partial revert because it removes the retry
loop and does not show any obvious negative benchmark effects.

John Ogness (1):
  fs/namespace.c: use spinlock instead of busy loop

 fs/mount.h     |   7 +++
 fs/namespace.c | 118 +++++++++++++++++++++++++++++++++----------------
 2 files changed, 86 insertions(+), 39 deletions(-)

-- 
2.20.1

