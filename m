Return-Path: <linux-fsdevel+bounces-38105-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6186A9FC0E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 18:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A7A7A1A92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 17:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946B2212B3E;
	Tue, 24 Dec 2024 17:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vMgFZi+L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E783D1CDA09
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735060294; cv=none; b=FzJT1Pbk6p9s/Ge8B/h1PBADIU5iRZIV6CswuqbXtugX0GZPwsIFExu+4izBlv1gAaBVXNaxCQ9t2eSwI+BhCL1oIXYM7aLOYIAJXY2kxCMqf8+zRHEu61RsaMEKxqiLG7nMfCQctSHjcDKO3icAnw3lwvCMyPzrs0Yqnv7Yz4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735060294; c=relaxed/simple;
	bh=asLAwQJicYyZLJC1MNZBxgBSJIeawN+3ejHDfNXwB+w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jCnc9RuKpk+vxbNM2xMMqnym77FMICPKFgGs8NqEYwzVHgr0E4qIMbzi7Z+ukAfzFW0hElyunz5f8ipv7YZan+XwfOCCmfeDtH5/qtIYrgrEFEhw2S6fkJ8ta+KyH8rEmUZY4uLgXFkMBlfzfDC4LG4uCRh7IGAwZws1OKgKCL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vMgFZi+L; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2efa0eb9dacso5515337a91.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 09:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735060291; x=1735665091; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KZY5Za5D37Z3up26nRyyJq//3SGwDKKcBKx13SsJE3M=;
        b=vMgFZi+LWDC9SMpgrZgTsWh8+bHW5C89Tusp1zUp6nR3P7SdvExnXGEfNxV1bJVGn6
         AO0rGKcQ8Fo1vdYD0p3Vi6O7TrpKVnen3HEg1wirhD5nfEcwjsbX5QW3TOuOgaUe7VaK
         eVfap3hTWe7XktrYzDZZ64YrYRNQpIRTgiVuPuHpbIk9skeUTvFMOm/dRNC3NyEbBqPA
         gH8TOCLg6LwjYTLNSO8Ci4A0YrQjHjsqjKGkwrKCWqmLDQzyE9zp49unvg4b9puWP2VJ
         /wPBBWMSrZ+VWCB3ssfalxPQfuYKE1ew3SYU8OKxSsW5dYOHgoBSO19qI6eRBXCFKS2h
         J7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735060291; x=1735665091;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KZY5Za5D37Z3up26nRyyJq//3SGwDKKcBKx13SsJE3M=;
        b=jAVh3sNvGI9hMi0ouMBP+79xgKWbgGxOfAWcTzePR0eQ0e0A254vVG/wMyszYzxpn+
         ySCDSLXvljoSPLP/YkyO9mWBQ7HFCFoWbO+FRIXPH/ADe3D6FlvDyisp41HRkCGGxkIF
         kyTeam+7wQVHYV3qf4AIPHSthxexh1LHL3AtE4g/k+3mwDvPKIlyWetkDv7yqw6eza8R
         q0iCpGyZeoFbppQTAmH/aVY98uWu6RlDzSZDPvZTWtX3XFfXXH825UWpU2btWWeLfvuF
         Nj9pjzyu/8vLEatKjKwU0owbeEyVnz3B/LcaeZzniMUy5nlp1BfHcnvjYdANNR0jBAjy
         rdpg==
X-Forwarded-Encrypted: i=1; AJvYcCWU3IR3UoD0HTDE8Mo0IZNMpZjHlXhdi3Zn6zP6hBhjuDRHolPMnJTlXRM6CnZJBZpWX5YIaHIhUSLMtGp5@vger.kernel.org
X-Gm-Message-State: AOJu0YwgrRVj9spgZ1W28/7sx+3qtFraydXIgsr4WV5J+0JtdvONhc1q
	6Qii5lDT3DVcNbchq4WUudUrCD3k4tgTOhWZsjVaEoW+CWDtU65rvCGsqFUGZZ9wkb1M0/8pN8z
	BNJLNgp93lj7cBw==
X-Google-Smtp-Source: AGHT+IGCBmJDOEpowr6QdeLBoNzr3MO0MLez0iKB9/7oHCQdnyWAWz6JtbU0Ea/Ch1TDLlG/7Fvc7IZUAuxx8XE=
X-Received: from pjyd15.prod.google.com ([2002:a17:90a:dfcf:b0:2ea:46ed:5d3b])
 (user=jsperbeck job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2649:b0:2ee:dd9b:e402 with SMTP id 98e67ed59e1d1-2f452e0e152mr31990027a91.12.1735060291269;
 Tue, 24 Dec 2024 09:11:31 -0800 (PST)
Date: Tue, 24 Dec 2024 09:11:24 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241224171124.3676538-1-jsperbeck@google.com>
Subject: [PATCH] sysctl: unregister sysctl table after testing
From: John Sperbeck <jsperbeck@google.com>
To: Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, John Sperbeck <jsperbeck@google.com>
Content-Type: text/plain; charset="UTF-8"

In commit b5ffbd139688 ("sysctl: move the extra1/2 boundary check
of u8 to sysctl_check_table_array"), a kunit test was added that
registers a sysctl table.  If the test is run as a module, then a
lingering reference to the module is left behind, and a 'sysctl -a'
leads to a panic.

This can be reproduced with these kernel config settings:

    CONFIG_KUNIT=y
    CONFIG_SYSCTL_KUNIT_TEST=m

Then run these commands:

    modprobe sysctl-test
    rmmod sysctl-test
    sysctl -a

The panic varies but generally looks something like this:

    BUG: unable to handle page fault for address: ffffa4571c0c7db4
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 100000067 P4D 100000067 PUD 100351067 PMD 114f5e067 PTE 0
    Oops: Oops: 0000 [#1] SMP NOPTI
    ... ... ...
    RIP: 0010:proc_sys_readdir+0x166/0x2c0
    ... ... ...
    Call Trace:
     <TASK>
     iterate_dir+0x6e/0x140
     __se_sys_getdents+0x6e/0x100
     do_syscall_64+0x70/0x150
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

If we unregister the test sysctl table, then the failure is gone.

Fixes: b5ffbd139688 ("sysctl: move the extra1/2 boundary check of u8 to sysctl_check_table_array")
Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 kernel/sysctl-test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sysctl-test.c b/kernel/sysctl-test.c
index 3ac98bb7fb82..2184c1813b1d 100644
--- a/kernel/sysctl-test.c
+++ b/kernel/sysctl-test.c
@@ -373,6 +373,7 @@ static void sysctl_test_api_dointvec_write_single_greater_int_max(
 static void sysctl_test_register_sysctl_sz_invalid_extra_value(
 		struct kunit *test)
 {
+	struct ctl_table_header *hdr;
 	unsigned char data = 0;
 	struct ctl_table table_foo[] = {
 		{
@@ -412,7 +413,9 @@ static void sysctl_test_register_sysctl_sz_invalid_extra_value(
 
 	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_foo));
 	KUNIT_EXPECT_NULL(test, register_sysctl("foo", table_bar));
-	KUNIT_EXPECT_NOT_NULL(test, register_sysctl("foo", table_qux));
+	hdr = register_sysctl("foo", table_qux);
+	KUNIT_EXPECT_NOT_NULL(test, hdr);
+	unregister_sysctl_table(hdr);
 }
 
 static struct kunit_case sysctl_test_cases[] = {
-- 
2.47.1.613.gc27f4b7a9f-goog


