Return-Path: <linux-fsdevel+bounces-10089-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDE4847A96
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0C1B2852F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F857A73D;
	Fri,  2 Feb 2024 20:39:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DCD48788
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906391; cv=none; b=D/aWLq/s0ykMXLcL/PogzhWiqL3IFCiJFm01w9hkc9cEQxxC9nQ66VimeP6WF6irN0JEEJ6bvjlfOE48Ny57y9FWxSx57IA9qRv5lg3IknxIK8EBuIoBhbPatfQBkTaKIxRApf2RkZ90W3NArwOnQtCzSlmtIk0GSP5zFft9fTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906391; c=relaxed/simple;
	bh=9vS2BqhDsnRY9TWsjUOBP5i2r4QT0NEevOkYXmxkIMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5dnnZmDOIA/cDRGx/uxuffhTtlwhworJFu8BNW/eBt03GQvyx1KDc/hc5cKi2o5ogJ3YbPnt1RXRyqaKgjCys9ZKb565k6pmimoIRlWuCceG/YXse4+WFXkE3cnU91L0yjMMn6qEc8wIvkgY7bTGOf0cOQWSHbyllG/T2aLBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3637860f03bso8685635ab.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 12:39:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906389; x=1707511189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHt4H/x+qcMPzHU6qwJG2VMpe3tJiV6m8j63XJJYag0=;
        b=shwvaGuaO77Q3YmfDvPXMvqMLnTMbs3rv60TbccjT7XrIive/S4E5ux9gQRw5Tb61v
         QpSdQW3fHelcCDTYNOrUf02oF278wOpjHOlOQCOcl/ql8RDdNmc25ncZlWSMRXO8lzvY
         kSHKEObAZkMnUS1jDFlPxujzCkGokEgc4eIfWbxyV6A2H7A5W5JQC2O3CzRJ0NwkQMTI
         xGACWvMOng+4V8/bpm1nnsN6Lx6+5ut0nAmginqlAeD4K+QxWm2Vy8il48CVIlY/x+3o
         v52mulZLmzMGXxTxMA+r2dgyUTd1JE/CWTvJlqLITjPbxTCxRehWe0B/TWNoHgMl+9NZ
         ynMA==
X-Gm-Message-State: AOJu0YzQbihbxbExGGtDbhakWxcwde4PmtCyYSCj2OqHyfiHtxCbznCf
	DTlc5iUX5GPH8lZXdZaElUSBuG/yC/Bg7QXHBH5nLZsRvRYZwPjk
X-Google-Smtp-Source: AGHT+IGv9WHtffWpyc1HN7hnIjMDANFz34q2cM0+WcYXw6xG1BniLInmR2c1p0vqtPkRKpHp+nXIUQ==
X-Received: by 2002:a92:de52:0:b0:363:b669:d102 with SMTP id e18-20020a92de52000000b00363b669d102mr2057763ilr.0.1706906388910;
        Fri, 02 Feb 2024 12:39:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVhssh8LXIufojR6mMglKpv1SZAC+S6Ed7qg9tuTkHrXr9ppZdAvw420Aeo9h1+mLUdDSobtYvM4FWByoOz7lUNmCmgeXRgLTKg8n18BRqItdBwhNf0Em/KtMqLVhIwfmA4NjvkgDNeHpR7JGI0fSgjqIdR49EWZhVQt5zyCX+JECQa22vo4Q0U1VMFw55jc22QimJv
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:4cc3:4ab5:7d2:ddc7])
        by smtp.gmail.com with ESMTPSA id f8-20020a63de08000000b005d8aef12380sm2239678pgg.73.2024.02.02.12.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 12:39:48 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/6] Restore data lifetime support
Date: Fri,  2 Feb 2024 12:39:19 -0800
Message-ID: <20240202203926.2478590-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Hi Christian,

UFS devices are widely used in mobile applications, e.g. in smartphones.
UFS vendors need data lifetime information to achieve good performance.
Providing data lifetime information to UFS devices can result in up to 40%
lower write amplification. Hence this patch series that restores the
bi_write_hint member in struct bio. After this patch series has been merged,
patches that implement data lifetime support in the SCSI disk (sd) driver
will be sent to the Linux kernel SCSI maintainer.

The following changes are included in this patch series:
 - Improvements for the F_GET_RW_HINT and F_SET_RW_HINT fcntls.
 - Move enum rw_hint into a new header file.
 - Support F_SET_RW_HINT for block devices to make it easy to test data
   lifetime support.
 - Restore the bio.bi_write_hint member and restore support in the VFS layer
   and also in the block layer for data lifetime information.

The shell script that has been used to test the patch series combined with
the SCSI patches is available at the end of this cover letter.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v1:
 - Rebased this patch series on top of the vfs.all branch.
 - Use READ_ONCE() / WRITE_ONCE() to access i_write_hint in the fcntl
   implementation.

Bart Van Assche (6):
  fs: Fix rw_hint validation
  fs: Verify write lifetime constants at compile time
  fs: Split fcntl_rw_hint()
  fs: Move enum rw_hint into a new header file
  fs: Propagate write hints to the struct block_device inode
  block, fs: Restore the per-bio/request data lifetime fields

 block/bio.c                 |  2 ++
 block/blk-crypto-fallback.c |  1 +
 block/blk-merge.c           |  8 +++++
 block/blk-mq.c              |  2 ++
 block/bounce.c              |  1 +
 block/fops.c                |  3 ++
 fs/buffer.c                 | 12 ++++---
 fs/direct-io.c              |  2 ++
 fs/f2fs/f2fs.h              |  1 +
 fs/fcntl.c                  | 64 +++++++++++++++++++++++--------------
 fs/inode.c                  |  1 +
 fs/iomap/buffered-io.c      |  1 +
 fs/iomap/direct-io.c        |  1 +
 fs/mpage.c                  |  1 +
 include/linux/blk-mq.h      |  2 ++
 include/linux/blk_types.h   |  2 ++
 include/linux/fs.h          | 16 ++--------
 include/linux/rw_hint.h     | 24 ++++++++++++++
 18 files changed, 102 insertions(+), 42 deletions(-)
 create mode 100644 include/linux/rw_hint.h


