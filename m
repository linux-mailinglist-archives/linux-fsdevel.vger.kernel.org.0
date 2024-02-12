Return-Path: <linux-fsdevel+bounces-11109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4411E85129B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 12:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF9F3282DC4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 11:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5FB39FC9;
	Mon, 12 Feb 2024 11:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lbcYxzR0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F024739AFC;
	Mon, 12 Feb 2024 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707738526; cv=none; b=aKeHNZvSOtwWqN1g3Ro9Tae+CrHD3zzGLHkdQ0A/brghX06hoUE61xZpSgPknBuwW/0sl95Dw7hWw03RGC0vGHYMtRLHNd4f1Dn/6QC2PemB4UO+Q9W5Mz9fIu4h2fRgH6PyLHdTWBqYS11v6BZHa1BF6ertoi7BreyLMIDF6wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707738526; c=relaxed/simple;
	bh=SwJr96ZQNPn8iJpAOmRLCCSv8Y6xq7c0+DKT6vCESSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNcr5WgutJkYqeQKb9u692cd4NcqAJqz9pM22gN5S5JmMU/MYpCkfiq+NLZSpz4AB6LBL7BIvwUbk4ir6/m+j0J9kXbLuBpbpHSGHkh1XeBH/a7nZVOQupaL1+kT1fbiBxqKqkNLXY9N+EvHLCVHfUjkGLBa7mwe9zw+Nb4kA1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lbcYxzR0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41CBg5VG012956;
	Mon, 12 Feb 2024 11:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=qyjc0j0jXpc+L0msFwtcxdgLjULRRJxFM5z6Gd07mzc=;
 b=lbcYxzR0L95/JdQPxgzVM0orFamX5Lq9tPiGyj7WYs/JvNNVlfiREPODB6ruJFiJ5+FF
 h+3YyysPY/rYzzJzcS5JKrC+yjMEFglT0aKr7U7FbW+Jj3CaOwn3G1obkqKFxY+msqp/
 +BkUCD5nzySLptwe3ZkCMTUZ5LeDHS2gNY9SMaJOpYzaN8ufFxGCvr/5x3odJl4Ru2uE
 Kt5Zvh8+A5UoAUidX8D/Kssh3uc0LfkFaS7Y68pI5lbLqkuMmSPPLtadZaBq9zeT56UK
 IQGCuBD5jugLJG4wyVctA/dwg8wsqd9JyM8R19ojBAIwoIbvqzbDXyqf8D8EtJwKOeVz DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7jpjg678-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 11:48:27 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41CBhGAv017166;
	Mon, 12 Feb 2024 11:48:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w7jpjg66w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 11:48:26 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41CBPuRd009694;
	Mon, 12 Feb 2024 11:48:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6npkfyme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Feb 2024 11:48:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41CBmMaL21168770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Feb 2024 11:48:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01A0E20043;
	Mon, 12 Feb 2024 11:48:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F6BD20040;
	Mon, 12 Feb 2024 11:48:19 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Feb 2024 11:48:19 +0000 (GMT)
Date: Mon, 12 Feb 2024 17:18:17 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com
Subject: Re: [PATCH 4/6] fs: xfs: Support atomic write for statx
Message-ID: <ZcoFgbyr5HXc8vKn@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-5-john.g.garry@oracle.com>
 <ZcXNidyoaVJMFKYW@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <36437378-de35-48dc-8b1e-b5c1370e38b0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36437378-de35-48dc-8b1e-b5c1370e38b0@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NRKSTWEYCcEk4WOn0yqisVNvaiAIpFLC
X-Proofpoint-GUID: ljQZJMRmunj2FQs59o9g2B7pU8HTfELA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_08,2024-02-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402120089

On Fri, Feb 09, 2024 at 05:30:50PM +0000, John Garry wrote:
> 
> > > +void xfs_get_atomic_write_attr(
> > > +	struct xfs_inode *ip,
> > > +	unsigned int *unit_min,
> > > +	unsigned int *unit_max)
> > > +{
> > > +	xfs_extlen_t		extsz = xfs_get_extsz(ip);
> > > +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> > > +	struct block_device	*bdev = target->bt_bdev;
> > > +	unsigned int		awu_min, awu_max, align;
> > > +	struct request_queue	*q = bdev->bd_queue;
> > > +	struct xfs_mount	*mp = ip->i_mount;
> > > +
> > > +	/*
> > > +	 * Convert to multiples of the BLOCKSIZE (as we support a minimum
> > > +	 * atomic write unit of BLOCKSIZE).
> > > +	 */
> > > +	awu_min = queue_atomic_write_unit_min_bytes(q);
> > > +	awu_max = queue_atomic_write_unit_max_bytes(q);
> > > +
> > > +	awu_min &= ~mp->m_blockmask;
> > > +	awu_max &= ~mp->m_blockmask;
> > 
> > I don't understand why we try to round down the awu_max to blocks size
> > here and not just have an explicit check of (awu_max < blocksize).
> We have later check for !awu_max:
> 
> if (!awu_max || !xfs_inode_atomicwrites(ip) || !align ||
> ...
> 
> So what we are doing is ensuring that the awu_max which the device reports
> is at least FS block size. If it is not, then we cannot support atomic
> writes.
> 
> Indeed, my NVMe drive reports awu_max  = 4K. So for XFS configured for 64K
> block size, we will say that we don't support atomic writes.

> 
> > 
> > I think the issue with changing the awu_max is that we are using awu_max
> > to also indirectly reflect the alignment so as to ensure we don't cross
> > atomic boundaries set by the hw (eg we check uint_max % atomic alignment
> > == 0 in scsi). So once we change the awu_max, there's a chance that even
> > if an atomic write aligns to the new awu_max it still doesn't have the
> > right alignment and fails.
> 
> All these values should be powers-of-2, so rounding down should not affect
> whether we would not cross an atomic write boundary.


> 
> > 
> > It works right now since eveything is power of 2 but it should cause
> > issues incase we decide to remove that limitation.
> 
> Sure, but that is a fundamental principle of this atomic write support. Not
> having powers-of-2 requirement for atomic writes will affect many things.
> 

Correct, so the only reason for the rounding down is to ensure that
awu_max is not smaller than our block size but the way these checks are
right now doesn't make it obvious. It also raises questions like why we
are changing these min and max values especially why are we rounding
*down* min.

I think we should just have explicit (unit_[min/max] < bs) checks
without trying to round down the values.

> > Anyways, I think
> > this implicit behavior of things working since eveything is a power of 2
> > should atleast be documented in a comment, so these things are
> > immediately clear.
> > 
> > > +
> > > +	align = XFS_FSB_TO_B(mp, extsz);
> > > +
> > > +	if (!awu_max || !xfs_inode_atomicwrites(ip) || !align ||
> > > +	    !is_power_of_2(align)) {
> > 
> > Correct me if I'm wrong but here as well, the is_power_of_2(align) is
> > esentially checking if the align % uinit_max == 0 (or vice versa if
> > unit_max is greater)
> 
> yes
> 
> > so that an allocation of extsize will always align
> > nicely as needed by the device.
> > 
> 
> I'm trying to keep things simple now.
> 
> In theory we could allow, say, align == 12 FSB, and then could say awu_max =
> 4.
> 
> The same goes for atomic write boundary in NVMe. Currently we say that it
> needs to be a power-of-2. However, it really just needs to be a multiple of
> awu_max. So if some HW did report a !power-of-2 atomic write boundary, we
> could reduce awu_max reported until to fits the power-of-2 rule and also is
> cleanly divisible into atomic write boundary. But that is just not what HW
> will report (I expect). We live in a power-of-2 data granularity world.

True, we ideally won't expect the hw to report that but why not just
make the check as (awu_max % align) so that:

1. intention is immediately clear
2. It'll directly work for non power of 2 boundary in future without
change.

Just my 2 cents.
> 
> > So maybe we should use the % expression explicitly so that the intention
> > is immediately clear.
> 
> As mentioned, I wanted to keep it simple. In addition, it's a bit of a mess
> for the FS block allocator to work with odd sizes, like 12. And it does not
> suit RAID stripe alignment, which works in powers-of-2.
> 
> > 
> > > +		*unit_min = 0;
> > > +		*unit_max = 0;
> > > +	} else {
> > > +		if (awu_min)
> > > +			*unit_min = min(awu_min, align);
> > 
> > How will the min() here work? If awu_min is the minumum set by the
> > device, how can statx be allowed to advertise something smaller than
> > that?
> The idea is that is that if the awu_min reported by the device is less than
> the FS block size, then we report awu_min = FS block size. We already know
> that awu_max => FS block size, since we got this far, so saying that awu_min
> = FS block size is ok.
> 
> Otherwise it is the minimum of alignment and awu_min. I suppose that does
> not make much sense, and we should just always require awu_min = FS block
> size.

Yep, that also works. We should just set the minimum to FS block size,
since that min() operator there is confusing.

Regards,
ojaswin

