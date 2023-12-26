Return-Path: <linux-fsdevel+bounces-6937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C91281EA4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 23:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64A31F2170B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 22:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3577D5C9C;
	Tue, 26 Dec 2023 22:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fyZHtNnp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE07A101CA;
	Tue, 26 Dec 2023 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BQIDaNR016393;
	Tue, 26 Dec 2023 22:15:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=VoRo5f6IrCV9ALJyUXnzTLDuogXBDmbUaDVMt4gglAo=;
 b=fyZHtNnpBcz/UuSTBUru5KIOSo2YU93PY1F5j6F9H0WOWNmUFSdE0EO9Lh07xkGyw3Uy
 m32uaBM4EIuwSGtlbmJDmwD1SQoNZ1yoQuxK4gbOh5DocEHgMOkge1PoUqjDfQRaJQXX
 aLR6AZ7LYvt0mkN4AIMMYlYORYAOMArPL8Yuc2nO2JhN9Xc/8LVGO/iD9c7NK/BCgl1Y
 gL5VGvYoe3Q+QnMccMTd33q4xHH3KzGBcdRmpqQ7MrewZ5EKyQI4FxeJgjjJ7tnbmMId
 3rgD6cRy4xbP/yt0f+Y3AJROutYDUxIsUvEOzfya//Dqwjhz1jSUo8GW2I6MhCcJkq3X kg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v83wtkatg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 22:15:24 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BQMFOxd023492;
	Tue, 26 Dec 2023 22:15:24 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v83wtkat9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 22:15:24 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BQIf0Vr029924;
	Tue, 26 Dec 2023 22:15:23 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3v6avnevrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 22:15:23 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BQMFMRC14680722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Dec 2023 22:15:22 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9BCF58050;
	Tue, 26 Dec 2023 22:15:22 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AE8B58045;
	Tue, 26 Dec 2023 22:15:19 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.184.58])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 Dec 2023 22:15:19 +0000 (GMT)
Message-ID: <b16e3c23475119a51218378a0749d023773b30f1.camel@linux.ibm.com>
Subject: Re: [PATCH v8 20/24] ima: Move IMA-Appraisal to LSM infrastructure
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        dmitry.kasatkin@gmail.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Roberto Sassu
	 <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Date: Tue, 26 Dec 2023 17:15:18 -0500
In-Reply-To: <20231214170834.3324559-21-roberto.sassu@huaweicloud.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
	 <20231214170834.3324559-21-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tlhLAv7YzTcht7l2Hkl5NXy03ihqIFql
X-Proofpoint-ORIG-GUID: nHQ2p4p0s8yrqBO3GhxsV7FCYYxw18SV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-26_12,2023-12-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312260170

On Thu, 2023-12-14 at 18:08 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>

A few additional IMA hooks are needed to reset the cached appraisal
status, causing the file's integrity to be re-evaluated on next access.
Register these IMA-appraisal only functions separately ...

Mimi

> Do the registration of IMA-Appraisal only functions separately from the
> rest of IMA functions, as appraisal is a separate feature not necessarily
> enabled in the kernel configuration.
> 
> Reuse the same approach as for other IMA functions, move hardcoded calls
> from various places in the kernel to the LSM infrastructure. Declare the
> functions as static and register them as hook implementations in
> init_ima_appraise_lsm(), called by init_ima_lsm().
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>


