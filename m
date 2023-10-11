Return-Path: <linux-fsdevel+bounces-126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2227C5E2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 22:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44AF91C20CAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Oct 2023 20:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58733CCF9;
	Wed, 11 Oct 2023 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MMxyc78M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7571D12E5B
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Oct 2023 20:18:07 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90369D;
	Wed, 11 Oct 2023 13:18:05 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39BKF2gI004155;
	Wed, 11 Oct 2023 20:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=jUFqUIlQQYDCiNzSso1s+qE/HAPZvK1rf/Wq5kMZ68U=;
 b=MMxyc78MDYWVcppPIxi/Hi8vGw1uyrWzz6VQsY+VBBDMGoX1DTZ1PKtjpcEkkcDu4iry
 WFEp0lxBMRBVZE/rbVmXOR432438HpZDfr0X+ouP/IAASy9jyDB0XtPhUUHXHNuOFxZV
 M+N48WQTkQ9+F0oiq35xJ/nmhX3tbCnXl3j9U7Xf7mCtp67/Hgxq1IW+O4GOytN6OsV6
 +gCU67CFQJVb0TP0FI9M83meN31Dom+SYh3Y+xTAF2A+HQarfQUf7otn3N8ybSUEihlT
 upcVF0ob5+pytVc4a9Xlxy0r54McaQw2MqNZEkyAlycsw6UX/UuuXQo8HJUQPuU96oY3 vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tp23j18ft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Oct 2023 20:17:36 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39BJgK0I006816;
	Wed, 11 Oct 2023 20:17:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tp23j18f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Oct 2023 20:17:35 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39BI5Wbf024439;
	Wed, 11 Oct 2023 20:17:33 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkhnsu26f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Oct 2023 20:17:33 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39BKHWLB25363092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Oct 2023 20:17:32 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5EAF58056;
	Wed, 11 Oct 2023 20:17:32 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E5F958052;
	Wed, 11 Oct 2023 20:17:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.14.38])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Oct 2023 20:17:31 +0000 (GMT)
Message-ID: <a9ed5a1a545e177f2491e132924d2b9a2a70496d.camel@linux.ibm.com>
Subject: Re: [PATCH v3 04/25] ima: Align ima_file_mprotect() definition with
 LSM infrastructure
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
        selinux@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        Stefan
 Berger <stefanb@linux.ibm.com>
Date: Wed, 11 Oct 2023 16:17:31 -0400
In-Reply-To: <b9e204c1b34c204133059b87a9a307ae5bccb84b.camel@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904133415.1799503-5-roberto.sassu@huaweicloud.com>
	 <443fb4da33eb0ac51a580e8fd51fa271a59172ef.camel@linux.ibm.com>
	 <b9e204c1b34c204133059b87a9a307ae5bccb84b.camel@huaweicloud.com>
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
X-Proofpoint-GUID: yEdWKnpi_9YFnuIHDzreB_r4e1hAuuoT
X-Proofpoint-ORIG-GUID: N6YACTqlEzQz1g97roTeGL9JOHubZggC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-11_15,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 mlxlogscore=726 lowpriorityscore=0 mlxscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310110178
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-10-11 at 17:43 +0200, Roberto Sassu wrote:
> On Wed, 2023-10-11 at 10:51 -0400, Mimi Zohar wrote:
> > On Mon, 2023-09-04 at 15:33 +0200, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Change ima_file_mprotect() definition, so that it can be registered
> > > as implementation of the file_mprotect hook.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > > ---
> > >  include/linux/ima.h               | 5 +++--
> > >  security/integrity/ima/ima_main.c | 6 ++++--
> > >  security/security.c               | 2 +-
> > >  3 files changed, 8 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/linux/ima.h b/include/linux/ima.h
> > > index 893c3b98b4d0..56e72c0beb96 100644
> > > --- a/include/linux/ima.h
> > > +++ b/include/linux/ima.h
> > > @@ -24,7 +24,8 @@ extern void ima_post_create_tmpfile(struct mnt_idmap *idmap,
> > >  extern void ima_file_free(struct file *file);
> > >  extern int ima_file_mmap(struct file *file, unsigned long reqprot,
> > >  			 unsigned long prot, unsigned long flags);
> > > -extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot);
> > > +int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
> > > +		      unsigned long prot);
> > 
> > "extern" is needed here and similarly in 5/25.
> 
> I removed because of a complain from checkpatch.pl --strict.

Intermixing with/without "extern" looks weird.  I would suggest
removing all the externs as a separate patch, but they're being removed
in "[PATCH v3 21/25] ima: Move to LSM infrastructure" anyway.  For now
I would include the "extern".

-- 
thanks,

Mimi



