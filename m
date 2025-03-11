Return-Path: <linux-fsdevel+bounces-43738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B063A5D09D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 21:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 858427AB862
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 20:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423A7264A62;
	Tue, 11 Mar 2025 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lexv+R5U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D96264638;
	Tue, 11 Mar 2025 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741724133; cv=none; b=tJqvI4KGVIWxqUeQ0/qHYLAjbGerLX7GZkql5VbNEsmFnUHEAXXnsHCd1CJvTalXGNynYppHqs+yqh/gB+a/+SOxukkzVeOp1LAfT4pnIMNxeeSE0x3J33kExVh46gMJGixjll3ZQ4Ne7pF9wQnt76yul6fJr2S21CO8XFI4y7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741724133; c=relaxed/simple;
	bh=9kxzyQ7WNcc0CNS9HuQkrJLgzQDtU3H0tehHlZkAuQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgPhJF9G9p4acxufDLcZHe+DoakN93ITbgeoeImwi2evE6QqEFFI4si1VpFHV8ip1GFGS7bjJBLMd7ot6fZeClwARS7uPVlXRyq35IxzJWSQwfkZwXvpwEePzBmEjGJaHefh9xq4UuUc0Z0ba6mEpDH0cPF11XNj7cknbJffOxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lexv+R5U; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741724127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3Nrgdr9y7mpusjQj2TskrwXHx7MXt9LTGAJ46g3dBsk=;
	b=lexv+R5UkC6Gdc/rM2MhzVrOX0b7jFwG2Gs7ANgePxvEb3dnpD8tbo9HEZ838jutsadf15
	e9mKk7m36SB583Lwj8EvEiYJkxM/J9uLJ09luz1SzyFoXiO4nNW8qTN2/MQ+nUE6RKXvql
	2bDXkIbLz6N5mU8qa5Iuof7iW74FziI=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-bcachefs@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Roland Vet <vet.roland@protonmail.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 00/14] better handling of checksum errors/bitrot
Date: Tue, 11 Mar 2025 16:15:02 -0400
Message-ID: <20250311201518.3573009-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Roland Vet spotted a good one: currently, rebalance/copygc get stuck if
we've got an extent that can't be read, due to checksum error/bitrot.

This took some doing to fix properly, because

- We don't want to just delete such data (replace it with
  KEY_TYPE_error); we never want to delete anything except when
  explicitly told to by the user, and while we don't yet have an API for
  "read this file even though there's errors, just give me what you
  have" we definitely will in the future.

- Not being able to move data is a non-option: that would block copygc,
  device removal, etc.

- And, moving said extent requires giving it a new checksum - strictly
  required if the move has to fragment it, teaching the write/move path
  about extents with bad checksums is unpalateable, and anyways we'd
  like to be able to guard against more bitrot, if we can.

So that means:

- Extents need a poison bit: "reads return errors, even though it now
  has a good checksum" - this was added in a separate patch queued up
  for 6.15.

  It's an incompat feature because it's a new extent field, and old
  versions can't parse extents with unknown field types, since they
  won't know their sizes - meaning users will have to explicitly do an
  incompat upgrade to make use of this stuff.

- The read path needs to do additional retries after checksum errors
  before giving up and marking it poisoned, so that we don't
  accidentally convert a transient error to permanent corruption.

- The read path gets a whole bunch of work to plumb precise modern error
  codes around, so that e.g. the retry path, the data move path, and the
  "mark extent poisoned" path all know exactly what's going on.

- Read path is responsible for marking extents poisoned after sufficient
  retry attempts (controlled by a new filesystem option)

- Data move path is allowed to move extents after a read error, if it's
  a checksum error (giving it a new checksum) if it's been poisoned
  (i.e. the extent flags feature is enabled).

Code should be more or less finalized - still have more tests for corner
cases to write, but "write corrupt data and then tell rebalance to move
it to another device" works as expected.

TODO:

- NVME has a "read recovery level" attribute that controlls how hard the
  erasure coding algorithms work - we want that plumbed.

  Before we give up and move data that we know is bad, we need to try
  _as hard as possible_ to get a successful read.

Code currently lives in
https://evilpiepirate.org/git/bcachefs.git/log/?h=bcachefs-testing

Kent Overstreet (14):
  bcachefs: Convert read path to standard error codes
  bcachefs: Fix BCH_ERR_data_read_csum_err_maybe_userspace in retry path
  bcachefs: Read error message now indicates if it was for an internal
    move
  bcachefs: BCH_ERR_data_read_buffer_too_small
  bcachefs: Return errors to top level bch2_rbio_retry()
  bcachefs: Print message on successful read retry
  bcachefs: Don't create bch_io_failures unless it's needed
  bcachefs: Checksum errors get additional retries
  bcachefs: __bch2_read() now takes a btree_trans
  bcachefs: Poison extents that can't be read due to checksum errors
  bcachefs: Data move can read from poisoned extents
  bcachefs: Debug params for data corruption injection
  block: Allow REQ_FUA|REQ_READ
  bcachefs: Read retries are after checksum errors now REQ_FUA

 block/blk-core.c              |  19 +-
 fs/bcachefs/bcachefs_format.h |   2 +
 fs/bcachefs/btree_io.c        |   2 +-
 fs/bcachefs/errcode.h         |  19 +-
 fs/bcachefs/extents.c         | 157 +++++++++-------
 fs/bcachefs/extents.h         |   7 +-
 fs/bcachefs/extents_types.h   |  11 +-
 fs/bcachefs/io_read.c         | 325 +++++++++++++++++++++++++---------
 fs/bcachefs/io_read.h         |  21 +--
 fs/bcachefs/io_write.c        |  24 +++
 fs/bcachefs/move.c            |  26 ++-
 fs/bcachefs/opts.h            |   5 +
 fs/bcachefs/super-io.c        |   4 +
 fs/bcachefs/util.c            |  21 +++
 fs/bcachefs/util.h            |  12 ++
 15 files changed, 473 insertions(+), 182 deletions(-)

-- 
2.47.2


