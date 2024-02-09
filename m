Return-Path: <linux-fsdevel+bounces-10878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A458384F07D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 08:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94031C228E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 07:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47BF657BE;
	Fri,  9 Feb 2024 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E3VmzKT/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44893651B4;
	Fri,  9 Feb 2024 07:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707462087; cv=none; b=V++KNyoE2/sDxKwzM/Pe9uNWS3kNPgL/DKavNw0UExn/GhQ4/17ehY4pl5uX6MEnANPsYVbO/r2n20w3Q60ayrODmYV29W9YpCvoLALk2tW7vXnfpOGeeAmpvPAEs5aDH6MG/EROHq/XNobi0TOm72Eruz9794kT2XYFuf9vGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707462087; c=relaxed/simple;
	bh=FbvfLimCRTIizgrKaU2lF8zyXFZz6p1xNTqV1ED8pWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGgXLRCCeyp3Bglku9MB/iRyGPjEW1hXWZnGP3LPaBJyCoA1BCEKKqHUPtQxqKbZ1jnM00d0otsAEcLsVGBQjl9HadktAAM5+BGcQe2b0qur3b1kjwG/zMGGpjx/qfoTHnRTYYcBOeVEisqfcJv5JvET0Ios0KqgG7WEFttJ9lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E3VmzKT/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4196TnCX007002;
	Fri, 9 Feb 2024 07:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=SU+RhwOCJyXKUQy8eP7qCl/A4QdJg+opYZJ7tZXEN1I=;
 b=E3VmzKT/wdQxJHYFux42SZt3KUOjuOzpv2OWqdpyMb6FfU+tNPVF5m0msMviZsBNMDdR
 ql1BD2XaemQcBe1H8s8A2j2WJmRcm4O0ja5MS8rEfb6wILJkOVdlBZA3IYJJW6VphZ08
 KH8Qbn4Wvd3dOXYnJ7bEVZvSwzZKrKqlSCRG4+/hrCDbjibx91Wxu5oQIm72pxGEPrab
 LT+AkZuz7JF9Q5ZeMqyGxvPRDnJc36fQRJlfBfhZNkSf44OqT6Dk8s2FDTFMUgcvQ59X
 cQ2N05mPyt73a3dT1Y2ILC+hWKM4iaK7PfcrWAEqK4mvM+XQw9FLJvnjUhxFKbMgrWlG AA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5a6dxcd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 07:01:05 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4196rnw5026969;
	Fri, 9 Feb 2024 07:01:05 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w5a6dxcc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 07:01:05 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4194GSMg008539;
	Fri, 9 Feb 2024 07:01:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221kh8kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 07:01:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 419712a842074864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 07:01:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 431092004F;
	Fri,  9 Feb 2024 07:01:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AC8220040;
	Fri,  9 Feb 2024 07:00:59 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.98.150])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 Feb 2024 07:00:58 +0000 (GMT)
Date: Fri, 9 Feb 2024 12:30:56 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com,
        martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com
Subject: Re: [PATCH 4/6] fs: xfs: Support atomic write for statx
Message-ID: <ZcXNidyoaVJMFKYW@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20240124142645.9334-1-john.g.garry@oracle.com>
 <20240124142645.9334-5-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124142645.9334-5-john.g.garry@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Or_oZ37MC-AVzjU37NrZ8eyd8WXaqE_I
X-Proofpoint-ORIG-GUID: AgQW3RwfUqVAr-JFgQp5bQTIRPYOtQ_Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_04,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 impostorscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402090048

Hi John,

Thanks for the patch, I've added some review comments and questions
below.

On Wed, Jan 24, 2024 at 02:26:43PM +0000, John Garry wrote:
> Support providing info on atomic write unit min and max for an inode.
> 
> For simplicity, currently we limit the min at the FS block size, but a
> lower limit could be supported in future.
> 
> The atomic write unit min and max is limited by the guaranteed extent
> alignment for the inode.
> 
> Signed-off-by: John Garry <john.g.garry@oracle.com>
> ---
>  fs/xfs/xfs_iops.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/xfs/xfs_iops.h |  4 ++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index a0d77f5f512e..0890d2f70f4d 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -546,6 +546,44 @@ xfs_stat_blksize(
>  	return PAGE_SIZE;
>  }
>  
> +void xfs_get_atomic_write_attr(
> +	struct xfs_inode *ip,
> +	unsigned int *unit_min,
> +	unsigned int *unit_max)
> +{
> +	xfs_extlen_t		extsz = xfs_get_extsz(ip);
> +	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> +	struct block_device	*bdev = target->bt_bdev;
> +	unsigned int		awu_min, awu_max, align;
> +	struct request_queue	*q = bdev->bd_queue;
> +	struct xfs_mount	*mp = ip->i_mount;
> +
> +	/*
> +	 * Convert to multiples of the BLOCKSIZE (as we support a minimum
> +	 * atomic write unit of BLOCKSIZE).
> +	 */
> +	awu_min = queue_atomic_write_unit_min_bytes(q);
> +	awu_max = queue_atomic_write_unit_max_bytes(q);
> +
> +	awu_min &= ~mp->m_blockmask;
> +	awu_max &= ~mp->m_blockmask;

I don't understand why we try to round down the awu_max to blocks size
here and not just have an explicit check of (awu_max < blocksize).

I think the issue with changing the awu_max is that we are using awu_max
to also indirectly reflect the alignment so as to ensure we don't cross
atomic boundaries set by the hw (eg we check uint_max % atomic alignment
== 0 in scsi). So once we change the awu_max, there's a chance that even
if an atomic write aligns to the new awu_max it still doesn't have the
right alignment and fails. 

It works right now since eveything is power of 2 but it should cause
issues incase we decide to remove that limitation.  Anyways, I think
this implicit behavior of things working since eveything is a power of 2
should atleast be documented in a comment, so these things are
immediately clear. 

> +
> +	align = XFS_FSB_TO_B(mp, extsz);
> +
> +	if (!awu_max || !xfs_inode_atomicwrites(ip) || !align ||
> +	    !is_power_of_2(align)) {

Correct me if I'm wrong but here as well, the is_power_of_2(align) is
esentially checking if the align % uinit_max == 0 (or vice versa if
unit_max is greater) so that an allocation of extsize will always align
nicely as needed by the device. 

So maybe we should use the % expression explicitly so that the intention
is immediately clear.

> +		*unit_min = 0;
> +		*unit_max = 0;
> +	} else {
> +		if (awu_min)
> +			*unit_min = min(awu_min, align);

How will the min() here work? If awu_min is the minumum set by the
device, how can statx be allowed to advertise something smaller than
that?

If I understand correctly, right now the way we set awu_min in scsi and
nvme, the follwoing should usually be true for a sane device:

 awu_min <= blocks size of fs <= align

 so the min() anyways becomes redundant, but if we do assume that there
 might be some weird devices with awu_min absurdly large (SCSI with
 high atomic granularity) we still can't actually advertise a min
 smaller than that of the device, or am I missing something here?

> +		else
> +			*unit_min = mp->m_sb.sb_blocksize;
> +
> +		*unit_max = min(awu_max, align);
> +	}
> +}
> +

Regards,
ojaswin

