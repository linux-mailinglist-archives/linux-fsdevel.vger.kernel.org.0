Return-Path: <linux-fsdevel+bounces-20214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F41DA8CFC55
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 11:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6093FB207D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 09:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF205139D19;
	Mon, 27 May 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fHwgV9di"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09DA6A8A3
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716800396; cv=none; b=Wpu5vO3zeHT6iYZ2ReWtIahkhZa28AaQUNigd2/3jTpEKGE4vpmnveapPcAc8lqVul9CBMXEplAbbwx+U7Hg+5PxODPli8Ak74pPtRTzhg15TWCfxSOBcQ/Yx1T8h2/9UswXB5PlgXRfKh58PBdE/Zr6akZmQhT3A1dQG0nqccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716800396; c=relaxed/simple;
	bh=8/wfd20QEm2KLvHAdA7Pa90xMSDfPYbqPMRi1cwgZ4k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=cOker9Uv+bmdHvKrnwwCvtxOOUZfSWz7iJ8efTR39M0IXjACH4gXpdMkWlO2B4GlOFULhz80GFhLtsjkg354+2KYmIXqWvBj92Op4G3/PDmwc+jc84G3kD/WXxLPmsYXM3nu8Rw5rZCofEei6vHhDlIlWBOALMB+K3LPs2B+fPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fHwgV9di; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240527085952epoutp0248d4555547b95e5cda739e44f724978f~TTNxLoDmA2400724007epoutp02d
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 08:59:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240527085952epoutp0248d4555547b95e5cda739e44f724978f~TTNxLoDmA2400724007epoutp02d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716800392;
	bh=CQEl5Odrn2gxp6sQ0rwKylnsdnwf7SZr6c5IE4f2Nnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fHwgV9dicOrvtK0z8lmz68358uiMntn47nnmXsHF1ZQTEmbfH0FzFwD53GAQMBi2R
	 Eu4oBOqzSmsscZA6OF/9iDm7p1QakySlP1XhEB4f+1cLbe4PYmZBWdrrp5xwyKNGB8
	 oxGFiy0QNEq2uwzy1rNKgS36ypTUhbBO7553kvP8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240527085951epcas5p49def0d875e71e6e2715f7a999b37eaf1~TTNwdHmqw1010910109epcas5p4v;
	Mon, 27 May 2024 08:59:51 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VnqN46xXZz4x9Q5; Mon, 27 May
	2024 08:59:48 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5C.51.10035.48B44566; Mon, 27 May 2024 17:59:48 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240527085054epcas5p2be182df41a889b664ebc3edab8daf981~TTF84VBY20347303473epcas5p2Y;
	Mon, 27 May 2024 08:50:54 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240527085054epsmtrp2f1618382f9787da1f2681bcab59eaba5~TTF83Cwh92271122711epsmtrp2r;
	Mon, 27 May 2024 08:50:54 +0000 (GMT)
X-AuditID: b6c32a4b-8afff70000002733-3e-66544b84bb3f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	76.7A.08336.E6944566; Mon, 27 May 2024 17:50:54 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240527085050epsmtip1de5e35f4122e1db93f8daa490f6e562d~TTF5UwrDI2589625896epsmtip1Y;
	Mon, 27 May 2024 08:50:50 +0000 (GMT)
Date: Mon, 27 May 2024 08:43:51 +0000
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, hare@suse.de,
	damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
	nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 06/12] fs, block: copy_file_range for def_blk_ops
 for direct block device
Message-ID: <20240527084351.g2m7jt4xirj4elle@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZlJvp47RSFKkbwRJ@dread.disaster.area>
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUZRjG+c7ZPRxsVo8LDB9sGG7UJAYucvGDQGog5jAwCqZNWok77OES
	sLvtLglMk1wkLnKXsl1AV0DlkmCAtCA4gnItI7kZNEARIIIBcbHMQdr1QON/v3ne55nv/d53
	XhLnXzK2IiOkKkYhFUcJiS2chtu77OxP+x8OFRUk70M1PR04Sspdw1HVaA6B5m4vAfT14hMc
	Td5KBejp3V4c1XeMAaQtKeag4VuNGGouycdQRVU7hgrPJWOoff1PAuW3DQE0NajBUMvIbnTx
	yzIOam7p5qD+piICXbg8ZYyudD7DUF7aIIZ0k4kAVc8tcFDXiAD1rnVy3xbQ/QP+dE8JpBs1
	o8Z079h3HLr/bgxdW5lO0HVlp+iZOjWgbwwnEHRp9lkunZU8T9CNKeNc+q+pEQ69cHOQoLPr
	KwH9o/aOcaDpsUiPcEYsYRQ2jDREJomQhnkK/d8L9g52cRU52ju6oX1CG6k4mvEU+gQE2vtG
	ROmHI7T5TBwVo5cCxUqlcM9+D4UsRsXYhMuUKk8hI5dEyZ3lDkpxtDJGGuYgZVTujiLRXhe9
	8URkeM31Kq5cZxHb+c91PAEUmmYAExJSzvAXdRM3A2wh+dQNACsSHgJDgU8tAfgoOZAtPAYw
	5XIqsZmo7q/jsqYWAL9plbGmZQAfl01hhgKHeg1mas/pmSQJajf8YZ00yGbU6zA/X4cb/Dil
	JWBGYvVzjykVAtvLaYOHR3nD7K4GwPJ22K2e5BjYhHKCpcm5wJCFVJ8JTL3fw2Eb8oFnxqsB
	y6ZwtrPemGUruDzfstH0SVhRUE6w4dMAau5rNgJeMKUnBzcwToXBR2lDGwFr+FVPNcbqW2HW
	00mM1XlQd36TX4Xf1mg3/JZw6O/EDabh6PcDGDuVaQAT2tRYLtiheeFHmhfeY9kdpi8mcTX6
	YeCUAF55RrK4C9Y07dECbiWwZOTK6DBG6SJ3kjIn/19yiCy6Fjy/Fzt/HZj4bdGhDWAkaAOQ
	xIVmPLPzQaF8nkQcF88oZMGKmChG2QZc9AvKw63MQ2T6g5Oqgh2d3UTOrq6uzm5Oro5CC95c
	SrGET4WJVUwkw8gZxWYOI02sEjB+yuHOgWNVbboHM5+fMH+IgbTZDx84TYp0Ywffumn/aW3N
	78E5sVc/1tzJKtq6t+iAbXEhXz0w0WwWNBOUUxxZ/G6/d3L8R0WrK4Ly5b6A6SS/l4+o+xIP
	/HyqOcOcxI86vHL8X120Z1zfvfT9C62zw5UXhB2VOxuHtzX5WBT/mvmFR4Qk4U1S9NPSarWo
	yEt1RHpUMOfncJaKXZ3xu+frNb0jzT3n2h/WL6FL7xyvaYLdefXb1/2truK+w6XzsfEtKx2t
	JYOZh1xCr31i1MAvfb9gm5FJaP4h0cLgG0YyS+9xnm3X0NpFi+a4CfP4Nb/ekABh4brg4AfU
	E1sCn7c+Y7YSgAs5ynCxox2uUIr/A35YaGK4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUxTWRiGPfdcbi91mlxK1YMkmDQqqUSgavDEZRxHjRdX3GJiTLTSC5Sl
	YgsuEw3VBtRKESvStCxWICAlKSqKIIhaUMCtUUQjKuhMsRVUpNEERltmCpmM/568y/f++Wgo
	dJHTaYUyg1MpZaliik/Wt4rD5ipjtyZEl3yU4Nr79yA+lu+FuObNaQoPtnoALvwyCrHz9nGA
	vz9yQHz1Xi/AlrISEr+83Ujg5jIDgatr7hK4yKgl8N2xTxQ22J8D3N9tJvDNngh8IaeCxM03
	O0ncdaOYwucr+3m4qt1H4DMnugnc4DwKsG1wiMQdPaHY4W0P+C2U7Xq2lr1fhthG8xse6+i9
	TLJdjzLZK9aTFFtXkcW660yAbXqpodjyvLMBrF77mWIbs/sC2OH+HpIdaumm2LyrVsA+tLTx
	4oJ38JfIuVTFfk4V9etuftIr7ykq/ZPoYIHzGakBA4wOBNKIWYBsXXUBfhYyTQBVFs2f0ENQ
	pbcNTnAwqva5eDrA/zczDNDbD27Kb5DMLJRrMRI6QNMUE4EejNF+WcTMRgZDA/TnIVNBIdPT
	p+MDwUw8cpQ2j7OAWYHyOurBxNH3AA1/OAUnjCDUaXKSfoZMDCqtewf9A5AJRVW+8YFAZj4q
	1+aDfMCYf2qYf2qY/29YALSCEC5dnZaYppamS5XcgUi1LE2dqUyMjN+bdgWM/8IcSQO4bv0S
	aQcEDewA0VAsEohKNyUIBXLZoT841d5dqsxUTm0HoTQpniaY5tbLhUyiLINL4bh0TvWfS9CB
	0zWEWff7LX7uL0vjcrbq14zETPb92WIf2bcnKzdjp9zwl3xl9FtHgTwOFhlvKFvK3UnLIprC
	s+0DhxPdq9fqNUSMWWHaFFsuTJDWO/NsYSmrZvTauhUxk9xjnTrPuSqBxGV6vvni8r6D9Hub
	Y7Qvs16YvD1upOzO8jXWktdwYbRYmVwce0xSLXOBx4Pi05xz3xHj/pTCrKh5DZ2+DTntvIjC
	8F3O9TPbNj9ZUhsfFC7t3/Z3z+qvCcrW4tHab68vefTGi71g6m6jVq2dvGWWSINfhDwcenWh
	apsl27u44/LxsYp1i5I9Uao9nzMOv9gSpJpd8+OaIkwy4Dnyndo45asrSEyqk2TSOVCllv0D
	5ojMDHoDAAA=
X-CMS-MailID: 20240527085054epcas5p2be182df41a889b664ebc3edab8daf981
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----u98hW3AvpxW_WMqzG8XaJinKydZ84Ygy6oP0sovTVoTPagnQ=_6c01_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102929epcas5p2f4456f6fa0005d90769615eb2c2bf273
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102929epcas5p2f4456f6fa0005d90769615eb2c2bf273@epcas5p2.samsung.com>
	<20240520102033.9361-7-nj.shetty@samsung.com>
	<ZlJvp47RSFKkbwRJ@dread.disaster.area>

------u98hW3AvpxW_WMqzG8XaJinKydZ84Ygy6oP0sovTVoTPagnQ=_6c01_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 26/05/24 09:09AM, Dave Chinner wrote:
>On Mon, May 20, 2024 at 03:50:19PM +0530, Nitesh Shetty wrote:
>> For direct block device opened with O_DIRECT, use blkdev_copy_offload to
>> issue device copy offload, or use splice_copy_file_range in case
>> device copy offload capability is absent or the device files are not open
>> with O_DIRECT.
>>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> ---
>>  block/fops.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/block/fops.c b/block/fops.c
>> index 376265935714..5a4bba4f43aa 100644
>> --- a/block/fops.c
>> +++ b/block/fops.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/fs.h>
>>  #include <linux/iomap.h>
>>  #include <linux/module.h>
>> +#include <linux/splice.h>
>>  #include "blk.h"
>>
>>  static inline struct inode *bdev_file_inode(struct file *file)
>> @@ -754,6 +755,30 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
>>  	return ret;
>>  }
>>
>> +static ssize_t blkdev_copy_file_range(struct file *file_in, loff_t pos_in,
>> +				      struct file *file_out, loff_t pos_out,
>> +				      size_t len, unsigned int flags)
>> +{
>> +	struct block_device *in_bdev = I_BDEV(bdev_file_inode(file_in));
>> +	struct block_device *out_bdev = I_BDEV(bdev_file_inode(file_out));
>> +	ssize_t copied = 0;
>> +
>> +	if ((in_bdev == out_bdev) && bdev_max_copy_sectors(in_bdev) &&
>> +	    (file_in->f_iocb_flags & IOCB_DIRECT) &&
>> +	    (file_out->f_iocb_flags & IOCB_DIRECT)) {
>> +		copied = blkdev_copy_offload(in_bdev, pos_in, pos_out, len,
>> +					     NULL, NULL, GFP_KERNEL);
>> +		if (copied < 0)
>> +			copied = 0;
>> +	} else {
>> +		copied = splice_copy_file_range(file_in, pos_in + copied,
>> +						 file_out, pos_out + copied,
>> +						 len - copied);
>> +	}
>
>This should not fall back to a page cache copy.
>
>We keep being told by application developers that if the fast
>hardware/filesystem offload fails, then an error should be returned
>so the application can determine what the fallback operation should
>be.
>
>It may well be that the application falls back to "copy through the
>page cache", but that is an application policy choice, not a
>something the kernel offload driver should be making mandatory.
>
>Userspace has to handle copy offload failure anyway, so they a
>fallback path regardless of whether copy_file_range() works on block
>devices or not...
>
Makes sense, We will remove fallback part in next version.

Thank you,
Nitesh Shetty

------u98hW3AvpxW_WMqzG8XaJinKydZ84Ygy6oP0sovTVoTPagnQ=_6c01_
Content-Type: text/plain; charset="utf-8"


------u98hW3AvpxW_WMqzG8XaJinKydZ84Ygy6oP0sovTVoTPagnQ=_6c01_--

