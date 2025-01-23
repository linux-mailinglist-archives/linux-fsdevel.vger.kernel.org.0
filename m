Return-Path: <linux-fsdevel+bounces-39889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A365BA19C30
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4E81887C1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DCE1C2BD;
	Thu, 23 Jan 2025 01:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChUPk2yU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD45A4A1D
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737595687; cv=none; b=U0/gz7VabGkL2uxZgM/A4ptQLBdfGwgaVrefGEf5QXcPjlKxaZT/yGzam8oGwIfNULMmVzoCzGGFqP16Qbnjo+EeSGWbg5vqzBz+VNeFXaSGWXtjHb33kaAwHGns5eLHrmIR3/xwE4dGOGnCxK3WELG1EC4mirqha+vVcctMFjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737595687; c=relaxed/simple;
	bh=/EvZmbqVD2b4ubFmLbs8qdT+8ZMGWUzWPisXDWRux44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W6//qgAtxYZFknQoDZJ20X0jY2c/lyBotU3I5rskGUAWagV7XbpZPbSA/ROUeU2rjAzUds7zNG1GQp6CJR1tCxfxLKmHJ4UodkK7Diss8BBp+yCWiEysRICFEq+tG97qbMJf8+dJdOPCAjVTpsTPqoNDLs1zunN0ZFb7zZ/DHZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChUPk2yU; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e3a0acba5feso559595276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2025 17:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737595685; x=1738200485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1SffMDP8hctL8iW83FGsySI3SG3kMmGukXzIy4Yw39A=;
        b=ChUPk2yUY69CGPvpFm2xlnJse9SXkyQf9Ybr1fYwlTa0HNZvKC+50go85oetjxI2Qb
         zCfLFtoafIcx680L0uKrv8FkDwXKdIbQ5GFGEnjZlN/y2aHY67z3qP5VXi/vh9Qi4uOu
         D/ozZfdYHkg4OrkTrkEPyINmbyrQDXiNzypbAmiFBDxM7rIlJEnOi9CDaj/QwEK+xyuu
         JQILev82OVwyrjioWXOXbSE4PkIO+oOG67h84P4+KcY3jXaPqNtCyiwrN2wtaoWvvhBC
         z89keCxyfHtDwIwArFim3Iko51kIk4oOBa9yhmEOX/i5Cgxmy5QgJqoSWImb1tbOgmnF
         mQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737595685; x=1738200485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1SffMDP8hctL8iW83FGsySI3SG3kMmGukXzIy4Yw39A=;
        b=rD1nsjpii1Zn7KwSlWeubtvXvI4Ruih9cK6pQsfmEu+ovP5zlhdxbkrr8RuiNTyYTD
         RXlhoAvsEHuWHisMwpfGOioi6NirI8FyZMCq5rwUf4aE7MdbJcBcl+H2nbSDiLp3LR9Z
         Elf5Ej/aVpnTzGn75uTaE2W0nfqMMqqMs1Xdl4No+n0cR5EeP/M2/YHbOZ1Cudh9QHlj
         iTpcdNnpA7JyINzKRNUEw4tzHYROGLwlTgaCGX0LpaH5sSWkn11846qh+YBNiRSDXASA
         VG3BSZVSsHGGUgsPg8Vsb+Wsto5dp5sDTkFOYfv3jz9hTB2+aOPWWGntXr0st5BkR/2S
         AogA==
X-Forwarded-Encrypted: i=1; AJvYcCVBBDs6/NwaUT5VJabQecM19LEu8mrsC8/CRTwgFIQm3PgHQEBkZ8ryumHT2AeQUQ3vBQ+6uqFB+2kJhwZh@vger.kernel.org
X-Gm-Message-State: AOJu0YzWkkDR52riqfaEdXQluZo72FT08+E7cWrT+NRs09JKbp7Dfytc
	YjRJZRnJUOhoX6snVSgHaMvqZ36Je9MHL4uXRpAPvqTeqd8Pvh9R
X-Gm-Gg: ASbGncssusFlZqn5rARCVNkFpFm7n3tlBvNwVAB2NxZZQM7+Xwug2e7pZ2Km5oE6Zuq
	76kEp0JZX5db8ObdjQ1gO5VVxsVf+jcyMZrDWD1nQU100nO4ULFlEg+vjZFwffuKdQqIyjtvuXo
	fj1F1ot+Q+m95IEwBwRxG3bqgHBe+LN5zsOzzoO0QQMeShe3tYLrWTIN9d3U4mfYdg6xXIBg8kV
	3werzXKSOn8mD9+QYKHs8tI/M5ooWlIY6wDf90L3i2Bo/YWBcs3CJcoU1TTv6A6WKKGQjA93+wh
	cg==
X-Google-Smtp-Source: AGHT+IHU4A7m6K5Rb9Ias/6XazTAm1cbT+vkHhflLkQv3xYGevH2aFRUn20xSwKvbpUQFBTMF6crvQ==
X-Received: by 2002:a05:690c:6a04:b0:6ef:4a1f:36b7 with SMTP id 00721157ae682-6f6eb908ed8mr181625447b3.25.1737595684709;
        Wed, 22 Jan 2025 17:28:04 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f6e63ab39bsm22319017b3.4.2025.01.22.17.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2025 17:28:04 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	willy@infradead.org,
	jefflexu@linux.alibaba.com,
	shakeel.butt@linux.dev,
	jlayton@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 00/10] fuse: support large folios
Date: Wed, 22 Jan 2025 17:24:38 -0800
Message-ID: <20250123012448.2479372-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support for folios larger than one page size in FUSE.
This does not yet enable large folios, as that requires one last piece, which
is for writeback to support large folios. Large folios for writeback will be
done separately in a future patchset. Please see this [1] for more details, as
well as benchmarks we can expect from enabling large folios.

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1a8fP7JQRWNhq7uvM=k=RbKrW+V9bOj1CQo=v4ZoNGQ3w@mail.gmail.com/ 

Changelog:
v3:
https://lore.kernel.org/linux-fsdevel/20241213221818.322371-1-joannelkoong@gmail.com/
v3 -> v4:
* Add Jeff's reviewed-bys
* Drop writeback large folios changes, drop turning large folios on. These
  will be part of a separate future patchset

v2:
https://lore.kernel.org/linux-fsdevel/20241125220537.3663725-1-joannelkoong@gmail.com/
v2 -> v3:
* Fix direct io parsing to check each extracted page instead of assuming all
  pages in a large folio will be used (Matthew)

v1:
https://lore.kernel.org/linux-fsdevel/20241109001258.2216604-1-joannelkoong@gmail.com/
v1 -> v2:
* Change naming from "non-writeback write" to "writethrough write"
* Fix deadlock for writethrough writes by calling fault_in_iov_iter_readable()
* first
  before __filemap_get_folio() (Josef)
* For readahead, retain original folio_size() for descs.length (Josef)
* Use folio_zero_range() api in fuse_copy_folio() (Josef)
* Add Josef's reviewed-bys

Joanne Koong (10):
  fuse: support copying large folios
  fuse: support large folios for retrieves
  fuse: refactor fuse_fill_write_pages()
  fuse: support large folios for writethrough writes
  fuse: support large folios for folio reads
  fuse: support large folios for symlinks
  fuse: support large folios for stores
  fuse: support large folios for queued writes
  fuse: support large folios for readahead
  fuse: optimize direct io large folios processing

 fs/fuse/dev.c        | 126 +++++++++++++++++++++--------------------
 fs/fuse/dir.c        |   8 +--
 fs/fuse/file.c       | 130 +++++++++++++++++++++++++++++--------------
 fs/fuse/fuse_dev_i.h |   2 +-
 4 files changed, 156 insertions(+), 110 deletions(-)

-- 
2.43.5


