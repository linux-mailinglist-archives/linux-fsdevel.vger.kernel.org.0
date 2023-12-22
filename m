Return-Path: <linux-fsdevel+bounces-6770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63D381C58A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 08:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63F731F228E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 07:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 307C9FBE9;
	Fri, 22 Dec 2023 07:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="e+DZminS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B9F9D2
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231222073145epoutp03bf64029259e65123351c16632ce21908~jFvBetBAB3151231512epoutp03m
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:31:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231222073145epoutp03bf64029259e65123351c16632ce21908~jFvBetBAB3151231512epoutp03m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703230305;
	bh=oYmWBQh8Xrm3dk31K6Vq7v1vH8yZ+PWQvUYQg3orms0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=e+DZminSJxfiARqH1GJUs6l/bC5XGRbQ4TQ2Ow5p4MiXSnKgs+jJdjT93dr1EUkrQ
	 qNQtJ9VHu74XQzy1PrsAhRuJ3ZfPZD8Uk3wE/TEWCB3VbIi0lHUSJm9bg5wl8G1Kpg
	 S6TOAzxXfWtfADspURJ4ksEubsf93TThkd0adNHs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231222073144epcas5p221f49405b58f0b52a58bec045d9b289b~jFvAzVYu42928829288epcas5p24;
	Fri, 22 Dec 2023 07:31:44 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SxJrv5z4Pz4x9Px; Fri, 22 Dec
	2023 07:31:43 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B2.34.08567.F5B35856; Fri, 22 Dec 2023 16:31:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231222061955epcas5p2ae80bc6bfd70bc2f3ddb147888899694~jEwTmHEuD1103911039epcas5p2u;
	Fri, 22 Dec 2023 06:19:55 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231222061955epsmtrp152c3cde84f77674032765036dd28668a~jEwTlEex31498714987epsmtrp1w;
	Fri, 22 Dec 2023 06:19:55 +0000 (GMT)
X-AuditID: b6c32a44-3abff70000002177-38-65853b5fe817
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F5.1D.07368.B8A25856; Fri, 22 Dec 2023 15:19:55 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231222061952epsmtip29f7ac2cf74112ad2e47a1ce7105ac1e8~jEwQU0C7h0289602896epsmtip2S;
	Fri, 22 Dec 2023 06:19:52 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
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
Subject: [PATCH v19 00/12] Implement copy offload support
Date: Fri, 22 Dec 2023 11:42:54 +0530
Message-Id: <20231222061313.12260-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1CTdRzH+z7Ps4ehwD3yI74gBa2zAoFtyfA7xqwusqf0Eq/6ox82duxp
	IPvlxkLiOiGdCsYvsTyGyA+5EYPgRFpDRAmOCCZ6akOggD8YiuwEkR9dcmKbg/K/1+fz/vz+
	3peN++d5hbLTVZmMViVVcMgNhKUnMipGIjIwvLs3I1HLwG84ml9aIVDjWDGJnD0PAXJ0HQOo
	uraSQCNd7RhqaOzF0MnuIYCm7EYMdY5uRTVH6wh0qbOfQLcuniFRlWnKC524bSVRfd8qhoZL
	pgAqPW7HkNWRB5BlpQpHzc45Av0+uhldf9zHehPS7cYxL/r6+HmCvjWop1vN+SR9oe4QPX2h
	HNAdI7kkfa6ojEUXHp4l6fmpUYKeu2wn6aI2M6AXWl+kWx33sWS/TzMS0xipjNFGMKpUtSxd
	JRdzdn0oeVsiiOfxY/hCtJ0ToZIqGTEnaXdyzM50hesInIivpAq9y5Us1ek43B2JWrU+k4lI
	U+syxRxGI1No4jSxOqlSp1fJY1VMZgKfx3td4ApMyUizmWwszQ/7Ds4sTpG5ID+pAHizIRUH
	vz2TRxaADWx/qgPA/OOFLLfgTz0EsKEuxyMsA2iqqiXWM8qsBZhH6ASw9LvHwGMYMFhkPu0y
	2GyS2gptT9juhECqCYft5/nuGJwaweDgFQvmFgIoIfyjrAd3M0FtgcNXh4CbfakEaB2zY+46
	kOLC4olNHvcm2F/ueDoEToXDwz9X4O6akKrwhvdnc3HPdEnwUWcx5uEAONPX5uXhUHiv+Oga
	Z8GGUz+SnuQjABpvG4FHeAMaBopxd2OcioQtF7ke9wvw+4FmzNPYDxauONbq+0Lr2XV+GTa1
	VJMeDoFDf+etMQ3bO5bWTroPdvUtkiUg3PjMPsZn9jH+37ka4GYQwmh0SjmTKtDwVUzWfw+b
	qla2gqd/ISrJCoarVmO7AcYG3QCycU6grzr6COPvK5Nmf81o1RKtXsHouoHAdeNSPDQoVe36
	TKpMCT9OyIuLj4+PE26L53OCfZ2GSpk/JZdmMhkMo2G063kY2zs0FzvImjTrPq6euHLs1bbE
	5vIdohvRkdvl0krLzCmlcPkG/tmXTvlf3zzYdS94MDulrYa8a1P5nOzNj35+evJAywHhHtEH
	MYTjdJDl81+yArMVC5LK3i/e+bUyfzqrPlxsujnS+olt8pqlO+zPGpFNgBkWL2H7fWqJt3QF
	SwHje3WPupW5Q5sN6asNDxK42jspe99PlF3128N6rkNsP/TKqOCsKF10rn7jTu3+4NdKvJPN
	IUW7m/GKLeGlI8R7OfNh49yBXHZ71EdhC7NhPT+plp/kmPTOvH/aXhJxTKaUwbqK1ctgIkaD
	xBZeY9Acv+naRr9t71banazUiQif/iJr8h2SyyF0aVJ+FK7VSf8FnkdSBZQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Rf0yMcRzHfZ/n6bmns+Ppanw7KU6Si8uZ2bdmtMk8IaP8pfy46VFN1+Wu
	8nvVDuma9GNU50dFO1wSV3Hpx3JFiIUcaa42OlIrrnK5pbKrmf777PV+vd//fCic30QIqNj4
	RFYRL40TklziQZPQa2Wm6Ay76mvOUlTx4imOrL/GCFRmvkCi/qYhgHoa0wEqvn6VQB8bazB0
	u+wJhnKN7wGymDQYqu/0QyVnSwlUV/+cQO2PrpCoSGvhoMwPBhLdbJnAUEe2BaCccyYMGXrS
	AHowVoSju/0/CPSscwFqG29xCoJMjcbMYdq67hNM+6skRq/LIJnK0hSmt7IQMLUfU0nmRlae
	E3NeNUgyVksnwfxoMJFMVpUOMMN6T0bfM4DtmLObuy6KjYtNZhX+6/dzY1q1rU4Jl/Yc7Rux
	kKkgI1gNnClIr4F5BjWmBlyKT9cC2J1u40wH7lA73oxP367w9sQ3zrSkwuD3oXygBhRF0n6w
	dZJycDfagEN7uWpqCactGLTabcDRdqUD4Lu8pqklgl4KO16+n+I8OhAazCbMMQRpf3ih22Ua
	u8DnhT2EA+P0Mlhxje/AOO0FVdWX8WwwVzPD0vy3NDOsYoDrgDuboJRFyw5IEiTx7BGxUipT
	JsVHiw/IZXow9WeRrwF0FU2IjQCjgBFAChe68eQrTrN8XpT02HFWId+nSIpjlUawgCKE83mS
	gstRfDpamsgeYtkEVvEvxShnQSp2paqgfG/DzsCk78+8xu/Qy5MFoV9igx7XBGcPnvu9SHp4
	0J5W4BnmFxa5Gvus9lr86Ocf/5EQwX1ZQMq80iUhiSb+pm2b34XN3RLhE9HvIVcpAgaqvZPF
	gUHFpg2fREJfFmnhCd49eyMuOiUBR1/NLhv8yimIDJ83XKrOD7St9V74BvTZam9UfOKFlNRv
	rxpAgtEjOcH2joPIhuqMdTpLam/ERmpH6MldrnTow3xf7iYG2Za0u7lZCy9mj7w81ha51Voy
	25UK7xMfjsms7Z58HZbV/FYXbh6SeLBzJve1uVybNfrl0PidW51DRa9zvS/Fmn16G/WaXPk9
	LX6wkBASyhipRIQrlNK/+5rgVlYDAAA=
X-CMS-MailID: 20231222061955epcas5p2ae80bc6bfd70bc2f3ddb147888899694
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231222061955epcas5p2ae80bc6bfd70bc2f3ddb147888899694
References: <CGME20231222061955epcas5p2ae80bc6bfd70bc2f3ddb147888899694@epcas5p2.samsung.com>

Hi Martin, Christoph,
We have addressed most of the review-comments received from community in
the previous iterations of this series.
Is it possible to know your opinion on this, what needs to be added to
get this series merged?

The patch series covers the points discussed in past and most recently
in LSFMM'23[0].
We have covered the initial agreed requirements in this patch set and
further additional features suggested by community.

This is next iteration of our previous patch set v18[1].
Copy offload is performed using two bio's -
1. Take a plug
2. The first bio containing destination info is prepared and sent,
        a request is formed.
3. This is followed by preparing and sending the second bio containing the
        source info.
4. This bio is merged with the request containing the destination info.
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
	[1] https://lore.kernel.org/all/20231206100253.13100-1-joshi.k@samsung.com/
	[2] https://qemu-project.gitlab.io/qemu/system/devices/nvme.html#simple-copy
	[3] https://github.com/nitesh-shetty/blktests/tree/feat/copy_offload/v19
	[4] https://github.com/OpenMPDK/fio/tree/copyoffload-3.35-v14

Changes since v18:
=================
        - block, nvmet, null: change of copy dst/src request opcodes form
            19,21 to 18,19 (Keith Busch)
            Change the copy bio submission order to destination copy bio
            first, followed by source copy bio. 

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


base-commit: ceb6a6f023fd3e8b07761ed900352ef574010bcb
-- 
2.35.1.500.gb896f729e2


