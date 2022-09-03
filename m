Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B235ABD7D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Sep 2022 08:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbiICGnj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 3 Sep 2022 02:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiICGni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:43:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5B78FD50
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Sep 2022 23:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662187416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zZUo4Yh/oc1vNFvxaSNW3YUhPsCaAqVSFhhyRBZevNo=;
        b=Kaqh/fvdaJVsYgFXyk1ZTdWQv4vY7rgHEGaVpYCV2cn0jDe50CnUOC1jxUj4JLRpdrCztA
        YumzwJAHomXyJVva3GZFbkrCMfAVHPJ76kCuD3JjmvIUHlc53YwYY4P2qE1D7OjDPkGfvq
        2taq2qbc4zr/a9p4BDtOkvBgQ7cv9so=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-Sqaui8VDPACHMNd1m7TfYg-1; Sat, 03 Sep 2022 02:43:33 -0400
X-MC-Unique: Sqaui8VDPACHMNd1m7TfYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88DE8805B9A;
        Sat,  3 Sep 2022 06:43:32 +0000 (UTC)
Received: from localhost (unknown [10.40.192.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6FAFAC15BBD;
        Sat,  3 Sep 2022 06:43:31 +0000 (UTC)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Will Deacon <will@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Stephen Kitt <steve@sk2.org>, Rob Herring <robh@kernel.org>,
        Joel Savitz <jsavitz@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        =?UTF-8?q?Renaud=20M=C3=A9trich?= <rmetrich@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, Qi Guo <qguo@redhat.com>
Subject: [PATCH] core_pattern: add CPU specifier
Date:   Sat,  3 Sep 2022 08:43:30 +0200
Message-Id: <20220903064330.20772-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Statistically, in a large deployment regular segfaults may indicate a CPU issue.

Currently, it is not possible to find out what CPU the segfault happened on.
There are at least two attempts to improve segfault logging with this regard,
but they do not help in case the logs rotate.

Hence, lets make sure it is possible to permanently record a CPU
the task ran on using a new core_pattern specifier.

Suggested-by: Renaud Métrich <rmetrich@redhat.com>
Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 Documentation/admin-guide/sysctl/kernel.rst | 1 +
 fs/coredump.c                               | 5 +++++
 include/linux/coredump.h                    | 1 +
 3 files changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 835c8844bba48..b566fff04946b 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -169,6 +169,7 @@ core_pattern
 	%f      	executable filename
 	%E		executable path
 	%c		maximum size of core file by resource limit RLIMIT_CORE
+	%C		CPU the task ran on
 	%<OTHER>	both are dropped
 	========	==========================================
 
diff --git a/fs/coredump.c b/fs/coredump.c
index a8661874ac5b6..166d1f84a9b17 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -325,6 +325,10 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
 				err = cn_printf(cn, "%lu",
 					      rlimit(RLIMIT_CORE));
 				break;
+			/* CPU the task ran on */
+			case 'C':
+				err = cn_printf(cn, "%d", cprm->cpu);
+				break;
 			default:
 				break;
 			}
@@ -535,6 +539,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 		 */
 		.mm_flags = mm->flags,
 		.vma_meta = NULL,
+		.cpu = raw_smp_processor_id(),
 	};
 
 	audit_core_dumps(siginfo->si_signo);
diff --git a/include/linux/coredump.h b/include/linux/coredump.h
index 08a1d3e7e46d0..191dcf5af6cb9 100644
--- a/include/linux/coredump.h
+++ b/include/linux/coredump.h
@@ -22,6 +22,7 @@ struct coredump_params {
 	struct file *file;
 	unsigned long limit;
 	unsigned long mm_flags;
+	int cpu;
 	loff_t written;
 	loff_t pos;
 	loff_t to_skip;
-- 
2.37.2

