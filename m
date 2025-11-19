Return-Path: <linux-fsdevel+bounces-69116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E0FC6FCA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 16:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C097B3543D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EE43570DA;
	Wed, 19 Nov 2025 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozSj3byC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2409832E697;
	Wed, 19 Nov 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567000; cv=none; b=amMAf8D7kMl06VjONL2JD0rxWrZxLebCctbb39CtK4UCW/J9KWcd7c20bB5jJj21+GQEGGlnbdYm3JapbnwPKKcig8gUkkNds9Jht3R+Vkktl1Z43i1rlZ5qK56f8WxcreQcfGbh3m7iSS8Icgf21d4V2e+uaBSRYs1ewNkKm+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567000; c=relaxed/simple;
	bh=jO+ISN3oWkr/KvKN84Ex4/rf5QHuhEwbQIGPlnN0X7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y4+TKAck66mrHLzWTa1amuGl5MJdUJ6xMMufCQkMYVGQ+lNKP28+IZeActd+vl76SIPZh1bDbUQccjdvueF3A96PH6FwTqsw1DPz+eZwgk4WEWUIuvbJftPkQ7UEkIXNGGYoRHhW18MZmZq9rnZS6ZEIMym+YUTjx1JPXRY6eoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozSj3byC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A29C2BC86;
	Wed, 19 Nov 2025 15:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763566999;
	bh=jO+ISN3oWkr/KvKN84Ex4/rf5QHuhEwbQIGPlnN0X7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ozSj3byCDOIUhf19r1Me3LeuGtw66krRDaTBBbKJVQlF1d6n53Pt7tEUVYNSEonOt
	 vurVpEmqw8bA/t5QN2fTek2h7xfTGuLXFywfTemHTp6cE6cAuZnE3rEub2WoX6kLNG
	 a8mDaXFuFv44JRt7siACevwnOqk7YNNqezkij53UqSyazo8j4y+o91Q5gsNYB3HEMF
	 KikLGsPaORRSHRy5yNC6Q5yLbVbEFD9kfVQ3365gdONYGUauyksd0PzhTR9C+MYvhq
	 YnXlkcWJj7ppHRed0IZgA370WHAn0fElhIqFcHrZZAfUWt8RD2A20zqwPOzeySKb7/
	 qqgIK+fnfmF/w==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 19 Nov 2025 10:43:03 -0500
Subject: [PATCH fstests v2 1/3] common/rc: clean up after the
 _require_test_fcntl_setlease() test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-dir-deleg-v2-1-f952ba272384@kernel.org>
References: <20251119-dir-deleg-v2-0-f952ba272384@kernel.org>
In-Reply-To: <20251119-dir-deleg-v2-0-f952ba272384@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=jO+ISN3oWkr/KvKN84Ex4/rf5QHuhEwbQIGPlnN0X7E=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpHeWVhGF5OzPcVj/TC3FXQfDyHrmeNdYtTjPnW
 FOWx6EzKhWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaR3llQAKCRAADmhBGVaC
 FbvMEADWuxdUMwwr60Ryb1atwlsPakSsvHpsd8Zq4WBzOIiMut7UQTJbqS1VPDLiuFayT0hNV8U
 7HXU+vXGrBmsLkayhkzt3OmCqMuG/jNKw39F+QAGbrfQzuU0q2ZHX/V+8ORWtSssEOs30vBbiIH
 avxCFMiDCwJJv+krQc18boGYEQpwrU1NctDESDj9AeQHj13Loz0fqoAS3iNF5KAd/4m2O0O3Km6
 FAorAIvJ5OngqNpZKgJtnrXk7JN0uLjwPnCm4KQhEYtNpFSf8dXJejcZNrCvGLUds8tWlPc4HXI
 B0NtbWedLJx0ZXF05WFg79nzwf7zqgC0o81NQMDApBOh8ZbxjLG/rf09jBJ3YPAsIuEQ3Bfseet
 e0coU1ox9ZCnIRw1qfRtLAlG7RRAiovdoKfB5IErtpS5aSOoyWFQr96hHUEf5KIEVuDaeUQjxtd
 9dJqD5Wn30RNHDZVc1mVB9Ilb3wSkpHDbnJ1eoQ16jg9v5IvrE3codUDYR9shfYP12iNqRoKWv2
 bSgGi/uZGV1ISTHGxwd+awP+NTY7a8v7d/qy0sdQYp9T07BXd64y3SPbpItLK08BIt3k/tLTuh9
 QqfjlrV/QmbJZqBpTDYI4qOgvR8sBw6eF/9Gbyx1Gr2KdyFk6QQC/HOWyLWIlUUwfh4legYxRis
 je+/WTvfAhQjnMg==
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
2.51.1


