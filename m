Return-Path: <linux-fsdevel+bounces-49518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CD8ABDD63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 16:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C04B3A4EE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE0F1D90DF;
	Tue, 20 May 2025 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c5Jw3tcf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3762459FE;
	Tue, 20 May 2025 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751814; cv=none; b=OFOXEHjEMini+cYyhbFwWDKH1XzyHSL7la6fEcj6T7fuVNzubGJreLa2KhmDiPeO19dN1MBRApb79dY6s3WdbBsZDwawsUfLfWRoBohVmIg1HS7x6EF8KxQiF6oRn5yJQIOKwJ/JChylmZ1MuKEe1HCTdEkV21o0FMntZ7bn514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751814; c=relaxed/simple;
	bh=1WE4LshaOFQ/sN5WLnjiygCTXVPtbCtwIjBFTVdCebc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHDxWnAZuEc4kErkxTX4vFM1QCauNQIbwoPAkaGhiCIQjZ/nXGa/aTiILo8BZjPZ6ABJ1i/iVrKfh51j3q24GzpuRxgS+LQORCdWcp+aF30s61h5mBUDeB14UNB2OhAfoCZ7ZdSZj2SP0oMZYB+IpOiWf2YSibFCB+1ajq+rVK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c5Jw3tcf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K6IcSE017221;
	Tue, 20 May 2025 14:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ycGTivaHEyvym4t4Vb3cJQZEhtJDTN
	PQOlS8CDYiQnY=; b=c5Jw3tcfiOmyB/47CC5Pv6Xwo+7WH6lhEnXM9CE7ckQT/y
	p1X2qwCvc/px4hHh4YJ2O8paoHfobant3nG9JiE+5cektXXP5cA+WnTlF02ZWdLv
	up4OPJ6xaMRC0gyrtLddmYA3989N0qVNDupNA8X0CpuN/C3UfnYndWZeManGbcfi
	004xvVyoPvLAo+fzWIXUAFIj9vLaPoEwTCYUIB2QTPwZxUHpwUw1NiaTaqwe8L0T
	IeAGa1YZcrGNLUcP/Q6ZGX1ascXW6mFEZT+IB85z3pGMQlrLs0adfTsrm+Oun3zk
	A41DY2MtHLcinIe+NF8X4ApjCfEGWHXhDHkPQaJg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rmbstea2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 14:36:40 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54KEWG1N018021;
	Tue, 20 May 2025 14:36:40 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rmbste9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 14:36:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54KBf21F015851;
	Tue, 20 May 2025 14:36:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q7g2c33v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 14:36:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54KEabHq47120666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 14:36:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AEAF820040;
	Tue, 20 May 2025 14:36:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7808220043;
	Tue, 20 May 2025 14:36:34 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.103])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 May 2025 14:36:34 +0000 (GMT)
Date: Tue, 20 May 2025 20:06:30 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 2/5] ext4: Simplify last in leaf check in
 ext4_map_query_blocks
Message-ID: <aCyTbk-FYrkuBvxM@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1747677758.git.ritesh.list@gmail.com>
 <5fd5c806218c83f603c578c95997cf7f6da29d74.1747677758.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd5c806218c83f603c578c95997cf7f6da29d74.1747677758.git.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDExOCBTYWx0ZWRfXw4iVKXmZdkoF 4AIs05Wtz30zNr7DTmGYKod5BYLXfiqlkYSAN+KpTJO8IdAD+d5x9YAsb/B7SLC2uCVnKjk+a2m oqm/qbJOJ8D5XbqulhDsTxXpGfhDQMMr+rs4hXIzIgzsuXf87FWCa1DHY8EosqQNjLz7SztcXtm
 EshGHO9wldguvGw/WfIwsvmVo7kbcb43M2zq96serSi5RJvh48ep2lXT9vYSFlOkVYlurCDR90P 9EC11cyAgwDO2Q5xHyaxvJQVAF+vYFRgnD1BdDcdS10OoI+qB74FI0V4c8KuHdAiqEn9GgIHFyL lNa9qUZl214acKsqobVj24etKssDnSPhM3DwJQH1JmfnKMffWwprkCkTRl+d1jWzwugE6wFHhba
 SdBgf0mxUk8mxhuLSwt7sTpLaddTKDGFHX1+ed0j6qpu11XbvtLDNA2N/j2oBlqBnXZEV66T
X-Proofpoint-ORIG-GUID: 8nGhtnHCLOaOA7tyGkPFJFNxD0LSn9vE
X-Proofpoint-GUID: BNEBRGYHe-BlakhKgV5ZQeYn6ntjp_H3
X-Authority-Analysis: v=2.4 cv=DsxW+H/+ c=1 sm=1 tr=0 ts=682c9379 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8
 a=07Sk1U5I1JZMWGubBnQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200118

On Mon, May 19, 2025 at 11:49:27PM +0530, Ritesh Harjani (IBM) wrote:
> This simplifies the check for last in leaf in ext4_map_query_blocks()
> and fixes this cocci warning.
> 
> cocci warnings: (new ones prefixed by >>)
> >> fs/ext4/inode.c:573:49-51: WARNING !A || A && B is equivalent to !A || B
> 
> Fixes: 2e7bad830aa9 ("ext4: Add support for EXT4_GET_BLOCKS_QUERY_LEAF_BLOCKS")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505191524.auftmOwK-lkp@intel.com/
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Makes sense, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

> ---
>  fs/ext4/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index ce0632094c50..459ffc6af1d3 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -570,8 +570,7 @@ static int ext4_map_query_blocks(handle_t *handle, struct inode *inode,
>  	 * - if the last in leaf is the full requested range
>  	 */
>  	if (!(map->m_flags & EXT4_MAP_QUERY_LAST_IN_LEAF) ||
> -			((map->m_flags & EXT4_MAP_QUERY_LAST_IN_LEAF) &&
> -			 (map->m_len == orig_mlen))) {
> +			map->m_len == orig_mlen) {
>  		status = map->m_flags & EXT4_MAP_UNWRITTEN ?
>  				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
>  		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
> -- 
> 2.49.0
> 

