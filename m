Return-Path: <linux-fsdevel+bounces-69225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFA8C73EE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 13:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 748494E9453
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 12:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF15833555D;
	Thu, 20 Nov 2025 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EUeocMSX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F352D0600;
	Thu, 20 Nov 2025 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640928; cv=none; b=MLrSzvIeM1dhKAM/IaLr/iOR77sj9zqqBtgX/lvR1sanBoflPaVji2hh0pTt66v/yYg/lThfc2t6cx+1fJc2TZZSaD4en/h56uIfdxtGjig1RrQV/AxHx5FrPHPz936N4cc839kIlHLjvuvyn2EaxYUOgfmIzbZUZRsd1wRXi9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640928; c=relaxed/simple;
	bh=iiTBllRFNBfDrnqnao3rStmALYx6sVXy4eCt7cTwtCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAj25WiSaFfrdDhLmYiR0EbCuU9dHINx8xA1uPdOtZpgdtxb3meMZX2gCMUTP2cKSbk8CE9gztdmi0IaaGHS1LnhftP9q5v6N+2KB4CW3Irtjh+aM0jPqf/+k20heGR7vdOO1T5G2FmDPzY/4PVmd/D3PQ0aH/FjL+oMpR90eTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EUeocMSX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKC7E9G029043;
	Thu, 20 Nov 2025 12:14:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=BmQGXOrLqR42QAIqI1W4D/JNPzmWBe
	bAgsCF39Fhysc=; b=EUeocMSXk9QosseBzTaFAceXVFzNSCY34ZR9Z7p6CSVJEA
	fFYuMwmQ9ACPyZit85kaC0W1QF4PjRXPXTP1yVPSTYJn1ph7I3PaQ+2QoWuL0CeT
	OSfWxL3OoTu7oZy+p4HM1o4ZhQsy8SArHOEy4axzV/M7kqnNra1PyGbuixaFmdrO
	48vnCo9uPXGBonTVXX3Czbhm3WUz7f6sPvjnWmHyoF4nBp2pqXyObeqR+uQel2js
	0H+VbwkDwGlK0NUTUpPK6UTzx8vLkY9XHJU3moosVGaIaFnKs9TNT7n/usurZbla
	98iseQcdu7jsKekfmBX6SEe/qBgvgstGjpAv5wew==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1paf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 12:14:59 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AKCEwuB017022;
	Thu, 20 Nov 2025 12:14:58 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejk1paew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 12:14:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AKB0AJK017404;
	Thu, 20 Nov 2025 12:14:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4af6j1x065-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 12:14:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AKCEuCY39780754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 12:14:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1F6720040;
	Thu, 20 Nov 2025 12:14:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E21C720043;
	Thu, 20 Nov 2025 12:14:51 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.109.219.158])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 20 Nov 2025 12:14:51 +0000 (GMT)
Date: Thu, 20 Nov 2025 17:44:49 +0530
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
Message-ID: <aR8GObWa1mtbbtts@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
 <aRUCqA_UpRftbgce@dread.disaster.area>
 <20251113052337.GA28533@lst.de>
 <87frai8p46.ritesh.list@gmail.com>
 <aRWzq_LpoJHwfYli@dread.disaster.area>
 <aRb0WQJi4rQQ-Zmo@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <aRmHRk7FGD4nCT0s@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRmHRk7FGD4nCT0s@dread.disaster.area>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=C/nkCAP+ c=1 sm=1 tr=0 ts=691f0643 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=07d9gI8wAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=7-415B0cAAAA:8
 a=QkCu-KvVQgBkKXyteS4A:9 a=CjuIK1q_8ugA:10 a=e2CUPOnPG4QKp8I52DXD:22
 a=biEYGPWJfzWAr4FL6Ov7:22
X-Proofpoint-GUID: QY8vQPMMKHQZuhxLUU8MzOElMmP_zUb_
X-Proofpoint-ORIG-GUID: yvqGZeDceYeUfnkxgEv76IrM8wfF74Db
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX+pck3x06oJSH
 wFNr41pE/Z4Kt9RRpJCPvqy1URHIf78uqbpEyJ0Tom3RdhiP0N9cwtgbT27ML0Dn5/vfUb+m2RJ
 P2Cxhu21a6rEg92xcpGUcJnSFIzNbty3OzibQ6z4LaQ8CFBxsJ6tZ+9BCgAAYfbG6zix77U8P+f
 42CuBl9g4YbnmUZAckagpVnw6MfGU7fDdVswcmxGcxMTxG7lp5jaWBtKo902F198kd+m1Qp/ss/
 6mSyMrCXvAlsB97taBiHtKZS8senXTURcdTNqY6OoqhUpJbEoV2elq+Ghbeu3WnIn/42JSk0++E
 QdEArDShq4bKSdbXazxKNyx1XGHAfZjhqD+kFyM0DPPr9ViiQrLaxcGMaST6/XnrQiWX1LeKgXE
 bufZvnwC93o5Kl2iMH1Jmng7J/L1/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_04,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

On Sun, Nov 16, 2025 at 07:11:50PM +1100, Dave Chinner wrote:
> On Fri, Nov 14, 2025 at 02:50:25PM +0530, Ojaswin Mujoo wrote:
> > On Thu, Nov 13, 2025 at 09:32:11PM +1100, Dave Chinner wrote:
> > > On Thu, Nov 13, 2025 at 11:12:49AM +0530, Ritesh Harjani wrote:
> > > > Christoph Hellwig <hch@lst.de> writes:
> > > > 
> > > > > On Thu, Nov 13, 2025 at 08:56:56AM +1100, Dave Chinner wrote:
> > > > >> On Wed, Nov 12, 2025 at 04:36:03PM +0530, Ojaswin Mujoo wrote:
> > > > >> > This patch adds support to perform single block RWF_ATOMIC writes for
> > > > >> > iomap xfs buffered IO. This builds upon the inital RFC shared by John
> > > > >> > Garry last year [1]. Most of the details are present in the respective 
> > > > >> > commit messages but I'd mention some of the design points below:
> > > > >> 
> > > > >> What is the use case for this functionality? i.e. what is the
> > > > >> reason for adding all this complexity?
> > > > >
> > > > > Seconded.  The atomic code has a lot of complexity, and further mixing
> > > > > it with buffered I/O makes this even worse.  We'd need a really important
> > > > > use case to even consider it.
> > > > 
> > > > I agree this should have been in the cover letter itself. 
> > > > 
> > > > I believe the reason for adding this functionality was also discussed at
> > > > LSFMM too...  
> > > > 
> > > > For e.g. https://lwn.net/Articles/974578/ goes in depth and talks about
> > > > Postgres folks looking for this, since PostgreSQL databases uses
> > > > buffered I/O for their database writes.
> > > 
> > > Pointing at a discussion about how "this application has some ideas
> > > on how it can maybe use it someday in the future" isn't a
> > > particularly good justification. This still sounds more like a
> > > research project than something a production system needs right now.
> > 
> > Hi Dave, Christoph,
> > 
> > There were some discussions around use cases for buffered atomic writes
> > in the previous LSFMM covered by LWN here [1]. AFAIK, there are 
> > databases that recommend/prefer buffered IO over direct IO. As mentioned
> > in the article, MongoDB being one that supports both but recommends
> > buffered IO. Further, many DBs support both direct IO and buffered IO
> > well and it may not be fair to force them to stick to direct IO to get
> > the benefits of atomic writes.
> > 
> > [1] https://lwn.net/Articles/1016015/
> 
> You are quoting a discussion about atomic writes that was
> held without any XFS developers present. Given how XFS has driven
> atomic write functionality so far, XFS developers might have some
> ..... opinions about how buffered atomic writes in XFS...
> 
> Indeed, go back to the 2024 buffered atomic IO LSFMM discussion,
> where there were XFS developers present. That's the discussion that
> Ritesh referenced, so you should be aware of it.
> 
> https://lwn.net/Articles/974578/
> 
> Back then I talked about how atomic writes made no sense as
> -writeback IO- given the massive window for anything else to modify
> the data in the page cache. There is no guarantee that what the
> application wrote in the syscall is what gets written to disk with
> writeback IO. i.e. anything that can access the page cache can
> "tear" application data that is staged as "atomic data" for later
> writeback.
> 
> IOWs, the concept of atomic writes for writeback IO makes almost no
> sense at all - dirty data at rest in the page cache is not protected
> against 3rd party access or modification. The "atomic data IO"
> semantics can only exist in the submitting IO context where
> exclusive access to the user data can be guaranteed.
> 
> IMO, the only way semantics that makes sense for buffered atomic
> writes through the page cache is write-through IO. The "atomic"
> context is related directly to user data provided at IO submission,
> and so IO submitted must guarantee exactly that data is being
> written to disk in that IO.
> 
> IOWs, we have to guarantee exclusive access between the data copy-in
> and the pages being marked for writeback. The mapping needs to be
> marked as using stable pages to prevent anyone else changing the
> cached data whilst it has an atomic IO pending on it.
> 
> That means folios covering atomic IO ranges do not sit in the page
> cache in a dirty state - they *must* immediately transition to the
> writeback state before the folio is unlocked so that *nothing else
> can modify them* before the physical REQ_ATOMIC IO is submitted and
> completed.
> 
> If we've got the folios marked as writeback, we can pack them
> immediately into a bio and submit the IO (e.g. via the iomap DIO
> code). There is no need to involve the buffered IO writeback path
> here; we've already got the folios at hand and in the right state
> for IO. Once the IO is done, we end writeback on them and they
> remain clean in the page caceh for anyone else to access and
> modify...

Hi Dave,

I believe the essenece of your comment is that the data in the page
cache can be modified between the write and the writeback time and hence
it makes sense to have a write-through only semantic for RWF_ATOMIC
buffered IO.

However, as per various discussions around this on the mailing list, it
is my understanding that protecting tearing against an application
changing a data range that was previously written atomically is
something that falls out of scope of RWF_ATOMIC.

As John pointed out in [1], even with dio, RWF_ATOMIC writes can be torn
if the application does parallel overlaps. The only thing we guarantee
is the data doesn't tear when the actualy IO happens, and from there its
the userspace's responsibility to not change the data till IO [2]. I
believe userspace changing data between write and writeback time falls
in the same category.


[1] https://lore.kernel.org/fstests/0af205d9-6093-4931-abe9-f236acae8d44@oracle.com/
[2] https://lore.kernel.org/fstests/20250729144526.GB2672049@frogsfrogsfrogs/

> 
> This gives us the same physical IO semantics for buffered and direct
> atomic IO, and it allows the same software fallbacks for larger IO
> to be used as well.
> 
> > > Why didn't you use the existing COW buffered write IO path to
> > > implement atomic semantics for buffered writes? The XFS
> > > functionality is already all there, and it doesn't require any
> > > changes to the page cache or iomap to support...
> > 
> > This patch set focuses on HW accelerated single block atomic writes with
> > buffered IO, to get some early reviews on the core design.
> 
> What hardware acceleration? Hardware atomic writes are do not make
> IO faster; they only change IO failure semantics in certain corner
> cases. Making buffered writeback IO use REQ_ATOMIC does not change
> the failure semantics of buffered writeback from the point of view
> of an application; the applicaiton still has no idea just how much
> data or what files lost data whent eh system crashes.
> 
> Further, writeback does not retain application write ordering, so
> the application also has no control over the order that structured
> data is updated on physical media.  Hence if the application needs
> specific IO ordering for crash recovery (e.g. to avoid using a WAL)
> it cannot use background buffered writeback for atomic writes
> because that does not guarantee ordering.
> 
> What happens when you do two atomic buffered writes to the same file
> range? The second on hits the page cache, so now the crash recovery
> semantic is no longer "old or new", it's "some random older version
> or new". If the application rewrites a range frequently enough,
> on-disk updates could skip dozens of versions between "old" and
> "new", whilst other ranges of the file move one version at a time.
> The application has -zero control- of this behaviour because it is
> background writeback that determines when something gets written to
> disk, not the application.
> 
> IOWs, the only way to guarantee single version "old or new" atomic
> buffered overwrites for any given write would be to force flushing
> of the data post-write() completion.  That means either O_DSYNC,
> fdatasync() or sync_file_range(). And this turns the atomic writes
> into -write-through- IO, not write back IO...

I agree that there is no ordeirng guarantee without calls to sync and
friends, but as with all other IO paths, it has always been the
applicatoin that needs to enforce the ordering. Applications like DBs
are well aware of this however there are still areas where they can
benefit with unordered atomic IO, eg bg write of a bunch of dirty
buffers, which only need to be sync'd once during checkpoint.

> 
> > Just like we did for direct IO atomic writes, the software fallback with
> > COW and multi block support can be added eventually.
> 
> If the reason for this functionality is "maybe someone
> can use it in future", then you're not implementing this
> functionality to optimise an existing workload. It's a research
> project looking for a user.
> 
> Work with the database engineers to build a buffered atomic write
> based engine that implements atomic writes with RWF_DSYNC.
> Make it work, and optimise it to be competitive with existing
> database engines, than then show how much faster it is using
> RWF_ATOMIC buffered writes.
> 
> Alternatively - write an algorithm that assumes the filesystem is
> using COW for overwrites, and optimise the data integrity algorithm
> based on this knowledge. e.g. use always-cow mode on XFS, or just
> optimise for normal bcachefs or btrfs buffered writes. Use O_DSYNC
> when completion to submission ordering is required. Now you have
> an application algorithm that is optimised for old-or-new behaviour,
> and that can then be acclerated on overwrite-in-place capable
> filesystems by using a direct-to-hw REQ_ATOMIC overwrite to provide
> old-or-new semantics instead of using COW.
> 
> Yes, there are corner cases - partial writeback, fragmented files,
> etc - where data will a mix of old and new when using COW without
> RWF_DSYNC.  Those are the the cases that RWF_ATOMIC needs to
> mitigate, but we don't need whacky page cache and writeback stuff to
> implement RWF_ATOMIC semantics in COW capable filesystems.
> 
> i.e. enhance the applicaitons to take advantage of native COW
> old-or-new data semantics for buffered writes, then we can look at
> direct-to-hw fast paths to optimise those algorithms.
> 
> Trying to go direct-to-hw first without having any clue of how
> applications are going to use such functionality is backwards.
> Design the applicaiton level code that needs highly performant
> old-or-new buffered write guarantees, then we can optimise the data
> paths for it...

Got it, thanks for the pointers Dave, we will look into this.

Regards,
ojaswin

> 
> -Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

