Return-Path: <linux-fsdevel+bounces-50533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02513ACCFEE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A6316FDE3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18375252903;
	Tue,  3 Jun 2025 22:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="u4dmPpXI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1055022331C
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 22:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990250; cv=none; b=FthoyaMLDjdi4xLJSOnq/nLeZvKsvLevouMRTgBgJLCmrBDliD2tWxlDoMbS7HabRtkkFjr+GRw/x5847s94dv0rXkCry75fHDs4sJcto7d9cFL2Z1x6cerdPLBUJEx+te7TWsi2dQWW0aMFLk/Fod/cXerGd0mVGD9rBCFZmEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990250; c=relaxed/simple;
	bh=Mhu5UgsGKVBtr694zPgKzOcZMIqd8uhkAolGEdGjAxM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y/FqdZ0TUFSSEhDOVRneQj/WQrrpccSwpeF2vQkTV1EfRu4an+xluJVCQE4KHOk14fW4ED9yyNxJEMYz7m7FZAIdik/qfpX+0SvsZe0cEbc9wNkEdTSI2EdsZE7NmnYDBaI3NGPuLZDXtG71sfKuS1RkSnePq6ml7fLR/VmuVN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=u4dmPpXI; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553LALfH005697
	for <linux-fsdevel@vger.kernel.org>; Tue, 3 Jun 2025 18:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=pps01;
 bh=pR5/XontXtxtAuJG6F7B70YU8ZyR64gw9geu5D2VmVw=;
 b=u4dmPpXIIMS133fFgojn5PBhvFIVLpvbaURdXnQd6TGtBsW8Vx9r4H2Y8307ukB8ehF7
 OAzWB3LLvxfrKVjw6XQRK7NjkeG6ucOFIQhgIcjUTIPy7AzxjpfBmo85VmEFBp01XOR6
 zM5eE3KlQx0lISUODrN4pg3JiDK6EHmujL1TdgSWHVqHOT7s9+CGYhOoEugpb+4BxHBs
 ko89rPM0+gxL89jDS+R2/9uw5QWN/PNvlMAxMeRDoyUVj45bfoeyKsZ9ELcCl+9cHIeN
 cp6A9AgQR8bltwiCVN7HgPpJ3OI6mZp/o6cT1DGMxL0zMiNs2fiox3XSVl6TbsgLPFyh yw== 
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 471fu7uw9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 18:15:19 -0400
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a589edc51aso61601161cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 15:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748988904; x=1749593704;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pR5/XontXtxtAuJG6F7B70YU8ZyR64gw9geu5D2VmVw=;
        b=W1hH46y2EbOqMTdwx5DoJVXzE0wqW+5afhScdXRXh5k4h+1XsUbyyWoKGgRDUdifpD
         X/Fab65BWbHQ8FBDcxROW3V+4+/G9FsRseuuNohtpaLw3+eFJlk8v6S4M/XgXnYGopap
         dqexyM7l3MehhVvoj94s8R4yc48nERweQBl1XbqZW923mHU3RyMbdA5bJO9XTSlljf53
         J9c399TZhtqKQZd6WtvJIuy/hE6Gr7X38vsFEg41y20bMIhzovcxVnUPdu3emUP6CRkC
         WuJuW9NnPT5nfTPAIISvSijBqkK3hZiSd2ppchUAfD5kpIml7rbxiJw5y0tWIuXXOW8L
         BRJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu5uqgEbWMPwxImjn0oeQOCjPi6LJsOH0xqwcwzl1mXgpe9NkRR5oyQ79ZBxjLGK2JlPsaSLKMzLe+JETq@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1ykk7lnae+AbMUucgXJgHErH4cJOyVpVkrnV9VPjx75fS5Po4
	dGypZhopHpNYNeU3aLQ/ZJnsKQ5APcYlm5KbMdKC2CKdJ8GvlA9NY0KppAOgllepZCx/n8vQl6n
	shoQjDeDjpsFvF5A1g8bgrHam9M72yev4pvhh6tKVg7Md3sIPDqQ0AZRKU2uF5FI=
X-Gm-Gg: ASbGnctM3djr4bBF8K3eM4lO0sW/vRM1kUbuIwm5PZ8WazvD9BAUNns8392oWDnciRq
	ft1Oy+yPMD0lDXx4hjS+6rCstgGvR2PNgdKGICdo2Cx5oE4Nwk6UDHkNqjftBAGqcNO8nkBs6Iu
	tOVbzPSt/E0xOzyPhovXHP8xAqybky1q6tdxMIIxJy2jXWmS9dLBh6WQeNQrNrc303piEP60wvd
	mdW0pzIYJcAzqjcMjiKzKkOWRcwkqYgplOfTw6qtSC+tGsoq1H5N3eyr9Reskvfg0ZeTtZ9Iwmj
	caKYr15PwC5Eop4U6nmkLG/Gy9HQTrXLT9D7fyNjoeXpWb+VDfrzNLsKtBbYRjdgnXOK
X-Received: by 2002:a05:622a:4184:b0:494:993d:ec30 with SMTP id d75a77b69052e-4a5a57f0bcdmr10800301cf.16.1748988903724;
        Tue, 03 Jun 2025 15:15:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxNXrwYeZso4epO+Rxc5EeKdK7iBln5yFli1M2Ii71UtbPVNvQj17eNdr9KOBrhoWgtfOe+A==
X-Received: by 2002:a05:622a:4184:b0:494:993d:ec30 with SMTP id d75a77b69052e-4a5a57f0bcdmr10799791cf.16.1748988903278;
        Tue, 03 Jun 2025 15:15:03 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-95.net.columbia.edu. [128.59.176.95])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a5919064dbsm33085741cf.53.2025.06.03.15.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 15:15:02 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/3] mm: userfaultfd: assorted fixes and cleanups
Date: Tue, 03 Jun 2025 18:14:19 -0400
Message-Id: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALtzP2gC/x2LQQqAIBAAvyJ7TnA1O/SV6FC51l4slCIQ/97Sc
 ZiZCoUyU4FRVcj0cOEzCWCnYDuWtJPmIAzWWG+8Q33HGHTkl4rG3jqHK3oaHMhwZfqF9NPc2gc
 VvqtFXAAAAA==
X-Change-ID: 20250531-uffd-fixes-142331b15e63
To: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Pavel Emelyanov <xemul@parallels.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748988902; l=861;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=Mhu5UgsGKVBtr694zPgKzOcZMIqd8uhkAolGEdGjAxM=;
 b=4q8yWH3RUQtdW6CPPg1ymoUjwCjvIh7v83CMiLiZGVa2qENAAcH/07MkUGP97IU1TtObvFyjV
 YN5DzKGNRbWCpE2mOJNC05z6Ya0oPs1o89uhFUs+wuVkFsiZHUJCoyT
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: FU6zMwQIodWvHV0C3SbCo1FAMAYwpje2
X-Proofpoint-ORIG-GUID: FU6zMwQIodWvHV0C3SbCo1FAMAYwpje2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE5MyBTYWx0ZWRfX2c8o+dbx7Uxx qowPStNeSJ2Ho6B//NKt1mpAHawer4lr4MNbf6plTCvQruNt6TdMR0CYpPMapaz4ix2j8EEvh4U j7UZCcB8+9r6kKvM0gdFpvDkGfOJFM+AfrK5oThYrbh8ZsnFP60hE2LpOHyLDzsIsTnfjgzUlq7
 MIdYnY4qPzBntHDQDrntNfAZBsBW+SqY4LJzR4QWnZbWrWiUZjULbNQex/obH1ACBOOA5zpGXJK Pu6GbP4XAHSaONTtpfdo+R3WG7vZn029hprAdEUyfT9KMxnr5IGtRI2qOOtUZmR3TxKuZ0WNFJO /tXUzrwKu+msSq4YyRHyextbD3MMshas74aODN+2H9lvpS3cLOJYgX20Rp/KbaQrZpE/yAiwzwD wG+hKea2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=10
 mlxscore=0 impostorscore=0 clxscore=1011 suspectscore=0 mlxlogscore=439
 phishscore=0 lowpriorityscore=10 priorityscore=1501 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506030193

Two fixes and one cleanup for userfaultfd.

The second patch is a more of an RFC, as it changes previously allowed
user behavior. However, being able to unregister memory through a uffd
different from the uffd it was originally registered with seems odd enough
that I'd argue it's a bug :)

---
Tal Zussman (3):
      userfaultfd: correctly prevent registering VM_DROPPABLE regions
      userfaultfd: prevent unregistering VMAs through a different userfaultfd
      userfaultfd: remove UFFD_CLOEXEC, UFFD_NONBLOCK, and UFFD_FLAGS_SET

 fs/userfaultfd.c              | 17 +++++++++++++----
 include/linux/userfaultfd_k.h |  6 +-----
 2 files changed, 14 insertions(+), 9 deletions(-)
---
base-commit: 546b1c9e93c2bb8cf5ed24e0be1c86bb089b3253
change-id: 20250531-uffd-fixes-142331b15e63

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>


