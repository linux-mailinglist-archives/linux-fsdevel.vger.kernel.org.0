Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D8E74C150
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 08:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjGIGvU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jul 2023 02:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjGIGvT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jul 2023 02:51:19 -0400
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38691B0;
        Sat,  8 Jul 2023 23:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688885473;
        bh=fyZH/r5nTrPpM2AfEk5mFUkI1ZFvRJ9ak8CEwBQnokE=;
        h=From:To:Cc:Subject:Date;
        b=Utqq2I1O9DcmaKEzZefKSwuOuLj65hjxSOlc4XUIhdPnsKL5yFeWxBXPWgDxXFLgt
         WUe6gISCrdVq5mHOQ3ZQLXSMxMpkVgvoFk6/b9VyGvFyHY07kc1z6UCQQjyn/Tz7+f
         qADniFF7W1wECDM2bnL0VFOd/g4RHL85mMqfLkMM=
Received: from linkpc.nju.edu.cn ([58.213.8.104])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id AB8AFC80; Sun, 09 Jul 2023 14:42:56 +0800
X-QQ-mid: xmsmtpt1688884976tp3vj4aso
Message-ID: <tencent_4D921A8D1F69E70C85C28875DC829E28EC09@qq.com>
X-QQ-XMAILINFO: NzvgoOffVB4jt8SXukzjfjyKd9itsXsW6CWopDpFvoXdBu+tbt79EaFlhmtm+Y
         epnaAttHwg4JfSduhDX8tBPIQDwMnudnWwoaSrfAZkBxUtPv/WyiPF2lKIsmiG0tX7E7r4BOGHv2
         I4X+BvvY+NtOaQdd7l7wcDBaI6s61+J+1Od/35GNn4jI/MY8JoS6wRSOp9vxcN+i/2eKPnkOpgR+
         MzVyDULVVX6sMhvJKKrM71GROxxm2JfIPBUA6Kt/kSRG1QK0ndQLeTYCxwKZePS4UlNPwlmj+C3q
         VllOsi0ETyPGqooUQi5aKK5orc8FxJpB3X2aG9+p9QTl2+MBB1sso3342wQpvAVnHXbKT8aw9X23
         eUA8tO5oNgl045Z+l77DcGRoIiiKnougDYFfzsdzuhUa5UrElymO7SeFv2psOKBN6XQQCrlVsEri
         e8RwiCwUwdrMxj2yIdXQqiyBJfykKlk2r5hHV4A+NEb/9CYqPyuYKCpsEBn5kIg5s5n5qIH9lvfH
         vudapz01GD5O58sxIs/oZrUWIAA/nozwF5SdMQ4z9B9QhBq131kwarlwh7YJClnGSHX01Or28/bE
         Wb+mGh/JcmHDnyZnx4bjxZSQFohZ28bPjEaqnGlfl5+rGAB6xCz8YBbKbzUfHCp5wOFxhnRM5I7e
         kNgjL/ZoXMnxFWpDfPUx9RHg6wOC2zf4awYb21PgfSb6IaIJoYXdYY/OWOWIHmwJyxK5cLa03SAC
         BpdJ2lpf1wPL2UkTQI6D3oz8HMz2EmL8n6hN1vnlQtkfHo7vhQXoKUsHos2WLQhm48s/O8ZpXUek
         HfoXi38oHphJgCVutPmKT1+HPLYJ/qvm8lfJdQ+YIP0fNOXCmfUhS2DfMl3tWQxdIj2Of30c8Iwt
         PhwuJl6SAAW+WY+P/5jogJLDg3fj1qLUoegMKO25Qy2hg2TugYYvI/A7cEHv4dcNwG3JYTLJLhYJ
         lMbnv2h3b0DHMGdkvozPeu5EzIbLWgrKkHSXi1YTUR6DpmYM+qx909ldUIaO1D/IT/U1Hgnzeafl
         2ozrlfWGpikfzapfhR/gkl22A/PzE4KmgcKdhgrcyPl0759pqVoVk+caIWc9BMktkYPWbltw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From:   Linke Li <lilinke99@foxmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Linke Li <lilinke99@gmail.com>
Subject: [PATCH] isofs: fix undefined behavior in iso_date()
Date:   Sun,  9 Jul 2023 14:42:55 +0800
X-OQ-MSGID: <20230709064255.384407-1-lilinke99@foxmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Linke Li <lilinke99@gmail.com>

Fix undefined behavior in the code by properly handling the left shift operaion.
Instead of left-shifting a negative value, explicitly cast -1 to an unsigned int
before the shift. This ensures well defined behavior and resolves any potential
issues.

Signed-off-by: Linke Li <lilinke99@gmail.com>
---
 fs/isofs/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/isofs/util.c b/fs/isofs/util.c
index e88dba721661..4c902901401a 100644
--- a/fs/isofs/util.c
+++ b/fs/isofs/util.c
@@ -37,7 +37,7 @@ int iso_date(u8 *p, int flag)
 
 		/* sign extend */
 		if (tz & 0x80)
-			tz |= (-1 << 8);
+			tz |= ((unsigned int)-1 << 8);
 		
 		/* 
 		 * The timezone offset is unreliable on some disks,
-- 
2.25.1

