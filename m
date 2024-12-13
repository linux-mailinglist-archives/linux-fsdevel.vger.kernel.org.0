Return-Path: <linux-fsdevel+bounces-37352-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F203F9F14F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 19:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98AD2851B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2024 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B721E883A;
	Fri, 13 Dec 2024 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aeLjx8eZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391E8157E9F;
	Fri, 13 Dec 2024 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114566; cv=none; b=YlAZJd58oCCdde/NqZ/MkcoL11fEPzBYXh5SsbcHc7bFcURd0Dw7xpOY8NtDFxYnOor4b5DEYp2+dvVriR1L3LtOMhIOzw2CpVRrl4jtFZxSwDSsAk4lOTX5xw6EHnOnJEurScLEwpja+aqvdads9/PV1dlUwnfJdZsd/X0Rjdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114566; c=relaxed/simple;
	bh=JVk5RdH8jUY4kclcX+pZWMZJSGLYenDeELwKRHs+pww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZ7Wte/AvgipTNr3XsVwUHFlSxDGxjc8NCXf+Amn2/3psQ6TGt4b6M1YkOI2hrF4sZfZKrRvBuGcoasi3GOz6//5JMj6TVNpxfGb53ah7DKB5wn+crYHVg/1qrLFbnnfp6dofWhgI0VwReWt6KW4oy6uGWWWqNE+NVZfAuk3EYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aeLjx8eZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDGfHWp013504;
	Fri, 13 Dec 2024 18:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=kBEckMknow7qlqB7AuvJ+bg9JaWDEl
	7eJi82f+le/Yg=; b=aeLjx8eZE4KR3bM34UExhpQfXWiMz8ttVEL7RURn2gVYZz
	BHBH6YNXObak7i5IJQtW1ZvMntNj0Ly7O/3YCxICRRPZkQD+CGO3m/nrMJ5/SHec
	PqVr/C3edGpHI5LjlPuAfl01cHLGKV76iWiuucm0FfkjpegVMA4YLMrVLrd2alK1
	mLRQmTyexr/V2bdYuNwi79NtrYtB1e1R/pxjhB9IVD4Dnkc9lL8wuw8CeFRIUu0I
	ZNcAWoN5akCVVKa186EyXFTNs7Ib6z5M6B8w0d5QQcW694o4lZUMfU8ruoRodyM/
	/LsUkxJjRX+BBueIT1iAUn+7TP8b5hSnXy05I6cw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gh43atmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 18:29:17 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BDIICvN013542;
	Fri, 13 Dec 2024 18:29:17 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gh43atmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 18:29:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDFoJJu016926;
	Fri, 13 Dec 2024 18:29:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12yqekm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 18:29:16 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDITEo931195732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 18:29:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DED820040;
	Fri, 13 Dec 2024 18:29:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE9762004B;
	Fri, 13 Dec 2024 18:29:12 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.39.19.196])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 13 Dec 2024 18:29:12 +0000 (GMT)
Date: Fri, 13 Dec 2024 23:59:08 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrey Albershteyn <aalbersh@kernel.org>,
        John Garry <john.g.garry@oracle.com>
Subject: Re: [RFC 2/3] xfs_io: Add ext4 support to show FS_IOC_FSGETXATTR
 details
Message-ID: <Z1x89DDTQBcFenIp@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1733902742.git.ojaswin@linux.ibm.com>
 <3b4b9f091519d2b2085888d296888179da3bdb73.1733902742.git.ojaswin@linux.ibm.com>
 <20241211181706.GB6678@frogsfrogsfrogs>
 <Z1oTOUCui9vTgNoM@dread.disaster.area>
 <20241212161919.GA6657@frogsfrogsfrogs>
 <Z1tLEQmRiZc7alBo@dread.disaster.area>
 <20241212210758.GN6678@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212210758.GN6678@frogsfrogsfrogs>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YnCrpXNBGC2P26eHjN6KYQ9IC9UU7XIM
X-Proofpoint-GUID: NGxKQ3L5CjdOOvxeHRaItP2CjJmu3Htd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130131

On Thu, Dec 12, 2024 at 01:07:58PM -0800, Darrick J. Wong wrote:
> On Fri, Dec 13, 2024 at 07:44:01AM +1100, Dave Chinner wrote:
> > On Thu, Dec 12, 2024 at 08:19:19AM -0800, Darrick J. Wong wrote:
> > > On Thu, Dec 12, 2024 at 09:33:29AM +1100, Dave Chinner wrote:
> > > > On Wed, Dec 11, 2024 at 10:17:06AM -0800, Darrick J. Wong wrote:
> > > > > On Wed, Dec 11, 2024 at 01:24:03PM +0530, Ojaswin Mujoo wrote:
> > > > > > Currently with stat we only show FS_IOC_FSGETXATTR details
> > > > > > if the filesystem is XFS. With extsize support also coming
> > > > > > to ext4 make sure to show these details when -c "stat" or "statx"
> > > > > > is used.
> > > > > > 
> > > > > > No functional changes for filesystems other than ext4.
> > > > > > 
> > > > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > > > > ---
> > > > > >  io/stat.c | 38 +++++++++++++++++++++-----------------
> > > > > >  1 file changed, 21 insertions(+), 17 deletions(-)
> > > > > > 
> > > > > > diff --git a/io/stat.c b/io/stat.c
> > > > > > index 326f2822e276..d06c2186cde4 100644
> > > > > > --- a/io/stat.c
> > > > > > +++ b/io/stat.c
> > > > > > @@ -97,14 +97,14 @@ print_file_info(void)
> > > > > >  		file->flags & IO_TMPFILE ? _(",tmpfile") : "");
> > > > > >  }
> > > > > >  
> > > > > > -static void
> > > > > > -print_xfs_info(int verbose)
> > > > > > +static void print_extended_info(int verbose)
> > > > > >  {
> > > > > > -	struct dioattr	dio;
> > > > > > -	struct fsxattr	fsx, fsxa;
> > > > > > +	struct dioattr dio;
> > > > > > +	struct fsxattr fsx, fsxa;
> > > > > > +	bool is_xfs_fd = platform_test_xfs_fd(file->fd);
> > > > > >  
> > > > > > -	if ((xfsctl(file->name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > > > > > -	    (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa)) < 0) {
> > > > > > +	if ((ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0 ||
> > > > > > +		(is_xfs_fd && (xfsctl(file->name, file->fd, XFS_IOC_FSGETXATTRA, &fsxa) < 0))) {
> > > > > 
> > > > > Urgh... perhaps we should call FS_IOC_FSGETXATTR and if it returns zero
> > > > > print whatever is returned, no matter what filesystem we think is
> > > > > feeding us information?
> > > > 
> > > > Yes, please. FS_IOC_FSGETXATTR has been generic functionality for
> > > > some time, we should treat it the same way for all filesystems.
> > > > 
> > > > > e.g.
> > > > > 
> > > > > 	if (ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> > > > > 		if (is_xfs_fd || (errno != EOPNOTSUPP &&
> > > > > 				  errno != ENOTTY))
> > > > > 			perror("FS_IOC_GETXATTR");
> > > > 
> > > > Why do we even need "is_xfs_fd" there? XFS will never give a
> > > > EOPNOTSUPP or ENOTTY error to this or the FS_IOC_GETXATTRA ioctl...
> > > 
> > > Yeah, in hindsight I don't think it's needed for FS_IOC_FSGETXATTR, but
> > 
> > *nod*
> > 
> > > it's definitely nice for XFS_IOC_FSGETXATTRA (which is not implemented
> > > outside xfs) so that you don't get unnecessary error messages on ext4.
> > 
> > I don't think we even need it for FS_IOC_GETXATTRA - if the
> > filesystem does not support that ioctl, we don't print the fields,
> > nor do we output an error.
> > 
> > After all, this "extended info" and it's only ever been printed
> > for XFS, so we can define whatever semantics we want for foreign
> > filesystem output right now. As long as XFS always prints the same
> > info as it always has (i.e. all of it), we can do whatever we want
> > with the foreign filesystem stuff.
> > 
> > Keep in mind that we don't need platform tests for XFS files - that
> > has already been done when the file was opened and the state stored
> > in file->flags via the IO_FOREIGN flag. We already use that in the
> > stat_f() to determine whether we print the "xfs info" or not.
> > 
> > IOWs, I think all we need to do is  move where we check the
> > IO_FOREIGN flag. i.e.:
> > 
> > print_extented_info(file)
> > {
> > 	struct dioattr  dio = {};
> >         struct fsxattr  fsx = {}, fsxa = {};
> > 
> > 	if (ioctl(file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
> > 		perror("FS_IOC_GETXATTR");
> > 		exitcode = 1;
> > 		return;
> > 	}
> > 
> > 	printf(_("fsxattr.xflags = 0x%x "), fsx.fsx_xflags);
> > 	printxattr(fsx.fsx_xflags, verbose, 0, file->name, 1, 1);
> > 	printf(_("fsxattr.projid = %u\n"), fsx.fsx_projid);
> > 	printf(_("fsxattr.extsize = %u\n"), fsx.fsx_extsize);
> > 	printf(_("fsxattr.cowextsize = %u\n"), fsx.fsx_cowextsize);
> > 	printf(_("fsxattr.nextents = %u\n"), fsx.fsx_nextents);
> > 
> > 	/* Only XFS supports FS_IOC_FSGETXATTRA and XFS_IOC_DIOINFO */
> > 	if (file->flags & IO_FOREIGN)
> > 		return;
> > 
> > 	if (ioctl(file->fd, FS_IOC_FSGETXATTRA, &fsxa)) < 0) {
> > 		perror("FS_IOC_GETXATTRA");
> > 		exitcode = 1;
> > 		return;
> > 	}
> > 	if ((xfsctl(file->name, file->fd, XFS_IOC_DIOINFO, &dio)) < 0) {
> > 		perror("XFS_IOC_DIOINFO");
> > 		exitcode = 1;
> > 		return;
> > 	}
> > 
> > 	printf(_("fsxattr.naextents = %u\n"), fsxa.fsx_nextents);
> > 	printf(_("dioattr.mem = 0x%x\n"), dio.d_mem);
> > 	printf(_("dioattr.miniosz = %u\n"), dio.d_miniosz);
> > 	printf(_("dioattr.maxiosz = %u\n"), dio.d_maxiosz);
> > }
> > 
> > Thoughts?
> 
> Seems fine to me, though I'd print the fsxa before trying to call
> DIOINFO.
> 
> --D

Got it, this makes sense to me as well. I'll do something like this in
v2. Thanks!

Regards,
ojaswin

> 
> > -Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
> > 

