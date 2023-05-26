Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82877712FF7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 May 2023 00:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbjEZWWv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 18:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242588AbjEZWWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 18:22:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC2A9E;
        Fri, 26 May 2023 15:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=SHkCwnoLOgnVuVhD20vulZh61NLbbufsccKwdmPmKe0=; b=ZVTTDYMv5DZ18vLNN631PL2Hc6
        RBK1fTpo0SJpvaC1HRR8H4tMN8NeRw61Xg6HzrcddCkECaU7Uzynq+MtPhsZ6zYbf9C+Sm2I/dlYg
        ODiS2hgc/KY16lhXZ+CsGTLXdz/n+YxrPqDMrp7CYbEW7vf1rfuIMjWV2OVVTMxvOEpDxVTYIA3HI
        jVq3ueGqNi3pamCmyKNGVHBoT/cIZhSQojGFK7HJwj12bmEl4mK2r9iryVC4W3hxPsldLvYnKf46j
        CKCyRXTjtFN1FOZOEzFMjY2PScnhTaSIq05z3QbDhemyQ8HDAvaxtS+NL9rk9gRQVkAmm4VP41MhK
        U3dV7iUg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q2fp1-0047Uk-2H;
        Fri, 26 May 2023 22:22:07 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        dave.hansen@intel.com, arnd@arndb.de, bp@alien8.de,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        hpa@zytor.com, luto@kernel.org, peterz@infradead.org,
        brgerst@gmail.com, christophe.jaillet@wanadoo.fr,
        kirill.shutemov@linux.intel.com, jroedel@suse.de
Cc:     j.granados@samsung.com, akpm@linux-foundation.org,
        willy@infradead.org, linux-parisc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 1/2] sysctl: remove empty dev table
Date:   Fri, 26 May 2023 15:22:05 -0700
Message-Id: <20230526222207.982107-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230526222207.982107-1-mcgrof@kernel.org>
References: <20230526222207.982107-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that all the dev sysctls have been moved out we can remove the
dev sysctl base directory. We don't need to create base directories,
they are created for you as if using 'mkdir -p' with register_syctl()
and register_sysctl_init(). For details refer to sysctl_mkdir_p()
usage.

We save 90 bytes with this changes:

./scripts/bloat-o-meter vmlinux.2.remove-sysctl-table vmlinux.3-remove-dev-table
add/remove: 0/1 grow/shrink: 0/1 up/down: 0/-90 (-90)
Function                                     old     new   delta
sysctl_init_bases                            111      85     -26
dev_table                                     64       -     -64
Total: Before=21257057, After=21256967, chg -0.00%

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/sysctl.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index fa2aa8bd32b6..a7fdb828afb6 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2344,16 +2344,11 @@ static struct ctl_table debug_table[] = {
 	{ }
 };
 
-static struct ctl_table dev_table[] = {
-	{ }
-};
-
 int __init sysctl_init_bases(void)
 {
 	register_sysctl_init("kernel", kern_table);
 	register_sysctl_init("vm", vm_table);
 	register_sysctl_init("debug", debug_table);
-	register_sysctl_init("dev", dev_table);
 
 	return 0;
 }
-- 
2.39.2

