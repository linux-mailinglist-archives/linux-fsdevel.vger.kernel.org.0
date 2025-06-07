Return-Path: <linux-fsdevel+bounces-50897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90ECDAD0B7E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 08:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21CA27A8BD1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 06:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C47325A327;
	Sat,  7 Jun 2025 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="GeQQw7Dg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00F258CC2
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Jun 2025 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749278420; cv=none; b=RfwAfqPV4sIr+kzDlb9UtPbyVhDwirDq0lNp7KrbhUmn+WC4Bx1nb1eHu7k5xXa6lhSD1wft4ms2LcSFapneLSkHkfDUarhCciZ4jwkUCCbTHhbu1sZ0NKt5vUBVSM1N1KpSF9rq4u/P3ilW8YwdD5OEeJ6NQilhH8k14j8+pjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749278420; c=relaxed/simple;
	bh=ZV6IvBG9rODNxyRdIe9D1A/OZu56meo0GhXdqsXp4+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jFEORtPijgtyB/ZjspTdYKc+Tsv6QA1cbF+31xd1nlsJQJzF+HJskLBikAnxzP+CUMX8YcgJFr0c0uA/1DkvZC5pNyW66CzA8anDFT3gatOiSFMrfAdDZtsV7jCX3hqSTX/tfY85ae+x1r8tz1xVTHhWYV0jgk/sjwLkk157KrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=GeQQw7Dg; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167077.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55758J5s018356
	for <linux-fsdevel@vger.kernel.org>; Sat, 7 Jun 2025 02:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=O3hRpBEKykTos0eYdysg7Qljwq5u2yLqFXW9AcwF/YQ=;
 b=GeQQw7DgwSo8C5AIrIb3odSN5wUmysiIVlawRTjxm4i0/HUJAiZfKx+wIGq0ludDH0ji
 KR01EwmQf3b/m4cTxErPkmml76GEY1TexpZNZAOzvwvOuI10phmbD2jon2fGe7j22rYN
 nyyQfou7Gae9i3pcaRgVV3NJ/KeLCFuiP9ctIDIZx1RtagnFeHeqstmgh+aMZ1UJ+F6O
 PyT8M8nBxEZAiFgCaw/fD/lp/6IHt7TCGisCkMQGdbsWyycw96+k4vMOzJJCaFLvqglb
 4nWiw24sKQfJAA0HvHhJog71aodH0h/YtQVEtmTTH7cDj3Zs7TdlQP+Rlj5VBJyn8lBG uw== 
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 474f0wr5x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 07 Jun 2025 02:40:12 -0400
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fab979413fso53366216d6.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 23:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749278411; x=1749883211;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3hRpBEKykTos0eYdysg7Qljwq5u2yLqFXW9AcwF/YQ=;
        b=n8mOp7RXrlQjA+5S1hZbzQdQ/VOK08mwl+GYJ4Chiv+xha21ZJAZf0gwFh469UZips
         kFYLftDRVppiuGOuOjPiaoMh2r8jr9xWZv2TQLPPg4z0+jiZ5ojBWzLNpNWRj85zU5iy
         ad8xcfr1pjWnx2e+Q0piqxlmveBvGkugoxVD1EvabDZZUTR0awjfKCl0k0q8SuF5gktx
         FSaS/75Ks9TdzKDjHpHB8mcoL+L8+964yLLRoihzTshZB4oS8cQ4iCm8gkSyhid19WCk
         NsUcCkzNldp6taT5vfrQg/e3IxeWtvpmvm+RM08b1JY8OkswYnLfoHyFAnsDNkHU5T1o
         FDKA==
X-Forwarded-Encrypted: i=1; AJvYcCXcOXI6nKT8pRZP93gLrdvvVehpaTtPMShl91w3SYECdftCodMlNn7dT6Evpxl88USdy8epSYemnU+85KRY@vger.kernel.org
X-Gm-Message-State: AOJu0YwwY7Lomcn2hvfzjKoaNsv0HfG3UWfvp2n4ePVZWjAJIufpfPfu
	qYfv6PDaGgcM/UQYFLWDhweB3OKbtccA0KsR94lqANILB6cR7yepROHJmVXcY33zIty/XVc5WxL
	TZctQ2xBJ8EeeIrH9/OFuzqQbPfHsqxyYUXAt6OMOXXVdHffbo8TSGOHUZzd2mCI=
X-Gm-Gg: ASbGncsyOWL67bYpyaAG6pdKQ3MI5QSSRz3ysGMI2l5WOfxVExzJwyol1KxYZZo0Q/+
	ao0DCwl1NrI8y7UMvXt0n3bCFcVOeiG/q1QZiJf6eBCxK2DG8kq0r+kuCOdtNa7OOea0e4jdWGZ
	HwFUfTV5ncztxl3w2z7FgtQxSD3JWrzKbFVwafXevFvw7xF9jlSOXyWYwqMQyOhvg04N1VLcSPj
	H2Lfjo3UvcFoi9P5ZqsZtiId9DiwVUnXdkMz/NDAnze5PtYuU3yHkcr3pW6bKsC+/e33sEjx6u+
	oz6knRWmCk49ZNGhPzL8GS/lrWO9jTh+6FhEMcgarJ/8g1cxHFyfK/h+/x/lhY/yxOM9
X-Received: by 2002:a05:6214:c29:b0:6f5:3a79:a4b2 with SMTP id 6a1803df08f44-6fb08f5a53bmr101411546d6.14.1749278411227;
        Fri, 06 Jun 2025 23:40:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmVrk/VdZ4ByYAP6ObydcI2V+4WHKHTrNByFsQ6SroU2GDeGkFxy7AqxcuptII4nzRfd/vNg==
X-Received: by 2002:a05:6214:c29:b0:6f5:3a79:a4b2 with SMTP id 6a1803df08f44-6fb08f5a53bmr101411316d6.14.1749278410836;
        Fri, 06 Jun 2025 23:40:10 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ac95e5sm24461256d6.43.2025.06.06.23.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 23:40:09 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 07 Jun 2025 02:40:02 -0400
Subject: [PATCH v2 3/4] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250607-uffd-fixes-v2-3-339dafe9a2fe@columbia.edu>
References: <20250607-uffd-fixes-v2-0-339dafe9a2fe@columbia.edu>
In-Reply-To: <20250607-uffd-fixes-v2-0-339dafe9a2fe@columbia.edu>
To: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749278406; l=2794;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=ZV6IvBG9rODNxyRdIe9D1A/OZu56meo0GhXdqsXp4+g=;
 b=cbRiuPYOlDNC85xvdOnlaqM/TKAJAmMIkwYerXoRYFE+4o6gzxXLjI8Dj43tZLoBroYGTs5dk
 1vFeBnd/qJIBrk2shfUuxz4u8JfXfa2uUChkESjNV74hDtToHHfWXG+
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: d98gqQVEpe4nTkbwK5Zzzo3p5GZ9ymYa
X-Proofpoint-GUID: d98gqQVEpe4nTkbwK5Zzzo3p5GZ9ymYa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDA0NyBTYWx0ZWRfX47Zq6mVSB11J bzfkKZCwxIntDkEBkSboeNtnS27+YtedIqA6597sVidMCGOMcoHClECynwQ1Wknf9q+R1P+QRtD kfbMImxiQFpJnS1q5ARBawKTP8vump2RlqBcIUy/GDa9OCGlMS0cS5Ms/Jd4Vx06Ek31wJP4O8B
 w4O2JdnGpK5M0XtQC2FJ7eirvnh13j6y9yk1Fhz5vzQao0Dsy33VRUlZzaebEr0gz0qupIpvlhi flKv52COX2k43HOTGbMDYaSL21/GaF6MnmAUgLNYjgoUO3ecEXfuTVHqzc0gF/JrfbrMvjNN2QK gYn+f7FMqSfcEowke2ZMOE4rNgXnhP/ekkmqHpXcqWk+G0v4fVG4a9XzqXT9S+um0M1A/+WlIq/ 749VDuLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=10 spamscore=0
 mlxlogscore=830 phishscore=0 adultscore=0 mlxscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=10
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506070047

Currently, a VMA registered with a uffd can be unregistered through a
different uffd associated with the same mm_struct.

The existing behavior is slightly broken and may incorrectly reject
unregistering some VMAs due to the following check:

	if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
		goto out_unlock;

where wp_async is derived from ctx, not from cur. For example, a file-backed
VMA registered with wp_async enabled and UFFD_WP mode cannot be unregistered
through a uffd that does not have wp_async enabled.

Rather than fix this and maintain this odd behavior, make unregistration
stricter by requiring VMAs to be unregistered through the same uffd they
were registered with. Additionally, reorder the WARN() checks to avoid
the aforementioned wp_async issue in the WARN()s.

This change slightly modifies the ABI. It should not be backported to
-stable.

While at it, correct the comment for the no userfaultfd case. This seems to
be a copy-paste artifact from the analogous userfaultfd_register() check.

Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/userfaultfd.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 80c95c712266..10e8037f5216 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1466,6 +1466,16 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		VM_WARN_ON_ONCE(!!cur->vm_userfaultfd_ctx.ctx ^
 				!!(cur->vm_flags & __VM_UFFD_FLAGS));
 
+		/*
+		 * Check that this VMA isn't already owned by a different
+		 * userfaultfd. This provides for more strict behavior by
+		 * preventing a VMA registered with a userfaultfd from being
+		 * unregistered through a different userfaultfd.
+		 */
+		if (cur->vm_userfaultfd_ctx.ctx &&
+		    cur->vm_userfaultfd_ctx.ctx != ctx)
+			goto out_unlock;
+
 		/*
 		 * Check not compatible vmas, not strictly required
 		 * here as not compatible vmas cannot have an
@@ -1489,15 +1499,14 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	for_each_vma_range(vmi, vma, end) {
 		cond_resched();
 
-		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vma->vm_flags, wp_async));
-
 		/*
-		 * Nothing to do: this vma is already registered into this
-		 * userfaultfd and with the right tracking mode too.
+		 * Nothing to do: this vma is not registered with userfaultfd.
 		 */
 		if (!vma->vm_userfaultfd_ctx.ctx)
 			goto skip;
 
+		VM_WARN_ON_ONCE(vma->vm_userfaultfd_ctx.ctx != ctx);
+		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vma->vm_flags, wp_async));
 		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
 
 		if (vma->vm_start > start)

-- 
2.39.5


