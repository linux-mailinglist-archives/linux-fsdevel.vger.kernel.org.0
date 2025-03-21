Return-Path: <linux-fsdevel+bounces-44710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8452A6BB0E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 13:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542ED3B5C27
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 12:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C0E22B586;
	Fri, 21 Mar 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYN1cly8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890A322371B;
	Fri, 21 Mar 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561291; cv=none; b=nmqgKDR/m31UdfsT3dtPK2iLvzOorTTeDHEps3Fb2Bfc4SkcpNcFRksPfWhRCMec0+xsXiekDIqTeKxD7rw1NELc0GxJQ5akXQPgILKa4lO519MzFcdi8yIsyYlCP1zraWZAMTL+a9I5YowmTOMXdrMFJDUGUQB2KWtJWIcDfAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561291; c=relaxed/simple;
	bh=++XbEfpnPeqQ4moIezitAVfEJDIk+P74wNcs5SRzozU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqSLzQiJhMl0TowesRy7jfSsmqsVX9kH6IcOk3Wzcbnl5/pv4nrboTTjc2wrcsSYYGnohuC1fUk1CHq5KVd7yxnwLt8ZaWnJncNeHHA1SDFTxANuXDSS562Z0lw21aJdAYszw/rId0Sm/1kD6UgRfzSLLOHtbaAvnIjq3h5FZBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYN1cly8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 207A8C4AF0B;
	Fri, 21 Mar 2025 12:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742561291;
	bh=++XbEfpnPeqQ4moIezitAVfEJDIk+P74wNcs5SRzozU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eYN1cly8fznjwHSDCg5vrQ+9GJ6AJ2AsqJmaHa4+uuX3vzL2HHLoJj/0XvbFINpMJ
	 07WCKGuHsQnA34j2QSm5ygIl8wZ/ocwNujfjwcMIx4Eg2Ch1s6kdH8B8EHkZIZxqXw
	 YkJQqDycsXi1EpwiNVRBj8kb0RE9t6cOfkyuMZYsrqPDxmm0YGYpAMuz4jM1b8P023
	 3Ynn/QLuhfFmTHoSPOCFoLLGrsfLWyPLOGU7yy6+dd9a2ohcV8vrwG4lxsMxZ1KZs2
	 lAF4LFwZQmJz8m8pXzhzAnjnSC5IMMPtlKCI9aG9uLibZ8PrPHX6HhAmPvBFTs+WTi
	 Ogap52A7jxoUQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F116C36008;
	Fri, 21 Mar 2025 12:48:11 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 21 Mar 2025 13:47:25 +0100
Subject: [PATCH 2/4] sysctl: Add 0012 to test the u8 range check
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-jag-test_extra_val-v1-2-a01b3b17dc66@kernel.org>
References: <20250321-jag-test_extra_val-v1-0-a01b3b17dc66@kernel.org>
In-Reply-To: <20250321-jag-test_extra_val-v1-0-a01b3b17dc66@kernel.org>
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, John Sperbeck <jsperbeck@google.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=++XbEfpnPeqQ4moIezitAVfEJDIk+P74wNcs5SRzozU=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfdYAj+wL7uNtMJMtN+SaEhFHsQNTYvxgciq
 qT1UQ+ymTaQb4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn3WAIAAoJELqXzVK3
 lkFP8xcL/00KbQvm8zlN6hup0eFPPsksVlQqhtagFA/g4+ODy/KvMy4YItrC1ixaN9bIjyAMSov
 2iUFQsO8VB6PaFjajRJyasZ5ntXMAGUgeAGHUBdrt8nTnmsIjM8tgxpbHWUJglbspBbtn3jVzLW
 XWbNt9UNb0X9QtFAj1H5oT06dlhtNZgFggUZW2AnYBNl5gbYxtW1LIYCXqbZ9hph1P5O7Y+qGIS
 jpcYS3B6QgdDgj2WCgUPk8i2atXV6p1gR1gDRxT6mQ/2Hi192I45JCF2klRJptybB4D2oKgRQXK
 gUhlNCdkdjltM4Yk152o8cKH0Tq1/QVLgnLAh8Iq2wh8rzLdUg9n1/x4h6wp1TAPYnV2ue65O7X
 mh8FGedySrH9q6xqR0wH3eS5nIFbwEEHvPeT4CWuYRml6xD79pB8EVEHBwj8UUlnyhykZhDe01W
 fX/BxHfIRKD+xnCkKj9+WG0AJDJGB+yl7cvrcKjdxauOb1gVxBne5+Oyzjf/T0t1+r3LT4+unA5
 Gs=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Add a sysctl test that uses the new u8 test ctl files in a created by
the sysctl test module. Check that the u8 proc file that is valid is
created and that there are two messages in dmesg for the files that were
out of range.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 tools/testing/selftests/sysctl/sysctl.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
index 84472b436c07faf43e555999951e554f8e1a60c5..22b53c263dd4525ee8d4655272d6842e5249a7dc 100755
--- a/tools/testing/selftests/sysctl/sysctl.sh
+++ b/tools/testing/selftests/sysctl/sysctl.sh
@@ -36,6 +36,7 @@ ALL_TESTS="$ALL_TESTS 0008:1:1:match_int:1"
 ALL_TESTS="$ALL_TESTS 0009:1:1:unregister_error:0"
 ALL_TESTS="$ALL_TESTS 0010:1:1:mnt/mnt_error:0"
 ALL_TESTS="$ALL_TESTS 0011:1:1:empty_add:0"
+ALL_TESTS="$ALL_TESTS 0012:1:1:u8_valid:0"
 
 function allow_user_defaults()
 {
@@ -851,6 +852,34 @@ sysctl_test_0011()
 	return 0
 }
 
+sysctl_test_0012()
+{
+	TARGET="${SYSCTL}/$(get_test_target 0012)"
+	echo -n "Testing u8 range check in sysctl table check in ${TARGET} ... "
+	if [ ! -f ${TARGET} ]; then
+		echo -e "FAIL\nCould not create ${TARGET}" >&2
+		rc=1
+		test_rc
+	fi
+
+	local u8over_msg=$(dmesg | grep "u8_over range value" | wc -l)
+	if [ ! ${u8over_msg} -eq 1 ]; then
+		echo -e "FAIL\nu8 overflow not detected" >&2
+		rc=1
+		test_rc
+	fi
+
+	local u8under_msg=$(dmesg | grep "u8_under range value" | wc -l)
+	if [ ! ${u8under_msg} -eq 1 ]; then
+		echo -e "FAIL\nu8 underflow not detected" >&2
+		rc=1
+		test_rc
+	fi
+
+	echo "OK"
+	return 0
+}
+
 list_tests()
 {
 	echo "Test ID list:"
@@ -870,6 +899,7 @@ list_tests()
 	echo "0009 x $(get_test_count 0009) - tests sysct unregister"
 	echo "0010 x $(get_test_count 0010) - tests sysct mount point"
 	echo "0011 x $(get_test_count 0011) - tests empty directories"
+	echo "0012 x $(get_test_count 0012) - tests range check for u8 proc_handler"
 }
 
 usage()

-- 
2.47.2



