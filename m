Return-Path: <linux-fsdevel+bounces-4966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57197806C15
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9432815B9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D25230331
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GS6Q8Rlm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2600D65
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:10:24 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231206101020epoutp0374e7903bae3a61d263f0a848fe4b31e4~eNk69BCMl2139221392epoutp03y
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 10:10:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231206101020epoutp0374e7903bae3a61d263f0a848fe4b31e4~eNk69BCMl2139221392epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701857421;
	bh=NQaeqHb71WNuSDmwWjNfXLgGC7RzocU/JD+gw0HcLQk=;
	h=From:To:Cc:Subject:Date:References:From;
	b=GS6Q8Rlm1De0klM+dkBiDymuGnW/pD7ShpoWlQtAWqs9FDDY9BNoC4zpRFT4QLAIb
	 J7V23vrTHAfDrOV4paK/w3B07idQ6+L/3snXzPazaJfTD79HL1/PZm4rbjcXKDHGGL
	 cfLhfx6L7/GC3BjU8d2wFdDRtTDpxy/C7UOKM4kM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231206101020epcas5p32471be58337426ab9da53dbc8171a859~eNk6TpWLq0035500355epcas5p3W;
	Wed,  6 Dec 2023 10:10:20 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SlY7H17skz4x9Pw; Wed,  6 Dec
	2023 10:10:19 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E8.A6.10009.A8840756; Wed,  6 Dec 2023 19:10:18 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231206101018epcas5p1c4f2dc5149853412918e0270314f96b0~eNk4vZ4aI1278812788epcas5p1L;
	Wed,  6 Dec 2023 10:10:18 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231206101018epsmtrp268eb09e70ceb1c177042d903f892e793~eNk4uNXvj0924509245epsmtrp2a;
	Wed,  6 Dec 2023 10:10:18 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-a7-6570488a2926
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.6B.08755.A8840756; Wed,  6 Dec 2023 19:10:18 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231206101010epsmtip2e44b349e4d7137d786a243189fdbd6d2~eNkxKzG7r0666706667epsmtip2D;
	Wed,  6 Dec 2023 10:10:09 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, dm-devel@lists.linux.dev, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v18 00/12] Implement copy offload support
Date: Wed,  6 Dec 2023 15:32:32 +0530
Message-Id: <20231206100253.13100-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxjn3Ht7WzSQa2HjABl0TYhBBFqk5YCwKRC9UZex4MyCmVjoDSCl
	rX0w3ZjADJSB8twcRbAijA1kPqrjITAFnDwWHkqQxyKBrNUNAkwo4iRsay1u/vf7ft/vO7/v
	+845HJy7RHpwUuQaRiWXyPjkJqKp23erfwGtZASFGehq/z0cPV1ZI9DlR0UkmuteAsh0RwfQ
	xUtVBJq404qh+ss/Y6i06yFA5tEKDHVM+qHq3FoCtXf0EWjkViWJDHVmNioYayHRdz1/Y2i8
	2AxQSd4ohlpM2QA1rRlwdGVukUC9k55oaL2HtQvSrRWP2PTQ1HWCHhnQ0saGL0n6Rm0m/fsN
	PaDbJrJIuqawjEWfPb1A0k/NkwS9+NMoSRfebAD0stGLNprmsRjnuNTwZEYiZVQ8Rp6okKbI
	kyL4+2Pjo+JFYoHQXxiKQvg8uSSNieBHH4jx35Mis+6Az0uXyLRWKkaiVvMD3wlXKbQahpes
	UGsi+IxSKlMGKwPUkjS1Vp4UIGc0YUKBIEhkFR5NTc7uGCGU3x8+Md2WT2aB+ch84MiBVDCc
	zesl8sEmDpdqA/CX5nvAHiwBOPOrgWUPngHY0JyDvyoZWfl6I9EBYKlxim1LcKllAFevkfmA
	wyEpXzhcprXRrlQjDluvC216nJrA4MDtJsyWcKFCYc/yfdymJygfuKpLt9FOFILPa/Qsu5c3
	1D9YZdv5LbBPbyJsGLfyp388j9vOhJTBEfYbHhP2gmi4/scKZscucLbnJtuOPeDyQgdpx4nw
	gX5wQ6OBv7V3buB3YU5/0ct+cGv/V28F2r2c4dk1E2ajIeUE83K5dvXbcKrUvNGmG5wpr93A
	NHxc08yyb+Rj+KSugSwGXhWvTVDx2gQV/5tdBHgDcGeU6rQkRi1SBsmZT/67ykRFmhG8fPzb
	9rWAmek/A7oAxgFdAHJwvquTbEjBcJ2kkpOfMipFvEorY9RdQGTdagnu8Uaiwvp75Jp4YXCo
	IFgsFgeH7hAL+W5OczlVUi6VJNEwqQyjZFSv6jCOo0cW5tOd69Ln+p679wueX70u8khjwhFf
	86VnhvCDH+pqV/g+4Z3HPIMcnzx8npCg29luKhOMSys3p3uC4gzL0bHzY8DhnxOxRSyR4MXA
	+/Osw5lg8IAuoS/NlaUd84sMaR33S606yDmnLyph19WZjZt5XfVZFvf9Zsu3ygHL8NbWwvnw
	LbOHdn9+aNqSHzX7WWBN8Ztrk3cXC1ZlOSFn3MonG88cA9VR7mEfUccF8JSIW83LHu7l7V3f
	EbtyzhP3Pul/YSn/whcR0rGm8b+OS8S7992PQ+UfeG3fbvnq9rVK54xdg2Uh32SeuuJQEubg
	0PfW3bi8narOmb0ljtF7fmDVxegcFviEOlki3Iar1JJ/AUkDDpiFBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCSvG6XR0GqweZJkhbrTx1jtvj49TeL
	xeq7/WwWrw9/YrR4cqCd0WLBorksFjcP7GSyWLn6KJPFpEPXGC2eXp3FZLH3lrbFwrYlLBZ7
	9p5ksbi8aw6bxfxlT9ktuq/vYLNYfvwfk8WNCU8ZLSZ2XGWy2PGkkdFi2+/5zBbrXr9nsThx
	S9ri/N/jrA4SHjtn3WX3OH9vI4vH5bOlHptWdbJ5bF5S7/Fi80xGj903G9g8FvdNZvXobX7H
	5vHx6S0Wj/f7rrJ59G1ZxejxeZOcx6Ynb5kC+KK4bFJSczLLUov07RK4Mhr3XmYpWBFd8WB3
	F1sD41unLkZODgkBE4nLX6eydjFycQgJ7GaU6Jq+ng0iIS7RfO0HO4QtLLHy33N2iKKPjBL3
	119h7mLk4GAT0JS4MLkUJC4isINZ4ufaZiYQh1ngKZPEx5/fGEG6hQUsJY5/vgjWwCKgKvG9
	vQwkzCtgIfFj8UxWiAXyEjMvfWeHiAtKnJz5hAWknFlAXWL9PCGQMDNQSfPW2cwTGPlnIama
	hVA1C0nVAkbmVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYwfGspbmDcfuqD3qHGJk4
	GA8xSnAwK4nw5pzPTxXiTUmsrEotyo8vKs1JLT7EKM3BoiTOK/6iN0VIID2xJDU7NbUgtQgm
	y8TBKdXAdKWE98vTlnvJ/o9spj2ICXzpZplr4pMt/iHpmt3GzU8WZbEvMTac31f3uGLXmpkX
	ld55Xp8sLrVSXCJK7qg/+xFFcR65a4K+T45u1tLz7zQyDpAytat465Sm3/jO/+6Z3KeVNifP
	tczYcUnyIxNvw1q241/kjZx6LPJfyU/xmGATLyj25hyTwBP3jKe8K55PtP71WHv9pIyaX3Me
	zrBb+uHI2V113xrD5wcK1QV/mPI1fZq+rtHEF6lb2WqNVNPX8/XNW5u0W6ZD93PnCY1Vj/T9
	NygxaMypUs+NFDZm6DOJczTI+JWV77spTTXF/t6i8Hij5Geh3BaJ9neaJG+nT6+Pt9HsdxP+
	qVYy5aoSS3FGoqEWc1FxIgC25ruFVgMAAA==
X-CMS-MailID: 20231206101018epcas5p1c4f2dc5149853412918e0270314f96b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206101018epcas5p1c4f2dc5149853412918e0270314f96b0
References: <CGME20231206101018epcas5p1c4f2dc5149853412918e0270314f96b0@epcas5p1.samsung.com>

From: Nitesh Shetty <nj.shetty@samsung.com>

Hi Martin, Christoph,
We have addressed most of the review-comments received from community in
the previous iterations of this series.
Is it possible to know your opinion on this, what needs to be added to
get this series merged?

The patch series covers the points discussed in past and most recently
in LSFMM'23[0].
We have covered the initial agreed requirements in this patch set and
further additional features suggested by community.

This is next iteration of our previous patch set v17[1].
Copy offload is performed using two bio's -
1. Take a plug
2. The first bio containing source info is prepared and sent,
        a request is formed.
3. This is followed by preparing and sending the second bio containing the
        destination info.
4. This bio is merged with the request containing the source info.
5. The plug is released, and the request containing source and destination
        bio's is sent to the driver.
This design helps to avoid putting payload (token) in the request,
as sending payload that is not data to the device is considered a bad
approach.

So copy offload works only for request based storage drivers.
We can make use of copy emulation in case copy offload capability is
absent.

Overall series supports:
========================
	1. Driver
		- NVMe Copy command (single NS, TP 4065), including support
		in nvme-target (for block and file back end).

	2. Block layer
		- Block-generic copy (REQ_OP_COPY_DST/SRC), operation with
                  interface accommodating two block-devs
                - Merging copy requests in request layer
		- Emulation, for in-kernel user when offload is natively
                absent
		- dm-linear support (for cases not requiring split)

	3. User-interface
		- copy_file_range

Testing
=======
	Copy offload can be tested on:
	a. QEMU: NVME simple copy (TP 4065). By setting nvme-ns
		parameters mssrl,mcl, msrc. For more info [2].
	b. Null block device
        c. NVMe Fabrics loopback.
	d. blktests[3]

	Emulation can be tested on any device.

	fio[4].

Infra and plumbing:
===================
        We populate copy_file_range callback in def_blk_fops. 
        For devices that support copy-offload, use blkdev_copy_offload to
        achieve in-device copy.
        However for cases, where device doesn't support offload,
        use generic_copy_file_range.
        For in-kernel users (like NVMe fabrics), use blkdev_copy_offload
        if device is copy offload capable or else use emulation 
        using blkdev_copy_emulation.
        Modify checks in generic_copy_file_range to support block-device.

Blktests[3]
======================
	tests/block/035-040: Runs copy offload and emulation on null
                              block device.
	tests/block/050,055: Runs copy offload and emulation on test
                              nvme block device.
        tests/nvme/056-067: Create a loop backed fabrics device and
                              run copy offload and emulation.

Future Work
===========
	- loopback device copy offload support
	- upstream fio to use copy offload
	- upstream blktest to test copy offload
        - update man pages for copy_file_range
        - expand in-kernel users of copy offload

	These are to be taken up after this minimal series is agreed upon.

Additional links:
=================
	[0] https://lore.kernel.org/linux-nvme/CA+1E3rJ7BZ7LjQXXTdX+-0Edz=zT14mmPGMiVCzUgB33C60tbQ@mail.gmail.com/
            https://lore.kernel.org/linux-nvme/f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com/
            https://lore.kernel.org/linux-nvme/20230113094648.15614-1-nj.shetty@samsung.com/
	[1] https://lore.kernel.org/all/20231019110147.31672-1-nj.shetty@samsung.com/
	[2] https://qemu-project.gitlab.io/qemu/system/devices/nvme.html#simple-copy
	[3] https://github.com/nitesh-shetty/blktests/tree/feat/copy_offload/v15
	[4] https://github.com/OpenMPDK/fio/tree/copyoffload-3.35-v14

Changes since v17:
=================
        - block, nvmet: static error fixes (Dan Carpenter, kernel test robot) 
        - nvmet: pass COPY_FILE_SPLICE flag for vfs_copy_file_range in case
                        file backed nvmet device

Changes since v16:
=================
        - block: fixed memory leaks and renamed function (Jinyoung Choi)
        - nvmet: static error fixes (kernel test robot) 

Changes since v15:
=================
        - fs, nvmet: don't fallback to copy emulation for copy offload IO
                    failure, user can still use emulation by disabling
                    device offload (Hannes)
        - block: patch,function description changes (Hannes)
        - added Reviewed-by from Hannes and Luis.

Changes since v14:
=================
        - block: (Bart Van Assche)
            1. BLK_ prefix addition to COPY_MAX_BYES and COPY_MAX_SEGMENTS
            2. Improved function,patch,cover-letter description
            3. Simplified refcount updating.
        - null-blk, nvme:
            4. static warning fixes (kernel test robot)

Changes since v13:
=================
        - block:
            1. Simplified copy offload and emulation helpers, now
                  caller needs to decide between offload/emulation fallback
            2. src,dst bio order change (Christoph Hellwig)
            3. refcount changes similar to dio (Christoph Hellwig)
            4. Single outstanding IO for copy emulation (Christoph Hellwig)
            5. use copy_max_sectors to identify copy offload
                  capability and other reviews (Damien, Christoph)
            6. Return status in endio handler (Christoph Hellwig)
        - nvme-fabrics: fallback to emulation in case of partial
          offload completion
        - in kernel user addition (Ming lei)
        - indentation, documentation, minor fixes, misc changes (Damien,
          Christoph)
        - blktests changes to test kernel changes

Changes since v12:
=================
        - block,nvme: Replaced token based approach with request based
          single namespace capable approach (Christoph Hellwig)

Changes since v11:
=================
        - Documentation: Improved documentation (Damien Le Moal)
        - block,nvme: ssize_t return values (Darrick J. Wong)
        - block: token is allocated to SECTOR_SIZE (Matthew Wilcox)
        - block: mem leak fix (Maurizio Lombardi)

Changes since v10:
=================
        - NVMeOF: optimization in NVMe fabrics (Chaitanya Kulkarni)
        - NVMeOF: sparse warnings (kernel test robot)

Changes since v9:
=================
        - null_blk, improved documentation, minor fixes(Chaitanya Kulkarni)
        - fio, expanded testing and minor fixes (Vincent Fu)

Changes since v8:
=================
        - null_blk, copy_max_bytes_hw is made config fs parameter
          (Damien Le Moal)
        - Negative error handling in copy_file_range (Christian Brauner)
        - minor fixes, better documentation (Damien Le Moal)
        - fio upgraded to 3.34 (Vincent Fu)

Changes since v7:
=================
        - null block copy offload support for testing (Damien Le Moal)
        - adding direct flag check for copy offload to block device,
	  as we are using generic_copy_file_range for cached cases.
        - Minor fixes

Changes since v6:
=================
        - copy_file_range instead of ioctl for direct block device
        - Remove support for multi range (vectored) copy
        - Remove ioctl interface for copy.
        - Remove offload support in dm kcopyd.

Changes since v5:
=================
	- Addition of blktests (Chaitanya Kulkarni)
        - Minor fix for fabrics file backed path
        - Remove buggy zonefs copy file range implementation.

Changes since v4:
=================
	- make the offload and emulation design asynchronous (Hannes
	  Reinecke)
	- fabrics loopback support
	- sysfs naming improvements (Damien Le Moal)
	- use kfree() instead of kvfree() in cio_await_completion
	  (Damien Le Moal)
	- use ranges instead of rlist to represent range_entry (Damien
	  Le Moal)
	- change argument ordering in blk_copy_offload suggested (Damien
	  Le Moal)
	- removed multiple copy limit and merged into only one limit
	  (Damien Le Moal)
	- wrap overly long lines (Damien Le Moal)
	- other naming improvements and cleanups (Damien Le Moal)
	- correctly format the code example in description (Damien Le
	  Moal)
	- mark blk_copy_offload as static (kernel test robot)
	
Changes since v3:
=================
	- added copy_file_range support for zonefs
	- added documentation about new sysfs entries
	- incorporated review comments on v3
	- minor fixes

Changes since v2:
=================
	- fixed possible race condition reported by Damien Le Moal
	- new sysfs controls as suggested by Damien Le Moal
	- fixed possible memory leak reported by Dan Carpenter, lkp
	- minor fixes

Changes since v1:
=================
	- sysfs documentation (Greg KH)
        - 2 bios for copy operation (Bart Van Assche, Mikulas Patocka,
          Martin K. Petersen, Douglas Gilbert)
        - better payload design (Darrick J. Wong)

Anuj Gupta (1):
  fs/read_write: Enable copy_file_range for block device.

Nitesh Shetty (11):
  block: Introduce queue limits and sysfs for copy-offload support
  Add infrastructure for copy offload in block and request layer.
  block: add copy offload support
  block: add emulation for copy
  fs, block: copy_file_range for def_blk_ops for direct block device
  nvme: add copy offload support
  nvmet: add copy command support for bdev and file ns
  dm: Add support for copy offload
  dm: Enable copy offload for dm-linear target
  null: Enable trace capability for null block
  null_blk: add support for copy offload

 Documentation/ABI/stable/sysfs-block |  23 ++
 Documentation/block/null_blk.rst     |   5 +
 block/blk-core.c                     |   7 +
 block/blk-lib.c                      | 427 +++++++++++++++++++++++++++
 block/blk-merge.c                    |  41 +++
 block/blk-settings.c                 |  24 ++
 block/blk-sysfs.c                    |  36 +++
 block/blk.h                          |  16 +
 block/elevator.h                     |   1 +
 block/fops.c                         |  25 ++
 drivers/block/null_blk/Makefile      |   2 -
 drivers/block/null_blk/main.c        | 100 ++++++-
 drivers/block/null_blk/null_blk.h    |   1 +
 drivers/block/null_blk/trace.h       |  25 ++
 drivers/block/null_blk/zoned.c       |   1 -
 drivers/md/dm-linear.c               |   1 +
 drivers/md/dm-table.c                |  37 +++
 drivers/md/dm.c                      |   7 +
 drivers/nvme/host/constants.c        |   1 +
 drivers/nvme/host/core.c             |  79 +++++
 drivers/nvme/host/trace.c            |  19 ++
 drivers/nvme/target/admin-cmd.c      |   9 +-
 drivers/nvme/target/io-cmd-bdev.c    |  71 +++++
 drivers/nvme/target/io-cmd-file.c    |  50 ++++
 drivers/nvme/target/nvmet.h          |   1 +
 drivers/nvme/target/trace.c          |  19 ++
 fs/read_write.c                      |   8 +-
 include/linux/bio.h                  |   6 +-
 include/linux/blk_types.h            |  10 +
 include/linux/blkdev.h               |  22 ++
 include/linux/device-mapper.h        |   3 +
 include/linux/nvme.h                 |  43 ++-
 32 files changed, 1101 insertions(+), 19 deletions(-)


base-commit: 629a3b49f3f957e975253c54846090b8d5ed2e9b
-- 
2.35.1.500.gb896f729e2


