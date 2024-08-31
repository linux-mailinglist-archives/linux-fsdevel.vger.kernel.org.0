Return-Path: <linux-fsdevel+bounces-28102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A8896707C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 11:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6661F23408
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Aug 2024 09:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF556178381;
	Sat, 31 Aug 2024 09:37:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C152616DC33;
	Sat, 31 Aug 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097077; cv=none; b=CEoG/rGYkkGcKbagUPuYQ9bDdCmacFBczLT9mtP9eMSUxxGnxG8JfIh4s4lcjZeXDQ9xQI1gN2d6NTD4j/b9E+WLwAn0EjCukElL5ObazLcwAZ6vqSypOG3QMOilcS7U3WWEaYiR4tdR/wilm9KYKv/Nu16MFIqLNW1KzzENh94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097077; c=relaxed/simple;
	bh=1lL0P5MhRS+DnyvL7X98m5nvWYYL0N6ajAaOdNJWiQ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z2MPIOi6NSjJ9GDqg8xffBRjbxdLfAk+rZ6Uz9cVVt5m9FmmV7fkaAbT94zhKHYXnkfqAqk9iHvBz/TRTvrW2Tm1FTLMt0ADzLzsZXGy8xNqAfiyd2C2SKdQa7SIzOkBN1koaWMIhwGn1V5oUNZ+Zk+EIOjV/yZpqQmgAa8TEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WwqgV2SmMz4f3jkJ;
	Sat, 31 Aug 2024 17:37:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6F4F21A07B6;
	Sat, 31 Aug 2024 17:37:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXzIJj5NJm0I_lDA--.58191S4;
	Sat, 31 Aug 2024 17:37:50 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Vivek Goyal <vgoyal@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Jingbo Xu <jefflexu@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	houtao1@huawei.com
Subject: [PATCH v4 0/2] virtiofs: fix the warning for kernel direct IO
Date: Sat, 31 Aug 2024 17:37:48 +0800
Message-Id: <20240831093750.1593871-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXzIJj5NJm0I_lDA--.58191S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZryxAw4xAry7JF1fXFWUArb_yoW5GF48pr
	WfGan8XrsrJryxJrs3A3WkuFyF9wn5JF47Xr93Ww1rZrW5ZF1I9rnFvF4F9ry7Ary8JFyY
	qr4SvF1qgryqv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU10PfPUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The patch set aims to fix the warning related to an abnormal size
parameter of kmalloc() in virtiofs. Patch #1 fixes it by introducing
use_pages_for_kvec_io option in fuse_conn and enabling it in virtiofs.
Beside the abnormal size parameter for kmalloc, the gfp parameter is
also questionable: GFP_ATOMIC is used even when the allocation occurs
in a kworker context. Patch #2 fixes it by using GFP_NOFS when the
allocation is initiated by the kworker. For more details, please check
the individual patches.

As usual, comments are always welcome.

Change Log:

v4:
 * patch 1: add the missed {flush|invalidate}_kernel_vmap_range() and
            update commit message accordingly
 * patch 2: update commit message to explain why GFP_ATOMIC is
            reasonable for the first invocation of
	    virtio_fs_enqueue_req().

v3: https://lore.kernel.org/linux-fsdevel/20240426143903.1305919-1-houtao@huaweicloud.com/
 * introduce use_pages_for_kvec_io for virtiofs. When the option is
   enabled, fuse will use iov_iter_extract_pages() to construct a page
   array and pass the pages array instead of a pointer to virtiofs.
   The benefit is twofold: the length of the data passed to virtiofs is
   limited by max_pages, and there is no memory copy compared with v2.

v2: https://lore.kernel.org/linux-fsdevel/20240228144126.2864064-1-houtao@huaweicloud.com/
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

Hou Tao (2):
  virtiofs: use pages instead of pointer for kernel direct IO
  virtiofs: use GFP_NOFS when enqueuing request through kworker

 fs/fuse/file.c      | 62 +++++++++++++++++++++++++++++++--------------
 fs/fuse/fuse_i.h    |  6 +++++
 fs/fuse/virtio_fs.c | 25 +++++++++++-------
 3 files changed, 65 insertions(+), 28 deletions(-)

-- 
2.29.2


