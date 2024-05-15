Return-Path: <linux-fsdevel+bounces-19506-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2939B8C6331
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 10:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881B328446B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C99467A1A;
	Wed, 15 May 2024 08:56:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437A60EC4;
	Wed, 15 May 2024 08:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763402; cv=none; b=Yqs+cb3BR+p+9rlwz/EsjltVUMRHtAgcGh+cI/Od15GGZp8DonpgRzHW/K+0C48Vze2KQQEQWIaqYPXfC8HI/OWkuRzUK9gZFnUgWHZixp+QbEQBOG52ho88XXjHAGxZ29iMGk5m07serTR+dd9XR3h8bJ/D+OO53N13EkzF9bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763402; c=relaxed/simple;
	bh=5euwH6CxB4x5TEj7VSBC62QDjiP6o88GZy3qb6LYYiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Who2O5oAT+CF9hH1VWkKfsa1yrhSYutEC6MEoA519gXTqia33SBh66UOoKqcO+l/dCtkvq3sYeWXhkBNc9B20R+J8nPykWtKYSsZ5gC+UGbJGhvLtlyV0JeyopIt9VFmdFRr9QDSknQou0s3bTRvzJbOH1fLdXB1IbK8YYM/5XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VfRsh34hvz4f3jYQ;
	Wed, 15 May 2024 16:56:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1B34A1A12F9;
	Wed, 15 May 2024 16:56:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxC7eERm68LgMg--.42328S9;
	Wed, 15 May 2024 16:56:32 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	zhujia.zj@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v2 05/12] cachefiles: add output string to cachefiles_obj_[get|put]_ondemand_fd
Date: Wed, 15 May 2024 16:45:54 +0800
Message-Id: <20240515084601.3240503-6-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240515084601.3240503-1-libaokun@huaweicloud.com>
References: <20240515084601.3240503-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxC7eERm68LgMg--.42328S9
X-Coremail-Antispam: 1UD129KBjvdXoW7Gw4ftFy7Cr1DCryfAw1xAFb_yoWDCwb_ua
	s7Zw1kXr4Sga1kJ3yxAryUJrW09w18A3Z0grn5tFy7C345J345Jan5JrnFv39rGF1UWa1q
	qFsava48XrnI9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbk8FF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
	IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
	F7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
	1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7M4kE6xkIj40Ew7xC0wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8
	JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1V
	AFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
	UjIFyTuYvjfUYGYpUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

This lets us see the correct trace output.

Fixes: c8383054506c ("cachefiles: notify the user daemon when looking up cookie")
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 include/trace/events/cachefiles.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 119a823fb5a0..bb56e3104b12 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -130,6 +130,8 @@ enum cachefiles_error_trace {
 	EM(cachefiles_obj_see_lookup_failed,	"SEE lookup_failed")	\
 	EM(cachefiles_obj_see_withdraw_cookie,	"SEE withdraw_cookie")	\
 	EM(cachefiles_obj_see_withdrawal,	"SEE withdrawal")	\
+	EM(cachefiles_obj_get_ondemand_fd,      "GET ondemand_fd")      \
+	EM(cachefiles_obj_put_ondemand_fd,      "PUT ondemand_fd")      \
 	EM(cachefiles_obj_get_read_req,		"GET read_req")		\
 	E_(cachefiles_obj_put_read_req,		"PUT read_req")
 
-- 
2.39.2


