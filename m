Return-Path: <linux-fsdevel+bounces-20307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD9E8D14CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 08:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDB11C2226B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 06:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0285A6F065;
	Tue, 28 May 2024 06:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A6QX3l8B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958BA71742
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716879423; cv=none; b=hfRlznyp8E4rOQ0TnyuIUTP+X51zJM6kt5G5dv7xQZT8o2w5A2mwj/lJSOYVxPzQcDuYLDThcBDuQxCj+N8n1wpEnKv/B94OYtzJKMhbF5B5fF76hw2q7YXJiJqoyBqlapfl0u+6BwxuS3i0hzPFJNKGDhr6gXPnECpwcXowxqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716879423; c=relaxed/simple;
	bh=VHklIm/d1slFpHw4H0fGDmkRx7FbeR3jd6KKqB6xOrY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=jt7dG5TT4AxO+Ozmmvf/LLB5GDKGrhot1SClqNwu4S/kTsifqdzhhJl/QthTYyBom/ZwSsMAjXpk4Ma7YzvDmo6kELebm2OeCVbR0IAWMKtJURxHV2Qfvo4ioMamQVXVJMZDQ/EwXErfabnJMCivdS/74pJbnj3FjinvIbLEd/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=A6QX3l8B; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240528065653epoutp02728f29c1b4f2ced737ba3d1e39b89d4d~TlLru-G9f2778827788epoutp02z
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 May 2024 06:56:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240528065653epoutp02728f29c1b4f2ced737ba3d1e39b89d4d~TlLru-G9f2778827788epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716879413;
	bh=nAZx1LsOHkUtzRfjnw0sqmJkB2agzB/i6qclqjs+O2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A6QX3l8BIRem4hWQvpzZ3SdTCGJG8oFBQxAtoXUfhh6JWRyw5vGiUTkfGlzg61oG/
	 zIPDj5UZ8SnBerbI5RNbJbjlFhpRhZ09n9uAyaL3qurd8qhyjNjmd7urty52Um3DQt
	 8lzVnBgI8Ej5B2UVZDo11DTBKBpgxK8cVcFJMdpU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240528065652epcas5p2d8319a1124923aaa87746d14bdf69f6a~TlLq5UvCH0185501855epcas5p2N;
	Tue, 28 May 2024 06:56:52 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VpNbk5vG5z4x9QC; Tue, 28 May
	2024 06:56:50 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	60.C8.09989.23085566; Tue, 28 May 2024 15:56:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240528060437epcas5p2587b9da4ba2e6f0beddcb42a9679e860~TkeCoTB6X0914209142epcas5p2L;
	Tue, 28 May 2024 06:04:37 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240528060437epsmtrp2df0fb02a548747a950a44b275d53f541~TkeCm5zxE0102101021epsmtrp2O;
	Tue, 28 May 2024 06:04:37 +0000 (GMT)
X-AuditID: b6c32a4a-e57f970000002705-54-665580324bfc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	9E.14.18846.4F375566; Tue, 28 May 2024 15:04:36 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240528060433epsmtip20328e5dbd5f2ec8f001612a38afabaf3~Tkd-DQImr1951119511epsmtip2Z;
	Tue, 28 May 2024 06:04:33 +0000 (GMT)
Date: Tue, 28 May 2024 05:57:33 +0000
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
Subject: Re: [PATCH v20 05/12] fs/read_write: Enable copy_file_range for
 block device.
Message-ID: <20240528055733.kwmyx7f7u3w7gpon@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZlJuDxhMEpJxKQHV@dread.disaster.area>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzOubfcFiN4pRAPBSerExXCo7w8SFE3jLmZk7AMMjeTYQeXRyht
	1xZR5kZ5OakPsFOcdbxxCGwQhC1FYUKFFgqERF6DQRkOBoyIDFQmDllLwfjf9/t+33d+rxwW
	blfO5LDiRXJaKhIIucQmxi8P9rp5+CgiYryV9/egGoMOR+m5KziqGs0h0OyDBYDy5l/gaKL5
	G4BedvfgqF5nBKioJJ+BhpobMNRYosJQRVUbhm5ez8BQ2+pjAqm0AwBN9qsx1DTsjorPlTFQ
	Y1MHA/Xe/Z5AhT9MMlG5/hWGrpzvx5BmIg2g6tknDNQ+7IR6VvRWh5yo3r6jlKEEUg3qUSbV
	Y6xlUL3dSdSdymyCqitLpabrbgDq3pCCoEovf2tFXcqYI6iGrDEr6p/JYQb15Nd+grpcXwmo
	rqJWZhj70wR+HC2IpqUutChKHB0vig3mHv0oMiTSP8Cb58ELRPu4LiJBIh3MPfxBmMeReKFp
	OVyXUwJhkokKE8hkXK8DfKk4SU67xIll8mAuLYkWSvwknjJBoixJFOspouX7ed7ePv4m4cmE
	OLXeSEiK4enRpVKmApTZK4E1C5J+MO1CH6EEm1h25D0Aq1ueMS3BAoC3pwbB68C4OopvWKrG
	fltXNQDYpWlbDxYBXF7WWZlVDHIXXB3sNtlZLIJ0h52rLDNtT7pClUqDm/U4WURAZVo1Zk6w
	yeNwsXicYcY2ZAisrx0CFrwVdtyYWOOtSV/Y9HPHWkuQNFjD7yrKGZaWDkPthal1zIZ/6+uZ
	FsyBi3NNhAUnw4qrtwmLORNA9aAaWBIHYZYhZ202nIyFE4356w9th9cMlu5w0hZeejmBWXgb
	qCnYwDvhjzVF6wUc4cBSGmGeGJIU1J5zt2zlLwD7ZoxYLnhL/cZA6jfKWfB+mD2fbqU22XHS
	CZa/YlngXlhz16sIWFUCR1oiS4ylZf4SHxGd/PrMUeLEO2Dtx7i9rwHjf8x7agHGAloAWTjX
	3sa+4MMYO5towZkUWiqOlCYJaZkW+JsOdAXnOESJTV9OJI/k+QV6+wUEBPgF+gbwuNtsZrPy
	o+3IWIGcTqBpCS3d8GEsa44Cy1kKoj5mF511zniB5T/tsWcbvrJLUbVXLxWrfqo89AVz907+
	VM5JB8Pz5SParcey30vd3Mku9tg83vzo+JyX/sSxZ1n383Sh7wTNlLHjAlOn+a7O188o/9zj
	PxL+r0KDPW3jLkYMdG9vURba8mpcp7ewog7Odp9QCpdCyQVdn/0499bjKU6Bo63CcWXRuS4m
	ZCUlnbPr7VO7m8/WjglzvwwvxCQPWx1WnR9u86Ayb6mu6STWn4XnS3wTr7LPf87/7+vMm+F5
	BQkHnp+eHdgRWncRzrRUJnzye2tet3PtxR3sEaB/t7RPlujDwDsjtI+St3QtjjCD5tsXYmEI
	Z3Uf08j35DJkcQKeGy6VCf4HXkQjk7oEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsWy7bCSvO6X4tA0g1vTTCzWnzrGbNE04S+z
	xeq7/WwWrw9/YrSY9uEns8WTA+2MFr/Pnme22HLsHqPFgkVzWSxuHtjJZLFn0SQmi5WrjzJZ
	zJ7ezGRx9P9bNotJh64xWjy9OovJYu8tbYuFbUtYLPbsPclicXnXHDaL+cueslssP/6PyWJi
	x1Umix1PGhkt1r1+z2Jx4pa0xfm/x1kdpD0uX/H2OLVIwmPnrLvsHufvbWTxuHy21GPTqk42
	j81L6j1ebJ7J6LH7ZgObx+K+yawevc3v2Dx2tt5n9fj49BaLx/t9V9k8+rasYvQ4s+AIe4Bw
	FJdNSmpOZllqkb5dAlfGkmkfGAuuiVYcn3iQqYHxs2AXIyeHhICJxOr7N9i7GLk4hAS2M0pc
	3tvCCJGQlFj29wgzhC0ssfLfc6iij4wSB94dYAFJsAioSvy/fhaogYODTUBb4vR/DpCwiICa
	xKRJO5hB6pkFlrBJzLx0iRUkISwQIfF54UOwXl4BZ4ktG28yQgx9xigx/+x1JoiEoMTJmU/A
	ipgFzCTmbX7IDLKAWUBaYvk/sAWcAsYSe7eeZJzAKDALSccsJB2zEDoWMDKvYhRNLSjOTc9N
	LjDUK07MLS7NS9dLzs/dxAhOCFpBOxiXrf+rd4iRiYPxEKMEB7OSCK/IvMA0Id6UxMqq1KL8
	+KLSnNTiQ4zSHCxK4rzKOZ0pQgLpiSWp2ampBalFMFkmDk6pBqZQiWu7vCT3br5wUlM2Uel2
	6byl/IZmgse1Zx2+vUtbSF9ccvZ1tYzkVY8jdk7QqQ+tipmWaPWjfpIZe7rfbLVtTxlNVhZx
	fhWK/CSSEiEQw1J1vCP1ydl1WrwWGtWyahnv2TL476/Pd3C0mWbH7M8ktP92i/kynYX66syC
	3242pP3ZN/fRxpcKdd0CfocV/qSdndzzxZg5zOhXwstyvuULAu+WrEuzimDTnWv8687+87zG
	p0TVix1/fLMw6869KVx/9IPpOrmjMi94GL5K/Ylt1DnodMWexTuJ4fxhnenbs06IRJVybjYu
	vb14AUMxQ1xPWOGzz6XGs9bPSA9hqnVMqf/4ov+v8rInxXbaSizFGYmGWsxFxYkAAcvDiHcD
	AAA=
X-CMS-MailID: 20240528060437epcas5p2587b9da4ba2e6f0beddcb42a9679e860
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----u98hW3AvpxW_WMqzG8XaJinKydZ84Ygy6oP0sovTVoTPagnQ=_b7ed_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102917epcas5p1bda532309b9174bf2702081f6f58daf7
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102917epcas5p1bda532309b9174bf2702081f6f58daf7@epcas5p1.samsung.com>
	<20240520102033.9361-6-nj.shetty@samsung.com>
	<ZlJuDxhMEpJxKQHV@dread.disaster.area>

------u98hW3AvpxW_WMqzG8XaJinKydZ84Ygy6oP0sovTVoTPagnQ=_b7ed_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 26/05/24 09:02AM, Dave Chinner wrote:
>On Mon, May 20, 2024 at 03:50:18PM +0530, Nitesh Shetty wrote:
>> From: Anuj Gupta <anuj20.g@samsung.com>
>>
>> This is a prep patch. Allow copy_file_range to work for block devices.
>> Relaxing generic_copy_file_checks allows us to reuse the existing infra,
>> instead of adding a new user interface for block copy offload.
>> Change generic_copy_file_checks to use ->f_mapping->host for both inode_in
>> and inode_out. Allow block device in generic_file_rw_checks.
>>
>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
>> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
>> ---
>>  fs/read_write.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/read_write.c b/fs/read_write.c
>> index ef6339391351..31645ca5ed58 100644
>> --- a/fs/read_write.c
>> +++ b/fs/read_write.c
>> @@ -1413,8 +1413,8 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
>>  				    struct file *file_out, loff_t pos_out,
>>  				    size_t *req_count, unsigned int flags)
>>  {
>> -	struct inode *inode_in = file_inode(file_in);
>> -	struct inode *inode_out = file_inode(file_out);
>> +	struct inode *inode_in = file_in->f_mapping->host;
>> +	struct inode *inode_out = file_out->f_mapping->host;
>>  	uint64_t count = *req_count;
>>  	loff_t size_in;
>>  	int ret;
>
>Ok, so this changes from file->f_inode to file->mapping->host. No
>doubt this is because of how bdev inode mappings are munged.
>However, the first code that is run here is:
>
>	ret = generic_file_rw_checks(file_in, file_out);
>
>and that function still uses file_inode().
>
>Hence there checks:
>
>> @@ -1726,7 +1726,9 @@ int generic_file_rw_checks(struct file *file_in, struct file *file_out)
>>  	/* Don't copy dirs, pipes, sockets... */
>>  	if (S_ISDIR(inode_in->i_mode) || S_ISDIR(inode_out->i_mode))
>>  		return -EISDIR;
>> -	if (!S_ISREG(inode_in->i_mode) || !S_ISREG(inode_out->i_mode))
>> +	if (!S_ISREG(inode_in->i_mode) && !S_ISBLK(inode_in->i_mode))
>> +		return -EINVAL;
>> +	if ((inode_in->i_mode & S_IFMT) != (inode_out->i_mode & S_IFMT))
>>  		return -EINVAL;
>
>.... are being done on different inodes to the rest of
>generic_copy_file_checks() when block devices are used.
>
>Is this correct? If so, this needs a pair of comments (one for each
>function) to explain why the specific inode used for these functions
>is correct for block devices....
>
We were getting wrong size with file_inode() for block device, but we
missed to do it here in generic_file_rw_checks.
We will change the generic_file_rw_checks to use file->mapping->host
to make it consistent.

Thank You,
Nitesh Shetty

------u98hW3AvpxW_WMqzG8XaJinKydZ84Ygy6oP0sovTVoTPagnQ=_b7ed_
Content-Type: text/plain; charset="utf-8"


------u98hW3AvpxW_WMqzG8XaJinKydZ84Ygy6oP0sovTVoTPagnQ=_b7ed_--

