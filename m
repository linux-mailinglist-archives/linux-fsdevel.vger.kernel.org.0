Return-Path: <linux-fsdevel+bounces-29185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9B0976E27
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 17:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E09C6B220A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 15:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87A71B9832;
	Thu, 12 Sep 2024 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cX6fpqCd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FED44C8F
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726156264; cv=none; b=Co8/RA0hPMaup7VTJ3cOTaF9VyryYaBL1J1FjpKVZsjAIhSiDd/nOQ0pxqMNgN3Asw7JKsfmkP5qHyjrjHY+3f1psrZ3t9xm/lAzTUSwdjukHsaxxHtkfAUY7pX6Mh2epa2yGCowpP5WDe1YigkKlgWp9oQ9nwJY42AElsrhnkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726156264; c=relaxed/simple;
	bh=bjL4TAj50YfyLvnKrykTtDWzPJ0HJA2DnK9CwZTqwAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=seMBy8Ftj42hcRPt9gFJuYGHW6dNaGvD+boAdvPgiZI6EKzEJU2rTUfrQUnYgPAUPGPIluzJRxLWsE/l+XFCc8N4tCJcuqI1bRmOS+y3DviqFqVGLBZbO/lOHbAdHl1/Nahr9OdjpXFyxUvaKQCisECO83THtN/6QG7YiTjCLd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cX6fpqCd; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240912155053epoutp03bde3a32902555b4e83b3bb80a8bf17e3~0ifekeD2i0612506125epoutp03y
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 15:50:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240912155053epoutp03bde3a32902555b4e83b3bb80a8bf17e3~0ifekeD2i0612506125epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1726156253;
	bh=t9VILr0qkYP4rvJKavSsOF6cu9G5TqXZShkha385+XA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=cX6fpqCdzPNuJGL7dr3izSpgxqHcAzY/DhTXjK1OxHiBa5quc3tYpqEGI6xdezVZ2
	 BXHbIXeZwikjN7W6ze37q0ZUHI78N30v8qxJqshW84Fsnz6WEwTAk33VP7TZXhZlSi
	 lyvA+KcAM1vGCFWd1L4fvmW4oVgt7HHSllFSeL0I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240912155052epcas5p2b02dfa87f8f14aebc50237e7e689f9d1~0ifdLYGGZ0517205172epcas5p23;
	Thu, 12 Sep 2024 15:50:52 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4X4MNV5JVsz4x9Pp; Thu, 12 Sep
	2024 15:50:50 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A1.28.09743.ADD03E66; Fri, 13 Sep 2024 00:50:50 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240912155049epcas5p479bf103d5407f12aeeb936b3f167e9f0~0ifazBgj10514805148epcas5p4F;
	Thu, 12 Sep 2024 15:50:49 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240912155049epsmtrp23139a0c48ea642236cda3a4145f6eb0e~0ifav_tYp3192931929epsmtrp2M;
	Thu, 12 Sep 2024 15:50:49 +0000 (GMT)
X-AuditID: b6c32a4a-14fff7000000260f-37-66e30dda6919
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EE.82.07567.9DD03E66; Fri, 13 Sep 2024 00:50:49 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240912155046epsmtip24aa2bc591086ec837e8ed050a50d5f8e~0ifX9cWQI0255602556epsmtip2G;
	Thu, 12 Sep 2024 15:50:46 +0000 (GMT)
Message-ID: <0baddb91-b292-db90-8110-37fa5a19af01@samsung.com>
Date: Thu, 12 Sep 2024 21:20:45 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v5 1/5] fs, block: refactor enum rw_hint
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	jaegeuk@kernel.org, jlayton@kernel.org, chuck.lever@oracle.com,
	bvanassche@acm.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240912125347.GA28068@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTZxTG9957aS8kdXcFwivZZrlTQTZKi6VeEBjJcN5Np4jZFmVLuaMX
	aCht0w/ZjBskgKGoKKgwOxzgB8S6iALZQEZUPtaxQcAxEVAQpR2MBqZAEEFkLa0b//3Ok+fk
	Oee8eXGUn8P1xxUqPatVMUqS44X92LopMGSQN5oiut23kbo8dJxD2VunAVXy+BlKLQ+NIdTA
	zUaEunS5HaG+K81BKGuNCaWuHcep0fszXOpZlZlLFbf0Aap58G3qj3PbqZ+bOzCqvMrGpY7c
	beBQ1ZYXCHXF/g9GdS9ZPKhuUxk31pfu/XMH3T18DaNLin/j0L1dBrrWbOTQdRey6KaKGYRu
	Gsjm0E9sgxhdWG8GdGdFG5eeqX2TrrVOIvG8/elRaSwjZ7UCVpWslitUqdHkjr2y92ThUpE4
	RBxBbSEFKiaDjSbjdsaHvK9QOtYlBQcYpcEhxTM6HRkaE6VVG/SsIE2t00eTrEau1Eg0Qh2T
	oTOoUoUqVh8pFonCwh3GpPQ0W20uqrHxv2zpOgqygWVNAfDEISGB53sauQXAC+cTTQDWHW3m
	uIppAH/vs6CuYg7Awvx27suW5X6b29UMYP5cj9s1CaC5/QeO08UjYuCt6iuYkzFiA6ysykdd
	+muw44x1RfclvoALd8qAk72JKNh4a2pFRwk/OGgtR5zsQ5DQNtEFnAEosYTCpafDHgUAxznE
	Jthz0uBET+Id2DvOc7Wugz9Nlq3MA4lqTzg1XwlcU8fBAesd9wbecMJS72Z/ODPVzHFxOhx5
	NIK5+BBsqCv0cPG7MPt5/0os6oituR7qyloDjy1aEacMCR7MP8x3uQPgcLHN3ekHH357wc00
	vH3K4r7bgOPUpzuRE0BgWnUV06rtTavWMf2fXAEwM1jLanQZqawuXBOmYjP/e/BkdUYtWPkN
	wR82gIcjj4UtAMFBC4A4SvrwijmPUvg8OfPVQVarlmkNSlbXAsIdz1OE+vsmqx3fSaWXiSUR
	IolUKpVEbJaKST+ePe+snE+kMno2nWU1rPZlH4J7+mcjca//mrjrg7sBV0sbx7tHSxPjPj4T
	nPdRrnGroCzSVgr1MsV4EGGUXxVOH9h9pFWgNWbVbPlkyCJ74Jt2b2GrUhK559Bfg/t4opIF
	I79oMXR+KkeiqGybTNjWF2T9rE1emeKLc7GqVwIvbesEJbOLARNTn+/p+zvzSdUimZXofXbX
	PSYmlF/3VCgNWz99/vnO2frskJ7tJ2PKuftj18/98r3fWxUB+xKz1moP3ohdTBjJU9JxgEzw
	6ig9Nt+RflqROXyxJLloNvxoUMoy63P9hr0+6hv7uY1gcndu+c26dUmbHwSOMRfDuvtP3R/b
	G2vGhEnaT0NyJja8anzja3vB4TnVCxLTpTHiYFSrY/4FJg+SLJYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7bCSvO5N3sdpBodbdSxW3+1ns3h9+BOj
	xbQPP5kt/t99zmRx88BOJouVq48yWcye3sxk8WT9LGaLjf0cFo/vfGa3+LlsFbvFpEPXGC32
	3tK2uLTI3WLP3pMsFvOXPWW36L6+g81i+fF/TBbrXr9nsTj/9zirxflZc9gdRD0uX/H2OH9v
	I4vHtEmn2Dwuny312LSqk81j85J6j90LPjN57L7ZwObx8ektFo++LasYPc4sOMLu8XmTnMem
	J2+ZAnijuGxSUnMyy1KL9O0SuDKebmphLngqVHHobA9jA+Nxvi5GTg4JAROJ/zeesnUxcnEI
	CexmlPjfu5QFIiEu0XztBzuELSyx8t9zdoii14wSN18+YQRJ8ArYSRxcvg6sgUVAVWLhsg5m
	iLigxMmZT8DiogJJEnvuNzKB2MICNhI7D74DizMDLbj1ZD5YXERASeLpq7OMIAuYBf4yS6z+
	/IsRYttNRoldbc2sXYwcHGwCmhIXJpeCmJwCOhKXX/BCzDGT6NraxQhhy0tsfzuHeQKj0Cwk
	Z8xCsm4WkpZZSFoWMLKsYpRMLSjOTc9NNiwwzEst1ytOzC0uzUvXS87P3cQITgNaGjsY783/
	p3eIkYmD8RCjBAezkgjvJLZHaUK8KYmVValF+fFFpTmpxYcYpTlYlMR5DWfMThESSE8sSc1O
	TS1ILYLJMnFwSjUwHVjE7LytTphBw0U05cuv2WIPGvduCW5am75ap1vshFYge9hbk6QHzoeO
	+07KTUrxtclccf/DZ515itV596cYP311/XNT+K8X9WG5r6N+3zGrEjmZpJjurrxsQd3V7823
	0xQ0JDwP8mhfsF2rtNyP57/+LYZTrIan1e3fzuMO4+LetK3zeDajyukFS19OrxeY1z9tpljN
	7Pg4C+bJWXySx+9wZsx8Hs1wYq6ayaQ70XJ/vyZxrbSPlPtofs5h8wJ1Buvl0UJX5G77u78L
	vtqzICup4GJ/euUmwRWmNlMdLWRuKq/5OUl89eLfgqcKF3o5vOqR8reUfmM8ozVnzhV18d3b
	+3Y7v9oStWM5u94lJZbijERDLeai4kQASkYcrXIDAAA=
X-CMS-MailID: 20240912155049epcas5p479bf103d5407f12aeeb936b3f167e9f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240910151044epcas5p37f61bb85ccf8b3eb875e77c3fc260c51
References: <20240910150200.6589-1-joshi.k@samsung.com>
	<CGME20240910151044epcas5p37f61bb85ccf8b3eb875e77c3fc260c51@epcas5p3.samsung.com>
	<20240910150200.6589-2-joshi.k@samsung.com> <20240912125347.GA28068@lst.de>

On 9/12/2024 6:23 PM, Christoph Hellwig wrote:
> On Tue, Sep 10, 2024 at 08:31:56PM +0530, Kanchan Joshi wrote:
>> Rename enum rw_hint to rw_lifetime_hint.
>> Change i_write_hint (in inode), bi_write_hint(in bio), and write_hint
>> (in request) to use u8 data-type rather than this enum.
>>
>> This is in preparation to introduce a new write hint type.
> 
> The rationale seems a bit sparse.  Why is it renamed?  Because the
> name fits better, because you need the same for something else?
> 

Right, new name fits better. Because 'enum rw_hint' is a generic name 
that conveys 'any' hint. This was fine before. But once we start 
supporting more than one hint type, we need to be specific what 
hint-type is being handled. More below.

>>   static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
>> -			  enum rw_hint hint, struct writeback_control *wbc);
>> +			  u8 hint, struct writeback_control *wbc);
> 
> And moving from the enum to an plain integer seems like a bit of a
> retrograde step.

This particular enum is hardwired to take 6 temperature-hint values [*].
But this (and many other) functions act as a simple propagator, which do 
not have to care whether hint type is lifetime or placement or anything 
else.

The creator/originator of the hint decides what hint to pass (userspace 
in this case). And the consumer (driver in this case) decides whether or 
not it understands the hint that has been passed. The intermediate 
components/functions only need to pass the hint, regardless of its type, 
down.

Wherever hint is being used in generic way, u8 data type is being used. 
  Down the line if a component/function needs to care for a specific 
type, it can start decoding the passed hint type/value (using the 
appropriate macro similar to what this series does for SCSI and NVMe).

Overall, this also helps to avoid the churn. Otherwise we duplicate all 
the propagation code that has been done for temperature hint across the 
IO stack.

[*]
enum rw_hint {
         WRITE_LIFE_NOT_SET      = RWH_WRITE_LIFE_NOT_SET,
         WRITE_LIFE_NONE         = RWH_WRITE_LIFE_NONE,
         WRITE_LIFE_SHORT        = RWH_WRITE_LIFE_SHORT,
         WRITE_LIFE_MEDIUM       = RWH_WRITE_LIFE_MEDIUM,
         WRITE_LIFE_LONG         = RWH_WRITE_LIFE_LONG,
         WRITE_LIFE_EXTREME      = RWH_WRITE_LIFE_EXTREME,
} __packed;



