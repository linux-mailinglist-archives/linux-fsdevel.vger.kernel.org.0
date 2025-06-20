Return-Path: <linux-fsdevel+bounces-52278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692D7AE10AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 03:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0060D4A09AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 01:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3631049641;
	Fri, 20 Jun 2025 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="b3DP1ef0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1AC1386B4
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382715; cv=none; b=oQ2UOiUH2al2SDDq943+DufBXhk9z+2NF1DKSLVuX4ksU6k9qf5kngDHaKDzxhRKA/Y0pOqNY/byQjQzhLK+1Md3+9nxP4V4WltciDL4nqKogT/vzbUc7KTeW1x5fuxCHFyYwxewgPZyFLDhMExVDGjlNoQfCUro9YduOq440TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382715; c=relaxed/simple;
	bh=EP9W1OmB+wcjXQYUgIL2fq+FEVkI22zf392uYjNc/Kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gs2tl4oUa+xGsJ1okEA4kJd7U3znutmgeEZE2J4sCeXnTnLaFCq/vcYDBezw24IvLK5X9dBSVZR9jUo1Yh2d6cG5i581Emb7MNr6/PQp11Ig8NvJqVWM2/9QMNk8dsT8Ki/GlAcrDVq56OZPI81mEMGYCLRUdkOZUa0OEGoTKtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=b3DP1ef0; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JKL6Y7002260
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 21:25:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=y1DbwL1SG9nqQt6rgisMJIz4Tza+3QMR1zphzABvsLI=;
 b=b3DP1ef0ovPOnRNKCRG6SoL/WKc8apVbD69DjCrOT1sKDWfiKnlKsdrSy15K1J6h9SBb
 rlbQmR2U5e5jWz2wWyc5pIH6UIzQbI8fjaJoAoAtyMTbAj2qvGxTvhnEJYmJ1UbyTCfs
 XaCyPry8N6NaPpHtcDSXR6T8cXLjDC9ys5hidB5oSYU/hGEEqXGmonhRdDPmA/MTVq2G
 hAMmzDck/158YxVKophyvUhtaLp1x+k7SJQrXhe0d56Y2CRuawSGcpw7+4ApGutRxOsh
 tEQrq2iP+qRBf+ute9KIfZ9kwVi8+qwNH4WJLCQOKAnKrCfSeB624CirQhmE9K9YqP/P 0w== 
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 47924hmyng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 21:25:12 -0400
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a587a96f0aso34068551cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 18:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750382694; x=1750987494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1DbwL1SG9nqQt6rgisMJIz4Tza+3QMR1zphzABvsLI=;
        b=HyNESUrB8+TOoO0MmJSnbGcxTfAeecTOQttbJBJhzWPEVEGGmwpmry9DyDyyHrTKxd
         BrTstcPG/+qAXzukFsIJl8BtJkKwtpveO7hq0D+vXt5Nc1nlA6xG2q3NCf5BYE0ASRPM
         69gCfU1Rkt33tlkgTuYfoS/gpkbl9Gdazp9eRLT9z3AlkRncFyyqqV5yp3wg0ECLl/Qx
         ufwZmcDw0WET4xGoHTaSh7jXmzKIkXsV2/vtpkMs0Q73Cutm2dpst/SnN61HyVFu6pYC
         +cBkvHszeKKzsgMkkuI1NZRZWB0hyBoVtG2/z8zE8DNM3R91gNsh6hLXa5pfdai8sidX
         wmcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWctqrUwD+uB/DdZgHquY+tEXC1TOwL5OvkWzvrTmWGSwhp9J3zdsdXrvNAabKO7cr/38buRew9AXs7FTYZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyJg0kPdRyjN6Z3vsLxSkVdSf/FzBEpIyDuSrhBSfNyjeTMlE2p
	SpdCMx64VH08MHwVWPKbwTMzXRhe1cRfU+IUw+TAJZlXRhZCQ0wQenQ/VkHloc42jSoGTrAwu++
	FL9N3BMSXTImP0J6L2uOihbgIKoZldiKeXw4glm2N9wO/GnJiPi2eli9q5r+w5Us=
X-Gm-Gg: ASbGncvQXBts05KFog2zRRQMLp/Kxhf3JSRQcwFP7K4tko2RpRYYgQGtZ79WnbGX79V
	BgAEVw4NNWE7iQdnGc5hUazkCpie7RQgSajpzwPk7eJn09PNI5OI4gitoGZAxXE0Mdan5sqSNVF
	sdhsyGxZZnQ2MjBot9bO3Qd7Qyy9SoPwxZ9u2ZpRrAcT6kksoU7ar26Ox348J+cnlEcy9qeu3q/
	aF6tluLfL1hgmJYQ/XqbBXbh7ZJMozYokyTy6LnZ5Q5Cly7RviNgygMkfqo33L59b8cmyS5ht0u
	reZExyNOCqO4vs1hLEPKB3+pmMOlV1WFb1/0e3Lw+AvN9A1mTMtj+YVsq8JSke4q2ldT
X-Received: by 2002:a05:622a:134b:b0:4a4:2ffb:5482 with SMTP id d75a77b69052e-4a77a2cc1a2mr18298041cf.38.1750382694502;
        Thu, 19 Jun 2025 18:24:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdvZEXi3Vbfe/ihSwyAC6bOFZTIRmYu8oCTMk4/J2B2hDJEgqywAAZZz5rCDXLHlNnuSS/tA==
X-Received: by 2002:a05:622a:134b:b0:4a4:2ffb:5482 with SMTP id d75a77b69052e-4a77a2cc1a2mr18297771cf.38.1750382694086;
        Thu, 19 Jun 2025 18:24:54 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779e79c12sm3794321cf.53.2025.06.19.18.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 18:24:53 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 19 Jun 2025 21:24:26 -0400
Subject: [PATCH v3 4/4] userfaultfd: remove UFFD_CLOEXEC, UFFD_NONBLOCK,
 and UFFD_FLAGS_SET
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-uffd-fixes-v3-4-a7274d3bd5e4@columbia.edu>
References: <20250619-uffd-fixes-v3-0-a7274d3bd5e4@columbia.edu>
In-Reply-To: <20250619-uffd-fixes-v3-0-a7274d3bd5e4@columbia.edu>
To: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750382688; l=1546;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=EP9W1OmB+wcjXQYUgIL2fq+FEVkI22zf392uYjNc/Kw=;
 b=4m0MC8lpRu7JrFBUgKxSFn0CjaKQkdAzLnQAQrVX3RoGclBRGauwzPiHVkIISeEUPOieusAn7
 OZo32XipF0HBu7kDSe/Y3EbDpYR9WkGa6j1Q0UCU0Gc17bcAwqbVtH6
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: aevFTce3G-g-cF299fl2mxteTOWVTuEr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDAwOSBTYWx0ZWRfX4obz+sXsTzAZ i/Mz8iuDD37th9/IeyPoTrakU1KSLNf3eK5eO+c+AYibiwiUv8MJq90fkd7gDOepUP7LyyC/w1I 6+KxQzL77daNXkadHxfxPvbbeUA4r2x9yYhBmg/sHMxc21ChhyiTBE5MYI20chyqqkgWhrlCsPy
 ml4frgB3zIhy0987Z8E8Pf4RciJI3Eqc6zaAa0eq4w+mt7QOZ0e9N3SNaT6nVRsavVfEdDbHF/n Y4pFbpxiGD0Y1zwDrguI67x50NcjIRYlLggLdlxNhiMZGEBFHa46KQH1ZxJKs6iqmXJh07+agPt eWX9whF6U0DQ5GHef/WrtQPHKOCMDvSltlK2AthIqxAoslKl1sQvn5f4JrLv2XRdQIHQz/nEPiK QVD4RclB
X-Proofpoint-GUID: aevFTce3G-g-cF299fl2mxteTOWVTuEr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_08,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=10 bulkscore=10 clxscore=1015 adultscore=0
 phishscore=0 mlxlogscore=523 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506200009

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
index 771e81ea4ef6..a2928b0aec6f 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -2114,8 +2114,6 @@ static int new_userfaultfd(int flags)
 
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


