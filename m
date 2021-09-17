Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38A640FF20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 20:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344375AbhIQSYH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 14:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234479AbhIQSYG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:24:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D60C061574;
        Fri, 17 Sep 2021 11:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=tD4Sbra29CB+zDaId3JKIIubIM6CxINJL6HrVfCbIoA=; b=zkwXatXSLHRehaBwXk1y8v317Y
        1UtVMaNO10I3xGAvya1UM6SPveE0FNAH+KI5JrLvVpE9Bs6Cq2Ztb0QcBPOFGVkKzlIhhwOvDVLWy
        cXZV56xaJpif4DvbrBmFhMyI16m9ZuJbrqfqh4mcUADuQnsItHEnBEupdvizQqsSnoLmQCEsx0kEz
        R/UjBcBJ3/5mm10KLthGJocfnM7wMqLZkCo3n98IKYEP0Fm7Nwi07cDFzlKHHC7VwKIsy3tz9gUg4
        Lj2VAsXzxBFdSxplrjX6Gdo0fBVXi5tGfGzDNfsquHu1vPccfnawu1UIqwMQ4Wdvd+CO1TH0fxLWc
        LQ4mbEeA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mRIVI-00Ep5s-Nq; Fri, 17 Sep 2021 18:22:28 +0000
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
Subject: [PATCH 13/14] test_firmware: move a few test knobs out to its library
Date:   Fri, 17 Sep 2021 11:22:25 -0700
Message-Id: <20210917182226.3532898-14-mcgrof@kernel.org>
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

These will be used by other tests cases in other files so
move them to the library.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 .../testing/selftests/firmware/fw_filesystem.sh | 16 ----------------
 tools/testing/selftests/firmware/fw_lib.sh      | 17 +++++++++++++++++
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index c2a2a100114b..7d763b303057 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -118,27 +118,11 @@ test_config_present()
 	fi
 }
 
-# Defaults :
-#
-# send_uevent: 1
-# sync_direct: 0
-# name: test-firmware.bin
-# num_requests: 4
-config_reset()
-{
-	echo 1 >  $DIR/reset
-}
-
 release_all_firmware()
 {
 	echo 1 >  $DIR/release_all_firmware
 }
 
-config_set_name()
-{
-	echo -n $1 >  $DIR/config_name
-}
-
 config_set_into_buf()
 {
 	echo 1 >  $DIR/config_into_buf
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index 5b8c0fedee76..31b71fe11dc5 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -221,3 +221,20 @@ kconfig_has()
 		fi
 	fi
 }
+
+# Defaults :
+#
+# send_uevent: 1
+# sync_direct: 0
+# name: test-firmware.bin
+# num_requests: 4
+config_reset()
+{
+	echo 1 >  $DIR/reset
+}
+
+
+config_set_name()
+{
+	echo -n $1 >  $DIR/config_name
+}
-- 
2.30.2

