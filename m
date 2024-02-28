Return-Path: <linux-fsdevel+bounces-13091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFF286B1FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 15:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9112B1F2469D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A85115B992;
	Wed, 28 Feb 2024 14:40:49 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6809415A4AE;
	Wed, 28 Feb 2024 14:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131249; cv=none; b=Mu7arhBW387g8vlpSgPZOsQipCOfa81PQE8+1uexYuDhSdqpkjYxvjop5FRerFzi4/ozqcHoui286mn0yOJCPoSQJ0pxqPcm7pr/4UKb2zvOj/f0RdHdDVGFVrGETfnPmPwaMY1jpzjJ6gtCtYw7OyvGzli6aiB/LsZcCV/WKMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131249; c=relaxed/simple;
	bh=XHXeXaJRpFl8dTOB0fKC2pb2+NvmS7IshikIKOOpEW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=No1rggB2K1hloGbW2mKR+maCalv4l2SHjGABmNvOZN0l+NE/D2wW+LeX1YfpR3+oUzWpCrAvX+SWpE1tOjGTCfkU9A+ISWm8C+46cD7FMIU+4SRHI7alz0wE08L/9tMZHI6vARTu0Huz2AvhVe++6CgVPghKVx6iR9PSAE2oi3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TlH8L6K18z4f3l1V;
	Wed, 28 Feb 2024 22:40:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 393841A0568;
	Wed, 28 Feb 2024 22:40:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgBnOBHkRd9lwGKzFQ--.18779S4;
	Wed, 28 Feb 2024 22:40:37 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	houtao1@huawei.com
Subject: [PATCH v2 0/6] virtiofs: fix the warning for ITER_KVEC dio
Date: Wed, 28 Feb 2024 22:41:20 +0800
Message-Id: <20240228144126.2864064-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnOBHkRd9lwGKzFQ--.18779S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZryxAw4xAF45KF1kZry8uFg_yoW5Ar1xpr
	WfKw45XrsxJFy7Ar93C3Z8Gw1rCws5JFy7W393Ww1UCa15X3W7uryqvFyYqry7ArykAFy8
	tr1Fqa4v9w1qv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set aims to fix the warning related to an abnormal size
parameter of kmalloc() in virtiofs. The warning occurred when attempting
to insert a 10MB sized kernel module kept in a virtiofs with cache
disabled. As analyzed in patch #1, the root cause is that the length of
the read buffer is no limited, and the read buffer is passed directly to
virtiofs through out_args[0].value. Therefore patch #1 limits the
length of the read buffer passed to virtiofs by using max_pages. However
it is not enough, because now the maximal value of max_pages is 256.
Consequently, when reading a 10MB-sized kernel module, the length of the
bounce buffer in virtiofs will be 40 + (256 * 4096), and kmalloc will
try to allocate 2MB from memory subsystem. The request for 2MB of
physically contiguous memory significantly stress the memory subsystem
and may fail indefinitely on hosts with fragmented memory. To address
this, patch #2~#5 use scattered pages in a bio_vec to replace the
kmalloc-allocated bounce buffer when the length of the bounce buffer for
KVEC_ITER dio is larger than PAGE_SIZE. The final issue with the
allocation of the bounce buffer and sg array in virtiofs is that
GFP_ATOMIC is used even when the allocation occurs in a kworker context.
Therefore the last patch uses GFP_NOFS for the allocation of both sg
array and bounce buffer when initiated by the kworker. For more details,
please check the individual patches.

As usual, comments are always welcome.

Change Log:

v2:
  * limit the length of ITER_KVEC dio by max_pages instead of the
    newly-introduced max_nopage_rw. Using max_pages make the ITER_KVEC
    dio being consistent with other rw operations.
  * replace kmalloc-allocated bounce buffer by using a bounce buffer
    backed by scattered pages when the length of the bounce buffer for
    KVEC_ITER dio is larger than PAG_SIZE, so even on hosts with
    fragmented memory, the KVEC_ITER dio can be handled normally by
    virtiofs. (Bernd Schubert)
  * merge the GFP_NOFS patch [1] into this patch-set and use
    memalloc_nofs_{save|restore}+GFP_KERNEL instead of GFP_NOFS
    (Benjamin Coddington)

v1: https://lore.kernel.org/linux-fsdevel/20240103105929.1902658-1-houtao@huaweicloud.com/

[1]: https://lore.kernel.org/linux-fsdevel/20240105105305.4052672-1-houtao@huaweicloud.com/

Hou Tao (6):
  fuse: limit the length of ITER_KVEC dio by max_pages
  virtiofs: move alloc/free of argbuf into separated helpers
  virtiofs: factor out more common methods for argbuf
  virtiofs: support bounce buffer backed by scattered pages
  virtiofs: use scattered bounce buffer for ITER_KVEC dio
  virtiofs: use GFP_NOFS when enqueuing request through kworker

 fs/fuse/file.c      |  12 +-
 fs/fuse/virtio_fs.c | 336 +++++++++++++++++++++++++++++++++++++-------
 2 files changed, 296 insertions(+), 52 deletions(-)

-- 
2.29.2


