Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5EEE18A8F9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 00:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgCRXGg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 19:06:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCRXGP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 19:06:15 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C36EE20772;
        Wed, 18 Mar 2020 23:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584572775;
        bh=pyfoelTFUrUS8nqrG9mSLUHYjidpQeeIpDUHP53gjl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8AP04gTBXOjxzF4km8U9zuui3lKYHUGGlBhXVxY7kAOk6pg/6g11nTfyqHxWFA8x
         W+cppg3wRVybvoenstFvJIaQeJsJg/jSf/ofDBk6rnTWoma3zxw5F8lX4YIEI8bWFg
         yzNOYEOVUsFday93oOH4XOBSxIYVnCzpay8/SqUE=
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
Subject: [PATCH v4 3/5] docs: admin-guide: document the kernel.modprobe sysctl
Date:   Wed, 18 Mar 2020 16:05:13 -0700
Message-Id: <20200318230515.171692-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318230515.171692-1-ebiggers@kernel.org>
References: <20200318230515.171692-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Document the kernel.modprobe sysctl in the same place that all the other
kernel.* sysctls are documented.  Make sure to mention how to use this
sysctl to completely disable module autoloading, and how this sysctl
relates to CONFIG_STATIC_USERMODEHELPER.

Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 25 ++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index def074807cee9..e3c15660ee5d9 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -49,7 +49,7 @@ show up in /proc/sys/kernel:
 - kexec_load_disabled
 - kptr_restrict
 - l2cr                        [ PPC only ]
-- modprobe                    ==> Documentation/debugging-modules.txt
+- modprobe
 - modules_disabled
 - msg_next_id		      [ sysv ipc ]
 - msgmax
@@ -444,6 +444,29 @@ l2cr: (PPC only)
 This flag controls the L2 cache of G3 processor boards. If
 0, the cache is disabled. Enabled if nonzero.
 
+modprobe:
+=========
+
+The path to the usermode helper for autoloading kernel modules, by
+default "/sbin/modprobe".  This binary is executed when the kernel
+requests a module.  For example, if userspace passes an unknown
+filesystem type to mount(), then the kernel will automatically request
+the corresponding filesystem module by executing this usermode helper.
+This usermode helper should insert the needed module into the kernel.
+
+This sysctl only affects module autoloading.  It has no effect on the
+ability to explicitly insert modules.
+
+If this sysctl is set to the empty string, then module autoloading is
+completely disabled.  The kernel will not try to execute a usermode
+helper at all, nor will it call the kernel_module_request LSM hook.
+
+If CONFIG_STATIC_USERMODEHELPER=y is set in the kernel configuration,
+then the configured static usermode helper overrides this sysctl,
+except that the empty string is still accepted to completely disable
+module autoloading as described above.
+
+Also see Documentation/debugging-modules.txt.
 
 modules_disabled:
 =================
-- 
2.25.1

