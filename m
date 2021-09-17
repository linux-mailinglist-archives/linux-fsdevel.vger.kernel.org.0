Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD92140FF38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 20:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344476AbhIQSYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 14:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344381AbhIQSYJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:24:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90DDC061574;
        Fri, 17 Sep 2021 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=OQG1Hx1C3V+AIbyqDjpSPSWFykzcTbz1vVVOQjeWO0w=; b=Kqb3vawGdf5WUfPAXE1WjKV0Np
        ST2UiWGAquVxLai4MtQ5hUkWtem+YnCJVFTZDcf64i2zFReePkjpahU7PkXcGIq1RlLrw+Wv6YAtw
        eJg4vqto+NN3/mbkLvg6wxqUln2hBsZ1I6KmTaDRqUtva3VshG5w4R+ZUNkeGgAmkdrEtSkFQqmG1
        5UTWiDuenVQ1S/yiMP3HCKsy3cE22NQQcVCxcMfna5tA2lLagNU3ydUiIBD95s/n8wEoL6Eklhw2i
        8tC95HQNppTtqXsl1GNKtgNc+ND/waHTaJyaMT8hI2qB/2BC1jqNyE+NVaNNum8ARRg78y4zj9wMY
        s+O4gRXg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRIVI-00Ep5U-5G; Fri, 17 Sep 2021 18:22:28 +0000
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
Subject: [PATCH 03/14] firmware_loader: add a sanity check for firmware_request_builtin()
Date:   Fri, 17 Sep 2021 11:22:15 -0700
Message-Id: <20210917182226.3532898-4-mcgrof@kernel.org>
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

Right now firmware_request_builtin() is used internally only
and so we have control over the callers. But if we want to expose
that API more broadly we should ensure the firmware pointer
is valid.

This doesn't fix any known issue, it just prepares us to later
expose this API to other users.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/base/firmware_loader/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index eb4085b92ad4..d95b5fe5f700 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -115,6 +115,9 @@ static bool firmware_request_builtin(struct firmware *fw, const char *name)
 {
 	struct builtin_fw *b_fw;
 
+	if (!fw)
+		return false;
+
 	for (b_fw = __start_builtin_fw; b_fw != __end_builtin_fw; b_fw++) {
 		if (strcmp(name, b_fw->name) == 0) {
 			fw->size = b_fw->size;
-- 
2.30.2

