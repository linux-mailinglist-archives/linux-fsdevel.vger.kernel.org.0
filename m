Return-Path: <linux-fsdevel+bounces-15697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D511089243F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 20:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9092E286E3E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 19:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA00E13AA5D;
	Fri, 29 Mar 2024 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QpzfPYRT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184E113958C;
	Fri, 29 Mar 2024 19:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711740529; cv=none; b=gjT4lFL9nbbUZ8kGA2kMU6WYVimGVTPhaQcnKppJqmlhrfH1Pc6XR3xNSqW28TXHaWzdBQ7BHHiuQ2jdfJlQZqHbGYJ03XnprIKhr2QwJ7aekwU2EG8+x3mu+MpWyR4NaZ65ScITgCiCaZkWonfz26mVgV0GA6fNkMs0tWvNzqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711740529; c=relaxed/simple;
	bh=EuthMF2I/CGCzxqbIW6CTFTU3WJ9GvZd0sLdLmgf2QM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=RksE7e0w28O8cUNyFEDkqLWY3XTf70U4dAK/8cje+wovQOhIsqjcXvHJrAiWXrRjWVFEdncldifozBn1aIv/h912oWbmAyNszvdMZfENef3SMLLPxw76Mbo161L5fvoreeN9gRAX1OHEu2nwK/o4N20cUEPf7k/EJPbYaX+UlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QpzfPYRT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42TJOar2005192;
	Fri, 29 Mar 2024 19:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=RPm6LRHYSctRSd+zM9QadhHObB66yv7gwSwuVesuA4Q=;
 b=QpzfPYRTKVLh+Nmh2zSXApG3hcBPdLM/EAUwlCEcKdPZfpAKQh4rDmWySWa+O8IH9HOv
 IcW67No8lUENsqTIjGSF9Z1hvun1we3W0qrOAZWg/S8odqEuwmaKw4eQr2MAzjn+rj8e
 IpKoGhJ3m0CqrGlW8Wms6p5o0iaMOvUDc+orarW7exVzH3Hi19dsOeDyF6zehkKruCyK
 cBu9NopCa4gVQxEkBBXkL1H+hUp2oLL3CV2Q9UiA/yPnvl6uGNjeXm3TAivgUX+nD91X
 B4OPdtV79Vfo8UX3i45vIgq+fVetYGQV8ukp2me1ed/a6h2yDxBDCkVDctroSZgJ7usi 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x61peg9dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 19:28:05 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42TJS4B2011403;
	Fri, 29 Mar 2024 19:28:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x61peg9de-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 19:28:04 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42TGmPMS028620;
	Fri, 29 Mar 2024 19:28:02 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3x2adpwyqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 19:28:02 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42TJS0gu42205732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Mar 2024 19:28:02 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0890258074;
	Fri, 29 Mar 2024 19:28:00 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFAAA58070;
	Fri, 29 Mar 2024 19:27:58 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.12.217])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Mar 2024 19:27:58 +0000 (GMT)
Message-ID: <1fe6813db395563be658a9b557931cf4db949100.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] ima: evm: Rename *_post_path_mknod() to
 *_path_post_mknod()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Roberto Sassu <roberto.sassu@huaweicloud.com>, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, viro@zeniv.linux.org.uk, pc@manguebit.com,
        christian@brauner.io, Roberto
 Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org, Sasha Levin
 <sashal@kernel.org>,
        Greg KH <greg@kroah.com>
Date: Fri, 29 Mar 2024 15:27:58 -0400
In-Reply-To: <CAHC9VhS49p-rffsP4gW5C-C6kOqFfBWJhLrfB_zunp7adXe2cQ@mail.gmail.com>
References: <20240329105609.1566309-1-roberto.sassu@huaweicloud.com>
	 <20240329105609.1566309-2-roberto.sassu@huaweicloud.com>
	 <e9181ec0bc07a23fc694d47b4ed49635d1039d89.camel@linux.ibm.com>
	 <CAHC9VhS49p-rffsP4gW5C-C6kOqFfBWJhLrfB_zunp7adXe2cQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-23.el8_9) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZNE1V6pIpT0OlP36vtct_NB6tvbA6TUj
X-Proofpoint-ORIG-GUID: HCT9qPZXNSd6ke-dTfHCrx6LyGPgzf-y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_13,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0
 clxscore=1011 malwarescore=0 mlxlogscore=940 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403290174

[Cc: Sasha, Greg]

On Fri, 2024-03-29 at 15:12 -0400, Paul Moore wrote:
> I'd take it one step further and remove both 'Fixes' tags.  A 'Fixes'
> tag implies a flaw in the functionality of the code, this is just a
> function rename.

Totally agree.

> Another important thing to keep in mind about 'Fixes' tags, unless
> you've told the stable kernel folks to only take patches that you've
> explicitly marked for stable, they are likely going to attempt to
> backport anything with a 'Fixes' tag.

How do we go about doing that?  Do we just send an email to stable?

Is it disabled for security?  I thought new functionality won't be backported. 
Hopefully the changes for making IMA & EVM full fledged LSMs won't be
automatically backported to stable.

thanks,

Mimi


