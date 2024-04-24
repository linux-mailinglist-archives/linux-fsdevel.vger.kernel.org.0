Return-Path: <linux-fsdevel+bounces-17584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C228AFFE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 05:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B0791C234AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 03:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E891422D4;
	Wed, 24 Apr 2024 03:43:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4390D139CEB;
	Wed, 24 Apr 2024 03:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713930208; cv=none; b=Qm6nkDD3MR8S84GyKh8qbaa0kBP+bXKth2rmbVbc/N5uZzdZs469PSimgeCUJTIPp8zn4bRLh0kXDFq2rNc5mxDaDcffsvCcyPeyvUwuBR3/SZ0obbHdgDye/SKWIj9kVbo87/TZEDYHugC2ltyEk8iHviFoHl3XWRub/eJHNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713930208; c=relaxed/simple;
	bh=klE7ewnkfYNzuZ52pxanOrEsvUoVVsXNsM1uSrsVQ1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JP8E9Nx3hMV+lvhnbkuCx/ESS5kEiXIZOeCbGv+/8tujvPCFMHopiCFGGkddSk266tDy0c4FLQP77nJ3pfUASAZnsv1sYJFPSojFVj0SGxAkFHBmEkub82WuKIgrRJoJPTzDkbXmd75jJA2SaiNNZ9JxhvxES5suXV5jCCg2IIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPPw309Hhz4f3nbg;
	Wed, 24 Apr 2024 11:43:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 359071A0572;
	Wed, 24 Apr 2024 11:43:24 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBHGBHafyhmuSA4Kw--.57541S5;
	Wed, 24 Apr 2024 11:43:23 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev
Cc: dhowells@redhat.com,
	jlayton@kernel.org,
	zhujia.zj@bytedance.com,
	jefflexu@linux.alibaba.com,
	linux-cachefs@redhat.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH 1/5] cachefiles: stop sending new request when dropping object
Date: Wed, 24 Apr 2024 11:34:05 +0800
Message-Id: <20240424033409.2735257-2-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424033409.2735257-1-libaokun@huaweicloud.com>
References: <20240424033409.2735257-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBHGBHafyhmuSA4Kw--.57541S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAF47Zw1DXw4rurW3Xw17GFg_yoW5AFW5pF
	WayFy3Kry8ur17GrZ7Za95GrySy3ykZrnFga4Yq3WUAanIqr4rZr1ktr1DuF1Uu3yxXr43
	tw48Casxt3y2y3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQ014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUWVWUuwAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwAKzVCY07xG64k0F24lc7CjxVAKzI0EY4vE52x082I5MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjTRR7KVUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

Added CACHEFILES_ONDEMAND_OBJSTATE_DROPPING indicates that the cachefiles
object is being dropped, and is set after the close request for the dropped
object completes, and no new requests are allowed to be sent after this
state.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/cachefiles/internal.h |  2 ++
 fs/cachefiles/ondemand.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index d33169f0018b..8ecd296cc1c4 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -48,6 +48,7 @@ enum cachefiles_object_state {
 	CACHEFILES_ONDEMAND_OBJSTATE_CLOSE, /* Anonymous fd closed by daemon or initial state */
 	CACHEFILES_ONDEMAND_OBJSTATE_OPEN, /* Anonymous fd associated with object is available */
 	CACHEFILES_ONDEMAND_OBJSTATE_REOPENING, /* Object that was closed and is being reopened. */
+	CACHEFILES_ONDEMAND_OBJSTATE_DROPPING, /* Object is being dropped. */
 };
 
 struct cachefiles_ondemand_info {
@@ -332,6 +333,7 @@ cachefiles_ondemand_set_object_##_state(struct cachefiles_object *object) \
 CACHEFILES_OBJECT_STATE_FUNCS(open, OPEN);
 CACHEFILES_OBJECT_STATE_FUNCS(close, CLOSE);
 CACHEFILES_OBJECT_STATE_FUNCS(reopening, REOPENING);
+CACHEFILES_OBJECT_STATE_FUNCS(dropping, DROPPING);
 
 static inline bool cachefiles_ondemand_is_reopening_read(struct cachefiles_req *req)
 {
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 4ba42f1fa3b4..73da4d4eaa9b 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -422,7 +422,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 		 */
 		xas_lock(&xas);
 
-		if (test_bit(CACHEFILES_DEAD, &cache->flags)) {
+		if (test_bit(CACHEFILES_DEAD, &cache->flags) ||
+		    cachefiles_ondemand_object_is_dropping(object)) {
 			xas_unlock(&xas);
 			ret = -EIO;
 			goto out;
@@ -463,7 +464,8 @@ static int cachefiles_ondemand_send_req(struct cachefiles_object *object,
 	 * If error occurs after creating the anonymous fd,
 	 * cachefiles_ondemand_fd_release() will set object to close.
 	 */
-	if (opcode == CACHEFILES_OP_OPEN)
+	if (opcode == CACHEFILES_OP_OPEN &&
+	    !cachefiles_ondemand_object_is_dropping(object))
 		cachefiles_ondemand_set_object_close(object);
 	kfree(req);
 	return ret;
@@ -562,8 +564,12 @@ int cachefiles_ondemand_init_object(struct cachefiles_object *object)
 
 void cachefiles_ondemand_clean_object(struct cachefiles_object *object)
 {
+	if (!object->ondemand)
+		return;
+
 	cachefiles_ondemand_send_req(object, CACHEFILES_OP_CLOSE, 0,
 			cachefiles_ondemand_init_close_req, NULL);
+	cachefiles_ondemand_set_object_dropping(object);
 }
 
 int cachefiles_ondemand_init_obj_info(struct cachefiles_object *object,
-- 
2.39.2


