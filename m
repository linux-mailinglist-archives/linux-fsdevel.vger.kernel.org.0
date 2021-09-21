Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3714133B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Sep 2021 15:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbhIUNGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Sep 2021 09:06:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:53386 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhIUNGK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Sep 2021 09:06:10 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D69021FED6;
        Tue, 21 Sep 2021 13:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632229480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hl/MOmvXomLoOTDJpYFB1eX0OKjWBWw5KeY0f7BZBk8=;
        b=DDAn3qOj3hI0wsKV+6nC7kwpEoKuHTKIVo5QpbT/czkSEyqcAejn81xt4A/suCV0oxFEmo
        Cn0pouydQemRsd5QaLfWJwxS7TpPEqOzRGwkOr1NxIRaR9LnAwtCDmsgS/XIUHI0U0t4Mu
        X++nb53QCf8CzcKprEebYeluK4pye/4=
Received: from g78.suse.de (unknown [10.163.24.38])
        by relay2.suse.de (Postfix) with ESMTP id BE194A3B85;
        Tue, 21 Sep 2021 13:04:39 +0000 (UTC)
From:   Richard Palethorpe <rpalethorpe@suse.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Richard Palethorpe <rpalethorpe@suse.com>,
        linux-api@vger.kernel.org, linux-aio@kvack.org,
        y2038@lists.linaro.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, ltp@lists.linux.it
Subject: [PATCH] aio: Wire up compat_sys_io_pgetevents_time64 for x86
Date:   Tue, 21 Sep 2021 14:01:27 +0100
Message-Id: <20210921130127.24131-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The LTP test io_pgetevents02 fails in 32bit compat mode because an
nr_max of -1 appears to be treated as a large positive integer. This
causes pgetevents_time64 to return an event. The test expects the call
to fail and errno to be set to EINVAL.

Using the compat syscall fixes the issue.

Fixes: 7a35397f8c06 ("io_pgetevents: use __kernel_timespec")
Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 960a021d543e..0985d8333368 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -420,7 +420,7 @@
 412	i386	utimensat_time64	sys_utimensat
 413	i386	pselect6_time64		sys_pselect6			compat_sys_pselect6_time64
 414	i386	ppoll_time64		sys_ppoll			compat_sys_ppoll_time64
-416	i386	io_pgetevents_time64	sys_io_pgetevents
+416	i386	io_pgetevents_time64	sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	i386	recvmmsg_time64		sys_recvmmsg			compat_sys_recvmmsg_time64
 418	i386	mq_timedsend_time64	sys_mq_timedsend
 419	i386	mq_timedreceive_time64	sys_mq_timedreceive
-- 
2.31.1

