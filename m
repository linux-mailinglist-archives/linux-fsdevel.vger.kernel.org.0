Return-Path: <linux-fsdevel+bounces-49862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3A7AC4391
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 19:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36A73ABAAA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 17:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4CD23E35E;
	Mon, 26 May 2025 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gE4szHvQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE912A1A4;
	Mon, 26 May 2025 17:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748282086; cv=none; b=NKyuVVNZsbZ0riaFhxeMzVO0PMvnbuurTkaYsVGzwP5ZwmP86TWEXONKuSEHKdluZPsO+LYIoflpl2TjnSxGLmn4arNSOQZrlBAepS8j1pBi6g2sdoeZlClzeyaTmHTz/ab2IZk1BJS6tDPx882XzdXe9znZ4F2mmv9DoI2uE84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748282086; c=relaxed/simple;
	bh=RiugET/wmbwy36f/Zti7VV2TCNg+g7BYaeB34ODVReU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mnsOqINPVF0LA8izVLCjkRcyOzQUuvaYzXc+VkvkNRjZeudSaHr6gzFdga86j9+RGXlNxfhLybivT9CXA1BymBDXvYrymTOpMajl5Esnpc7buSQr8psZML5oDA5v/JDgt0WN/exmgA3Ph6eSDMw6aVg6PA1w4mOM9cM6R2nl7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gE4szHvQ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4c9024117so1912184f8f.0;
        Mon, 26 May 2025 10:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748282083; x=1748886883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=enHoO/sz9x+16UFfRaxKa/msLfJCJBolFi9i0cloaB8=;
        b=gE4szHvQIyap/DGAt66Pe3PNu0dDN1Oa1s0KfcEfvAcnsarVAs1b3fhqHCeuduw1Ib
         ezj5+xYbuq0lc3OJVE1X2g47AWqMwwxErjxLoM7YX5vB98O1topglvklilp1Pt/J35GW
         l4gC+zFnWganteWwlAkNADjobJ7JGIqWIurZa6caP6uQE+ySUzz3SfthsiftjTnZx1m/
         u5NQMyCnkXrTEoUdml0+gehgzeZ7q7UpYfjohlmA02Zw0fbNI7tdtxpa1Px2twqqO3yi
         v2L2P/IYVoLtgHwW6HYkB+8mhy1BwFY/VVzLRvoC/8PHDei2lRf1L50nRzy+ZByWIPfT
         rkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748282083; x=1748886883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=enHoO/sz9x+16UFfRaxKa/msLfJCJBolFi9i0cloaB8=;
        b=uJ7whl0YRnpiaVB7496IHxC4qVQbLF9+uqUw8ihXd0MZuXOcwvyW4TBLwMR4E1DWJY
         5TCbauoK2EzlpBNRYLTztdV4TlelAj7mFcdRzZdA5HK45wMUR70g1APD53/PEmB37lc4
         uga9avVtkAUduBQeT4od78uTltGUgnKrgtktS6vc2WALwXHKvAMfbv05qLiqXfN5qU8y
         N7d8Cf+7JhGOoHbMbmyc8gfy3U16MqZNMlSa3YBp9c7QQ/Gkh79QMDipRco7cTUn8hl2
         9RFSYFDtNbqIGfi1MWPBynQRrcD+tHCgV8xQtMbu3gvndR6RNCSepVZBuIcpMSiyr4P7
         oYrw==
X-Forwarded-Encrypted: i=1; AJvYcCV965jzvt0bsJkci5tuxlVuDq3OQl4MAaBmnQhWYeeFMaUijxhEcvjvimM7d03j2gZaMSef95my@vger.kernel.org, AJvYcCVhESb5ZqZoyO9GlPbcuW65X+UusSd2uhw9JYOfmQPfCuJ1yKtx3s+g3KdDJvNU57y9bazbAU1h0G7F7RZbKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhBMaRDDf871PCp3eAFjd+jTKIa8vQeKVp5cME4DUw6wCfytOq
	BQ67eQcx1F/SSGXIeh6SSMTUPLhIX9S/z352Ox0pW4Q2wtEVQovJNXC0
X-Gm-Gg: ASbGnctomuJIyCC8PCcqpHYO4x7/xCktMsY6SMvRZY2wUFraebPy/wTV+Z4S7dbHguA
	y6uBscRRRWnu56ug2QHotI5oq0K/7LtWYZHxRpx+MMGsoy+EoZk3L6kPF/toIErp37G5ufWOvwg
	ZZI2wp2FZD29I5fEvJmkT9CxBdaQsKJcodrgGZKGj48AWBHj2PdpAJLAs6rWhCERaOFONrnNhaU
	ntr3ig6k9xAnlO7497jfPyO8BgXbQ93MYE6Mry6gXuYAoh2V0nksY/0PmXPE0rY3UjLgLVvAPWR
	CV075hSZcwgGnj4lYf1VQfRikWGqGIvj4lWqAH+2n4Qo1/Pxa2VvRypo594bj+YoeIptfFmbhYO
	tai25+TTpOHkj6D1aAEzAvX254jTPAp7tWCCc2P4BvaGTDSiq
X-Google-Smtp-Source: AGHT+IFGWBrJuyyaKi64sN6FrhGeHzbD8bg+OdD5YoncI6NTdFaU5rrNFQYZDjoAOJ1EXR0kuE+9fw==
X-Received: by 2002:a05:6000:228a:b0:3a3:7be3:d0aa with SMTP id ffacd0b85a97d-3a4c153f8c6mr11376905f8f.18.1748282082663;
        Mon, 26 May 2025 10:54:42 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d3a74422sm5591176f8f.18.2025.05.26.10.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 May 2025 10:54:42 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Zorro Lang <zlang@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	fstests@vger.kernel.org,
	Yang Xu <xuyang2018.jy@fujitsu.com>,
	Anthony Iliopoulos <ailiop@suse.com>,
	David Disseldorp <ddiss@suse.de>
Subject: [PATCH] generic: remove incorrect _require_idmapped_mounts checks
Date: Mon, 26 May 2025 19:54:37 +0200
Message-Id: <20250526175437.1528310-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f5661920 ("generic: add missed _require_idmapped_mounts check")
wrongly adds _require_idmapped_mounts to tests that do not require
idmapped mounts support.

The added _require_idmapped_mounts in test generic/633 goes against
commit d8dee122 ("idmapped-mounts: always run generic vfs tests")
that intentionally removed this requirement from the generic tests.

The added _require_idmapped_mounts in tests generic/69{6,7} causes
those tests not to run with overlayfs, which does not support idmapped
mounts. However, those tests are regression tests to kernel commit
1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers")
which is documented as also solving a correction issue with overlayfs,
so removing this test converage is very much undesired.

Remove the incorrectly added _require_idmapped_mounts checks.
Also fix the log in _require_idmapped_mounts to say that
"idmapped mounts not support by $FSTYP", which is what the helper
checks instead of "vfstests not support by $FSTYP" which is incorrect.

Cc: Yang Xu <xuyang2018.jy@fujitsu.com>
Cc: Anthony Iliopoulos <ailiop@suse.com>
Cc: David Disseldorp <ddiss@suse.de>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

Please confirm that I am not missing anything.

should we leave those tests or remove them from the idmapped test group?

Thanks,
Amir.

 common/rc         | 2 +-
 tests/generic/633 | 1 -
 tests/generic/696 | 1 -
 tests/generic/697 | 1 -
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index bffd576a..96d65d1c 100644
--- a/common/rc
+++ b/common/rc
@@ -2639,7 +2639,7 @@ _require_idmapped_mounts()
 		--fstype "$FSTYP"
 
 	if [ $? -ne 0 ]; then
-		_notrun "vfstest not support by $FSTYP"
+		_notrun "idmapped mounts not support by $FSTYP"
 	fi
 }
 
diff --git a/tests/generic/633 b/tests/generic/633
index f58dbbf5..b683c427 100755
--- a/tests/generic/633
+++ b/tests/generic/633
@@ -12,7 +12,6 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
 # Import common functions.
 . ./common/filter
 
-_require_idmapped_mounts
 _require_test
 
 echo "Silence is golden"
diff --git a/tests/generic/696 b/tests/generic/696
index d2e86c96..48b3aea0 100755
--- a/tests/generic/696
+++ b/tests/generic/696
@@ -17,7 +17,6 @@ _begin_fstest auto quick cap idmapped mount perms rw unlink
 # Import common functions.
 . ./common/filter
 
-_require_idmapped_mounts
 _require_test
 _require_scratch
 _fixed_by_kernel_commit ac6800e279a2 \
diff --git a/tests/generic/697 b/tests/generic/697
index 1ce673f7..66444a95 100755
--- a/tests/generic/697
+++ b/tests/generic/697
@@ -17,7 +17,6 @@ _begin_fstest auto quick cap acl idmapped mount perms rw unlink
 . ./common/filter
 . ./common/attr
 
-_require_idmapped_mounts
 _require_test
 _require_acls
 _fixed_by_kernel_commit 1639a49ccdce \
-- 
2.34.1


