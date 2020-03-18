Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4801618A8F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 00:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgCRXGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 19:06:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgCRXGQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 19:06:16 -0400
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3FDBA2076F;
        Wed, 18 Mar 2020 23:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584572775;
        bh=xmE3yElXSaLPkHmEr4QxRVGER8+rZ3BdqvEa3ZNkdF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBM+mtpjchueINOvzNZpxN2IDRCAxiG81X0PxlbMekTYiu9iXIIxqaIcKY8t+UnLo
         2IrsiYs4JUcgA/C7duJWM0hZAqA7SEYXsFFNIP/1q2LSJIIPiWSv1gXgauA8f2t9cc
         +aChfDbgOhlxlLrgLWbzCkzQJbp7NM5ZljfPdHSI=
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
Subject: [PATCH v4 4/5] selftests: kmod: fix handling test numbers above 9
Date:   Wed, 18 Mar 2020 16:05:14 -0700
Message-Id: <20200318230515.171692-5-ebiggers@kernel.org>
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

get_test_count() and get_test_enabled() were broken for test numbers
above 9 due to awk interpreting a field specification like '$0010' as
octal rather than decimal.  Fix it by stripping the leading zeroes.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeff Vander Stoep <jeffv@google.com>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: NeilBrown <neilb@suse.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tools/testing/selftests/kmod/kmod.sh | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index 8b944cf042f6c..315a43111e046 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -505,18 +505,23 @@ function test_num()
 	fi
 }
 
-function get_test_count()
+function get_test_data()
 {
 	test_num $1
-	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$1'}')
+	local field_num=$(echo $1 | sed 's/^0*//')
+	echo $ALL_TESTS | awk '{print $'$field_num'}'
+}
+
+function get_test_count()
+{
+	TEST_DATA=$(get_test_data $1)
 	LAST_TWO=${TEST_DATA#*:*}
 	echo ${LAST_TWO%:*}
 }
 
 function get_test_enabled()
 {
-	test_num $1
-	TEST_DATA=$(echo $ALL_TESTS | awk '{print $'$1'}')
+	TEST_DATA=$(get_test_data $1)
 	echo ${TEST_DATA#*:*:}
 }
 
-- 
2.25.1

