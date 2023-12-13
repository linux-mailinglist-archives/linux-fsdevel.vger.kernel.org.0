Return-Path: <linux-fsdevel+bounces-5809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3928109C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 07:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271AE281E3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 06:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64655DDCB;
	Wed, 13 Dec 2023 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YjgO2RbA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7439F7;
	Tue, 12 Dec 2023 22:00:14 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD5gRtY009863;
	Wed, 13 Dec 2023 06:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=TjaLeJnqTOAYTFIcON8BZhczgaQnsRt3YN92XTznSZU=;
 b=YjgO2RbA7ZTb6qQQT9Pd1Q+4qL1RWzIMcPKn0H+8jxnep/6LUCUTPXHxQa0+bDeUC4Ze
 ikyIq4TalgvhwJvH+1i/FTy7aUBKITv0bult90vOXDozybGR2s/itZ0xaHzpqpBsKEH6
 1InwZtbbNrbZ37b3dLDwe/kbM4j1pB/z+QcrhSAtdo+gwKy4MUINWpizEmSP2aFr5m0z
 GdVzLl9435VoVvIxGfNyRLRqQ9SFFiRVVGAu1JfpjyuC8IKu8/qgp71CSRy6ojhZDzES
 4b3/EMZelNuTjdFYh8QK71zqt510twEc56E46O0HaKZhHoeRsUt8+soRUqv7fEsnnGiZ 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uy6pvrdvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 06:00:08 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BD5qh9W003082;
	Wed, 13 Dec 2023 06:00:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uy6pvrduc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 06:00:07 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BD4e9Ij004899;
	Wed, 13 Dec 2023 06:00:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4skeb1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Dec 2023 06:00:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BD604pw44827110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Dec 2023 06:00:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA6D32004D;
	Wed, 13 Dec 2023 06:00:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAE5820043;
	Wed, 13 Dec 2023 06:00:01 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.51.82])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 13 Dec 2023 06:00:01 +0000 (GMT)
Date: Wed, 13 Dec 2023 11:29:57 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
Subject: Re: [RFC 0/7] ext4: Allocator changes for atomic write support with
 DIO
Message-ID: <ZXlIXWIqP9xipYzL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <8c06c139-f994-442b-925e-e177ef2c5adb@oracle.com>
 <ZW3WZ6prrdsPc55Z@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <de90e79b-83f2-428f-bac6-0754708aa4a8@oracle.com>
 <ZXbqVs0TdoDcJ352@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <c4cf3924-f67d-4f04-8460-054dbad70b93@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4cf3924-f67d-4f04-8460-054dbad70b93@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _8OkYYCLfW-dy6EZ47uB0qBsdgMdIFs4
X-Proofpoint-ORIG-GUID: 7rrjuVr4GoM9eExABM89Fy3OpjTg-SS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_14,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=851 adultscore=0 spamscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130041

On Tue, Dec 12, 2023 at 07:46:51AM +0000, John Garry wrote:
> On 11/12/2023 10:54, Ojaswin Mujoo wrote:
> > > This seems a rather big drawback.
> > So if I'm not wrong, we force the extent alignment as well as the size
> > of the extent in xfs right.
> 
> For XFS in my v1 patchset, we only force alignment (but not size).
> 
> It is assumed that the user will fallocate/dd the complete file before
> issuing atomic writes, and we will have extent alignment and length as
> required.
> 
> However - as we have seen with a trial user - it can create a problem if we
> don't do that and we write 4K and then overwrite with a 16K atomic write to
> a file, as 2x extents may be allocated for the complete 16K and it cannot be
> issued as a single BIO.

So currently, if we don't fallocate beforehand in xfs and the user
tries to do the 16k overwrite to an offset having a 4k extent, how are
we handling it?

Here ext4 will return an error indicating atomic write can't happen at
this particular offset. The way I see it is if the user passes atomic
flag to pwritev2 and we are unable to ensure atomicity for any reason we
return error, which seems like a fair approach for a generic interface. 

> 
> > 
> > We didn't want to overly restrict the users of atomic writes by
> > forcing
> > the extents to be of a certain alignment/size irrespective of the
> > size
> > of write. The design in this patchset provides this flexibility at
> > the
> > cost of some added precautions that the user should take (eg not
> > doing
> > an atomic write on a pre existing unaligned extent etc).
> 
> Doesn't bigalloc already give you what you require here?

Yes, but its an mkfs time feature and it also applies to each an every
file which might not be desirable for all use cases. 

Regards,
ojaswin

