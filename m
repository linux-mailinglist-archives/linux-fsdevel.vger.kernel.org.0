Return-Path: <linux-fsdevel+bounces-18277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB388B68F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 05:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB80AB22649
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 03:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC8410A1E;
	Tue, 30 Apr 2024 03:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4eLg1TV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82A21118C;
	Tue, 30 Apr 2024 03:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448182; cv=none; b=p08jnk9Z2DY1QF/9BSlNFZ+MioS6jc+jrGFJoVvKMm7nnOiJveCYrnATdTY5POEfTsgn7qTghYeweU233TxlmW0jjoV4Vq2s36Qh9C7Sj699Cd04Ygby1hul9r9ZCT77QgJ/d4oT5DXizfdBa77cjKsh3GeqWDLGczRy9fgf6Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448182; c=relaxed/simple;
	bh=q3YUnm0bGb7HE0uRQljjJv8p6Srj4K4xP+f1CATFCHY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrXFw3TZn2T/zGduJDyq+U/UZSLX6Ew3/ujT3r/K6/55s9dIYLTZu0/cpot8tLC/kjTEv5jdnLCjkkbABHQ2Crrze0e14V4n15zZ074k7OaWk8EaQOjdAyFnX5UVuy8WEyGvpmZR8NL5YJKAeS74QhvGh8uD7rLKw3mNBNDCNlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4eLg1TV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C2FC116B1;
	Tue, 30 Apr 2024 03:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714448182;
	bh=q3YUnm0bGb7HE0uRQljjJv8p6Srj4K4xP+f1CATFCHY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=g4eLg1TVEIOYIrQQ8e0jLfdqiUHt9eOB023FsAyhEB4pzDKMloWQG2rcFjmDRPmp9
	 v2Y3bNy1umHf3BRzTIT07/v+xETusBQVtVE7PbwHCzowEw5fnFwSzU3/Ytj7zKzK5l
	 YV7FvXzXj3yQ9Z2P6nC1D/y09YAo35BEGZw8Fzz1MQ1qO1MBJF4QtxiXM9TpC9ptP+
	 jqPHSk2Et6rb3qWAEjLB38BwXb4wHAimDFoHg0n9q31pCNObVE3kIp8Pf9jlECptFy
	 Tb281An7Qd2eyuO3ogfcYjOFWo4QbHBzFp3sFDASREiySNpbsMmH+rIv87yxdmsI1Q
	 Yx7+aX9q78Bdg==
Date: Mon, 29 Apr 2024 20:36:21 -0700
Subject: [PATCH 21/38] xfs_db: create hex string as a field type
From: "Darrick J. Wong" <djwong@kernel.org>
To: aalbersh@redhat.com, ebiggers@kernel.org, cem@kernel.org,
 djwong@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 fsverity@lists.linux.dev
Message-ID: <171444683434.960383.8666398059683404403.stgit@frogsfrogsfrogs>
In-Reply-To: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
References: <171444683053.960383.12871831441554683674.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Define a field type for hex strings so that we can print things such as:

file_digest = deadbeef31337023aaaa

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 db/field.c  |    2 ++
 db/field.h  |    1 +
 db/fprint.c |   24 ++++++++++++++++++++++++
 db/fprint.h |    2 ++
 4 files changed, 29 insertions(+)


diff --git a/db/field.c b/db/field.c
index d5879f4ada7d..066239ae6073 100644
--- a/db/field.c
+++ b/db/field.c
@@ -158,6 +158,8 @@ const ftattr_t	ftattrtab[] = {
 	{ FLDT_CHARNS, "charns", fp_charns, NULL, SI(bitsz(char)), 0, NULL,
 	  NULL },
 	{ FLDT_CHARS, "chars", fp_num, "%c", SI(bitsz(char)), 0, NULL, NULL },
+	{ FLDT_HEXSTRING, "hexstring", fp_hexstr, NULL, SI(bitsz(char)), 0, NULL,
+	  NULL },
 	{ FLDT_REXTLEN, "rextlen", fp_num, "%u", SI(RMAPBT_BLOCKCOUNT_BITLEN),
 	  0, NULL, NULL },
 	{ FLDT_RFILEOFFD, "rfileoffd", fp_num, "%llu", SI(RMAPBT_OFFSET_BITLEN),
diff --git a/db/field.h b/db/field.h
index f1b4f4e217de..89752d07b84c 100644
--- a/db/field.h
+++ b/db/field.h
@@ -67,6 +67,7 @@ typedef enum fldt	{
 	FLDT_CFSBLOCK,
 	FLDT_CHARNS,
 	FLDT_CHARS,
+	FLDT_HEXSTRING,
 	FLDT_REXTLEN,
 	FLDT_RFILEOFFD,
 	FLDT_REXTFLG,
diff --git a/db/fprint.c b/db/fprint.c
index ac916d511e87..182e5b7cb27c 100644
--- a/db/fprint.c
+++ b/db/fprint.c
@@ -54,6 +54,30 @@ fp_charns(
 	return 1;
 }
 
+int
+fp_hexstr(
+	void	*obj,
+	int	bit,
+	int	count,
+	char	*fmtstr,
+	int	size,
+	int	arg,
+	int	base,
+	int	array)
+{
+	int	i;
+	char	*p;
+
+	ASSERT(bitoffs(bit) == 0);
+	ASSERT(size == bitsz(char));
+	for (i = 0, p = (char *)obj + byteize(bit);
+	     i < count && !seenint();
+	     i++, p++) {
+		dbprintf("%02x", *p & 0xff);
+	}
+	return 1;
+}
+
 int
 fp_num(
 	void		*obj,
diff --git a/db/fprint.h b/db/fprint.h
index a1ea935ca531..348e04215588 100644
--- a/db/fprint.h
+++ b/db/fprint.h
@@ -9,6 +9,8 @@ typedef int (*prfnc_t)(void *obj, int bit, int count, char *fmtstr, int size,
 
 extern int	fp_charns(void *obj, int bit, int count, char *fmtstr, int size,
 			  int arg, int base, int array);
+extern int	fp_hexstr(void *obj, int bit, int count, char *fmtstr, int size,
+			  int arg, int base, int array);
 extern int	fp_num(void *obj, int bit, int count, char *fmtstr, int size,
 		       int arg, int base, int array);
 extern int	fp_sarray(void *obj, int bit, int count, char *fmtstr, int size,


