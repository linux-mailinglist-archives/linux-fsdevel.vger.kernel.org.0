Return-Path: <linux-fsdevel+bounces-43078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC3FA4DBBC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 12:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D5E7A6AE0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 11:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841D41FECA7;
	Tue,  4 Mar 2025 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="T1qpgAmI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940A91F4CA6
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086208; cv=none; b=WDZmR/15OKE5XtFpYL1GfH36dLFDNtSu9ab1h1W8g8oi5unjOihe5p++4qUS9PtnGFqxYSIbu/AC4b2OdHTpo6Dc6cPPcMCJKTRBatIGc5nzbbUzTuW8wGvi8ITAq8pgejEtH+A0nrzOh83qSI0ZzASJRzV3pCWSdA8X6DDZw58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086208; c=relaxed/simple;
	bh=zqEaK6lshzIGNze+IgF53qRIWCWzyItSBvl64+V6X00=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MD/bxnlbF4rG9VyPNVeK4gvhftFXTlUrp5qiy67BFaaD8UpU/2uF1JstCDt3Rzo+4xJqHpviVkBMeull1hMBZ0Cl65SfPMOCv1MF0EHU23BfIz5nbCym5hNA37i5B4fe/NiJmVSqdvwQGF17N9i4lxVOtyuFVg4uVhFW2l2e6eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=T1qpgAmI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223cc017ef5so24042075ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 03:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1741086206; x=1741691006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SHtbx793tIAG1ciJBxRLA5mIHUNtam6m5RVXu4DBixg=;
        b=T1qpgAmI6q5tdSkdoroAWQzI6raC8vj1ekYmO0S00AvDGBQgvgqjyA9DypK1bqBc26
         CbnCYspiGfGNGr6IVKoIP1U4Dam0zCNg2KVnQGCQ/C4thCu7UZ0LY6JJpbbq6mdTOnIQ
         eQ3i897loaTZmOEKLS+oUIExdNtaATLU+XLtO6AhgWtCfWJBbG8rS+B3roXbgs1SUTeA
         neGmFQRfnxWWa7dQA/4qcaZ1bqx2B2sktTfz5JbhfmVn0LJu79iPvNDbsBSS4XKnUtEz
         aMsGUeM/3jUp6VyzxWj8CfM8s665S7gMmBBUCfVBLJ1V6iwPsJrDaKnqoPSZ8VTJ4q3B
         w32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741086206; x=1741691006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHtbx793tIAG1ciJBxRLA5mIHUNtam6m5RVXu4DBixg=;
        b=njHv57tfNMx/NJrhfemEhyD24tL1dTbwi24wGnmAu7hlNHPm5CCSpuKR63rbmETsj9
         ZiOjIuAsVOywupfVYSY81bkPGGEneNCad7EofWCMsaSnXmUxIOLZwC8eElnm0W2G/Jlz
         Wb3Nn7L+e+gCZY7zuJwzO2PLyp3zwHWtDO1sFUxUHLRTU4Mbqw9fDp2lhL/dNmneIFkD
         ImnBdf6o52aIFh6u/XEbC2nF8G0w6iz/ET0TlR2DfzZhhSW0GRyxNsUX3711gc4dEtkO
         9z9QqOwN48GrjT60XeSjRsnK5xvgLY5Q9gutAgoRUtdf1X+RLI9Bh/cAz+rfoJugcx1n
         D+TA==
X-Forwarded-Encrypted: i=1; AJvYcCUtkNAZ97EmSKCBWUdAFVvTwVkNkgHy8JggjsO7RGXmOI+N5739l/4ezKft+qqy8T4KyLdbO9XHJsAOJUWV@vger.kernel.org
X-Gm-Message-State: AOJu0YyXHnPSBcBCDyjAvf6j6+hYYFlrqwTcFFnrl0QpNZ0xniXasmVD
	Uhmt3H7nICIUzuVVrtz2dCBR/RPXnI/KEQGsn6Rc1WwqavoC+OTazkfzHS6KWcU=
X-Gm-Gg: ASbGncvRo77SQ81yC2xnfUMGrlMYsP6ZQr8YoqQDfYNHeRHWNGqcqkr4oQzGFze4Ovk
	TGOmbvOcefgoGZvbiHPC2YOdIMxyOoO/UfIxUr0ISJ/gwXHw22AFWI5ZjsnZfOXoujal60F0MmB
	YviopUTQXHcKfndMQWuetmoZkwfljfSjNRZ+2hbcWSFaR92L0VhEdKLXK/FQjUufZMVUFEvlY3b
	pcrwZlNXjAG38X5Vs1OCLh636uy1Ck9Sx8J27+fVjE9NWmw+/Pm2whGkQMx5dxoyLjyXMgPgMG+
	CRxxyj0incaNVkZtjvy8PbXQ/IQgDA==
X-Google-Smtp-Source: AGHT+IEmfNtA9j59gyV0N5Y1sufC0pIIYm447vAhwkKJoR7YVLQIz4BOAJdQRHPoFR2B8LBfRVy0ag==
X-Received: by 2002:a17:903:2307:b0:223:65e2:2f1f with SMTP id d9443c01a7336-2236924e56fmr240292725ad.33.1741086205808;
        Tue, 04 Mar 2025 03:03:25 -0800 (PST)
Received: from localhost.localdomain ([143.92.64.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501d2778sm92764415ad.36.2025.03.04.03.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 03:03:24 -0800 (PST)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: tj@kernel.org,
	jack@suse.cz,
	brauner@kernel.org,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	ast@kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 0/3] Fix calculations in trace_balance_dirty_pages() for cgwb
Date: Tue,  4 Mar 2025 19:03:15 +0800
Message-Id: <20250304110318.159567-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

In my experiment, I found that the output of trace_balance_dirty_pages()
in the cgroup writeback scenario was strange because
trace_balance_dirty_pages() always uses global_wb_domain.dirty_limit for
related calculations instead of the dirty_limit of the corresponding
memcg's wb_domain.

The basic idea of the fix is to store the hard dirty limit value computed
in wb_position_ratio() into struct dirty_throttle_control and use it for
calculations in trace_balance_dirty_pages().

v2:
Adopt Tejun's suggestion and split the renaming code into Patch #2.
Pick up Tejun's Acked-by tag in Patch #3.

Tang Yizhou (3):
  writeback: Let trace_balance_dirty_pages() take struct dtc as
    parameter
  writeback: Rename variables in trace_balance_dirty_pages()
  writeback: Fix calculations in trace_balance_dirty_pages() for cgwb

 include/linux/writeback.h        | 24 +++++++++++++++++++++
 include/trace/events/writeback.h | 33 ++++++++++++----------------
 mm/page-writeback.c              | 37 +++-----------------------------
 3 files changed, 41 insertions(+), 53 deletions(-)

-- 
2.25.1


