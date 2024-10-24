Return-Path: <linux-fsdevel+bounces-32797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0DB9AEDC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 19:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE1F1C23C39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2024 17:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D25F1FBF67;
	Thu, 24 Oct 2024 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq7u+nSn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B2B1F5844
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 17:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729790489; cv=none; b=WyXfrK+Kb9Qif/HhxMfJiPnORLXsaxzkgoDe33fXfTNeY2qDDjUOc76/6/aK53ux9pnbiBs6EWRLloVkh/ip9izR/wuBqG5PQBnFl3DIKfsXvbvyAoVjFqB0hDuw9n9+coQFbQaDCwfMqyTRP8nPVjpGJunb0wipgbDFVx42uLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729790489; c=relaxed/simple;
	bh=t0G7XvQELzJobEkpS6WgMQL2tbcYnf3YQE94YnBdn9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mic13ptLikWB3vxD16LE2X3ayGDF5lyGZQtr7IbEmAQJ0+ZDK+ZGnfeZKiWEuxtPfQHbg2SJPJFuYr+GsWjazhC2qcn0aHkjPKHDrpLMuv11wnWfDZYeXo0vPMsUlkmGnIFGssCF7xbXdqfSyrQAXn+Gvpjv832GUK0eFzRlyno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zq7u+nSn; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e59a9496f9so14231757b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2024 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729790487; x=1730395287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HTVaLroFuqdh1Iolf48zNhV4vvhWxe/V4feKI2fvWbc=;
        b=Zq7u+nSneAyocVRZwpWt0eE3Cbp9XfzrFhaUNDhoEhPrepEqrFDt6QoedPLAcsczUE
         SrM6g88BqArGAFWT5Pwxo9Qe7PoZV2uoPuyPgh3AI0WO01fa0Qn/mFbJoK1O8qoexyJ/
         gn3ZHbeenWSwEYEMAyA2tPNiFNr/Z0cWDHm9I+cgCPJDVSEjsy/1CNOEzUptDlzgnblW
         S3etpaN2+imLV3KphqCiD7oTYd+dedqIy4Q1hW6XebgXNjjtPndiBpSQqJFAjqTfgTW8
         oaD3IUw0E6B3O5/x4fOIKD5dlXX7FYw6Gw3tgq4lgCcMXaqZElsK5IjcdwVsIBq4QEgp
         2Q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729790487; x=1730395287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTVaLroFuqdh1Iolf48zNhV4vvhWxe/V4feKI2fvWbc=;
        b=uNzg4UTEA2xrOnzzG6Mlm7gJWhiWG5E9OGiHvb6OmawvBXFHMHgdaD+KPVv4jwi2c/
         h8PlI1wRqav472ycRRjMRoXyMF6J+jby2gef1O0C3bae5RD0/3vS+SGo4ptwDppd4S3p
         689pbwTqH5Ac9HGsFzV7tqYvC4SIRJ6P6oDRto63RvpUE3DoeY+otXsybfda6gifkTpa
         amG0zdgfnGdLu54palaf9zQjVpOmd1AhxUXZb9oLxMoQAqrvvcbUlQ7iVKtVM9YKOBkq
         0o0AcZrLKNP2TLn/2CWNHYcfTO4aAw76CbjLPQ9W/gRqpBRXLh+PWqcNxEg2eJ7Q5gKs
         oj+A==
X-Forwarded-Encrypted: i=1; AJvYcCV25GkkqbBP+yQ32TxsWL3zqh6U22coM2y7LmufLaQ3eq5lCHBpa6gZC8Xzjverjx3iWDsA+hdl+tyMXs6M@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4tq+oylP11rwJpj/WIe6oxj1G7aubi6GyLannxc6z1qE/nI/j
	bVfXIAp+Ue67JfrbfdYQrIn/j8FYSmla1QCEvaNDz8x7HyimSSsg
X-Google-Smtp-Source: AGHT+IGClbFs/NRqelAQStn1WDjqslLjdgC/t8ENpWTYj1J5IRjdj4JErmVQ4ZSOU+Bm+joES8fhHg==
X-Received: by 2002:a05:690c:fcb:b0:6be:54e1:f1f3 with SMTP id 00721157ae682-6e7f0c254acmr84097377b3.0.1729790486767;
        Thu, 24 Oct 2024 10:21:26 -0700 (PDT)
Received: from localhost (fwdproxy-nha-113.fbsv.net. [2a03:2880:25ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d0c9b3sm20452917b3.122.2024.10.24.10.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:21:26 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	kernel-team@meta.com
Subject: [PATCH v3 00/13] fuse: use folios instead of pages for requests
Date: Thu, 24 Oct 2024 10:17:56 -0700
Message-ID: <20241024171809.3142801-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset converts fuse requests to use folios instead of pages. Right
now, all folios in fuse are one page, but a subsequent patchset will be
enabling larger-size folios on fuse. This patchset has no functional
changes. Any multi-page allocations for requests (eg ioctl requests) will
also be optimized in a subsequent patchset as well.

v2:
https://lore.kernel.org/linux-fsdevel/20241022185443.1891563-1-joannelkoong@gmail.com/
Changes from v2 -> v3:
* Fix wrong variable use in fuse_retrieve, which was introduced in the v1 ->
  v2 variable name refactoring.

v1:
https://lore.kernel.org/linux-fsdevel/20241002165253.3872513-1-joannelkoong@gmail.com/
Changes from v1 -> v2:
* Address Josef's comments on v1
  - Clarify comment about folio replacement in page cache 
  - Remove unused fuse_page_descs_length_init() and fuse_pages_alloc()
  - Copy comment to folio_mark_dirty_lock()
* Add Josef's Reviewed-bys
* Refactor page_set_dirty_lock() to use folio_mark_dirty_lock()
* Keep using variable naming "nr_pages" in some places (eg fuse_direct_io)
  instead of "nr_folios" to make accounting more clear for max_pages, which
  reduce variable naming churn in subsequent patchset that supports large
folio.

Joanne Koong (13):
  fuse: support folios in struct fuse_args_pages and fuse_copy_pages()
  fuse: add support in virtio for requests using folios
  fuse: convert cuse to use folios
  fuse: convert readlink to use folios
  fuse: convert readdir to use folios
  fuse: convert reads to use folios
  fuse: convert writes (non-writeback) to use folios
  fuse: convert ioctls to use folios
  fuse: convert retrieves to use folios
  fuse: convert writebacks to use folios
  mm/writeback: add folio_mark_dirty_lock()
  fuse: convert direct io to use folios
  fuse: remove pages for requests and exclusively use folios

 fs/fuse/cuse.c      |  31 ++---
 fs/fuse/dev.c       |  41 ++++---
 fs/fuse/dir.c       |  28 ++---
 fs/fuse/file.c      | 268 +++++++++++++++++++++++---------------------
 fs/fuse/fuse_i.h    |  36 +++---
 fs/fuse/ioctl.c     |  31 +++--
 fs/fuse/readdir.c   |  20 ++--
 fs/fuse/virtio_fs.c |  58 +++++-----
 include/linux/mm.h  |   1 +
 mm/folio-compat.c   |   6 +
 mm/page-writeback.c |  22 ++--
 11 files changed, 291 insertions(+), 251 deletions(-)

-- 
2.43.5


