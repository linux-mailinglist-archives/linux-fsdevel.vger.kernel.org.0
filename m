Return-Path: <linux-fsdevel+bounces-51462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3682AAD7212
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D92FF189A23C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241C9246BD6;
	Thu, 12 Jun 2025 13:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCFxv/M8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8366B253B67
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734732; cv=none; b=PTi8dgclrbf8gBdaOwzpdzrBL7M/1eYNG1s/Bq9Axw4xgIt3kjN51j0wMqzksfG5bh5g5mtqsXFLx2jOwYrZugWR1GlkVUfQmr5FCYu73u1e9NRHTUS6AqEkX7HNmgOwhmo6Qijki8ys9igPgaZ+AiDlzhw1iG2/I3ykbdJrfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734732; c=relaxed/simple;
	bh=RvrZtMu1KImUI+/Ro107tj8hYBS5ukfpKyMHdMIY/Ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ooC7CniNKrZqdCvEP+YZua59UD23pT+mFJLpDShHN3keq+UvJXao3CMLWny4VsZMOZ7kgxXnlPiIk6/UVJFoApDkAykzP+Qx2DixqGH4v3jcVPxDyN50MsKPdDqVWEVL2Uef7aYlnhg2UNeSXVFsgxUFxPNkJskG5w762uGk39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCFxv/M8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72188C4CEF1;
	Thu, 12 Jun 2025 13:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734732;
	bh=RvrZtMu1KImUI+/Ro107tj8hYBS5ukfpKyMHdMIY/Ic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UCFxv/M8zlqsJ2R09MRxaX76Y4gHE5k1U0WfLc+y0P6eehRs+Y3WqYr06Wz5il9Hz
	 5y71WwwWHgUTEbbAr47wjp8j5VrN1NmM2Pw7ONISCDKzJnjyOtcoPqX9efvhaZmtJA
	 67NmSc9PuhspXXb6cocAIRJFVNvcAtG1vhKpjp5NcwjxBH9eANBkuiQTKJypli3zdn
	 a4UOFh4teNG6l7XQKbE8B3L3KjJIV6ISdlr2wmBYWtT3/7TWCzEY52s6y54dOXamc7
	 YTxmOgDT5FzVim8Qf0nQ0mAqEUkxtdkJd1P43zwmCqT0VOJZvdDGVeoyqypYKo6EVd
	 hWYqmnpoXtFOg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:15 +0200
Subject: [PATCH 01/24] coredump: rename format_corename()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-1-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1565; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RvrZtMu1KImUI+/Ro107tj8hYBS5ukfpKyMHdMIY/Ic=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXUrYpHJNZp+JKYvdI/2zec1HDntx9m/rn0gz7m0u
 mVzXfvOjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIk0cDP8D4p78Ul3cc/n5+5t
 c15rsz1d4PG/sHXxu/P6MfKHLLW+TGBkmG4SOmVdw13B04crLeeffbTfzuXqQ6PfPf9kY+sO7pn
 9kB8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

It's not really about the name anymore. It parses very distinct
information. Reflect that in the name.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 3568c300623c..79a3c8141e8c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -225,12 +225,13 @@ static int cn_print_exe_file(struct core_name *cn, bool name_only)
 	return ret;
 }
 
-/* format_corename will inspect the pattern parameter, and output a
- * name into corename, which must have space for at least
- * CORENAME_MAX_SIZE bytes plus one byte for the zero terminator.
+/*
+ * coredump_parse will inspect the pattern parameter, and output a name
+ * into corename, which must have space for at least CORENAME_MAX_SIZE
+ * bytes plus one byte for the zero terminator.
  */
-static int format_corename(struct core_name *cn, struct coredump_params *cprm,
-			   size_t **argv, int *argc)
+static int coredump_parse(struct core_name *cn, struct coredump_params *cprm,
+			  size_t **argv, int *argc)
 {
 	const struct cred *cred = current_cred();
 	const char *pat_ptr = core_pattern;
@@ -910,7 +911,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 
 	old_cred = override_creds(cred);
 
-	retval = format_corename(&cn, &cprm, &argv, &argc);
+	retval = coredump_parse(&cn, &cprm, &argv, &argc);
 	if (retval < 0) {
 		coredump_report_failure("format_corename failed, aborting core");
 		goto fail_unlock;

-- 
2.47.2


