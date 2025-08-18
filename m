Return-Path: <linux-fsdevel+bounces-58181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D5AB2AB3B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD7C7BE8C6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155CF35A2A5;
	Mon, 18 Aug 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obWx+LGW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652035A2B7;
	Mon, 18 Aug 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527992; cv=none; b=OGAXkFDNpqqbytZnO7uvRKV7o4Cy2T+1wyw/M/Qgd0HpCo0bmgI985A4jY9fQkzi39XTzz3Dt7vHd5BMppLOufl+fwavRZXQVp+ZI4XhE/T6hhGTf2sjUTFvIRV5QsELAvJi3iIQMPI8A8WW2buePNvi8QFdWF+dilNUSCoN2qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527992; c=relaxed/simple;
	bh=zKJgFcVQFDMZBGCycDUxRehszM9ewxhxe2/WnRjxhHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8aXvMge4EWY1gXNQBQuPk8pJ+woOzMyTcArHqAZDxwp7C6nF41EyNMVmffDIrbMnBPnvvKk4jhFUJ+9038MR+TZWgiXqLAQGpMSPcjtREC3NaQseapuGfE++Z49h+7X4Ru9v7m+3ogLVtvXbC2Ra+5svWyDyXruGJnuCMzKRMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obWx+LGW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D13CC4CEEB;
	Mon, 18 Aug 2025 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755527992;
	bh=zKJgFcVQFDMZBGCycDUxRehszM9ewxhxe2/WnRjxhHY=;
	h=From:To:Cc:Subject:Date:From;
	b=obWx+LGWforQQif+PTJvsjR9P7ptWmuGcyU6cBChj2Zrx5g2J5MTSWEhEPtdFWexh
	 CZda8zf/flmc3oulyTv9qLxmtTaAGjfcFLEB1apu6+m5sMz8YxI7Q3R/53KYJa+Gqr
	 jm2G2uSvhwHnuLKoU/zoYmD/Y8CSCXi47iRa+20NszrTDGRnjzagw9dvIRZN+k6Vk/
	 IK6c4XV/+H9UlXEqKNMYUzc61P7XQ/c0qbz9k/aa2aNviFnhHl97ebYv7VitEkoZo/
	 850mO0JKsMYH7FtuyvXf8+u5Uo0IXDP8OreFYVnTLPdFP8fk68dY0S8lJsBLU9h6qc
	 cLR95sBJAdKHA==
From: Trond Myklebust <trondmy@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v3 0/2] Initial NFS client support for RWF_DONTCACHE
Date: Mon, 18 Aug 2025 07:39:48 -0700
Message-ID: <cover.1755527537.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following patch set attempts to add support for the RWF_DONTCACHE
flag in preadv2() and pwritev2() on NFS filesystems.

The main issue is allowing support on 2 stage writes (i.e. unstable
WRITE followed by a COMMIT) since those don't follow the current
assumption that the 'dropbehind' flag can be fulfilled as soon as the
writeback lock is dropped.

v2:
 - Make use of the new iocb parameter for nfs_write_begin()
v3:
 - Set/clear PG_DROPBEHIND on the head of the nfs_page group
 - Simplify helper folio_end_dropbehind

Trond Myklebust (2):
  filemap: Add a helper for filesystems implementing dropbehind
  NFS: Enable the RWF_DONTCACHE flag for the NFS client

 fs/nfs/file.c            |  6 ++----
 fs/nfs/nfs4file.c        |  1 +
 fs/nfs/write.c           | 20 +++++++++++++++++---
 include/linux/nfs_page.h |  1 +
 include/linux/pagemap.h  |  1 +
 mm/filemap.c             | 11 +++++++++++
 6 files changed, 33 insertions(+), 7 deletions(-)

-- 
2.50.1


