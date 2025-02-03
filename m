Return-Path: <linux-fsdevel+bounces-40591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027EEA25AF2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 14:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08A45165481
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 13:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70797205E14;
	Mon,  3 Feb 2025 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CsEpA/ti"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CD6205ACF
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 13:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738589557; cv=none; b=B2wS1kFbCtVcPB2o6RTN40A2cAbS4Ima8bV78pi/2+XBJ0GY9qrNxcO7bAW7GzFAkA8gUKjUIGhUXR5qA38DbWNn1qv2Lv65O9rD2wQ3oqWJMAiTzdjsi8616EYniRubTr2J0lKLpT/yQYPStIEim5ZV6ZEOBuXk6mk+94t3rzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738589557; c=relaxed/simple;
	bh=7bbDhhMd9aHuVxlo/lQg2LxexkJ/8f8XKk8GWoA9L1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=lhoJexzhTEipKEhXwrwdWpVnjOBq0QetTo/Wmllokv2BIVP/qlqTfYE71OPwGjohGf/qtx9Nf43id0CWhxOuvt2wGvDfcXCOQ2LHULEQobefl4PTNmM6IQ4kfvoiOIIOIPtKmyv7GeBj2/BGmTlOMXP837WVWnPuRHoVTV2U8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CsEpA/ti; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250203133233epoutp01cd4f85bb8d5584ef6070fc4fd822e58b~gtfzGgWNY1977619776epoutp01u
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Feb 2025 13:32:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250203133233epoutp01cd4f85bb8d5584ef6070fc4fd822e58b~gtfzGgWNY1977619776epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1738589553;
	bh=6MGxFi5Fv9kCAeqR+MAkvHCwAW4ts2bnPjVRRBdttjE=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=CsEpA/tiKPDyCecskBUSbMjiVEpH0S/QkwSqCWlrvzKo+TlbIZv8ioVvRP7akFCUA
	 U269KEhpAn4A0C3jzB5MR+CV1ISsIqCCDj6Fo9YgPFr8CI0fUHLGrhRb3jtJ/FhTwU
	 feeIdsFEacldgYhoO0ZyNOj+VbsNZAUgE9EMUgjA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250203133232epcas5p26eccc8d735a8e4761a7ac0b4f2d31d21~gtfx8uCNX0357503575epcas5p2L;
	Mon,  3 Feb 2025 13:32:32 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YmnVQ39MTz4x9Pq; Mon,  3 Feb
	2025 13:32:30 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	27.AA.20052.E65C0A76; Mon,  3 Feb 2025 22:32:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250203133229epcas5p28eed3ac46c83cecc403cfc7104d8a92c~gtfv0f6vg1023410234epcas5p2p;
	Mon,  3 Feb 2025 13:32:29 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250203133229epsmtrp175c332bf5deb1f7a740065d7f7aca358~gtfvzgmXG3054430544epsmtrp1L;
	Mon,  3 Feb 2025 13:32:29 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-92-67a0c56e6e58
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	19.88.23488.D65C0A76; Mon,  3 Feb 2025 22:32:29 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250203133228epsmtip1a6d857052e7216c3c7278fedaf36b351~gtfubeF3m0150601506epsmtip1F;
	Mon,  3 Feb 2025 13:32:28 +0000 (GMT)
Message-ID: <c9b1325e-e986-4b85-ae6b-32686cd66888@samsung.com>
Date: Mon, 3 Feb 2025 19:02:27 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, Theodore Ts'o
	<tytso@mit.edu>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEJsWRmVeSWpSXmKPExsWy7bCmum7e0QXpBs8WiFj87brHZPHnoaHF
	3lvaFpcer2C32LP3JIvF/GVP2S32vd7LbNHa85PdgcNj85J6j8k3ljN6NJ05yuwxYfNGVo/P
	m+Q82g90MwWwRWXbZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE
	6Lpl5gBdo6RQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMCnQK07MLS7NS9fLSy2x
	MjQwMDIFKkzIzli/8wJLwX3xigurX7I0MHYKdzFyckgImEg8m/+YtYuRi0NIYDejxPVTa5gg
	nE+MEn+/X2OHcL4xSmxYdB7I4QBraXjnDxHfyyjR/XY7G4TzllFi0bxWVpC5vAJ2Endnn2YB
	sVkEVCRuN19mhIgLSpyc+QQsLiogL3H/1gx2EFtYwEaie9chNhBbRCBEYmn/JLCbmAWamCUO
	fVnADJJgFhCXuPVkPhPIFWwCmhIXJpeChDkFrCUWXf/DClEiL7H97RxmkF4JgZkcEp2fG9gg
	HnWRaPx9kxXCFpZ4dXwLO4QtJfGyvw3KzpZ48OgBC4RdI7Fjcx9Uvb1Ew58brCB7mYH2rt+l
	D7GLT6L39xMmSKDwSnS0CUFUK0rcm/QUqlNc4uGMJVC2h8SlVZuhoTuNSeLom69MExgVZiEF
	yywkX85C8s4shM0LGFlWMUqmFhTnpqcWmxYY5qWWwyM8OT93EyM4sWp57mC8++CD3iFGJg7G
	Q4wSHMxKIrynty9IF+JNSaysSi3Kjy8qzUktPsRoCoyficxSosn5wNSeVxJvaGJpYGJmZmZi
	aWxmqCTO27yzJV1IID2xJDU7NbUgtQimj4mDU6qBSWGtlvKvLV5nPv+WfTPlgMWxRr7NRlGi
	6sc+2iRv4YsTy7c3kmua+8Ki+9hq17upLVl2wQ7MttsyJbRNF1gkWd7MPnHm2WuZtpxiLxeN
	Xd4u82ruci5p0XvH51h259jBPTPvfHdly1poyKO+/lHNFhWLr7FHWVRvNGvPq0p3nuCrU31d
	ZNautw2Faw/MMOpI+zXlvoKR1l6jgntCoqeOr1flm3c84NFELol/FR/5PBUPNnoFlqz6Frib
	dbG8t3mPn5TflG9CV+adi5y39fVvtpU1i6dcZ23gvu+wevKDn05V1clOcl8Tv3bs+fX17PVp
	B+ZmnvtSb8dy2vuga5FA5Orq4x9dH/BVcucW3xXVVWIpzkg01GIuKk4EAGdzzhM1BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsWy7bCSnG7u0QXpBm2f9Sz+dt1jsvjz0NBi
	7y1ti0uPV7Bb7Nl7ksVi/rKn7Bb7Xu9ltmjt+cnuwOGxeUm9x+Qbyxk9ms4cZfaYsHkjq8fn
	TXIe7Qe6mQLYorhsUlJzMstSi/TtErgy1u+8wFJwX7ziwuqXLA2MncJdjBwcEgImEg3v/LsY
	uTiEBHYzSsyZsJOxi5ETKC4u0XztBzuELSyx8t9zdoii14wSb6a+AiviFbCTuDv7NAuIzSKg
	InG7+TJUXFDi5MwnYHFRAXmJ+7dmgA0SFrCR6N51iA3EFhEIkfj2fiITyFBmgSZmif/7rjJB
	bJjGJPHqwHdWkCpmoDNuPZnPBHIqm4CmxIXJpSBhTgFriUXX/0CVmEl0be1ihLDlJba/ncM8
	gVFoFpI7ZiGZNAtJyywkLQsYWVYxSqYWFOem5yYbFhjmpZbrFSfmFpfmpesl5+duYgRHkZbG
	DsZ335r0DzEycTAeYpTgYFYS4T29fUG6EG9KYmVValF+fFFpTmrxIUZpDhYlcd6VhhHpQgLp
	iSWp2ampBalFMFkmDk6pBiajWDHrkHcLSqS0GUv+y1TenbBM19DAIj5ZXPnTVp/o0xOnsdyf
	1uyXvv/ov8M7OGy6Xm5pfu/30eTflNOaj4KmRc/MPpciZmL+X5u5y3F92Re96Xf40xZ6WS2+
	/f71am2LwNVWs5QCkvg+LQowyOu3PT4ra9vN3mLVOOFrm3kP7lvy1+3kobX/9lWqmRVv76tW
	aq6I/LLy1ioWhwN7S+afz/zQ1szwLfjdocndGhzR16obL0r9mPLzir5g3spLx+OXR2mXpckk
	c0+y5Nwwe50tf+86u4t3lhivdtZL4FD7WdUwf6tJReeVzsanldr3uzf9OtB0R+TTN75/y2MX
	Lpjy07nvbOa79VEFDnu61i9XYinOSDTUYi4qTgQAN4zWIhEDAAA=
X-CMS-MailID: 20250203133229epcas5p28eed3ac46c83cecc403cfc7104d8a92c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
	<20250130091545.66573-1-joshi.k@samsung.com>
	<20250130142857.GB401886@mit.edu>
	<97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
	<b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>

On 2/3/2025 1:17 PM, Johannes Thumshirn wrote:

>>> I wouldn't call this "file system offload".  Enabling the data
>>> integrity feature or whatever you want to call it is really a block
>>> layer issue.  The file system doesn't need to get involved at all.
>>> Indeed, looking the patch, the only reason why the file system is
>>> getting involved is because (a) you've added a mount option, and (b)
>>> the mount option flips a bit in the bio that gets sent to the block
>>> layer.
>> Mount option was only for the RFC. If everything else gets sorted, it
>> would be about choosing whatever is liked by the Btrfs.
>>      > But this could also be done by adding a queue specific flag, at which
>>> point the file system doesn't need to be involved at all.  Why would
>>> you want to enable the data ingregity feature on a per block I/O
>>> basis, if the device supports it?
>> Because I thought users (filesystems) would prefer flexibility. Per-IO
>> control helps to choose different policy for say data and meta. Let me
>> outline the differences.
> But data and metadata checksums are handled differently in btrfs. For
> data we checksum each block and write it into the checksum tree. For
> metadata the checksum is part of the metadata (see 'struct btrfs_header').

Yes, I am aware that btrfs meta checksum is put into an exiting field in 
the B-tree header. It only affects the compute part, and not the 
write-amplification part unlike the data checksums. That is exactly why 
I did not find it worth to optimize in the existing RFC.


>> Block-layer auto integrity
>> - always attaches integrity-payload for each I/O.
>> - it does compute checksum/reftag for each I/O. And this part does not
>> do justice to the label 'offload'.
>>
>> The patches make auto-integrity
>> - attach the integrity-buffer only if the device configuration demands.
>> - never compute checksum/reftag at the block-layer.
>> - keeps the offload choice at per I/O level.
>>
>> Btrfs checksum tree is created only for data blocks, so the patches
>> apply the flag (REQ_INTEGRITY_OFFLOAD) on that. While metadata blocks,
>> which maybe more important, continue to get checksummed at two levels
>> (block and device).
> The thing I don't like with the current RFC patchset is, it breaks
> scrub, repair and device error statistics. It nothing that can't be
> solved though. But as of now it just doesn't make any sense at all to
> me. We at least need the FS to look at the BLK_STS_PROTECTION return and
> handle accordingly in scrub, read repair and statistics.
> 
> And that's only for feature parity. I'd also like to see some
> performance numbers and numbers of reduced WAF, if this is really worth
> the hassle.

Have you seen the numbers mentioned in the cover letter of the RFC?
For direct IO: IOPS increase from 144K to 172K, and extra-writes 
reduction from 66GB to 9GB.

Something similar for buffered IO:
https://lore.kernel.org/linux-block/20250129140207.22718-1-joshi.k@samsung.com/


