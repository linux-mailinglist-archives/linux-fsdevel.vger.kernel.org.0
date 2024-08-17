Return-Path: <linux-fsdevel+bounces-26180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8322A95567C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 10:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965E41C20D9C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 08:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E156144D27;
	Sat, 17 Aug 2024 08:50:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3988814374C
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723884655; cv=none; b=J3n17o2qOEz7g7CtEkrYKjOe+91CeKDwUDlINx+dxP8Wsoz4bAjGhBHJXfNaqxFa1gtOpaMxODYl3OP+ZCh3QOd0IaDep7+9FFn363qqFN2od3eXSMQL2mtoQYixMBMLogAJ+nKwyAYAw26d1ssfgZdPT1occ7qAonkzm4oozUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723884655; c=relaxed/simple;
	bh=F7HBEHKXFO0xpO53ZBEeYIwp3RgZ1ffoQoBDp9NUi2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K8ucIlfY3G5frdHzXZtjMnHGIBYm2zhxpbQo5UWfemTnXFGBiV01zmBRFG4Q5Gq/FaV7XmUqdMYnFL3x31IBEamvlU8MfsbYf13kiSjk7V5gBDtzEpZLu5b/h8QqIgt1NW5aIQAZpApIGz7Pt2JEMd0w6uV2oahGU1Vy3PTMqKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WmCHY3SfQz4f3kw3
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 16:50:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5C92C1A018D
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2024 16:50:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCHr4VhZMBmPT66Bw--.39037S4;
	Sat, 17 Aug 2024 16:50:48 +0800 (CST)
From: yangerkun <yangerkun@huaweicloud.com>
To: dhowells@redhat.com,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	hsiangkao@linux.alibaba.com
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2] netfs: fix the mismatch used for CONFIG_FSCACHE_DEBUG
Date: Sat, 17 Aug 2024 16:46:19 +0800
Message-Id: <20240817084619.2075189-1-yangerkun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHr4VhZMBmPT66Bw--.39037S4
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr1DGryUCF1DCF48tFWkZwb_yoWDZrc_tF
	40yF18Xr45tF9aq34xCrWI9FWUWa97KF48uw13trZIqrZxtas5CFsag393AwsxWF4UWrnr
	Awnaqrs8ury7GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267
	AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
	ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

From: yangerkun <yangerkun@huawei.com>

The name of debug config used in fs/netfs/internal.h has a mismatch
compared to the define in fs/netfs/Kconfig, which lead to that debug for
netfs won't work.

Signed-off-by: yangerkun <yangerkun@huawei.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/netfs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

No logic change, send v2 since this patch does not accept for a long
time...

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 7773f3d855a9..a683a8505696 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -365,7 +365,7 @@ void fscache_create_volume(struct fscache_volume *volume, bool wait);
 #define _leave(FMT, ...) kleave(FMT, ##__VA_ARGS__)
 #define _debug(FMT, ...) kdebug(FMT, ##__VA_ARGS__)
 
-#elif defined(CONFIG_NETFS_DEBUG)
+#elif defined(CONFIG_FSCACHE_DEBUG)
 #define _enter(FMT, ...)			\
 do {						\
 	if (netfs_debug)			\
-- 
2.39.2


