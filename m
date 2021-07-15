Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA6F3C9582
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 03:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbhGOBRf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 21:17:35 -0400
Received: from foss.arm.com ([217.140.110.172]:45128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231165AbhGOBRf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:17:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FFCC12FC;
        Wed, 14 Jul 2021 18:14:42 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 770073F7D8;
        Wed, 14 Jul 2021 18:14:37 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>
Subject: [PATCH v7 4/5] lib/test_printf.c: split write-beyond-buffer check in two
Date:   Thu, 15 Jul 2021 09:14:06 +0800
Message-Id: <20210715011407.7449-5-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715011407.7449-1-justin.he@arm.com>
References: <20210715011407.7449-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Before each invocation of vsnprintf(), do_test() memsets the entire
allocated buffer to a sentinel value. That buffer includes leading and
trailing padding which is never included in the buffer area handed to
vsnprintf (spaces merely for clarity):

  pad  test_buffer      pad
  **** **************** ****

Then vsnprintf() is invoked with a bufsize argument <=
BUF_SIZE. Suppose bufsize=10, then we'd have e.g.

 |pad |   test_buffer    |pad |
  **** pizza0 **** ****** ****
 A    B      C    D           E

where vsnprintf() was given the area from B to D.

It is obviously a bug for vsnprintf to touch anything between A and B
or between D and E. The former is checked for as one would expect. But
for the latter, we are actually a little stricter in that we check the
area between C and E.

Split that check in two, providing a clearer error message in case it
was a genuine buffer overrun and not merely a write within the
provided buffer, but after the end of the generated string.

So far, no part of the vsnprintf() implementation has had any use for
using the whole buffer as scratch space, but it's not unreasonable to
allow that, as long as the result is properly nul-terminated and the
return value is the right one. However, it is somewhat unusual, and
most %<something> won't need this, so keep the [C,D] check, but make
it easy for a later patch to make that part opt-out for certain tests.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Tested-by: Jia He <justin.he@arm.com>
Signed-off-by: Jia He <justin.he@arm.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 lib/test_printf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/test_printf.c b/lib/test_printf.c
index 8ac71aee46af..cabdf9f5fd15 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -78,12 +78,17 @@ do_test(int bufsize, const char *expect, int elen,
 		return 1;
 	}
 
-	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE + PAD_SIZE - (written + 1))) {
+	if (memchr_inv(test_buffer + written + 1, FILL_CHAR, bufsize - (written + 1))) {
 		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond the nul-terminator\n",
 			bufsize, fmt);
 		return 1;
 	}
 
+	if (memchr_inv(test_buffer + bufsize, FILL_CHAR, BUF_SIZE + PAD_SIZE - bufsize)) {
+		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote beyond buffer\n", bufsize, fmt);
+		return 1;
+	}
+
 	if (memcmp(test_buffer, expect, written)) {
 		pr_warn("vsnprintf(buf, %d, \"%s\", ...) wrote '%s', expected '%.*s'\n",
 			bufsize, fmt, test_buffer, written, expect);
-- 
2.17.1

