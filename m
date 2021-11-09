Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21E644B446
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Nov 2021 21:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244739AbhKIUuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Nov 2021 15:50:03 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:33726 "EHLO
        fanzine.igalia.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S244756AbhKIUuD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; s=20170329;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=GfjvBUEO6CHJKx4vDHWQYbiB8efYdnD/KZ9F5VdyVnA=;
        b=UuS+dG94ZFZVJLJDtZgHoPYWySpSY0y+5yAHA8dRU7mJb8SBudGviFzQI2OwdHjG2FcW4N8M7DFwj9lxcewuhWkDpOhYPBX5GiR7Y4vQghfZUDhCk+vO/IFkE0y8f/MS30rTsJCKZUuuT/A3KemjU19FZ+D4IzlWhQiJopLk4t8AHEe8U62PSe5ukCJH3kfamrKoqMVA3aV+E2wWn2sxi6Qvvsz0hPWx6QR9Vh5ot3VOJYatC1iKE0E5RMVYAteojHAH8DUAqrIZag9tSf0shwWpsnCayG4NhwgWCeNcErV0OS1uCt0OG7ayiuiOoMo5buQILUUAgB2rtvjgga4yOQ==;
Received: from 201-95-14-182.dsl.telesp.net.br ([201.95.14.182] helo=localhost)
        by fanzine.igalia.com with esmtpsa 
        (Cipher TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim)
        id 1mkXlT-0000Md-Af; Tue, 09 Nov 2021 21:30:44 +0100
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, feng.tang@intel.com,
        siglesias@igalia.com, kernel@gpiccoli.net, gpiccoli@igalia.com
Subject: [PATCH 3/3] panic: Allow printing extra panic information on kdump
Date:   Tue,  9 Nov 2021 17:28:48 -0300
Message-Id: <20211109202848.610874-4-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211109202848.610874-1-gpiccoli@igalia.com>
References: <20211109202848.610874-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently we have the "panic_print" parameter/sysctl to allow some extra
information to be printed in a panic event. On the other hand, the kdump
mechanism allows to kexec a new kernel to collect a memory dump for the
running kernel in case of panic.
Right now these options are incompatible: the user either sets the kdump
or makes use of "panic_print". The code path of "panic_print" isn't
reached when kdump is configured.

There are situations though in which this would be interesting: for
example, in systems that are very memory constrained, a handcrafted
tiny kernel/initrd for kdump might be used in order to only collect the
dmesg in kdump kernel. Even more common, systems with no disk space for
the full (compressed) memory dump might very well rely in this
functionality too, dumping only the dmesg with the additional information
provided by "panic_print".

So, this is what the patch does: allows both functionality to co-exist;
if "panic_print" is set and the system performs a kdump, the extra
information is printed on dmesg before the kexec. Some notes about the
design choices here:

(a) We could have introduced a sysctl or an extra bit on "panic_print"
to allow enabling the co-existence of kdump and "panic_print", but seems
that would be over-engineering; we have 3 cases, let's check how this
patch change things:

- if the user have kdump set and not "panic_print", nothing changes;
- if the user have "panic_print" set and not kdump, nothing changes;
- if both are enabled, now we print the extra information before kdump,
which is exactly the goal of the patch (and should be the goal of the
user, since they enabled both options).

(b) We assume that the code path won't return from __crash_kexec()
so we didn't guard against double execution of panic_print_sys_info().

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 kernel/panic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/panic.c b/kernel/panic.c
index 5da71fa4e5f1..439dbf93b406 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -243,6 +243,13 @@ void panic(const char *fmt, ...)
 	 */
 	kgdb_panic(buf);
 
+	/*
+	 * If we have a kdump kernel loaded, give a chance to panic_print
+	 * show some extra information on kernel log if it was set...
+	 */
+	if (kexec_crash_loaded())
+		panic_print_sys_info();
+
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
 	 * everything else.
-- 
2.33.1

