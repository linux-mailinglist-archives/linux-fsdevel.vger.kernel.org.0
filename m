Return-Path: <linux-fsdevel+bounces-11188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D32E5851F1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C7B1C21EFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 21:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9F243AA8;
	Mon, 12 Feb 2024 21:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fnn3m8Qp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9763B4BAA6;
	Mon, 12 Feb 2024 21:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707771994; cv=none; b=AdkmaG4Y3EcIeuXOdlty2Bti5IpvNkRt0gIF4c2AQZfbgRCwJENu5iMx+irJZOe331O5mQrOLbenpkEwpc7//BwShejaaA/lXtbrBOmrSBOKcH2C8etaoNN4KezxgMTHRV81rroIzlFZSj7rQMohZviliN7BACgS24adIm7rUr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707771994; c=relaxed/simple;
	bh=WOCaTXiHT/gTBKz8I905kYg3HZ4wKewbyQbmdauMPR8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=k+uDoxtIvLomulUUUoTj21svYeudqWgku6nS99ZXDHlnOYPOIKn5Uc/0QdraIWnEZwnGpzmXbEkYcR1tZZocGeOnIQHFgFiwAx8w5Z+sO8PIXSEThJo91rB0h17eX82VBO7VhDxKMRmFdI/oYT9uB/vNYEswTjT56mDVIW2CBOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fnn3m8Qp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CL2bq3016465;
	Mon, 12 Feb 2024 21:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=hyjD0aJ8LyZ5qPFArghXLMKuTGD3SIZmoUaIuuQVY9Y=;
 b=Fnn3m8QpmWYfZumwDcGlFwlCTkbm3uOga+Y0pr/VZ1wIMh+axHs0qNanh5jDtTH/60hm
 323acb9ir0gM8WKwFDZUS3mUKb9gWf7tMJJykMIYh/yBDV9bNWX0aLABX0OfVpX6ClMR
 /XUHD/McWWyHWXsDsU/k2BQw37x3U/NCOMFTmgVvNOaPS4TptgBsZPc7wAxGmTsYXa/P
 JUedqpZf8rimyuDdnnladbQ7br+s9saqc0zSIsnJd7TMsQ1rw1Mi/y68EI2lFlkF9UJY
 cEeb/FVJ9EstukwOvscPc1vLBwoOXsdKo3StYCDpbl2D5KOxAVFIJ2vrtmk90dg8Jlo8 dg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7tw9g47v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 21:05:57 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CL3iEC019822;
	Mon, 12 Feb 2024 21:05:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7tw9g470-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 21:05:56 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CJGmgo024878;
	Mon, 12 Feb 2024 21:00:55 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfp34p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 21:00:55 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CL0qYl28181202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 21:00:54 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6524358076;
	Mon, 12 Feb 2024 21:00:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB5725805C;
	Mon, 12 Feb 2024 21:00:50 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.73.237])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Feb 2024 21:00:50 +0000 (GMT)
Message-ID: <305cd1291a73d788c497fe8f78b574d771b8ba41.camel@linux.ibm.com>
Subject: Re: [PATCH v9 12/25] security: Introduce file_post_open hook
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org,
        mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Roberto Sassu
	 <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Date: Mon, 12 Feb 2024 16:00:50 -0500
In-Reply-To: <20240115181809.885385-13-roberto.sassu@huaweicloud.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
	 <20240115181809.885385-13-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fwTq-ORuY4eUEMDSmtEUx3WTaqBFlsH8
X-Proofpoint-ORIG-GUID: ixco56Pb_Pr-9e5H6t8K6WSdAPs_nZUT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_16,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120163

Hi Roberto,


> diff --git a/security/security.c b/security/security.c
> index d9d2636104db..f3d92bffd02f 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2972,6 +2972,23 @@ int security_file_open(struct file *file)
>  	return fsnotify_perm(file, MAY_OPEN);  <===  Conflict

Replace with "return fsnotify_open_perm(file);"

>  }
>  

The patch set doesn't apply cleaning to 6.8-rcX without this change.  Unless
there are other issues, I can make the change.

thanks,

Mimi


