Return-Path: <linux-fsdevel+bounces-64355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAACBE2B4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 12:16:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2509458590A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Oct 2025 10:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0F331B800;
	Thu, 16 Oct 2025 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vh8pmbTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FB231A7EE
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608653; cv=none; b=pL9VnHwbCmGj2D/AHXW3KKrPcqqJ1IhSl8fu+5YZiFq131emHMrDhVl2o88NTSq49mLbhKeihicNxuF3FHmWRc+9qJYBSM8ZltTHmXY10rNEBpqEHQ/pjJnOlGCUhOjj7wz6PdpPgdYiAUrUwgTYguPt6ko81/JN98HoS3JNSiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608653; c=relaxed/simple;
	bh=c3Y6uzRSpKdJJ/ckRACM03VmBMcJ+/JDxk+tRz48kEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=K/nrx5nM+kFpmeJbIx0XjBTCzaEFQrNkW408UQc7hxPIqoR9wRK+U7fjtqCUiPKFhbSgdsq6o0QyeUr/OzoGHjEtYqCrUP2Nsr7bnEiLo93t2+QV9/2bXWN+7YyAe2hiXG5uS2HXwv9xo+47JshL9Il683uYSzoZcDiJMrC78dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vh8pmbTm; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20251016095727epoutp03fc839fca222caf2955b2feb2e548fde3~u8DyBETTY1056510565epoutp03D
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Oct 2025 09:57:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20251016095727epoutp03fc839fca222caf2955b2feb2e548fde3~u8DyBETTY1056510565epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760608647;
	bh=c3Y6uzRSpKdJJ/ckRACM03VmBMcJ+/JDxk+tRz48kEk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=vh8pmbTmenFna0Dk/mBXhzcypyR6IVsq8WqQcdnFS4OMCXmsiTupSNneFoomdmrXY
	 kqKLqGueEktvW5AttawQLSIZHR7IddiegEQft4tColWAGrkUonWmcOZmzkj3baOOvD
	 3RWgB1wOuVz2UQsacKIjnukjlJ8h5aQVRbsx0doo=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20251016095725epcas5p245f07f3671b4770dc18248dd2ab9b51c~u8Dwwl1ma2556625566epcas5p25;
	Thu, 16 Oct 2025 09:57:25 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.87]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4cnNfX69dSz3hhT3; Thu, 16 Oct
	2025 09:57:24 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20251016095724epcas5p45528badaeabae6c4065bf47546c861ca~u8DvrIvyc1850818508epcas5p4v;
	Thu, 16 Oct 2025 09:57:24 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251016095723epsmtip2d74c78b6603ceea6d3a8a2e926a0be99~u8DuXufQ51167611676epsmtip25;
	Thu, 16 Oct 2025 09:57:22 +0000 (GMT)
Message-ID: <4cf4ebdd-a33f-4ff5-8016-aff8a6a87c54@samsung.com>
Date: Thu, 16 Oct 2025 15:27:22 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] fs: add the interface to query user write
 streams
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, brauner@kernel.org,
	josef@toxicpanda.com, jack@suse.cz, jlayton@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250812082240.GB22212@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251016095724epcas5p45528badaeabae6c4065bf47546c861ca
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729145335epcas5p462315e4dae631a1d940b6c3b2b611659
References: <20250729145135.12463-1-joshi.k@samsung.com>
	<CGME20250729145335epcas5p462315e4dae631a1d940b6c3b2b611659@epcas5p4.samsung.com>
	<20250729145135.12463-3-joshi.k@samsung.com> <20250812082240.GB22212@lst.de>

On 8/12/2025 1:52 PM, Christoph Hellwig wrote:
> On Tue, Jul 29, 2025 at 08:21:32PM +0530, Kanchan Joshi wrote:
>> Add new fcntl F_GET_MAX_WRITE_STREAMS.
>> This returns the numbers of streams that are available for userspace.
>>
>> And for that, use ->user_write_streams() callback when the involved
>> filesystem provides it.
>> In absence of such callback, use 'max_write_streams' queue limit of the
>> underlying block device.
> As mentioned in patch 1, I think we'd rather dispath the whole fcntl
> to the file system, and then use generic helpers, which will give
> more control of the details to the file system.


I could not follow it, can you please expand that a bit.
Should I get F_GET_MAX_WRITE_STREAMS dispatched to new inode operation.



