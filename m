Return-Path: <linux-fsdevel+bounces-41159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32613A2BB4F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 07:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBF7188A58A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 06:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB6218A95A;
	Fri,  7 Feb 2025 06:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SICP8l2q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A8315445D;
	Fri,  7 Feb 2025 06:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738909555; cv=none; b=QLlIA7pc3nx5g7108LRLlCgN9+AB5X+PDpTCdWcN5uo8q2a+Ek+kWnK5125aNULYa7mnVN54lcKpTJuRbsCPBc4wK45A7ee2YaZC3601Wx2F9Fqkyg9LKxSSpDZr+oyrXX+BoBbfp2LJY3ToKUNDT1oWU9lQzcmHkpyuEUOXLi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738909555; c=relaxed/simple;
	bh=2ZAMUwoXa9jVDZ8qCVxlUHJmvAo7/bFakyN3XEU75Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcA3+H/hNwW4FTFReK2PxOe+i8XTYYWVK2x8OQFVclInAGnX2wMlftxLMojCwwi/MyYgYkGVosrCTlXnGHGQym3XPnZsydfOsEI5xDd0RMUL/ntAn52bA2q9QVZE3P/EQcVSNm2qY3MEeTuAj0S3fW8JDjhechHHyCg5/J8nNyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SICP8l2q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51717xC9020985;
	Fri, 7 Feb 2025 06:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=yeUJENEyzNNBjE6gqD5nfYnx9JffI2
	JgN4G9+tK5BsY=; b=SICP8l2qbojV0tPD/rdXRpVKFQB5e0PrkgZbKWLQUTOKmE
	kWWM1eSCNCct+EISDt4g0xPKT8kq4RNCk5NLhE99G1/O+tqXSCshqNHWPRXqCaeN
	Ui5MWEHFa1lZCMG8CiL/XZ+qtVXkqxf0qZv4SFARIl+YUZcK9ptDxE7FXd9Nv93g
	7+Ea5ZBvkezWdQKTgwYSffMRTe4LZgnIAzuuRVS5tkgPcxomXMEmYJDFmsGIWIZw
	BpDV5PtzIK3hTY4D0P1wVeMVQyCWnTsGD8R1nahtYsElSJa5vkMZUPd5wCvoQC54
	/rlPfWpyqoqXl/ALIIT1SVam7ZD3Fbzzyaq7G8sg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44n88994ag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 06:25:40 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5176MwrP011324;
	Fri, 7 Feb 2025 06:25:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44n88994ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 06:25:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51721XBL007158;
	Fri, 7 Feb 2025 06:25:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxb02ama-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 06:25:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5176PZEl30671416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 06:25:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E635200CB;
	Fri,  7 Feb 2025 06:08:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C477E200CA;
	Fri,  7 Feb 2025 06:08:10 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.220.180])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Feb 2025 06:08:10 +0000 (GMT)
Date: Fri, 7 Feb 2025 11:38:08 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de, ritesh.list@gmail.com, jack@suse.cz, tytso@mit.edu,
        linux-ext4@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] extsize and forcealign design in filesystems
 for atomic writes
Message-ID: <Z6WjSJ9EbBt3qbIp@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <Z5nTaQgLGdD6hSvL@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <35939b19-088b-450e-8fa6-49165b95b1d3@oracle.com>
 <Z5pRzML2jkjL01F5@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e00bac5d-5b6c-4763-8a76-e128f34dee12@oracle.com>
 <Z53JVhAzF9s1qJcr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <4a492767-ee83-469c-abd1-484d0e3b46cb@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a492767-ee83-469c-abd1-484d0e3b46cb@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TAdV_FGx9uLLR2FfgYiJxSR0NBz83XNu
X-Proofpoint-ORIG-GUID: mYPA3wv1jA24pg34ePGN4nON3nEYOt7r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_03,2025-02-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070046

On Tue, Feb 04, 2025 at 12:20:25PM +0000, John Garry wrote:
> On 01/02/2025 07:12, Ojaswin Mujoo wrote:
> 
> Hi Ojaswin,
> 
> > > For my test case, I am trying 16K atomic writes with 4K FS block size, so I
> > > expect the software fallback to not kick in often after running the system
> > > for a while (as eventually we will get an aligned allocations). I am
> > > concerned of prospect of heavily fragmented files, though.
> > Yes that's true, if the FS is up long enough there is bound to be
> > fragmentation eventually which might make it harder for extsize to
> > get the blocks.
> > 
> > With software fallback, there's again the point that many FSes will need
> > some sort of COW/exchange_range support before they can support anything
> > like that.
> > 
> > Although I;ve not looked at what it will take to add that to
> > ext4 but I'm assuming it will not be trivial at all.
> 
> Sure, but then again you may not have issues with getting forcealign support
> accepted for ext4. However, I would have thought that bigalloc was good
> enough to use initially.

Yes, bigalloc is indeed good enough as a start but yes eventually
something like forcealign will be beneficial as not everyone prefers an
FS-wide cluster-size allocation granularity.

We do have a patch for atomic writes with bigalloc that was sent way
back in mid 2024 but then we went into the same discussion of mixed
mapping[1].

Hmm I think it might be time to revisit that and see if we can do
something better there.

[1] https://lore.kernel.org/linux-ext4/37baa9f4c6c2994df7383d8b719078a527e521b9.1729825985.git.ritesh.list@gmail.com/
> 
> > 
> > > > I agree that forcealign is not the only way we can have atomic writes
> > > > work but I do feel there is value in having forcealign for FSes and
> > > > hence we should have a discussion around it so we can get the interface
> > > > right.
> > > > 
> > > I thought that the interface for forcealign according to the candidate xfs
> > > implementation was quite straightforward. no?
> > As mentioned in the original proposal, there are still a open problems
> > around extsize and forcealign.
> > 
> > - The allocation and deallocation semantics are not completely clear to
> > 	me for example we allow operations like unaligned punch_hole but not
> > 	unaligned insert and collapse range, and I couldn't see that
> > 	documented anywhere.
> 
> For xfs, we were imposing the same restrictions as which we have for
> rtextsize > 1.
> 
> If you check the following:
> https://lore.kernel.org/linux-xfs/20240813163638.3751939-9-john.g.garry@oracle.com/
> 
> You can see how the large allocunit value is affected by forcealign, and
> then check callers of xfs_is_falloc_aligned() -> xfs_inode_alloc_unitsize()
> to see how this affects some fallocate modes.

True, but it's something that just implicitly happens when we use
forcealign. I eventually found out while testing forcealign with
different operations but such things can come as a surprise to users
especially when we support some operations to be unaligned and then
reject some other similar ones.

punch_hole/collapse_range is just an example and yes it might not be
very important to support unaligned collapse range but in the long run
it would be good to have these things documented/discussed.
> 
> > 
> > - There are challenges in extsize with delayed allocation as well as how
> > 	the tooling should handle forcealigned inodes.
> 
> Yeah, maybe. I was only testing my xfs forcealign solution for dio (and no
> delayed alloc).
> 
> > 
> > - How are FSes supposed to behave when forcealign/extsize is used with
> > 	other FS features that change the allocation granularity like bigalloc
> > 	or rtvol.
> 
> As you would expect, they need to be aligned with one another.
> 
> For example, in the case of xfs rtvol, rextsize needs to be a multiple of
> extsize when forcealign is enabled. Or the other way around, I forget now..
> 
> > 
> > I agree that XFS's implementation is a good reference but I'm
> > sure as I continue working on the same from ext4 perspective we will have
> > more points of discussion. So I definitely feel that its worth
> > discussing this at LSFMM.
> 
> Understood, but I wait to see what happens to my CoW-based method for XFS to
> see where that goes before commenting on what needs to be discussed for xfs

Got it.
> 
> > 
> > > What was not clear was the age-old issue of how to issue an atomic write of
> > > mixed extents, which is really an atomic write issue.
> > Right, btw are you planning any talk for atomic writes at LSFMM?
> 
> I hadn't planned on it, but I guess that Martin will add something to the
> agenda.
> 
> Thanks,
> John
> 

