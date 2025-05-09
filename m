Return-Path: <linux-fsdevel+bounces-48527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AA5AB09A4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 07:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5D64E43C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 05:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64030267B88;
	Fri,  9 May 2025 05:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K1kG6xm+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD16267B12;
	Fri,  9 May 2025 05:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746767963; cv=none; b=Bw1AGlex1b2wZSpJDLqb4l2OU2RtrifN614SetRY8VmUN5aIpuL4lcRQk2tuKuGDWkg9eA3CoDTLB/gX3HFCFWKhump5gsOmEI6haLXmodEHWIL1n/EdBnRjVoa/MNTSf5EJkpp+SlSJjm840/wRS/h29kMtoxuTd/yZal+Xfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746767963; c=relaxed/simple;
	bh=IeiU+TQV4Hm6y4sQytXE0Gys6GSd1+1sL/AECGG4WLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GPfh6WhJxU4xmD7+nwrd065usVnbm8eK5Bjm88yDh76ZHohgz43rDp1DteCY96l0X5E7fNc+/GsY61ow34sopU54V30G0GQ+H0WlujiacFKCNK8kGk5Kal0TVq1hmWqoDDkyeKLubWF8LXkDHJcEIruBAzQmzzRUrvMSWBBuBhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K1kG6xm+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494Bxpd029523;
	Fri, 9 May 2025 05:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=34PKnaJNfe/p7wWcGE1L+VvEkDaO3K
	n2XYIwl3Fb6zM=; b=K1kG6xm+lp8YNAPVQE9ImFx6uJjr67vtvoQy/cIpPLsbdJ
	4KU7zwKQ7g7ffdEvXVBVTz9tqukAjm6broxsGmZwth5sE+hfhj2rD2HWOQD2z15U
	053SylbWGYkVPF8AAG2IHZWUpbgaZBmJbGuXyQ2L5rT0Of3Ki6pVk/MXak3/yekp
	jR1EKgBuk2C/H6Emow/d0bXs1NHRTsa6v9RhDxo0rg+SwWO11ojG+1dyhCXnWPtE
	lAQa2RvqZASdw/E2P6YeaffNxhEXr4GEH4tVxZbOV3sdoEmQpJeNyCR4e8xyeAP1
	UnYWk/AEpk2sxoitvA19B9f67SBlXCPy/ONeYTdw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h6k0h7w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 05:19:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5495J9L6001750;
	Fri, 9 May 2025 05:19:09 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h6k0h7w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 05:19:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54940J3W001304;
	Fri, 9 May 2025 05:19:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwftsqw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 05:19:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5495J7G635193332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 05:19:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86D312004F;
	Fri,  9 May 2025 05:19:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF85920043;
	Fri,  9 May 2025 05:19:05 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.209.93])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 May 2025 05:19:05 +0000 (GMT)
Date: Fri, 9 May 2025 10:49:03 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/7] ext4: Document an edge case for overwrites
Message-ID: <aB2QRwxl-pj9cJ0G@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1746734745.git.ritesh.list@gmail.com>
 <9f95d7e26f3421c5aa0b835b5aa1dd4f702fc380.1746734745.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f95d7e26f3421c5aa0b835b5aa1dd4f702fc380.1746734745.git.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z5p2cUmOmVQLMba2UrxITFtV3REnFNwF
X-Proofpoint-ORIG-GUID: PIDgF4xcEA1g981BceF2bZ6MpLRWknNP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA0NyBTYWx0ZWRfX5CoTUXCCSbh8 EX6XHow0NOvW6mVx0Q2hDkfWMyZkf5MIp0wfPmK971yhlAwWaqvN9lXXnboncelTxrk7qlLHxUP 8ELo7ivCL1wkmt2vtKeoUczAQgJpcw3FmjPtgF6KOoMW5nkNcoz2fer8v7EsaHag/gTxXZt7iyH
 x2RH4FqXZ6TGzHvNNVAsOot0nNtqKCTjYhLqjzYrPi/x19DYNaZeAzrsmBP/8fK9qo6QbF6B2IJ ewb7G7oM1PREVHmsntwxV6kT+JM2deGnGDKl1H/wMA8Atl4pTNe+6aQiuALiZ/DM8fFDoNT/FxK 5c5wEQKmYp3LSeJSyPGNeXlWctKz0/+IFkatJtUhpbF52+T31EFGdzAWt8f8C14lP+PSCNfGSDQ
 JrRaCJar+yWoJcNO252aPQVLl4fZcYU6ED7K7yFpzuV0gSDundCGaEk7aAJz205b1Qpi0cPR
X-Authority-Analysis: v=2.4 cv=OcCYDgTY c=1 sm=1 tr=0 ts=681d904e cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=wd8qQTJu-rFUNS85vokA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_01,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=560 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090047

On Fri, May 09, 2025 at 02:20:31AM +0530, Ritesh Harjani (IBM) wrote:
> ext4_iomap_overwrite_begin() clears the flag for IOMAP_WRITE before
> calling ext4_iomap_begin(). Document this above ext4_map_blocks() call
> as it is easy to miss it when focusing on write paths alone.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
 
Looks good Ritesh. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 94c7d2d828a6..b10e5cd5bb5c 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3436,6 +3436,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>  		}
>  		ret = ext4_iomap_alloc(inode, &map, flags);
>  	} else {
> +		/*
> +		 * This can be called for overwrites path from
> +		 * ext4_iomap_overwrite_begin().
> +		 */
>  		ret = ext4_map_blocks(NULL, inode, &map, 0);
>  	}
>  
> -- 
> 2.49.0
> 

