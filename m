Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04FC9F80F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfKKURE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:17:04 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:35251 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfKKURD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:17:03 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MXoxG-1iOksW3uyi-00YDU3; Mon, 11 Nov 2019 21:16:49 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 08/19] nfsd: use ktime_get_seconds() for timestamps
Date:   Mon, 11 Nov 2019 21:16:28 +0100
Message-Id: <20191111201639.2240623-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:prYR0ybWZtYGIQZYrlV+P2u6nCi8TfYizkBHaraboVlw4qnbxig
 LQKMg4gkL6vA2s1NikusRiqqI1Bm3OJMCVQrHmiRdY33vKAPBSyBCBpoYNX09gkc2Gbejkw
 ddVEJ7y9RckGfWslXKbXu8O9Uc0NAxW1C97J9iekWWr5QEcA/bmNwrwMb43PJTBZgPhdTjZ
 d9ZmLBmTnKXMJseMexgHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:pIvNkoEd/l4=:HQOWQXYKVwj2Av0ucDw3uJ
 gyl0crXndujLUH0aGyy6jX2F875PqFZIjKrmP8pwRiawQi0YLcZHsWq3f58TZWzalfob+XAnn
 SK8zcqmmD/t/A3VVrQYN0cADSqaNRMA5TG7zT9zI0KOHAuLWB4Er0qgx7aYy0jrM+KBDUqhJK
 5Fbn5lUQuT46mkh0hkk/7rE8UEgiEwsRl3t+SeJxI7uvQssrdQuQ07SSvoNUwGeCwlSt7c2sm
 SsPpkPW67qOkg0rOESXyfsAWr3AIFyQ1j80Uu+9YH3GoI/DdwAKh8OQSfENGAaKzD29od0Phy
 axtrQv3uYapyNkaCl7VQZK/AAfzddTUhis5THTkazM5KeNCG90BTTFF9DEGXCBi62KTDzBpsG
 2XyXLqCetAuOxTMuT+CdBSqf3K+bwyF0XRKvbDPtOMG7jVbeqZhj9wN0TyKZXcSlouhk+JSWR
 qHlPFHgvDweA6NonMgYZAsKOcWha0ZWg6pWgDvxmxEM+Sd6qbNrwS7Cntdj6BnMSWsUA7a3Vw
 Nq7JplT2GLVv5r8VmkW4aVwiI+SXwt7NYyqx/7ZlvjZfQZuKLDYtVAWnmq785+Ab7g/JlwOb1
 mXgOtQzwlf42WoewNuvlARh1wmnh04b2/kKeLqb6AN+6afwYtHN4wZBd7pLEnN0/CMcGPPzVF
 tsd8XTbip8+sokjx+D5M4DGL0U1JuJ8PjRy07/V39bBNFg/p5PnvKhKT8JuioBOS0nO1/w9KG
 mE06b8MDMVBLj8jaQD/vRPSIThibBKmVh/g40f6ikaXxWgGTEuHYTHa84lyEs5S6oP6FzGcHK
 GBUFoQTS0IDSN9LCwpVTQswvG1VaW32lyREB5/+IguvViGvgbr5OikajuDLcuoXTtuO1jDgNG
 DpQhiP63FLJgQbAX8L3g==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The delegation logic in nfsd uses the somewhat inefficient
seconds_since_boot() function to record time intervals.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs4state.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c65aeaa812d4..a20795b5053c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -806,7 +806,7 @@ static void nfs4_free_deleg(struct nfs4_stid *stid)
 static DEFINE_SPINLOCK(blocked_delegations_lock);
 static struct bloom_pair {
 	int	entries, old_entries;
-	time_t	swap_time;
+	time64_t swap_time;
 	int	new; /* index into 'set' */
 	DECLARE_BITMAP(set[2], 256);
 } blocked_delegations;
@@ -818,15 +818,15 @@ static int delegation_blocked(struct knfsd_fh *fh)
 
 	if (bd->entries == 0)
 		return 0;
-	if (seconds_since_boot() - bd->swap_time > 30) {
+	if (ktime_get_seconds() - bd->swap_time > 30) {
 		spin_lock(&blocked_delegations_lock);
-		if (seconds_since_boot() - bd->swap_time > 30) {
+		if (ktime_get_seconds() - bd->swap_time > 30) {
 			bd->entries -= bd->old_entries;
 			bd->old_entries = bd->entries;
 			memset(bd->set[bd->new], 0,
 			       sizeof(bd->set[0]));
 			bd->new = 1-bd->new;
-			bd->swap_time = seconds_since_boot();
+			bd->swap_time = ktime_get_seconds();
 		}
 		spin_unlock(&blocked_delegations_lock);
 	}
@@ -856,7 +856,7 @@ static void block_delegations(struct knfsd_fh *fh)
 	__set_bit((hash>>8)&255, bd->set[bd->new]);
 	__set_bit((hash>>16)&255, bd->set[bd->new]);
 	if (bd->entries == 0)
-		bd->swap_time = seconds_since_boot();
+		bd->swap_time = ktime_get_seconds();
 	bd->entries += 1;
 	spin_unlock(&blocked_delegations_lock);
 }
-- 
2.20.0

