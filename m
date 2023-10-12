Return-Path: <linux-fsdevel+bounces-175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 225F67C6F60
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 15:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13F0282955
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 13:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5E929424;
	Thu, 12 Oct 2023 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WNbvvIUI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329929417
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 13:36:04 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890F7E0;
	Thu, 12 Oct 2023 06:36:02 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CDRnMh001704;
	Thu, 12 Oct 2023 13:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=3e+sP/4LvWake3Mp2WG5hQgW0F0A4aNnsHpEEfmrHxE=;
 b=WNbvvIUIojMIV41Cz5CqCdRBwCEBUU/zQM07fHAVgYKTKiTflOrjKjTAbKmzufKzKDmT
 HfoTbVREAAoW6QQsXqqjuQk7iOEsJvWExXLsMUUimMND2Zo2QcyqvUhkIVYTexlNZKlx
 XhhqX6YLMCMbjS0MufJHaGP/qdHxBpDqOaGw5HDDVGTGVmNLPgFVyt7m8/svvoOpOG5O
 Nue0qTXS58JOPJ/KYJQESzC+PKm98d4taszazcNy28R73hFJ1rnVlVwghGJa1ObRx4B4
 /9uXn592PptaMTn8zHmRmq1ViReVAKi5x866W2a9znt2KnHRUAW0i5T3KXRUb+SfZSd8 lg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tphpvr92e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 13:35:32 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39CDSMhP003478;
	Thu, 12 Oct 2023 13:35:31 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tphpvr90m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 13:35:31 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39CBDmKX001170;
	Thu, 12 Oct 2023 13:35:29 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvk7bd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 13:35:29 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39CDZSuM23396882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 13:35:29 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A01A858064;
	Thu, 12 Oct 2023 13:35:28 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BB215805F;
	Thu, 12 Oct 2023 13:35:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.11.225])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Oct 2023 13:35:26 +0000 (GMT)
Message-ID: <4c11613696d2ffd92a652c1a734d4abfc489ff40.camel@linux.ibm.com>
Subject: Re: [PATCH v3 14/25] security: Introduce file_post_open hook
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
Date: Thu, 12 Oct 2023 09:35:24 -0400
In-Reply-To: <e6f0e7929abda6fa6ae7ef450b6e155b420a5f5b.camel@huaweicloud.com>
References: <20230904133415.1799503-1-roberto.sassu@huaweicloud.com>
	 <20230904133415.1799503-15-roberto.sassu@huaweicloud.com>
	 <2026a46459563d8f5d132a099f402ddad8f06fae.camel@linux.ibm.com>
	 <e6f0e7929abda6fa6ae7ef450b6e155b420a5f5b.camel@huaweicloud.com>
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
X-Proofpoint-ORIG-GUID: U59meXdpALm_ufaoOhFcEc8lkx0Nv5y8
X-Proofpoint-GUID: 6V-BGdQlrt4k18kJFgz7alScEp_zj-0E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_05,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120111
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 2023-10-12 at 14:45 +0200, Roberto Sassu wrote:
> On Thu, 2023-10-12 at 08:36 -0400, Mimi Zohar wrote:
> > On Mon, 2023-09-04 at 15:34 +0200, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > In preparation to move IMA and EVM to the LSM infrastructure, introduce the
> > > file_post_open hook. Also, export security_file_post_open() for NFS.
> > > 
> > > It is useful for IMA to calculate the dhigest of the file content, and to
> > > decide based on that digest whether the file should be made accessible to
> > > the requesting process.
> > 
> > Please remove "It is usefile for".   Perhaps something along the lines:
> > 
> > 
> > Based on policy, IMA calculates the digest of the file content and
> > decides ...
> 
> Ok.
> 
> > > 
> > > LSMs should use this hook instead of file_open, if they need to make their
> > > decision based on an opened file (for example by inspecting the file
> > > content). The file is not open yet in the file_open hook.

Needing to inspect the file contents is a good example.

>  
> > The security hooks were originally defined for enforcing access
> > control.  As a result the hooks were placed before the action.  The
> > usage of the LSM hooks is not limited to just enforcing access control
> > these days.  For IMA/EVM to become full LSMs additional hooks are
> > needed post action.  Other LSMs, probably non-access control ones,
> > could similarly take some action post action, in this case successful
> > file open.
> 
> I don't know, I would not exclude LSMs to enforce access control. The
> post action can be used to update the state, which can be used to check
> next accesses (exactly what happens for EVM).
> 
> > Having to justify the new LSM post hooks in terms of the existing LSMs,
> > which enforce access control, is really annoying and makes no sense. 
> > Please don't.
> 
> Well, there is a relationship between the pre and post. But if you
> prefer, I remove this comparison.

My comments, above, were a result of the wording of the hook
definition, below.

> > > +/**
> > > + * security_file_post_open() - Recheck access to a file after it has been opened
> > 
> > The LSM post hooks aren't needed to enforce access control.   Probably
> > better to say something along the lines of "take some action after
> > successful file open".
> > 
> > > + * @file: the file
> > > + * @mask: access mask
> > > + *
> > > + * Recheck access with mask after the file has been opened. The hook is useful
> > > + * for LSMs that require the file content to be available in order to make
> > > + * decisions.
> > 
> > And reword the above accordingly.
> > 
> > > + *
> > > + * Return: Returns 0 if permission is granted.
> > > + */
> > > +int security_file_post_open(struct file *file, int mask)
> > > +{
> > > +	return call_int_hook(file_post_open, 0, file, mask);
> > > +}
> > > +EXPORT_SYMBOL_GPL(security_file_post_open);
> > > +
> > >  /**
> > >   * security_file_truncate() - Check if truncating a file is allowed
> > >   * @file: file
> > 
> 



