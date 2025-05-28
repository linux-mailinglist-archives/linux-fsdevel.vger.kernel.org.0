Return-Path: <linux-fsdevel+bounces-49954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C271CAC6418
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 10:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29C4F3ACE0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 08:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65459266B65;
	Wed, 28 May 2025 08:13:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBAE246791;
	Wed, 28 May 2025 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419987; cv=none; b=U+oVqU4q9Tjp14vahInxNTGOvdtxE4SwkMxMWNP3fHDzy+m6SzvwlBEbqElU+T2sSmn9HAFtYN6F+SJR1rhe5W5bWpVSpQeEFHDHqlG5dGtRN1tVjQhn70w+X3ELOvlDBpjODRfceNBRV+e1v5xwTI1qu9tZFlJdPaEmBjvv2xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419987; c=relaxed/simple;
	bh=Ojd7iMoppI0Vmr8htaS6S4vgrqwMyDhGX+qRFtVJFaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hk4/59gwX9iuuYktixdiXqRhrb7ZyHYYDmlMfE3G6+OE81yranK3VTh+lrDOT8I3xwHQZJi9onD1lqUKreLfayDzziVrtEf9J4F4x2rCZf0IO98ElynWqhQJvv88LR0lAcXInrH5ZNtI2AQWBd4te89mQIbpqormvaiL8YE5bLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4b6j0g40dHz4f3lVL;
	Wed, 28 May 2025 16:12:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5A7191A0359;
	Wed, 28 May 2025 16:13:02 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgAHa1+MxTZozegGNw--.47012S4;
	Wed, 28 May 2025 16:13:02 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org,
	brauner@kernel.org
Cc: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	zhujia.zj@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wozizhi@huawei.com,
	libaokun1@huawei.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com
Subject: [QUESTION] cachefiles: Recovery concerns with on-demand loading after unexpected power loss
Date: Wed, 28 May 2025 16:07:59 +0800
Message-Id: <20250528080759.105178-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAHa1+MxTZozegGNw--.47012S4
X-Coremail-Antispam: 1UD129KBjvJXoWxJr47CF1DWr4fCw15XF13Arb_yoW8JFy5pF
	ZI9w1UK34kXFZ7K3s7AF48uryfZ3s5AF4DXrWSqrWktrn0kF1Iqryaqr1UJFWUurZrG3y2
	qw1jyr9rAwnFvrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUnUDG7UUUUU==
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

Currently, in on-demand loading mode, cachefiles first calls
cachefiles_create_tmpfile() to generate a tmpfile, and only during the exit
process does it call cachefiles_commit_object->cachefiles_commit_tmpfile to
create the actual dentry and making it visible to users.

If the cache write is interrupted unexpectedly (e.g., by system crash or
power loss), during the next startup process, cachefiles_look_up_object()
will determine that no corresponding dentry has been generated and will
recreate the tmpfile and pull the complete data again!

The current implementation mechanism appears to provide per-file atomicity.
For scenarios involving large image files (where significant amount of
cache data needs to be written), this re-pulling process after an
interruption seems considerable overhead?

In previous kernel versions, cache dentry were generated during the
LOOK_UP_OBJECT process of the object state machine. Even if power was lost
midway, the next startup process could continue pulling data based on the
previously downloaded cache data on disk.

What would be the recommended way to handle this situation? Or am I
thinking about this incorrectly? Would appreciate any feedback and guidance
from the community.

Thanks,
Zizhi Wo


