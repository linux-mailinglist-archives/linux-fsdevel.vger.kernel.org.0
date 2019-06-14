Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 793C945A2E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 12:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfFNKRK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 06:17:10 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:51090 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfFNKRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:17:10 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5EAGObb038267;
        Fri, 14 Jun 2019 19:16:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Fri, 14 Jun 2019 19:16:24 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x5EAGHsZ038230
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 14 Jun 2019 19:16:24 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: [PATCH] kexec: Bail out upon SIGKILL when allocating memory.
To:     Eric Biederman <ebiederm@xmission.com>
References: <000000000000a861f6058b2699e0@google.com>
 <000000000000c0103a058b2ba0ec@google.com>
Cc:     syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <993c9185-d324-2640-d061-bed2dd18b1f7@I-love.SAKURA.ne.jp>
Date:   Fri, 14 Jun 2019 19:16:18 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <000000000000c0103a058b2ba0ec@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot found that a thread can stall for minutes inside kexec_load() after
that thread was killed by SIGKILL [1]. It turned out that the reproducer
was trying to allocate 2408MB of memory using kimage_alloc_page() from
kimage_load_normal_segment(). Let's check for SIGKILL before doing memory
allocation.

[1] https://syzkaller.appspot.com/bug?id=a0e3436829698d5824231251fad9d8e998f94f5e

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
---
 kernel/kexec_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index fd5c95f..2b25d95 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -302,6 +302,8 @@ static struct page *kimage_alloc_pages(gfp_t gfp_mask, unsigned int order)
 {
 	struct page *pages;
 
+	if (fatal_signal_pending(current))
+		return NULL;
 	pages = alloc_pages(gfp_mask & ~__GFP_ZERO, order);
 	if (pages) {
 		unsigned int count, i;
-- 
1.8.3.1

