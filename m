Return-Path: <linux-fsdevel+bounces-48528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06D1AB09A7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 07:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E3D54E3B6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 05:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98FC267B8E;
	Fri,  9 May 2025 05:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gciK5zNG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A96267B12;
	Fri,  9 May 2025 05:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746768053; cv=none; b=Q+9dSVNWE7Uc2VhoV0inPKbiR+XaNU33AffHfuTaOfbnICBZvRYZQSusFUKdnr6PTMD/GaGMtcLJ4ek8QcIiUFUfmQPNm+Tz6t9oBxTJk6XmUB6m6DNamy0X/R/JT0cyemGJrwF3/FyoieScU+kYrn2hAaS4Tvnrb+qrzAML6qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746768053; c=relaxed/simple;
	bh=NIlkb1Q5N//UbsWwPAJTzDZkIKefsJsbkgKelbnL8FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcCDzoYOmjVjCSiRQz3bbWWtApk/FDGJjbl9JzglDWLC0HKSxlMsaRZPWF8ZzVjufFp+h7wEsBKMIuaFIbApjaAXYyKD+9MLg6p76Ki+gxI7VkgNL2Uxp0eczxRo8rUvzugICWf7LnS52tw5u7mSbh1/T120eW/rFwCcfn1RGYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gciK5zNG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5494BxpH029519;
	Fri, 9 May 2025 05:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rFRhew6w7YTtC+fcQ5kCsvJaIoDiAA
	MoKAvvIc2lhAs=; b=gciK5zNG7LGqMb5IpcpNGpoHuCi9vGnv6I+pWnRlGZx5Ui
	i2b2POHzGu/7KARUX6OeCIblNRie+pDLyuFIpTT8yH+ZJFZ7ryf21PjwD8A708/s
	shjQqLFxomZpZlvLxWTiUVwTQ/jfqCpBsV6j932tBKe3U9TUf91M0gL8wBK9eCCi
	yKF7867N2KYhS4fZOn3MxqqqLtLr3Gb/EFVsHaso07dV05IVPtaE7g7amrui8cZW
	9V9nQ8wONE0PlzdIReskT0LHTCGiMmFWBE6iQlRflaGGBpjGlMk2JlFDb0U3izp8
	j/w+KEJDc2ZqTKMXUUi4wcZygZA6/ti2VEffCozQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h6k0h830-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 05:20:39 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5495EXkY024999;
	Fri, 9 May 2025 05:20:38 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46h6k0h82x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 05:20:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5492TxBp014167;
	Fri, 9 May 2025 05:20:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypm1asd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 05:20:37 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5495KaMX51970548
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 05:20:36 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 349082004B;
	Fri,  9 May 2025 05:20:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 638BD20043;
	Fri,  9 May 2025 05:20:34 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.209.93])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  9 May 2025 05:20:34 +0000 (GMT)
Date: Fri, 9 May 2025 10:50:31 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] ext4: Check if inode uses extents in
 ext4_inode_can_atomic_write()
Message-ID: <aB2Qnw8nkpBcgE2q@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1746734745.git.ritesh.list@gmail.com>
 <f6592ee7a4fc862d19806e4ab9e4a4ea316c4f9b.1746734745.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6592ee7a4fc862d19806e4ab9e4a4ea316c4f9b.1746734745.git.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: H1L-oOrDC1xXrY6MROe0i8ONILZAa1Tm
X-Proofpoint-ORIG-GUID: iaNmOxuWn-2WYu8PTF7QUYMTn3Kg3ofs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA0NyBTYWx0ZWRfXyNGSzJq0WFH3 ZwmdPpfl5abyAnOlhoae15/NijXvX1KFun0Y4fg4GZmIaq87Ykr6gxuZ4bVmDTvY5Mt6ZqVCGv3 t8d0smtYqX/mNPjvoisa9oz8fR4B2xdIxiKfVuvxxvMHjqNKWFZ6lq19eHxt5Y7R2HNvhmQyenF
 ObVuRSE+8QCLkN2C1N8spWzmPFGJK2cAuFq3DtN9Kfh59u8ttqllvT66Y9kE4TxvXq+OGlvhcNg yXrmJVfj7w0XmuTf2x96SQhwvmnGE9M/rERsGirXbwfbkxvQzZkZG3WYdyd/ZgG/HDNm51q1ahb SiPOhay1MrCyw93pRTgPPUemlm7uoOJCLtyB+ZgpKSkLq2JYVFgSI11sm2k2RwfGULR3jO1j1TS
 bQsJ/reUtzXQjtLQKVh1wpZnoxGrvR+hUqz47FjT1ee7J17OJLvMJDj6tQ0XaKyOS3HklZ2C
X-Authority-Analysis: v=2.4 cv=OcCYDgTY c=1 sm=1 tr=0 ts=681d90a7 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=S4nAt5I17TqgIa1i4okA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_01,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=625 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090047

On Fri, May 09, 2025 at 02:20:32AM +0530, Ritesh Harjani (IBM) wrote:
> EXT4 only supports doing atomic write on inodes which uses extents, so
> add a check in ext4_inode_can_atomic_write() which gets called during
> open.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good Ritesh. Feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> ---
>  fs/ext4/ext4.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 5a20e9cd7184..c0240f6f6491 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -3847,7 +3847,9 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
>  static inline bool ext4_inode_can_atomic_write(struct inode *inode)
>  {
>  
> -	return S_ISREG(inode->i_mode) && EXT4_SB(inode->i_sb)->s_awu_min > 0;
> +	return S_ISREG(inode->i_mode) &&
> +		ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS) &&
> +		EXT4_SB(inode->i_sb)->s_awu_min > 0;
>  }
>  
>  extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
> -- 
> 2.49.0
> 

