Return-Path: <linux-fsdevel+bounces-15691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C51892090
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 16:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF10B38986
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0BF6BB22;
	Fri, 29 Mar 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mmy0jBkr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AE779ED;
	Fri, 29 Mar 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725423; cv=none; b=fz6cl97F1U75Pui0ncB0zE1F5Vo2PmS1vgPCN5Jy3eS6yRoI19kNCJ4yzCEIBDJcxSfsE0KDutZd3YRxJdDRbDjcDsJ7OHyTllkSy39Lb69SG68uqKwCpjNpwPf45XU1yJMDj3piMSfLV+prYnvomo5KL6SiQcQdTrb3ZpjnhBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725423; c=relaxed/simple;
	bh=cxV2h94CytkTe3yX+PhAfUA/WzzS7dvZRyGc6Wy0fVI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JWw7dBRClM9+gAFMG6Kytkdqt17+KDZNjcVq/a88ImIMfpxgW7a/+MAUC821rUmXp26NEuqyUAtEniSlQaGwtEAjzgelXVy9URmHDm7lNqU/7xMLrtDYV42zASDbOrjbi17ltH2KSbz6LG9Y74DCT8Y82rVWgxtWZdXDAC+OB94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mmy0jBkr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42TF84lj013445;
	Fri, 29 Mar 2024 15:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xKqb49aLiqfIagQXhAp4QnthHitt5DumKP+zdA38ioA=;
 b=mmy0jBkrNsti65WwbRVPmGhkXCBUxZE1TaFO0FYPMDa3uFrsSubTBtOj2pcbdzFYXqwS
 oPp1OgmL2TSus6YPk65DJvhtHjMlc1yRst60OndW78vjzRH6gvd1+mpIFyaUF8NpR8lJ
 MdFxItB1H4H5IaIIxgEBAljCzigI55Dr1e33zMg+AwEENsqeqtmiZOjJWKlfgj8CtVsP
 iySN4IJr1PhOrJC78EQA8Kwhmd6C61QD/CiVXAYoDaMgC43d/O+NfO6dRWlAwxfFuf9B
 51izz7zbQRU+F7Qwp5PsdaYVUATiBBbbKDGC04WBRFuoPaUmi71G/RyQZzQxBfS04RbZ Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x600nr0fa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 15:16:33 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42TFGXKd025192;
	Fri, 29 Mar 2024 15:16:33 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x600nr0ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 15:16:33 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42TCAw6H016605;
	Fri, 29 Mar 2024 15:16:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x29dun1yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 15:16:12 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42TFG9lT13435594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 15:16:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5213B58067;
	Fri, 29 Mar 2024 15:16:09 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E58158056;
	Fri, 29 Mar 2024 15:16:08 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.126.92])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Mar 2024 15:16:08 +0000 (GMT)
Message-ID: <e9181ec0bc07a23fc694d47b4ed49635d1039d89.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] ima: evm: Rename *_post_path_mknod() to
 *_path_post_mknod()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, viro@zeniv.linux.org.uk, pc@manguebit.com,
        christian@brauner.io, Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Date: Fri, 29 Mar 2024 11:16:07 -0400
In-Reply-To: <20240329105609.1566309-2-roberto.sassu@huaweicloud.com>
References: <20240329105609.1566309-1-roberto.sassu@huaweicloud.com>
	 <20240329105609.1566309-2-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5F0O-khqSzUeEqVZ1ma7nq3NsjZ5mjbW
X-Proofpoint-ORIG-GUID: 9nZZvu_OYfi8h2ylkCJkt-4RNTrNm77r
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 clxscore=1015 spamscore=0
 mlxlogscore=825 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403290135

On Fri, 2024-03-29 at 11:56 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Rename ima_post_path_mknod() and evm_post_path_mknod() respectively to
> ima_path_post_mknod() and evm_path_post_mknod(), to facilitate finding
> users of the path_post_mknod LSM hook.
> 
> Cc: stable@vger.kernel.org # 6.8.x

Since commit cd3cec0a02c7 ("ima: Move to LSM infrastructure") was upstreamed in
this open window.  This change does not need to be packported and should be
limited to IMA and EVM full fledge LSMs.

> Reported-by: Christian Brauner <christian@brauner.io>
> Closes: 
> https://lore.kernel.org/linux-kernel/20240328-raushalten-krass-cb040068bde9@brauner/
> Fixes: 05d1a717ec04 ("ima: add support for creating files using the mknodat
> syscall")

"Fixes: 05d1a717ec04" should be removed.

> Fixes: cd3cec0a02c7 ("ima: Move to LSM infrastructure")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Acked-by: Mimi Zohar <zohar@linux.ibm.com>


