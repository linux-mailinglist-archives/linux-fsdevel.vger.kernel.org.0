Return-Path: <linux-fsdevel+bounces-34969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BDF9CF40A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 19:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D35F1F20C92
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2024 18:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA231E0DD7;
	Fri, 15 Nov 2024 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ji28jsis"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0C1D90A5;
	Fri, 15 Nov 2024 18:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695700; cv=none; b=s2pskIxYbMFoeSP6FTzUvxKs0w1y0B0A1MlDRktnS0cPNVwKQDtIt5kznicRBPe9g/1krXipj6Fc4OQ/VfOdVSqzbeKcE5jFqYx7g7ddUWFU54dHL6B/RCUBw9xmhmQD+R6XiIX7pSMFOsL/2lY1D6VsPw3Kdh7v12pkqENIfRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695700; c=relaxed/simple;
	bh=lXQz7wy56AGz3YhdfTia7HvsBEdDjKSuSrGoAlkUh1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bl3gwgK6CUTKsp6TBTqzIDJw1FYM1LJbQnUlQhEJ7W9HjWe++aGZ61e1y5rhP7TLfySa1IL7cf+XFFDO1iJv+zZV5kFJBeia3MgPE6rDmB1ChaE7fSiYzm5mipC8aili9yQlCW5xZjaATC6JcnQxcfA6jibJmLbYMdcRdTIbJro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ji28jsis; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAYZVD017758;
	Fri, 15 Nov 2024 18:34:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=CXvP+XzCQ3zQcG4pDpZchG89wmh8EwXBycr5MMRTU
	9M=; b=ji28jsisIPVFerdupBGQVDoSsZQETxnwqJZ4BF8L4q8ODlnG2FqetBT2j
	QNwbQrzuXFFGkQVmIwCFBOf4HoIk683XIMSeYzo2ZZFlmjg5DCqwijAqf6Qet/EN
	sKhc4lnif6wyiQ5utQzrz6vDaL07ZZJHiSwkz1uvfpepVwByZkzByar6+F++BwYv
	rvECIcw28EvUNwPFX6c8GC8ISRpIRWMMYI5C5k7fx9HgQ9a891N8OkffIm+fvAx/
	atRpB68iof7gPrb9DpZQgNjrovCd6VEsoxyZX1VXpEi0NXlyRH226XOCxORzzHsQ
	2X0zk6uOsXk1PUZfWbE+UF3ErdeQg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wuvc4qk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 18:34:56 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AFIQbC7004104;
	Fri, 15 Nov 2024 18:34:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42wuvc4qk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 18:34:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFHHPnw029689;
	Fri, 15 Nov 2024 18:34:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tkjmvh37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 18:34:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AFIYq7F55574858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 18:34:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C40D520049;
	Fri, 15 Nov 2024 18:34:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A462620040;
	Fri, 15 Nov 2024 18:34:51 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.39.26.153])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Nov 2024 18:34:51 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 0/1] Fix generic/390 failure due to quota release after freeze
Date: Sat, 16 Nov 2024 00:04:48 +0530
Message-ID: <20241115183449.2058590-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EF1ioymXVt52NrmqoNwPC_Z40tCgWmYP
X-Proofpoint-ORIG-GUID: btOZyRtVpSP2AHZRZxuT0yXlERGnIuIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 clxscore=1011 suspectscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=797 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150156

Recently we noticed generic/390 failing on powerpc systems. This test
basically does a freeze-unfreeze loop in parallel with fsstress on the
FS to detect any races in the code paths.

We noticed that the test started failing due to kernel WARN_ONs because
quota_release_work workqueue started executing while the FS was frozen
which led to creating new transactions in ext4_release_quota. 

Most of the details are in the bug however I'd just like to add that
I'm completely new to quota code so the patch, although fixing the
issue, might be not be logically the right thing to do. So reviews and
suggestions are welcome. 

Also, I can only replicate this race on one of my machines reliably and
does not appear on others.  I've tested with with fstests -g quota and
don't see any new failures.

Ojaswin Mujoo (1):
  quota: flush quota_release_work upon quota writeback

 fs/quota/dquot.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.43.5


