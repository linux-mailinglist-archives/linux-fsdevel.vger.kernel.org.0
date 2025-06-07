Return-Path: <linux-fsdevel+bounces-50898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016DEAD0B80
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 08:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1BA616EBBE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 06:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6078C25B1D5;
	Sat,  7 Jun 2025 06:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="UJ23Ly3P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654ED241698
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Jun 2025 06:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749278427; cv=none; b=N8luixYRJmmVxIvqvZF1vZuv1HngLocGjP8l9q/duQHHHCJHyNuzvOATpw8ReTKPmnl9mpDzQKvN+MrJWM28iduqhaBv2x8TSyiiiJghW+DWVj6Q4Fm149YUeZzAlxsjFLrMjVh6JrDwiEISptGfQQ6oQE2XB3PSIusr42nyRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749278427; c=relaxed/simple;
	bh=BCiqmyiBck+kr/OASD2ROBkgeX+5AW3Pps9lr6jrizo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rjQtsU6qRet3Y/S3LEEWEjlFUai9ltmWgyVSQyiEiXyNlLM4fCpROmEVEYhyVkJzyWfPgZUOJPCk3NrZdxbWmIJTYgpqSb6/EBWTAIG275XU1MqlqkLTrbAVecTaCzh15EkWPX/smk+KB7ul/VQ/qZg9uvUaxlkfiByX5Mok1Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=UJ23Ly3P; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5575qprv017480
	for <linux-fsdevel@vger.kernel.org>; Sat, 7 Jun 2025 02:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=NCb2N0Fk92a1P9JTghKE8MY8Out64G9+V7YULXAPf30=;
 b=UJ23Ly3PeQAsrR9GxRQF+LR37pMg61M2pNRwZFHWN2ngpt1OnwDq+m0fnF1OXyjanmOq
 h1MaijbAfqApYu09GD66kyIxBrhGJ9/oFh9b/kExIpb5sHJua9hJAdMrYhQwIyp+gANG
 mTns6/G3b+UGWuGsKmprp2PGpIsWro8+gySO/Oy/Ec1VWVMy5/NfnO+vqi+GD6kEfbbM
 o+WUot4Bd8ArzATXdFsSqn8mwtie2Hk17V5Gr/Up/CVEnrzP1sGIhNPvz4f6+JRZQS/8
 3aw7a7cW68SLJ9jWBpeBOcZ5rb+677ic/l3sT1GnnI2Z96FJW2sRaDVJiGa2NVmHzG4M 3g== 
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 474ehw088s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 07 Jun 2025 02:40:25 -0400
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-742b6705a52so4253390b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 23:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749278424; x=1749883224;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCb2N0Fk92a1P9JTghKE8MY8Out64G9+V7YULXAPf30=;
        b=iwjfq3Dy9CTp6kfmJbyjc5x16bqo7W8DAb3kdbDy+lv03V4Rz2jKWudJpgEEdHR9nN
         C7BEB2H66S3D07TdRy8GczUlb0dLGY86H60qyhIESQ86aj2loxQmo95T4vxR1EZI5eht
         Cjcmeck+hVRjG9vfoD4mLkqcDq5bVWCLTc2VRJ7j1A4T01IRJgDxaUvvsZ6UcigKkZHC
         9EV8WIsY8Z9A12b29OqHgAYB59iFEOcAjUbIYGTWRUZXEa2vcH7N+2mZfoqouRkQI3nE
         8VIoi3FFpbigY/NuY5gMf9yDHEXDFsDEt2hVBJPsIv9gV3Ozi/WGnz2/viDXWLm7mk/M
         RU9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3cCdXjFShPX91JeSIhV31o1qD8HLXcZuCESAEUtfgYY8emcxbZVKxjBG2SuSNc1kavHEdiz5JNTHiCUE9@vger.kernel.org
X-Gm-Message-State: AOJu0YwjtQJlRJCduDOWmoqSUeVNj5blcBFpv1uyWeR3v4Gfj5gAGsa1
	FLiVHj4h8+ljTK4kqLdwx/SN3HBF8K4Vu4bYtRMgeqSWFi9vhzToNo2s6lE1UYtPsLZYw4GQkUB
	HNekzsEEhL3K/Hc96kQ0yT0OmBicswEpPyJCGruuOWHs8jOEJMw6MInVXI+j9K5ib+D/+mKU=
X-Gm-Gg: ASbGncvE4SBqdYbA7B4keTetWqwsVkarayIiWDL/XlBPne3Rjo8Fuslke874eIfrynL
	r3oziH8MOlAAUQBJYuC92ZQBujtEhH5YJFYQdcyfvKz4uZFLGAYGBuy88ybvTnlB8FJHuhS7KNe
	WhqLguVCBxXiCl6FpBLxxwx9F6vhWuNlwFCuDkVwi4TEUsIX4o2Pvo7Vzv0DtHTdnkYMigrkQ8n
	akGjSZiMUH6O5Q17kXxq6CWuCfZ1p8CXfG+AbnM3RW7OCaraLyT9FECMOk3JnRBBuC9f+OvCMCD
	F8n1SM1rXhKX1YsrBauRMQ/m3bmUjufkexLzQMbLW+Qzlob6dtnnjCOHGQ==
X-Received: by 2002:a05:6a00:1796:b0:736:3d7c:236c with SMTP id d2e1a72fcca58-74827ea6519mr7668151b3a.14.1749278423867;
        Fri, 06 Jun 2025 23:40:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY98CY2YVyggGLeAbDV8ar/PXW0sOfH78h7Uor9zXD3xjSJRiEh9rmijJ2dx5XASHXOijwJw==
X-Received: by 2002:a05:620a:1921:b0:7d0:98a1:7aba with SMTP id af79cd13be357-7d22987fa6emr771839185a.17.1749278411587;
        Fri, 06 Jun 2025 23:40:11 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ac95e5sm24461256d6.43.2025.06.06.23.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 23:40:11 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 07 Jun 2025 02:40:03 -0400
Subject: [PATCH v2 4/4] userfaultfd: remove UFFD_CLOEXEC, UFFD_NONBLOCK,
 and UFFD_FLAGS_SET
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250607-uffd-fixes-v2-4-339dafe9a2fe@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749278406; l=1546;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=BCiqmyiBck+kr/OASD2ROBkgeX+5AW3Pps9lr6jrizo=;
 b=ejkjZoE1iwXmZVjGzc4EEQx+Dppi+NjcO9zdi6poqefulL2rmdjseAjaKNWamrHSbTvuzD+FU
 fLY2ZocKMooBdDYNZGuFJ7IfSw+VD6eiII8yG3hEK03A2qopBgdanbr
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDA0NyBTYWx0ZWRfX+FlGAVe+hU9o 38WlB+IsiQrcxTI0oPk3yW8ik1DcVu5IX2Rj1ja/1qq3SlrjWGklD0sy3+/QWwj9aXV1ekigbaz Br+oD8cnvH5JVWAYgNslYUoo6nwf2yczyvdYxrXMJfLwUZhhmvqwnW1lYZBzIVCFBCuZ2wLBzhE
 3yGKvO9TP+pzWOf46bNawCQrvTExGtL9rCXgqCrM3jejtkV4DIOx+y8I3VSdyl85+buvQmPwB9N mkZZFsPfI9/0OxEBaCMFRwb25gh8JOOSKaS83HGWmiXMgrxN2piUajbgfBhfqHoygvb3Lr40J/u mDWyZhLRAfXhy7f4gNV54EkQaWfJ27sXGsmsblxqn50KpgTjv9k/GcDNo3S86CRRAPBL8gZDYT1 Acv4D5z8
X-Proofpoint-GUID: oSQdiyIcGR4DODkkehZQ7hKt7uecJu8h
X-Proofpoint-ORIG-GUID: oSQdiyIcGR4DODkkehZQ7hKt7uecJu8h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=10 impostorscore=0 mlxlogscore=508 bulkscore=10
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2505160000 definitions=main-2506070047

UFFD_CLOEXEC, UFFD_NONBLOCK, and UFFD_FLAGS_SET have been unused since they
were added in commit 932b18e0aec6 ("userfaultfd: linux/userfaultfd_k.h").
Remove them and the associated BUILD_BUG_ON() checks.

Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/userfaultfd.c              | 2 --
 include/linux/userfaultfd_k.h | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 10e8037f5216..ef054b3154b2 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2118,8 +2118,6 @@ static int new_userfaultfd(int flags)
 
 	/* Check the UFFD_* constants for consistency.  */
 	BUILD_BUG_ON(UFFD_USER_MODE_ONLY & UFFD_SHARED_FCNTL_FLAGS);
-	BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
-	BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
 
 	if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | UFFD_USER_MODE_ONLY))
 		return -EINVAL;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index f3b3d2c9dd5e..ccad58602846 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -30,11 +30,7 @@
  * from userfaultfd, in order to leave a free define-space for
  * shared O_* flags.
  */
-#define UFFD_CLOEXEC O_CLOEXEC
-#define UFFD_NONBLOCK O_NONBLOCK
-
 #define UFFD_SHARED_FCNTL_FLAGS (O_CLOEXEC | O_NONBLOCK)
-#define UFFD_FLAGS_SET (EFD_SHARED_FCNTL_FLAGS)
 
 /*
  * Start with fault_pending_wqh and fault_wqh so they're more likely

-- 
2.39.5


