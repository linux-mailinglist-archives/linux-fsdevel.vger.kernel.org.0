Return-Path: <linux-fsdevel+bounces-70566-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B23C9F968
	for <lists+linux-fsdevel@lfdr.de>; Wed, 03 Dec 2025 16:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 326F4300195A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Dec 2025 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B58C318140;
	Wed,  3 Dec 2025 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OidaFNwK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0927317706;
	Wed,  3 Dec 2025 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776606; cv=none; b=dKs8c2Q1Th2vE3XZfKuuPQ07ZA5FtqnItGXOpzzK0JtIz98k3x8rVgU6m99bKyTK1n/E7YGuDXVyKz/HYwEkRjq2KdL3WnW5XkvNuWAJXUpzCYJHYiSO12ti9/pG1oDAV86ALxZMZ2/YJ6/SMRvMYEjWskRBRD18sojCMSyXutk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776606; c=relaxed/simple;
	bh=I6YcT/83WkyV7QCwXAwwDabMpj6mpVN8sQVcDNhCnhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bhkB+oswtK5K9NpjXxjQyhzaEolXy34DjbSLLocGiHdLoIL9EasemTXzpm4Wo5zfy2DqtEh4NIMmZ+Qo5/11Ho8ziRtv5B2OXHJczdcaywTdxJu/dqAypwPiJ6oq0HniEH5p7ibaZiCAFlQI0shdm5OzRF5Ewr4F5YK1HiUJHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OidaFNwK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A50C4CEF5;
	Wed,  3 Dec 2025 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764776605;
	bh=I6YcT/83WkyV7QCwXAwwDabMpj6mpVN8sQVcDNhCnhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OidaFNwKbLjMTnHMUCvD8ZlG8xjONsNp/AutlwQAuF8w21LnSn80nOYlK56CjAV9H
	 t17NAKDftvsg/O7tIf5Q6/13aFY8ufGqSeHIUKC/6Hh/RNXc3buq3XAsD7QhqWb4av
	 Gndwvl8EimlU6qBtPXDJWl7hMAGku6ODzUTQyMkbJ61PdGpwqNT+6ITWP2KyhGDaN9
	 Y+4ubxMRgGolMleQB7VvBXJNE3otaS4oTH/dbVbkALRyak7eaA7QSs01WLpIgJcgjT
	 b60ojl9axpCj/DAONA+gERClSz49N7CdeJN72FP7qEabhjS2cL5GR766JCC8i0eSRR
	 F8KfgitUJIdUg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 03 Dec 2025 10:43:07 -0500
Subject: [PATCH fstests v3 1/3] common/rc: clean up after the
 _require_test_fcntl_setlease() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-dir-deleg-v3-1-be55fbf2ad53@kernel.org>
References: <20251203-dir-deleg-v3-0-be55fbf2ad53@kernel.org>
In-Reply-To: <20251203-dir-deleg-v3-0-be55fbf2ad53@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Zorro Lang <zlang@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=I6YcT/83WkyV7QCwXAwwDabMpj6mpVN8sQVcDNhCnhU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpMFqbbhi5qb6ZKUYtAB05R7Os0RBRfhnkQRfKs
 0cok1TpUKOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaTBamwAKCRAADmhBGVaC
 FUYeD/4vI5EQon6xI+NfbEOu1ooNSnnpTrIV7eINq0vmP17Ck/x1hjiIBVVeKaPl3lp6wOgyMLw
 olhW6OMbYF43OVw69seKfIHPJW+rxLKjaVGvCFAKDyxFMI2Y8GkpCGc4jUwBHM+YVFWjacKOtsY
 IrJhd0pml8RjyUYecmWxU5gtLuqcYvwytwa/I3FGSWy43Nad3+OHcT3oP48uZahbD4cGATKyTv7
 E3RsoPxL1gtvJMdLlhuaNJiWWfr28tmXFnUYiLwvnnr0xeTGCwsqnH6nKOo1q96kJm/scz583hX
 HYVXWYzOw2xLCvp2i9eq+C7SgeGHZ03+kqZyVyo36MB25+MtRdpJUXrAwTDa6Qk2yxBDwvd+dCs
 njy9CXuAYMryxaBb4p2M+Z13X6ycNF58LekDE1o5m1idDzXJHQjz7SPnQGgPiqf7E1MQmvz7Fdv
 UhUrzyPtlq5+PQesSmLp44yGuuF2hM/i/peqljPlzhxYVsXl6q8ylOf9P0AWeFfrsX+ryPgiFle
 jMMyUG0n5caepAOZ7n7vUwvPM5FYpwS03ESLgKHogrqA14A8mSeRXpCOTwOvDounX0gLwcYY9TE
 1XdZo/teYq8RagqdTHji1B1XUNQBHAJz4wdWlbs3jtydPPufAtrvhPUsM07wfBFvMSC5A+HJFng
 LZcbluelI9TDSBA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Remove setlease_testfile after validating whether a lease can be set.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/rc b/common/rc
index a10ac17746a3ca4d9aca1d4ce434ccd6f39838b9..116216ca8aeb4e53f3e0d741cc99a050cb3a7462 100644
--- a/common/rc
+++ b/common/rc
@@ -4656,6 +4656,7 @@ _require_test_fcntl_setlease()
 	touch $TEST_DIR/setlease_testfile
 	$here/src/locktest -t $TEST_DIR/setlease_testfile >/dev/null 2>&1
 	local ret=$?
+	rm -f $TEST_DIR/setlease_testfile
 	[ $ret -eq 22 ] && _notrun "Require fcntl setlease support"
 	[ "$FSTYP" == "nfs" -a $ret -eq 11 ] && \
 		_notrun "NFS requires delegation before setlease"

-- 
2.52.0


