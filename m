Return-Path: <linux-fsdevel+bounces-41292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E02DA2D7B8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 18:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585213A3505
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 17:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47161F3BB0;
	Sat,  8 Feb 2025 17:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Sd7UHXm4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8061F3B8B
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Feb 2025 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739034350; cv=none; b=GjBKD6E2NH6yQQYlizRjbtETqXmmBzlfKp0UPZJJKmswPOQDQM26Em8HgXXD1k6pgHpZGRFMuhDyZLp9xZSKiLzamxZkVbd4V2Sb1enOPY67lPk1f3hLobgzRYRUUmrGqPc5sjdYesC00L6GlyKJNt33ctZ0uf01bfOQ00wtzs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739034350; c=relaxed/simple;
	bh=o5q2jWMgeIZopzW3ykNhW/gGfsOb/MIY2FUC9jDWGTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Disposition:MIME-Version; b=MGq7hE0a/Nc5oJyqGX7B96z/7+gKavqAIDOw8hWzIpjQjEcTh6gyTRyO9ErAR7Ix0PpoAJ48mFevxBhvHA2ZsqGddvn99HfaK3Y+tI9OvVCKx76vioFYEtAdoHqZbrs55m5BwcU6ET4pyBbOuIsB9qJsMjHtkpe3zgRPaWD8+eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Sd7UHXm4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5188TRxQ023323
	for <linux-fsdevel@vger.kernel.org>; Sat, 8 Feb 2025 17:05:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+TEAaa
	uXMY7wpCZmsy50sq9H7W+7zT7DvX88A//fmOY=; b=Sd7UHXm4rH/Kojl0fdy6b1
	Jzph0ImAcZpRPTnRXmhkJIWAo946cbDIue5b206pVoKjQghInP5+hRgYlXop3y4q
	g/Y5kHXDdTLtjGvdluioGWrPuY32hONgtgp7TxF0mbaAmdNqDK6y9U5jG3Jo1KcT
	aPaD5ziTdGibH48rvCISG3ztF3jIgybUOMI2R7JFhFwuwUk2ziIj8D4ba8Zrnm46
	AGSFxTllK/YG/aow28AGksAPa2or/nqwbfFItnDyItLCiLlTL64sL+hYJEwvsTX1
	I02kAzFwFKthxvs0VnP3maKYi2qxmYCBEubjnegrcgA8zoHoeVWW+apjp0tGszPg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44p11q1trf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 08 Feb 2025 17:05:48 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 518H5lD6015717
	for <linux-fsdevel@vger.kernel.org>; Sat, 8 Feb 2025 17:05:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44p11q1tr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Feb 2025 17:05:46 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 518H5kwA015706;
	Sat, 8 Feb 2025 17:05:46 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44p11q1tr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Feb 2025 17:05:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 518BkQ3Q005254;
	Sat, 8 Feb 2025 17:05:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05kggtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Feb 2025 17:05:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 518H5hit59703720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Feb 2025 17:05:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B10522009C;
	Sat,  8 Feb 2025 17:05:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2EBD20099;
	Sat,  8 Feb 2025 17:05:40 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.21.61])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  8 Feb 2025 17:05:40 +0000 (GMT)
Date: Sat, 8 Feb 2025 22:35:34 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com, jack@suse.cz, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] extsize and forcealign design in filesystems
 for atomic writes
Message-ID: <Z6eO3k4SG6TIA12p@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <Z5nTaQgLGdD6hSvL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <35939b19-088b-450e-8fa6-49165b95b1d3@oracle.com>
 <Z5pRzML2jkjL01F5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e00bac5d-5b6c-4763-8a76-e128f34dee12@oracle.com>
 <Z53JVhAzF9s1qJcr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <4a492767-ee83-469c-abd1-484d0e3b46cb@oracle.com>
 <Z6WjSJ9EbBt3qbIp@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e86ed85f-6941-44ef-96a5-0ca15faaec1d@oracle.com>
In-Reply-To: <e86ed85f-6941-44ef-96a5-0ca15faaec1d@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kBl63ZGhraqqAKDOqGG8T4-2oVrCBzrU
X-Proofpoint-ORIG-GUID: 1IKzLiu8Yj-iH9MHJHCmAHUbNVWpt2X6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-08_06,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=2 engine=8.19.0-2501170000 definitions=main-2502080143

On Fri, Feb 07, 2025 at 12:01:32PM +0000, John Garry wrote:
>=20
> > Yes, bigalloc is indeed good enough as a start but yes eventually
> > something like forcealign will be beneficial as not everyone prefers an
> > FS-wide cluster-size allocation granularity.
> >=20
> > We do have a patch for atomic writes with bigalloc that was sent way
> > back in mid 2024 but then we went into the same discussion of mixed
> > mapping[1].
> >=20
> > Hmm I think it might be time to revisit that and see if we can do
> > something better there.
> >=20
> > [1] https://lore.kernel.org/linux-ext4/37baa9f4c6c2994df7383d8b719078a5=
27e521b9.1729825985.git.ritesh.list@gmail.com/=20
>=20
> Feel free to pick up the iomap patches I had for zeroing when trying to
> atomic write mixed mappings - that's in my v3 series IIRC.

Thanks I'll give it a try.
>=20
> But you might still get some push back on them...

Right, it would be good if we all can come to a consensus of what to do
if an FS wants to implement something like forcealign for atomic writes
but does not have a way to implement software fallback. As I see, we
seem to be 2 (un)popular options:

1. Reject atomic writes on mixed mappings. This is not user space
friendly but simplest to implement

2. Zero out the unwritten part of the mapping and convert to a single
   mapping before performing the IO.

All options have their shortcomings but I think 2 is still okay. I
believe thats the path we've taken in the latest XFS patches right.

>=20
> > >=20
> > > >=20
> > > > > > I agree that forcealign is not the only way we can have atomic =
writes
> > > > > > work but I do feel there is value in having forcealign for FSes=
 and
> > > > > > hence we should have a discussion around it so we can get the i=
nterface
> > > > > > right.
> > > > > >=20
> > > > > I thought that the interface for forcealign according to the cand=
idate xfs
> > > > > implementation was quite straightforward. no?
> > > > As mentioned in the original proposal, there are still a open probl=
ems
> > > > around extsize and forcealign.
> > > >=20
> > > > - The allocation and deallocation semantics are not completely clea=
r to
> > > > 	me for example we allow operations like unaligned punch_hole but n=
ot
> > > > 	unaligned insert and collapse range, and I couldn't see that
> > > > 	documented anywhere.
> > >=20
> > > For xfs, we were imposing the same restrictions as which we have for
> > > rtextsize > 1.
> > >=20
> > > If you check the following:
> > > https://lore.kernel.org/linux-xfs/20240813163638.3751939-9-john.g.gar=
ry@oracle.com/=20
> > >=20
> > > You can see how the large allocunit value is affected by forcealign, =
and
> > > then check callers of xfs_is_falloc_aligned() -> xfs_inode_alloc_unit=
size()
> > > to see how this affects some fallocate modes.
> >=20
> > True, but it's something that just implicitly happens when we use
> > forcealign. I eventually found out while testing forcealign with
> > different operations but such things can come as a surprise to users
> > especially when we support some operations to be unaligned and then
> > reject some other similar ones.
> >=20
> > punch_hole/collapse_range is just an example and yes it might not be
> > very important to support unaligned collapse range but in the long run
> > it would be good to have these things documented/discussed.
>=20
> Maybe the man pages can be documented for forcealign/rtextsize > 1 punch
> holes/collapse behaviour - at a quick glance, I could not see anything.

Yep sounds good.

> Indeed, I am not sure how bigalloc affects punch holes/collapse range
> either.

Yeah, I think even bigalloc has the similar behavior of disallowing
unaligned insert/collapse ranges but allowing punch hole.=20
>=20
> Thanks,
> John

Regards,
ojaswin

