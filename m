Return-Path: <linux-fsdevel+bounces-12564-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AE9861228
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FB61C228B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC37A7CF21;
	Fri, 23 Feb 2024 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hvDavKdV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A1651A2
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Feb 2024 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693284; cv=none; b=GPs1/e/UUqOhwqjbwZLfuFO/iGtCGJQfwaNHOzXy4C68ZXYil+ErbBeKIktT7Pm04izyDkc8jrWgiVqYAF9H6BeCmEpctFe44FBuY3pF4t2N06utxfowDlV0NanX4C81qFi7f4wVP+4GIIdj6GZLzBtSzAswc4sjNr95Phn5FpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693284; c=relaxed/simple;
	bh=/D015y6if6AAwdlcuR+SzGgx8YNUzdhZjrFMgHx2dRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LkBx/+iLS/pv9RGNZRunqJMJQWiD1ZKjNO4S2MjXBm9sxfvChm8n1D8x3IVbtrBIFDWRT+JuHEQUg4Mry0G6LndvW1pwYlFM0SYZ3pccuhmljp0Yw956TvXu7/lRjjRPLp57hs+GsmUJ/2ZUQLGT3L6+0iT4Av1M9IySuHCFtyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hvDavKdV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NCtlhI009956;
	Fri, 23 Feb 2024 13:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=CnHm7igyUzTnSaVCGkCzuNVgK4Jc1Hx4s9EKAAgXmSo=;
 b=hvDavKdVxR6LBDlmyFqZBiRLXK0r2UDwZaF0BcyphNgjg7NcRpZYdYwLNFTt34B7GPkl
 LFEf3po2sX3Jr9YRxRvNI7n7ec09C5cvvde4v8zcHPa8U4aoaDsPPyaww4WH0uyPV2MC
 gPMNkiry96jcB6cOMm9Ru/U5xQ3VnqLq0rQau3pY4oQldJ8M7xyNyb+Lgu5NCzQitkJd
 VhRk8MJj6NTf1riYpClX/M5GjbJ+6j+ITnqwfqsYXIvN5Q0f3hvqv3Ag+b3LUbqr1gau
 1hvzmOClEjaN7Rwbp/WwlAgmybcJ8SKDER2TceBxpJwuayg1UBrdmZSwWL7Nu5Rp64qA dA== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weukugfdx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 13:01:13 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NC7ADt017278;
	Fri, 23 Feb 2024 12:57:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb8mmw8uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 12:57:11 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NCv7bI39715118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 12:57:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1D8B20040;
	Fri, 23 Feb 2024 12:57:07 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E1C420043;
	Fri, 23 Feb 2024 12:57:07 +0000 (GMT)
Received: from osiris (unknown [9.171.74.183])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 23 Feb 2024 12:57:07 +0000 (GMT)
Date: Fri, 23 Feb 2024 13:57:06 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
Message-ID: <20240223125706.23760-A-hca@linux.ibm.com>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <20240222190334.GA412503@dev-arch.thelio-3990X>
 <20240223-delfin-achtlos-e03fd4276a34@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-delfin-achtlos-e03fd4276a34@brauner>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lYLqezVHgJiDAdqqwvORWm9sawkhuWun
X-Proofpoint-GUID: lYLqezVHgJiDAdqqwvORWm9sawkhuWun
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=853 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230094

On Fri, Feb 23, 2024 at 12:55:07PM +0100, Christian Brauner wrote:
> In short, we have to update the selinux policy for Fedora. (Fwiw, went
> through the same excercise with nsfs back then.)
> 
> I've created a pull-request here:
> 
> https://github.com/fedora-selinux/selinux-policy/pull/2050
> 
> and filed an issue here:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=2265630
> 
> We have sufficient time to get this resolved and I was assured that this
> would be resolved. If we can't get it resolved in a timely manner we'll
> default to N for a while until everything's updated but I'd like to
> avoid that. I'll track that issue.

So you are basically saying that for now it is ok to break everybody's
system who tries linux-next and let them bisect, just to figure out they
have to disable a config option?

To me this is a clear indication that the default is wrong already now.

