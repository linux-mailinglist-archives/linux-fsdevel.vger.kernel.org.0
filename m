Return-Path: <linux-fsdevel+bounces-191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F3D7C73F2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 19:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B47A3282E4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 17:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AA034199;
	Thu, 12 Oct 2023 17:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b2mv3jUx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA66224CF
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 17:16:32 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1422D6;
	Thu, 12 Oct 2023 10:16:27 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CH2IQJ007409;
	Thu, 12 Oct 2023 17:15:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ruLAwstVJYOfziGmebf4MFgKg/exPipsxwb0UugNc+4=;
 b=b2mv3jUxA6k4cTp8yMzRSfLlz0S4Zy/Nc0UwZtt3Szi4QUfJ1Q+rStBO4u52y64zObaR
 ro/AiG7XiWrbz4Pxcgz9EmLvf/DoOywBPWDCH+I3Nw05JfLi0tzpjZhIZc9vM232dnMU
 ETX0JVSw5lp/ME6rm38lMrh2gPaoZc4AzFLlIFe846AJwQY9cbLP0b7r9Q38S68ztnAV
 AOmOZTArLtdDroBx2bmcjeCB4ANq065yMuOgntkJ1pyl2UaNiVdHVeKhzTVxiGMuQGae
 khByidn34IHmUOGBnrkpqPr2uJPly5yHdMsKno390q7OztC+dZWRvsQh/nZ2oWwWMOkO hA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpmuj0d14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 17:15:44 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CHFhwb020298;
	Thu, 12 Oct 2023 17:15:43 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpmuj0cwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 17:15:43 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CFCsfw028188;
	Thu, 12 Oct 2023 17:10:53 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tkj1yh8y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 17:10:53 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CHAqUv50135662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 17:10:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5ADB5805A;
	Thu, 12 Oct 2023 17:10:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87EDD5805D;
	Thu, 12 Oct 2023 17:10:50 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Oct 2023 17:10:50 +0000 (GMT)
Message-ID: <102b06b30518ac6595022e079de92717c92f3b8e.camel@linux.ibm.com>
Subject: Re: [PATCH v3 02/25] ima: Align ima_post_path_mknod() definition
 with LSM infrastructure
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
Date: Thu, 12 Oct 2023 13:10:50 -0400
In-Reply-To: <4866a6ef46deebf9a9afdeb7efd600edb589da93.camel@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904133415.1799503-3-roberto.sassu@huaweicloud.com>
	 <a733fe780a3197150067ad35ed280bf85e11fa97.camel@linux.ibm.com>
	 <b51baf7741de1fdee8b36a87bd2dde71184d47a8.camel@huaweicloud.com>
	 <8646e30b0074a2932076b5a0a792b14be034de98.camel@linux.ibm.com>
	 <16c8c95f2e63ab9a2fba8cba919bf129d0541b61.camel@huaweicloud.com>
	 <c16551704db68c6e0ba89c729c892e9401f05dfc.camel@linux.ibm.com>
	 <2336abd6ae195eda221d54e3c2349a4760afaff2.camel@huaweicloud.com>
	 <84cfe4d93cb5b02591f4bd921b828eb6f3e95faa.camel@linux.ibm.com>
	 <4866a6ef46deebf9a9afdeb7efd600edb589da93.camel@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: JsOvQDlFYlC1UJRUF-UeTH3-IMW7Gucg
X-Proofpoint-GUID: d359mtKa2PkNdJRCP2N4Q_la3JjXXcGd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_09,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=806
 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > > > > We need to make sure that ima_post_path_mknod() has the same parameters
> > > > > as the LSM hook at the time we register it to the LSM infrastructure.
> > > > 
> > > > I'm trying to understand why the pre hook parameters and the missing
> > > > IMA parameter are used, as opposed to just defining the new
> > > > post_path_mknod hook like IMA.
> > > 
> > > As an empyrical rule, I pass the same parameters as the corresponding
> > > pre hook (plus idmap, in this case). This is similar to the
> > > inode_setxattr hook. But I can be wrong, if desired I can reduce.
> > 
> > The inode_setxattr hook change example is legitimate, as EVM includes
> > idmap, while IMA doesn't. 
> > 
> > Unless there is a good reason for the additional parameters, I'm not
> > sure that adding them makes sense.  Not modifying the parameter list
> > will reduce the size of this patch set.
> 
> The hook is going to be used by any LSM. Without knowing all the
> possible use cases, maybe it is better to include more information now,
> than modifying the hook and respective implementations later.
> 
> (again, no problem to reduce)

Unless there is a known use case for a specific parameter, please
minimize them.   Additional parameters can be added later as needed. 

-- 
thanks,

Mimi


