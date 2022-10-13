Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9FE5FE3D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Oct 2022 23:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJMVLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 17:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJMVLE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:11:04 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2E92B189;
        Thu, 13 Oct 2022 14:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tZIWksLvbZf3hKAivkvuzlnH7vev2LNtmjEPqqMctpQ=; b=a5Q74KM2d0akGfotwLs4Oze7xd
        5/ohN2Rdfcek3Yqthbqc2LGy9joEXU4R5QpeNAnDlLzf1ha5JAcbRNncDqmQtHb2A80nnOQRND1ey
        DMV3d3HpEX7Ctu2BWqyjl6J4hy4X/Y1bDZhh4mo22vep7vA27FVULyLrg5NfBoiXKx12Z2IgsBVyH
        Fdn2HaMiVb9xNaMVxsijAG0HiClg1pGj8EGtrZVckcDsuYYgrT0B8/IuRqvM9g3vk6s3ToCi34RkO
        lXJ2bFQ/bWJqwMTmM1DGjbLQtQ1IYSKSltQi3nDMmfCPC/acrPq3UyHoenhrQyc7/MVooEIcJzJTN
        +EaVCKHA==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=localhost)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oj5Tk-0010yp-8K; Thu, 13 Oct 2022 23:10:57 +0200
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-efi@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, keescook@chromium.org,
        anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        ardb@kernel.org, "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH V2 1/3] pstore: Alert on backend write error
Date:   Thu, 13 Oct 2022 18:06:46 -0300
Message-Id: <20221013210648.137452-2-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221013210648.137452-1-gpiccoli@igalia.com>
References: <20221013210648.137452-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The pstore dump function doesn't alert at all on errors - despite
pstore is usually a last resource and if it fails users won't be
able to read the kernel log, this is not the case for server users
with serial access, for example.

So, let's at least attempt to inform such advanced users on the first
backend writing error detected during the kmsg dump - this is also
very useful for pstore debugging purposes.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---


V2:
- Show error message late, outside of the critical region
(thanks Kees for the idea!).


 fs/pstore/platform.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index 06c2c66af332..cbc0b468c1ab 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -393,6 +393,7 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 	const char	*why;
 	unsigned int	part = 1;
 	unsigned long	flags = 0;
+	int		saved_ret = 0;
 	int		ret;
 
 	why = kmsg_dump_reason_str(reason);
@@ -463,12 +464,21 @@ static void pstore_dump(struct kmsg_dumper *dumper,
 		if (ret == 0 && reason == KMSG_DUMP_OOPS) {
 			pstore_new_entry = 1;
 			pstore_timer_kick();
+		} else {
+			/* Preserve only the first non-zero returned value. */
+			if (!saved_ret)
+				saved_ret = ret;
 		}
 
 		total += record.size;
 		part++;
 	}
 	spin_unlock_irqrestore(&psinfo->buf_lock, flags);
+
+	if (saved_ret) {
+		pr_err_once("backend (%s) writing error (%d)\n", psinfo->name,
+			    saved_ret);
+	}
 }
 
 static struct kmsg_dumper pstore_dumper = {
-- 
2.38.0

