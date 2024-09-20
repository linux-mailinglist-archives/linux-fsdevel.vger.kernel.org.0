Return-Path: <linux-fsdevel+bounces-29760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED2B97D741
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 17:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE5A1F25704
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 15:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7356D17C9B9;
	Fri, 20 Sep 2024 15:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H7wSq9eK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A53178CC5;
	Fri, 20 Sep 2024 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844713; cv=none; b=Ntx+QeoN0SulnD22vbLkc5z0SFVIIglR0dN61gs8i9deHaUBcmMe2Fj1czHBQmMf5PO2CtTKzwAbHLUFCGtEyvhtEkhscjWTTXb7jAgcEyNMwYk2o1ubhONn6D6CLSWlGfqmcp/w7LujT8qANPdYzekLSSbpYvScpDSDlRZs1UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844713; c=relaxed/simple;
	bh=hy0yaNATSBW6HFAtXgqFKMg6kFdVeMn/ISUMPkMHW0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQw4We6OrHVEEE9N+2MW7uKHG/aYPLsBzPLiuQjy0fqw6G2R/DsjOlrwHoayMev39c7pLhm6xBit+c4d6cqUYXV404ELO4Uh+3QN0d0j5DV1Kw1N3QpwErzsPPvsTtFtpS6v++/QMsrcM4oufO6zeUy3ldLGKUh44pEDzlaCXNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H7wSq9eK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K7IUTT018163;
	Fri, 20 Sep 2024 15:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=hBOva1nCLu1YkoUWtKFqjSHLjIa
	NINMLna+tFGpx2f0=; b=H7wSq9eKqkh+DjNQ/hnG+ZmqOdR5uUBHBTqx8p1xgkE
	cZ7OWBuVNDb5O0659GNDsEIshlJP9F3ygpbrU4txJKCrsAPFTeS3ihH/VgydKFBL
	uLsDAe3ZqSxwWM8FM31cn4WOqGm91GDF9liYYL8zV4RbxlWaBM2V5JyDsDDyY7y/
	9KJ5E17BMYS2xVOGwcLet2QRbnnCmDwYytuUdaH+7mT5Kxi7K6KNLa/D4FeDGfYD
	qqHdhM/2HBI9lgwYyND6CmyKZP42YLVwI1CeKIx362oczPY8qG8zth9txmOq5zfa
	KPhxHmEX5CbBsrJc3MqSrrsN9DcXndAdBDBN6t9jjnw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vpbyv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 15:04:57 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48KF4uGA007341;
	Fri, 20 Sep 2024 15:04:56 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3vpbyv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 15:04:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48KBwFKp024672;
	Fri, 20 Sep 2024 15:04:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41nq1nfpf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 15:04:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48KF4seS39649734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 15:04:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AE8F20040;
	Fri, 20 Sep 2024 15:04:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A13220043;
	Fri, 20 Sep 2024 15:04:52 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.124.218.203])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 20 Sep 2024 15:04:52 +0000 (GMT)
Date: Fri, 20 Sep 2024 20:34:49 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: Re: [RFC 0/5] ext4: Implement support for extsize hints
Message-ID: <Zu2PEXtKMAUN5CyV@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1726034272.git.ojaswin@linux.ibm.com>
 <ZuqjU0KcCptQKrFs@dread.disaster.area>
 <ZuvPDQ+S/u4FdNNU@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <Zuym5suTo/KYUAND@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zuym5suTo/KYUAND@dread.disaster.area>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IseEDR8wnXBf21xRi0Rc59LkXBRvuYAW
X-Proofpoint-GUID: WjHLczP8o4B6uChnJtkS_OdA7-Ctz_Hf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_07,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409200110

On Fri, Sep 20, 2024 at 08:34:14AM +1000, Dave Chinner wrote:
> On Thu, Sep 19, 2024 at 12:43:17PM +0530, Ojaswin Mujoo wrote:
> > On Wed, Sep 18, 2024 at 07:54:27PM +1000, Dave Chinner wrote:
> > > On Wed, Sep 11, 2024 at 02:31:04PM +0530, Ojaswin Mujoo wrote:
> > > Behaviour such as extent size hinting *should* be the same across
> > > all filesystems that provide this functionality.  This makes using
> > > extent size hints much easier for users, admins and application
> > > developers. The last thing I want to hear is application devs tell
> > > me at conferences that "we don't use extent size hints anymore
> > > because ext4..."
> > 
> > Yes, makes sense :)  
> > 
> > Nothing to worry here tho as ext4 also treats the extsize value as a
> > hint exactly like XFS. We have tried to keep the behavior as similar
> > to XFS as possible for the exact reasons you mentioned. 
> 
> It is worth explicitly stating this (i.e. all the behaviours that
> are the same) in the design documentation rather than just the
> corner cases where it is different. It was certainly not clear how
> failures were treated.

Got it Dave, I did mention it in the actual commit 5/5 but I agree. I
will update the cover letter to be more clear about the design in future
revisions.

> 
> > And yes, we do plan to add a forcealign (or similar) feature for ext4 as
> > well for atomic writes which would change the hint to a mandate
> 
> Ok. That should be stated, too.
> 
> FWIW, it would be a good idea to document this all in the kernel
> documentation itself, so there is a guideline for other filesystems
> to implement the same behaviour. e.g. in
> Documentation/filesystems/extent-size-hints.rst

Okay makes sense, I can look into this as a next step.

> 
> > > > 2. eof allocation on XFS trims the blocks allocated beyond eof with extsize
> > > >    hint. That means on XFS for eof allocations (with extsize hint) only logical
> > > >    start gets aligned.
> > > 
> > > I'm not sure I understand what you are saying here. XFS does extsize
> > > alignment of both the start and end of post-eof extents the same as
> > > it does for extents within EOF. For example:
> > > 
> > > # xfs_io -fdc "truncate 0" -c "extsize 16k" -c "pwrite 0 4k" -c "bmap -vvp" foo
> > > wrote 4096/4096 bytes at offset 0
> > > 4 KiB, 1 ops; 0.0308 sec (129.815 KiB/sec and 32.4538 ops/sec)
> > > foo:
> > > EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
> > >    0: [0..7]:          256504..256511    0 (256504..256511)     8 000000
> > >    1: [8..31]:         256512..256535    0 (256512..256535)    24 010000
> > >  FLAG Values:
> > >     0100000 Shared extent
> > >     0010000 Unwritten preallocated extent
> > > 
> > > There's a 4k written extent at 0, and a 12k unwritten extent
> > > beyond EOF at 4k. I.e. we have an extent of 16kB as the hint
> > > required that is correctly aligned beyond EOF.
> > > 
> > > If I then write another 4k at 20k (beyond both EOF and the unwritten
> > > extent beyond EOF:
> > > 
> > > # xfs_io -fdc "truncate 0" -c "extsize 16k" -c "pwrite 0 4k" -c "pwrite 20k 4k" -c "bmap -vvp" foo
> > > wrote 4096/4096 bytes at offset 0
> > > 4 KiB, 1 ops; 0.0210 sec (190.195 KiB/sec and 47.5489 ops/sec)
> > > wrote 4096/4096 bytes at offset 20480
> > > 4 KiB, 1 ops; 0.0001 sec (21.701 MiB/sec and 5555.5556 ops/sec)
> > > foo:
> > >  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
> > >    0: [0..7]:          180000..180007    0 (180000..180007)     8 000000
> > >    1: [8..39]:         180008..180039    0 (180008..180039)    32 010000
> > >    2: [40..47]:        180040..180047    0 (180040..180047)     8 000000
> > >    3: [48..63]:        180048..180063    0 (180048..180063)    16 010000
> > >  FLAG Values:
> > >     0100000 Shared extent
> > >     0010000 Unwritten preallocated extent
> > > 
> > > You can see we did contiguous allocation of another 16kB at offset
> > > 16kB, and then wrote to 20k for 4kB.. i.e. the new extent was
> > > correctly aligned at both sides as the extsize hint says it should
> > > be....
> > 
> > Sorry for the confusion Dave. What was meant is that XFS would indeed
> > respect extsize hint for EOF allocations but if we close the file, since
> > we trim the blocks past EOF upon close, we would only see that the
> > lstart is aligned but the end would not.
> 
> Right, but that is desired behaviour, especially when extsize is
> large.  i.e. when the file is closed it is an indication that the
> file will not be written again, so we don't need to keep post-eof
> blocks around for fragmentation prevention reasons.
> 
> Removing post-EOF extents on close prevents large extsize hints from
> consuming lots of unused space on files that are never going to be
> written to again(*).  That's user visible, and because it can cause
> premature ENOSPC, users will report this excessive space usage
> behaviour as a bug (and they are right).  Hence removing post-eof
> extents on file close when extent size hints are in use comes under
> the guise of Good Behaviour To Have.
> 
> (*) think about how much space is wasted if you clone a kernel git
> tree under a 1MB extent size hint directory. All those tiny header
> files now take up 1MB of space on disk....
> 
> Keep in mind that when the file is opened for write again, the
> extent size hint still gets applied to the new extents.  If the
> extending write starts beyond the EOF extsize range, then the new
> extent after the hole at EOF will be fully extsize aligned, as
> expected.
> 
> If the new write is exactly extending the file, then the new extents
> will not be extsize aligned - the start will be at the EOF block,
> and they will be extsize -length-.  IOWs, the extent size is
> maintained, just the logical alignment is not exactly extsize
> aligned. This could be considered a bug, but it's never been an
> issue for anyone because, in XFS, physical extent alignment is
> separate (and maintained regardless of logical alignment) for extent
> size hint based allocations.
> 
> Adding force-align will prevent this behaviour from occurring, as
> post-eof trimming will be done to extsize alignment, not to the EOF
> block.  Hence open/close/open will not affect logical or physical
> alignment of force-align extents (and hence won't affect atomic
> writes).

Thanks for the context, I will try to keep this behavior similar to XFS
once we implement the EOF support for extsize hints in next revision.

Regards,
Ojaswin
> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

