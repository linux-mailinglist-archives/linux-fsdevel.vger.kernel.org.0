Return-Path: <linux-fsdevel+bounces-40307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE34A22138
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 17:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5F6165D5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135B019D886;
	Wed, 29 Jan 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pJHyRnFZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA145023
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166801; cv=none; b=RyQoIQ47koCky6F2Slo+QxrjLDlT+2SFmWKe+A5WSgnH0k09B30oo/gejVA0DDt3zC3hYfOpagoR9saP+xDH+pCNLFUM5ZFuaaVPvXSHqtviidwWMyb1ZBbpXnKK4Uy0va0AtE6v+ruBwTZ0p0mi7uCN0F+oAcy4eYegbebBq8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166801; c=relaxed/simple;
	bh=kBX+tTsGfdkDCs2/ErBbZ8OTpkCIL1AwIZFrZUyZqOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Disposition:MIME-Version; b=WVGtX/VNsAv9Eaoae315KYIIn2Iez9RVDXwZhWSK4MVkKCSetXgcgEWyUjOAg1wDKy/Su1Y+S9ZsC5U3LDL3lTFwAa61JbXRpPZBMgzogd+xJmM9R7tqXyUaqhrlfattXJb24FUkPiJDXbQlEOgVngiuLN5IF8qhtKSfjLOeT1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pJHyRnFZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T7Wn3i006015
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 16:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G7yEK3
	loJSbEqITzwTV5MiIT8WdRXgWyMqb4GIlsCY4=; b=pJHyRnFZz+R+iqQkrPeQGS
	U8+iTCzDxAifxrVZPRp4Pa/uRO0umtY3RykgboJws88QM6e+c9U7oGC3+xMHwrcN
	y82hfBy8nkxjdk8YvEhCWOZfxL2lpJYHPBUEdW/D9j5ypN1qFddBz8t8W89t5qdd
	NsKjHu8qiCZDGF88jKQjFuOAh6Dd6EvJ6uHl1CxHNHi05HbFWWk+HKXemzAMuZvv
	clgLB8+V5+CB17tfPjGlQKugK0jrP7H06mSekFNclNuB7A60xINc+yNSCvTemKpP
	6y25kaLteFG5kbEW/9y0hNsEDTXF9fJIj7g/PpnsD/HJOiqeAGaTIyvuKXbxCy6Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fg1nj9jq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 16:06:38 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50TFTCIS030079
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2025 16:06:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fg1nj9je-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 16:06:37 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50TFtgVL005274;
	Wed, 29 Jan 2025 16:06:37 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fg1nj9jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 16:06:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50TEGc1V022175;
	Wed, 29 Jan 2025 16:06:36 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44dcgjs4bt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 16:06:36 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50TG6YQS21102956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 16:06:34 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E260200F5;
	Wed, 29 Jan 2025 16:06:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0AF5200F3;
	Wed, 29 Jan 2025 16:06:21 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.30.109])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jan 2025 16:06:21 +0000 (GMT)
Date: Wed, 29 Jan 2025 21:36:19 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com, jack@suse.cz, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] extsize and forcealign design in filesystems
 for atomic writes
Message-ID: <Z5pRzML2jkjL01F5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <Z5nTaQgLGdD6hSvL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <35939b19-088b-450e-8fa6-49165b95b1d3@oracle.com>
In-Reply-To: <35939b19-088b-450e-8fa6-49165b95b1d3@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Is77M-qaVDA3-usNlv7bHyu83TUIVG91
X-Proofpoint-ORIG-GUID: _poBDtmh4rse1CoBIDvcoq-v7LAQoX2n
Content-Type: text/plain; charset=iso-8859-1
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
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=2 engine=8.19.0-2411120000
 definitions=main-2501290129

On Wed, Jan 29, 2025 at 08:59:15AM +0000, John Garry wrote:
> On 29/01/2025 07:06, Ojaswin Mujoo wrote:
>=20
> Hi Ojaswin,
>=20
> >=20
> > I would like to submit a proposal to discuss the design of extsize and
> > forcealign and various open questions around it.
> >=20
> >   ** Background **
> >=20
> > Modern NVMe/SCSI disks with atomic write capabilities can allow writes =
to a
> > multi-KB range on disk to go atomically. This feature has a wide variet=
y of use
> > cases especially for databases like mysql and postgres that can leverag=
e atomic
> > writes to gain significant performance. However, in order to enable ato=
mic
> > writes on Linux, the underlying disk may have some size and alignment
> > constraints that the upper layers like filesystems should follow. extsi=
ze with
> > forcealign is one of the ways filesystems can make sure the IO submitte=
d to the
> > disk adheres to the atomic writes constraints.
> >=20
> > extsize is a hint to the FS to allocate extents at a certian logical al=
ignment
> > and size. forcealign builds on this by forcing the allocator to enforce=
 the
> > alignment guarantees for physical blocks as well, which is essential fo=
r atomic
> > writes.
> >=20
> >   ** Points of discussion **
> >=20
> > Extsize hints feature is already supported by XFS [1] with forcealign s=
till
> > under development and discussion [2].
>=20
> From
> https://lore.kernel.org/linux-xfs/20241212013433.GC6678@frogsfrogsfrogs/
> thread, the alternate solution to forcealign for XFS is to use a
> software-emulated fallback for unaligned atomic writes. I am looking at a
> PoC implementation now. Note that this does rely on CoW.
>=20
> There has been push back on forcealign for XFS, so we need to prove/dispr=
ove
> that this software-emulated fallback can work, see
> https://lore.kernel.org/linux-xfs/20240924061719.GA11211@lst.de/
>=20

Hey John,

Thanks for taking a look. I did go through the 2 series sometime back.
I agree that there are some open challenges in getting the multi block
atomic write interface correct especially for mixed mappings and this is
one of the main reasons we want to explore the exchange_range fallback
in case blocks are not aligned.=20

That being said, I believe forcealign as a feature still holds a lot=20
of relevance as:

1. Right now, it is the only way to guarantee aligned blocks and hence
   gurantee that our atomic writes can always benefit from hardware atomic
   write support. IIUC DBs are not very keen on losing out on performance
   due to some writes going via the software fallback path.

2. Not all FSes support COW (major example being ext4) and hence it will
   be very difficult to have a software fallback incase the blocks are=20
	 not aligned.=20

3. As pointed out in [1], even with exchange_range there is still value
   in having forcealign to find the new blocks to be exchanged.

I agree that forcealign is not the only way we can have atomic writes
work but I do feel there is value in having forcealign for FSes and
hence we should have a discussion around it so we can get the interface
right.=20

Just to be clear, the intention of this proposal is to mainly discuss
forcealign as a feature. I am hoping there would be another different
proposal to discuss atomic writes and the plethora of other open
challenges there ;)

[1]  https://lore.kernel.org/linux-xfs/20250117182945.GH1611770@frogsfrogsf=
rogs/


> > After taking a look at ext4's multi-block
> > allocator design, supporting extsize with forcealign can be done in ext=
4 as
> > well. There is a RFC proposed which adds support for extsize hints feat=
ure in
> > ext4 [3]. However there are some caveats and deviations from XFS design=
. With
> > these in mind, I would like to propose LSFMM topic on:
> >=20
> >   * exact semantics of extsize w/ forcealign which can bring a consiste=
nt
> >     interface among ext4 and xfs and possibly any other FS that plans to
> >     implement them in the future.
> >=20
> >   * Documenting how forcealign with extsize should behave with various =
FS
> >     operations like fallocate, truncate, punch hole, insert/collapse ra=
nge etc=C2
> >=20
> >   * Implementing extsize with delayed allocation and the challenges the=
re.
> >=20
> >   * Discussing tooling support of forcealign like how are we planning t=
o maintain
> >     block alignment gurantees during fsck, resize and other times where=
 we might
> >     need to move blocks around?
> >=20
> >   * Documenting any areas where FSes might differ in their implementati=
ons of the
> >     same. Example, ext4 doesn't plan to support non power of 2 extsizes=
 whereas
> >     XFS has support for that.
> >=20
> > Hopefully this discussion will be relevant in defining consistent seman=
tics for
> > extsize hints and forcealign which might as well come useful for other =
FS
> > developers too.
> >=20
> > Thoughts and suggestions are welcome.
> >=20
> > References:
> > [1] https://man7.org/linux/man-pages/man2/ioctl_xfs_fsgetxattr.2.html=20
> > [2] https://lore.kernel.org/linux-xfs/20240813163638.3751939-1-john.g.g=
arry@oracle.com/=20
> > [3] https://lore.kernel.org/linux-ext4/cover.1733901374.git.ojaswin@lin=
ux.ibm.com/=20
> >=20
> > Regards,
> > ojaswin
>=20

