Return-Path: <linux-fsdevel+bounces-20301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5068D137D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 06:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 253B31F23D8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 04:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AD71C6B8;
	Tue, 28 May 2024 04:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcYt5aFI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233C1D699;
	Tue, 28 May 2024 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716871030; cv=none; b=cIGh/EMoIZ5iXdJerkqVty1yZDP1J8QomPe8w3a3ozunhuVO+ETxRWUDONJhfe9E/quGtL4pBiqaXoA2GgpYlcGczOlTzEzxEln4GyHC0gVzKZ90k2TZzjALCzkPVNuQUD1btPll4i6yfBw/icKwE4zBnxpJIslU2EnS94gSbBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716871030; c=relaxed/simple;
	bh=RecDOvTp7V9U4Hp5VKqC8OYPaihTZu1E3lNwHIkMPk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJPXGPP7jvYV1fTz8IntLWAeUWEYJ5f/eHdg0oLzsgDV9suAfr+aMROw3CR2hJvDRDs6uDHwcGLiAq+3/BGvi5XtSNlZNP4PpyTYy0inEOFeWU79i7Ts2SBrHcg8EK/XIVmOUuV4M4DlH81lueGEowcOrkc1zS3wz3xkmpD6EIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcYt5aFI; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3737b281d89so1888725ab.0;
        Mon, 27 May 2024 21:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716871028; x=1717475828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bMpY5aevVZFRxB8skfCbfpL1jf4BDnAEwOKXi8CvdY=;
        b=ZcYt5aFIJi5bCCpkeEaFsOnpmlPpviDCW1tq7udWnkSSKbrba0q3EIhROmLHh1XFP9
         MXcVty0XbO//Ho7cDyNdQ7qsMABXyPOjFbQdmON6WZhBaY64xiTvO0BOSr+DwYLJN5qc
         OBYZW0EBNuQ4mVc9wR4H5FyGihfzP1iJuq/RjDEhIQHIP9JfjL622kII0USYUFWXHxCo
         TA3WucV1qTblZCCRnYmjwvHO6VIX+vaEx4jLNLh05C97XeUHMvhGxH0u0IeKgT7e+NfH
         OwnWEUSDvSa2Xk3+82kBPPDOgrc9MOUdgudzRpxYekgqOg+YQE0Bc7m5tVoBWgrpKW8Y
         SAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716871028; x=1717475828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bMpY5aevVZFRxB8skfCbfpL1jf4BDnAEwOKXi8CvdY=;
        b=hdiP5g0omnY9k8QbgwfxEoSaRq8pg7sUsi+eHzwhqaoQyb8MJBXoKul8D3nil1YzW2
         Bx3cFotGG2TyiSldGQvVgSmJ82OMpW+Jhf5EENYZPEoiebgx790lME/JY8NGR8KCQ7rp
         LdYTZS/qDUKAI+o26KubEdMjpVw3jgThZFnp+ppmV+ye7RYsl7sV4TjYqvcJd6uSKxsO
         pU9/zGizYgRB+A3R1/cXj5x2euruAZvr80Y+hhVf+7vQdubE+aGMuFq8SMT2ToNdIm0O
         C2pr9piBTNfQoHCo79/CIuN6vycsk32B3rHIdn3l+jVUWgUIqWBpfK5DAQL6Hkyzek9M
         y+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCU+5Uxyih6jheW884QLKt0dyMlRHTKzdfbWHQ0i5JsxfXanVi70ACT/368GMMhzcHlePslehfCIsoxAlU1DwTyhRmw17f5xRwcpvEir/SlAV1wEdpV3KHXZljRnJGK4aoDp/LidykDKNAfKEFS4
X-Gm-Message-State: AOJu0Yzu/ghMS1n6aGe2MsO2qpiT3mB56YC3q2Fkf+9klE9MNWZKBfOF
	WuFLI9esJERENv8chbU1vCTMwTcDe6bSTttg3JHimowePqFgk1UM
X-Google-Smtp-Source: AGHT+IHSciGuZvdKzTNi/RPP/y7FlBaWRUn4F8PqJEOOcJKkaL5JZSBP4M40uP0V8kaOMEHIvdi0Ag==
X-Received: by 2002:a05:6e02:1c4e:b0:36a:1e30:36a8 with SMTP id e9e14a558f8ab-3737b31cedemr124310885ab.14.1716871028423;
        Mon, 27 May 2024 21:37:08 -0700 (PDT)
Received: from fedora-laptop.hsd1.nm.comcast.net (c-73-127-246-43.hsd1.nm.comcast.net. [73.127.246.43])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3737d1468b7sm18013605ab.26.2024.05.27.21.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 21:37:08 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	sandeen@redhat.com,
	dhowells@redhat.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH KTEST] add test to exercise the new mount API for bcachefs
Date: Mon, 27 May 2024 22:36:12 -0600
Message-ID: <20240528043612.812644-5-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528043612.812644-1-tahbertschinger@gmail.com>
References: <20240528043612.812644-1-tahbertschinger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
 tests/bcachefs/single_device.ktest | 33 ++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/bcachefs/single_device.ktest b/tests/bcachefs/single_device.ktest
index 7476a08..e170b8b 100755
--- a/tests/bcachefs/single_device.ktest
+++ b/tests/bcachefs/single_device.ktest
@@ -79,6 +79,39 @@ test_remount_ro_rw()
     check_counters ${ktest_scratch_dev[0]}
 }
 
+test_mount_options()
+{
+    local dev=${ktest_scratch_dev[0]}
+    set_watchdog 10
+
+    run_quiet "" bcachefs format -f --errors=panic $dev
+
+    echo "test: valid mount options"
+    mount -t bcachefs -o metadata_checksum=crc64,metadata_target=$(basename $dev) $dev /mnt
+    mount -t bcachefs | grep --quiet metadata_checksum
+    mount -t bcachefs | grep --quiet metadata_target
+
+    echo "test: valid remount options"
+    mount -o remount,ro,errors=continue /mnt
+    mount -t bcachefs | grep --quiet metadata_target
+    mount -t bcachefs | grep --quiet continue
+    mount -t bcachefs | grep --quiet ro
+    umount /mnt
+
+    echo "test: invalid mount options"
+    ! mount -t bcachefs -o metadata_checksum=invalid $dev /mnt
+    ! mount -t bcachefs -o promote_target=$(basename $dev),metadata_target=not_a_device $dev /mnt
+
+    echo "test: invalid remount options"
+    mount -t bcachefs $dev /mnt
+    ! mount -o remount,promote_target=not_a_device /mnt
+    ! mount -o remount,metadata_replicas=not_a_number /mnt
+    umount /mnt
+
+    bcachefs fsck -ny $dev
+    check_counters $dev
+}
+
 test_extent_merge2()
 {
     local p=/sys/module/bcachefs/parameters/debug_check_iterators
-- 
2.45.0


