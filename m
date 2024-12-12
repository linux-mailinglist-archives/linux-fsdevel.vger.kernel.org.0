Return-Path: <linux-fsdevel+bounces-37155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C3A9EE63B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 13:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61B71882509
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 12:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35C7216E2B;
	Thu, 12 Dec 2024 12:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LZrLrdTZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ADD21577D;
	Thu, 12 Dec 2024 12:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004920; cv=none; b=dn0/OZje+JhPzduhye/I2Z3RUf2jT/L1J9z47vdE/LSctwogDM2AYe9XMUVKpX6/Jm7IB1vxcFU82ExjQgPa0WKNZP5dplrbzxJqssqoqDnXzgF34ulrAbvsqRD9EC8Cq8K/mWg6tC79g2Rpo45dzNfFb4/K815x6x13BoYjLTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004920; c=relaxed/simple;
	bh=oxrCOLeKzuBBTX19y5H+zypH4b02mKV3KfmmQV0JUpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOk3MaJ3VaN8EietAssTSvtvAv40YdxldYhRZ3JMy14vyFVyTuOLUmVLTOZhrEybiS9HW87H0leULatWwn+il6btteTUVZrQArAOk7v6LSbiBk/2NhXTwUzlvhr/tfApssw9H+NLymmK0Fo/vUwtHPfWswA2l4onZ2ZLOKCFn6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LZrLrdTZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC71xh2013689;
	Thu, 12 Dec 2024 12:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=uMdurywD9XjfCVrf9DXjLrwRuO8D79
	jzPa3O78TCAY0=; b=LZrLrdTZ+8P+MSpL57Sl91yMtXGslhY0ZrDP9MyaL+aSSu
	/lBMWQIzpuPbnJ2cZBvnFaHG8vA6DiAknfX9w4dCC8gqw4ZR38cZQ+XgyNMooLxg
	8fy13jPASkSxBvA96Zgqi0Sn9Ioz691nASAYZbqKqytVe9eEELHej5ZwL/aR6Ogr
	FUAARSlZlEQQ+iUlumspRhrFyuCTaSFvPxejTmR5GT1gJUzc0URFoLNpB4acPYQh
	+fzS1snBITtTCvtDq/XSnK0lc86N9BTQKCgtCxboeIRcEMYrFYDzQEJDZqOhQx2O
	jqAf8RhVFw5z/zwyDnJU4MSrBb7ooA2qpMK7pxJw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce3941yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 12:01:53 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BCBvTJD015036;
	Thu, 12 Dec 2024 12:01:52 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce3941ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 12:01:52 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC9bOQj032739;
	Thu, 12 Dec 2024 12:01:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0psrdmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 12:01:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BCC1oKr27329260
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 12:01:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FEC220043;
	Thu, 12 Dec 2024 12:01:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7944120040;
	Thu, 12 Dec 2024 12:01:48 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Dec 2024 12:01:48 +0000 (GMT)
Date: Thu, 12 Dec 2024 17:31:43 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 2/3] xfs_io: Add ext4 support to show FS_IOC_FSGETXATTR
 details
Message-ID: <Z1rQp8UZz9s+BQM1@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <3b4b9f091519d2b2085888d296888179da3bdb73.1733902742.git.ojaswin@linux.ibm.com>
 <20241211181706.GB6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211181706.GB6678@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ssASAEAzaYTugZioFGIun2jM2YWnwWiA
X-Proofpoint-ORIG-GUID: dyRRgAjLFpmkAJwRg7MJK9C-pSv7S3LU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=933
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120086

On Wed, Dec 11, 2024 at 10:17:06AM -0800, Darrick J. Wong wrote:
> On Wed, Dec 11, 2024 at 01:24:03PM +0530, Ojaswin Mujoo wrote:
> > Currently with stat we only show FS_IOC_FSGETXATTR details
> > if the filesystem is XFS. With extsize support also coming
> > to ext4 make sure to show these details when -c "stat" or "statx"
> > is used.
> > 
> > No functional changes for filesystems other than ext4.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  io/stat.c | 38 +++++++++++++++++++++-----------------
> >  1 file changed, 21 insertions(+), 17 deletions(-)
> > 
> > diff --git a/io/stat.c b/io/stat.c
> > index 326f2822e276..d06c2186cde4 100644
> > --- a/io/stat.c
> > +++ b/io/stat.c
> > @@ -97,14 +97,14 @@ print_file_info(void)
> >  		file->flags & IO_TMPFILE ? _(",tmpfile") : "");
> >  }
> >  
> > -static void
> > -print_xfs_info(int verbose)
> > +static void print_extended_info(int verbose)
> >  {
> > -	struct dioattr	dio;
> > -	struct fsxattr	fsx, fsxa;
> > +	struct dioattr dio;
> > +	struct fsxattr fsx, fsxa;
> > +	bool is_xfs_fd = platform_test_xfs_fd(file->fd);
> >  
> > -	if ((xfsctl(file->name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > -	    (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
> > +	if ((ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > +		(is_xfs_fd && (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa) < 0))) {
> 
> Urgh... perhaps we should call FS_IOC_FSGETXATTR and if it returns zero
> print whatever is returned, no matter what filesystem we think is
> feeding us information?
> 
> e.g.
> 
> 	if (ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> 		if (is_xfs_fd || (errno != EOPNOTSUPP &&
> 				  errno != ENOTTY))
> 			perror("FS_IOC_GETXATTR");
> 	} else {
> 		printf(_("fsxattr.xflags = 0x%x "), fsx.fsx_xflags);
> 		...
> 	}
> 
> 	if (ioctl(file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
> 		if (is_xfs_fd || (errno != EOPNOTSUPP &&
> 				  errno != ENOTTY))
> 			perror("XFS_IOC_FSGETXATTRA");
> 	} else {
> 		printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
> 	}
> 
> That way we don't have to specialcase platform_test_*_fd() for every
> other filesystem that might want to return real fsxattr results?
> Same idea for DIOINFO.

Hi Darrick, thanks for the review.

I agree that this looks like a more modular approach, I'll make the
change. IIUC we basically want to perform the ioctls regardless of the
FS and then handle the error/output accordingly here so that we wont need the 

    if (file->flags & IO_FOREIGN && !platform_test_ext4_fd(file->fd))
            return 0;

line in the stat functions, right?

Also, with the suggested approach the user visible behavior might change
subtly because earlier we used to fail if either FSGETXATTR or
FGGETXATTRA failed but now theres a slim chance that we might print the
output partially. It might not be a very big deal but just thought I'd
point out.

Regards,
ojaswin

> 
> --D
> 
> >  		perror("FS_IOC_FSGETXATTR");
> >  	} else {
> >  		printf(_("fsxattr.xflags = 0x%x "), fsx.fsx_xflags);
> > @@ -113,14 +113,18 @@ print_xfs_info(int verbose)
> >  		printf(_("fsxattr.extsize = %u\n"), fsx.fsx_extsize);
> >  		printf(_("fsxattr.cowextsize = %u\n"), fsx.fsx_cowextsize);
> >  		printf(_("fsxattr.nextents = %u\n"), fsx.fsx_nextents);
> > -		printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
> > +		if (is_xfs_fd)
> > +			printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
> >  	}
> > -	if ((xfsctl(file->name, file->fd, XFS_IOC_DIOINFO, &dio)) < 0) {
> > -		perror("XFS_IOC_DIOINFO");
> > -	} else {
> > -		printf(_("dioattr.mem = 0x%x\n"), dio.d_mem);
> > -		printf(_("dioattr.miniosz = %u\n"), dio.d_miniosz);
> > -		printf(_("dioattr.maxiosz = %u\n"), dio.d_maxiosz);
> > +
> > +	if (is_xfs_fd) {
> > +		if ((xfsctl(file->name, file->fd, XFS_IOC_DIOINFO, &dio)) < 0) {
> > +			perror("XFS_IOC_DIOINFO");
> > +		} else {
> > +			printf(_("dioattr.mem = 0x%x\n"), dio.d_mem);
> > +			printf(_("dioattr.miniosz = %u\n"), dio.d_miniosz);
> > +			printf(_("dioattr.maxiosz = %u\n"), dio.d_maxiosz);
> > +		}
> >  	}
> >  }
> >  
> > @@ -167,10 +171,10 @@ stat_f(
> >  		printf(_("stat.ctime = %s"), ctime(&st.st_ctime));
> >  	}
> >  
> > -	if (file->flags & IO_FOREIGN)
> > +	if (file->flags & IO_FOREIGN && !platform_test_ext4_fd(file->fd))
> >  		return 0;
> >  
> > -	print_xfs_info(verbose);
> > +	print_extended_info(verbose);
> >  
> >  	return 0;
> >  }
> > @@ -440,10 +444,10 @@ statx_f(
> >  				ctime((time_t *)&stx.stx_btime.tv_sec));
> >  	}
> >  
> > -	if (file->flags & IO_FOREIGN)
> > +	if (file->flags & IO_FOREIGN && !platform_test_ext4_fd(file->fd))
> >  		return 0;
> >  
> > -	print_xfs_info(verbose);
> > +	print_extended_info(verbose);
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.43.5
> > 
> > 

