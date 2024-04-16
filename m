Return-Path: <linux-fsdevel+bounces-17026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A088A6668
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 10:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597DA1F21B60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5B384A36;
	Tue, 16 Apr 2024 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DXYk7BI/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C5629;
	Tue, 16 Apr 2024 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257287; cv=none; b=Hk4d5+io7inIDV3wDKQa1tfChK/cUZ4VlKPT/fIMRW5qlYLXM9m18WUnUtxArL5RP8FpoXXixgBEatvNXHpxZLm0icfzWqjMgH4Ks2Bj9wkWC6ptGGBgy6PU1z6UwHQvzqeCfU09fcvzv4sQUDav1ATAeUUZ0mt8bZ0YvvWAgA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257287; c=relaxed/simple;
	bh=09GQbPd6FpwheuuydH526rxab4hvYSZ+K6vL9my2HZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CklY6X2RHWZTTT+jqo4JegSTUL11HEMt37bahuGFDaCbYN1SOEUOSlOCnBvD5+ACA/GXqztZPWzGxsHb4VdWK2/dMsmdKlffeY1TN66Rxg+8gl1vdNB3MPgb17UoFYHqPQ/V+mS3+XU9gBRgBFpvt82+LUTOHqOmKAUSEjJnlfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DXYk7BI/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43G8hV5E013672;
	Tue, 16 Apr 2024 08:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=Ef7z3sb7mZtrkoLr/R6lVpfSEXk+mJy+j7bcakZo1p8=;
 b=DXYk7BI/zRIk1Jfijd2y94Cu3kvrzDzkpz9QXRUq6nGEMH8kdmfdPUlEshEuq3vvWDgA
 9Lnnj2BduJZ4i7IQ9Ofp4PkTAK/rl0qgqdvYeDmPl+lJuYVePda1qKVSNKhwDV1Kmno/
 2KHBQYQWO6IXYlTG0eYjvAQohgusaExNv6GyMFFHAM1LT7eQV1nVblc5ORN057GZaY7D
 Q46uuCDr5pjm0HmaShol37ZFMMzBoHGbH0uT32NwXWCvCw5X6LZyCPCXYE/zkK8Pq7/b
 zMoI+hX5AASKmD8ve9KbYSED5FBBajy8JCN/Ng/rRyPnbB8ZV5nMiGo25ufVkMjZkmSe 0A== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xhp2fg084-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 08:47:38 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43G6wlx9021351;
	Tue, 16 Apr 2024 08:47:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg6kkcqps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Apr 2024 08:47:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43G8lWWj50266448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 08:47:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 781582005A;
	Tue, 16 Apr 2024 08:47:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B7A62004B;
	Tue, 16 Apr 2024 08:47:31 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.55.218])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Apr 2024 08:47:31 +0000 (GMT)
Date: Tue, 16 Apr 2024 10:47:29 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Al Viro <viro@zeniv.linux.org.uk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, jack@suse.cz, hch@lst.de, brauner@kernel.org,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
        yukuai3@huawei.com, Yu Kuai <yukuai1@huaweicloud.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: Re: [PATCH vfs.all 15/26] s390/dasd: use bdev api in dasd_format()
Message-ID: <Zh47IY7M1LQXjckX@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-16-yukuai1@huaweicloud.com>
 <20240416013555.GZ2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416013555.GZ2118490@ZenIV>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F3z-IpdyO4uhJCE-QbbN3P9TL-ZqKfOK
X-Proofpoint-ORIG-GUID: F3z-IpdyO4uhJCE-QbbN3P9TL-ZqKfOK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-16_06,2024-04-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 impostorscore=0 clxscore=1011
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404160053

On Tue, Apr 16, 2024 at 02:35:55AM +0100, Al Viro wrote:
> >  drivers/s390/block/dasd_ioctl.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/s390/block/dasd_ioctl.c b/drivers/s390/block/dasd_ioctl.c
> > index 7e0ed7032f76..c1201590f343 100644
> > --- a/drivers/s390/block/dasd_ioctl.c
> > +++ b/drivers/s390/block/dasd_ioctl.c
> > @@ -215,8 +215,9 @@ dasd_format(struct dasd_block *block, struct format_data_t *fdata)
> >  	 * enabling the device later.
> >  	 */
> >  	if (fdata->start_unit == 0) {
> > -		block->gdp->part0->bd_inode->i_blkbits =
> > -			blksize_bits(fdata->blksize);
> > +		rc = set_blocksize(block->gdp->part0, fdata->blksize);
> 
> Could somebody (preferably s390 folks) explain what is going on in
> dasd_format()?  The change in this commit is *NOT* an equivalent
> transformation - mainline does not evict the page cache of device.
> 
> Is that
> 	* intentional behaviour in mainline version, possibly broken
> by this patch
> 	* a bug in mainline accidentally fixed by this patch
> 	* something else?
> 
> And shouldn't there be an exclusion between that and having a filesystem
> on a partition of that disk currently mounted?

CC-ing Stefan and Jan.

Thanks!

