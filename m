Return-Path: <linux-fsdevel+bounces-68442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC7AC5C469
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 074203623F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D7D306482;
	Fri, 14 Nov 2025 09:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O23AHUJz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BA12F6164;
	Fri, 14 Nov 2025 09:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112074; cv=none; b=aeGOfFJiKGG+eWrcUKVS5QVPDslDuBf5ircc5/TSycO17zmrIXiuGgFD/5Yf6FTd6Lo8v7qcjvbQFGVMDuhdIrTof2C8MAufafAyU72RN+09XZD7ewS7wMOx+hiVSePmofqHvgnbeWdRGqFkR5FP/M0ajSGsxuY9uSz0gz6mnVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112074; c=relaxed/simple;
	bh=tLXs6QGR6tyfdtQa9CRonCTGW8w8q5P9WL7FJ71aNiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBFEwZ2+kZTfRviPCqAzbZ5UPp4dZMUTW73ba9kY22+vTQc5r8EIBhRE57WXzvMnHLKHxFx/mr74lJhffn1ErB/Rmk8VUIQeQTR/C8CEL0M5UvJHIh1k38Og9shvYlCqpeacwecU1eMGQ+FX5yBjV1rHUir2qGVUdPm0W6QUD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O23AHUJz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADMlP0P000482;
	Fri, 14 Nov 2025 09:20:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=qeHXUYMFSy8eRy5hcdz09NbECVSzhU
	F3RPksa1OX55Y=; b=O23AHUJz7ranXNGFgaqbiPJtfqqV1CiruQIzwI/JynZgWW
	a579AwNYFprV3BVB3XZXRk2K7mQpx4Rj77oF/JDot6EjlcIqCW2AVD2zHXyZ1FMT
	yVHGyq+vCOUiF/TaBZ20Xism4LSu2geobF55yMydsG7EgsAMdc/1YycnUlfATfrB
	YR2tKE2Qgbfq/qWFPGDJCUab9xCXx4A1kJ03/vwsRnqnVuGYGRgehbyHXqmnEUXl
	gnwcWVijQ9oEgVcuqArSQlB8U6Hfe6rKUZ1xEsl6cj/EzfUm4w4ihsPrBepInGRD
	BSIaGCr6XMAzRyXxBhwNnBmiXzI9KzjaxkqcdTcA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4adrechv90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 09:20:35 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AE9CBA8001006;
	Fri, 14 Nov 2025 09:20:35 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4adrechv8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 09:20:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AE8tXwm011441;
	Fri, 14 Nov 2025 09:20:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajw1t53e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 09:20:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AE9KWVK58327466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 09:20:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 100F620040;
	Fri, 14 Nov 2025 09:20:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F74420043;
	Fri, 14 Nov 2025 09:20:27 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.212.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Nov 2025 09:20:27 +0000 (GMT)
Date: Fri, 14 Nov 2025 14:50:25 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, willy@infradead.org,
        dchinner@redhat.com, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz,
        nilay@linux.ibm.com, martin.petersen@oracle.com, rostedt@goodmis.org,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
Message-ID: <aRb0WQJi4rQQ-Zmo@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
 <aRUCqA_UpRftbgce@dread.disaster.area>
 <20251113052337.GA28533@lst.de>
 <87frai8p46.ritesh.list@gmail.com>
 <aRWzq_LpoJHwfYli@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRWzq_LpoJHwfYli@dread.disaster.area>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rsuUkEddEYzblp7K82O2A1ALKBX7yvA8
X-Proofpoint-ORIG-GUID: Hwgk37d6V1PX3jo4iq9ZXuUVV9Bmk7Vr
X-Authority-Analysis: v=2.4 cv=RrzI7SmK c=1 sm=1 tr=0 ts=6916f463 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=07d9gI8wAAAA:8 a=7-415B0cAAAA:8 a=wh1SXWFTCzeTCxTICb8A:9 a=CjuIK1q_8ugA:10
 a=e2CUPOnPG4QKp8I52DXD:22 a=biEYGPWJfzWAr4FL6Ov7:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OSBTYWx0ZWRfX150420s1nCiX
 7qQ5hJedJunqCODNeKz66X70QQJ0LdWGXEnS/cA0XqkCNH2SP6XgX8Za4MDcxPoAWtbbtILRwcB
 tw/ZL5uast4uLcZwLLG/LC/BW7p0HDcasm4eXCM3ZODuI6iR+lslaRCML7uH/FD39jel9jU+9FL
 hxRGc0iBPZWU19T7ldVHN6v42CtZsIUo6FnMu9EBibki21TQwsg9b4Vq8WtHn1xtyJhuYevVf5n
 8N2BBPcReUx/ag+siORfb773p08hMhPx3PIMzKnbsWnTVLVvR78TAdhnbyzCV3z2QU/e/R4Vas+
 TRC30GJfiU9nnGT4eYsKgornUKStXENev/cBPIBjMh5EVNLqnIP2VrJhouYE8IhZoU05bs+iYN3
 NI9ZnxRP9FjDNvPYlI1m0afTz8CgOw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511130179

On Thu, Nov 13, 2025 at 09:32:11PM +1100, Dave Chinner wrote:
> On Thu, Nov 13, 2025 at 11:12:49AM +0530, Ritesh Harjani wrote:
> > Christoph Hellwig <hch@lst.de> writes:
> > 
> > > On Thu, Nov 13, 2025 at 08:56:56AM +1100, Dave Chinner wrote:
> > >> On Wed, Nov 12, 2025 at 04:36:03PM +0530, Ojaswin Mujoo wrote:
> > >> > This patch adds support to perform single block RWF_ATOMIC writes for
> > >> > iomap xfs buffered IO. This builds upon the inital RFC shared by John
> > >> > Garry last year [1]. Most of the details are present in the respective 
> > >> > commit messages but I'd mention some of the design points below:
> > >> 
> > >> What is the use case for this functionality? i.e. what is the
> > >> reason for adding all this complexity?
> > >
> > > Seconded.  The atomic code has a lot of complexity, and further mixing
> > > it with buffered I/O makes this even worse.  We'd need a really important
> > > use case to even consider it.
> > 
> > I agree this should have been in the cover letter itself. 
> > 
> > I believe the reason for adding this functionality was also discussed at
> > LSFMM too...  
> > 
> > For e.g. https://lwn.net/Articles/974578/ goes in depth and talks about
> > Postgres folks looking for this, since PostgreSQL databases uses
> > buffered I/O for their database writes.
> 
> Pointing at a discussion about how "this application has some ideas
> on how it can maybe use it someday in the future" isn't a
> particularly good justification. This still sounds more like a
> research project than something a production system needs right now.

Hi Dave, Christoph,

There were some discussions around use cases for buffered atomic writes
in the previous LSFMM covered by LWN here [1]. AFAIK, there are 
databases that recommend/prefer buffered IO over direct IO. As mentioned
in the article, MongoDB being one that supports both but recommends
buffered IO. Further, many DBs support both direct IO and buffered IO
well and it may not be fair to force them to stick to direct IO to get
the benefits of atomic writes.

[1] https://lwn.net/Articles/1016015/
> 
> Why didn't you use the existing COW buffered write IO path to
> implement atomic semantics for buffered writes? The XFS
> functionality is already all there, and it doesn't require any
> changes to the page cache or iomap to support...

This patch set focuses on HW accelerated single block atomic writes with
buffered IO, to get some early reviews on the core design.

Just like we did for direct IO atomic writes, the software fallback with
COW and multi block support can be added eventually.

Regards,
ojaswin

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

