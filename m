Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC5734571F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 06:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCWFTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 01:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhCWFSq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 01:18:46 -0400
Received: from ustc.edu.cn (email6.ustc.edu.cn [IPv6:2001:da8:d800::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15A60C061574;
        Mon, 22 Mar 2021 22:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:MIME-Version:Content-Transfer-Encoding; bh=TiZe8UTTgE
        Nquwib5uwcT0dF8caXTeaaWpOpfzenyxQ=; b=KsD29ddwEse7OSbf2UQkcjoSee
        tKEVMEI5ImD0gAk1YrOHdjVS2vkaWMf29Q1Sns/daJqRRmwcB+cD/uA/Mb7Q9Jr4
        pM3LSLle04E42SXglbeRefEHOMewww/5M3cHYxUwHWoeVyS8AohVUlKIt+oGtNNr
        XXXmck+lfNXhCCiWM=
Received: from ubuntu.localdomain (unknown [202.38.69.14])
        by newmailweb.ustc.edu.cn (Coremail) with SMTP id LkAmygC3vkoqellg6XEbAA--.456S4;
        Tue, 23 Mar 2021 13:18:34 +0800 (CST)
From:   Lv Yunlong <lyl2019@mail.ustc.edu.cn>
To:     vgoyal@redhat.com, stefanha@redhat.com, miklos@szeredi.hu
Cc:     virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Subject: [PATCH] fuse: Fix a potential double free in virtio_fs_get_tree
Date:   Mon, 22 Mar 2021 22:18:31 -0700
Message-Id: <20210323051831.13575-1-lyl2019@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LkAmygC3vkoqellg6XEbAA--.456S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1rGF48Ar1kCF1DArW8WFg_yoW8JFyrpr
        ykCr13Gr47Xry7Jas3CFnYg345K392kr1UGr92v343Cw4rJry0yrZ5Cry5Krs5ZrWxJFyr
        tF4rJr4agFWDCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwCY02Avz4vE14v_GrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
        1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
        14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
        IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
        DU0xZFpf9x0JU94SOUUUUU=
X-CM-SenderInfo: ho1ojiyrz6zt1loo32lwfovvfxof0/
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In virtio_fs_get_tree, fm is allocated by kzalloc() and
assigned to fsc->s_fs_info by fsc->s_fs_info=fm statement.
If the kzalloc() failed, it will goto err directly, so that
fsc->s_fs_info must be non-NULL and fm will be freed.

But later fm is freed again when virtio_fs_fill_super() fialed.
I think the statement if (fsc->s_fs_info) {kfree(fm);} is
misplaced.

My patch puts this statement in the correct palce to avoid
double free.

Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>
---
 fs/fuse/virtio_fs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 8868ac31a3c0..727cf436828f 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1437,10 +1437,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 
 	fsc->s_fs_info = fm;
 	sb = sget_fc(fsc, virtio_fs_test_super, set_anon_super_fc);
-	if (fsc->s_fs_info) {
-		fuse_conn_put(fc);
-		kfree(fm);
-	}
+
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
 
@@ -1457,6 +1454,11 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 		sb->s_flags |= SB_ACTIVE;
 	}
 
+	if (fsc->s_fs_info) {
+		fuse_conn_put(fc);
+		kfree(fm);
+	}
+
 	WARN_ON(fsc->root);
 	fsc->root = dget(sb->s_root);
 	return 0;
-- 
2.25.1


