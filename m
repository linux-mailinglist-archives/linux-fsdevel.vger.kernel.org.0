Return-Path: <linux-fsdevel+bounces-36506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116509E4B14
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 01:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F47282CFA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 00:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95F4D53C;
	Thu,  5 Dec 2024 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="trKvKWmM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF51C36;
	Thu,  5 Dec 2024 00:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733358389; cv=none; b=MP8bhd8yIaMdVZExaPq7cJlM/6Hh733rEIphPg+PzRukEyhEIWvxaEKD+WUEU5jsBI91vpyNG0PGcYVSzaBSdvXzYZvRshH3AUe8R0Bwcz63sRcRR9mKR3nsXhuN71clwU3OmYevL/8eEJu5DGIOLkNdJhxArnv82IHqXqijWvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733358389; c=relaxed/simple;
	bh=hZq42RBJ1eHg0DT0y6H8DhVwVHSMTJaExIlIRRRKAa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oC/0oTYsI/ul7eOoDeq/j2zpGnicXouYESIup7G5Rk4GSkewsuF/XP0IRLaZobzf1Ea8zwV40xIK24yc0PUgJVB30BXOXA0uWzA1TidBMF2TTzaTFjSaYGhm/r5/2xdPcFcwpsDdeMfp2Zd3uIm1iTLLfpWsuO7aCDUdGUyvJiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=trKvKWmM; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=J234ny5yyhrfseHzJ11zzCKLAAps5cwchYksQX/+uLU=; b=trKvKWmMXiTifUOHBUSFzB2Lfk
	K3VfVSLkAS4ZJlUnxygy4g7Hk6sQNSzVNILE6KDjUuJ7M6DiwdqLoRSNJ9G6nwdOT/XTmPVOcigar
	h4mONChVuuTQLb+p8HPShV7KLEw/DjLFChry+FvZ8fwl6sBT26YkJ1//zjegdkg8HPoMD5etci5hm
	bROFjRNZ2N4QwF85hJyWlgK22Y7q82C0QJW3R4h+DEdZY2U0kydwVZKzNnBaIAWSZOVVB+Fbj+uI1
	Jc7vbduz3sqR4fOmsxnXXXjGKAFLEdAP9eL/qRchcMSAQOah5Re6kGmGfhKfPnxjs+Ly1Q1ZfO293
	rlRwxr9g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tIzhJ-0000000ELpc-2AJI;
	Thu, 05 Dec 2024 00:26:25 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: patches@lists.linux.dev,
	fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	gost.dev@samsung.com,
	sandeen@redhat.com,
	mcgrof@kernel.org
Subject: [PATCH] common/config: use modprobe -w when supported
Date: Wed,  4 Dec 2024 16:26:24 -0800
Message-ID: <20241205002624.3420504-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

We had added support for open coding a patient module remover long
ago on fstests through commit d405c21d40aa1 ("common/module: add patient
module rmmod support") to fix many flaky tests. This assumed we'd end up
with modprobe -p -t <msec-timeout> but in the end kmod upstream just
used modprobe -w <msec-timeout> through the respective kmod commit
2b98ed888614 ("modprobe: Add --wait").

Take advantage of the upstream patient module remover support added
since June 2022, so many distributions should already have support for
this now.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

Eric, I saw you mentioning on IRC you didn't understand *why*
the patient module remover was added. Even though I thought the
commit log explained it, let me summarize again: fix tons of
flaky tests which assume module removal is being done correctly.
It is not and fixing this is a module specific issue like with
scsi_debug as documented in the commit log bugzilla references.
So any sane test suite thing relying on module removal should use
something like modprobe -w <timeout-in-ms>.

  Luis

 common/config | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/common/config b/common/config
index fcff0660b05a..d899129fd5f1 100644
--- a/common/config
+++ b/common/config
@@ -264,7 +264,7 @@ export UDEV_SETTLE_PROG
 # Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to "forever" if you want the patient
 # modprobe removal to run forever trying to remove a module.
 MODPROBE_REMOVE_PATIENT=""
-modprobe --help >& /dev/null && modprobe --help 2>&1 | grep -q -1 "remove-patiently"
+modprobe --help >& /dev/null && modprobe --help 2>&1 | grep -q -1 "wait TIMEOUT_MSEC"
 if [[ $? -ne 0 ]]; then
 	if [[ -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
 		# We will open code our own implementation of patient module
@@ -276,19 +276,19 @@ else
 	if [[ ! -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
 		if [[ "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" != "forever" ]]; then
 			MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
-			MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-t $MODPROBE_PATIENT_RM_TIMEOUT_MS"
+			MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-w $MODPROBE_PATIENT_RM_TIMEOUT_MS"
 		fi
 	else
 		# We export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS here for parity
-		# with environments without support for modprobe -p, but we
+		# with environments without support for modprobe -w, but we
 		# only really need it exported right now for environments which
-		# don't have support for modprobe -p to implement our own
+		# don't have support for modprobe -w to implement our own
 		# patient module removal support within fstests.
 		export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS="50"
 		MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
-		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-t $MODPROBE_PATIENT_RM_TIMEOUT_MS"
+		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-w $MODPROBE_PATIENT_RM_TIMEOUT_MS"
 	fi
-	MODPROBE_REMOVE_PATIENT="modprobe -p $MODPROBE_RM_PATIENT_TIMEOUT_ARGS"
+	MODPROBE_REMOVE_PATIENT="modprobe $MODPROBE_RM_PATIENT_TIMEOUT_ARGS"
 fi
 export MODPROBE_REMOVE_PATIENT
 
-- 
2.45.2


