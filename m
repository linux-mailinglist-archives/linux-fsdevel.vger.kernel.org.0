Return-Path: <linux-fsdevel+bounces-11659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9299855C45
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 09:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2201C2389E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Feb 2024 08:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81A117BA6;
	Thu, 15 Feb 2024 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZiFcak6n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE2417984;
	Thu, 15 Feb 2024 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985125; cv=none; b=CvXEr9K1rU3pF4Q+pPyhnmOW7ypQrWXBGkg0r4/m83VKtkJK4r13WTCv5zCAf0D+DGC3uUJJd84DyJ2gaZ6Do4ysrqd97R9wON/j7wmyhr658xGCT8gw8fUJ2U3uxdY4/TdoTsq5iOCBu8/8j1YvY2yDQO80Q+HUQ4cHnV3ofsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985125; c=relaxed/simple;
	bh=tQiuOODpfiSZqbi1fSHEb7a5d1KdNB1lrpcclcbPW5o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=gfSyCp9rQH1XZhtAh4cd8uginJshUZ57gYAIByEOgLmS2XnX+sjxDv+IvoeoIAZJLyGccbMSVpZGEMhrcoZgJzWBCTXz7HzdQ48C96PBGS0Ab2gtVls2F51sftj+3EtfkLtsXaUeDVlwmwaqieJFiwhEpMoGVFuUcn97LpTz1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZiFcak6n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41F8BcoY032007;
	Thu, 15 Feb 2024 08:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=xQpf4U6thY0RmYjLTmzPv/P+MlK6sZqho4klRx7+4kg=;
 b=ZiFcak6n4DVmF+NJkPnhQWWDMSj50pD72AfSoDtFmIEGzwGGSJciJIeUNtZXbr3I5epn
 i+G+F5ozsRoZE12hA8rz2FndgygnuVElri6hT1lZ9yfqBElugOTWbDHRHLD/oB2cR/OZ
 FSq2KhqKU9c93+tSH2do2g+Ro3074iav/VYcQC2bk8bzepP7OkPXeaNywF69JQ5OoEH/
 EQDhBdPUfL7wCSjsXFenIAXe85A2BN3d252Ze259y0tgfuP4bu0YdENz5GfVl65yqQNT
 zI0N7COFL41YtOH3gEgrcxSvMSGv4FpBAeDGU0WCPs0jXpA6lX72KpUaLuwzQCPtCCnB tA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9dnd216y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 08:18:09 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41F8ADxQ028970;
	Thu, 15 Feb 2024 08:18:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9dnd215u-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 08:18:08 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41F7FPjv004339;
	Thu, 15 Feb 2024 08:16:22 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv0kmte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 08:16:22 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41F8GJnj13173444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 08:16:22 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE6CB58059;
	Thu, 15 Feb 2024 08:16:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4853558057;
	Thu, 15 Feb 2024 08:16:18 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.77.242])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 08:16:18 +0000 (GMT)
Message-ID: <6ffcd054ff81d64b92b52baf097ed21f8ea4d870.camel@linux.ibm.com>
Subject: Re: [PATCH v9 12/25] security: Introduce file_post_open hook
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org,
        neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com,
        jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Date: Thu, 15 Feb 2024 03:16:17 -0500
In-Reply-To: <CAHC9VhQGiSq2LTm7TBvCwDB_NcMe_JjORLbuHVfC4UpJQi_N4g@mail.gmail.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
	 <20240115181809.885385-13-roberto.sassu@huaweicloud.com>
	 <305cd1291a73d788c497fe8f78b574d771b8ba41.camel@linux.ibm.com>
	 <CAHC9VhQ7DgPJtNTRCYneu_XnpRmuwfPCW+FqVuS=k6U5-F6pJw@mail.gmail.com>
	 <05ad625b0f5a0e6c095abee5507801da255b36cd.camel@huaweicloud.com>
	 <CAHC9VhR2M_MWHs34kn-WH3Wr0sgT09WKveecy7onkFhUb1-gEg@mail.gmail.com>
	 <63afc94126521629bb7656b6e6783d6614ee898a.camel@linux.ibm.com>
	 <CAHC9VhQGiSq2LTm7TBvCwDB_NcMe_JjORLbuHVfC4UpJQi_N4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JPiXEt9OIAZjMDJms0hUwl0uAwRfnvqC
X-Proofpoint-GUID: tM-IWJ0kHfrSVh4SVeDZK-a2LckzZzzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_08,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402150064

On Wed, 2024-02-14 at 16:21 -0500, Paul Moore wrote:
> On Wed, Feb 14, 2024 at 3:07 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Tue, 2024-02-13 at 10:33 -0500, Paul Moore wrote:
> > > On Tue, Feb 13, 2024 at 7:59 AM Roberto Sassu
> > > <roberto.sassu@huaweicloud.com> wrote:
> > > > On Mon, 2024-02-12 at 16:16 -0500, Paul Moore wrote:
> > > > > On Mon, Feb 12, 2024 at 4:06 PM Mimi Zohar <zohar@linux.ibm.com>
> > > > > wrote:
> > > > > > Hi Roberto,
> > > > > > 
> > > > > > 
> > > > > > > diff --git a/security/security.c b/security/security.c
> > > > > > > index d9d2636104db..f3d92bffd02f 100644
> > > > > > > --- a/security/security.c
> > > > > > > +++ b/security/security.c
> > > > > > > @@ -2972,6 +2972,23 @@ int security_file_open(struct file *file)
> > > > > > >       return fsnotify_perm(file, MAY_OPEN);  <===  Conflict
> > > > > > 
> > > > > > Replace with "return fsnotify_open_perm(file);"
> > > > > > 
> > > > > > >  }
> > > > > > > 
> > > > > > 
> > > > > > The patch set doesn't apply cleaning to 6.8-rcX without this
> > > > > > change.  Unless
> > > > > > there are other issues, I can make the change.
> > > > > 
> > > > > I take it this means you want to pull this via the IMA/EVM tree?
> > > > 
> > > > Not sure about that, but I have enough changes to do to make a v10.
> > 
> > @Roberto:  please add my "Reviewed-by" to the remaining patches.
> > 
> > > Sorry, I should have been more clear, the point I was trying to
> > > resolve was who was going to take this patchset (eventually).  There
> > > are other patches destined for the LSM tree that touch the LSM hooks
> > > in a way which will cause conflicts with this patchset, and if
> > > you/Mimi are going to take this via the IMA/EVM tree - which is fine
> > > with me - I need to take that into account when merging things in the
> > > LSM tree during this cycle.  It's not a big deal either way, it would
> > > just be nice to get an answer on that within the next week.
> > 
> > Similarly there are other changes for IMA and EVM.  If you're willing to
> > create
> > a topic branch for just the v10 patch set that can be merged into your tree
> > and
> > into my tree, I'm fine with your upstreaming v10. (I'll wait to send my pull
> > request after yours.)  Roberto will add my Ack's to the integrity, IMA, and
> > EVM
> > related patches.  However if you're not willing to create a topic branch,
> > I'll
> > upstream the v10 patch set.
> 
> I'm not a big fan of sharing topic branches across different subsystem
> trees, I'd much rather just agree that one tree or another takes the
> patchset and the others plan accordingly.

Just curious why not?

> Based on our previous
> discussions I was under the impression that you wanted me to merge
> this patchset into lsm/dev, but it looks like that is no longer the
> case - which is okay by me.

Paul, I don't recall saying that.  Please go ahead and upstream it.  Roberto can
add my acks accordingly.

Mimi

> Assuming Roberto gets a v10 out soon, do you expect to merge the v10
> patchset and send it up during the upcoming merge window (for v6.9),
> or are you expecting to wait until after the upcoming merge window
> closes and target v6.10?  Once again, either is fine, I'm just trying
> to coordinate this with other patches.




