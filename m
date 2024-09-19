Return-Path: <linux-fsdevel+bounces-29692-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FC297C4CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 09:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3471C2289E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 07:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42446192B62;
	Thu, 19 Sep 2024 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c2J2yiXw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A8018BC04;
	Thu, 19 Sep 2024 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726730635; cv=none; b=dUzNU72su4iniZ6knhE7/J40H+iJyJK31Q/Cup9EKOfDU0rv01JxpZ2U9G8zh2wbzIHEfDwJm5/iWa5BPYxEZTZav9Q46vONRCp/ngujFv/CTgY/z5cM24h15SbmPRxYFr1mUCTOdGqCY8+T39VPun5/QP7RFyZWNyR4yH0U8VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726730635; c=relaxed/simple;
	bh=apG6SyASQ/Pu+tgfU+87K+vq1xdOrii+oH61cio7kqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KitS6eUz3f1wfQeP02oPFfqC/kqS7cgSc05mgQ30lzo9E6Z7vhMp6xyCH5NSPgOF3apszSokGvkBgK76OvbiVy9kvGYeJuunxax6iLCS4ijfTEET6bCFMTz0Pbmfb73OSO7rY9kwKc1fRKExCPwsE1pexDyaHCV2zyovYSK/eQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c2J2yiXw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48J6FEaw028990;
	Thu, 19 Sep 2024 07:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=Vkdxw73uZ7ChMEhNbP+4PcNSWOG
	NSDNpDnK3ABcM9hM=; b=c2J2yiXwsSjyZ6oQIB74qPA3Gx8ooNlsa4J/6YAqDy0
	9/C6pALRq+rPnagnm9GBtBdJ6OQoKRQSag11z35GLf4FblcQ8AC9DI8BFmwU05ee
	EyO18Bozc0xr/Pg/K18J8WscS3DlluI2/2/V2z/rAbCI2s95IOj/+gf1w7SzwIEz
	JK7Fy9SsWovr7fs9UnZz6ldg7ejIXbuk9MXtxGxAmcSzeouHPWzfJcThLwAgJIxd
	vOXvCTLYk94c4fy3Xj1ns/cA1MvCuuTJJ1+6tWaSUfO5bRdN+erQmzcldr5JQ5SK
	O9+adH4n0tTShky/c7oxGks8idxOfeGMaHd+6k0OCVg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3udj7g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 07:22:10 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48J7MA7I019389;
	Thu, 19 Sep 2024 07:22:10 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41n3udj5xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 07:18:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48J72RSB001184;
	Thu, 19 Sep 2024 07:13:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nntqftnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Sep 2024 07:13:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48J7DLvE37355810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 07:13:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84AD820040;
	Thu, 19 Sep 2024 07:13:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACCC920043;
	Thu, 19 Sep 2024 07:13:19 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.109.253.82])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 19 Sep 2024 07:13:19 +0000 (GMT)
Date: Thu, 19 Sep 2024 12:43:17 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Dave Chinner <david@fromorbit.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>, dchinner@redhat.com
Subject: Re: [RFC 0/5] ext4: Implement support for extsize hints
Message-ID: <ZuvPDQ+S/u4FdNNU@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1726034272.git.ojaswin@linux.ibm.com>
 <ZuqjU0KcCptQKrFs@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuqjU0KcCptQKrFs@dread.disaster.area>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2z8Mvk1kcxPocUP0sOHkLT5tHmgfyAOz
X-Proofpoint-ORIG-GUID: oURXS2QpbEHaZVwyfUhsu40dtGCC2ft9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-19_03,2024-09-18_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409190045

On Wed, Sep 18, 2024 at 07:54:27PM +1000, Dave Chinner wrote:
> On Wed, Sep 11, 2024 at 02:31:04PM +0530, Ojaswin Mujoo wrote:
> > This patchset implements extsize hint feature for ext4. Posting this RFC to get
> > some early review comments on the design and implementation bits. This feature
> > is similar to what we have in XFS too with some differences.
> > 
> > extsize on ext4 is a hint to mballoc (multi-block allocator) and extent
> > handling layer to do aligned allocations. We use allocation criteria 0
> > (CR_POWER2_ALIGNED) for doing aligned power-of-2 allocations. With extsize hint
> > we try to align the logical start (m_lblk) and length(m_len) of the allocation
> > to be extsize aligned. CR_POWER2_ALIGNED criteria in mballoc automatically make
> > sure that we get the aligned physical start (m_pblk) as well. So in this way
> > extsize can make sure that lblk, len and pblk all are aligned for the allocated
> > extent w.r.t extsize.
> > 
> > Note that extsize feature is just a hinting mechanism to ext4 multi-block
> > allocator. That means that if we are unable to get an aligned allocation for
> > some reason, than we drop this flag and continue with unaligned allocation to
> > serve the request. However when we will add atomic/untorn writes support, then
> > we will enforce the aligned allocation and can return -ENOSPC if aligned
> > allocation was not successful.
> > 
> > Comparison with XFS extsize feature -
> > =====================================
> > 1. extsize in XFS is a hint for aligning only the logical start and the lengh
> >    of the allocation v/s extsize on ext4 make sure the physical start of the
> >    extent gets aligned as well.
> 
> What happens when you can't align the physical start of the extent?
> It fails the allocation with ENOSPC?

Hi Dave, thanks for the review.

No, ext4 treats it as a hint as well and we fallback to nonaligned
allocation
> 
> For XFS, the existing extent size behaviour is a hint, and so we
> ignore the hint if we cannot perform the allocation with the
> suggested alignment. i.e. We should not fail an allocation with an
> extent size hint until we are actually very near ENOSPC.
> 
> With the new force-align feature, the physical alignment within an
> AG gets aligned to the extent size. In this case, if we can't find
> an aligned free extent to allocate, we fail the allocation (ENOSPC).
> Hence with forced alignment, we can have ENOSPC occur when there are
> large amounts of free space available in the filesystem.
> 
> This is almost certainly what most people -don't want-, but it is a
> requirement for atomic writes. To make matters worse, this behaviour
> will almost certainly get worst as filesystem ages and free space
> slowly fragments over time.
> 
> IOWs, by making the ext4 extsize have forced alignment semantics by
> default, it means users will see ENOSPC at lot more frequently and
> in situations where it is most definitely not expected.
> 
> We also have to keep in mind that there are applications out there
> that set and use extent size hints, and so enabling extsize in ext4
> will result in those applications silently starting to use them. If
> ext4 supporting extsize hints drastically changes the behaviour of
> the filesystem then that is going to cause significant unexpected
> regressions for users as they upgrade kernels and filesystems.
> 
> Hence I strongly suggest that ext4 implements extent size hints in
> the same way that XFS does. i.e. unless forced alignment has been
> enabled for the inode, extsize is just a hint that gets discarded if
> aligned allocation does not succeed.
> 
> Behaviour such as extent size hinting *should* be the same across
> all filesystems that provide this functionality.  This makes using
> extent size hints much easier for users, admins and application
> developers. The last thing I want to hear is application devs tell
> me at conferences that "we don't use extent size hints anymore
> because ext4..."

Yes, makes sense :)  

Nothing to worry here tho as ext4 also treats the extsize value as a
hint exactly like XFS. We have tried to keep the behavior as similar
to XFS as possible for the exact reasons you mentioned. 

And yes, we do plan to add a forcealign (or similar) feature for ext4 as
well for atomic writes which would change the hint to a mandate

> 
> > 2. eof allocation on XFS trims the blocks allocated beyond eof with extsize
> >    hint. That means on XFS for eof allocations (with extsize hint) only logical
> >    start gets aligned.
> 
> I'm not sure I understand what you are saying here. XFS does extsize
> alignment of both the start and end of post-eof extents the same as
> it does for extents within EOF. For example:
> 
> # xfs_io -fdc "truncate 0" -c "extsize 16k" -c "pwrite 0 4k" -c "bmap -vvp" foo
> wrote 4096/4096 bytes at offset 0
> 4 KiB, 1 ops; 0.0308 sec (129.815 KiB/sec and 32.4538 ops/sec)
> foo:
> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>    0: [0..7]:          256504..256511    0 (256504..256511)     8 000000
>    1: [8..31]:         256512..256535    0 (256512..256535)    24 010000
>  FLAG Values:
>     0100000 Shared extent
>     0010000 Unwritten preallocated extent
> 
> There's a 4k written extent at 0, and a 12k unwritten extent
> beyond EOF at 4k. I.e. we have an extent of 16kB as the hint
> required that is correctly aligned beyond EOF.
> 
> If I then write another 4k at 20k (beyond both EOF and the unwritten
> extent beyond EOF:
> 
> # xfs_io -fdc "truncate 0" -c "extsize 16k" -c "pwrite 0 4k" -c "pwrite 20k 4k" -c "bmap -vvp" foo
> wrote 4096/4096 bytes at offset 0
> 4 KiB, 1 ops; 0.0210 sec (190.195 KiB/sec and 47.5489 ops/sec)
> wrote 4096/4096 bytes at offset 20480
> 4 KiB, 1 ops; 0.0001 sec (21.701 MiB/sec and 5555.5556 ops/sec)
> foo:
>  EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>    0: [0..7]:          180000..180007    0 (180000..180007)     8 000000
>    1: [8..39]:         180008..180039    0 (180008..180039)    32 010000
>    2: [40..47]:        180040..180047    0 (180040..180047)     8 000000
>    3: [48..63]:        180048..180063    0 (180048..180063)    16 010000
>  FLAG Values:
>     0100000 Shared extent
>     0010000 Unwritten preallocated extent
> 
> You can see we did contiguous allocation of another 16kB at offset
> 16kB, and then wrote to 20k for 4kB.. i.e. the new extent was
> correctly aligned at both sides as the extsize hint says it should
> be....

Sorry for the confusion Dave. What was meant is that XFS would indeed
respect extsize hint for EOF allocations but if we close the file, since
we trim the blocks past EOF upon close, we would only see that the
lstart is aligned but the end would not.

For example:

$ xfs_io -c "open -dft foo" -c "truncate 0" -c "extsize 16k" -c "pwrite 0 4k" -c "bmap -vvp" -c "close" -c "open foo" -c "bmap -vvp"

wrote 4096/4096 bytes at offset 0
4 KiB, 1 ops; 0.0003 sec (9.864 MiB/sec and 2525.2525 ops/sec)

foo:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
   0: [0..7]:          384..391          0 (384..391)           8 000000
   1: [8..31]:         392..415          0 (392..415)          24 010000
 FLAG Values:
    0010000 Unwritten preallocated extent

foo:
 EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
   0: [0..7]:          384..391          0 (384..391)           8 000000

> 
> >    However extsize hint in ext4 for eof allocation is not
> >    supported in this version of the series.
> 
> If you can't do extsize aligned allocations for EOF extension, then
> how to applications use atomic writes to atomically extend the file?
> 

In this particular RFC we can't and we'll have to go via the 'set extsize hint
and then truncate' route.  But we do plan to add this in next revision.

> > 3. XFS allows extsize to be set on file with no extents but delayed data.
> 
> It does?
> 
> <looks>
> 
> Yep, it doesn't check ip->i_delayed_blks is zero when changing
> extsize.
> 
> I think that's simply a bug, not intended behaviour, because
> delalloc will not have reserved space for the extsize hint rounding
> needed when writeback occurs. Can you send a patch to add this
> check?

Got it, sure I can send a patch for this.

> 
> >    However, ext4 don't allow that for simplicity. The user is expected to set
> >    it on a file before changing it's i_size.
> 
> We don't actually care about i_size in XFS - the determining factor
> is whether there are extents allocated on disk. i.e. we can truncate
> up and then set the extent size hint because there are no extents
> allocated even though the size is non-zero. 

That's right Dave, my intention was also to just make sure that before
setting extsize:

  1. We dont have dellayed allocs in flight
  2. We dont have blocks allocated on disk

So ideally truncate followed by extsize set should have worked.

And in that sense, you are right that using i_size (or i_disksize in ext4)
is not correct. I will fix this behavior in next revision, thanks.

> 
> There are almost certainly applications out there that change extent
> size after truncating to a non-zero size, so this needs to work on
> ext4 the same way it does on XFS. Otherwise people are going to
> complain that their applications suddenly stop working properly on
> ext4....
> 
> > 4. XFS allows non-power-of-2 values for extsize but ext4 does not, since we
> >    primarily would like to support atomic writes with extsize.
> 
> Yes, ext4 can make that restriction if desired.
> 
> Keep in mind that the XFS atomic write support is still evolving,
> and I think the way we are using extent size hints isn't fully
> solidified yet.
> 
> Indeed, I think that we can allow non-power-of-2 extent sizes for
> atomic writes, because integer multiples of the atomic write unit
> will still ensure that physical extents are properly aligned for
> atomic writes to succeed.  e.g. 24kB extent size is compatible with
> 8kB atomic write sizes.
> 
> To make that work efficiently unwritten extent boundaries need to be
> maintained at atomic write alignments (8kB), not extent size
> alignment (24kB), but other than that I don't think anything else is
> needed....
> 
> This is desirable because it will allow extent size hints to remain
> usable for their original purposes even with atomic writes on XFS.
> i.e. fragmentation minimisation for small random DIO write worklaods
> (exactly the sort of IO you'd consider using atomic writes for!),
> alignment of extents to [non-power-of-2] RAID stripe geometry, etc.

Got it, I agree that extsize doesn't **have** to be power-of-2 but
for this revision we have kept it that way cause getting power of 2
aligned blocks comes almost without much changes in ext4 allocator.

However, it shouldn't be a problem to support non power-of-2 blocks. We
already have some aligned allocation logic for RAID use case which can
be leveraged.

> 
> > 5. In ext4 we chose to store the extsize value in SYSTEM_XATTR rather than an
> >    inode field as it was simple and most flexible, since there might be more
> >    features like atomic/untorn writes coming in future.
> 
> Does that mean you can query and set it through the user xattr
> interfaces? If so, how do you enforce the values users set are
> correct?

AFAICU, ext4 (and XFS) doesn't provide a handler for system xattrs, so
its not possible for a user to get/set it from the xattr interface.
They'd have to go through the ioctl. 

$ getfattr -n system.extsize test
test: system.extsize: Operation not supported

That being said, in case in future we would for some reason want to add
a handler for system xattrs to ext4, we'll have to be mindful of making
sure users can't get or set extsize through the xattr interfaces.

> 
> > 6. In buffered-io path XFS switches to non-delalloc allocations for extsize hint.
> >    The same has been kept for EXT4 as well.
> 
> That's an internal XFS implementation detail that you don't need to
> replicate. Historically speaking, we didn't use unwritten extents
> for delayed allocation and so we couldn't do within-EOF extsize
> unaligned writes without adding special additional zero-around code to
> ensure that we never exposed stale data to userspace from the extra
> allocation that the data write did not cover.
> 
> We now use unwritten extents for delalloc conversion, so this istale
> data exposure issue no longer exists. We should really switch this
> code back to using delalloc because it is much faster and less
> fragmentation prone than direct extsize allocation....

Thanks for the context Dave, I didn't implement it this time around as I
wanted to be sure what challenges XFS faced and ext4 will face while
trying extsize with delalloc. I think this clears things up and this can
be added in the next revisions.

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

