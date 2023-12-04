Return-Path: <linux-fsdevel+bounces-4773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A518036FC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 15:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5921C20BA0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8733028DD4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CDBdu+nx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD45419A5;
	Mon,  4 Dec 2023 05:39:10 -0800 (PST)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4ClLZW000906;
	Mon, 4 Dec 2023 13:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=JWXu4qy8zsoHGMYQ4VpZBTPvSXI9OX0ldDgJDtioPbo=;
 b=CDBdu+nxXnZY4hjJDqhX4u3Kgk2A3nrN6rdVtWxp/o4VqXaGqztVvYyEY0uxl9Q+HY8N
 oMSvPgBWE2+zFcZt2fmrUNkgWLxbPgZ04hIEzHBtxMGFnYSlqIn7ws8eL17GXnv/5EpH
 CDjdybrudWHSfeWT9shPLUxJjKxAWfODp7gu8wednIwIV+VpZxB22grcB281coPisriF
 Zy0uaGVDeUkvF5RsSvZyBKrWxPetZRtu9BQRAPvfEtTFvjMUjQXHbuGUBipGcn5RgDnb
 EpMn6mRgT28vQGT3EW/G74NHe7qcDhF4pxCVAkh5z7obc0SeZgLWsEMQd63wmkVP4cLc 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usex6hrys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 13:39:04 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B4CmBAm005380;
	Mon, 4 Dec 2023 13:39:04 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usex6hry8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 13:39:04 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4AnGWn015310;
	Mon, 4 Dec 2023 13:39:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urewt8hve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 13:39:02 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B4Dd1Wi63504832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 13:39:01 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3349D20040;
	Mon,  4 Dec 2023 13:39:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E724A20043;
	Mon,  4 Dec 2023 13:38:53 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.24.253])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  4 Dec 2023 13:38:53 +0000 (GMT)
Date: Mon, 4 Dec 2023 19:08:47 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
Subject: Re: [RFC 0/7] ext4: Allocator changes for atomic write support with
 DIO
Message-ID: <ZW3WZ6prrdsPc55Z@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <8c06c139-f994-442b-925e-e177ef2c5adb@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c06c139-f994-442b-925e-e177ef2c5adb@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pqMqYZoB5u1kPGItM7FXb3lU_mohMlQE
X-Proofpoint-GUID: AmoxTpAGqRo9ZBjsPI0fNlAXgV9Pduud
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_12,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2312040102

Hi John,

Thanks for the review. 

On Mon, Dec 04, 2023 at 10:36:01AM +0000, John Garry wrote:
> On 30/11/2023 13:53, Ojaswin Mujoo wrote:
> 
> Thanks for putting this together.
> 
> > This patch series builds on top of John Gary's atomic direct write
> > patch series [1] and enables this support in ext4. This is a 2 step
> > process:
> > 
> > 1. Enable aligned allocation in ext4 mballoc. This allows us to allocate
> > power-of-2 aligned physical blocks, which is needed for atomic writes.
> > 
> > 2. Hook the direct IO path in ext4 to use aligned allocation to obtain
> > physical blocks at a given alignment, which is needed for atomic IO. If
> > for any reason we are not able to obtain blocks at given alignment we
> > fail the atomic write.
> 
> So are we supposed to be doing atomic writes on unwritten ranges only in the
> file to get the aligned allocations?

If we do an atomic write on a hole, ext4 will give us an aligned extent
provided the hole is big enough to accomodate it. 

However, if we do an atomic write on a existing extent (written or
unwritten) ext4 would check if it satisfies the alignment and length
requirement and returns an error if it doesn't. Since we don't have cow
like functionality afaik the only way we could let this kind of write go
through is by punching the pre-existing extent which is not something we
can directly do in the same write operation, hence we return error.

> 
> I actually tried that, and I got a WARN triggered:
> 
> # mkfs.ext4 /dev/sda
> mke2fs 1.46.5 (30-Dec-2021)
> Creating filesystem with 358400 1k blocks and 89760 inodes
> Filesystem UUID: 7543a44b-2957-4ddc-9d4a-db3a5fd019c9
> Superblock backups stored on blocks:
>         8193, 24577, 40961, 57345, 73729, 204801, 221185
> 
> Allocating group tables: done
> Writing inode tables: done
> Creating journal (8192 blocks): done
> Writing superblocks and filesystem accounting information: done
> 
> [   12.745889] mkfs.ext4 (150) used greatest stack depth: 13304 bytes left
> # mount /dev/sda mnt
> [   12.798804] EXT4-fs (sda): mounted filesystem
> 7543a44b-2957-4ddc-9d4a-db3a5fd019c9 r/w with ordered data mode. Quota
> mode: none.
> # touch mnt/file
> #
> # /test-statx -a /root/mnt/file
> statx(/root/mnt/file) = 0
> dump_statx results=5fff
>   Size: 0               Blocks: 0          IO Block: 1024    regular file
> Device: 08:00           Inode: 12          Links: 1
> Access: (0644/-rw-r--r--)  Uid:     0   Gid:     0
> Access: 2023-12-04 10:27:40.002848720+0000
> Modify: 2023-12-04 10:27:40.002848720+0000
> Change: 2023-12-04 10:27:40.002848720+0000
>  Birth: 2023-12-04 10:27:40.002848720+0000
> stx_attributes_mask=0x703874
>         STATX_ATTR_WRITE_ATOMIC set
>         unit min: 1024
>         uunit max: 524288
> Attributes: 0000000000400000 (........ ........ ........ ........
> ........ .?--.... ..---... .---.-..)
> #
> 
> 
> 
> looks ok so far, then write 4KB at offset 0:
> 
> # /test-pwritev2 -a -d -p 0 -l 4096  /root/mnt/file
> file=/root/mnt/file write_size=4096 offset=0 o_flags=0x4002 wr_flags=0x24
> [   46.813720] ------------[ cut here ]------------
> [   46.814934] WARNING: CPU: 1 PID: 158 at fs/ext4/mballoc.c:2991
> ext4_mb_regular_allocator+0xeca/0xf20
> [   46.816344] Modules linked in:
> [   46.816831] CPU: 1 PID: 158 Comm: test-pwritev2 Not tainted
> 6.7.0-rc1-00038-gae3807f27e7d-dirty #968
> [   46.818220] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS rel-1.16.0-0-gd239552c-rebuilt.opensuse.org 04/01/2014
> [   46.819886] RIP: 0010:ext4_mb_regular_allocator+0xeca/0xf20
> [   46.820734] Code: fd ff ff f0 41 ff 81 e4 03 00 00 e9 63 fd ff ff
> 90 0f 0b 90 e9 fe f3 ff ff 90 48 c7 c7 e2 7a b2 86 44 89 ca e8 f7 f1
> d2 ff 90 <0f> 0b 90 90 45 8b 44 24 3c e9 d4 f3 ff ff 4d 8b 45 08 4c 89
> c2 4d
> [   46.823577] RSP: 0018:ffffb77dc056b7c0 EFLAGS: 00010286
> [   46.824379] RAX: 0000000000000000 RBX: ffff9b2ad77dea80 RCX:
> 0000000000000000
> [   46.825458] RDX: 0000000000000001 RSI: ffff9b2b3491b5c0 RDI:
> ffff9b2b3491b5c0
> [   46.826557] RBP: ffff9b2adc7cd000 R08: 0000000000000000 R09:
> c0000000ffffdfff
> [   46.827634] R10: ffff9b2adcb9d780 R11: ffffb77dc056b648 R12:
> ffff9b2ac6778000
> [   46.828714] R13: ffff9b2adc7cd000 R14: ffff9b2adc7d0000 R15:
> 000000000000002a
> [   46.829796] FS:  00007f726dece740(0000) GS:ffff9b2b34900000(0000)
> knlGS:0000000000000000
> [   46.830706] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   46.831299] CR2: 0000000001ed72b8 CR3: 000000001c794006 CR4:
> 0000000000370ef0
> [   46.832041] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> 0000000000000000
> [   46.832813] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> 0000000000000400
> [   46.833546] Call Trace:
> [   46.833901]  <TASK>
> [   46.834163]  ? __warn+0x78/0x130
> [   46.834504]  ? ext4_mb_regular_allocator+0xeca/0xf20
> [   46.835037]  ? report_bug+0xf8/0x1e0
> [   46.835527]  ? console_unlock+0x45/0xd0
> [   46.835963]  ? handle_bug+0x40/0x70
> [   46.836419]  ? exc_invalid_op+0x13/0x70
> [   46.836865]  ? asm_exc_invalid_op+0x16/0x20
> [   46.837329]  ? ext4_mb_regular_allocator+0xeca/0xf20
> [   46.837852]  ext4_mb_new_blocks+0x7e8/0xe60
> [   46.838382]  ? __kmalloc+0x4b/0x130
> [   46.838824]  ? __kmalloc+0x4b/0x130
> [   46.839243]  ? ext4_find_extent+0x347/0x360
> [   46.839743]  ext4_ext_map_blocks+0xc44/0xff0
> [   46.840395]  ext4_map_blocks+0x162/0x5b0
> [   46.841010]  ? jbd2__journal_start+0x84/0x1f0
> [   46.841694]  ext4_map_blocks_aligned+0x20/0xa0
> [   46.842382]  ext4_iomap_begin+0x1e9/0x320
> [   46.843006]  iomap_iter+0x16d/0x350
> [   46.843554]  __iomap_dio_rw+0x3be/0x830
> [   46.844150]  iomap_dio_rw+0x9/0x30
> [   46.844680]  ext4_file_write_iter+0x597/0x800
> [   46.845346]  do_iter_readv_writev+0xe1/0x150
> [   46.846029]  do_iter_write+0x86/0x1f0
> [   46.846638]  vfs_writev+0x96/0x190
> [   46.847176]  ? do_pwritev+0x98/0xd0
> [   46.847721]  do_pwritev+0x98/0xd0
> [   46.848230]  ? syscall_trace_enter.isra.19+0x130/0x1b0
> [   46.849028]  do_syscall_64+0x42/0xf0
> [   46.849590]  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> [   46.850405] RIP: 0033:0x7f726df9666f
> [   46.850964] Code: d5 41 54 49 89 f4 55 89 fd 53 44 89 c3 48 83 ec
> 18 80 3d bb fd 0b 00 00 74 2a 45 89 c1 49 89 ca 45 31 c0 b8 48 01 00
> 00 0f 05 <48> 3d 00 f0 ff ff 76 5c 48 8b 15 7a 77 0b 00 f7 d8 64 89 02
> 48 83
> [   46.854020] RSP: 002b:00007fff28b9bff0 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000148
> [   46.855178] RAX: ffffffffffffffda RBX: 0000000000000024 RCX:
> 00007f726df9666f
> [   46.856248] RDX: 0000000000000001 RSI: 00007fff28b9c050 RDI:
> 0000000000000003
> [   46.857303] RBP: 0000000000000003 R08: 0000000000000000 R09:
> 0000000000000024
> [   46.858365] R10: 0000000000000000 R11: 0000000000000246 R12:
> 00007fff28b9c050
> [   46.859407] R13: 0000000000000001 R14: 0000000000000000 R15:
> 00007f726e08aa60
> [   46.860448]  </TASK>
> [   46.860797] ---[ end trace 0000000000000000 ]---
> [   46.861497] EXT4-fs warning (device sda):
> ext4_map_blocks_aligned:520: Returned extent couldn't satisfy
> alignment requirements
> main wrote -1 bytes at offset 0
> [   46.863855] test-pwritev2 (158) used greatest stack depth: 11920 bytes
> left
> #
> 
> Please note that I tested on my own dev branch, which contains changes over
> [1], but I expect it would not make a difference for this test.

Hmm this should not ideally happen, can you please share your test
script with me if possible?

> 
> 
> > 
> > Currently this RFC does not impose any restrictions for atomic and non-atomic
> > allocations to any inode,  which also leaves policy decisions to user-space
> > as much as possible. So, for example, the user space can:
> > 
> >   * Do an atomic direct IO at any alignment and size provided it
> >     satisfies underlying device constraints. The only restriction for now
> >     is that it should be power of 2 len and atleast of FS block size.
> > 
> >   * Do any combination of non atomic and atomic writes on the same file
> >     in any order. As long as the user space is passing the RWF_ATOMIC flag
> >     to pwritev2() it is guaranteed to do an atomic IO (or fail if not
> >     possible).
> > 
> > There are some TODOs on the allocator side which are remaining like...
> > 
> > 1.  Fallback to original request size when normalized request size (due to
> >      preallocation) allocation is not possible.
> > 2.  Testing some edge cases.
> > 
> > But since all the basic test scenarios were covered, hence we wanted to get
> > this RFC out for discussion on atomic write support for DIO in ext4.
> > 
> > Further points for discussion -
> > 
> > 1. We might need an inode flag to identify that the inode has blocks/extents
> > atomically allocated. So that other userspace tools do not move the blocks of
> > the inode for e.g. during resize/fsck etc.
> >    a. Should inode be marked as atomic similar to how we have IS_DAX(inode)
> >    implementation? Any thoughts?
> > 
> > 2. Should there be support for open flags like O_ATOMIC. So that in case if
> > user wants to do only atomic writes to an open fd, then all writes can be
> > considered atomic.
> > 
> > 3. Do we need to have any feature compat flags for FS? (IMO) It doesn't look
> > like since say if there are block allocations done which were done atomically,
> > it should not matter to FS w.r.t compatibility.
> > 
> > 4. Mostly aligned allocations are required when we don't have data=journal
> > mode. So should we return -EIO with data journalling mode for DIO request?
> > 
> > Script to test using pwritev2() can be found here:
> > https://gist.github.com/OjaswinM/e67accee3cbb7832bd3f1a9543c01da9
> 
> Please note that the posix_memalign() call in the program should PAGE align.

Why do you say that? direct IO seems to be working when the userspace
buffer is 512 byte aligned, am I missing something?

Regards,
ojaswin

PS: I'm on vacation this week so might be a bit slow to address all the
review comments.

> 
> Thanks,
> John

