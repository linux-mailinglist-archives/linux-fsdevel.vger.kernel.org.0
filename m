Return-Path: <linux-fsdevel+bounces-57585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B72FB23AD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 23:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710B7580305
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970FE2D6E49;
	Tue, 12 Aug 2025 21:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpCrMc1J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058C7081F;
	Tue, 12 Aug 2025 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755034815; cv=none; b=USm4Z9oToRf5NfSswgQoWSfI8Dgl+2PZ5E+GUTb0J3PBl686KNlq/mpcRTX1+2p39MKydAA3wOnNTeLyZGZ157Hv4szUhjDG4VauSEr77tjRJKCxF9sIx/jiE2dKQEP3gc84LrVyc991FaHsJeJ31z0OK1eyGFGrGLfOfMB2lEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755034815; c=relaxed/simple;
	bh=3YwlQnJDsBpYv33OodhCrSrkKD5WqZPDu5PY99TU3n4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h3+rjMdqpKi0iahNqzCXp6sLy22TRWXdJmIsjXLwL2IBwdDI4Mfk6mn5PGrevNlUeST2UyugTBD5OYPKk7F5ci0Hb9Ugu3fQmrou3ONwtr9v7aqJUcFnqRo6ooVqcGnJu0f4yDa7OCnYlKSs1cFTbic1Egm0plgDnwbRBTnNSAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpCrMc1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F72C4CEF0;
	Tue, 12 Aug 2025 21:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755034814;
	bh=3YwlQnJDsBpYv33OodhCrSrkKD5WqZPDu5PY99TU3n4=;
	h=From:To:Cc:Subject:Date:From;
	b=CpCrMc1JMusph0aAsMpyTGFflmAA2O7aNGRwaRqlFzBiDQMowehqPn6V10Pj89iTh
	 BFv1WuGLAcgDAVymKMuNefXDuPPHUhpCm5TJh/pN4BMHOAlFjH8ihgfGla6ZGOaGH9
	 6kIGmwGL9Ovd497j4YTDhMzycx7cnQNh7iG97nXNM20nDq/icIjtmOPlS78MyL+0IL
	 oz2cgjmSVUNMwgAe2x2tjmDvJmcwecgJ8tEtQQuW4xh36hK/d17HP2fWVV5Aw+gG65
	 j2xRTVXSUbSMBw7z/6GPzKw3azVE7pgXcK9vFOJMYPjv7sKvoACmmtAYeMF5+48Feh
	 rGa9F6OFhq3Rw==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH v2 0/2] Initial NFS client support for RWF_DONTCACHE
Date: Tue, 12 Aug 2025 14:40:05 -0700
Message-ID: <cover.1755034536.git.trond.myklebust@hammerspace.com>
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

Trond Myklebust (2):
  filemap: Add a helper for filesystems implementing dropbehind
  NFS: Enable the RWF_DONTCACHE flag for the NFS client

 fs/nfs/file.c            |  7 +++----
 fs/nfs/nfs4file.c        |  2 ++
 fs/nfs/write.c           | 12 +++++++++++-
 include/linux/nfs_page.h |  1 +
 include/linux/pagemap.h  |  1 +
 mm/filemap.c             | 16 ++++++++++++++++
 6 files changed, 34 insertions(+), 5 deletions(-)

-- 
2.50.1


