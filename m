Return-Path: <linux-fsdevel+bounces-31480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6CA9976B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 22:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF231F231F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 20:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C781E572D;
	Wed,  9 Oct 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="dK5pokPQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677721E230F;
	Wed,  9 Oct 2024 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728506515; cv=none; b=A+EtDe1T5Ad+nMTMs/ENRwhuoxLPEWh5lMpdLxs4WOfqej8qLJNDsr508D2F9qltSz2lQNCbiSZIyikh3mAJexUx0uGieMCdD73Od6Cus9DkVYQykJR5RvfKsRfvnOfruMcwEXG0W8uwUHlOvpOqnJl4B9u5bW1hyavp8nmJyIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728506515; c=relaxed/simple;
	bh=M9iWszswoUm+ACdoBR6OSZmDmOZ0gV76Hvojwn9eqxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QLmhlSQRTK9cDHAWlf4VaORU1xTDXEVxAXJjnQ+QIzQcnOGEEuT9YmwGp5PvlfEInbRVK/zb+qidx/WBOXPIK2HxSXNAMZAp4qKp1YntG6oNJt3st3ZANoH3UHvb25btrjd2zgDyFPy+MdsKXJUV/YW0ukJU0KtqWDTW2IFCnPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=dK5pokPQ; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4XP4Yn5rqSz9stM;
	Wed,  9 Oct 2024 22:41:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1728506509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ICm4bzvlgrwdJ59X+goTMMQMK+SqT/1B0scZvKOBQTs=;
	b=dK5pokPQPwhS6hvQWb4G/R+lf0fAFk8NSut94azvuDIVK6tn1w/g7zwucLdIO1XSkbU+2q
	HrPW6B6fgMKPPJ2KNgbBIRou7R2RdaXSFqxgB/8Zcy7pO1hokarxIo/c1W4x+U1Fw/IRX/
	VN2BLam3lFDCKX/ULiriBfubnuXNHPtsaKazWAg3/Z+UrZI//jfR73fuiuuVYxyiVEXOXb
	wBfjvmt3cb6Haf9/vxwu2jjbBiwg7XEsLuPE3PHlUs8Ohr6HsJeNV+uakMHDdM6grawp+u
	skDl+KqlBCZKVExZCQ7zT6uMgzZCAB6ugP8boNif9iiF/wU3cw2rZBdGoOAUHg==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 10 Oct 2024 07:40:38 +1100
Subject: [PATCH RFC v3 05/10] selftests: openat2: add 0xFF poisoned data
 after misaligned struct
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-extensible-structs-check_fields-v3-5-d2833dfe6edd@cyphar.com>
References: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
In-Reply-To: <20241010-extensible-structs-check_fields-v3-0-d2833dfe6edd@cyphar.com>
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
 h=from:subject:message-id; bh=M9iWszswoUm+ACdoBR6OSZmDmOZ0gV76Hvojwn9eqxg=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaSzvQoMsvl4dsUWLUPVxvLwfKcdlqtcfZK+/MlYn/Gk8
 HTzybffOkpZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBE5GwYGS5HVKhYHmNycL9i
 yNAf/9q6yXp79C6XGw3rtvwL0sg7so6R4cK8zrjrolp9+r8Wtat3JaY4nPHqWrj1f3B08pWb/27
 7MAMA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

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
2.46.1


