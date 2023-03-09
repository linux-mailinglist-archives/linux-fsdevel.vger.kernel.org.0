Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10EC6B2ECD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 21:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCIUjZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 15:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCIUjX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:39:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAE71BAFB;
        Thu,  9 Mar 2023 12:39:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5F6CB82084;
        Thu,  9 Mar 2023 20:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60816C433EF;
        Thu,  9 Mar 2023 20:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678394360;
        bh=Kc6ftv+Ki9/j3zTjyqcXi3xpxwHe7bNOe/f1JASrrnE=;
        h=From:Date:Subject:To:Cc:From;
        b=DTqOAyfQtKj3j45rDR915fArJ1TIT+wa4LFoUbBTcdfvt7y3919baCx4p/Sowar6w
         2B0vU0d48/NBX6PDy+rwLr0yisvj3As2H3RB7+nkqHiE9NBzPHNay1mk6WOAyzhmqU
         6nEI2VMCwUAiAesUOHnFaK7QLnFMhGRDGry2Kj/7rW1hznj33Med8sDKykAMQrDHil
         2bu6pfPaHgXIXgvS99Regj0S2AETp1nNHsnqnyDGlMM6XB412FuW1VNwDmyu5SbN1j
         oKQuTuYf6lcD/48b0xNX+sdisaS+4Q1jXuS36++aWBm4KyhQvXIYY5oe542kdIr6df
         02GE0AijLgH2w==
From:   "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Date:   Thu, 09 Mar 2023 14:39:09 -0600
Subject: [PATCH] filelocks: use mount idmapping for setlease permission
 check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230309-generic_setlease-use-idmapping-v1-1-6c970395ac4d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAOxDCmQC/x2NUQrCMBBEr1L220BMRIhXEZFtHNMFG0O2FaH07
 iZ+DvPmzUaKKlC6DBtVfETlnVs4HgaKE+cEI4+WyVnnrbfBJOS2iHfF8gIrzKqdmbkUycn4E2w
 IzM7ZMzXJ2JGxco5T18ysC2ovSsVTvv/n623ff+JB4luJAAAA
To:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=sforshee@kernel.org;
 h=from:subject:message-id; bh=Kc6ftv+Ki9/j3zTjyqcXi3xpxwHe7bNOe/f1JASrrnE=;
 b=owEBbQGS/pANAwAKAVMDma7l9DHJAcsmYgBkCkP1dRYpt1PRHcuj1+hk1OrsYwsc5jyg80fFm5k8
 p0x/wWWJATMEAAEKAB0WIQSQnt+rKAvnETy4Hc9TA5mu5fQxyQUCZApD9QAKCRBTA5mu5fQxydDGB/
 0TjNkJ3L9JDuobidxFGVpig8X7NHRobwoFiUGwBUu+nLBn9xC2edBtUcPTuWhR51NLzxhH8Gmiiol5
 OKNpThyYUYJ5o/WBKFN8tpWiRaOj7XAGQS21OhIoBrO6axP76venFCGpwhVtsUUjU8vgLF2otXiePR
 emZ/NOFtpx+tLYVq00lfbwC57ZdcQAY1aqJiE8rBs3LKpyZu9C2vljHFtY0UJhJn1NR7I91Dyg47R3
 JczZNWUvcGtlx8V6Bu3yucNwM0fAykTECi6jBwGG7cvcMPHGdmrYR/odMRwsOEo2J7eMj1yjL68HBF
 IbU3jR0qOPYumVwRJR5dhxVlwgIfiO
X-Developer-Key: i=sforshee@kernel.org; a=openpgp;
 fpr=2ABCA7498D83E1D32D51D3B5AB4800A62DB9F73A
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A user should be allowed to take out a lease via an idmapped mount if
the fsuid matches the mapped uid of the inode. generic_setlease() is
checking the unmapped inode uid, causing these operations to be denied.

Fix this by comparing against the mapped inode uid instead of the
unmapped uid.

Fixes: 9caccd41541a ("fs: introduce MOUNT_ATTR_IDMAP")
Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
---
 fs/locks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 66b4eef09db5..cf07f72eaf45 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1863,9 +1863,10 @@ int generic_setlease(struct file *filp, long arg, struct file_lock **flp,
 			void **priv)
 {
 	struct inode *inode = file_inode(filp);
+	vfsuid_t vfsuid = i_uid_into_vfsuid(file_mnt_idmap(filp), inode);
 	int error;
 
-	if ((!uid_eq(current_fsuid(), inode->i_uid)) && !capable(CAP_LEASE))
+	if ((!vfsuid_eq_kuid(vfsuid, current_fsuid())) && !capable(CAP_LEASE))
 		return -EACCES;
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;

---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230309-generic_setlease-use-idmapping-34e099aa2206

Best regards,
-- 
Seth Forshee (DigitalOcean) <sforshee@kernel.org>

