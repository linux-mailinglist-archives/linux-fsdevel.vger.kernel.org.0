Return-Path: <linux-fsdevel+bounces-57492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCB3B22297
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 11:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B46A4E1716
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5932E8DE2;
	Tue, 12 Aug 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSqkyw41"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688B12DF3F8;
	Tue, 12 Aug 2025 09:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990153; cv=none; b=t8Nb0knnHtbMoosS0j5iJEevH+BDHR20/fxKxprUPE8dTfKig9mC5XKdzo6iZKIwp8uvAdV0hEccN+eaWMXG/xJER9D1d+Mct8bQS3luT+TRt7SSfaBwiI6hldOl84srGyKcmE6uq5xYaLDexj2+8BNhTaFbo5nUW6KZwf6+yEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990153; c=relaxed/simple;
	bh=j9+6/BtKXkL2QaMY2FoQC+HwWI3ZEqaWiBWV7v0gt+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzA0KpCk+lIuUZYHiJ0LrwgRJZYh/jRgUPMtA6LZW+zAnETkyKn4Ku5Xkqgph0QCi5rbq4SsVVLRyy2plI8szFE+PUCzbokHSGVLgtB/qcoir1uHJd6YgVbt/SuVtlRpZqo75CynoAKjvyMdOXFe72s3IoTbxAUVjZv2DBGvkU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSqkyw41; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2403ceef461so44065315ad.3;
        Tue, 12 Aug 2025 02:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754990152; x=1755594952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WbwDl4rRVtn28imgZeHnrlv/um74SVfJLwZLvLqwSRA=;
        b=jSqkyw41T8xrZA6ma74MZb/FFz6K0VOJtXbdmveLBi7gjOYAe/raaTzZcd2LpmxKw2
         4Xs+zGaTqKuUlYhWKHjAt9kX9pzQDMDDhkQ52El+nADqem1mTFyK+ONS3SS6ScIW+CUn
         psSUcz/Q1jhInPmJaSzSwmCedG9dgWnmy3TNhPSSh5XP6Q7gWy0DTycaz2Pte2X1M4G8
         2y+rVv1vNHxaLflxBiv5L/SiOjemhRjs5sfsCkMjZWD1SjFF7caJacf1iVJzVO5IY8nW
         hP0QXdzZKjUCdQPsMmSSEXsirPPSMIHsxXn1JAly7SWHJhXJ4FGqlzug8BJFdYVz0TLh
         1K0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990152; x=1755594952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbwDl4rRVtn28imgZeHnrlv/um74SVfJLwZLvLqwSRA=;
        b=dUuWPyBRLMrDvSnySN8kCL5H/fELOzNgdxgtLvABP269Cxe903igiMCi7D06jfjyfD
         g44us/8VM5vOBdjeelAgxKWwtOq8VdLR8m5t51NOXabY6G5i/bZpBL1GLnxIrWTvhKee
         +SnwtUzQ6CP6ltrqhpwpKbUlfcXdT/i40SxgEnM51nkA/9YAemAjry9hfrtHdHuAdhkK
         btLpCCjGmHP1UArULVNG4G+Ury6XgoXCB2QjRFL/tTcyfTYOh1NY62t2bXOA+xULafmo
         MLQbRXI2pj4EteEtYov9VUUyRdfjnVII5agZzfl74oSzuME+1GCOqPScFSKe43Pqdu9R
         bhdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPcXduJFwKRWt47X6aYlU8x6taVXXuKGgFP0Ul4koAjSowL9Z7rdTP0YWwYomCWH/hbnzaRiKUAwxAuhbb@vger.kernel.org, AJvYcCXjeqBWRsZ8VQgycOw2x+w3WuaFL4mIlp71rgjTCvVKeOnOv95tByDbZybnjHwS1+1FG1/r3oGtSRdTTWy5@vger.kernel.org
X-Gm-Message-State: AOJu0YwnfLGTbi7LNNyb4ZPZiDJ7TXSTKIJk/LAcUzh0bo5iBfiVKDb8
	y9iIZQDVLNN69l2ppoo801NDoxNzCh98+bRiV4NJ5DeRsEdKIIrt9tVR
X-Gm-Gg: ASbGncu3Ui8uZMVKl2Y2V0aw3VIN+WCTQynBU9ROjB10mx1k/NVwQEugtunopmDXin+
	zlIwUnj7lt+ACGaTNmW4ouNN0kebV4DIf+exPVBw+Lu+vXvRMPUQVq+sWgfdOZiMLWL3fgkLZ0w
	8okFnmWhsB2gVfdjIn4im8zB3O8Ds2WjHJItcAnsxL9fE9wSbmDptNvwYkWpbFVSOZpyHBMNj98
	1+QpkdcOEbrplRwqRZRvsEY4xqgAk/x3lnBulNViXe+t/377XNpRdy9ynk5WtX5xsmpcawhaLMs
	4DCaLATIS9UBLKUBlN0GvuRchtchCWav0YRz5wpZ51qxwIw5nDEVrcyXbpMbtOInn63twkf8g3d
	y4gpDezDYoDemoW7P1sTFhI50Wc7asbNsvoY=
X-Google-Smtp-Source: AGHT+IGuIQ1YTqAaMYMDmAKJX2mJyPZGXP1hLFmGpeB4DWEiDBGam4XzBUEoGRxXqCcEXbLfGwwDRA==
X-Received: by 2002:a17:902:e84b:b0:240:483:dc3a with SMTP id d9443c01a7336-242c1fdc531mr262814785ad.12.1754990151568;
        Tue, 12 Aug 2025 02:15:51 -0700 (PDT)
Received: from VM-16-24-fedora.. ([43.153.32.141])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f1efe8sm291670665ad.69.2025.08.12.02.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:15:51 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: brauner@kernel.org,
	djwong@kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH v3 0/4] allow partial folio write with iomap_folio_state
Date: Tue, 12 Aug 2025 17:15:34 +0800
Message-ID: <20250812091538.2004295-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

With iomap_folio_state, we can identify uptodate states at the block
level, and a read_folio reading can correctly handle partially
uptodate folios.

Therefore, when a partial write occurs, accept the block-aligned
partial write instead of rejecting the entire write.

For example, suppose a folio is 2MB, blocksize is 4kB, and the copied
bytes are 2MB-3kB.

Without this patchset, we'd need to recopy from the beginning of the
folio in the next iteration, which means 2MB-3kB of bytes is copy
duplicately.

 |<-------------------- 2MB -------------------->|
 +-------+-------+-------+-------+-------+-------+
 | block |  ...  | block | block |  ...  | block | folio
 +-------+-------+-------+-------+-------+-------+
 |<-4kB->|

 |<--------------- copied 2MB-3kB --------->|       first time copied
 |<-------- 1MB -------->|                          next time we need copy (chunk /= 2)
                         |<-------- 1MB -------->|  next next time we need copy.

 |<------ 2MB-3kB bytes duplicate copy ---->|

With this patchset, we can accept 2MB-4kB of bytes, which is block-aligned.
This means we only need to process the remaining 4kB in the next iteration,
which means there's only 1kB we need to copy duplicately.

 |<-------------------- 2MB -------------------->|
 +-------+-------+-------+-------+-------+-------+
 | block |  ...  | block | block |  ...  | block | folio
 +-------+-------+-------+-------+-------+-------+
 |<-4kB->|

 |<--------------- copied 2MB-3kB --------->|       first time copied
                                         |<-4kB->|  next time we need copy

                                         |<>|
                              only 1kB bytes duplicate copy

Although partial writes are inherently a relatively unusual situation and do
not account for a large proportion of performance testing, the optimization
here still makes sense in large-scale data centers.

This patchset has been tested by xfstests' generic and xfs group, and
there's no new failed cases compared to the lastest upstream version kernel.

Changelog:

V3: patch[1]: use WARN_ON() instead of BUG_ON()
    patch[2]: make commit message clear
    patch[3]: -
    patch[4]: make commit message clear

V2: https://lore.kernel.org/linux-fsdevel/20250810101554.257060-1-alexjlzheng@tencent.com/ 
    use & instead of % for 64 bit variable on m68k/xtensa, try to make them happy:
       m68k-linux-ld: fs/iomap/buffered-io.o: in function `iomap_adjust_read_range':
    >> buffered-io.c:(.text+0xa8a): undefined reference to `__moddi3'
    >> m68k-linux-ld: buffered-io.c:(.text+0xaa8): undefined reference to `__moddi3'

V1: https://lore.kernel.org/linux-fsdevel/20250810044806.3433783-1-alexjlzheng@tencent.com/

Jinliang Zheng (4):
  iomap: make sure iomap_adjust_read_range() are aligned with block_size
  iomap: move iter revert case out of the unwritten branch
  iomap: make iomap_write_end() return the number of written length
    again
  iomap: don't abandon the whole copy when we have iomap_folio_state

 fs/iomap/buffered-io.c | 68 +++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 21 deletions(-)

-- 
2.49.0


