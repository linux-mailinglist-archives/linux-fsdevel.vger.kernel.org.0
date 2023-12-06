Return-Path: <linux-fsdevel+bounces-5026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EECED80754F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 17:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E90C1C20F1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6F548CF2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 16:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Cts1C9t4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3026A3;
	Wed,  6 Dec 2023 08:12:16 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6Fm1ef002321;
	Wed, 6 Dec 2023 16:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=TirS9AB+02GzCC/ZaT3LtdSlY0QQT78AikkNU0XEjlE=;
 b=Cts1C9t4gvRUGFNjdY/Grg8/HujBcGuE5tzUci4EhA0sIV9ZNRPB4DsRtWz07QyJ1WA1
 c04paI7fa6XXk5RyzpDaRVgWz0HEHTw7l0teEk3s8Sf4sL39UNE6exXk8EphXCgyg9fn
 aMj7wjsONEl///4Iu4SdDqKFQneaiMJh4BFztVOZ6l/8GB5cQj5ggEIq66tp0cywMGPi
 uvpsVT8Tu4rFGHjAivMSHmIQxRzJauNeLTgNdDkJjlf0arnRu3EzW7ZGyrJ9REKCYUow
 8FjUmRelGLkj+E03dem1e4E9U7uf807VSjY7Hc8EAL7f9+HQE0zWxMfFKxGymPIx4wYJ tg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utuwn8x04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 16:11:13 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B6Fn94v007176;
	Wed, 6 Dec 2023 16:11:12 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3utuwn8wyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 16:11:12 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6G73nb004688;
	Wed, 6 Dec 2023 16:11:11 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3utav4deqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 16:11:11 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B6GBB6m15663660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Dec 2023 16:11:11 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F190858050;
	Wed,  6 Dec 2023 16:11:10 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3F9B58045;
	Wed,  6 Dec 2023 16:11:08 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.99.183])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Dec 2023 16:11:08 +0000 (GMT)
Message-ID: <7aefd87764ba8962de85250ff92b82800550401b.camel@linux.ibm.com>
Subject: Re: [PATCH v5 23/23] integrity: Switch from rbtree to LSM-managed
 blob for integrity_iint_cache
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Paul Moore
	 <paul@paul-moore.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org,
        serge@hallyn.com, dmitry.kasatkin@gmail.com, dhowells@redhat.com,
        jarkko@kernel.org, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com, mic@digikod.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Wed, 06 Dec 2023 11:11:08 -0500
In-Reply-To: <d608edb80efe03b62698ab33cbee1eea856a0422.camel@huaweicloud.com>
References: <20231107134012.682009-24-roberto.sassu@huaweicloud.com>
	 <17befa132379d37977fc854a8af25f6d.paul@paul-moore.com>
	 <2084adba3c27a606cbc5ed7b3214f61427a829dd.camel@huaweicloud.com>
	 <CAHC9VhTTKac1o=RnQadu2xqdeKH8C_F+Wh4sY=HkGbCArwc8JQ@mail.gmail.com>
	 <b6c51351be3913be197492469a13980ab379e412.camel@huaweicloud.com>
	 <CAHC9VhSAryQSeFy0ZMexOiwBG-YdVGRzvh58=heH916DftcmWA@mail.gmail.com>
	 <90eb8e9d-c63e-42d6-b951-f856f31590db@huaweicloud.com>
	 <CAHC9VhROnfBoaOy2MurdSpcE_poo_6Qy9d2U3g6m2NRRHaqz4Q@mail.gmail.com>
	 <5f441267b6468b98e51a08d247a7ae066a60ff0c.camel@huaweicloud.com>
	 <d608edb80efe03b62698ab33cbee1eea856a0422.camel@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: Y28njRj7zR3cjjYOzyBPbBfJWG3Qmg_U
X-Proofpoint-GUID: 5uBuPgG_9R1M1ich1n8oG8dyH5r9Eh7W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_14,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=934 suspectscore=0 mlxscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060131

On Wed, 2023-12-06 at 14:10 +0100, Roberto Sassu wrote:
> On Mon, 2023-12-04 at 14:26 +0100, Roberto Sassu wrote:

...
> > If the result of this patch set should be that IMA and EVM become
> > proper LSMs without the shared integrity layer, instead of collapsing
> > all changes in this patch set, I think we should first verify if IMA
> > and EVM can be really independent. Once we guarantee that, we can
> > proceed making the proper LSMs.
> > 
> > These are the changes I have in mind:
> > 
> > 1) Fix evm_verifyxattr(), and make it work without integrity_iint_cache
> > 2) Remove the integrity_iint_cache parameter from evm_verifyxattr(),
> >    since the other callers are not going to use it
> 
> Ehm, I checked better.
> 
> integrity_inode_get() is public too (although it is not exported). So,
> a caller (not IMA) could do:
> 
> iint = integrity_inode_get(inode);
> status = evm_verifyxattr(..., iint);
> 
> However, it should not call integrity_inode_free(), which is also in
> include/linux/integrity.h, since this is going to be called by
> security_inode_free() (currently).

Calling integrity_inode_free() directly would release the iint early.  
As a result, IMA would then need to re-allocate it on next access. 
Other than impacting IMA's performance, is this a problem?

> > 3) Create an internal function with the original parameters to be used
> >    by IMA
> > 4) Introduce evm_post_path_mknod(), which similarly to
> >    ima_post_path_mknod(), sets IMA_NEW_FILE for new files
> 
> I just realized that also this is changing the current behavior.
> 
> IMA would clear IMA_NEW_FILE in ima_check_last_writer(), while EVM
> wouldn't (unless we implement the file_release hook in EVM too).

True

Mimi

> > 5) Add hardcoded call to evm_post_path_mknod() after
> >    ima_post_path_mknod() in security.c
> > 
> > If we think that this is good enough, we proceed with the move of IMA
> > and EVM functions to the LSM infrastructure (patches v7 19-21).
> > 
> > The next patches are going to be similar to patches v6 22-23, but
> > unlike those, their goal would be simply to split metadata, not to make
> > IMA and EVM independent, which at this point has been addressed
> > separately in the prerequisite patches.
> > 
> > The final patch is to remove the 'integrity' LSM and the integrity
> > metadata management code, which now is not used anymore.
> > 
> > Would that work?
> 
> We are not making much progress, I'm going to follow any recommendation
> that would move this forward.


