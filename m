Return-Path: <linux-fsdevel+bounces-52280-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6939BAE10B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 03:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162D37AD8E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jun 2025 01:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3436C8632B;
	Fri, 20 Jun 2025 01:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="k3eSBrgQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F24634EC
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jun 2025 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750382718; cv=none; b=gbuL3rkDt66kQqL1Kj7b/zKs4evQCFfIHofxPr/9BM20fDbuQpX/FwJARzqpE1REDWrbwZ60g3JumotygguPtIkpbQ4ZUcCmwQ0fb8/IbvRSLCAdd9r3YSSxN12ZHGVKzwreyy5uyr0zSsYf9UOksx7i1IFQlxm7FMUbLGIGx98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750382718; c=relaxed/simple;
	bh=48H87QO2Pis/SoCKFWPY9K3keEwEH0YOZ4nBSSNwcvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nS7r1wB2lVKVuctzEgCCz906oeeRlJGAoCrAW+U8CpqNmCOkGorKM8ZsjL1fWOrWhfV1Tp1DpRL5TiczUFyCB4Hy9GYI9XTnkneOdD9sxQ/XKLmriMIwbMd86F0dvgevdEASrKpxIPSP36XyswDyxlvn5MpqaMcIKf9RdBjymCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=k3eSBrgQ; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JGxRVk008255
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 21:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=+FYO/0M59dmuE89lk57/ngo+KRWnkH8LVWe4hPQu/fY=;
 b=k3eSBrgQX8ugAmAyRe9Y8gTr+vIJTGwUdhWsl33rAVAvAreqvtjanDBu0qjPU8Oq7R+7
 YsDbmccg6QIu6OBC/zvL+r7RWga5vZOEqFhHjEVtPMVo/p9py7inWML+bxPmQxUmxoUb
 MWg+df+2YSh9fTRYsIOjAjSSpLQyVy5ZFGNXSWXoetYRK2QVxLJ0chcaAHRRTRYWXxdM
 XFp4MHrN5VScIMTxXI8+X/4ukqULTb//4zsYL/80h17AcXWhgXqW+s1D4HLcDX4ruCxS
 d6cHYpTQc5CAvR3Or0dJWrU3zokzK1F/AqEEXhQmW3ovbwBDwcJAMH8XU6/hcg2xJT4Q Eg== 
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 479pqn795k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 21:25:15 -0400
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a6ef72a544so28402731cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 18:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750382691; x=1750987491;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+FYO/0M59dmuE89lk57/ngo+KRWnkH8LVWe4hPQu/fY=;
        b=lRXpUEbKc4vIRNKJRqm7IxqKbtZpMufiuwXrGpXxkkM/cQokqgvpAoIhcYIRlFmORl
         JYjncx1yAg7GAAWQJnYcJHmtxD0G/Cn/JcxVNxYt695a4ANfEOk5CQM+k4LoTCemvuPB
         6F4lF1n79tDZiaK1OvJ/i0OfFfJ2sL8711UwgkB/fXHuU10KbywLcRgwzToZVp/CInOs
         U+EVZRXFBi7Aeg46PHOwrlDawkhW56XLtg3u2CfMQTamvy8JUT5thWk1O27IN5zKlcLa
         UXQlh1ItIidU+o7t4ZFJBVRE+NfIFMu1egHqBFcgB+O7ITiV6h0FebaGDcMVIB/tM4Z7
         j6OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmHejVfk22d1icigWpG0dYRHxURv3zBkHU+qdU5zk8ai1ko2zbd5ZqJzS3s6zQnzSSSCOmJbaBf1rPcDHY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdj/6P3ZkcWTJMY8W4a6FqjtJOsjpbQthdG3x+UJtMX99Prh5F
	UsSKcB1IzuDb5ScKyn5kshOV+Cs2n3RNAhbR2w3WkaKfv/sf4NkBEQlcupr/yVkGR3wzU8nQnOj
	WtcDbgGZ0ZuLWrJ5RikAX7H0EDya5mE/HX44VEp39Je0Cx0HvV3OPg3uh2fLFxFk=
X-Gm-Gg: ASbGncu4p9uwPUx/VixW1FLtV1IMmstFRzHBv+reQqfnLusR1nMbpHX3c52T2or0kl9
	qm7WL3KdST1JmRksxaz34nwfwEvPoXn4ErQLx+Metim83CMubNKefXFe89KVBwxkn+Ii+2OVQnB
	wXdz5pfOoLsZuvatn26VIKjNcKk8Z2Z6Syg6t0ace8L3IA8PERNncQ1jAXDX3uqTRGZ9LTXmuIE
	vNG2MHyDcw4O69jY7chVXrtYTpJOGRG0qlb63xpwWMa1Us0kkrgcavDR5J3BOjj05w+mMvHIEVO
	7XbMqL5oY/EVXWzVTab/mhvKn6CumDobxW9RFGPgSPbf0JuehjbsDjS/5j8olA4xBs+i
X-Received: by 2002:a05:622a:40f:b0:47a:e482:2eae with SMTP id d75a77b69052e-4a77a229e06mr20311191cf.31.1750382690655;
        Thu, 19 Jun 2025 18:24:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpgKZPPSMphCZVQvNohMUiRd5i1lgxsJaw2otLFCbdmxNwVix523VQOy7E3/sJIy61nwUvHA==
X-Received: by 2002:a05:622a:40f:b0:47a:e482:2eae with SMTP id d75a77b69052e-4a77a229e06mr20310941cf.31.1750382690182;
        Thu, 19 Jun 2025 18:24:50 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779e79c12sm3794321cf.53.2025.06.19.18.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 18:24:49 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 19 Jun 2025 21:24:23 -0400
Subject: [PATCH v3 1/4] userfaultfd: correctly prevent registering
 VM_DROPPABLE regions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-uffd-fixes-v3-1-a7274d3bd5e4@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750382688; l=1272;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=48H87QO2Pis/SoCKFWPY9K3keEwEH0YOZ4nBSSNwcvE=;
 b=anDw4BUOIaeEyJ5c4porbKpKkHrHAXlVWt+d9mp9dQbT/Aordkik+mDY6JLUsIbX3B3SmAthB
 I7FE0uQDxRzCy7TSGKnedagoQqrgduV4YtN885eaf3bwsgnhRjP1ODV
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDAwOSBTYWx0ZWRfX9Vq2scCrbXxy Sl9cTC/CVUFqNHwCZhIO6bT6w2+I1CrQLdGSHU3+x/5Puesu6rYgMaMigAA8pUSUYRfgQgPzC/Q oL4N7D6hBMVMn50NlMo9JgXWDFlCNMV/WiB2XThszmHB5qfu7eDvJ05n7vwYmdMxZNR6kijMgAg
 kdM4RX7SHDv6I5b+8uHIkU54eZIHIFzTGvv2tyyh6BEuTdX0NLx+UX27NrXj0cD+Xa0g0cdch/D ElTf0az3AwvLyAAIvjytVZheZfvV39xfGzu4J8BrepHbVH7KXF/NhBtdFB44cA1fPJflBN6ogox fO8F8yMCHqcSddIM0J2g8THwzx1akFaJbQpQgdawjmakKVeqTTkxeQ8uHxkbhncyiwiUssUjvoO wSMWp++D
X-Proofpoint-GUID: rNbKVWh2pU_j_LTVW3aIQJ6vRfTuJLY7
X-Proofpoint-ORIG-GUID: rNbKVWh2pU_j_LTVW3aIQJ6vRfTuJLY7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_08,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=10
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=10 priorityscore=1501 phishscore=0 mlxlogscore=927
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506200009

vma_can_userfault() masks off non-userfaultfd VM flags from vm_flags.
The vm_flags & VM_DROPPABLE test will then always be false, incorrectly
allowing VM_DROPPABLE regions to be registered with userfaultfd.

Additionally, vm_flags is not guaranteed to correspond to the actual
VMA's flags. Fix this test by checking the VMA's flags directly.

Link: https://lore.kernel.org/linux-mm/5a875a3a-2243-4eab-856f-bc53ccfec3ea@redhat.com/
Fixes: 9651fcedf7b9 ("mm: add MAP_DROPPABLE for designating always lazily freeable mappings")
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Acked-by: Jason A. Donenfeld <Jason@zx2c4.com>
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


