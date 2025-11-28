Return-Path: <linux-fsdevel+bounces-70115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4C7C910A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 08:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5662435021A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 07:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9CD2DAFCC;
	Fri, 28 Nov 2025 07:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q7mkiZO7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E56022D795;
	Fri, 28 Nov 2025 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764314931; cv=none; b=ELLjP3TGoDDLb2vzkE6cZPqcRh2lQOwV0JgJ6K26MkM1SjQV9Cz6evOVOH2/uPjqmorkbJEBFbjRzdhgKKtQC52LpdRZrhCxIacy/5Sm2u8mskqWDB5Jeid9Rh+v/xRSn7uka0qNuiA1vC4BOa0QCg5yB8FxEyHYpi41E0DX98M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764314931; c=relaxed/simple;
	bh=4jfAAGJcrpgRJSrtCrR2zisKyaOceP6JOH3iOoR0ItI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoHyqrwEd/iKdYJsuzO1qeX3ubmCv2GVZYuik0JUVrGLgESYFS5Br2HrVAGXFFszTrg35E8mV4Qfryzgsy7IVV7Uk8cj94J26p/vwDGk6P1f+xXz6h3OvMPyXIYTkSMbSc9y2Qx7qW952vD5/1ZfrsvT2zSl1Gz7xhjrBdYti64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q7mkiZO7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ARFbQwv012141;
	Fri, 28 Nov 2025 07:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Ux3gG1DVlD53Q8Rvde5FAkrFApVFDM
	bNXKqQnfaVmM4=; b=q7mkiZO7eWYqglJ0Zws16u/uuif++6+YfEu2UCSzfOzHd5
	R/78JSh3vM1jAuV/M5ulZqNO9G1cseEqQUuTxjWHnbtpgCHgJCyxX6zPRonC4GEx
	g+DBckz9q9vxujjzfy+yQw4HJ6jcSa9/kSdl6HPNlYohi2ql8smbeN8p4VV1VnzW
	CGO8ni0KPox5FlbD8VpcgU5YQRAFYp8FiINomlc8ZI4JBwj0Pc6FQlkaBkn+vwxb
	mtLlrNM/lJ7l9QWdLX+VwDqd6vF32TISF9h/I8YbGfr7HDQEQrPd5x3X43a41Txi
	GtbkRtFU8JnnCzC7/x1FaKEAqI0Y5OZPhs8OXQ4w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kkbhxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 07:28:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AS7P8qS022101;
	Fri, 28 Nov 2025 07:28:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kkbhxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 07:28:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AS30Ke2027384;
	Fri, 28 Nov 2025 07:28:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4anq4hcp66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Nov 2025 07:28:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AS7SSFZ42205638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 07:28:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DAA720040;
	Fri, 28 Nov 2025 07:28:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BA8F2004B;
	Fri, 28 Nov 2025 07:28:25 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.26.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 28 Nov 2025 07:28:25 +0000 (GMT)
Date: Fri, 28 Nov 2025 12:58:22 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Jan Kara <jack@suse.cz>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, yi.zhang@huawei.com,
        yizhang089@gmail.com, libaokun1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 03/13] ext4: don't zero the entire extent if
 EXT4_EXT_DATA_PARTIAL_VALID1
Message-ID: <aSlPFohdm8IfB7r7@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <20251121060811.1685783-1-yi.zhang@huaweicloud.com>
 <20251121060811.1685783-4-yi.zhang@huaweicloud.com>
 <yro4hwpttmy6e2zspvwjfdbpej6qvhlqjvlr5kp3nwffqgcnfd@z6qual55zhfq>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yro4hwpttmy6e2zspvwjfdbpej6qvhlqjvlr5kp3nwffqgcnfd@z6qual55zhfq>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dUpxPsnasC82ouoXAxVgZe3wWr5qfLKh
X-Authority-Analysis: v=2.4 cv=frbRpV4f c=1 sm=1 tr=0 ts=69294f1f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=iox4zFpeAAAA:8 a=k4RGnHD_Gnpfp-dnHJ8A:9 a=CjuIK1q_8ugA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-ORIG-GUID: iUUpjNwcDRz5Lof0PT-5SX5OjEutDOzo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwOCBTYWx0ZWRfX9I49XYhZRlU2
 6pe7gt9gxdUZiVX3rk+B0cPO28hx9mhoGOX1wShLABfs8xC70/sfb92P02k+UVB2ZTbssD0MBXq
 J1b1sXJbUJvEDZKmRkpkGerIqvxl6VbvlVVJJilIpVbhYnLV0/n6vzq5A2javsdnHxVXXxE2EP8
 MtB4tSny91U4qCaaVL9kV4NncmwRFsbe/PS84aEFV123AD7eXfd/Ww+ck8RBJiNxU2HDlKjdWZp
 ifDQ6If9owWUIjLkScNE4SHfv3pdhoNyIrEFUbbi71U/fMhYYBK8DwMaVlW1pZxKPfygf14G0HZ
 V8F4Ss5OLKSa/JojJu/fRlBcb/4FERQOz3u7lmnnimz9qvIRE1dGC/PCL/JvNBUjJdgnxJQSsX6
 e/rLS0bqUFy0t1D4euUpy6ErF7md+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220008

On Thu, Nov 27, 2025 at 02:41:52PM +0100, Jan Kara wrote:
> On Fri 21-11-25 14:08:01, Zhang Yi wrote:
> > From: Zhang Yi <yi.zhang@huawei.com>
> > 
> > When allocating initialized blocks from a large unwritten extent, or
> > when splitting an unwritten extent during end I/O and converting it to
> > initialized, there is currently a potential issue of stale data if the
> > extent needs to be split in the middle.
> > 
> >        0  A      B  N
> >        [UUUUUUUUUUUU]    U: unwritten extent
> >        [--DDDDDDDD--]    D: valid data
> >           |<-  ->| ----> this range needs to be initialized
> > 
> > ext4_split_extent() first try to split this extent at B with
> > EXT4_EXT_DATA_ENTIRE_VALID1 and EXT4_EXT_MAY_ZEROOUT flag set, but
> > ext4_split_extent_at() failed to split this extent due to temporary lack
> > of space. It zeroout B to N and mark the entire extent from 0 to N
> > as written.
> > 
> >        0  A      B  N
> >        [WWWWWWWWWWWW]    W: written extent
> >        [SSDDDDDDDDZZ]    Z: zeroed, S: stale data
> > 
> > ext4_split_extent() then try to split this extent at A with
> > EXT4_EXT_DATA_VALID2 flag set. This time, it split successfully and left
> > a stale written extent from 0 to A.
> > 
> >        0  A      B   N
> >        [WW|WWWWWWWWWW]
> >        [SS|DDDDDDDDZZ]
> > 
> > Fix this by pass EXT4_EXT_DATA_PARTIAL_VALID1 to ext4_split_extent_at()
> > when splitting at B, don't convert the entire extent to written and left
> > it as unwritten after zeroing out B to N. The remaining work is just
> > like the standard two-part split. ext4_split_extent() will pass the
> > EXT4_EXT_DATA_VALID2 flag when it calls ext4_split_extent_at() for the
> > second time, allowing it to properly handle the split. If the split is
> > successful, it will keep extent from 0 to A as unwritten.
> > 
> > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> 
> Good catch on the data exposure issue! First I'd like to discuss whether
> there isn't a way to fix these problems in a way that doesn't make the
> already complex code even more complex. My observation is that
> EXT4_EXT_MAY_ZEROOUT is only set in ext4_ext_convert_to_initialized() and
> in ext4_split_convert_extents() which both call ext4_split_extent(). The
> actual extent zeroing happens in ext4_split_extent_at() and in
> ext4_ext_convert_to_initialized(). I think the code would be much clearer
> if we just centralized all the zeroing in ext4_split_extent(). At that
> place the situation is actually pretty simple:

This is exactly what I was playing with in my local tree to refactor this
particular part of code :). I agree that ext4_split_extent() is a much
better place to do the zeroout and it looks much cleaner but I agree
with Yi that it might be better to do it after fixing the stale
exposures so backports are straight forward. 

Am I correct in understanding that you are suggesting to zeroout
proactively if we are below max_zeroout before even trying to extent
split (which seems be done in ext4_ext_convert_to_initialized() as well)?

In this case, I have 2 concerns:

> 
> 1) 'ex' is unwritten, 'map' describes part with already written data which
> we want to convert to initialized (generally IO completion situation) => we
> can zero out boundaries if they are smaller than max_zeroout or if extent
> split fails.

Firstly, I know you mentioned in another email that zeroout of small ranges
gives us a performance win but is it really faster on average than
extent manipulation?

For example, for case 1 where both zeroout and splitting need
journalling, I understand that splitting has high journal overhead in worst case,
where tree might grow, but more often than not we would be manipulating
within the same leaf so journalling only 1 bh (same as zeroout). In which case
seems like zeroout might be slower no matter how fast the IO can be
done. So proactive zeroout might be for beneficial for case 3 than case
1.

> 
> 2) 'ex' is unwritten, 'map' describes part we are preparing for write (IO
> submission) => the split is opportunistic here, if we cannot split due to
> ENOSPC, just go on and deal with it at IO completion time. No zeroing
> needed.
> 
> 3) 'ex' is written, 'map' describes part that should be converted to
> unwritten => we can zero out the 'map' part if smaller than max_zeroout or
> if extent split fails.

Proactive zeroout before trying split does seem benficial to help us
avoid journal overhead for split. However, judging from
ext4_ext_convert_to_initialized(), max zeroout comes from
sbi->s_extent_max_zeroout_kb which is hardcoded to 32 irrespective of
the IO device, so that means theres a chance a zeroout might be pretty
slow if say we are doing it on a device than doesn't support accelerated
zeroout operations. Maybe we need to be more intelligent in setting
s_extent_max_zeroout_kb?

> 
> This should all result in a relatively straightforward code where we can
> distinguish the three cases based on 'ex' and passed flags, we should be
> able to drop the 'EXT4_EXT_DATA_VALID*' flags and logic (possibly we could
> drop the 'split_flag' argument of ext4_split_extent() altogether), and fix
> the data exposure issues at the same time. What do you think? Am I missing
> some case?
> 
> 								Honza
> 
> > ---
> >  fs/ext4/extents.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index f7aa497e5d6c..cafe66cb562f 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -3294,6 +3294,13 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
> >  		err = ext4_ext_zeroout(inode, &zero_ex);
> >  		if (err)
> >  			goto fix_extent_len;
> > +		/*
> > +		 * The first half contains partially valid data, the splitting
> > +		 * of this extent has not been completed, fix extent length
> > +		 * and ext4_split_extent() split will the first half again.
> > +		 */
> > +		if (split_flag & EXT4_EXT_DATA_PARTIAL_VALID1)
> > +			goto fix_extent_len;
> >  
> >  		/* update the extent length and mark as initialized */
> >  		ex->ee_len = cpu_to_le16(ee_len);
> > @@ -3364,7 +3371,9 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
> >  			split_flag1 |= EXT4_EXT_MARK_UNWRIT1 |
> >  				       EXT4_EXT_MARK_UNWRIT2;
> >  		if (split_flag & EXT4_EXT_DATA_VALID2)
> > -			split_flag1 |= EXT4_EXT_DATA_ENTIRE_VALID1;
> > +			split_flag1 |= map->m_lblk > ee_block ?
> > +				       EXT4_EXT_DATA_PARTIAL_VALID1 :
> > +				       EXT4_EXT_DATA_ENTIRE_VALID1;
> >  		path = ext4_split_extent_at(handle, inode, path,
> >  				map->m_lblk + map->m_len, split_flag1, flags1);
> >  		if (IS_ERR(path))
> > -- 
> > 2.46.1
> > 
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

