Return-Path: <linux-fsdevel+bounces-44709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CD1A6BB15
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 13:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4678417A470
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Mar 2025 12:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCA422AE7B;
	Fri, 21 Mar 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNZpIWs1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FEC1EA7D3;
	Fri, 21 Mar 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742561291; cv=none; b=gC3t+1seZb6/XPsS5z+6rGG/USxoXKVTT76Gq9tudEx7zvc87V/rnngFz2sxLKSNq7jgLHv2oodfsCV6lqkA/KZG4CrSrCeS6c3qRjDtfrVxz7NWHIXgF0XppBodc+m6BriT4BoYlwXAQiVgwjfcJx0Mzb80allMOQ47Kzwa95Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742561291; c=relaxed/simple;
	bh=V1kuVirUzH2nkyWLPiJEMJZeSr0lXGHfzJy65bU2PIU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MhLdhNDzqvyMm1gQ4/qG5bbBW8v5lezvEuRvaGIyuYOercORDzquCX64usjm+Eibmf5exIlKM4UF+4RnKwHrB8RujcQpwRj0Ucym6+Ld7fOZXQghBz8Mh2XbNq3SGZv5ybLpdHuzvBW9ePEq7dG6yjrcaVJfGoNO1Qngj5kOwKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNZpIWs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F30A0C4CEE3;
	Fri, 21 Mar 2025 12:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742561291;
	bh=V1kuVirUzH2nkyWLPiJEMJZeSr0lXGHfzJy65bU2PIU=;
	h=From:Subject:Date:To:Cc:From;
	b=hNZpIWs1lA6keN30ewySL8adHm7ZIpM8aKj5tYVOJRtShEVz6ByogEDtCnBhqHDXE
	 pr4y6prFc8BZZYNWse2lLSOdDralKYImrtkVruGUYr6r0cJ/TNimMpgo5exS/lk21T
	 PwRieMsIG8fpJWJJDKoRFUyhf3prfkRf8TLKvGAUeonSOwEHlrRav/JNucEgFf70mn
	 x7t7eLQeb2m5mPZ/uAjyvi/mO1tPG/EoATmlM+THhgmodBkOcgydAK9cjxLIUDGn4f
	 FVWilkONl4b3zivoRQi/qFqXJVwsajXtYmuulunRlwsHteGGXdE/EA8x0/rreVIRFs
	 CBpcPvBszS9Hg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06BEC36000;
	Fri, 21 Mar 2025 12:48:10 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Subject: [PATCH 0/4] sysctl: Move the u8 range check test to
 lib/test_sysctl.c
Date: Fri, 21 Mar 2025 13:47:23 +0100
Message-Id: <20250321-jag-test_extra_val-v1-0-a01b3b17dc66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANtf3WcC/x3MQQqAIBBA0avErBNG06CuEhFDjTURFSoRRHdPW
 r7F/w9EDsIR2uKBwJdEOfYMXRYwLrTPrGTKBoPGYWW0WmlWiWMa+E6Bhos2ZbFxFh2S9jXk8Az
 s5f6nXf++H9WjZ5NkAAAA
X-Change-ID: 20250321-jag-test_extra_val-40954050a1f6
To: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, John Sperbeck <jsperbeck@google.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1500;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=V1kuVirUzH2nkyWLPiJEMJZeSr0lXGHfzJy65bU2PIU=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGfdX/FPFhpvFqkJqN3iGTeATAeIgw8EUpiWc
 uFR+zMa2BVTtIkBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJn3V/xAAoJELqXzVK3
 lkFPfJAL/RJDhNqBvDB4ZlliaKap+XBFny/pRlk5qJ+dvQS8sW+vmNPIciZJhg7giKcagOrfAAh
 GMnQ83x0sa2307sdt7pzOHKT0hHi0PxoJ+ifjT9fmNtZEgGixSV+ItF9woYnx8a4AZ3qs5ETsQZ
 EXPvLXPrt6RGQX2VtaietDAxKOmFQ7fj9KnXr5BS3rK4r5e12YJKo5yGs5kOa8fbrOXvIDKUcVN
 QHdq1YKZ8zfDE4UjxqScbUIQyWaxadehog7Jc3DPdB7WucQU8YyHCGTNp8CN82hBEYxvu3SRbYP
 x80/TXzWSa9Pf0nIMJnYGITm7im/p8GkA+Cbho+8JYyTUWj19/iTExtm8UGPwyV4vqpFX3ZcX5w
 UJxfpY8xqyjV2oJebrbraipCqvn5D3Ihk7naw9csbEeXAUTinsQl1cyLY4QspSxz8VHASkXqU9y
 bT6KSeP76eys4dqOsZB8/wCmPdMfYr7n4Eime7Kg6wLzprrzn9DxSqX077D1n+7/JjlYcXQ6AH5
 o0=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Originally introduced to sysctl-test.c by commit b5ffbd139688 ("sysctl:
move the extra1/2 boundary check of u8 to sysctl_check_table_array"), it
has been shown to lead to a panic under certain conditions related to a
dangling registration.

This series moves the u8 test to lib/test_sysctl.c where the
registration calls are kept and correctly removed on module exit. An
additional 0012 test is added to selftests/sysctl/sysctl.sh in order to
visualize the registration calls done in test_sysctl.c.

Very much related to adding tests to sysctl, the last two patches of
this series reduce the places that need to be changed when tests are
added by managing the initialization and closing of sysctl tables with a
for loop.

Comments are greatly appreciated

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
Joel Granados (4):
      sysctl: move u8 register test to lib/test_sysctl.c
      sysctl: Add 0012 to test the u8 range check
      sysctl: call sysctl tests with a for loop
      sysctl: Close test ctl_headers with a for loop

 kernel/sysctl-test.c                     |  49 ------------
 lib/test_sysctl.c                        | 133 +++++++++++++++++++++----------
 tools/testing/selftests/sysctl/sysctl.sh |  30 +++++++
 3 files changed, 122 insertions(+), 90 deletions(-)
---
base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
change-id: 20250321-jag-test_extra_val-40954050a1f6

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



