Return-Path: <linux-fsdevel+bounces-49517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B49BABDD5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 16:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDEE73A37E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC07524503B;
	Tue, 20 May 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F1lZH4dV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60481DC99C;
	Tue, 20 May 2025 14:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751787; cv=none; b=sFETKVNu5THNAdTJeNqnDejCQqIpaR48wmLfv9XHqZSfZ3XDjOtwjxHxjWF8x9c2/dUaCzKChaP6gPFiluleNfXffTuA9APCWXAiUNUK9/q9A8bPtvS84fAKGFmbckn2kIOxaLGWAY3fs53HQs+OOZZiWGCeHZAO5+UcPi6Ln+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751787; c=relaxed/simple;
	bh=afUzUMRpxwKrDYURdqUuYAUCKecgYvYM+wO7AQGx+qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDAS00GzReNHFBFcXBVCVzgwZBUxc+Ok7Sa54V7Hscd3j0U1Y8udDp4KFJMOg5R5Rg3LR0TjT8cS3enTG8Fh87UXv/2n7kghlrTsVbb9GLDmN/IghkR86aJCRUGt5vG2uIM7/OtwtPJ6ej2wrJMWD1dpNrhiOFrQKlkJJ6Jopxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F1lZH4dV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54K9F1Lv007741;
	Tue, 20 May 2025 14:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=kH6es01bx+w0+FPZ8hgdCWnAlccrHs
	VSMBwhY7gPrF0=; b=F1lZH4dVjKqs+O93WsjAzXpPZALO/2UUWZR547tyFvhWhE
	mtxkpiQt4mdlzkBGUoOK7oJSa7lzKCsvBhkafFbX51QDNOvkm+5H1dmczzC1O1s3
	UWU8/YSKh/zYIsgdesM2UYI+GFSIVerJuhCR4r+FFNHsIbeoWhySk13rf8Ma5p7/
	q95XNl32WgqyYIi9iEgCJCpmmvhSOK45nyVDsk1abuhtzOHVAxJDXkRjibIeiH4e
	Ols0Vs/aZmaQ4EXR98G8qCD3BYixegOKg6RzC7iAjsS5X7QhPfwUbh/bPwyhtZEK
	FHKdNe6cSESfkKD1uuUCk05s5vnZTKbd0ovhnkVw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rpxksm32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 14:36:17 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54KEU5Qr013878;
	Tue, 20 May 2025 14:36:17 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46rpxksm2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 14:36:17 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54KDDi53013854;
	Tue, 20 May 2025 14:36:14 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q4stckb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 May 2025 14:36:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54KEaCnI27394476
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 May 2025 14:36:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 930CC20043;
	Tue, 20 May 2025 14:36:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B88F20040;
	Tue, 20 May 2025 14:36:11 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.103])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 20 May 2025 14:36:10 +0000 (GMT)
Date: Tue, 20 May 2025 20:06:08 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>, John Garry <john.g.garry@oracle.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 1/5] ext4: Unwritten to written conversion requires
 EXT4_EX_NOCACHE
Message-ID: <aCyTNqnZIB2me_MS@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1747677758.git.ritesh.list@gmail.com>
 <ea0ad9378ff6d31d73f4e53f87548e3a20817689.1747677758.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea0ad9378ff6d31d73f4e53f87548e3a20817689.1747677758.git.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EM8G00ZC c=1 sm=1 tr=0 ts=682c9361 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=g6sWhHbuWHJdhE_bHlMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: wQ0tZWcWuefdQCOl2R7neUYBFmG8bWPV
X-Proofpoint-ORIG-GUID: p2u3B3bijr3b9G7HActE5JXsTUodxHQZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDExOCBTYWx0ZWRfX2WH8V7OHK9cT BZeWf0zgJL17XxzA00z+eBv6fHT5bBWkGjSIkUI9mjPhW6ABykkE8E+TN62dFOtXZ5tXmwc3ho1 Ip3sA5GXKfqoWVbEy0GHAn62MLbSkEkp1guw/U6KH3p57ScF9/ToLTXCXIMyAuwAr9k7PZFAqbD
 7rR51L7MHp2WL2T44P8Z4QZGpA7CSXWEa4bhxsMAoc/iqhgG+RHQT91ty3cAYhkaAiHIEu/Quez 3KgqMx0iLRZrwSlYNuYVZ4+Xo0LwR9m3UkdlkrP4XJI7mWAUbm1LZaGE0aEN/xER/j5yrNrHA/L mhqRq9biBWUMzNOb1hnsdP9FycBwWuXQS9Yxuwr1fRLz66wUV+8iH/zWCLl2OhBcUVMewdZxDp5
 xQMx+OwTA5KWXSB2qWpUIpUcSpjij4uBgbL8gV4rmSAdccTt3c9vGt3STewRQtzIph+E47K3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=846 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505200118

On Mon, May 19, 2025 at 11:49:26PM +0530, Ritesh Harjani (IBM) wrote:
> This fixes the atomic write patch series after it was rebased on top of
> extent status cache cleanup series i.e.
> 
> 'commit 402e38e6b71f57 ("ext4: prevent stale extent cache entries caused by
> concurrent I/O writeback")'
> 
> After the above series, EXT4_GET_BLOCKS_IO_CONVERT_EXT flag which has
> EXT4_GET_BLOCKS_IO_SUBMIT flag set, requires that the io submit context
> of any kind should pass EXT4_EX_NOCACHE to avoid caching unncecessary
> extents in the extent status cache.
> 
> This patch fixes that by adding the EXT4_EX_NOCACHE flag in
> ext4_convert_unwritten_extents_atomic() for unwritten to written
> conversion calls to ext4_map_blocks().
> 
> Fixes: ba601987dbb4 ("ext4: Add multi-fsblock atomic write support with bigalloc")
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  fs/ext4/extents.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 8b834e13d306..7683558381dc 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4826,7 +4826,7 @@ int ext4_convert_unwritten_extents_atomic(handle_t *handle, struct inode *inode,
>  	struct ext4_map_blocks map;
>  	unsigned int blkbits = inode->i_blkbits;
>  	unsigned int credits = 0;
> -	int flags = EXT4_GET_BLOCKS_IO_CONVERT_EXT;
> +	int flags = EXT4_GET_BLOCKS_IO_CONVERT_EXT | EXT4_EX_NOCACHE;

Makes sense, feel free to add:

Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Thanks,
ojaswin

>  
>  	map.m_lblk = offset >> blkbits;
>  	max_blocks = EXT4_MAX_BLOCKS(len, offset, blkbits);
> -- 
> 2.49.0
> 

