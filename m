Return-Path: <linux-fsdevel+bounces-11606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C596E8553AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 21:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BFAF1F2AE6C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 20:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9962C13DBB1;
	Wed, 14 Feb 2024 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XO4ti+F8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4692613A888;
	Wed, 14 Feb 2024 20:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941289; cv=none; b=lK7rO3tuBI7LPpW2KD9dewlV0nI2AnsXyvixk5penrGsX/RpBYFAc4bu79UkwW+5PRZFrze/YmyO5bnWQnPYE3CtsBdsCOrGn10ktliBz2LNvHHo58Ouk3idDKxQtMTm9AAq504tF03BB/W7CbJ/Q+yz9ZJDIDbkuzkEbNc5Oo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941289; c=relaxed/simple;
	bh=0c27WM48Hr69yQ4BRbSljfY+8max5aVHrUQMsvmvoT0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=rGXh9vzZ+mmwWZGkm30yg52gEsaQcN2MOdm5gRYvMIdxaKslP0BZQw507K2stJttasCJvxsGAQrGRECj1RgUwRfX+49JAoELWj51pe4/JuYCYQGglmNn9WTR/jZHmIoVCzd9zTBbuep2lySmnAl+6/sf281G10LWA2luIhM2VLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XO4ti+F8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EJvFTF004798;
	Wed, 14 Feb 2024 20:07:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=mXHxoZ42mf/ESBqj6s5bnVAfG0vN7uRQxTDbGz8SwAo=;
 b=XO4ti+F8dvznCzwOMommY2wHzUPRF12PQUnYJO8wcMld4+xLiaDZrncmLdNb92rQ7TNe
 RQ+9rYnPchBKUFw5S9Fl7I38jgR7LO6LKwUUOB0dExBhkPLH6UbwCM16YyMy4XS2iK2r
 +0gh0WxTiNUirdOxbsuLbSFMGF0eadMRe4+BzFbNOEyWOpeZYWi0E0go6AeH/J1ElsT2
 sExdubjt5KshLHd61G8KyAJvOgkxAqxFZJV+1qsKFpJwgPGTcHLj9XBxFxl787CNPkXw
 AuT6Oi0YJiz5OVwSzTfJppPGbBIYD6oTQ2vUShlvwWT49EtCY3XXiM+cGR1oI6+ZznNS ug== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w944jranh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 20:07:32 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41EJvn2l007248;
	Wed, 14 Feb 2024 20:07:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w944jramk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 20:07:31 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41EIYP1m004329;
	Wed, 14 Feb 2024 20:07:30 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv0gd5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 20:07:30 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41EK7RHI19005960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 20:07:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8504C5805A;
	Wed, 14 Feb 2024 20:07:27 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF2835805E;
	Wed, 14 Feb 2024 20:07:25 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.101.207])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 20:07:25 +0000 (GMT)
Message-ID: <63afc94126521629bb7656b6e6783d6614ee898a.camel@linux.ibm.com>
Subject: Re: [PATCH v9 12/25] security: Introduce file_post_open hook
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>,
        Roberto Sassu
	 <roberto.sassu@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de, kolga@netapp.com,
        Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org,
        serge@hallyn.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com,
        dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org,
        mic@digikod.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>
Date: Wed, 14 Feb 2024 15:07:25 -0500
In-Reply-To: <CAHC9VhR2M_MWHs34kn-WH3Wr0sgT09WKveecy7onkFhUb1-gEg@mail.gmail.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
	 <20240115181809.885385-13-roberto.sassu@huaweicloud.com>
	 <305cd1291a73d788c497fe8f78b574d771b8ba41.camel@linux.ibm.com>
	 <CAHC9VhQ7DgPJtNTRCYneu_XnpRmuwfPCW+FqVuS=k6U5-F6pJw@mail.gmail.com>
	 <05ad625b0f5a0e6c095abee5507801da255b36cd.camel@huaweicloud.com>
	 <CAHC9VhR2M_MWHs34kn-WH3Wr0sgT09WKveecy7onkFhUb1-gEg@mail.gmail.com>
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
X-Proofpoint-ORIG-GUID: 3pmfVPR_ZkYzTv8MNJbgBILvsfAhufy_
X-Proofpoint-GUID: pUskxnPY1Bl82nL8IEpe0UmPvkoY0NWY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_12,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402140157

On Tue, 2024-02-13 at 10:33 -0500, Paul Moore wrote:
> On Tue, Feb 13, 2024 at 7:59 AM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> > On Mon, 2024-02-12 at 16:16 -0500, Paul Moore wrote:
> > > On Mon, Feb 12, 2024 at 4:06 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > Hi Roberto,
> > > > 
> > > > 
> > > > > diff --git a/security/security.c b/security/security.c
> > > > > index d9d2636104db..f3d92bffd02f 100644
> > > > > --- a/security/security.c
> > > > > +++ b/security/security.c
> > > > > @@ -2972,6 +2972,23 @@ int security_file_open(struct file *file)
> > > > >       return fsnotify_perm(file, MAY_OPEN);  <===  Conflict
> > > > 
> > > > Replace with "return fsnotify_open_perm(file);"
> > > > 
> > > > >  }
> > > > > 
> > > > 
> > > > The patch set doesn't apply cleaning to 6.8-rcX without this
> > > > change.  Unless
> > > > there are other issues, I can make the change.
> > > 
> > > I take it this means you want to pull this via the IMA/EVM tree?
> > 
> > Not sure about that, but I have enough changes to do to make a v10.

@Roberto:  please add my "Reviewed-by" to the remaining patches.

> 
> Sorry, I should have been more clear, the point I was trying to
> resolve was who was going to take this patchset (eventually).  There
> are other patches destined for the LSM tree that touch the LSM hooks
> in a way which will cause conflicts with this patchset, and if
> you/Mimi are going to take this via the IMA/EVM tree - which is fine
> with me - I need to take that into account when merging things in the
> LSM tree during this cycle.  It's not a big deal either way, it would
> just be nice to get an answer on that within the next week.

Similarly there are other changes for IMA and EVM.  If you're willing to create
a topic branch for just the v10 patch set that can be merged into your tree and
into my tree, I'm fine with your upstreaming v10. (I'll wait to send my pull
request after yours.)  Roberto will add my Ack's to the integrity, IMA, and EVM
related patches.  However if you're not willing to create a topic branch, I'll
upstream the v10 patch set.

thanks,

Mimi


