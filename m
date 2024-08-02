Return-Path: <linux-fsdevel+bounces-24876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDF0945F99
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 16:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1231C216F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFF92101A5;
	Fri,  2 Aug 2024 14:44:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F61171C;
	Fri,  2 Aug 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722609892; cv=none; b=cz4TNX/b/Xcw9OIESWYtBjypmfE2/mqwnNNpd5BI5jK+t2lX47IJVBF1S8SaXIqqdfYxkGJ0aH95JgJQnGpUxQPaG9nL5ZbI8gmEGiT9E0YP8nkhyqIbp8pz0UE/G1XNLYFmEG6IVgKZIhNYg86fRSbTlOVRkbYW7/C773VUIRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722609892; c=relaxed/simple;
	bh=TbtraOWhyx3XKowuKv1m3Z/5BsvIqmAlb7jX+usWXSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tY6Yc8oMnhFgBrIkTD9ygW4Klxb7rpejVT1uaJAVnvV9pgAgDQaw6EkV2fYK+3tIdGs7gGzxZ+eHjZSFzg2D9psVeExvFzN9QiC2SG4SDzri4lSGO5oyDHgxMpjcq01LGNLzLVh7+ph9TNbBO5Az+wCRjFF+KePU7bJfgpjTInU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472DVrA7021119;
	Fri, 2 Aug 2024 07:44:19 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40rjf08pdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 02 Aug 2024 07:44:19 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 2 Aug 2024 07:44:18 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 2 Aug 2024 07:44:16 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <viro@zeniv.linux.org.uk>
CC: <brauner@kernel.org>, <jack@suse.cz>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <phillip@squashfs.org.uk>, <squashfs-devel@lists.sourceforge.net>,
        <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] filemap: Init the newly allocated folio memory to 0 for the filemap
Date: Fri, 2 Aug 2024 22:44:15 +0800
Message-ID: <20240802144415.259364-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240802135214.GU5334@ZenIV>
References: <20240802135214.GU5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 79bnPn4ka2mgM7vqKYK1eRo_uMASQA5l
X-Proofpoint-ORIG-GUID: 79bnPn4ka2mgM7vqKYK1eRo_uMASQA5l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_10,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=801
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2408020101

On Fri, 2 Aug 2024 14:52:14 +0100, Al Viro wrote:
> > +			ERROR("Wrong i_size %d!\n", inode->i_size);
> > +			return -EINVAL;
> > +		}
> 
> ITYM something like
I do not recommend this type of code, as it would add unnecessary calls
to le32_o_cpu compared to directly using i_size.
> 		if (le32_to_cpu(sqsh_ino->symlink_size) > PAGE_SIZE) {
> 			ERROR("Corrupted symlink\n");
> 			return -EINVAL;
> 		}

--
Lizhi

