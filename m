Return-Path: <linux-fsdevel+bounces-5461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B8980C759
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 11:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDBA2817E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 10:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A3A2D78F;
	Mon, 11 Dec 2023 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YqMGZErW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4619A;
	Mon, 11 Dec 2023 02:54:28 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB8JhUs009011;
	Mon, 11 Dec 2023 10:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=yg+AOJ4pAdpNoXbdrXUMj4wiRQaG783GHe5izSwVsbE=;
 b=YqMGZErWBP2OC+aAdw3WUMoEGrVBBqwtz2sFTWfi1+5/TqSw2EW8IdZA1Tqdu0bMD0hl
 XwgDytxHL7T2eSVnQBt2RizYpCwBxYO7k7OSMku0xVh324cDd4G6aeYiSNj6A29YW5X3
 eFXSHIOUiFYsMkgOlBNKyOcqlVTU1ZLILUO0NU3CgE4zySbowBtI55G5eNx9DDvYDZDE
 5zI/70eRLUr8Bq2UktJn6PJS5p88fAYk2sdb2Kcmpcnqr+568KtVcQ/mkf0Q8yGReyZ8
 IZosrCHOCctFIz8keCdD2l5ezWmSSRtPuZx1xBC9QI9puUBTxtSqbR0p0LgzTH0LtRmO 3g== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwu4u1sp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 10:54:21 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BBAcWtw031481;
	Mon, 11 Dec 2023 10:54:21 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uwu4u1snq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 10:54:21 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BB90Clc004216;
	Mon, 11 Dec 2023 10:54:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4sk0enj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 10:54:20 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BBAsIss45351510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 10:54:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 999F820049;
	Mon, 11 Dec 2023 10:54:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE16920040;
	Mon, 11 Dec 2023 10:54:16 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.124.31.44])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 11 Dec 2023 10:54:16 +0000 (GMT)
Date: Mon, 11 Dec 2023 16:24:14 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
Subject: Re: [RFC 0/7] ext4: Allocator changes for atomic write support with
 DIO
Message-ID: <ZXbqVs0TdoDcJ352@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <8c06c139-f994-442b-925e-e177ef2c5adb@oracle.com>
 <ZW3WZ6prrdsPc55Z@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <de90e79b-83f2-428f-bac6-0754708aa4a8@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de90e79b-83f2-428f-bac6-0754708aa4a8@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0hk_CaKg5hl9OuxCwwTAIB1EfHwqWApK
X-Proofpoint-GUID: 6HnBDUGIbZWzEmNKTMIAYK6m4LFLD47B
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-11_04,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2312110087

Hi John,

On Mon, Dec 04, 2023 at 02:44:36PM +0000, John Garry wrote:
> On 04/12/2023 13:38, Ojaswin Mujoo wrote:
> > > So are we supposed to be doing atomic writes on unwritten ranges only in the
> > > file to get the aligned allocations?
> > If we do an atomic write on a hole, ext4 will give us an aligned extent
> > provided the hole is big enough to accomodate it.
> > 
> > However, if we do an atomic write on a existing extent (written or
> > unwritten) ext4 would check if it satisfies the alignment and length
> > requirement and returns an error if it doesn't.
> 
> This seems a rather big drawback.

So if I'm not wrong, we force the extent alignment as well as the size
of the extent in xfs right. 

We didn't want to overly restrict the users of atomic writes by forcing
the extents to be of a certain alignment/size irrespective of the size
of write. The design in this patchset provides this flexibility at the
cost of some added precautions that the user should take (eg not doing
an atomic write on a pre existing unaligned extent etc).

However, I don't think it should be too hard to provide an optional
forced alignment feature on top of this if there's interest in that.
> 
> > Since we don't have cow
> > like functionality afaik the only way we could let this kind of write go
> > through is by punching the pre-existing extent which is not something we
> > can directly do in the same write operation, hence we return error.
> 
> Well, as you prob saw, for XFS we were relying on forcing extent alignment,
> and not CoW (yet).

That's right.

> 
> > 
> > > I actually tried that, and I got a WARN triggered:
> > > 
> > > # mkfs.ext4 /dev/sda
> > > mke2fs 1.46.5 (30-Dec-2021)
> > > Creating filesystem with 358400 1k blocks and 89760 inodes
> > > Filesystem UUID: 7543a44b-2957-4ddc-9d4a-db3a5fd019c9
> > > Superblock backups stored on blocks:
> > >          8193, 24577, 40961, 57345, 73729, 204801, 221185
> > > 
> > > Allocating group tables: done
> > > Writing inode tables: done
> > > Creating journal (8192 blocks): done
> > > Writing superblocks and filesystem accounting information: done
> > > 
> > > [   12.745889] mkfs.ext4 (150) used greatest stack depth: 13304 bytes left
> > > # mount /dev/sda mnt
> > > [   12.798804] EXT4-fs (sda): mounted filesystem
> > > 7543a44b-2957-4ddc-9d4a-db3a5fd019c9 r/w with ordered data mode. Quota
> > > mode: none.
> > > # touch mnt/file
> > > #
> > > # /test-statx -a /root/mnt/file
> > > statx(/root/mnt/file) = 0
> > > dump_statx results=5fff
> > >    Size: 0               Blocks: 0          IO Block: 1024    regular file
> > > Device: 08:00           Inode: 12          Links: 1
> > > Access: (0644/-rw-r--r--)  Uid:     0   Gid:     0
> > > Access: 2023-12-04 10:27:40.002848720+0000
> > > Modify: 2023-12-04 10:27:40.002848720+0000
> > > Change: 2023-12-04 10:27:40.002848720+0000
> > >   Birth: 2023-12-04 10:27:40.002848720+0000
> > > stx_attributes_mask=0x703874
> > >          STATX_ATTR_WRITE_ATOMIC set
> > >          unit min: 1024
> > >          uunit max: 524288
> > > Attributes: 0000000000400000 (........ ........ ........ ........
> > > ........ .?--.... ..---... .---.-..)
> > > #
> > > 
> > > 
> > > 
> > > looks ok so far, then write 4KB at offset 0:
> > > 
> > > # /test-pwritev2 -a -d -p 0 -l 4096  /root/mnt/file
> > > file=/root/mnt/file write_size=4096 offset=0 o_flags=0x4002 wr_flags=0x24
> 
> ...
> 
> > > Please note that I tested on my own dev branch, which contains changes over
> > > [1], but I expect it would not make a difference for this test.
> > Hmm this should not ideally happen, can you please share your test
> > script with me if possible?
> 
> It's doing nothing special, just RWF_ATOMIC flag is set for DIO write:
> 
> https://github.com/johnpgarry/linux/blob/236870d48ecb19c1cf89dc439e188182a0524cd4/samples/vfs/test-pwritev2.c

Thanks for the script, will try to replicate this today and get back to
you.

> 
> > > > 
> > > > Script to test using pwritev2() can be found here:
> > > > https://gist.github.com/OjaswinM/e67accee3cbb7832bd3f1a9543c01da9
> > > Please note that the posix_memalign() call in the program should PAGE align.
> > Why do you say that? direct IO seems to be working when the userspace
> > buffer is 512 byte aligned, am I missing something?
> 
> ah, sorry, if you just use 1x IOV vector then no special alignment are
> required, so ignore this. Indeed, I need to improve kernel checks for
> alignment anyway.
> 
> Thanks,
> John
> 

Regards,
ojaswin

