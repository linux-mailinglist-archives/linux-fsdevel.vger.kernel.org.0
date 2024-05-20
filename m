Return-Path: <linux-fsdevel+bounces-19783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E85F8C9C4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8145282FFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18CA53E05;
	Mon, 20 May 2024 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SD54xgsc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3CF36134
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205480; cv=none; b=AntluHkeQg86mprtjhhwz/U2UZPsQlV6ZjHcUpiAu8XggPO7RsbHHIvJer28fn9RyENA0c5MBl7ki7e6hIGOGhKC10dKBTaCIy96NG+iKb3faTHI/tge7Rk589wRhehY+X4KIRdhZQXOBywi2HylYUP/L2i0Hdxnte3eqyv9oUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205480; c=relaxed/simple;
	bh=F5oidIO6CFr95P1rfEJcdvU4uIMr6DxXCHRj+ysqgX0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=O951zRK6tTM+NY9jUzx8pmcmLaHQNYYL0NsrHOdpPVCabTHi00SEuenZgCte49gDS3AmhZ0Xour9EsX6+6zf7XIQNRu9u5ZF66ov3BE1Dmi6BZg7kHb/fLIgm+woIfwfA0TTXYTZqj4aBzBm2iweJcv/tpwSMucJ9n3UxtesOKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SD54xgsc; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240520114435epoutp038cb36ea7c5daaabfcffe9d420f715127~RL8lygZCm1613216132epoutp03r
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:44:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240520114435epoutp038cb36ea7c5daaabfcffe9d420f715127~RL8lygZCm1613216132epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716205475;
	bh=nZvkHT1lt0LzNUEo2BHBiYOt4MxSs+BxljLweoio5BU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=SD54xgsc7+STLFpzyfieySy0tbEMnd6HjmxdrNH3gxkLmvrft1r/KVKy6phhaXE3N
	 qUsZ3ZeXWXhY0Cb8ZwktCdG74ptmfd/JgLB0dz4DihFZgs7NzgcE8NzZdVpVi7HZH2
	 usDhvtpl54kSk5RWH0xuH3Gl6285iQMAXaUS+pig=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240520114434epcas5p1af2b69d9501ee06c7e2a923eb13bf1ce~RL8koQKSJ2914429144epcas5p1-;
	Mon, 20 May 2024 11:44:34 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VjbMN64ZZz4x9Pw; Mon, 20 May
	2024 11:44:32 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6E.42.09688.0A73B466; Mon, 20 May 2024 20:44:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240520102747epcas5p33497a911ca70c991e5da8e22c5d1336b~RK5i6gl6F1861718617epcas5p3D;
	Mon, 20 May 2024 10:27:47 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240520102747epsmtrp2694085b28c6a2bd03317edc7b8dee140~RK5i5ZN542052720527epsmtrp2a;
	Mon, 20 May 2024 10:27:47 +0000 (GMT)
X-AuditID: b6c32a4a-5dbff700000025d8-11-664b37a04b2e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	FA.CD.09238.3A52B466; Mon, 20 May 2024 19:27:47 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240520102743epsmtip28b6e7e61d17179c33f29dc63d637a33f~RK5fGWBoW2185521855epsmtip2U;
	Mon, 20 May 2024 10:27:43 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v20 00/12] Implement copy offload support
Date: Mon, 20 May 2024 15:50:13 +0530
Message-Id: <20240520102033.9361-1-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TazBcZxjud85xrKhks2g+pCWbZhqMy4rLp0U7YvSkMiHTmcyknUTO2BOU
	vWR3Bc1k4hJ1SQgaxKK7wUSDkqI71qVlxW3JmFZEUEG7MhJFSiaaMaK7dtPm3/M87/c+7+Wb
	l4VzlOb2rFihjJEI6XguuYNQ9Tg7uyn9ws56qqdcUKO2D0dp+Zs4qpu+RqLFnlWAip+9xJGu
	KxOgjXsjOGrpewSQsrKCQBNdagx1VBZi6HZdL4bKStIx1Lu1RKJCzQOA5sfkGOqcdEU3v6km
	UEfnIIFG28pJpLg1b45q+l9hqCBrDEOtulSAVBsKHDUsrhBoYNIBjWz2m32ylxq9H0ZpKyGl
	lk+bUyOPfiSo0XsJVFNtNkk1V1+iFppLAdU+kUJSVXnfmlG56cskpc6YMaP+np8kqJWfx0gq
	r6UWUMPKu+YR1l/EBcQwNJ+RODHCKBE/VhgdyA37PPJwpI+vJ8+N54/8uE5CWsAEckOORriF
	xsbrN8R1Ok/HJ+ilCFoq5XoEBUhECTLGKUYklQVyGTE/XuwtdpfSAmmCMNpdyMg+5Hl6evno
	H56Ji5lYWyDFitNJNf0PiRTQF5IDWCzI9oZyhU8O2MHisNsBTPkjx9xIVgF8WP/ERF4AqJWn
	6InFdoauTYsbA50ADqfNAiPJwGDbr1ozgy/JdoVDWyyDbsOuw+GV5gLCQHB2Mw5Te7owg5U1
	2x/eKK82M2CCfQA+VT0HBmyl13UdQ6SxnCOsu9OFG/XdcLBURxgwrtfTfyrbbgOy2y3gzbkK
	wpgQAlfquzEjtoZP+1tMfdvDteVOk2kivH39e9KYfBlA+bgcGAMfwwztNdwwAs52ho1tHkb5
	XVikbcCMhXfC3A2dyd8Ktn73Gu+H9Y1Kk78dfLCeasIU/EddvN0bh30K9tS/APnAUf7GPPI3
	5pH/X1kJ8Fpgx4ilgmhG6iP2EjKJ/31tlEjQBLZPxeWzVjA3+8xdAzAW0ADIwrk2Vk0tR85y
	rPh08teMRBQpSYhnpBrgo19yAW5vGyXS35pQFsnz9vf09vX19fY/5Mvj7rFazKjgc9jRtIyJ
	YxgxI3mdh7Es7FMwW5e7V4LKRBqhY7Ei83RuZmC2a+lE3Ez6NAj+/UJgsvrxpfE9lkEnxn/p
	JVVH5QOiwVR6qWHC7quTXl6C5nALm4LMqYM2K10u5aLhc6XUhf2SBjUvsXT2YnVJQ+HqZn7n
	albxIc/5KiLgz51XsVzVbwqOR9RWuK1g99s1wdFJTgv5azdA8vrL653OSfssQ3cRtKp7Pe95
	0eidgqt1HyTSc1Gusz+cKdIIDjiUX/Y9F7rPdepkITf7/dXxY8dHvG+d73uLFb73vYuf2mQd
	e9Vf4VfrP2Q3s3VqtPuvLjq/pmSp/p32MJtd94N7lr8s5195PPqRre2J9icDaRl9a8ePVFke
	XHfgEtIYmueCS6T0v7fYHqqzBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe897djwuRqfN8M0iY7EKNWsU8na1ouioRPUhgshs6dGsqWNz
	doWW62LLtBulU5uX5ZiLSl1eSmvMNm+JmRlNcAVtdCNt3SjyUmtFffvxf37P//ny0FD4ggyj
	0zOzOWWmTC6m+GRDmzh8QZUkIXVRflEUvtnlhDj33BjElqFCCr9r+wjw5Q/fIfbYTgH8o6cX
	YqvTDXB5ZRmJXbZmArdUXiCw2eIgcMkVLYEdE+8pfMH+FGDvgJ7ArYORuOKkkcQtrZ0k7r9T
	SmFDtTcIm9rHCXw+b4DATZ5jADf8MEB8490IiTsGZ+DesXbe6pls/5MEtqsSsc36oSC2111L
	sv09arau5jTF1huPsq/riwF716Wh2KqCizz2rHaYYptPPOexPu8gyY7cG6DYAmsNYB+WPwja
	LNrOX5HCydNzOOXCVbv4e1yfXlMKw84DpvZnpAY41+lAMI2YJchzpwvqAJ8WMncB8tSXw8Bg
	Oqoee/CHRcg8/iooIGkJ5NDYCB2gaYqJRN0TtD8PYRoh8mnPEP4FyDggenQd+1nELEVFpUae
	n0lGgt42fAZ+FvzKPS3dVOBAOLLcssFAPhV1FntIfz9k5qGbV4WBynCkvV0Cz4Ep+v8s/T9L
	/59VDmANmM4pVBlpGclShTST2x+tkmWo1Jlp0clZGXXg9xNEzG8CbsN4tB0QNLADRENxiKDO
	GpcqFKTIDh7ilFlJSrWcU9nBDJoUhwqkRSUpQiZNls3t4zgFp/w7JejgMA2h1TZpvoXETMw9
	nPR23fWmavP6E58E/bc75utWFXi7+deoxXufRcpPaSocm1ySI/d8LcSa6r7IacFhW/MOH5ty
	XtJ4xHtx0ubOS4/fbKjNGciPzWpebbof+9ld69nO31LcY7ZFBctGc63gy3h8WoN9+e7O9DAi
	Ptficli+jO5IVBcqpPohiSFp7qjVvK1meC+IcvaVyUXmUbTR3VjsjsMoLyZiTrxN6VML45Zp
	C6tCt+RM7hjeugO08etNb0hj66LlZbMTlyScmZVteXnr65yV3YPJr/qKKKs031egO65m1sY4
	TT2JMam8Q3Zd6KZt0ZUw6XiscuSr2mc8yFSIxKRqj0waAZUq2U/hf3iAcwMAAA==
X-CMS-MailID: 20240520102747epcas5p33497a911ca70c991e5da8e22c5d1336b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102747epcas5p33497a911ca70c991e5da8e22c5d1336b
References: <CGME20240520102747epcas5p33497a911ca70c991e5da8e22c5d1336b@epcas5p3.samsung.com>

The patch series covers the points discussed in the past and most recently
in LSFMM'24[0].
We have covered the initial agreed requirements in this patch set and
further additional features suggested by the community.

This is next iteration of our previous patch set v19[1].
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
        use splice_copy_file_range.
        For in-kernel users (like NVMe fabrics), use blkdev_copy_offload
        if device is copy offload capable or else use emulation
        using blkdev_copy_emulation.
        Modify checks in copy_file_range to support block-device.

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
	[1] https://lore.kernel.org/linux-nvme/20231222061313.12260-1-nj.shetty@samsung.com/
	[2] https://qemu-project.gitlab.io/qemu/system/devices/nvme.html#simple-copy
	[3] https://github.com/nitesh-shetty/blktests/tree/feat/copy_offload/v19
	[4] https://github.com/SamsungDS/fio/tree/copyoffload-3.35-v14

Changes since v19:
=================
        - block, nvme: update queue limits atomically
                Also remove reviewed by tag from Hannes and Luis for
                these patches. As we feel these patches changed
                significantly from the previous one.
        - vfs: generic_copy_file_range to splice_file_range
        - rebased to latest linux-next

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
 block/blk-settings.c                 |  34 ++-
 block/blk-sysfs.c                    |  43 +++
 block/blk.h                          |  16 +
 block/elevator.h                     |   1 +
 block/fops.c                         |  26 ++
 drivers/block/null_blk/Makefile      |   2 -
 drivers/block/null_blk/main.c        | 105 ++++++-
 drivers/block/null_blk/null_blk.h    |   1 +
 drivers/block/null_blk/trace.h       |  25 ++
 drivers/block/null_blk/zoned.c       |   1 -
 drivers/md/dm-linear.c               |   1 +
 drivers/md/dm-table.c                |  37 +++
 drivers/md/dm.c                      |   7 +
 drivers/nvme/host/constants.c        |   1 +
 drivers/nvme/host/core.c             |  81 ++++-
 drivers/nvme/host/trace.c            |  19 ++
 drivers/nvme/target/admin-cmd.c      |   9 +-
 drivers/nvme/target/io-cmd-bdev.c    |  71 +++++
 drivers/nvme/target/io-cmd-file.c    |  50 ++++
 drivers/nvme/target/nvmet.h          |   1 +
 drivers/nvme/target/trace.c          |  19 ++
 fs/read_write.c                      |   8 +-
 include/linux/bio.h                  |   6 +-
 include/linux/blk_types.h            |  10 +
 include/linux/blkdev.h               |  23 ++
 include/linux/device-mapper.h        |   3 +
 include/linux/nvme.h                 |  43 ++-
 32 files changed, 1124 insertions(+), 22 deletions(-)


base-commit: dbd9e2e056d8577375ae4b31ada94f8aa3769e8a
-- 
2.17.1


