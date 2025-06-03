Return-Path: <linux-fsdevel+bounces-50532-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF0FACCFEC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 00:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7642F3A465C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 22:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EC1252903;
	Tue,  3 Jun 2025 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="hpRQPKI/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2213221D92
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 22:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748990182; cv=none; b=Hvs+xsSTm1v9wpfYjnbDZJRPj118DBmDMKzlnhrE4/X6r/G64NR7RN+76dmO8nUl5eIptBlKc1355jLDNSDtAhDhqRdocrZLTLX40wFWX35jDhWNyqqV3DvU1omwSju/eZLDS7CU/ZJWOdjqXmdbo1i09CGlR7SFBQJ+VBmYUJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748990182; c=relaxed/simple;
	bh=6173djIpHY67AhiXkmcV2Ll4/Vt187imCK1efPD/7Ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sg5H3As+jrwgp7A03hSUw0tRnzfzOj5HMb5T5EvxLNUAnH75PD64Zvss2qean21sZaMFZ9wEaMeBS1PZ3FeOMCfp5Tdju+W6W1nD2W/L52WoT9cT5HH4Zeprm8L3cINaF+xqMMk5Fl3q7SxXcnELB3/YQzn14DJ238LqCptbLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=hpRQPKI/; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 553LArRZ025614
	for <linux-fsdevel@vger.kernel.org>; Tue, 3 Jun 2025 18:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pps01;
 bh=e3pRUkgAh0M+NosxUGiJVwkSepJnz0HXGJMPqHgMtIg=;
 b=hpRQPKI/stzykwj0Xw1FNjj6jqkUtRpSx0IsC9REneCnCMqLkZV+uzxWU70WWvD2oZM+
 cW/5JPBhw9omfekfmKxXMZE/Zk5cG6h2nah119uxbsZABTAMvV/3whUd7Qriobuc/C5V
 5ApFr0yCjIhJ/pmSKKSfQbiTAYkFxpO+Ag+nMGRxy2gAyxXLWWWVhziM0v5/E9vA7WRl
 BavMqEQ1oJt3WWLQ3sDhhO22aetov0m31E7ajdvDix/N5RDGVmt0vUr+q32tcB1acI78
 hpzgejCSbEH04DcCTiXu8x2jzqJ+G70svatGKRp2W6cARY1ZK/tjiseDbg8VoNbnv4tj 7w== 
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 46yv20rxps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 18:15:24 -0400
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a448c036bfso85266571cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 15:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748988905; x=1749593705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3pRUkgAh0M+NosxUGiJVwkSepJnz0HXGJMPqHgMtIg=;
        b=oYhJ2QPMURLlTS7Cwgx7dyg/fWby+ivB5TG8FQFY1E0/qvAU6tc+2i9lHXqUn3Xp+i
         DyRXMLhI0JsefhYIDWWwVH0R5bg+WZXcNUZeAQa4X/mTQjaxakrJlgKGqy3vHaZc3BYV
         1j5TowZeQcCkT2/xk4hEvOuVuhWX7m9qTPRlQ2EjnzW/vXeRJuCRP2vXkt0QDKPMvuXW
         dIAB33DLMZN2Blfk+9ONAf6NYEe26QR7z74/E6OkKiTOls4l1pORuZuqf5bAkyzaG7s+
         r1y7I/X0EIt3JaCNrfl2Kp8s7tjF4In9xK4c3onMcvBYOtJ+p1iw+yG3MvVBls78atn6
         YN/A==
X-Forwarded-Encrypted: i=1; AJvYcCVd0JXzCIFKgV8wmejt5gyxnDPqIX02Pc0amxq5LZo3YXui00rQrhdwyTUbtnLezSBDzyUNNKesvcmvwHrW@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv+JEFL5HqioQEk73ud/N2T+Y/6djB5igIOpIsD0CwoOJNdQUY
	9GPc4HdHfI8Amdb2yScS7tubNOPL9LBG1NGdUWCwFXgFo2NR96JrT0TuPWQ6p4BcYyqm4jgOmdo
	Dk+0HdOrO2fAC6kyELlb42G1m1ldeD1mQmBiW8Sl8yMs0XthRHsa/CciU0mfi64I=
X-Gm-Gg: ASbGncuDH2KejmWAWgwPMAvCb6AGGvt6fvkencM00xwjWBamQayS+yjKLlfw2yEEUMc
	tLAvk4KsuXC1s3a9Hz0paahm9ZhxiV4NZ4Rq9h7HqXHlpb/b2k1umZHxOcx10WBd5fTs99ry/pu
	sd/diAtMpKKhjo871ZlgiNJiaou6SomQOMnUgpaclfzvQ8KkgvB+OQxSkK+Ttka9ME7HbVaEtoA
	iiNKt5tybwm3d7qCsN53MGn8Ybw2A6y5ajOZy8lsGgYnANntpw5YMLW8D/4spd8RjYbw5Q8yqhY
	IFng665vT6I6cexeTaFKotCVhNwY8SvREIMLEnZEyEEnCoodsGyWPWyqkJS50QYp8x2T
X-Received: by 2002:a05:622a:1e1a:b0:4a4:33b4:1b27 with SMTP id d75a77b69052e-4a5a5779217mr10447641cf.20.1748988905425;
        Tue, 03 Jun 2025 15:15:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEikFmrJJ/dqAk5juLthWKuprt/L7CUTwYwNjyF38/d/IpLrhGAlBMbPlvV4jfR+m7idIKeKw==
X-Received: by 2002:a05:622a:1e1a:b0:4a4:33b4:1b27 with SMTP id d75a77b69052e-4a5a5779217mr10447331cf.20.1748988904980;
        Tue, 03 Jun 2025 15:15:04 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-95.net.columbia.edu. [128.59.176.95])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a5919064dbsm33085741cf.53.2025.06.03.15.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 15:15:04 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 03 Jun 2025 18:14:21 -0400
Subject: [PATCH 2/3] userfaultfd: prevent unregistering VMAs through a
 different userfaultfd
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-uffd-fixes-v1-2-9c638c73f047@columbia.edu>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748988902; l=1931;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=6173djIpHY67AhiXkmcV2Ll4/Vt187imCK1efPD/7Ig=;
 b=8T6QODEVbi/mmjgbGFVZw/+kv6elEEqujUq9MRPiKoJoVsE166mOElZRzmD6ONQRXFEo8XnjJ
 botepy2REz7D8IxaMBLxBbHhlpvV1GgeUlQ3cMmpb5UsMDK0c3QU9g4
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDE5MyBTYWx0ZWRfX2mh8gOWLwKW9 OpM4UnD7a77AsJVyr3aWJt1qIYsROQlK4Jpxfwvpq/Kr4Mnm0OtkzJdTacuXPeLVedGI5DAbuPF 1X3xRKI//vzt5Wswu6xWEszQYS6Dl4Jv2GeGew9UbKK+kwdkEHsuMNTndeI35otuC22B+HW1ocR
 l2P/gMulqUjJ3Ow18SNBC7wxwnQObUZCNCH6lnfexpwsNanW3V1/T3gKHJxmDA+JhBQ/8Orz0/D EmQNPwcwrSStP7ojXnV8v+Gui4ZxMfD0vNlC0Vusm4xMtRAeMu7xI67pV89TYQYwxtEaWZh3zxm gvM33JW/7iShK8ULjtM2euYeIbswKYM6igIRhVQ8mH2NAeTD6mABbkOVlXaLBvXCy3AUaxJDLfB FEEVUg1g
X-Proofpoint-GUID: hC2JIuicL9lUqcDVtN-eWoPLC0Y6xyxn
X-Proofpoint-ORIG-GUID: hC2JIuicL9lUqcDVtN-eWoPLC0Y6xyxn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=728
 impostorscore=0 clxscore=1011 adultscore=0 lowpriorityscore=10 spamscore=0
 bulkscore=10 suspectscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506030193

Currently, a VMA registered with a uffd can be unregistered through a
different uffd asssociated with the same mm_struct.

Change this behavior to be stricter by requiring VMAs to be unregistered
through the same uffd they were registered with.

While at it, correct the comment for the no userfaultfd case. This seems
to be a copy-paste artifact from the analagous userfaultfd_register()
check.

Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/userfaultfd.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 22f4bf956ba1..9289e30b24c4 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1477,6 +1477,16 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		if (!vma_can_userfault(cur, cur->vm_flags, wp_async))
 			goto out_unlock;
 
+		/*
+		 * Check that this vma isn't already owned by a different
+		 * userfaultfd. This provides for more strict behavior by
+		 * preventing a VMA registered with a userfaultfd from being
+		 * unregistered through a different userfaultfd.
+		 */
+		if (cur->vm_userfaultfd_ctx.ctx &&
+		    cur->vm_userfaultfd_ctx.ctx != ctx)
+			goto out_unlock;
+
 		found = true;
 	} for_each_vma_range(vmi, cur, end);
 	BUG_ON(!found);
@@ -1491,10 +1501,11 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		cond_resched();
 
 		BUG_ON(!vma_can_userfault(vma, vma->vm_flags, wp_async));
+		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
+		       vma->vm_userfaultfd_ctx.ctx != ctx);
 
 		/*
-		 * Nothing to do: this vma is already registered into this
-		 * userfaultfd and with the right tracking mode too.
+		 * Nothing to do: this vma is not registered with userfaultfd.
 		 */
 		if (!vma->vm_userfaultfd_ctx.ctx)
 			goto skip;

-- 
2.39.5


