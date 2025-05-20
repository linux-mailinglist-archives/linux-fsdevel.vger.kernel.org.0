Return-Path: <linux-fsdevel+bounces-49519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9852AABDD55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 16:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D35E57B257D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149D824889F;
	Tue, 20 May 2025 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GJzSCpS+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F0F2475C2;
	Tue, 20 May 2025 14:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751845; cv=none; b=hWUZk+goovPZKS16BdmRtefXpSnjVbWfpuMpfiQzl6ZCR2coC6m8AO6IdHPsQWmle/Y5d3yr1zp2kNzZudm+qt/z+YJd43kD8dub5osYq/1tgw74AjlDg4kIOlRFxLTt45WGgdcS1iXFsel8vyt+E9iW331Q17PEkHZzPlyCdNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751845; c=relaxed/simple;
	bh=SeO1SQT356P79X1UHFLDgcApZtDrdX55bbwCXBMj+H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuf0SbMRqEpgRS1Gn+BjXPsbvtuupcJr1SIeyIXIF138FgRHj08kLv6HMaPXIht3B4ie/P8zR5h2dim6bmDrcLjCbt41ECms1K1+c1v/jqxhFycbcEO371XKEUOkNt0zoDIQUb5M0BMSFLvt8orMAe2dcfL3+Pncx3ritb+2oHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GJzSCpS+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KEDFZa018723;
	Tue, 20 May 2025 14:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=FGuZ+wzIwXzXu3Ifbcg8naejq6v4uH
	vfuCLIegb2hys=; b=GJzSCpS+QeBYTqb5iSDc+tcV0lVcVLLlPGrO3wQt212JHR
	t6R1ZcIL/RORRh4y9lOyB8ZmCty5x9frjzdHOZQzvDmGP98ArvKxIVtgYTRG5AeM
	87FyQsxRZC/XPI2jaN1KPyE5oDn1k7XAyJexNR+ocEhuY63u+aeBpwdR8akDMyS7
	9+sg/AjFn/qzYOwt4lya8yj516nEsyXOJOicmWBKH6R/XrmfSe5UwuN32hApfGVr
	OOZZXLFzRy5hUJLJHDLYMZijag3sPqeiTWkfqtE3ARzdJHyZTT35DmrZWmOdAFVn
	FrLNc1fdcZIzZS52uREJ+kMisnKJV1LoBjwbH6FQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rmbstecr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 14:37:17 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54KETTTx011635;
	Tue, 20 May 2025 14:37:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rmbstecm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 14:37:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54KDptgM002433;
	Tue, 20 May 2025 14:37:15 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46q5snvche-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 14:37:15 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54KEbDAr19530040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 14:37:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D9AF20043;
	Tue, 20 May 2025 14:37:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A74B620040;
	Tue, 20 May 2025 14:37:11 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.103])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 May 2025 14:37:11 +0000 (GMT)
Date: Tue, 20 May 2025 20:07:09 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] ext4: Add a WARN_ON_ONCE for querying
 LAST_IN_LEAF instead
Message-ID: <aCyTla1NLJ4FGnLy@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1747677758.git.ritesh.list@gmail.com>
 <ee6e82a224c50b432df9ce1ce3333c50182d8473.1747677758.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee6e82a224c50b432df9ce1ce3333c50182d8473.1747677758.git.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDExOCBTYWx0ZWRfX43UeU3Hw/Mwz w+kNPfV1jdqA10mcsbn0CEVjTfnzrwSL7S2wi6zEwCY0n+rcLfOOroBKusxWMgkQn0doW7Nh6cG YQn0P/WqevmNhxqXOie1aKH68lX4/W3OBjJuniYE495+EPY5XQPOu6yuPLL+b9QLiQacLn1KNqR
 ZDsiwwAW5NejQNOWQ52U8CAy5x7kopLnBOowl8Vl3cwjTQ9GRNl8wxlWUjRtQZcrP7u2IGtDyPq 4cdrhRp4TUF+xmwtVb+NyCZC7WxqE2re4TiX6YFUuY7KRcw5vfzpKU72o3rjG/F5VpgqOdoH0jX csW2DttwAQjP3YsmX+PXxdDzDgR4WLvmKMjnYeFZdI9MpcJejJaCTozIp97jVOs5/9NbU6kMyS6
 sBOf5xgp0YQbdjXxePCLni77G3Y5FfFCHE7OzIudElTvNeFIUPLRE2HQ3CRDSypirJkFWUFo
X-Proofpoint-ORIG-GUID: -ALrb50t4iCryhxpVIsxp_oAm4HsoZMY
X-Proofpoint-GUID: TnbUzP9yA4Wv6zSLdrDlxvyVvf-PZUlA
X-Authority-Analysis: v=2.4 cv=DsxW+H/+ c=1 sm=1 tr=0 ts=682c939d cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=XA4xw6b2gnAKlWgFTusA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=836
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200118

On Mon, May 19, 2025 at 11:49:30PM +0530, Ritesh Harjani (IBM) wrote:
> We added the documentation in ext4_map_blocks() for usage of
> EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF flag. But It's better to add
> a WARN_ON_ONCE in case if anyone tries using this flag with CREATE to
> avoid a random issue later. Since depth can change with CREATE and it
> needs to be re-calculated before using it in there.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Makes sense, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> ---
>  fs/ext4/extents.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 7683558381dc..ea5158703d2d 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4444,9 +4444,11 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	 * need to re-calculate the depth as it might have changed due to block
>  	 * allocation.
>  	 */
> -	if (flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF)
> +	if (flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF) {
> +		WARN_ON_ONCE(flags & EXT4_GET_BLOCKS_CREATE);
>  		if (!err && ex && (ex == EXT_LAST_EXTENT(path[depth].p_hdr)))
>  			map->m_flags |= EXT4_MAP_QUERY_LAST_IN_LEAF;
> +	}
>  
>  	ext4_free_ext_path(path);
>  
> -- 
> 2.49.0
> 

