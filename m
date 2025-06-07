Return-Path: <linux-fsdevel+bounces-50894-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1466FAD0B78
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 08:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A81BE7A68E4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 06:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A808258CF9;
	Sat,  7 Jun 2025 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="dSyraRB2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE01C7009
	for <linux-fsdevel@vger.kernel.org>; Sat,  7 Jun 2025 06:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749278417; cv=none; b=cqDGqQ9nSdVGKX3YqmyNlOxdIwEdjrJT+tiVA5UUOPNzABhDQQd1mTdTDXrrAfF3u12DVdwVrETJ2qasLG1sQYaogx2MX3DebPe5CMgceeltq7XL3hg4j1Rl5eVUhev92soXRhN/zSW64ZWPOEsas+rgXtRswNxjQNLYntik4Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749278417; c=relaxed/simple;
	bh=IUl6q/76PM2j47USWUISFhP3xI3SXkKWlPHUmyQ2co0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hiBpUs8UlCJM0ZACvg//34FSdHK8uac2/wkvqDTfqeYZsq92Zmg03+2lYXYokbj0yNtMMBQ3Ch5RpsH+B9Yx6C7RujiDApFxCIreSK7t1m1Yzld5NUVKFm+C/6PmZbK36+xX7ikZMO0U+QfLohaxhmYTrJlbW+eTY8c7ZqMA2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=dSyraRB2; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5575WjV3015013
	for <linux-fsdevel@vger.kernel.org>; Sat, 7 Jun 2025 02:40:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=pps01;
 bh=D8SoV7GNRZ/POy1AfaBjZVHTioJpzoc5dpPSb0goGb4=;
 b=dSyraRB2ONIpp28BYsxxClRORvQx3jgBC8loF446yrgl8ZPTLef3GCDyWjzjntSVPisj
 U6RTRNWkQp6iK1eqLiLdlD46lbSWmK988NNEJLavQRhZr4O54wyJsKmCKgsKLf06+1uY
 /YayqxjLKljrJb+JjMyJyINlg5f1DzZ6usELMFnTA9PerZQXyN7rlciJuuDSCDYPsrQ6
 paQQtLwNLyidsW5TOMLosnX9Kqy+XJ3swTubzomLIBFOHjBem9EwaAbUbGjl7dK8PIRq
 HAgfyXWwgKy+7GGBnK+Z038qZptKty0UYRyRFTwhQDd72XAod2wGgSZr6rj30vUBdfqu UQ== 
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 474efj089f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 07 Jun 2025 02:40:08 -0400
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d21fc72219so196632185a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Jun 2025 23:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749278408; x=1749883208;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8SoV7GNRZ/POy1AfaBjZVHTioJpzoc5dpPSb0goGb4=;
        b=IeUNhJXqoxMQA/2ioiJ7jIv57M1sw/lvppq1wNP+IvZL3KpbRBVLqFDRt5jAf98f3D
         HUK1BUhAdqhj6HH+Oy8M++NGYXSvhLfOGs85hcgKVNz6Sj89jMNk9OLIk+4MQ0LNPsdI
         9EaxOhzhYBLNuePDHARKukpQN+2KHW3gx9dYFyOdDxjxVqFxFRQuu3QztKyq3tJuRyP6
         GavFWN34CrPTGG5WRUsU6N7w/pOlFq2r1ulAdytqDF7kCfDxFjs0jCOB2thIbkDijgGC
         CWBOWkSoT2M/o+wZwb1+aC03AvX5sagLSyT+ua1kfqtFoeB+v1zbRSLvSVqVc67gl5Hv
         gd2g==
X-Forwarded-Encrypted: i=1; AJvYcCUSztI+8kUJLu+1YwRfFu/q9AkU5elHJ+Ku5HijQozZdai746vwHkDVcmqGx2mQxTTasqZmEivQEswo2ehz@vger.kernel.org
X-Gm-Message-State: AOJu0YxKtbT5LKh6TSKIOX9l0lvr0ZQwGI8Ai6FlrKMiII/kjAcylSjJ
	jMM4O51/gxvO3Er1DLDDoz8s4mVVcyOZ24Jtd194tl7PzgGglNLltoqtNg9XNmgDloBI+0uUrsE
	mbH4jY+1iidldxrN1mTVC84QaNEpfF2F79bN/qhwaVPUGI3OP5ZNaLLBSI9Nmroo=
X-Gm-Gg: ASbGncvvrp/WzjzHmR0NjlFxeDsripNdDwr+Nxc5cxivGZQD9IidFlw6IccQkrkntEB
	MiAYarPe/Oe+JIzQ+lQV8bmPOGSbXmu3x5jeBVV6CRzmaHRaQTHY2FWrEX+D5ub5GA1CISqqoSH
	vHal6CgaNRaBAtaEEEdBJOBMWw4qQKKJ4bSW5iHCiKYmDFbBKNvIcXLsTN1tYrNO1UGVc3EIzaK
	f3DyahVoVNFGCkX3xmCyC8uOcDPboqws8kmxyXaZX8SmwWgWkc311hgpVLjkHlHRPH9Ui8/Tm1N
	1+s3bJMa4Q8sTrfX43V31SDJfW3xiOAFveyTbe8yyQFhSjsrPJPxvM2bsw==
X-Received: by 2002:a05:620a:1720:b0:7d0:95f6:44a with SMTP id af79cd13be357-7d2299b1db6mr941289985a.40.1749278407949;
        Fri, 06 Jun 2025 23:40:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvruxEqfqrfa2x24Cr04nM5CvxBokXk40odRYVazuqhuEJPnDjkZTGkboqou31Aw/jxrNuLQ==
X-Received: by 2002:a05:620a:1720:b0:7d0:95f6:44a with SMTP id af79cd13be357-7d2299b1db6mr941288085a.40.1749278407558;
        Fri, 06 Jun 2025 23:40:07 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09ac95e5sm24461256d6.43.2025.06.06.23.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 23:40:07 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v2 0/4] mm: userfaultfd: assorted fixes and cleanups
Date: Sat, 07 Jun 2025 02:39:59 -0400
Message-Id: <20250607-uffd-fixes-v2-0-339dafe9a2fe@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL/eQ2gC/02MTQ7CIBBGr9LMWgwwhaor72G6aGGwk2hrwBJN0
 7uLdePyfT9vgUSRKcGpWiBS5sTTWEDvKnBDN15JsC8MWmojDSoxh+BF4BcloWqNqHplyCKUwyP
 SVpT9pS08cHpO8b25s/qmP42V+K/JSkhxdBYPrsEg6+bsptt877nbk5+hXdf1A6ntrVGnAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749278406; l=1697;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=IUl6q/76PM2j47USWUISFhP3xI3SXkKWlPHUmyQ2co0=;
 b=lnSgx8nHQ6hUrpebJcn/0ZTXN5o9vDh3IWCSaS25Evw95Igi7YpCvU7IU300F2Y5DsQdwhvOO
 DEZRX4fDF72DN7PEbegaLBdpEPBDbT8XtxjG4/LpuJKu3U8HJHP/Ey9
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-ORIG-GUID: xbToedpEL1p911bElZdRSLVg54gYI_B3
X-Proofpoint-GUID: xbToedpEL1p911bElZdRSLVg54gYI_B3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDA0NyBTYWx0ZWRfX6ankn9Jmwcdx oKo3UcZqF0LYJBsONx7PYM1QSxlRWbYhv14fu2iMYmT41LI5TnN9BODxNm9tSxo+1IHbuC/i5bo 58BW63jMNPI9QJgSzxZy3K5E6b1hxTUN20HuGN3W0r4/qV5FNXHEKlwU2kjkaYY9yzX3JdL5tOG
 nMZZ6hUK7WCygWopZkxK8E8HWJJDhSpvKQYfh/kGQH4rCWzGfYzaC3xhdt6+4sg93zSQUpTb0AI f1aElJw9MgFjkhcmeKR3CYleGMFyVvrqcDSdChvDesdpF0kFDUgc2XkjyNHjWDPEhTiBf5EKBAV dCc3LH6AMRXDNX3XrhSg/V1gi7+fq3N7yO5tHz8lZeu8LTmUYp19EEz5c4kInO1K+BAtcnZ/4QI 47wOrKis
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=10 malwarescore=0
 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=568 bulkscore=10
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506070047

Two fixes and two cleanups for userfaultfd.

I added a patch converting BUG_ON()s in the userfaultfd code to
VM_WARN_ON_ONCE() this time around.

Note that the third patch yields a small change in the ABI, but we seem
to have concluded that that's acceptable in this case.

---
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
      userfaultfd: remove (VM_)BUG_ON()s
      userfaultfd: prevent unregistering VMAs through a different userfaultfd
      userfaultfd: remove UFFD_CLOEXEC, UFFD_NONBLOCK, and UFFD_FLAGS_SET

 fs/userfaultfd.c              | 76 +++++++++++++++++++++++--------------------
 include/linux/userfaultfd_k.h |  6 +---
 mm/userfaultfd.c              | 66 ++++++++++++++++++-------------------
 3 files changed, 74 insertions(+), 74 deletions(-)
---
base-commit: 546b1c9e93c2bb8cf5ed24e0be1c86bb089b3253
change-id: 20250531-uffd-fixes-142331b15e63

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>


