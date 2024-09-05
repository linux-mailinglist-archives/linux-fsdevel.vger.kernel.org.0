Return-Path: <linux-fsdevel+bounces-28750-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A44CF96DCEE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 17:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E59B28A557
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 15:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31921A0720;
	Thu,  5 Sep 2024 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="R2cto8b3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B73B7F7FC;
	Thu,  5 Sep 2024 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548278; cv=none; b=BIaJGzUHPvNX/rWMLtmIxx0uUqVi8Ua9jDisBLfCof/HhPtMsLPLHZEeuoWgCraZldMTmWLNvUiMICSpgLefgh74ICAQ8Eo5ORmxUHZg49vrL4cMKMqyL/iXGctXoJnGYbBV7o9risllzUrmvol7ExOx40P7YkxkECBd7Fk4f8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548278; c=relaxed/simple;
	bh=Xo4dbP+N+dKe3SIozVX57QvOYTkX/g8hqX8+Psww87E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y4pqfw8FBr18MRLFEaV5FT2+Bo8pS91CJ7Y4VLpLqQZqeODprGrgy75v9s86Z2AYnGMuD7xsldzkJ89Ib7AtU+4D50DG2x6bb0UufMGYb0q6wuD00/hTnDsCydQpKW8KP/yBCOgrzz6zTtEpwhSCfmYUE094SM0Ds+LfoC41l30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=R2cto8b3; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4X02Xc6nzkz9t6V;
	Thu,  5 Sep 2024 16:57:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1725548273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6zDx/4wSgap3qpn522sEqjp0S1pufmopLG4YO9X8BM=;
	b=R2cto8b3gJsoczRAl9qHVBmzwA+YGlQNupg9uzRnF0t+IJpqzbN2k11zidq/Wa/TT2BLyT
	SQZR9M3zqz4w5TLYrkNbxw1v6qPprWmYunKu0WpmUMoc16tsazztDoyyyV0WGd+YZHgD9X
	plqdUOI4V25DLw7GJgz3tjAu0mV9lh5E6M3daGLp4T/p+v8W0WIC3uIoFT8y+EIFbaUEG2
	g2DTCOK8V9zeH3zWHib1l4XoAuU7D33Zoff0peCtTPfI3xr+nKUibwlGR/PwV+BgZStoOK
	Wsol534A2RV5sIcZWaM+fW/1eD3JBhywmyeiBPbba9htIBTcswgxsgricxsUCA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 06 Sep 2024 00:56:37 +1000
Subject: [PATCH RFC v2 05/10] selftests: openat2: add 0xFF poisoned data
 after misaligned struct
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-extensible-structs-check_fields-v2-5-0f46d2de9bad@cyphar.com>
References: <20240906-extensible-structs-check_fields-v2-0-0f46d2de9bad@cyphar.com>
In-Reply-To: <20240906-extensible-structs-check_fields-v2-0-0f46d2de9bad@cyphar.com>
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
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTdPLb5URWz6trbTC5piQHcm77/FZz3/enFDtHpR2zTP
 GbK2Ss/6ihlYRDjYpAVU2TZ5ucZumn+4ivJn1aywcxhZQIZwsDFKQATWe/B8D/ieLpMZPYCe9nM
 Xx/MnyyzNAvQY7/68rZtsXRUlwHTIQFGhv1NJbfOVM48qVUQ8VLbikPJ859avujMEzd2RromfGO
 0ZgcA
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
2.46.0


