Return-Path: <linux-fsdevel+bounces-50895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD95AD0B79
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 08:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D25D3A9AA3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 06:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B201C7009;
	Sat,  7 Jun 2025 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="VoZQaagw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA90B1C860A
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Jun 2025 06:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749278418; cv=none; b=uvuHdtwu+hmodag4GAhLbzkWdUmxScpJn7zco2yrXiilY5QVsfqR98T5EuYKFBSk0MoXV0NjbnSfF2AqbRz+C/8cMLd3kzMGEqpN3Ti+Oh9vNJpXv9s/e7ft0B/7cul2fLZTBTIl63d2DLF2Nr8IywMKZC0jM+V+AF470HgkVDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749278418; c=relaxed/simple;
	bh=n8v8jQPEHBDi3OBta5pBlj9xOrKQ3fNVoKSw2MhnIFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/K0YfJrq/iLL8+u1Z4rs+xW72HZ4zaaG1nSPUmyxxRDAkPVppZGMbZkPyj29EumpgF5KlV7Ln86SNJuU4veujycjw3KGSSHsTMLSQpuX5qjoBjkfSbQtZJjJMzidsGPm+UKPBFBNEfm9Nbcm9259Y/nDIhIbQTXAPuUCJ72jZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=VoZQaagw; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167075.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5576UqAj025092
	for <linux-fsdevel@vger.kernel.org>; Sat, 7 Jun 2025 02:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=eaF9ZDIYfaNPwqo33y/LzhOGAoT+trG57Ins5sBuVJU=;
 b=VoZQaagwt5enjptpd1TPl1Zpsx9Lh8tfd1l1+TN2m8NquYeF6qRzFvoPHMwHfKLEW7J/
 qVFs1HsUl8OTJ+bwCWlGjyykPPSyFM1hMKLwuYBCeOi1BHqQIoSdi611Ru3eBYn9UEsx
 yjlPt6UC0QxmRNDcJSuN+yTd9fkOwy9QLn4izW7wtKTSM7TP5OmXoDPdKY05a07ng2DW
 U4FJ4tkMup1KSVmfZATnGzHOduYxGe0c5fhoxtLNaqk3hXKvnV8tL1AWCYvSEEnOiUU3
 UKM4DZp3DNpQecnEVE9YecJeeJoY5yHq91ZG2vtKg6MA8EvOZXZ6d3Ros0/ElAAjdZDf Gg== 
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4743n0mb0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 07 Jun 2025 02:40:09 -0400
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fafc5092daso48556716d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 23:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749278409; x=1749883209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaF9ZDIYfaNPwqo33y/LzhOGAoT+trG57Ins5sBuVJU=;
        b=Xva/hLvRbFy+YNAAq+ItIcvdCO2NJLUrrgv808vycctiu0SfOQIT9BAkGqYnFOuGKi
         /fSCi2Pdu/kdo3iCIQrCe2GJMLkNtBGDlbLl1FtKhZEUPa1uw9OHqym66kK+q9qLOxqW
         hqagg1cDLi8F17RmGQ3ox5gzu0pyt3/jQWE5bW6FLKkPfOBJc4GhOe32evDIpQC3pdGV
         JrA0Kmz6N3n+66ftgLq78TPMHQNKS5mtIKcriqqWCjT8wEKTtHz4wwzdXKSe6loe5Nda
         gsYOCPGpO3W6EeS+S1Kg3zg4nRfVa9gE+KatH6WhtX0Ew8Or5yD8kwfAb9iOAtAMIWtw
         8R4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXB1NO7D7IuaY7Ig9IwLWsqP9NkE1B4auvfMf/zMDDzyWaqbZ6KsmCX8UX3843/x6ahhJy7Ykxz6lDQVwnJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzZidBjrysIzfxeBIfFBSVSFI0KoZnpsJIvKc9KIaKZ2SzqrsH4
	F7y5FWzukMRcAADClq8ZSAB5Sz7lrvtQHdemVuz3KN8fC+rym6ltpbmjBooB9KjhtTSBStaq/QO
	1DNMRkfXS0qeJCM9iFuko8ql6RNVt+p2e4iJVJDLWIhyDQb98n1V3TAV6ngtBF+E=
X-Gm-Gg: ASbGncvYabRK9W211QQs8kCPAo0LPkbnO9kWCPTbg+rTJaxVmIkG0CWHS46hridPigF
	uClHy/U/sHcX0aVjdKo51KLbon5vZ+5lypqndwniKPdSjMfsj4KDK/mdu3R4tcc7CX4vpd8B8S8
	9IldKcqG/VDDLGPY3w1PC+kAaurMBA7w8dJ79LmraA8pWY0TaSLkunBrGGpDkKl2wxIyJVhGN7e
	M26Itztrc7uCL9NcEGMm4y7xh/QMfwk9cOJKI4Ao35YVniygJ1RKpri+J9Z+qE824QdVmLKExbo
	NcKe+cBVgBTVkO4pNFPVaz6AuCn/av9+xo2fZjjCJZAeWGC+L4vTzEz94g==
X-Received: by 2002:a05:6214:624:b0:6f5:1192:ccdf with SMTP id 6a1803df08f44-6fb0922740cmr85295706d6.6.1749278408746;
        Fri, 06 Jun 2025 23:40:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcjl9GUbUvEFtWZ3GsQ4g7VepvswlFi7U+0OrNlaG/MUErefc5q5qG7CspnMXy4V+lIvtikQ==
X-Received: by 2002:a05:6214:624:b0:6f5:1192:ccdf with SMTP id 6a1803df08f44-6fb0922740cmr85295506d6.6.1749278408385;
        Fri, 06 Jun 2025 23:40:08 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ac95e5sm24461256d6.43.2025.06.06.23.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 23:40:07 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Sat, 07 Jun 2025 02:40:00 -0400
Subject: [PATCH v2 1/4] userfaultfd: correctly prevent registering
 VM_DROPPABLE regions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250607-uffd-fixes-v2-1-339dafe9a2fe@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749278406; l=1224;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=n8v8jQPEHBDi3OBta5pBlj9xOrKQ3fNVoKSw2MhnIFs=;
 b=rLCjnu3AuVjLMRsMouTDVAgFuy+fcnCkD8pTP58asoC4UhRlnYBPIGfGT7fICZTuJrXdQHyrR
 wFAzlGwgnCNACX8voDZpUDTUa7mpjPed0z1/ibxyJptvF9x6tZPNH0i
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDA0NyBTYWx0ZWRfXwk2KZZBzLXOE 8X8wKiKa0bki2ZRi80jT2S5dmmAkMOUvAhyKGnivNdcVY7FSoretmefyeuQ4hQoLrYi430hbA4z hAZXraPfAZDtFABE5uDDHoZ1CXWaCm35wW73E43gSrR7tCINbOfsaTdRkhdwAmbsG6Tidyx7klG
 9tPWecASwH4havsMl15f9dviIdkpaQfQjeWsCGK2r9Bd3h8vC8iqee1unYPaVLhywDMYSZwj9wP us4685n1RE8iilhcgG+KizIAI0AhDxGV3JhW1st+JP4biezuyGeUJE03+zlC0LyiFtphi68vCju BfPiisLtl0cF/b2L5/RbkY9VA8rjAj4kuys4tAXDZ5VS1X6GHgb+7tWjWHKrH/zT54wXi7ns2CQ 7PssVz1+
X-Proofpoint-ORIG-GUID: eedsK3tpKv9NJhF7rsvv4uUVwJKkXTQ0
X-Proofpoint-GUID: eedsK3tpKv9NJhF7rsvv4uUVwJKkXTQ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=10 mlxscore=0 lowpriorityscore=10
 mlxlogscore=902 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506070047

vma_can_userfault() masks off non-userfaultfd VM flags from vm_flags.
The vm_flags & VM_DROPPABLE test will then always be false, incorrectly
allowing VM_DROPPABLE regions to be registered with userfaultfd.

Additionally, vm_flags is not guaranteed to correspond to the actual
VMA's flags. Fix this test by checking the VMA's flags directly.

Link: https://lore.kernel.org/linux-mm/5a875a3a-2243-4eab-856f-bc53ccfec3ea@redhat.com/
Fixes: 9651fcedf7b9 ("mm: add MAP_DROPPABLE for designating always lazily freeable mappings")
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 include/linux/userfaultfd_k.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 75342022d144..f3b3d2c9dd5e 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -218,7 +218,7 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 {
 	vm_flags &= __VM_UFFD_FLAGS;
 
-	if (vm_flags & VM_DROPPABLE)
+	if (vma->vm_flags & VM_DROPPABLE)
 		return false;
 
 	if ((vm_flags & VM_UFFD_MINOR) &&

-- 
2.39.5


