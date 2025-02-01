Return-Path: <linux-fsdevel+bounces-40527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6D7A24769
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 08:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84F70167822
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 07:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F1C13C3D3;
	Sat,  1 Feb 2025 07:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J1BTri9r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A8224CC
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Feb 2025 07:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738393975; cv=none; b=Qz41RzpuX0YJqCsYwWQXKSrYyHkUecM99cIb81ceTVqSe1OcyXYmG0+opIce6a5Ko5OwqmkpBcQCx0Pt26YBebDWe0xBP5z7LUTUdYxL903v1QbqPy+i8RWQgh9V99JphentMIvnvuC0Xh32zmq66EfeDZ9sE8jVB5ohiH+hb8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738393975; c=relaxed/simple;
	bh=WKlQimKez6NMS+BUlbBWdv/ZZSPBF3L4H+l/B13+0MA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Disposition:MIME-Version; b=WyuE37sAkGlTuZix/qoFCzO8DCQVGif4hkd9rhz3gAKGwLwZdzeVtnH3T/lwkBWT5uf03ZzMsMEyo7w/yv64tsvEG1HCpBMMem739D+Xsl+YbFQI+Qv94zHbH3+88vW/dq2sLECbgajpRDry2ZC8zOTF/tETbr3FIBt5Wmly+0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J1BTri9r; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5115B3QK015367
	for <linux-fsdevel@vger.kernel.org>; Sat, 1 Feb 2025 07:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4BRccN
	/mzjAx/phfp0Rkw8pN1IvbKNND6rryLWpHh9M=; b=J1BTri9rhSKjZP0poz49Qq
	dQam6qy7AOlOTZYH0Gm6YVS8xYyfjvE65sAj5ySiCxA7+j7CTdYEWEuLmIaTkScO
	qGivHMaH5A1jfwbH6NThn+uceJtgPnDfn8WtMlnazBXXgsaMkBQAI3bY3GrW+Vws
	Y2QaqcH4UG66lypC6VhSm2s+pUZpZ6gbdcB7yG5weORBpqCqNO+J4rrpDrJs2jhl
	p09Mg20kfgbR5tu/rm8Zia2lPxSLejNjduSIk4qX3Rej2M54eAvKTOeQ1xrLiW7E
	jM1HpMMgzrG8sNj+fHPLbkqEAuYqOxT91/utTrR5FXLNLIRAvImowKzqR2ZxZjuA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44hd8708ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Sat, 01 Feb 2025 07:12:52 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5117CqXd029688
	for <linux-fsdevel@vger.kernel.org>; Sat, 1 Feb 2025 07:12:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44hd8708jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Feb 2025 07:12:51 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5117CpK7029678;
	Sat, 1 Feb 2025 07:12:51 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44hd8708jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Feb 2025 07:12:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5115Goi7029827;
	Sat, 1 Feb 2025 07:12:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44hdavrak1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Feb 2025 07:12:50 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5117CmwO38994214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Feb 2025 07:12:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DFE12008B;
	Sat,  1 Feb 2025 07:12:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 415E720089;
	Sat,  1 Feb 2025 07:12:40 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.216.81])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sat,  1 Feb 2025 07:12:39 +0000 (GMT)
Date: Sat, 1 Feb 2025 12:42:22 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com, jack@suse.cz, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] extsize and forcealign design in filesystems
 for atomic writes
Message-ID: <Z53JVhAzF9s1qJcr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <Z5nTaQgLGdD6hSvL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <35939b19-088b-450e-8fa6-49165b95b1d3@oracle.com>
 <Z5pRzML2jkjL01F5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e00bac5d-5b6c-4763-8a76-e128f34dee12@oracle.com>
In-Reply-To: <e00bac5d-5b6c-4763-8a76-e128f34dee12@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tzZ9oE-wNbklH9e_0j4L3mIrrEJmKXZY
X-Proofpoint-GUID: UIqt_CQPwRCOIXFJiaZ56XU5pcuy-vvy
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
 definitions=2025-02-01_02,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=2
 engine=8.19.0-2501170000 definitions=main-2502010059

On Thu, Jan 30, 2025 at 02:08:30PM +0000, John Garry wrote:
> On 29/01/2025 16:06, Ojaswin Mujoo wrote:
> > On Wed, Jan 29, 2025 at 08:59:15AM +0000, John Garry wrote:
> > > On 29/01/2025 07:06, Ojaswin Mujoo wrote:
> > >=20
> > > Hi Ojaswin,
> > >=20
> > > >=20
> > > > I would like to submit a proposal to discuss the design of extsize =
and
> > > > forcealign and various open questions around it.
> > > >=20
> > > >    ** Background **
> > > >=20
> > > > Modern NVMe/SCSI disks with atomic write capabilities can allow wri=
tes to a
> > > > multi-KB range on disk to go atomically. This feature has a wide va=
riety of use
> > > > cases especially for databases like mysql and postgres that can lev=
erage atomic
> > > > writes to gain significant performance. However, in order to enable=
 atomic
> > > > writes on Linux, the underlying disk may have some size and alignme=
nt
> > > > constraints that the upper layers like filesystems should follow. e=
xtsize with
> > > > forcealign is one of the ways filesystems can make sure the IO subm=
itted to the
> > > > disk adheres to the atomic writes constraints.
> > > >=20
> > > > extsize is a hint to the FS to allocate extents at a certian logica=
l alignment
> > > > and size. forcealign builds on this by forcing the allocator to enf=
orce the
> > > > alignment guarantees for physical blocks as well, which is essentia=
l for atomic
> > > > writes.
> > > >=20
> > > >    ** Points of discussion **
> > > >=20
> > > > Extsize hints feature is already supported by XFS [1] with forceali=
gn still
> > > > under development and discussion [2].
> > >=20
> > > From
> > > https://lore.kernel.org/linux-xfs/20241212013433.GC6678@frogsfrogsfro=
gs/=20
> > > thread, the alternate solution to forcealign for XFS is to use a
> > > software-emulated fallback for unaligned atomic writes. I am looking =
at a
> > > PoC implementation now. Note that this does rely on CoW.
> > >=20
> > > There has been push back on forcealign for XFS, so we need to prove/d=
isprove
> > > that this software-emulated fallback can work, see
> > > https://lore.kernel.org/linux-xfs/20240924061719.GA11211@lst.de/=20
> > >=20
> >=20
> > Hey John,
> >=20
> > Thanks for taking a look. I did go through the 2 series sometime back.
> > I agree that there are some open challenges in getting the multi block
> > atomic write interface correct especially for mixed mappings and this is
> > one of the main reasons we want to explore the exchange_range fallback
> > in case blocks are not aligned.
>=20
> Right, so for XFS I am looking at a CoW-based fallback for unaligned/mixed
> mapping atomic writes. I have no idea on how this could work for ext4.
>=20
> >=20
> > That being said, I believe forcealign as a feature still holds a lot
> > of relevance as:
> >=20
> > 1. Right now, it is the only way to guarantee aligned blocks and hence
> >     gurantee that our atomic writes can always benefit from hardware at=
omic
> >     write support. IIUC DBs are not very keen on losing out on performa=
nce
> >     due to some writes going via the software fallback path.
>=20
> Sure, we need performance figures for this first.
>=20
> >=20
> > 2. Not all FSes support COW (major example being ext4) and hence it will
> >     be very difficult to have a software fallback incase the blocks are
> > 	 not aligned.
>=20
> Understood
>=20
> >=20
> > 3. As pointed out in [1], even with exchange_range there is still value
> >     in having forcealign to find the new blocks to be exchanged.
>=20
> Yeah, again, we need performance figures.
>=20
> For my test case, I am trying 16K atomic writes with 4K FS block size, so=
 I
> expect the software fallback to not kick in often after running the system
> for a while (as eventually we will get an aligned allocations). I am
> concerned of prospect of heavily fragmented files, though.

Yes that's true, if the FS is up long enough there is bound to be
fragmentation eventually which might make it harder for extsize to
get the blocks.

With software fallback, there's again the point that many FSes will need
some sort of COW/exchange_range support before they can support anything
like that.=20

Although I;ve not looked at what it will take to add that to
ext4 but I'm assuming it will not be trivial at all.=20

>=20
> >=20
> > I agree that forcealign is not the only way we can have atomic writes
> > work but I do feel there is value in having forcealign for FSes and
> > hence we should have a discussion around it so we can get the interface
> > right.
> >=20
>=20
> I thought that the interface for forcealign according to the candidate xfs
> implementation was quite straightforward. no?

As mentioned in the original proposal, there are still a open problems
around extsize and forcealign.=20

- The allocation and deallocation semantics are not completely clear to
	me for example we allow operations like unaligned punch_hole but not
	unaligned insert and collapse range, and I couldn't see that
	documented anywhere.

- There are challenges in extsize with delayed allocation as well as how
	the tooling should handle forcealigned inodes.=20

- How are FSes supposed to behave when forcealign/extsize is used with
	other FS features that change the allocation granularity like bigalloc
	or rtvol.

I agree that XFS's implementation is a good reference but I'm
sure as I continue working on the same from ext4 perspective we will have=20
more points of discussion. So I definitely feel that its worth
discussing this at LSFMM.

>=20
> What was not clear was the age-old issue of how to issue an atomic write =
of
> mixed extents, which is really an atomic write issue.

Right, btw are you planning any talk for atomic writes at LSFMM?

Regards,
ojaswin

>=20
> > Just to be clear, the intention of this proposal is to mainly discuss
> > forcealign as a feature. I am hoping there would be another different
> > proposal to discuss atomic writes and the plethora of other open
> > challenges there ;)
>=20
> Thanks,
> John

