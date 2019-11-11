Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7978EF8101
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 21:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfKKURC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 15:17:02 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:33919 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbfKKURC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:17:02 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N6svJ-1hphAy14rX-018NFQ; Mon, 11 Nov 2019 21:16:51 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-nfs@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     y2038@lists.linaro.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 15/19] nfsd: fix delay timer on 32-bit architectures
Date:   Mon, 11 Nov 2019 21:16:35 +0100
Message-Id: <20191111201639.2240623-16-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191111201639.2240623-1-arnd@arndb.de>
References: <20191111201639.2240623-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gmiJexBFvqElF3mq4b9b+BZDQ8d72Q7kCeZTPOCjS6AhS6bzlDu
 NXJLMSB2hdsvgNmtvpikLv8CkbAUuuLITgyvau37mTIqgnGMh2E9z2Kqjdm+HVfcFTkEsgE
 9/kcOOnOXlfAtr/6WB+MFLMVjWxlTuUuJmcpK3g5R/UWsE22dELI9rGE5eFOqYyEefJsgrh
 5uj7yStbDDRkV90oaUamg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OuSNcZeVEos=:x5ZXKdsBl17wIelyNU21r3
 8HywO3EQnZh63jP5CdexIy9kbzHofX+dQ9vWCbGyNW6gxNBDmMoQdYNIOkN7oiQqhOxKT5miN
 LMLI3zCfLbaVnWqKzXHzkh4SXd60raLsDj6FZ9cqxRnLegxn+ujtQhmJ8O1qrAJ9uGHdZLEyo
 YYrIHvXt9yrS3dOKUH6D9er6OY6AE3pYEn6niAs26nWvtg31Oh8kIrebSr00Jfwq4uyVMUtMa
 LovWvlMjgjNNVvy2GM4CZgAc8qjB3IpKNM3Dk2tAM5WyUQRDj1rXtPNk0llxXBskdSmHWOGmM
 O01Z0XOSo8gBiTaL6JKDtCZPN7/mOK/La4BlGKGPel9nlWIqQdYIRC1lAQSz5LxrOdJNHNCQo
 c4Yeb6MDh1XYxzXp7hEifvWn65XWZ7EmeYVA8nlUZXm4F9K9Pl6WhGZjrqe15yqHsbxDtEyso
 zFCbNi+U+ezxW5uyTCO1WGPAhb5r84NSFv0BtGGH2jHcyiYKlhpDoxFXmco9e4u1oP9gxaqpV
 Coh9Kb8379K2/S45ksuq0DhJCSXfK2+/mVQS5ONJ/KKkCZeqe0VdQvVBVyEdyVL2cQZ6s2Eg4
 2SWHkhksSI61c9TmpFxbCv5LIguBAC0j6yaj8sesQwBzjdB8Mqo51GEzubeCjZR2t4nnupwMF
 oATxST3QYVtUyEn+jyRsq1kCOMrKwM/LWp90kFyffh6rm3nE6VkM+HxbBRHOnuszqT5w59STU
 lpDJzUcRO0AazmApNe0Emg7YfFD1DDH1qopZZnpp6IhPj6fwpCXEvyn0ltAA5wp4hbWOfP4sh
 qgUW/h5GeiZ266/UeL//8fY8p9NQIQ9M6LE7YJzHNOR12p1iBWrbBBawW5Lv3hC4nCTp2Nh2e
 47wyLsKwTNhlghaiTKhQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The nfsd4_cb_layout_done() function takes a 'time_t' value,
multiplied by NSEC_PER_SEC*2 to get a nanosecond value.

This works fine on 64-bit architectures, but on 32-bit, any
value over 1 second results in a signed integer overflow
with unexpected results.

Cast one input to a 64-bit type in order to produce the
same result that we have on 64-bit architectures, regarless
of the type of nfsd4_lease.

Fixes: 6b9b21073d3b ("nfsd: give up on CB_LAYOUTRECALLs after two lease periods")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/nfsd/nfs4layouts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 2681c70283ce..e12409eca7cc 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -675,7 +675,7 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
 
 		/* Client gets 2 lease periods to return it */
 		cutoff = ktime_add_ns(task->tk_start,
-					 nn->nfsd4_lease * NSEC_PER_SEC * 2);
+					 (u64)nn->nfsd4_lease * NSEC_PER_SEC * 2);
 
 		if (ktime_before(now, cutoff)) {
 			rpc_delay(task, HZ/100); /* 10 mili-seconds */
-- 
2.20.0

