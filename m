Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE47260368D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Oct 2022 01:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJRXOG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 19:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiJRXOD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 19:14:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDE9D9957;
        Tue, 18 Oct 2022 16:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F9FAB8218A;
        Tue, 18 Oct 2022 23:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FC6C433D7;
        Tue, 18 Oct 2022 23:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1666134839;
        bh=Bwa4jweO9boJ1ae2H8vPdpx5UbQEya05ZuGsjBJ9/yI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BNa8qEh/TV4+nuKBpx1Hv0FYGYDerl3JL2iWAf4uVpPzJGN2HdF0w9hwY/Akbu7E8
         EziGaaQ0Pb+Nh7UCdiRAi/jGPRYoW0tLYXI5gqK4S1il98BMOwORNZt4j41SWtok9O
         jN43wjoRyKKyHE33dz4JX57cqgf8P4XaQYHBmr4M=
Date:   Tue, 18 Oct 2022 16:13:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: Re: [PATCH v3] proc: report open files as size in stat() for
 /proc/pid/fd
Message-Id: <20221018161357.4891fcdb94ecc63035b6792a@linux-foundation.org>
In-Reply-To: <20221018045844.37697-1-ivan@cloudflare.com>
References: <20221018045844.37697-1-ivan@cloudflare.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 17 Oct 2022 21:58:44 -0700 Ivan Babrou <ivan@cloudflare.com> wrote:

> v3: Made use of bitmap_weight() to count the bits.

Thanks, I queued the below delta:

--- a/fs/proc/fd.c~proc-report-open-files-as-size-in-stat-for-proc-pid-fd-v3
+++ a/fs/proc/fd.c
@@ -283,7 +283,7 @@ static int proc_readfd_count(struct inod
 {
 	struct task_struct *p = get_proc_task(inode);
 	struct fdtable *fdt;
-	unsigned int i, size, open_fds = 0;
+	unsigned int open_fds = 0;
 
 	if (!p)
 		return -ENOENT;
@@ -293,10 +293,7 @@ static int proc_readfd_count(struct inod
 		rcu_read_lock();
 
 		fdt = files_fdtable(p->files);
-		size = fdt->max_fds;
-
-		for (i = size / BITS_PER_LONG; i > 0;)
-			open_fds += hweight64(fdt->open_fds[--i]);
+		open_fds = bitmap_weight(fdt->open_fds, fdt->max_fds);
 
 		rcu_read_unlock();
 	}
_


Also, let's explicitly include the header file to avoid possible
accidents with unexpected Kconfigs.

--- a/fs/proc/fd.c~proc-report-open-files-as-size-in-stat-for-proc-pid-fd-v3-fix
+++ a/fs/proc/fd.c
@@ -7,6 +7,7 @@
 #include <linux/namei.h>
 #include <linux/pid.h>
 #include <linux/ptrace.h>
+#include <linux/bitmap.h>
 #include <linux/security.h>
 #include <linux/file.h>
 #include <linux/seq_file.h>
_

