Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9379E1F583F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 17:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730382AbgFJPto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 11:49:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40841 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730357AbgFJPtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:49:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id e18so1158407pgn.7;
        Wed, 10 Jun 2020 08:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ht44Q655K+m4n+7cL9U0d/GUBshFxQzLVevKrr2oj0M=;
        b=UeqiLKBwMMpyNhNwyNWB86Wi4G23QdyqZIvrfKNvXCnjX0MSKPxC0GkslMg6lAC3qU
         fp8mdqtqt9AQjAopXVIjoMS5oV3iuz4ExE6TaMwMCNsJIj4bAcdxiRR2SwnDzcg2TjUq
         vUw7niJXVFqD/tZJEB7tyzvOKUmP/YBUpisgVDOQDfvZAdtkyvC1OCkaWv6w0u0M7+Gc
         Mnkan/ZlrweFcXRosYrGOqjGu7bb2Chs1oCFClRt5Z1obrT/ZZSz/T8aI2qlIZ2ugVjI
         8XxlXgaWm+3TkEsJZz/GQMC/zs2YzKRbMInW6WMOjLMCjC2Ob10j0D0i6TzeTAb5Oggm
         dvww==
X-Gm-Message-State: AOAM533MKh2QjOo+0rCUCt2jr997ZQB1CEd6L3c1F9OM6kQPeT+KWaVr
        QBQ9cbkSCL5kHVIIP65uNQM=
X-Google-Smtp-Source: ABdhPJy5SAdyQfQNoaTz3plQH9NsEWiOAvKCXruBaMt6+7nC5TCy5/CdN/0cXMcdcKFyT5YHNMINbw==
X-Received: by 2002:a62:7a89:: with SMTP id v131mr3246047pfc.38.1591804174942;
        Wed, 10 Jun 2020 08:49:34 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id m15sm247162pgv.45.2020.06.10.08.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:49:33 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 94C9741DD1; Wed, 10 Jun 2020 15:49:25 +0000 (UTC)
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, bfields@fieldses.org, chuck.lever@oracle.com,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        davem@davemloft.net, kuba@kernel.org, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, jmorris@namei.org,
        serge@hallyn.com, christian.brauner@ubuntu.com
Cc:     slyfox@gentoo.org, ast@kernel.org, keescook@chromium.org,
        josh@joshtriplett.org, ravenexp@gmail.com, chainsaw@gentoo.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        bridge@lists.linux-foundation.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH 5/5] selftests: simplify kmod failure value
Date:   Wed, 10 Jun 2020 15:49:23 +0000
Message-Id: <20200610154923.27510-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200610154923.27510-1-mcgrof@kernel.org>
References: <20200610154923.27510-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

The "odd" 256 value was just an issue with the umh never
wrapping it around with WEXITSTATUS() for us. Now that it
does that, we can use a sane value / name for the selftest,
and this is no longer a oddity.

We add a way to detect this for older kernels, and support
the old return value for kernel code where it was given.

This never affected userspace.

Reported-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tools/testing/selftests/kmod/kmod.sh | 46 +++++++++++++++++++++++-----
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kmod/kmod.sh b/tools/testing/selftests/kmod/kmod.sh
index da60c3bd4f23..df7b21d8561c 100755
--- a/tools/testing/selftests/kmod/kmod.sh
+++ b/tools/testing/selftests/kmod/kmod.sh
@@ -64,6 +64,8 @@ ALL_TESTS="$ALL_TESTS 0009:150:1"
 ALL_TESTS="$ALL_TESTS 0010:1:1"
 ALL_TESTS="$ALL_TESTS 0011:1:1"
 
+MODULE_NOT_FOUND="FAILURE"
+
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
@@ -155,14 +157,19 @@ test_finish()
 	echo "Test completed"
 }
 
+# OLD_FAILURE is just because the old kernel umh never wrapped
+# the error with WEXITSTATUS(). Now that it does it, we get the
+# appropriate actual value from userspace observed in-kernel.
+
+# We keep the old mapping to ensure this script keeps working
+# with older kernels.
 errno_name_to_val()
 {
 	case "$1" in
-	# kmod calls modprobe and upon of a module not found
-	# modprobe returns just 1... However in the kernel we
-	# *sometimes* see 256...
-	MODULE_NOT_FOUND)
+	OLD_FAILURE)
 		echo 256;;
+	FAILURE)
+		echo 1;;
 	SUCCESS)
 		echo 0;;
 	-EPERM)
@@ -181,7 +188,9 @@ errno_name_to_val()
 errno_val_to_name()
 	case "$1" in
 	256)
-		echo MODULE_NOT_FOUND;;
+		echo OLD_FAILURE;;
+	1)
+		echo FAILURE;;
 	0)
 		echo SUCCESS;;
 	-1)
@@ -335,6 +344,28 @@ kmod_defaults_fs()
 	config_set_test_case_fs
 }
 
+check_umh()
+{
+	NAME=''
+
+	kmod_defaults_driver
+	config_num_threads 1
+	printf '\0' >"$DIR"/config_test_driver
+	config_trigger ${FUNCNAME[0]}
+	RC=$(config_get_test_result)
+	if [[ "$RC" == "256" ]]; then
+		MODULE_NOT_FOUND="OLD_FAILURE"
+		echo "check_umh: you have and old umh which didn't wrap errors"
+		echo "           with WEXITSTATUS(). This is OK!"
+	elif [[ "$RC" != "1" ]]; then
+		echo "check_umh: Unexpected return value with no modprobe argument: $RC"
+		exit
+	else
+		echo "check_umh: You have a new umh which wraps erros with"
+		echo "           WEXITSTATUS(). This is OK!"
+	fi
+}
+
 kmod_test_0001_driver()
 {
 	NAME='\000'
@@ -343,7 +374,7 @@ kmod_test_0001_driver()
 	config_num_threads 1
 	printf $NAME >"$DIR"/config_test_driver
 	config_trigger ${FUNCNAME[0]}
-	config_expect_result ${FUNCNAME[0]} MODULE_NOT_FOUND
+	config_expect_result ${FUNCNAME[0]} $MODULE_NOT_FOUND
 }
 
 kmod_test_0001_fs()
@@ -371,7 +402,7 @@ kmod_test_0002_driver()
 	config_set_driver $NAME
 	config_num_threads 1
 	config_trigger ${FUNCNAME[0]}
-	config_expect_result ${FUNCNAME[0]} MODULE_NOT_FOUND
+	config_expect_result ${FUNCNAME[0]} $MODULE_NOT_FOUND
 }
 
 kmod_test_0002_fs()
@@ -648,6 +679,7 @@ load_req_mod
 MODPROBE=$(</proc/sys/kernel/modprobe)
 trap "test_finish" EXIT
 
+check_umh
 parse_args $@
 
 exit 0
-- 
2.26.2

