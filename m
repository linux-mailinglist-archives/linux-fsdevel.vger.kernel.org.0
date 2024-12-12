Return-Path: <linux-fsdevel+bounces-37157-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1519EE64A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20478167C9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15368212B2A;
	Thu, 12 Dec 2024 12:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fYOOdp9y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB788210F5E;
	Thu, 12 Dec 2024 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734005117; cv=none; b=jhGmb2AB7t9aIGnIIibyA3BjRtWD04/ZltFenRvv57WTJrGkBdDNFxgb76wpL5MmaC9mObb7URO7mo0kKNsMILztIJG+WbBRTY1WG5GGsGOsChZfRjKnjKYnmDuH9qN80Yw1JUuw+9oFaop1JmcPf/c+hBUWPQMKfLoz1JM5BAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734005117; c=relaxed/simple;
	bh=dczLnZD9ji8Trn9VosWQYezAvBkKMhVWPVVwWcNhnZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D51Vgu6A4ACHNJwnuGYILlTYRpDr6Vt+fYrA77dF7k9RCEELR2V8wIYJvU5hFet9eupTZv7aC9V8ftkOre/4K8sqwdIefEdsFqyNBJxPPWwv6xoKqiHOxBr3+J5BQx1LbkhtejoxMKAEFCqPzVT0e/zVGYiqPeow0GiPKOpTLKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fYOOdp9y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC7HOWv012053;
	Thu, 12 Dec 2024 12:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2a3k1mkd0XcuQRayXOuU+WcpNVU7Q/
	sxbzZYUDe0PV8=; b=fYOOdp9yuiOKakr7DVaDTJGGKj1r2LlGVTzdPHZy7lc3GL
	k4F9y0sdCU94hbvGAvTLZo1bOG4l0eBbtIHC3DZnaPz7OQvtmNxhem/5zbYyFEZt
	531SN8vtBjcWLFdsKqIYCQgRXVzr3egaxMxDf3c6uSre4sCoLsdWYy1TgJyYfeBQ
	lxWWPeSFIleHkwOaLGarEgxMKuNCLPPEI632SBKMK32G0SH3znW8RWkSKeWXDC+h
	HblqSjg3fZRrdWB2XWq2TRc6EGWnUzvI7Ty/ekXKNX91Hq2eVKLqB1absHy3lb3Q
	R8mWgOlcxWD0K+Qxcg99i6PyTvWTuCz1UZhHW6MQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce3942g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 12:05:11 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BCC4sIs001959;
	Thu, 12 Dec 2024 12:05:11 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce3942fw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 12:05:10 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCBVfcd017421;
	Thu, 12 Dec 2024 12:05:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1yv9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 12:05:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BCC58vG64291274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 12:05:08 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4201620040;
	Thu, 12 Dec 2024 12:05:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF7DE2004B;
	Thu, 12 Dec 2024 12:05:06 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Dec 2024 12:05:06 +0000 (GMT)
Date: Thu, 12 Dec 2024 17:35:04 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 1/3] include/linux.h: Factor out generic
 platform_test_fs_fd() helper
Message-ID: <Z1rRcFbDR4IbjyVl@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <5996d6854a16852daca5977063af6f2af2f0f4ca.1733902742.git.ojaswin@linux.ibm.com>
 <20241211180902.GA6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211180902.GA6678@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FN5KEreYSzSgbTaaoJ1nGUk6XxbA0WAO
X-Proofpoint-ORIG-GUID: TKdWiGCsZquPg3lnTsMpmCa3OJxrf8_L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=831
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120086

On Wed, Dec 11, 2024 at 10:09:02AM -0800, Darrick J. Wong wrote:
> On Wed, Dec 11, 2024 at 01:24:02PM +0530, Ojaswin Mujoo wrote:
> > Factor our the generic code to detect the FS type out of
> > platform_test_fs_fd(). This can then be used to detect different file
> > systems types based on magic number.
> > 
> > Also, add a helper to detect if the fd is from an ext4 filesystem.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  include/linux.h | 25 +++++++++++++++++--------
> >  1 file changed, 17 insertions(+), 8 deletions(-)
> > 
> > diff --git a/include/linux.h b/include/linux.h
> > index e9eb7bfb26a1..52c64014c57f 100644
> > --- a/include/linux.h
> > +++ b/include/linux.h
> > @@ -43,13 +43,7 @@ static __inline__ int xfsctl(const char *path, int fd, int cmd, void *p)
> >  	return ioctl(fd, cmd, p);
> >  }
> >  
> > -/*
> > - * platform_test_xfs_*() implies that xfsctl will succeed on the file;
> > - * on Linux, at least, special files don't get xfs file ops,
> > - * so return 0 for those
> > - */
> > -
> > -static __inline__ int platform_test_xfs_fd(int fd)
> > +static __inline__ int platform_test_fs_fd(int fd, long type)
> >  {
> >  	struct statfs statfsbuf;
> >  	struct stat statbuf;
> > @@ -60,7 +54,22 @@ static __inline__ int platform_test_xfs_fd(int fd)
> >  		return 0;
> >  	if (!S_ISREG(statbuf.st_mode) && !S_ISDIR(statbuf.st_mode))
> >  		return 0;
> > -	return (statfsbuf.f_type == 0x58465342);	/* XFSB */
> > +	return (statfsbuf.f_type == type);
> > +}
> > +
> > +/*
> > + * platform_test_xfs_*() implies that xfsctl will succeed on the file;
> > + * on Linux, at least, special files don't get xfs file ops,
> > + * so return 0 for those
> > + */
> > +static __inline__ int platform_test_xfs_fd(int fd)
> > +{
> > +	return platform_test_fs_fd(fd, 0x58465342); /* XFSB */
> > +}
> > +
> > +static __inline__ int platform_test_ext4_fd(int fd)
> > +{
> > +	return platform_test_fs_fd(fd, 0xef53); /* EXT4 magic number */
> 
> Should this be pulling EXT4_SUPER_MAGIC from linux/magic.h?

Oh right, thanks for pointing out. I'll use that for the magic numbers.

Thanks,
ojaswin

> 
> --D
> 
> >  }
> >  
> >  static __inline__ int platform_test_xfs_path(const char *path)
> > -- 
> > 2.43.5
> > 
> > 

