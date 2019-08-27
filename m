Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF089F3F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 22:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731390AbfH0UVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 16:21:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:47094 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731178AbfH0UVV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:21:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A53C3B61F;
        Tue, 27 Aug 2019 20:21:19 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Allison Randal <allison@lohutok.net>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] fs: always build llseek.
Date:   Tue, 27 Aug 2019 22:21:06 +0200
Message-Id: <80b1955b86fb81e4642881d498068b5a540ef029.1566936688.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1566936688.git.msuchanek@suse.de>
References: <cover.1566936688.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

64bit !COMPAT does not build because the llseek syscall is in the tables.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 fs/read_write.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 5bbf587f5bc1..9db56931eb26 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -331,7 +331,6 @@ COMPAT_SYSCALL_DEFINE3(lseek, unsigned int, fd, compat_off_t, offset, unsigned i
 }
 #endif
 
-#if !defined(CONFIG_64BIT) || defined(CONFIG_COMPAT)
 SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
 		unsigned long, offset_low, loff_t __user *, result,
 		unsigned int, whence)
@@ -360,7 +359,6 @@ SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
 	fdput_pos(f);
 	return retval;
 }
-#endif
 
 int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t count)
 {
-- 
2.22.0

