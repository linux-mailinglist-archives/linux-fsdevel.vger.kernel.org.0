Return-Path: <linux-fsdevel+bounces-78451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIbTLIsPoGnbfQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:16:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E632E1A33CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 10:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2446F30AC4C7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0584339A80A;
	Thu, 26 Feb 2026 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sx06D2iU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F19303A0A
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772097166; cv=none; b=NFpzcRpCEi+trxsYtr89tAAMzU+3cvJ5BH7kUOaNnXD3Ydm62S8BLaW2yC6OHW29dN5Ec4IeHtkPL5aiWIHGaRhzfN/ru8CA+w7vWzSfsTRrvJmjiqGMTtL7EvFZZMhBJ6GxG7yyrcUZ/F09F7Ida3TiX3yhY4oBsyCKMxK3AZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772097166; c=relaxed/simple;
	bh=P9zHJf9hw6gJ90Fg9rBaSKXTKmeOIQaBE4keCcx0Khk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lWx/DGi7CRxIoaBnYJvrY52HvWZFxfxlpX031Wbqr6wxYZcvBC4uugavRWRcGnBCkaxIHP7ZZLhol1dr1PYNMaXG/0QpJQl1ZZteFgmL3zAepe55Ou1cnkX0b64tyS+mTBA3jH7mDxiBtTxERXFlx+xrOIJ1pfgx4xeoaL8uj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sx06D2iU; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82728e5680cso374596b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 01:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772097164; x=1772701964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d3xiZQpdXnuPlqMuEGUu9XiIu4NW4DeVOIeIkTCMbGI=;
        b=Sx06D2iUirtyCFzxIKFsyigU+GsTN8t3kP15926+TfyLnC/jNqRvu9wmSxRgklnWqH
         E1KwCmjo/Jh6CZZWxsPapmeIw3esmFOW3kKS+laPIquTpivrVbwFk8+BugnoXz9i4U2C
         sFa8/SDkC45R5Gd1e8XBK4hA/BbzoRmCP3ndoyhKPJ5j6gnqQ4xf6+5QtMgpRCdowLxM
         Sj/2ABfUI8I3a225T1F8zj7RpiCffkSUEGOdLL222aW7Ikb3IkuBM1HbnZk8zgPHIwEH
         Yx8HPKWot/rwjmSS4IFCDSi47jSLbuYsJnkAS5+KCE6HdgQ+70Z20WmenwE98ypZHBIT
         DX5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772097164; x=1772701964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3xiZQpdXnuPlqMuEGUu9XiIu4NW4DeVOIeIkTCMbGI=;
        b=HtOSd0SCEs0KryXfoowYwDwdwHc6LFj9BCvbeQyiZIOYyNlR+++36y27245YUjvrUO
         hukyXPPxQtpNR5FkyLrR0B7W3BDo06wfOkfTPtV/k2S/uxl1VarGmMY/wjzfnvf+vNRz
         PxslUUq8v57GyZwc55dTUSZ5gQ3SGI+yQOCunXCsIBEfVaRqFX/57m/jtvgfaZWDcv+9
         6cOc42XobQRxpGiUC/ru/9LAL55bO+JykmoRETkDjTAJC0kEQKEvsl/lwN6/sHZiSw6o
         SWagSCC+eqx7keFQgZyUJQTKbSts4eVIlPZ0fKSQfzBzkavpgm6EvT73yay4aY5YNbUD
         Ttdw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ1e5U8MzDavXyLFVLE62qya+1O8siKwLvYU3Jz4qlwf/yOiRIDDptGF/9CyFGCcd3UX74aOK1Xdtp+Y2n@vger.kernel.org
X-Gm-Message-State: AOJu0YyTkIycR4nvSbW7nBc3G8cA2IwOalxDEHZrwejhervjOpWMW6Is
	UDIXYbn7ugzDu9lPc744cYRUVZNZdKgH66KBc5vmGRXxZcXgt4U+DF/h
X-Gm-Gg: ATEYQzw0zBw2MAdpzEAcxBMlxp5qUj+sIclJfbGuN1h76HfoWRyPvnkqUaghfu6VZnx
	R9GF9knl5YfSiisaPXQqw5u4I7vMEnnHDQH5OOdzFSminCAEeuVxDn+M9fz03M325ZIRu/hX79f
	Mvm8u7a3XV3AqoMbUDMFOQHWwWzJXZKAaz+P/+lVvP62SHstx08Rp99LSADt30mUQEUQSygGwGW
	+2wnUnL+Sjndg4E8plgKkk7tz+jk+Q7XylQ8PzNil4VO2T72VxTA/C6LAB3IC4YvpWFQcy7CqGp
	uyS3eSjo3fHW7jBL/Wq5ZnA5Pqn1q/I3aYbUrWA85lXRmzDCCZ3sgemuWyFusKdK0513t7ON6uE
	BnysaGworfGBrYBxzJuIlJ4X97YBR212ai9sYppI7kKw1MXbznLkU8QaIyrcUKHndWIOM5VSrWm
	7eWxrRmJSpv+BnZ+ieZUtLxeQCGKOna0LA4TI1sk8FWQGgT5A=
X-Received: by 2002:a05:6a21:6e04:b0:366:14af:9bbb with SMTP id adf61e73a8af0-39545fe2f9amr17549760637.69.1772097163597;
        Thu, 26 Feb 2026 01:12:43 -0800 (PST)
Received: from localhost.localdomain ([223.185.37.137])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5e4aafsm1457484a12.4.2026.02.26.01.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 01:12:43 -0800 (PST)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: janak@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v4 0/2] hfsplus: validate btree bitmap during mount and handle corruption gracefully
Date: Thu, 26 Feb 2026 14:42:33 +0530
Message-Id: <20260226091235.927749-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78451-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[mpiricsoftware.com,mpiric.us,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[shardulsb08@gmail.com,linux-fsdevel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E632E1A33CA
X-Rspamd-Action: no action

Hi,

syzbot reported an issue with corrupted HFS+ images where the b-tree
allocation bitmap indicates that the header node (Node 0) is free. Node 0
must always be allocated as it contains the b-tree header record and the
allocation bitmap itself. Violating this invariant leads to allocator
corruption, which cascades into kernel panics when the filesystem
attempts to allocate blocks.

This series prevents the kernel from trusting a corrupted state by
validating the Node 0 bitmap at mount time, allowing the filesystem to
safely fall back to read-only mode for data recovery.

Patch 1 is a preparatory cleanup. It extracts the map-record traversal
logic from hfs_bmap_alloc() into a generic helper. This deduplicates
the code, introduces strict node-type validation to prevent misinterpreting
corrupted nodes, and provides the abstraction needed for the mount-time check.

Patch 2 implements the actual Syzkaller fix. It uses the new helper during
hfs_btree_open() to verify that Node 0 is marked allocated. If it isn't, or
if the map record itself is structurally invalid, it forces the superblock
to SB_RDONLY.

Link: https://lore.kernel.org/all/54dc9336b514fb10547e27c7d6e1b8b967ee2eda.camel@ibm.com/

v4:
 - Split the changes into a 2-patch series (Refactoring + Bug Fix).
 - Extracted map node traversal into a generic helper (hfs_bmap_get_map_page)
   as per Slava's feedback, replacing manual offset/page management.
 - Added node-type validation (HFS_NODE_HEADER vs HFS_NODE_MAP) inside the
   helper to defend against structurally corrupted linkages.
 - Replaced hardcoded values with named macros (HFSPLUS_BTREE_NODE0_BIT, etc).
 - Handled invalid map offsets/lengths as corruption, continuing the mount
   as SB_RDONLY instead of failing it completely to preserve data recovery.

v3:
  - Moved validation logic inline into hfs_btree_open() to allow
    reporting the specific corrupted tree ID.
  - Replaced custom offset calculations with existing hfs_bnode_find()
    and hfs_brec_lenoff() infrastructure to handle node sizes and
    page boundaries correctly.
  - Removed temporary 'btree_bitmap_corrupted' superblock flag; setup
    SB_RDONLY directly upon detection.
  - Moved logging to hfs_btree_open() to include the specific tree ID in
    the warning message
  - Used explicit bitwise check (&) instead of test_bit() to ensure
    portability. test_bit() bit-numbering is architecture-dependent
    (e.g., bit 0 vs bit 7 can swap meanings on BE vs LE), whereas
    masking 0x80 consistently targets the MSB required by the HFS+
    on-disk format.
v2:
  - Fix compiler warning about comparing u16 bitmap_off with PAGE_SIZE which
can exceed u16 maximum on some architectures
  - Cast bitmap_off to unsigned int for the PAGE_SIZE comparison to avoid
tautological constant-out-of-range comparison warning.
  - Link: https://lore.kernel.org/oe-kbuild-all/202601251011.kJUhBF3P-lkp@intel.com/

Shardul Bankar (2):
  hfsplus: refactor b-tree map page access and add node-type validation
  hfsplus: validate b-tree node 0 bitmap at mount time

 fs/hfsplus/btree.c         | 123 ++++++++++++++++++++++++++++++-------
 include/linux/hfs_common.h |   3 +
 2 files changed, 104 insertions(+), 22 deletions(-)

-- 
2.34.1


