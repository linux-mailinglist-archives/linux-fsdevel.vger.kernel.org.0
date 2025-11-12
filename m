Return-Path: <linux-fsdevel+bounces-68044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5021DC51DEF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 12:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45ADE3AEF18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 11:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFB130BF66;
	Wed, 12 Nov 2025 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oPCzVNga"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC8B2FDC5B;
	Wed, 12 Nov 2025 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945640; cv=none; b=hY04JCH//ZorcCMj1xCEVMRnp0qam5d/luQrfSVV8k4hTr+68BJih/DkkxkC6Iz5NsbrBA6pUj9sPvLtNLuB6CCw/nxJYOcDzGUJQPD2NYfZ/PyDehF1AF3c1sp2WMlz7TZ16LaXM6/qyUJMTpVtP1CmkZ/Oy7A45DKTm0VWoao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945640; c=relaxed/simple;
	bh=buE5ncHJMikMWe3RFoP0J2mUOCgeUkxHQ9GqOKiC2Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3AVNfP8pzi11aEt+nuFhhug5Y1Y9T3zu98P+icq4LzBASCTcTnG3uAK7omk79r7aL1SP/CRVuDCRilp9tlDgfolQWDoohLgF4j8HWr17+ep59wLlOgXAX2uGhlV0zq7/+1eBt0+JcrMjO82h/5WyjMUVOVkdfkKRORkTOsVsCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oPCzVNga; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC5uvrq025241;
	Wed, 12 Nov 2025 11:06:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tYBzlMluwsbHKCVcq0twUKYhrQ+ptfpgJmIv6rRZz
	u8=; b=oPCzVNgaWIrKiSUDHN8sSXW7GsJ9dYYsGIWxhZfBRllX2tWkQxqlSjNCx
	fnXHHnsSvddyXiiE990ITx6hviLluSNHD43TDvyy9ZiByZnZIH9stMiBGkZGl7gd
	zqSUyCgzuW+g9D7eYump3ku8/QjIL4kTKM1FOgI7BaQbWfo/h//jt2n6gzfDLv12
	XgXkyPZhGIotfQwA5c+NQrRNnxQkIA7TJ2jbZq3AxERW/5UuTgmNMTv1Im+vrsIz
	f6Ry6LfSXNwzRNdZzUIzkHUqaS5sY5ectNbWQwmxANxKS5EruOyPHJ0fDx3ZlH/P
	IT+Vu98eCdXK9efDsTDaHez5nJpOg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjymj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:06:45 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5ACB5Afb023927;
	Wed, 12 Nov 2025 11:06:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aa5tjymj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:06:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AC9xYoC007313;
	Wed, 12 Nov 2025 11:06:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdjfjkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:06:43 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ACB6gB615991266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Nov 2025 11:06:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 358AC2004B;
	Wed, 12 Nov 2025 11:06:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61D7120040;
	Wed, 12 Nov 2025 11:06:35 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.190])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Nov 2025 11:06:35 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
        ritesh.list@gmail.com, john.g.garry@oracle.com, tytso@mit.edu,
        willy@infradead.org, dchinner@redhat.com, hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com,
        martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
Date: Wed, 12 Nov 2025 16:36:03 +0530
Message-ID: <cover.1762945505.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ztNLutqFQyZSVfciFckg7VeDJQL8ZM4W
X-Proofpoint-ORIG-GUID: a4RxntF_YGKVbOV_uzj9QeH2pP7F7lIR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA5OSBTYWx0ZWRfX7cKGmobGS9D+
 kz38uvdHIZPD0+uYpqfSlI4T9Wf1CBtuKcoT1q482xr8c1Lal/p8JLAQsnEzMxTks60IJPaW4k6
 DD80ZumvhYuUvtKbrorpfA9Kz3QYuqK9AFeNb4njEDzJDx+DT7T+AFnwS3t2duwdVI5wK2HqpKC
 uZUIQeosYNAxkQjehYfjekHNRwCjV4lRQiymbRKFhtNxUJFk1/kMiyYJ50U2TpsJ6giIroxpFq0
 dr5ezNZ572sYznpmLnoIczhLt2ybdV4wJHYqyRCRHX22CJCNCqev0mLINWdqbVgH9FJIp9ifgPj
 nwjAvOhs5wcM87/Mrg3k/UO5dQ3FuBTVZ7EDJ09t9zbmtImJkKJ/VempAyEJ51jhgOgDH+bQP2y
 pH6i8La+uWErKe/1IPcOXBhvV6V6Cg==
X-Authority-Analysis: v=2.4 cv=V6xwEOni c=1 sm=1 tr=0 ts=69146a45 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=JfrnYn6hAAAA:8 a=LdkhcUUB4uF8gWK5nKsA:9 a=1CNFftbPRP8L7MoqJWF3:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080099

This patch adds support to perform single block RWF_ATOMIC writes for
iomap xfs buffered IO. This builds upon the inital RFC shared by John
Garry last year [1]. Most of the details are present in the respective 
commit messages but I'd mention some of the design points below:

1. The first 4 patches introduce the statx and iomap plubming and page
flags to add basic atomic writes support to buffered IO. However, there
are still 2 key restrictions that apply:

FIRST: If the user buffer of atomic write crosses page boundary, there's a
possibility of short write, example if 1 user page could not be faulted or got
reclaimed before the copy operation. For now don't allow such a scenario by
ensuring user buffer is page aligned. This way either the full write goes
through or nothing does. This is also discussed in Mathew Wilcox's comment here
[2]

This is lifted in patch 5. The approach we took was to:
 1. pin the user pages
 2. Create a BVEC out of the struct page to pass to
    copy_folio_from_iter_atomic() rather than the USER backed iter. We
    don't use the user iter directly because the pinned user page could
    still get unmapped from the process, leading to short writes.

This approach allows us to only proceed if we are sure we will not have a short
copy.

SECOND: We only support block size == page size buf-io atomic writes.
This is to avoid the following scenario:
 1. 4kb block atomic write marks the complete 64kb folio as
    atomic.
 2. Other writes, dirty the whole 64kb folio.
 3. Writeback sees the whole folio dirty and atomic and tries
    to send a 64kb atomic write, which might exceed the
    allowed atomic write size and fail.

Patch 7 adds support for sub-page atomic write tracking to remove this
restriction.  We do this by adding 2 more bitmaps to ifs to track atomic
write start and end.

Lastly, a non atomic write over an atomic write will remove the atomic
guarantee. Userspace is expected to make sure to sync the data to disk
after an atomic write before performing any overwrites.

This series has survived -g quick xfstests and I'll be continuing to
test it.  Just wanted to put out the RFC to get some reviews on the
design and suggestions on any better approaches.

[1] https://lore.kernel.org/all/20240422143923.3927601-1-john.g.garry@oracle.com/
[2] https://lore.kernel.org/all/ZiZ8XGZz46D3PRKr@casper.infradead.org/

Thanks,
Ojaswin

John Garry (2):
  fs: Rename STATX{_ATTR}_WRITE_ATOMIC -> STATX{_ATTR}_WRITE_ATOMIC_DIO
  mm: Add PG_atomic

Ojaswin Mujoo (6):
  fs: Add initial buffered atomic write support info to statx
  iomap: buffered atomic write support
  iomap: pin pages for RWF_ATOMIC buffered write
  xfs: Report atomic write min and max for buf io as well
  iomap: Add bs<ps buffered atomic writes support
  xfs: Lift the bs == ps restriction for HW buffered atomic writes

 .../filesystems/ext4/atomic_writes.rst        |   4 +-
 block/bdev.c                                  |   7 +-
 fs/ext4/inode.c                               |   9 +-
 fs/iomap/buffered-io.c                        | 395 ++++++++++++++++--
 fs/iomap/ioend.c                              |  21 +-
 fs/iomap/trace.h                              |  12 +-
 fs/read_write.c                               |   3 -
 fs/stat.c                                     |  33 +-
 fs/xfs/xfs_file.c                             |   9 +-
 fs/xfs/xfs_iops.c                             | 127 +++---
 fs/xfs/xfs_iops.h                             |   6 +-
 include/linux/fs.h                            |   3 +-
 include/linux/iomap.h                         |   3 +
 include/linux/page-flags.h                    |   5 +
 include/trace/events/mmflags.h                |   3 +-
 include/trace/misc/fs.h                       |   3 +-
 include/uapi/linux/stat.h                     |  10 +-
 tools/include/uapi/linux/stat.h               |  10 +-
 .../trace/beauty/include/uapi/linux/stat.h    |  10 +-
 19 files changed, 551 insertions(+), 122 deletions(-)

-- 
2.51.0


