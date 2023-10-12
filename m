Return-Path: <linux-fsdevel+bounces-166-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C03D77C6C9F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 13:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E902F1C209DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 11:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E72249FD;
	Thu, 12 Oct 2023 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WFCtacQL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3FEDF71
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 11:44:30 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098DA94;
	Thu, 12 Oct 2023 04:44:27 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CBduDp001318;
	Thu, 12 Oct 2023 11:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=GNP2HRT0gAKlMcfakYjbZFco/Zl8oaazBkcPChReGHQ=;
 b=WFCtacQLMNv5wEEpzBluoVkcEszDJnI9JxyAVzZY0M6RCZtLO5ERkqqyhDeU+QmHDwY2
 dUvZrkCKKi/qFYD3RjsMZvbsqqjkZWqwXUbvXW67H/ILfZHzyh6J4mXcOagCfagrap02
 36y/C+rVsBV0UYsrbytqIt3nTTGrQ0iJfVStYiuNFhzjffsuObvZF45MbpJTWkFHg7nG
 ks84iifvgugT5jQwme2o5r3Gh02VrPBSebKVvAyw8S3N2dcrNzM3IXUHT1mewWxUeIeW
 5zCqsAOVp0KA832uNWbxln9ONG0+KzYAsntVecYERoX0QMoOVHEuZTxX8RI7kwoz7WFb LA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpg49g2ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 11:43:43 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CBdvmK001335;
	Thu, 12 Oct 2023 11:43:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpg49g2j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 11:43:42 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39C9uQ69025891;
	Thu, 12 Oct 2023 11:43:39 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkjnnq6cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 11:43:39 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CBhcqj20710036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 11:43:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF43F58057;
	Thu, 12 Oct 2023 11:43:38 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20C9C58061;
	Thu, 12 Oct 2023 11:43:37 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.11.225])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Oct 2023 11:43:37 +0000 (GMT)
Message-ID: <b295d1aae72d8122178dc93c9aac21217bde682a.camel@linux.ibm.com>
Subject: Re: [PATCH v3 12/25] security: Introduce inode_post_setattr hook
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Thu, 12 Oct 2023 07:43:36 -0400
In-Reply-To: <80e4a1ea172edb2d4d441b70dcd93bfa1654a5b7.camel@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904133415.1799503-13-roberto.sassu@huaweicloud.com>
	 <22761c3d88c2c4dbac747cc7ddca3d743c6d88d9.camel@linux.ibm.com>
	 <80e4a1ea172edb2d4d441b70dcd93bfa1654a5b7.camel@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: rZqxV2raaNky2t0Y2n1yXeJjRecmiZQx
X-Proofpoint-GUID: RCCxgB8C4pZpo8TpW59RDhMvmyn-xMBX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-10-12 at 09:42 +0200, Roberto Sassu wrote:
> On Wed, 2023-10-11 at 20:08 -0400, Mimi Zohar wrote:
> > gOn Mon, 2023-09-04 at 15:34 +0200, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> > > the inode_post_setattr hook.
> > > 
> > > It is useful for EVM to recalculate the HMAC on modified file attributes
> > > and other file metadata, after it verified the HMAC of current file
> > > metadata with the inode_setattr hook.
> > 
> > "useful"?  
> > 
> > At inode_setattr hook, EVM verifies the file's existing HMAC value.  At
> > inode_post_setattr, EVM re-calculates the file's HMAC based on the
> > modified file attributes and other file metadata.
> > 
> > > 
> > > LSMs should use the new hook instead of inode_setattr, when they need to
> > > know that the operation was done successfully (not known in inode_setattr).
> > > The new hook cannot return an error and cannot cause the operation to be
> > > reverted.
> > 
> > Other LSMs could similarly update security xattrs or ...
> 
> I added your sentence. The one above is to satisfy Casey's request to
> justify the addition of the new hook, and to explain why inode_setattr
> is not sufficient.

I was suggesting simplifying the wording.  Perhaps something like:

Other LSMs could similarly take some action after successful file attri
bute change.

-- 
thanks,

Mimi


