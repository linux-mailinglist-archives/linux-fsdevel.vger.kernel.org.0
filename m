Return-Path: <linux-fsdevel+bounces-60724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 531A8B50A8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 03:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB261B20B81
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 01:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E482253FC;
	Wed, 10 Sep 2025 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOvBDMUm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C1F2033A
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 01:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757469226; cv=none; b=QTj/zMM4gl9kzPdzLvSBrcG/+E/UuZ0tpQpQ7g0wuV54UHqPwzaLmae8NlheBfH9TiO4s3eRUyvhwnFZY/M7qGdyTg12LFx6/sREattLNTWai1pLO2PReSJJFFH8h65Jfg4EpU32by1o0npqz8Cm/fQx8Qzq046n/lptz8AgmXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757469226; c=relaxed/simple;
	bh=56bS2ap0hJvXbN/99ydP9OC4SqQB/mSQtppLSgmKJc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o3ewUxahBcOXb7W7VlhqGRhPdWk0A8vruDdl8w4nSH25PPUzhZwMxK12+Qczk5I88CYnrXEbl7V0AHub3El6CXWBAJWkT3XKycMlgtJLNOIZi/oEqtvNI5i5pspHJpOlq2mgkVDSVC7Gtcae9VNyYpE9Va4RTy8Ohjfu/k6GTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOvBDMUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8BFC4CEF4;
	Wed, 10 Sep 2025 01:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757469226;
	bh=56bS2ap0hJvXbN/99ydP9OC4SqQB/mSQtppLSgmKJc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOvBDMUm1PlZZvHn9uAcpe7U1Tw9LEy7uQ1LlFu9/EY4tP0VzCRKGrrFziva0rjbx
	 aERK/g/ejJTr7TA7ik3vO0jtvs8i2hlBqAdFr3aG2vkcvkKZabQGZNRU8Fw4vlf+sK
	 QtUKjzoHWo1TD4+sLtCwqwpRXRr6hFX98H0mCIYoAsHahVdHHwvK7uAmnWtRqknWWD
	 mz/vPJKtJlG/c4WTZoo8hjlKl1pTeXwRp4rArGRyjlovDusQ6SWUya5aAgEdJH/CnV
	 g5juBCfQTdpwhNUuFkhNSKtrzk9NXmHpcbpDN1phJ4/Jwww/Gi7+kxIFn+txxuSEzi
	 pWRIrVq8F5s/g==
From: Trond Myklebust <trondmy@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Anna Schumaker <anna@kernel.org>
Subject: [PATCH v5 0/3] Initial NFS client support for RWF_DONTCACHE
Date: Tue,  9 Sep 2025 21:53:41 -0400
Message-ID: <cover.1757177140.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1755612705.git.trond.myklebust@hammerspace.com>
References: <cover.1755612705.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The main issue is allowing support on 2 stage writes (i.e. unstable
WRITE followed by a COMMIT) since those don't follow the current
assumption that the 'dropbehind' flag can be fulfilled as soon as the
writeback lock is dropped.

v2:
 - Make use of the new iocb parameter for nfs_write_begin()
v3:
 - Set/clear PG_DROPBEHIND on the head of the nfs_page group
 - Simplify helper folio_end_dropbehind
v4:
 - Replace filemap_end_dropbehind_write() with folio_end_dropbehind()
 - Add a helper to replace folio_end_writeback with an equivalent that
   does not attempt to interpret the dropbehind flag
 - Keep the folio dropbehind flag set until the NFS client is ready to
   call folio_end_dropbehind.
 - Don't try to do a read-modify-write in nfs_write_begin() if the folio
   has the dropbehind flag set.
v5:
 - Change helper function export types to EXPORT_SYMBOL_GPL

Trond Myklebust (3):
  filemap: Add a helper for filesystems implementing dropbehind
  filemap: Add a version of folio_end_writeback that ignores dropbehind
  NFS: Enable use of the RWF_DONTCACHE flag on the NFS client

 fs/nfs/file.c           |  9 +++++----
 fs/nfs/nfs4file.c       |  1 +
 fs/nfs/write.c          |  4 +++-
 include/linux/pagemap.h |  2 ++
 mm/filemap.c            | 34 ++++++++++++++++++++++++++--------
 5 files changed, 37 insertions(+), 13 deletions(-)

-- 
2.51.0


