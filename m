Return-Path: <linux-fsdevel+bounces-6971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFF181F1B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 20:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6169B21FF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Dec 2023 19:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF0847F5C;
	Wed, 27 Dec 2023 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cCxQQR7A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566E647F46;
	Wed, 27 Dec 2023 19:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BRIHbjw029653;
	Wed, 27 Dec 2023 19:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ml9Y5Mp7YdpzZxYWY9a5OHUJel0QH3chfwN4pcEKVZ4=;
 b=cCxQQR7Adipzvo04b1hbj1njHzFvhA5mi8CuFR0zgHwEy60S8BstbBs+Tnb6crzQLEmM
 mVsUvf4VRP4qI4BnbGBn4lFGkCl+i8fV5/fZZecq4acHSc2flrOtn8XCLKsmq60hghIU
 2reVJWW797st4vtRiq+PbgpCY9rjoHiCVhyWxHVaju8NowHdjGx1Zc4pKbGcdzCQA0Yd
 GnictM5Q8Lkn2MUPEIU+zjzvWu+DUXfP8D63blBdEUW2R4VYb961PupqxEdAgy1rw/X1
 TuZapMkjPr5k6PwF4TU5NyQdVrYAWWo9EDysa9HS17uu+PIp3cBidBHFo8nZC6K5WMJF uw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v8k4s0ftm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 19:52:46 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BRJjY6o031310;
	Wed, 27 Dec 2023 19:52:45 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v8k4s0ft5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 19:52:45 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BRIbSL5017169;
	Wed, 27 Dec 2023 19:52:44 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3v6c3k3p7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Dec 2023 19:52:44 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BRJqhnl30474594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Dec 2023 19:52:43 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78AA058050;
	Wed, 27 Dec 2023 19:52:43 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24D6958045;
	Wed, 27 Dec 2023 19:52:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.140.144])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Dec 2023 19:52:41 +0000 (GMT)
Message-ID: <3bcc924ed59ecdc5fda5ab8aceeed9450a54c829.camel@linux.ibm.com>
Subject: Re: [PATCH v8 19/24] ima: Move to LSM infrastructure
From: Mimi Zohar <zohar@linux.ibm.com>
To: Casey Schaufler <casey@schaufler-ca.com>,
        Roberto Sassu
 <roberto.sassu@huaweicloud.com>,
        viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com,
        dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, shuah@kernel.org, mic@digikod.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Roberto Sassu
	 <roberto.sassu@huawei.com>
Date: Wed, 27 Dec 2023 14:52:40 -0500
In-Reply-To: <42fcd014-733b-41b2-9c7b-658533cd01a3@schaufler-ca.com>
References: <20231214170834.3324559-1-roberto.sassu@huaweicloud.com>
	 <20231214170834.3324559-20-roberto.sassu@huaweicloud.com>
	 <c6c2d413f340d858e43aa3837abdf80cb8be9d84.camel@linux.ibm.com>
	 <42fcd014-733b-41b2-9c7b-658533cd01a3@schaufler-ca.com>
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
X-Proofpoint-ORIG-GUID: XBClGj1OPCFWocoUzsTfrNGAaQ8RZ3_H
X-Proofpoint-GUID: _q93-Q7mH-WcyRhsNjOS9QLpRu8jibHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-27_12,2023-12-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=792 mlxscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312270146

On Tue, 2023-12-26 at 12:14 -0800, Casey Schaufler wrote:
> On 12/26/2023 10:14 AM, Mimi Zohar wrote:
> > On Thu, 2023-12-14 at 18:08 +0100, Roberto Sassu wrote:
> >> From: Roberto Sassu <roberto.sassu@huawei.com>
> >>
> >> Move hardcoded IMA function calls (not appraisal-specific functions) from
> >> various places in the kernel to the LSM infrastructure, by introducing a
> >> new LSM named 'ima' (at the end of the LSM list and always enabled like
> >> 'integrity').
> >>
> >> Having IMA before EVM in the Makefile is sufficient to preserve the
> >> relative order of the new 'ima' LSM in respect to the upcoming 'evm' LSM,
> >> and thus the order of IMA and EVM function calls as when they were
> >> hardcoded.
> >>
> >> Make moved functions as static (except ima_post_key_create_or_update(),
> >> which is not in ima_main.c), and register them as implementation of the
> >> respective hooks in the new function init_ima_lsm().
> >>
> >> A slight difference is that IMA and EVM functions registered for the
> >> inode_post_setattr, inode_post_removexattr, path_post_mknod,
> >> inode_post_create_tmpfile, inode_post_set_acl and inode_post_remove_acl
> >> won't be executed for private inodes. Since those inodes are supposed to be
> >> fs-internal, they should not be of interest of IMA or EVM. The S_PRIVATE
> >> flag is used for anonymous inodes, hugetlbfs, reiserfs xattrs, XFS scrub
> >> and kernel-internal tmpfs files.
> >>
> >> Conditionally register ima_post_path_mknod() if CONFIG_SECURITY_PATH is
> >> enabled, otherwise the path_post_mknod hook won't be available.
> > Up to this point, enabling CONFIG_SECURITY_PATH was not required.  By
> > making it conditional on CONFIG_SECURITY_PATH, anyone enabling IMA will
> > also need to enable CONFIG_SECURITY_PATH.  Without it, new files will
> > not be tagged as a "new" file.
> >
> > Casey, Paul, how common is it today not to enable CONFIG_SECURITY_PATH?
> > Will enabling it just for IMA be a problem?
> 
> Landlock, AppArmor and TOMOYO require it. Fedora enables Landlock and Ubuntu
> enables AppArmor. I expect that, except for "minimal" distributions, you
> won't get any push back. If a distribution is striving for minimal, it's not
> going to use IMA.
> 
> It makes me wonder if eliminating CONFIG_SECURITY_PATH might not be a
> rational alternative.

Embedded systems were the first to use IMA for file signature
verification, not distros.               Could they have enabled
SELinux, lockdown, and IMA?

Mimi


