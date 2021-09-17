Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7080840FF25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 20:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344533AbhIQSYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 14:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344400AbhIQSYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:24:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B44EC061574;
        Fri, 17 Sep 2021 11:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=TpWhHDdGVfR6RDYKOLjBIoqQ9UQe+x0mjeEQUKQ9/JM=; b=S+S6gIrumrtOg4NhyFQ271dZdr
        Ad/Ojk1EIqWUhRyG4pEowOeFSc09IYoYOdr6Ifq/RicwitFYjRS/qnK/kz1b+GQ3Zp+2BI4ZLKYGu
        9o4lyOYtupqQnu8zmWePvOpRjpVfOB+9AK5fU044V2DF4oLutNlxUpG0qAWMBpIpoahUztQatvLdJ
        0crirmh6RRhAPUe63SEsrjBp2P/ROCkGnoOOmK7YT5grfHMS6RrVyWRlIRvHyUEevaGGH+2mMg142
        VcJO1lTEYnjVJObQ9PINBQi+t676d2Kd9O0mUSooqfv5jaH8jxuGTUKJXc4O/9zh9G1vdRzSgcHkw
        WRt1ZY9A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRIVI-00Ep5Q-0I; Fri, 17 Sep 2021 18:22:28 +0000
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     bp@suse.de, akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, kubakici@wp.pl, maco@android.com,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-wireless@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, sfr@canb.auug.org.au, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 01/14] firmware_loader: fix pre-allocated buf built-in firmware use
Date:   Fri, 17 Sep 2021 11:22:13 -0700
Message-Id: <20210917182226.3532898-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210917182226.3532898-1-mcgrof@kernel.org>
References: <20210917182226.3532898-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

The firmware_loader can be used with a pre-allocated buffer
through the use of the API calls:

  o request_firmware_into_buf()
  o request_partial_firmware_into_buf()

If the firmware was built-in and present, our current check
for if the built-in firmware fits into the pre-allocated buffer
does not return any errors, and we proceed to tell the caller
that everything worked fine. It's a lie and no firmware would
end up being copied into the pre-allocated buffer. So if the
caller trust the result it may end up writing a bunch of 0's
to a device!

Fix this by making the function that checks for the pre-allocated
buffer return non-void. Since the typical use case is when no
pre-allocated buffer is provided make this return successfully
for that case. If the built-in firmware does *not* fit into the
pre-allocated buffer size return a failure as we should have
been doing before.

I'm not aware of users of the built-in firmware using the API
calls with a pre-allocated buffer, as such I doubt this fixes
any real life issue. But you never know... perhaps some oddball
private tree might use it.

In so far as upstream is concerned this just fixes our code for
correctness.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index bdbedc6660a8..ef904b8b112e 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -100,12 +100,15 @@ static struct firmware_cache fw_cache;
 extern struct builtin_fw __start_builtin_fw[];
 extern struct builtin_fw __end_builtin_fw[];
 
-static void fw_copy_to_prealloc_buf(struct firmware *fw,
+static bool fw_copy_to_prealloc_buf(struct firmware *fw,
 				    void *buf, size_t size)
 {
-	if (!buf || size < fw->size)
-		return;
+	if (!buf)
+		return true;
+	if (size < fw->size)
+		return false;
 	memcpy(buf, fw->data, fw->size);
+	return true;
 }
 
 static bool fw_get_builtin_firmware(struct firmware *fw, const char *name,
@@ -117,9 +120,7 @@ static bool fw_get_builtin_firmware(struct firmware *fw, const char *name,
 		if (strcmp(name, b_fw->name) == 0) {
 			fw->size = b_fw->size;
 			fw->data = b_fw->data;
-			fw_copy_to_prealloc_buf(fw, buf, size);
-
-			return true;
+			return fw_copy_to_prealloc_buf(fw, buf, size);
 		}
 	}
 
-- 
2.30.2

