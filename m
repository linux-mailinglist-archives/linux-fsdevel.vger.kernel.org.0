Return-Path: <linux-fsdevel+bounces-28207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70766968016
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 09:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259BE1F21C03
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 07:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240BC186E3D;
	Mon,  2 Sep 2024 07:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="tvBuTffu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5717F500;
	Mon,  2 Sep 2024 07:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260878; cv=none; b=Bxnw3yx4BXpXvkfljNdOIWFZd2ZdgGScUV0vYLBvuo6Wt4FQoGBZzQo3O845qpWhYPfyK9JGgEeZB26QhEppoluaR7ogsARqkRddANPwD5+3ayGEl+1nK7+6WAqkQR3wacI47/fTybaPhDQHggtkXVeqkUHvQ5lV+dMeX6KJH6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260878; c=relaxed/simple;
	bh=Xo4dbP+N+dKe3SIozVX57QvOYTkX/g8hqX8+Psww87E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QBYHaZ8EBxKVgQ2M/X8dPlAWqpcHKDUk8C7rxX9fJQPQ0cZFJrQbgXO7Ye9f61DctiFnlAeWlJC4j0VxSUOx6hxE8/VhyFG71xk/EJO2WOPFaxEJEjkjCMiYJ+XBjZswdTrZPKp7DXCavK+forOMQc99ryL1F4dGVOS7eEdLlP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=tvBuTffu; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Wy0Fj2XfVz9t47;
	Mon,  2 Sep 2024 09:07:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725260873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6zDx/4wSgap3qpn522sEqjp0S1pufmopLG4YO9X8BM=;
	b=tvBuTffubIYFVhsTV2BrlY6ba34HqAg9vIZE6anbelHh1JdaOAUWPY/RQQWh4sb5OyIrWm
	MssUyJW/7+VJekBhcWRl9SlsRpULriX7oi9wadBL1XOmKi/fvFNuhrP7bRg/1f92EK8Koa
	CtZXck2HdewpezyYuHtFjq7pQoa65BJPn4jOCBm/s5JQIOngdEF+S7euKx+vli+KaQyQxO
	CPwy2E+dMwwSwup9jjcdZd9NpcKZi2SogUnpcPdUp+77xKndtpP6NtqblJMXL/879OdVEG
	ySw+2GT5UluL6apGBB+1MQ8+w8OB3uRxzjU6udlFATrOU0+ZZb3pBLt9PoSFUg==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 02 Sep 2024 17:06:28 +1000
Subject: [PATCH RFC 6/8] selftests: openat2: add 0xFF poisoned data after
 misaligned struct
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-extensible-structs-check_fields-v1-6-545e93ede2f2@cyphar.com>
References: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
In-Reply-To: <20240902-extensible-structs-check_fields-v1-0-545e93ede2f2@cyphar.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Florian Weimer <fweimer@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1132; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=Xo4dbP+N+dKe3SIozVX57QvOYTkX/g8hqX8+Psww87E=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaRdTWHxm1ppkMKxZImRj8HuWn0z393ZUqtfckzw3C1z1
 qLQ4+3ejlIWBjEuBlkxRZZtfp6hm+YvvpL8aSUbzBxWJpAhDFycAjCR1FCG/wX8H18+nP5VZLJn
 zlEPu7mTGSfERR0RmqssxPr414YrMycxMvyZv6sh7/+PiZskp3YveLZK01p68QSxpc7nvwe1XIm
 +f4YJAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4Wy0Fj2XfVz9t47

We should also verify that poisoned data after a misaligned struct is
also handled correctly by is_zeroed_user(). This test passes with no
kernel changes needed, so is_zeroed_user() was correct already.

Fixes: b28a10aedcd4 ("selftests: add openat2(2) selftests")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/openat2/openat2_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 5790ab446527..4ca175a16ad6 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -112,9 +112,9 @@ void test_openat2_struct(void)
 				 *
 				 * This is effectively to check that is_zeroed_user() works.
 				 */
-				copy = malloc(misalign + sizeof(how_ext));
+				copy = malloc(misalign*2 + sizeof(how_ext));
 				how_copy = copy + misalign;
-				memset(copy, 0xff, misalign);
+				memset(copy, 0xff, misalign*2 + sizeof(how_ext));
 				memcpy(how_copy, &how_ext, sizeof(how_ext));
 			}
 

-- 
2.46.0


