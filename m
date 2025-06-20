Return-Path: <linux-fsdevel+bounces-52279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA50CAE10B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 03:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0043BB3CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 01:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178AC82899;
	Fri, 20 Jun 2025 01:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Wl5qVVaj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66EF70805
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382718; cv=none; b=ZyDWOzERDSVNIl3nefwaIixo/BBDDPe5rmdMXax7aciTObt1mjtyKDFeGY5EJjVJKgtjKx8vnKX1DLp+Yg/UX9cNNGSYM+3mPuW1gDPi3pWvV9KWoUcQ2bntNKgMtSGktk0d00us+cdt70T07E9KK1FxBODr0J120YVbbSg4rXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382718; c=relaxed/simple;
	bh=ZE6H1UsaemZuuFtMzSuGkSE5yaVJfmesBRedgaKkURA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qvWPaM19iVmGTz7xTRibu+u8u4A2kq4MGPGwz9r3WQ5c4YVYm+KjYOCpY8S17M9GcQFb4BpRflbKCF7pyp2P+uqVYc57oX8NqkIf32iUAMceA8u4r1E9WfRry2GnuH3K5JcDr+64CqU/KOVNEokojbIhNkgcqEVzcey7C22zWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Wl5qVVaj; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167073.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JKDbcm020279
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 21:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=pps01;
 bh=GOxKSLo88/sXZwWQN7+1MNoBNEcUs8IGR6idhRWKuT4=;
 b=Wl5qVVajGyapEOBP/ZgYDieFsd7UvqoNRUOm0bpseTC3OM+CKNoaDul3A0QuQO6vJnmz
 TzFZhsnsZCsvk8O/AdfQVO2mrgVkto4l22ZM7YopRLvF8vY3mlOvrjGXJMXwkm5igrxk
 Esbu6SYWjtqkxxDTsgM144AsGcPz5+VqlsbzPwOxFb/Ba0uQYBCQTeyqVQG4jM4t0OZ5
 FauKl5ZaCCjFTFEQUbZw+ZtUDrachxlOwvnLrZKnJzAliHeXyNuJKO/QzSTPxMPjehCk
 DV8SrrOIZ0N4mWvX1Um87vUSGzl5VUph0pVgwAGKdJ0tEcUxjNKPtRuhBOi4kxI0fNxr 9w== 
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4794yg4h75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 21:25:15 -0400
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a589edc51aso32440581cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 18:25:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750382690; x=1750987490;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOxKSLo88/sXZwWQN7+1MNoBNEcUs8IGR6idhRWKuT4=;
        b=RnsqO/UPAdbxIkDRLpSZ1lVbP+GqR1+TJU5E96nxRB2QgDuOEofAVEyW6/JGyQHlq1
         CZHHjm/biGdJq7ljGvoc19eHMN7W0ug2H7Ycywbwom7VuTRoKyXH/S1mircX3Sh4O3JB
         L7Nbfq81eASJ+xMaWIRXoYa5e1qpFDGOenAoLfJYDUSYzJdBUa+zPtgycjez/cWj2zIU
         0u+5w/NIgGN/DwbLOH8EPtKROeTdP/TU61Dn6q3AlFGXquCkJCQDDR5NkyLXxvDQZFK+
         S06UnnUkn7NbxRdVnLOpVCKX0uGwQN5Zsc9HnA/rYibBUtlgC2sJhnH9gYx0XNJl9P9t
         DStg==
X-Forwarded-Encrypted: i=1; AJvYcCVckf4ULCg9147YGzFdqheHTj4TXyQEO4Hve6PsqLGB17HmN8sdQJf7Zbyg8C7fLp7L43uVz3lP78RNHpOH@vger.kernel.org
X-Gm-Message-State: AOJu0YzGUouzQ9V/yLEInx8iZkViJV5pywA8M1nLsCNqJtukcSlbmXYC
	JEWu4E41wEZpnqwE62u3owqN2PqDjvxgZpwHvtGsuZjZPcsWv36LuvSbFFxxkYxDKgYHRVw2GuT
	jhLbF7nR9V+QNmrsTRaX0Adr/J2glYrPdiv0+Jf9p7tBjKWuJ6gFRRqJHiWABjPg=
X-Gm-Gg: ASbGncvJBV/p42+dX3XBY2s1sWt1shC6GnwPJ4q5FlKzWAcRtGqZ3VuVBx9xzkSy4UN
	rfDtFjKizC2TSbNA7OIlCfRS/PWzCMqNU+03SUk4oSx5SUTOqdAtaJAZytcjTUamtQThsF+hPtW
	abQjgBWwveXIM/TuxcPIlbcnsfF+OwX2AGkRoG39JsBBHyT9ERTUM/XlJv5oNZKi3kPgDzw36Q1
	2qC075KeitIFrLbrpERCUlVrRNMdtkI4LVjy0cvOVw67gxGLVea1DXycce0wzojME1bxUGYLEEq
	j3pIeV7M44pybeYS/3pFSLF2UUykO4MN5A6itJk0yUXZWyEM3LMbIJ6MF+L09fDHNqdl
X-Received: by 2002:a05:622a:180b:b0:4a6:f416:48c8 with SMTP id d75a77b69052e-4a77a21e7a6mr19249451cf.23.1750382689871;
        Thu, 19 Jun 2025 18:24:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC9jHCGCp55sYm55ro7Kc20y+6lcgDMG8zlg8paNloPrfi/X7/VdzRZ4ySVIX6xJuzroxtdQ==
X-Received: by 2002:a05:622a:180b:b0:4a6:f416:48c8 with SMTP id d75a77b69052e-4a77a21e7a6mr19249191cf.23.1750382689454;
        Thu, 19 Jun 2025 18:24:49 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779e79c12sm3794321cf.53.2025.06.19.18.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 18:24:49 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v3 0/4] mm: userfaultfd: assorted fixes and cleanups
Date: Thu, 19 Jun 2025 21:24:22 -0400
Message-Id: <20250619-uffd-fixes-v3-0-a7274d3bd5e4@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEa4VGgC/12MzQ7CIBAGX6XhLAbY/lhPvofxQGGxm2gxYImm6
 btL66V6nN1vZmIRA2Fkx2JiARNF8kMG2BXM9Hq4IiebmSmhKlGB5KNzljt6YeSyVACykxXWwLL
 wCLg+8v58ydxTfPrwXttJLtdvphawzSTJBW9NDQfTgBNlczL+Nt470nu0I1tKSW3t5sdW2QZor
 XbYauXwz57n+QNJ5y/i5QAAAA==
X-Change-ID: 20250531-uffd-fixes-142331b15e63
To: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750382688; l=2062;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=ZE6H1UsaemZuuFtMzSuGkSE5yaVJfmesBRedgaKkURA=;
 b=h51Sumoe8WMQI0ow4ldHFipUTQo0+KGud2JGMHV3Z4Jp/FnieXctvfS3G6UIcUk8KBHKmttXs
 /uxZhxMsgciDp/5JmA2w18lXCk8p26Nd2DbvPPJsyobMopV4CLUTM+O
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: 5GwhPNwy971wpyK0Hz792BRzCdRBAOTB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDAwOSBTYWx0ZWRfX+KkvoSa/Qgtm +T/Evza1th5U5NRxu6UEITinIKwdkhwYBQdWaB0lNXYCqcrRMtjgNI93Q53ISAF8GeXGTxpkUX7 LujmkCzTs4D1wSH1EGe8Dga6RYCOxg4Ml7gvwY5aC4t8Bdbk9kHK8aDflXzYT3OzdnC5cKHd05F
 ZHt+X/Z6vXx716SbchDd0106GADw90QIbMRAAhgvgXyFeLeUS7qUbXObsvbb56wxGSmBIkMREx5 2Ddba6gFiZQKeOg2VniVmNVlanzjDcZ9wdcSGxlwOWOMkRAzCTQQXI8v9g935uTvawENyyIxSWk eYdmrelKJKOJks8h4+T8mIFIXSq4zVnW+BKp2sXYxJb7ReIhXt4L+NkaQOab/B9Ycf6qOd+71Q3 sKCXkzdj
X-Proofpoint-GUID: 5GwhPNwy971wpyK0Hz792BRzCdRBAOTB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_08,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=602 clxscore=1015
 bulkscore=10 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=10 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506200009

Two fixes and two cleanups for userfaultfd.

Note that the third patch yields a small change in the ABI, but we seem
to have concluded that that's acceptable in this case.

---
Changes in v3:
- Propagate tags. (David, Jason)
- Move the uffd unregistration fixes patch before the
  VM_WARN_ON_ONCE() conversion patch, as per David.
- Update comments and commit message of 2/4, as per David.
- Update the commit message in 3/4 with more details about various
  conversions, as per David.
- Convert two additional WARN_ON()s in 3/4, as per David.
- Link to v2: https://lore.kernel.org/r/20250607-uffd-fixes-v2-0-339dafe9a2fe@columbia.edu

Changes in v2:
- Remove Pavel Emelyanov <xemul@parallels.com> from To: due to bouncing
  email.
- Propagate tags. (David, Peter)
- Add a patch converting userfaultfd BUG_ON()s to VM_WARN_ON_ONCE().
- Move the "different uffd" check in Patch 3 (prev. Patch 2) before the
  vma_can_userfault() check due to the wp_async bug, as per James.
- Change the added BUG_ON() in Patch 3 to a VM_WARN_ON_ONCE, as per
  James and David.
- Reorder the assertions in Patch 3 to simplify them and avoid the
  wp_async bug, as per James.
- Update the Patch 3 commit message to include more details, as per
  Peter.
- Link to v1: https://lore.kernel.org/r/20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu

---
Tal Zussman (4):
      userfaultfd: correctly prevent registering VM_DROPPABLE regions
      userfaultfd: prevent unregistering VMAs through a different userfaultfd
      userfaultfd: remove (VM_)BUG_ON()s
      userfaultfd: remove UFFD_CLOEXEC, UFFD_NONBLOCK, and UFFD_FLAGS_SET

 fs/userfaultfd.c              | 78 ++++++++++++++++++++++---------------------
 include/linux/userfaultfd_k.h |  6 +---
 mm/userfaultfd.c              | 68 ++++++++++++++++++-------------------
 3 files changed, 74 insertions(+), 78 deletions(-)
---
base-commit: 546b1c9e93c2bb8cf5ed24e0be1c86bb089b3253
change-id: 20250531-uffd-fixes-142331b15e63

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>


