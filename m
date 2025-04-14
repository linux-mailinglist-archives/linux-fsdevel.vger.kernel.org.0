Return-Path: <linux-fsdevel+bounces-46343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59543A8784C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 08:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E10B188FF2E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 06:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9001B0430;
	Mon, 14 Apr 2025 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bMfB2aJv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A747B4C62;
	Mon, 14 Apr 2025 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613945; cv=none; b=Abr8aY5Gc10eGV6it3RBRn6Wnzl23XPytkcK/WioUxMS4CduFD6fqzv8K9b7/isu+4Kzkk0VJQWpSOegyR2BDBKTozEF6KNtDRDtl3B2iEGDr8ji1WkndknAI3mAe+v5pzuy6X9lMMpQRG50NHPNGWHWqq+Oq2B3+IJon8JXnKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613945; c=relaxed/simple;
	bh=zAg9XEChC6B9fho8dwV4MdAXEebNrhBMlWMgAyUvLnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TrmKcdm6n21VZZe2DjSVJRUH5FLhuzs/BCeap/Jhpk36mEa8xLvtDCdsmuXB3P/a+MBufORR+cOJk5jrAi1hxXkNjGMmXGd02IzkVDBpmoq6MPO5Muz5B2YvNTNEt8nqVImiFhCoLf2noC3ndl+Wpi2mwP+rIFiKeyyim3hKos8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bMfB2aJv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53DL3jDG009868;
	Mon, 14 Apr 2025 06:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=HyrW4vchpooSb+MA3dBWGyScHgemg2
	ZN5oWXwtwmcFA=; b=bMfB2aJvJ8dn5O+z6sucXQO5XQ0iMy7WCSSx4n06uO13Xg
	sPerZdHFSH3SV5cGxFbt4wDxvF7aYFrt0Hm1K42OaMLdyABjxrvD7zrKOWpKQWSe
	s9qGvso6g/hHUJKyRI0iwfMh1ULXWr3px2MKUT+SuJNS8ZRLb7P6fMAaCUPRp/p7
	4gUPmjdreOR5A3hzFgXO9TS+h5/6DQqW0sfZ+zQ+Tkl00tb1f4EFNKrSTlmgTiCc
	pCX5LYZQS2Y+NgXraT1qjaGc/5reoDZ3ocbvT7kT/p+S3oBnAPVscDqi4PCb/9d+
	Qa2shG9Ecr7uqBh+TdojHQC29A3UrthbMoGMngLQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460mufst8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 06:58:52 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53E6kxjj001579;
	Mon, 14 Apr 2025 06:58:52 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460mufst88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 06:58:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53E6Fwxr024892;
	Mon, 14 Apr 2025 06:58:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gt5ch9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 06:58:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53E6wnuJ19399040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 06:58:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 405FA2004B;
	Mon, 14 Apr 2025 06:58:49 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D710B20040;
	Mon, 14 Apr 2025 06:58:47 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.26.169])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 14 Apr 2025 06:58:47 +0000 (GMT)
Date: Mon, 14 Apr 2025 12:28:45 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iomap: trace: Add missing flags to
 [IOMAP_|IOMAP_F_]FLAGS_STRINGS
Message-ID: <Z_yyJfqzZfJCUxsX@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <8d8534a704c4f162f347a84830710db32a927b2e.1744432270.git.ritesh.list@gmail.com>
 <dcaff476004805544b6ad6d54d0c4adee1f7184f.1744432270.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcaff476004805544b6ad6d54d0c4adee1f7184f.1744432270.git.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RiR0JFJ7MlIuaa4XugqI4f5FPH49fj_e
X-Proofpoint-ORIG-GUID: E4mlop5F4pZdrMSB0jmLP3nPf3cRabcM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=518 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504140045

On Sat, Apr 12, 2025 at 10:06:35AM +0530, Ritesh Harjani (IBM) wrote:
> This adds missing iomap flags to IOMAP_FLAGS_STRINGS &
> IOMAP_F_FLAGS_STRINGS for tracing. While we are at it, let's also print
> values of iomap->type & iomap->flags.
> 
> e.g. trace for ATOMIC_BIO flag set
> xfs_io-1203    [000] .....   183.001559: iomap_iter_dstmap: dev 8:32 ino 0xc bdev 8:32 addr 0x84200000 offset 0x0 length 0x10000 type MAPPED (0x2) flags DIRTY|ATOMIC_BIO (0x102)
> 
> e.g. trace with DONTCACHE flag set
> xfs_io-1110    [007] .....   238.780532: iomap_iter: dev 8:16 ino 0x83 pos 0x1000 length 0x1000 status 0 flags WRITE|DONTCACHE (0x401) ops xfs_buffered_write_iomap_ops caller iomap_file_buffered_write+0xab/0x0
> 
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Hi Ritesh, the patch looks good. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
ojaswin

> ---
>  fs/iomap/trace.h | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
> index 9eab2c8ac3c5..455cc6f90be0 100644
> --- a/fs/iomap/trace.h
> +++ b/fs/iomap/trace.h
> @@ -99,7 +99,11 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
>  	{ IOMAP_FAULT,		"FAULT" }, \
>  	{ IOMAP_DIRECT,		"DIRECT" }, \
>  	{ IOMAP_NOWAIT,		"NOWAIT" }, \
> -	{ IOMAP_ATOMIC,		"ATOMIC" }
> +	{ IOMAP_OVERWRITE_ONLY,	"OVERWRITE_ONLY" }, \
> +	{ IOMAP_UNSHARE,	"UNSHARE" }, \
> +	{ IOMAP_DAX,		"DAX" }, \
> +	{ IOMAP_ATOMIC,		"ATOMIC" }, \
> +	{ IOMAP_DONTCACHE,	"DONTCACHE" }
> 
>  #define IOMAP_F_FLAGS_STRINGS \
>  	{ IOMAP_F_NEW,		"NEW" }, \
> @@ -107,7 +111,14 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
>  	{ IOMAP_F_SHARED,	"SHARED" }, \
>  	{ IOMAP_F_MERGED,	"MERGED" }, \
>  	{ IOMAP_F_BUFFER_HEAD,	"BH" }, \
> -	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }
> +	{ IOMAP_F_XATTR,	"XATTR" }, \
> +	{ IOMAP_F_BOUNDARY,	"BOUNDARY" }, \
> +	{ IOMAP_F_ANON_WRITE,	"ANON_WRITE" }, \
> +	{ IOMAP_F_ATOMIC_BIO,	"ATOMIC_BIO" }, \
> +	{ IOMAP_F_PRIVATE,	"PRIVATE" }, \
> +	{ IOMAP_F_SIZE_CHANGED,	"SIZE_CHANGED" }, \
> +	{ IOMAP_F_STALE,	"STALE" }
> +
> 
>  #define IOMAP_DIO_STRINGS \
>  	{IOMAP_DIO_FORCE_WAIT,	"DIO_FORCE_WAIT" }, \
> @@ -138,7 +149,7 @@ DECLARE_EVENT_CLASS(iomap_class,
>  		__entry->bdev = iomap->bdev ? iomap->bdev->bd_dev : 0;
>  	),
>  	TP_printk("dev %d:%d ino 0x%llx bdev %d:%d addr 0x%llx offset 0x%llx "
> -		  "length 0x%llx type %s flags %s",
> +		  "length 0x%llx type %s (0x%x) flags %s (0x%x)",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->ino,
>  		  MAJOR(__entry->bdev), MINOR(__entry->bdev),
> @@ -146,7 +157,9 @@ DECLARE_EVENT_CLASS(iomap_class,
>  		  __entry->offset,
>  		  __entry->length,
>  		  __print_symbolic(__entry->type, IOMAP_TYPE_STRINGS),
> -		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS))
> +		  __entry->type,
> +		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS),
> +		  __entry->flags)
>  )
> 
>  #define DEFINE_IOMAP_EVENT(name)		\
> @@ -185,7 +198,7 @@ TRACE_EVENT(iomap_writepage_map,
>  		__entry->bdev = iomap->bdev ? iomap->bdev->bd_dev : 0;
>  	),
>  	TP_printk("dev %d:%d ino 0x%llx bdev %d:%d pos 0x%llx dirty len 0x%llx "
> -		  "addr 0x%llx offset 0x%llx length 0x%llx type %s flags %s",
> +		  "addr 0x%llx offset 0x%llx length 0x%llx type %s (0x%x) flags %s (0x%x)",
>  		  MAJOR(__entry->dev), MINOR(__entry->dev),
>  		  __entry->ino,
>  		  MAJOR(__entry->bdev), MINOR(__entry->bdev),
> @@ -195,7 +208,9 @@ TRACE_EVENT(iomap_writepage_map,
>  		  __entry->offset,
>  		  __entry->length,
>  		  __print_symbolic(__entry->type, IOMAP_TYPE_STRINGS),
> -		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS))
> +		  __entry->type,
> +		  __print_flags(__entry->flags, "|", IOMAP_F_FLAGS_STRINGS),
> +		  __entry->flags)
>  );
> 
>  TRACE_EVENT(iomap_iter,
> --
> 2.48.1
> 

