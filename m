Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E8F36C9AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Apr 2021 18:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237702AbhD0QpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Apr 2021 12:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236647AbhD0QpM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:45:12 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9FCC061760;
        Tue, 27 Apr 2021 09:44:28 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id 1so44609260qtb.0;
        Tue, 27 Apr 2021 09:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V+ync5bxHzaagLCmhFDwdwgW6fDC4JoiKPxDng/FSoE=;
        b=c/aC+Nn7ZYf6yFdNI45PdnOrruqUtl2T5zI0epEt0uFOLFafsW3xC87HSJiYdXRQji
         fCSfJl3NKGamOSMkVm0IWAiZGiYwAV0QQX8yWMcDWkpIYjdH7L8byztcvdzD+vDJAKRv
         /rGXdY8Lajz3pqcFk3boFXgKLFgL5Gs0gC4xNhoPdjr00kX15PSCGTwJvKjLbi5W1+kI
         8lVGTxZfuwYNSGkZA3B1npd6/pop+HgHIyeaQHyPwcZseBxbpLzSovTrm/rk+W1nV9JX
         pH26yDJ/9Fp3E343N54TvsCgvcXT6JbgkY6r+iosvH3Vx4v8OBdTA0eBTUhfchyJkHdA
         +QNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V+ync5bxHzaagLCmhFDwdwgW6fDC4JoiKPxDng/FSoE=;
        b=JTW5FDxFR9bAcQ24E0CTR9tgIz5vyhEyAqiG+S0nOieFkaoVg8eUOovdsjdZya466z
         UYiQbNTLe+Bim61rhZIF970hGd++sa1+WvZ+/1gZFlJrdanJ1hDW0m5qH/+W8xc7U/uv
         1L40+QW5pjh5dUcxMKnj+A17ClkBZPaTtsFCaZvqkr2TwutZgJjXnHBkIBWE9YXeVFom
         vOZwOW0GUZvjMqssKqZoWkJ7jBVzeWfOReawQoGjiP7wzJK3f7NtxeUOUIyxWcUNJGll
         rWKDf5H5CtDwCD/SDTlYt1o3Bnjb8HDbrF6jgbKrPwqelkY0YUZU1LNp0JXOcRRjrTVJ
         Qw7Q==
X-Gm-Message-State: AOAM5302Uk6MMrCJPiLZPQJxGrL86MFXtjn2d2Ppf3VBcK8xxSjtMkl3
        44JWfPzz27h0US2oopG71unn5T+gL5du
X-Google-Smtp-Source: ABdhPJxig6rEtnEG/zWEBTgvmXAHWZ7lO77Oaci897rw5jjrV+EvzRf8mnsbZHU9kRfUqsI+dYIEEw==
X-Received: by 2002:ac8:68d:: with SMTP id f13mr22614893qth.300.1619541867949;
        Tue, 27 Apr 2021 09:44:27 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id l71sm3149163qke.27.2021.04.27.09.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:44:27 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 3/3] Use --yes option to lvcreate
Date:   Tue, 27 Apr 2021 12:44:19 -0400
Message-Id: <20210427164419.3729180-4-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427164419.3729180-1-kent.overstreet@gmail.com>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This fixes spurious test failures caused by broken pipe messages.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 tests/generic/081 | 2 +-
 tests/generic/108 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/081 b/tests/generic/081
index 5dff079852..26702007ab 100755
--- a/tests/generic/081
+++ b/tests/generic/081
@@ -70,7 +70,7 @@ _scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
 $LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
 # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
 # (like 2.02.95 in RHEL6) don't support --yes option
-yes | $LVM_PROG lvcreate -L 256M -n $lvname $vgname >>$seqres.full 2>&1
+$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
 # wait for lvcreation to fully complete
 $UDEV_SETTLE_PROG >>$seqres.full 2>&1
 
diff --git a/tests/generic/108 b/tests/generic/108
index 6fb194f43c..74945fdf3c 100755
--- a/tests/generic/108
+++ b/tests/generic/108
@@ -56,7 +56,7 @@ $LVM_PROG pvcreate -f $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
 $LVM_PROG vgcreate -f $vgname $SCSI_DEBUG_DEV $SCRATCH_DEV >>$seqres.full 2>&1
 # We use yes pipe instead of 'lvcreate --yes' because old version of lvm
 # (like 2.02.95 in RHEL6) don't support --yes option
-yes | $LVM_PROG lvcreate -i 2 -I 4m -L 275m -n $lvname $vgname \
+$LVM_PROG lvcreate --yes -i 2 -I 4m -L 275m -n $lvname $vgname \
 	>>$seqres.full 2>&1
 # wait for lv creation to fully complete
 $UDEV_SETTLE_PROG >>$seqres.full 2>&1
-- 
2.31.1

