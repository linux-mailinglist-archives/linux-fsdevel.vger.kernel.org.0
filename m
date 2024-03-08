Return-Path: <linux-fsdevel+bounces-13980-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575AF875E5C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 08:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0A41C21C7B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 07:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF914EB55;
	Fri,  8 Mar 2024 07:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L+rBuwGM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E8C4E1DC;
	Fri,  8 Mar 2024 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709882399; cv=none; b=k4cCYouyAFkGy1AhBPnSSUFJ+7YAEwx7EfG8ZOCqrluKOlwkcpsf6Xe+kMTxE8utWwXJeaRzkLIJBNNn5rz7CwswAWdJxYYs05qynIJfcdmkH/yxUCKwmWopbOTxI954XS/iz3k7njFPo6qGnBmpZgSkjTHL5jNuXoc866S1n2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709882399; c=relaxed/simple;
	bh=357MfJ9e26p5+MssqPfVRuHaEyIQzNN1PO/smLcqBAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zq9EubZfkKpt9ek/UWNQVpiActjsFq6BBsOB8DQSNczspl/IxP+Spmpe38nE1QozcApiY4IoCeApLv3v6hpHf7xX8xxW751bSsXWYgwvouyWGfpiZREW2uumJKwkk1Q//UTyGfYwu9PSuli4RZrkCAxHykK+SrnYQ+5dnJvkMc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L+rBuwGM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4286vg73030867;
	Fri, 8 Mar 2024 07:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=DacinbEWQALdubakrIQd7g1cRfgEMG5/c5O61RBr34s=;
 b=L+rBuwGMcclW1MZj0Wo7aqYNQNaChMOlKYgEna3ROYhPw104ND/41SN6X/omwsh02T8l
 i4WEwfUp2VZCI1UFQO6ijfL+Mt9eWmG/m0d7lLTMVrmiC/NkIC2PkCKNOCEEHscSK+M5
 bXfKqwUqi3X11itNPjFQYRu+PlyhPRchzh7f45Z6jPIGjGFj5rAiuWe2bsPTdGzMUr3e
 S8kzHvF9b387/yglX/pefHE6lijXv6Mg6pfhzSxvRekZaaCZK/wTlXCVKO2QS7i+3DGE
 RJc+t/ROryg8denVCbS0C0hdW+MczvCmMZWyhIlXSSVmatNfUS/bzPH8234xlcXoCbnp hg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqwv0g96d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 07:19:27 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4287CX5S002226;
	Fri, 8 Mar 2024 07:19:27 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wqwv0g965-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 07:19:27 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4287F6vs010913;
	Fri, 8 Mar 2024 07:19:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52tf7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 07:19:26 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4287JM4S35651974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 07:19:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E5CB2004B;
	Fri,  8 Mar 2024 07:19:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89AF92004D;
	Fri,  8 Mar 2024 07:19:17 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  8 Mar 2024 07:19:17 +0000 (GMT)
Date: Fri, 8 Mar 2024 12:49:13 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Dave Chinner <david@fromorbit.com>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        John Garry <john.g.garry@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/8] fs: Reserve inode flag FS_ATOMICWRITES_FL for atomic
 writes
Message-ID: <Zeq78Ud5AJ+w2Atj@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
 <4c687c1c5322b4eaf0bb173f0b5d58b38fdaa847.1709361537.git.ritesh.list@gmail.com>
 <ZeUc1ipKMrh+pOn6@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeUc1ipKMrh+pOn6@dread.disaster.area>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QB3bg-oUgrbEE8YWM7dsSu48CL-Cpwms
X-Proofpoint-ORIG-GUID: fayCa-oKvr-9Tqy4-stvhPAL3Ce9ibt-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_05,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 mlxlogscore=999 phishscore=0 impostorscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080056

On Mon, Mar 04, 2024 at 11:59:02AM +1100, Dave Chinner wrote:
> On Sat, Mar 02, 2024 at 01:11:59PM +0530, Ritesh Harjani (IBM) wrote:
> > This reserves FS_ATOMICWRITES_FL for flags and adds support in
> > fileattr to support atomic writes flag & xflag needed for ext4
> > and xfs.
> > 
> > Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > ---
> >  fs/ioctl.c               | 4 ++++
> >  include/linux/fileattr.h | 4 ++--
> >  include/uapi/linux/fs.h  | 1 +
> >  3 files changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/ioctl.c b/fs/ioctl.c
> > index 76cf22ac97d7..e0f7fae4777e 100644
> > --- a/fs/ioctl.c
> > +++ b/fs/ioctl.c
> > @@ -481,6 +481,8 @@ void fileattr_fill_xflags(struct fileattr *fa, u32 xflags)
> >  		fa->flags |= FS_DAX_FL;
> >  	if (fa->fsx_xflags & FS_XFLAG_PROJINHERIT)
> >  		fa->flags |= FS_PROJINHERIT_FL;
> > +	if (fa->fsx_xflags & FS_XFLAG_ATOMICWRITES)
> > +		fa->flags |= FS_ATOMICWRITES_FL;
> >  }
> >  EXPORT_SYMBOL(fileattr_fill_xflags);
> >  
> > @@ -511,6 +513,8 @@ void fileattr_fill_flags(struct fileattr *fa, u32 flags)
> >  		fa->fsx_xflags |= FS_XFLAG_DAX;
> >  	if (fa->flags & FS_PROJINHERIT_FL)
> >  		fa->fsx_xflags |= FS_XFLAG_PROJINHERIT;
> > +	if (fa->flags & FS_ATOMICWRITES_FL)
> > +		fa->fsx_xflags |= FS_XFLAG_ATOMICWRITES;
> >  }
> >  EXPORT_SYMBOL(fileattr_fill_flags);
> >  
> > diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
> > index 47c05a9851d0..ae9329afa46b 100644
> > --- a/include/linux/fileattr.h
> > +++ b/include/linux/fileattr.h
> > @@ -7,12 +7,12 @@
> >  #define FS_COMMON_FL \
> >  	(FS_SYNC_FL | FS_IMMUTABLE_FL | FS_APPEND_FL | \
> >  	 FS_NODUMP_FL |	FS_NOATIME_FL | FS_DAX_FL | \
> > -	 FS_PROJINHERIT_FL)
> > +	 FS_PROJINHERIT_FL | FS_ATOMICWRITES_FL)
> >  
> >  #define FS_XFLAG_COMMON \
> >  	(FS_XFLAG_SYNC | FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND | \
> >  	 FS_XFLAG_NODUMP | FS_XFLAG_NOATIME | FS_XFLAG_DAX | \
> > -	 FS_XFLAG_PROJINHERIT)
> > +	 FS_XFLAG_PROJINHERIT | FS_XFLAG_ATOMICWRITES)
> 
> I'd much prefer that we only use a single user API to set/clear this
> flag.

Hi Dave,

So right now we have 2 ways to mark this flag in ext4:

1. SETFLAGS ioctl() w/ FS_ATOMICWRITES_FL -> set EXT4_ATOMICWRITES_FL on inode
2. SETXFLAGS ioctl() w/ FS_XFLAG_ATOMICWRITES -> translate to FS_ATOMICWRITES_FL -> set EXT4_ATOMICWRITES_FL on inode

IIUC you want to only keep 2. and not support 1. so the user space only
has a single ioctl to use, correct?

One thing I see is that the ext4_fileattr_set() is not XFLAGS aware
at all and right now it expects the XFLAGS to already be translated to 
SETFLAG equivalent before setting it in the inode. Maybe we'll need
to add that logic however it'll be more of an exception than the usual 
pattern.

> 
> This functionality is going to be tied to using extent size hints on
> XFS to indicate preferred atomic IO alignment/size, so applications
> are going to have to use the FS_IOC_FS{G,S}ETXATTR APIs regardless
> of whether it's added to the FS_IOC_{G,S}ETFLAGS API.

Hmm that's right, I'm not sure how we'll handle it in ext4 yet since we
don't have a per file extent size hint, the closest we have is bigalloc
that is more of an mkfs time, FS wide feature. 

Regards,
ojasw
> 
> Also, there are relatively few flags left in the SETFLAGS 32-bit
> space, so this duplication seems like a waste of the few flags
> that are remaining.

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

