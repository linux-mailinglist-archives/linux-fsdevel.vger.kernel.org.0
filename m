Return-Path: <linux-fsdevel+bounces-28567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 134E396C1A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 17:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 565EEB294EB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 14:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1211DEFC7;
	Wed,  4 Sep 2024 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EUf67+UR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC11DC1BB
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725461842; cv=none; b=gsuxcC2/8B+64iASeVIWZtZq5Hsixi4G7Liz3WjKQOIOmzbq3ojTDeOXAWg0k40YjJBtN7Or4xMktEssAfOap1cTcKPg/roUX28h/ylrG03YIVAS6WqSKZXvFUYX+CB9ny21l3eHWqXY2wMhixWJfBKWLDT2z/78UScHbk9TbU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725461842; c=relaxed/simple;
	bh=2MNDvJdAuFrKPaz7AKdeoAkNagaHCANVw+2OvyTUO+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=RlDSll3qviZEIBP7UZEBlGmijK9cAIcYNI+FQxh3CGASfwspkRiLy2cvEHOQiBJo7TA3bGLe/PjIN06I5S2EUgr+jQvXVxve+zSYpZTbX+DuJPSxbuvOGfGgXF4XKI/j7hYM1wzkYnYZC8Mi/u1aWKMkJwrvSc0SdQ1eh6cKrXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EUf67+UR; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240904145713epoutp04ab9429e29e6390818bf1cfc29f1d9c41~yEmUtzBWr3173331733epoutp04T
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 14:57:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240904145713epoutp04ab9429e29e6390818bf1cfc29f1d9c41~yEmUtzBWr3173331733epoutp04T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725461833;
	bh=/XD9MSPm2ieh7tYbx02NG5OSwwR0Rs4WQ1DiKKxiIlc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=EUf67+URh8alb88VzEor2UaIXgBKZJ3acZSCFSzN0ajwhhA7QkOFZtCdaeIskpcuR
	 wRu1fhD1aqucHaI7z4cHdrQ91wnczWbg25yFwUaV/mEvpzxIUmSBRnuMa4o96qM2NH
	 sfAyEQBbq9D76aGyzOfHnWQwDpUc/aWu5EOxF3Jw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240904145712epcas5p16b1e59b36b65364e750ad6186f3c40c0~yEmT86gsc0537605376epcas5p1a;
	Wed,  4 Sep 2024 14:57:12 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WzQZG2H28z4x9Pt; Wed,  4 Sep
	2024 14:57:10 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	02.09.09743.64578D66; Wed,  4 Sep 2024 23:57:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240904145709epcas5p1500f0810833c70c779c5b5d911fa7842~yEmRhvbRj0635006350epcas5p1x;
	Wed,  4 Sep 2024 14:57:09 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240904145709epsmtrp2579123e002487ee76c7e08d31d1d3da9~yEmRfmIxb0123901239epsmtrp25;
	Wed,  4 Sep 2024 14:57:09 +0000 (GMT)
X-AuditID: b6c32a4a-14fff7000000260f-69-66d875463bee
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	8A.1B.08964.54578D66; Wed,  4 Sep 2024 23:57:09 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240904145705epsmtip23467e1ecdd38069c57e5f46971b556e1~yEmN4AJW22167321673epsmtip2W;
	Wed,  4 Sep 2024 14:57:05 +0000 (GMT)
Message-ID: <cd7fa0b4-9f85-a73c-3f28-baa234a2ae7c@samsung.com>
Date: Wed, 4 Sep 2024 20:27:04 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/5] Write-placement hints and FDP
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: amir73il@gmail.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@hansenpartnership.com,
	jack@suse.cz, jaegeuk@kernel.org, jlayton@kernel.org,
	chuck.lever@oracle.com, bvanassche@acm.org, "axboe@kernel.dk"
	<axboe@kernel.dk>, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240903-erfassen-bandmitglieder-32dfaeee66b2@brauner>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbZRTOe3t7e8HUXAvIa1VgjSyOCaN8eVkATSRwwyASly3zI0IHF1pb
	2q63ZRshSmCbfGyjsIXOgqFWBAfKhCLjYxhSRLYJgiKDEj5dEUcFxrqgSHW2tFP+Pe85z3Oe
	95yTg7N4xRw+LpGraZVcJBNg3mjnwL4XQ5M0UznhzZtPkGOtLYBsma3ESNvAA0DW3N9ikY9m
	lxHS0t+NkFdbBhGyVleCkNZrehbZVomTd2fsHHKrsZlDVpvvALJvej/5kzGZvNF3CyXrG5c4
	ZMVkF0Y2Df2DkK22dZQc1ddxXvWjxn8+RHXrZznU6FwbStVU38ao8REN1d5chlGmhg+oXoMd
	oXotRRi1sTSNUhc7mgE1bPiWQ9nbA9K5b0njxLQom1YF0fIsRbZEnhsvOHQ447WM6JhwYagw
	lnxZECQX5dHxgsTU9NAkiczZriAoXyTTOEPpIoYRHEiIUyk0ajpIrGDU8QJamS1TRinDGFEe
	o5Hnhslp9UFheHhEtJOYKRU3XOhnK+9wT63rv+cUgS3vcuCFQyIKNn1twMqBN84jegFcrqpl
	ux8PABzsn/VkNgEc0J5FH0t05j/ZLswj+gC0lu5xk1YBvFSxDlwJLpEAtyoaEBdGiRfgRslV
	zB1/Ct76yLpTyI84Dv+aqNvh+xCx0DyyulOURfjDaWv9jtaXCIHFxg3EZcAizqBwcGnQKcZx
	jNgHxy5pXBwvIhFum2qBWxsIr6/WsdwfbfGCcyMenAgbOwc82AeuDHVw3JgP7Wt9mBtL4cIv
	C54mC2GX6SLbjV+BRY4ptsuW5bS91nPAbfUkvLBtRVxhSHBh6Tmem70HzlUveZT+cPFKgwdT
	cLr3oWeeDgA7iu2YFgTpd01Fv6t7/a5u9P87GwDaDJ6hlUxeLs1EKyPk9Mn/9p2lyGsHO8cQ
	ktIFFhfuh5kBggMzgDhL4Mu1+U7l8LjZotMFtEqRodLIaMYMop3rqWLx/bIUzmuSqzOEUbHh
	UTExMVGxkTFCgT/XdvbjbB6RK1LTUppW0qrHOgT34hchpWud22cqr0Re/+Z3m3g+2Jb54f76
	ma5yn758B2bybtWl/j3En3y/pyAt2cGSls3mrCSuWy3lPZZPPv2uKha3J6T98NXEwFYE9D4f
	vfcLo3Av89x4sOmuJjOsxP6bXOvz9POfl1UP30OffVsrLnovdLgqYDMwLuKNxgWLNrf04GGk
	Lcl4cuadJot48VFAaq3jS/m9eYZjHGXePZ0amaK1JktsOq3pMuEjeZN/vubEPHX7ZuCNieCM
	14/4F56SGT+bV9q7jdMpSYWyo8cHj92sEOjW08YWj76UuiwzGDIfsn/0uzxH/SopXJtcmbKd
	qP7jXE1nfzKhc9gix6X5aIH0yDEByohFwhCWihH9CwmGeIWVBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGe++9u/c6Wt2my9eKglVURqtByJvZB1R6Q4miKChKV7up6Nba
	dX2IpLagmpRl6GpqmpjiBopOs1qWrSxsibOFTmuWH2FlpmZRyz7nCvzvx3me5zznj0Pj4tfE
	LDpRncJp1YpkKSkkbjyQzlu2Sec+uML4LAQ5Ky0AWTzZJBp88AmgvBEvjn57BjDU2XgLQxWW
	JgzlG/UY6q8y4ag6m0Z9L8co5C0zUyjH3g5QQ9dS9KwkCt1paCZQUdkbCmV13CRR+eNfGKoc
	HCZQq6mAWi9hXc+j2VsmD8W2dlcTbF7OE5J1tejYGvNZkrWWprO24jGMtXVmkOzomy6CPV9r
	BuzT4ocUO1Yzd6totzBCySUnHuG0y9fGCRNKzzUKNO2iY8MmB5UBvEIDCKAhsxIa7d8EBiCk
	xYwNwAbLEPALwVDf/o3ycyCs+DVA+U2DAL7/XkL4BBGzFnqzSjEfE8wCOKqvIP3zGbD5Sv+E
	R8Lsh3deZU54AplV0N4yJPAx/regq79oYh7EhMKTJaOYrwBnThEwx/0B+Nt+AHjdmocbAE2T
	zBLovKTzBQKYjXDcmg/8i8Kgoc7wj+fB+qEC/AIQmybdYZrUZ5oUMU2KFAPCDEI4Da+KV/Fy
	jVzNHZXxChWvU8fLDhxS1YCJJwhdchPUm0dkdoDRwA4gjUuDRINB7oNikVJxPJXTHorV6pI5
	3g5m04Q0WBT89pxSzMQrUrgkjtNw2v8qRgfMysCqe2tdsUXpIRG32zq2P9m7hVg4jM/cU5f/
	YqSAbw3sHs09XaHMSx2XGLqd5Wme9A5bHAqumytI3loVkdiWVt4bHv6ZkU8p5GXrbs+Rvj9l
	bUtyhCo2riiINTocmS/LUmZ2ZjkCjx/uK3Qr+/L3/6RrW5oGUmOqOu/NftrWWuy0hGfre6bm
	bvsJG5qiKunp042wzpzpuh81vu/utU3yMG/KvmnubEnMaiqs0XC954dG4tx2JGDDu2jiBHkt
	4Wjkh8j1MfMvZ3icqp5HH/HwpLfrdgltO3ecWdT7pVym33zP+jVy+buuV2sWH96hXnqsPlJg
	i84dm9bc7Sq9mhYH0i5SUoJPUMhDcS2v+AN9Se0qcwMAAA==
X-CMS-MailID: 20240904145709epcas5p1500f0810833c70c779c5b5d911fa7842
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240826171409epcas5p306ba210a9815e202556778a4c105b440
References: <CGME20240826171409epcas5p306ba210a9815e202556778a4c105b440@epcas5p3.samsung.com>
	<20240826170606.255718-1-joshi.k@samsung.com>
	<20a9df07-f49e-ee58-3d0b-b0209e29c6af@samsung.com>
	<20240903-erfassen-bandmitglieder-32dfaeee66b2@brauner>

On 9/3/2024 8:05 PM, Christian Brauner wrote:
> On Tue, Sep 03, 2024 at 07:58:46PM GMT, Kanchan Joshi wrote:
>> Hi Amir,
>>
>>
>> On 8/26/2024 10:36 PM, Kanchan Joshi wrote:
>>> Current write-hint infrastructure supports 6 temperature-based data life
>>> hints.
>>> The series extends the infrastructure with a new temperature-agnostic
>>> placement-type hint. New fcntl codes F_{SET/GET}_RW_HINT_EX allow to
>>> send the hint type/value on file. See patch #3 commit description for
>>> the details.
>>>
>>> Overall this creates 128 placement hint values [*] that users can pass.
>>> Patch #5 adds the ability to map these new hint values to nvme-specific
>>> placement-identifiers.
>>> Patch #4 restricts SCSI to use only life hint values.
>>> Patch #1 and #2 are simple prep patches.
>>>
>>> [*] While the user-interface can support more, this limit is due to the
>>> in-kernel plumbing consideration of the inode size. Pahole showed 32-bit
>>> hole in the inode, but the code had this comment too:
>>>
>>> /* 32-bit hole reserved for expanding i_fsnotify_mask */
>>>
>>> Not must, but it will be good to know if a byte (or two) can be used
>>> here.
>>
>> Since having one extra byte will simplify things, I can't help but ask -
>> do you still have the plans to use this space (in entirety) within inode?
> 
> I just freed up 8 bytes in struct inode with what's currently in -next.
> There will be no using up those 8 bytes unless it's for a good reason
> and something that is very widely useful.

I see, so now there are two holes. Seems the plan is to co-locate these 
and reduce the size by 8 bytes. Thanks for the pointer. Primary reason 
is a bit cleaner plumbing, but I'll manage without extra space.

