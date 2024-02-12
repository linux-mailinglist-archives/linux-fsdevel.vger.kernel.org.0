Return-Path: <linux-fsdevel+bounces-11184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBEA851E2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 20:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79F7285093
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 19:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D395A47F5C;
	Mon, 12 Feb 2024 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oNTEXslP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8217445C14;
	Mon, 12 Feb 2024 19:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767459; cv=none; b=gWUk4rXosBwMvX/JJkZmT6a7Onb/dtOLTdKmFcapENmUDjFb05dIFSRRdMLURQzlnoZIIgd+dVTuF6osbuXZxZJAiVzDzkNIBRLUkhNMK+nodATUFlVyOwkCyfvMj0FixH/8YhRuzgs6HGiFmgcdpS3VMVo6qdYGPvgtO3+Yp9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767459; c=relaxed/simple;
	bh=xygywyVHBKkxm+gRiy6QRXMZqerCVsdLdDFpylmsoJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+SCEjSlLG3A0IitUj80HCGL+t/qB2s6/JzGYdJxk29DT2yNmvz++QZW6QJ+hM6m20zy2ixkXmOthrHWVYpp9JlPhwgC3HEQBSGiODi/MurLvVByoC4qV4t9dWwGrMylI0FcUo4vAudD2OBl505J8yiHT2KbM2tuzm9pvx6gpVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oNTEXslP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CJeoCH004547;
	Mon, 12 Feb 2024 19:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=1qWSDMw9Z9QAM3QnEVb9qYve2metSqJEdiPenNizCLs=;
 b=oNTEXslPSizSVjjyeDq+EMgL7tHDAlvmINDHuNhX0Qw9a0kRcOA21dnIkohMrgpOwCxc
 F/EV1mQnK1eH1kfddU/Le1U8Kr2eEOela0IR/FrjWmuABDwRUCfUhiX6tANXz/U66YT5
 SoaLxlxIVzNgO0Vv89KEamoLRorIWb3vWnk9dHzGfKsurRrdT5RiYIQH9pW5KOtTh4gj
 nONby+BsDdxWtTEZ9GfO2Ew8XTzUNsUOPFETpM89+wA/SN2++YNg+z4ojT7H1rrA0Ahi
 EeeEEQGAJu5GPiCCirTcXQ+xtf2CTb6tRa9e8prRbeYn+x9Oreg4++eHLFaO7eHj3YQI zA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7rq41tkw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 19:50:30 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CJf0oB005378;
	Mon, 12 Feb 2024 19:50:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7rq41tj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 19:50:29 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CJ0bJE004287;
	Mon, 12 Feb 2024 19:50:27 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv030db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 19:50:27 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CJoOjK4981448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 19:50:26 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43C3458059;
	Mon, 12 Feb 2024 19:50:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A09E58066;
	Mon, 12 Feb 2024 19:50:22 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 19:50:22 +0000 (GMT)
Message-ID: <d86d658e-7025-491c-b0b7-6fb4d7247ea6@linux.ibm.com>
Date: Mon, 12 Feb 2024 14:50:22 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 25/25] integrity: Remove LSM
Content-Language: en-US
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
 <20240115181809.885385-26-roberto.sassu@huaweicloud.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240115181809.885385-26-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ahnTHdsVblC8Ug3sV-oVFAGWgTXNd1r4
X-Proofpoint-GUID: aKlEuRg5f8xAaWyCHensofr4krYSlqAL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=966
 adultscore=0 mlxscore=0 suspectscore=0 phishscore=0 clxscore=1015
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120152



On 1/15/24 13:18, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
> 
> Since now IMA and EVM use their own integrity metadata, it is safe to
> remove the 'integrity' LSM, with its management of integrity metadata.
> 
> Keep the iint.c file only for loading IMA and EVM keys at boot, and for
> creating the integrity directory in securityfs (we need to keep it for
> retrocompatibility reasons).
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

