Return-Path: <linux-fsdevel+bounces-3012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB9E7EF399
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 14:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED3D1C20AA8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Nov 2023 13:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5568931A79;
	Fri, 17 Nov 2023 13:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LwBmh/N3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40D4126
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 05:17:22 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231117131719euoutp01ee5959d4627d03ba965f79444a228ca4~Ya3vtWPry0398303983euoutp01f
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Nov 2023 13:17:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231117131719euoutp01ee5959d4627d03ba965f79444a228ca4~Ya3vtWPry0398303983euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1700227039;
	bh=wDiwPZC9xF7zrrtSoVNyFCB9isti/tAxLZUtARGHt2o=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=LwBmh/N3UsD0mZ7j52jcZDu3p0+5zoExuVWuMAeBID0k0EBQKlXJr37IXD3Vlxzbd
	 mpGXcPr/+4oEINH37i96/95d9bIQ/Wftqi0fIu1MI8T+Tz5nUbMYN6IiznPB+ivg92
	 y7kv7fxfCQHUeGn99RDYpToFQwhWW743z0aCQC34=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231117131719eucas1p20443f7ec12843a0258192a73c27a0134~Ya3vcWJXQ1476914769eucas1p2d;
	Fri, 17 Nov 2023 13:17:19 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id F5.F2.09814.ED767556; Fri, 17
	Nov 2023 13:17:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231117131718eucas1p13328b32942cce99a99197eb28e14a981~Ya3uxG5j10456804568eucas1p1u;
	Fri, 17 Nov 2023 13:17:18 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231117131718eusmtrp2d3420befe72f85bd54eca9ac707cfd8d~Ya3uwgViO1792817928eusmtrp2W;
	Fri, 17 Nov 2023 13:17:18 +0000 (GMT)
X-AuditID: cbfec7f4-711ff70000002656-12-655767de12d3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id C7.5C.09146.ED767556; Fri, 17
	Nov 2023 13:17:18 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231117131717eusmtip1f0094167989a79e7143960d2d235cd09~Ya3uJaxuP0931909319eusmtip19;
	Fri, 17 Nov 2023 13:17:17 +0000 (GMT)
Message-ID: <b28b25ab-87eb-4905-855a-7809dda11f39@samsung.com>
Date: Fri, 17 Nov 2023 14:17:17 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] squashfs: fix oob in squashfs_readahead
Content-Language: en-US
To: Edward Adam Davis <eadavis@qq.com>,
	syzbot+604424eb051c2f696163@syzkaller.appspotmail.com
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, phillip@squashfs.org.uk,
	squashfs-devel@lists.sourceforge.net, syzkaller-bugs@googlegroups.com
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <tencent_35864B36740976B766CA3CC936A496AA3609@qq.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7r30sNTDVZOs7GYs34Nm8WqjU0s
	Fnv2nmSxuLxrDpvF0Z7NbBZXd9Vb3DkUaHFjy1xmBw6PPRNPsnmcmPGbxWP3gs9MHreerWX1
	mPL1ObPHzLdqHp83yQWwR3HZpKTmZJalFunbJXBl7LzYy17wTLOiYeMpxgbG10pdjJwcEgIm
	EqsWrWTvYuTiEBJYwShxZ28zM4TzhVHi57r3TBDOZ0aJo4tvscK0TDvZB5VYziix5dUvKOcj
	o8SNx0cYQap4Bewk5u16wgRiswioSnQ1L2eFiAtKnJz5hAXEFhWQl7h/awY7iC0sYCOxvvs5
	WA2zgLjErSfzwXpFBOIl+vY0gi1gFtgHtODjWrAEm4ChRNfbLjYQm1PASeL9twnMEM3yEtvf
	zmGGOPUNh8TrMzUQtovEs3sPoV4Qlnh1fAs7hC0j8X/nfLAFEgLtjBILft+HciYwSjQ8v8UI
	UWUtcefcL6BtHEAbNCXW79KHCDtK/O6fwAgSlhDgk7jxVhDiBj6JSdumM0OEeSU62oQgqtUk
	Zh1fB7f24IVLzBMYlWYhBcssJO/PQvLNLIS9CxhZVjGKp5YW56anFhvlpZbrFSfmFpfmpesl
	5+duYgSmp9P/jn/Zwbj81Ue9Q4xMHIyHGCU4mJVEeM3lQlKFeFMSK6tSi/Lji0pzUosPMUpz
	sCiJ86qmyKcKCaQnlqRmp6YWpBbBZJk4OKUamCKCHz+doZipE/bM073w+ZN5P/159q14JLir
	J3uV4KsnyXErrNVbwp85LjhZd7i6cWah3vsu3zDZ0i+JzU5ii5jPF4YsObLbnqX0b+SnbD03
	u7WCK7i6TvSIS+8WOBkieaH1zWuZtnKPUtniCEGxmakLFJRXZ+YVmgiv3fddb49D+LFjirna
	NZ6+TM2GE+uLvdweGbhtYJtwsVbH+eu9/gffy0NMD99ZKTp5y/Qfr0t3vg411heMcM2P/pHx
	bEbwMhUlcQbWS9fkvj12+vtd7+g2jX2O16a0f1duNsyalbXEiinXdNWv3mWO9yO1Tr/pCTTW
	OdGsu3fNi/CJ7KdLOP+dL5cSPZmhVPLY99J/JZbijERDLeai4kQAhrMGYb4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsVy+t/xu7r30sNTDZ7e4LeYs34Nm8WqjU0s
	Fnv2nmSxuLxrDpvF0Z7NbBZXd9Vb3DkUaHFjy1xmBw6PPRNPsnmcmPGbxWP3gs9MHreerWX1
	mPL1ObPHzLdqHp83yQWwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZ
	pKTmZJalFunbJehl7LzYy17wTLOiYeMpxgbG10pdjJwcEgImEtNO9jGB2EICSxklVk7QhIjL
	SJyc1sAKYQtL/LnWxdbFyAVU855R4k3zNGaQBK+AncS8XU/AmlkEVCW6mpezQsQFJU7OfMIC
	YosKyEvcvzWDHcQWFrCRWN/9HKyGWUBc4taT+WC9IgLxEp1zt7KDLGAW2McoMeHCXmaIi3Il
	Znz5ANbAJmAo0fUW5ApODk4BJ4n33yYwQwwyk+ja2sUIYctLbH87h3kCo9AsJHfMQrJvFpKW
	WUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMxm3Hfm7ewTjv1Ue9Q4xMHIyHGCU4
	mJVEeM3lQlKFeFMSK6tSi/Lji0pzUosPMZoCA2Mis5Rocj4wHeSVxBuaGZgamphZGphamhkr
	ifN6FnQkCgmkJ5akZqemFqQWwfQxcXBKNTA5/9AQZ5of03Ahs8TRQvMg0w228ydjRI7b7n9T
	tGmdpMC885xv5bXbk6eJeegsagnTPqvSGBOiy+H/NVT7+83tAYwcOVt1bBiDfbi+RbR7hNyR
	kHrwy4X5/BepH8fEDE8ov8+1dtGd6ZG3wiZk1r/q4l8bP38qey92fi7Taybfw01eZ1R8z+Rw
	1idoz2LYf0A9a8Wmg/e37mEo7S+cc3KD76p5atE2+hl9OQ07/ym7XjNS7vay5xYNYrghl1jc
	7n5F939L0dqjf+V+q5/W8k2X3zCjSeHm0R2aTK8jNF7a5PMUXWcIUSwuivN5f/S3kbK316ej
	CZnZLw3S+Pj+fYjnDKkzjmK0LqjImfpMiaU4I9FQi7moOBEA3ld5908DAAA=
X-CMS-MailID: 20231117131718eucas1p13328b32942cce99a99197eb28e14a981
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231117131718eucas1p13328b32942cce99a99197eb28e14a981
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231117131718eucas1p13328b32942cce99a99197eb28e14a981
References: <000000000000b1fda20609ede0d1@google.com>
	<tencent_35864B36740976B766CA3CC936A496AA3609@qq.com>
	<CGME20231117131718eucas1p13328b32942cce99a99197eb28e14a981@eucas1p1.samsung.com>

Hi All,

On 15.11.2023 05:05, Edward Adam Davis wrote:
> [Syz log]
> SQUASHFS error: Failed to read block 0x6fc: -5
> SQUASHFS error: Unable to read metadata cache entry [6fa]
> SQUASHFS error: Unable to read metadata cache entry [6fa]
> SQUASHFS error: Unable to read metadata cache entry [6fa]
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in __readahead_batch include/linux/pagemap.h:1364 [inline]
> BUG: KASAN: slab-out-of-bounds in squashfs_readahead+0x9a6/0x20d0 fs/squashfs/file.c:569
> Write of size 8 at addr ffff88801e393648 by task syz-executor100/5067
>
> CPU: 1 PID: 5067 Comm: syz-executor100 Not tainted 6.6.0-syzkaller-15156-g13d88ac54ddd #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>   print_address_description mm/kasan/report.c:364 [inline]
>   print_report+0x163/0x540 mm/kasan/report.c:475
>   kasan_report+0x142/0x170 mm/kasan/report.c:588
>   __readahead_batch include/linux/pagemap.h:1364 [inline]
>   squashfs_readahead+0x9a6/0x20d0 fs/squashfs/file.c:569
>   read_pages+0x183/0x830 mm/readahead.c:160
>   page_cache_ra_unbounded+0x68e/0x7c0 mm/readahead.c:269
>   page_cache_sync_readahead include/linux/pagemap.h:1266 [inline]
>   filemap_get_pages+0x49c/0x2080 mm/filemap.c:2497
>   filemap_read+0x42b/0x10b0 mm/filemap.c:2593
>   __kernel_read+0x425/0x8b0 fs/read_write.c:428
>   integrity_kernel_read+0xb0/0xf0 security/integrity/iint.c:221
>   ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
>   ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
>   ima_calc_file_hash+0xad1/0x1b30 security/integrity/ima/ima_crypto.c:573
>   ima_collect_measurement+0x554/0xb30 security/integrity/ima/ima_api.c:290
>   process_measurement+0x1373/0x21c0 security/integrity/ima/ima_main.c:359
>   ima_file_check+0xf1/0x170 security/integrity/ima/ima_main.c:557
>   do_open fs/namei.c:3624 [inline]
>   path_openat+0x2893/0x3280 fs/namei.c:3779
>
> [Bug]
> path_openat() called open_last_lookups() before calling do_open() and
> open_last_lookups() will eventually call squashfs_read_inode() to set
> inode->i_size, but before setting i_size, it is necessary to obtain file_size
> from the disk.
>
> However, during the value retrieval process, the length of the value retrieved
> from the disk was greater than output->length, resulting(-EIO) in the failure of
> squashfs_read_data(), further leading to i_size has not been initialized,
> i.e. its value is 0.
>
> This resulted in the failure of squashfs_read_data(), where "SQUASHFS error:
> Failed to read block 0x6fc: -5" was output in the syz log.
> This also resulted in the failure of squashfs_cache_get(), outputting "SQUASHFS
> error: Unable to read metadata cache entry [6fa]" in the syz log.
>
> [Fix]
> Before performing a read ahead operation in squashfs_read_folio() and
> squashfs_readahead(), check if i_size is not 0 before continuing.
>
> Optimize the return value of squashfs_read_data() and return -EFBIG when the
> length is greater than output->length(or (index + length) >
> msblk->bytes_used).
>
> Reported-and-tested-by: syzbot+604424eb051c2f696163@syzkaller.appspotmail.com
> Fixes: f268eedddf35 ("squashfs: extend "page actor" to handle missing pages")
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

This patch, merged to linux-next as commit 1ff947abe24a ("squashfs: fix 
oob in squashfs_readahead"), breaks mounting squashfs volumes on all my 
test systems. Let me know if you need more information to debug this issue.

> ---
>   fs/squashfs/block.c | 2 +-
>   fs/squashfs/file.c  | 8 ++++++++
>   2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
> index 581ce9519339..d335f28c822c 100644
> --- a/fs/squashfs/block.c
> +++ b/fs/squashfs/block.c
> @@ -323,7 +323,7 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
>   	}
>   	if (length < 0 || length > output->length ||
>   			(index + length) > msblk->bytes_used) {
> -		res = -EIO;
> +		res = length < 0 ? -EIO : -EFBIG;
>   		goto out;
>   	}
>   
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index 8ba8c4c50770..5472ddd3596c 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -461,6 +461,11 @@ static int squashfs_read_folio(struct file *file, struct folio *folio)
>   	TRACE("Entered squashfs_readpage, page index %lx, start block %llx\n",
>   				page->index, squashfs_i(inode)->start);
>   
> +	if (!file_end) {
> +		res = -EINVAL;
> +		goto out;
> +	}
> +
>   	if (page->index >= ((i_size_read(inode) + PAGE_SIZE - 1) >>
>   					PAGE_SHIFT))
>   		goto out;
> @@ -547,6 +552,9 @@ static void squashfs_readahead(struct readahead_control *ractl)
>   	int i, file_end = i_size_read(inode) >> msblk->block_log;
>   	unsigned int max_pages = 1UL << shift;
>   
> +	if (!file_end)
> +		return;
> +
>   	readahead_expand(ractl, start, (len | mask) + 1);
>   
>   	pages = kmalloc_array(max_pages, sizeof(void *), GFP_KERNEL);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


