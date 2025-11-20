Return-Path: <linux-fsdevel+bounces-69219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73066C737D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 11:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 59ACC2A6DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 10:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019A032D0DD;
	Thu, 20 Nov 2025 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CIpzmcRj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5592E2EF9;
	Thu, 20 Nov 2025 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763635071; cv=none; b=tz1sTdXBoV7jCsZy8PJT3a1jfziy1xc+CkiWaE48OYCkQFaU45ZwAqrnDbC3cMpCdHthOJeV4Z5au+0YTSb5AV7HWqxb7niDWCFpIoqHF6F2OTOu8TaZ0WsQvSl4Wqt1AjCi81dVbCvIAnW80bTYcmGXan4P6CPaN4fjxYtKOUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763635071; c=relaxed/simple;
	bh=zTgEYE395/v14G3bbz3aFs4mxZjYly78pp3eWo2OSTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsm+0WmKG9crUY7o4E6gzynso1t8IBHHOFI0pI9KxMxXZlWqdGYPmuSlnxgmIdcRVIoc8hbeldyX9Md0+9sJ8RfKT9ktWGyB7PncvXIOE5+nxBwJRuseS6DTt4UqmaIWryMmHmgzt2O7LL8RyajMwa7zSuuTJMs2AudxVNFYdFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CIpzmcRj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJLl0ke028025;
	Thu, 20 Nov 2025 10:37:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DiFm2pPK77NqjGSzdBjYiWga4vIf+H
	SFMe/r5qjGP94=; b=CIpzmcRjLwZN7KojVF0gGFWMPqnUYOnxsJlEBVmRyswY7r
	YLbnKYn2mj8h3fGVDY1+Ze9DCcUn0uLC4/0Ez7KL893cbgy1Z63qhrTiuW/19KAy
	s3lHv4VkUDvNP6cwOJcKSQ5JLwtQKms86t6tYXUshjCifCHFdq/Ml+jvvi7OCpxl
	l8A9QI+ZGKBUEx2C4H0SQPzB1IieZ7iBL1Ll+wyrAx/7yJdo+dCmETgksq3dT90+
	H00peX9MOBM50IQ7ipqb9rpVmkpZ3V6buQTPpgtInSrULUEy7H7Ti8UvJRXAz+K1
	UktDO6+edSl1xyijy/3TGWqcRjLhfa2G9bjH8l1w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejka5rfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 10:37:14 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AKAYZxS005668;
	Thu, 20 Nov 2025 10:37:13 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejka5rf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 10:37:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK9Gl4t010411;
	Thu, 20 Nov 2025 10:37:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af3use22j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 10:37:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AKAbA4g29557356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 10:37:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C66A320043;
	Thu, 20 Nov 2025 10:37:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 639E120040;
	Thu, 20 Nov 2025 10:37:06 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Nov 2025 10:37:06 +0000 (GMT)
Date: Thu, 20 Nov 2025 16:07:03 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Dave Chinner <david@fromorbit.com>
Cc: John Garry <john.g.garry@oracle.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
        tytso@mit.edu, willy@infradead.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
        martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
Message-ID: <aR7vTybVzFTnqL9G@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
 <aRUCqA_UpRftbgce@dread.disaster.area>
 <20251113052337.GA28533@lst.de>
 <87frai8p46.ritesh.list@gmail.com>
 <aRWzq_LpoJHwfYli@dread.disaster.area>
 <aRb0WQJi4rQQ-Zmo@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aRmHRk7FGD4nCT0s@dread.disaster.area>
 <8d645cb5-7589-4544-a547-19729610d44d@oracle.com>
 <aRuKz4F3xATf8IUp@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRuKz4F3xATf8IUp@dread.disaster.area>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iDamewJHv0QnhGk1wWJdIgKgHtcmARzf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX+pxIFpdIplp6
 RR2l0xrSadCKFa0vLJi9A7gDrVIAkyOtzmPehTZVRmLenVYmfRq3bq/USt+qDyJnFsMTOVZnI2H
 Z6RXB2oomcd42MbJolqmKOR/Qza90jAzBaX5pOhPYVVD9pXEHbhtp5tlX/iOixFLo8xByk5seEx
 NmDC/PcXrsqH270b2ZKJ1zcwzigTEMzw/4M7eAm0oaflXbYf7BvZ7szl2gvmJD7172hSgaSVKTm
 g7c1vT6t5NwKb69BVNe0KLDSQNQsJwCYwBzkVQCFrHZTqQ9s9TQFfmsR7C2cnHr5YsEJqcyydqs
 n/NJmIMV/93Ovc8Sw3oxwSCbuSpWumfYSbTs+96DpouPrKLCZJV63obthf0gQtpB353LJUWNk+X
 kOM+X5Bi0kaw3SFUeH2IxhbL341vrA==
X-Proofpoint-ORIG-GUID: _mx-pRALduQpTGKgkkarqN-KolQEQbAr
X-Authority-Analysis: v=2.4 cv=XtL3+FF9 c=1 sm=1 tr=0 ts=691eef5a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8 a=70sU5qKYBexbB1LL4xUA:9 a=CjuIK1q_8ugA:10
 a=biEYGPWJfzWAr4FL6Ov7:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

On Tue, Nov 18, 2025 at 07:51:27AM +1100, Dave Chinner wrote:
> On Mon, Nov 17, 2025 at 10:59:55AM +0000, John Garry wrote:
> > On 16/11/2025 08:11, Dave Chinner wrote:
> > > > This patch set focuses on HW accelerated single block atomic writes with
> > > > buffered IO, to get some early reviews on the core design.
> > > What hardware acceleration? Hardware atomic writes are do not make
> > > IO faster; they only change IO failure semantics in certain corner
> > > cases.
> > 
> > I think that he references using REQ_ATOMIC-based bio vs xfs software-based
> > atomic writes (which reuse the CoW infrastructure). And the former is
> > considerably faster from my testing (for DIO, obvs). But the latter has not
> > been optimized.
> 

Hi Dave,
Thanks for the review and insights.

Going through the discussions in previous emails and this email, I
understand that there are 2 main points/approaches that you've
mentioned:

1. Using COW extents to track atomic ranges
  - Discussed inline below.

2. Using write-through for RWF_ATOMIC buffered-IO (Suggested in [1])
	- [1] https://lore.kernel.org/linux-ext4/aRmHRk7FGD4nCT0s@dread.disaster.area/
  - I will respond inline in the above thread.

> For DIO, REQ_ATOMIC IO will generally be faster than the software
> fallback because no page cache interactions or data copy is required
> by the DIO REQ_ATOMIC fast path.
> 
> But we are considering buffered writes, which *must* do a data copy,
> and so the behaviour and performance differential of doing a COW vs
> trying to force writeback to do REQ_ATOMIC IO is going to be much
> different.
> 
> Consider that the way atomic buffered writes have been implemented
> in writeback - turning off all folio and IO merging.  This means
> writeback efficiency of atomic writes is going to be horrendous
> compared to COW writes that don't use REQ_ATOMIC.

Yes, I agree that it is a bit of an overkill.

> 
> Further, REQ_ATOMIC buffered writes need to turn off delayed
> allocation because if you can't allocate aligned extents then the
> atomic write can *never* be performed. Hence we have to allocate up
> front where we can return errors to userspace immediately, rather
> than just reserve space and punt allocation to writeback. i.e. we
> have to avoid the situation where we have dirty "atomic" data in the
> page cache that cannot be written because physical allocation fails.
> 
> The likely outcome of turning off delalloc is that it further
> degrades buffered atomic write writeback efficiency because it
> removes the ability for the filesystem to optimise physical locality
> of writeback IO. e.g. adjacent allocation across multiple small
> files or packing of random writes in a single file to allow them to
> merge at the block layer into one big IO...
> 
> REQ_ATOMIC is a natural fit for DIO because DIO is largely a "one
> write syscall, one physical IO" style interface. Buffered writes,
> OTOH, completely decouples application IO from physical IO, and so
> there is no real "atomic" connection between the data being written
> into the page caceh and the physical IO that is performed at some
> time later.
> 
> This decoupling of physical IO is what brings all the problems and
> inefficiencies. The filesystem being able to mark the RWF_ATOMIC
> write range as a COW range at submission time creates a natural
> "atomic IO" behaviour without requiring the page cache or writeback
> to even care that the data needs to be written atomically.
> 
> From there, we optimise the COW IO path to record that
> the new COW extent was created for the purpose of an atomic write.
> Then when we go to write back data over that extent, the filesystem
> can chose to do a REQ_ATOMIC write to do an atomic overwrite instead
> of allocating a new extent and swapping the BMBT extent pointers at
> IO completion time.
> 
> We really don't care if 4x16kB adjacent RWF_ATOMIC writes are
> submitted as 1x64kB REQ_ATOMIC IO or 4 individual 16kB REQ_ATOMIC
> IOs. The former is much more efficient from an IO perspective, and
> the COW path can actually optimise for this because it can track the
> atomic write ranges in cache exactly. If the range is larger (or
> unaligned) than what REQ_ATOMIC can handle, we use COW writeback to
> optimise for maximum writeback bandwidth, otherwise we use
> REQ_ATOMIC to optimise for minimum writeback submission and
> completion overhead...

Okay IIUC, you are suggesting that, instead of tracking the atomic
ranges in page cache and ifs, lets move that to the filesystem, for
example in XFS we can:

1. In write iomap_begin path, for RWF_ATOMIC, create a COW extent and
mark it as atomic. 

2. Carry on with the memcpy to folio and finish the write path.

3. During writeback, at XFS can detect that there is a COW atomic
extent. It can then:
  3.1 See that it is an overlap that can be done with REQ_ATOMIC
	directly 
	3.2 Else, finish the atomic IO in software emulated way just like we
	do for direct IO currently.

I believe the above example with XFS can also be extended to a FS like
ext4 without needing COW range, as long as we can ensure that we always
meet the conditions for REQ_ATOMIC during writeback (example by using
bigalloc for aligned extents and being careful not to cross the atomic
write limits)

> 
> IOWs, I think that for XFS (and other COW-capable filesystems) we
> should be looking at optimising the COW IO path to use REQ_ATOMIC
> where appropriate to create a direct overwrite fast path for
> RWF_ATOMIC buffered writes. This seems a more natural and a lot less
> intrusive than trying to blast through the page caceh abstractions
> to directly couple userspace IO boundaries to physical writeback IO
> boundaries...

I agree that this approach avoids bloating the page cache and ifs layers
with RWF_ATOMIC implementation details. That being said, the task of
managing the atomic ranges is now pushed down to the FS and is no longer
generic which might introduce friction in onboarding of new FSes in the
future. Regardless, from the discussion, I believe at this point we are
okay to make that trade-off.

Let me take some time to look into the XFS COW paths and try to implement
this approach. Thanks for the suggestion!

Regards,
ojaswin

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

