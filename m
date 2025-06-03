Return-Path: <linux-fsdevel+bounces-50534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A52ACCFEF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6E83A2D1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734832528E1;
	Tue,  3 Jun 2025 22:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Jv+6vYCt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7EC1DF75D
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 22:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990270; cv=none; b=blvBWCtxdYP8ygJkXgf6xTKFxxRC3VcQ5auv4XfgALyaoY+iOQU6P0o33wuSR4cOAZ/CeYUIhgvVV3CSB9T6aqd8JRziiftY6w9OlncR2C2VP6eADxA5iIdCrVjVFhSVCfpxj4Iw3Zvj8gE1qIVqm7Q5myMhKHcelwEASUlYp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990270; c=relaxed/simple;
	bh=37Yhqy8AU4wbTPIPEN/cYvBNg1+kOJHWPvbBST22r2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XamOOKHhjZNwLd7z00Ku197Ac+VFZV4fOKttqbKwqtGSoBr4kKXxXJYdoO/7OTQwb8OgB/Orne1Pl/A6MHW7I+e9x5xudW22Bxk0YkFrkbRy6Uxw8K9xO+6iCRDAWplWMUpw/csNNmL/IHG4PeP1/mUNmHhARbVfvEUdULRdND8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Jv+6vYCt; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553LAsQ5025678
	for <linux-fsdevel@vger.kernel.org>; Tue, 3 Jun 2025 18:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=bg24Q9e8jtah/xAc16ck8SlLx6Biq7CXknAdWAqxD5E=;
 b=Jv+6vYCtH1vIb9muE4Lvzej/sas2AFv3Cdwkj/GjTqqJjHlkyONBXnQDUHbzoawoaRxI
 6RCo9rJ0YkpD9LVB2u8VMUiAUsaS8nu25GMCtMtpUirPXMHzd4PKLVPxZ0JG1DrApnvw
 ypYLxFs5rCwMnM+s2LSJGVnUvcO4ybERM9j6S7A3SM6ieRzJfxcbOdmLbMfipo3dLzBa
 VtHfI1kGHi++3OIEbX3DxU/+Ugh6+lT+/PVgVWKSdC+V+4vZVm2x7o+lCnaS6JiqVv0+
 thlRq3LN2FQU6WojkTIrgpII0vrqMYivQiyaNPEplaWZpBHdDpfhh9MGgQtw9rZPbArt KA== 
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 46yv20rxpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 18:15:24 -0400
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a582e95cf0so33598511cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 15:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748988905; x=1749593705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bg24Q9e8jtah/xAc16ck8SlLx6Biq7CXknAdWAqxD5E=;
        b=sdXHaITs1nVdNHn2sxWGvtT7JYTxXhTnNlLDMPK1kG0oVtiBwTQ8BN3kqBqD15M7dE
         7+nxRDHPW0/O2I0d4AfGDm7Qr1dOt7VCWGeEiLxSLL8dMj68asAd1+3sSIFzT7n6dDGR
         fG3Uxkd2do39ihv0tcVMmagWSFqok1Kg+r0IpF2S9604+l0OktUYOffm84CjEMbND9H9
         jazzknU9ockMLxF70no8nPsFc3OGZyFl4U669J/tdz2U6cJZxEU2wzf9ufIFe7ageHoq
         r0n0iX4oYbg95nfg7H1cPs+ty9zcdA/BKz72AIj07MhWVQWdcOaAaIRm+Iq5N31hVTjc
         W6CA==
X-Forwarded-Encrypted: i=1; AJvYcCUGURM4jq/Yde7evn4QZHjicZUF4+9hp8LM033hCwbyOdNfuSIgpJwv39am6ZmXj6iLTE2ik/rD/v3lWOy8@vger.kernel.org
X-Gm-Message-State: AOJu0YxZVBJkbSQA5FxPj8r2zEecqgBbwwVwrufDstohuB1a49Rb7uYo
	PTkBY2PLqEZRtSesDR0kafkxi+qUWdbvywHTPSemVjO1NTYxXgbKdkx7Y5QgJA1P0FxC5pf260z
	2fnkUE5xvzUr682FP0vUumRWqXb1fT+RuxDv/CnV7GQCPFP/l+tqzOX24jEMNUKw=
X-Gm-Gg: ASbGncs3S6NiJDnDkc4os/uhXt1ci0vZD3k98XqzCBF8EWODjsWg9N2cnPQV91z13+E
	Fw9ovZ1veDLTKdCx34XPbzffLoOUqG1g/4wQs3mPlJRsgnuNHDshvewQ05kRWC9wq1ysdcRRv/t
	bE/v4EqjDfx+CLERuQ0WLXLAckbuWb8taWY5OK0rptI8odPe8tWccTfZ4M7Fh+RBBunrg24ju4w
	+0q21RLIxvG9EvuDFHkm6GhVoQfNeUcZwgwaz437q9MehgdxhgmuDOOeLyzSN/VJK3RCxp6FGfp
	uUPTLqb+o1U16/hc0Vmo8Nd4xPLvjeqbi6UwkUPjR1d3pVKzoqEv75i7Lw==
X-Received: by 2002:a05:622a:5c9a:b0:4a4:3414:3f79 with SMTP id d75a77b69052e-4a5a5759bbemr12581101cf.13.1748988904796;
        Tue, 03 Jun 2025 15:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEzoQH0sZBSRBHSaxiM1Ih0R6jzNTzEVjvBDvtQBBl6VqSZjQ1HlVesCPRbevn0B99owMG5Q==
X-Received: by 2002:a05:622a:5c9a:b0:4a4:3414:3f79 with SMTP id d75a77b69052e-4a5a5759bbemr12580311cf.13.1748988904139;
        Tue, 03 Jun 2025 15:15:04 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-95.net.columbia.edu. [128.59.176.95])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a5919064dbsm33085741cf.53.2025.06.03.15.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 15:15:03 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 03 Jun 2025 18:14:20 -0400
Subject: [PATCH 1/3] userfaultfd: correctly prevent registering
 VM_DROPPABLE regions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-uffd-fixes-v1-1-9c638c73f047@columbia.edu>
References: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
In-Reply-To: <20250603-uffd-fixes-v1-0-9c638c73f047@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748988902; l=1136;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=37Yhqy8AU4wbTPIPEN/cYvBNg1+kOJHWPvbBST22r2A=;
 b=1POmKOKsf0VyIS7OUyi5fS+1vuMjG1lwHk/1r/s7Bsd3ipsKiWh0nDa3vFHMa3L6VFfXSZnr0
 W8emj/MDZjPArf1SvuAY/CYJ6S30Ab1/x0gnYzXMV5ycQo2rlyY4eDt
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE5MyBTYWx0ZWRfX3g57mPjF0LlI k8v7F8D7KnUZn3g2C1GFG6GYDvKB0ArIkZSZjcyB5ORX6J9XoBwmMGZ9ANr1RumP5GMyOOzPLcf 90P7pkrFSDBrVbXZnsRyVoM/wWHTnD98Vrp62IBFO+JpivUwJ9+ey/2OvhCfKztYfA+TJU5l20C
 f1D8HsEcBw1Iij9UTLU5NWK1gvQxOBoKWnPvGUew+cMVzX6nyYeXqHj5ykxJFwMnm62yVozAeqc eH8S9du5NFEBQ8vLAgx84dHJMptWIqnLvZURNqy1hZbn2nz+6LdHjlAzZmflW66S1JT6oTfBtku Nfr07ioE3stJuIgIWz1g26UDxrmV2ZHzAlrV4Lq3uUAaGNEt/yawuypfC0O4f/SrTLww4u5TsSo lncMijvU
X-Proofpoint-GUID: Lzmrb7dimY_5F6Yk6n8WX5qoCxun_tIz
X-Proofpoint-ORIG-GUID: Lzmrb7dimY_5F6Yk6n8WX5qoCxun_tIz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=908
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=10 spamscore=0
 bulkscore=10 suspectscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506030193

vma_can_userfault() masks off non-userfaultfd VM flags from vm_flags.
The vm_flags & VM_DROPPABLE test will then always be false, incorrectly
allowing VM_DROPPABLE regions to be registered with userfaultfd.

Additionally, vm_flags is not guaranteed to correspond to the actual
VMA's flags. Fix this test by checking the VMA's flags directly.

Link: https://lore.kernel.org/linux-mm/5a875a3a-2243-4eab-856f-bc53ccfec3ea@redhat.com/
Fixes: 9651fcedf7b9 ("mm: add MAP_DROPPABLE for designating always lazily freeable mappings")
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


