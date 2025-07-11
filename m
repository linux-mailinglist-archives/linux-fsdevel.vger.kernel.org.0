Return-Path: <linux-fsdevel+bounces-54654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E675FB01E84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 16:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0121A1CC0977
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 14:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0972D46A0;
	Fri, 11 Jul 2025 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AyP2paRy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0657345948;
	Fri, 11 Jul 2025 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242491; cv=none; b=soLzqQisGLYlSl923dN3Fw+q3dAQqgDKA9yTkNYzcVO9jkdGjuypyB3zZwz2CqQCy3Sa9KzHHdp3PAMXF4Sd0fUlm+2uC+X/tbuhuUV4B340W3kG7KN6eF1rsDxXAJZrVyqrh0sfPGZgTV2Cge4lrbbVt+cpPCKkzgqRf3w9+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242491; c=relaxed/simple;
	bh=D9FK4N3hM4sbjnM/Ff4mnlQAXWongJe55IDek2YkNW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PEw8hwwFGpqmcc5JbzoGjHFbExpuTLJmoGcFsgK4+QJTTb1FPZJhBBjMyp0lYFYRbaFrK/bnIk+MnlhP9oX2hJy0twuL4hJy1yMja5tYyVYJKNyp2ju53qVStnf6ipL17gSzeCHYZ+kNwaIOp3Lij2RkAJSWPMvRmu2tMnjy/18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AyP2paRy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB7eVO015362;
	Fri, 11 Jul 2025 14:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=D/TxXPoBPeCkGtl2Jec4I0MqJ5jitp
	2Yb5CeKqPQMiY=; b=AyP2paRyw61iAW85rXNDcBnsH5mM9p3O3poZgHa32APo6W
	ZfQJaHgK0nB04JjRx/dEvEvmlj4qTYy5FRaq0TrwQ2Hh+ih2wmGlJFThQCP/M7qL
	Ba593mq3fjgd5d1hgWHCtVeySYi4E/UbQUJt69hH0Pkl+AtTOVujWnIDwYgEG0wt
	ngP/RXfm4Do1zm5z0QFNo3nP8TphyhDfo8/wWbhczxqHojbeB83cXmCaL9ax/umA
	0beyGtpYecB/rpVt5/25XpIrK0uGNFStRlb9z2B2DJjQvIMPvOoZrCM0uvxte5Q0
	5JlEK8qdzZVKxl9DpZ5M+zu9UK7iP3218OMxDZOw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47t3xdh9kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 14:01:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56BA8WA6021561;
	Fri, 11 Jul 2025 14:01:17 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47qecu37e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 14:01:17 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56BE1FBM34800170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 14:01:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 985E720043;
	Fri, 11 Jul 2025 14:01:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 068D620040;
	Fri, 11 Jul 2025 14:01:15 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown [9.87.156.131])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 11 Jul 2025 14:01:14 +0000 (GMT)
Date: Fri, 11 Jul 2025 16:01:13 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Paul Moore <paul@paul-moore.com>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v1 1/1] fs: Fix use of incorrect flags with splice() on
 pipe from/to memfd
Message-ID: <aHEZKb-kdpIjABQu@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <20250708154352.3913726-1-japo@linux.ibm.com>
 <20250710-geburt-aufbegehren-07813aabf939@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-geburt-aufbegehren-07813aabf939@brauner>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NPKe22MGOaSS_tJqN0PlMQVzjMIMgC2c
X-Authority-Analysis: v=2.4 cv=MLRgmNZl c=1 sm=1 tr=0 ts=6871192e cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=K96QQe1A4WfBV4HAJsgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: NPKe22MGOaSS_tJqN0PlMQVzjMIMgC2c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA5OCBTYWx0ZWRfXxLECziYPmq2f Nw1AvJLsTETGdj0VEwpauH6SPtQTgYh5xZC06uood2TUvFKi4QwZTs1nKz+3DNeGsq3hrJ/tTlI INHqH4EV/mHJ3AvlYPD71xU7dfzwdkqD8d5fGn6hyR5V0OUAvjFfBYsc9POZy9Q5LoIKDOIAuAt
 x5t7xctFFr0dwWpTgr9yuZERpVV+FkzeXGm0tOPfQsqUr1RuGCGHx5jhtVa3m+cgMVUbJWjGaun AR9sDqBBsW1A5RYkM2cH5PVwF497s9tfWNzC+cEqtdIR+cYie9fhUv3OrhtvRByLheZgtWk0Gi9 6fKg4mkAe0xkU+O9q2KjlD4SRdT7crsv3i5a9TxqAkg55mh0BrNXz6T2gETizGKJTxn/1/clsRM
 JGyvrfiRRM5Acx5yMCrulhx1LLFBqhMn8soZfNctMptgZ7wBfBjJCxOA5RPps0N4XPMM7zuA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 mlxlogscore=627 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110098

On Thu, Jul 10, 2025 at 01:34:12PM +0200, Christian Brauner wrote:
> On Tue, Jul 08, 2025 at 05:43:52PM +0200, Jan Polensky wrote:
> > Fix use of incorrect flags when using splice() with pipe ends and
[skip]
> > +	}
>
> That hides secret memory inodes from LSMs which is the exact opposite of
> what the original commit was there to fix. I'm pretty sure that the
> EACCES comes from the LSM layer because the relevant refpolicy or
> however that works hasn't been updated to allow secret memory files to
> use splice().
>
> This is a chicken-and-egg problem withy anything that strips S_PRIVATE
> from things that were previously S_PRIVATE.
Yes, agree. I've already send a fix to LTP.
Thank you for your reply.

