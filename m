Return-Path: <linux-fsdevel+bounces-47023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C86A97DC7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 06:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51FCF3BF8A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 04:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E08265CB0;
	Wed, 23 Apr 2025 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnC03gvi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7AF265612;
	Wed, 23 Apr 2025 04:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745382336; cv=none; b=T0PljuT9AsfemQXk3tl+d40zQcnxgJeBv4pkm2DsC2Bwz/OMFC+iIOy1JUmIrHpRi0hbGKfe84x4R7vVO4MHMzzXfsDoBy3EYMi33++2gL1LJ7OaQHbz3SLvMvDvfkFsQoqYozTAJHNQ6znlRqxyQcNPYeCfZg6byOdS9tp4nn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745382336; c=relaxed/simple;
	bh=7t+va58EdjenVOrQKiKXrAkZ8pnQuUBAFK8eTG4zRY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivPmVJFF1vSqDfqcb94F3LaQSqgp2EkZUHZDuFLz1CS91TANbL33GYuOMP8/8Ac9/Y4qd1jLzWKhn/kWq73L0KhbyEZZKwkaVGrcOiHlh00TBRXGS2q3CLkpVJLf+DM9InGjAlysBPWsy7ZwzhmZ8UNElpuFIrsTr9jS20vjExw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnC03gvi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E280CC4CEE2;
	Wed, 23 Apr 2025 04:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745382334;
	bh=7t+va58EdjenVOrQKiKXrAkZ8pnQuUBAFK8eTG4zRY0=;
	h=From:To:Cc:Subject:Date:From;
	b=PnC03gviZfaLlVUArj/wcbvlugcLaQNIYcOZpQxGgsc95Y/NM9fL1fAeEDJz41GQb
	 CPE3cpPbVv741IacZWWwZH8FrEDpszCtUNd0+Xhb4tMih2SkWK3fpbGfayCuLNL816
	 ZghuDURYjnHeLjXvoEBjE4hrsinGjvodaL3tgu0WH2AKs8ucInKuQDltbOZx0buWbf
	 fuULENg9mmagq/z2zDp2jb5tkC3Jix1egEJ/DIKEQ5OrBDnsynQcpHSouYe23OW9vp
	 QbRZe6bP9qvyKkP/3cjg29mRb0mG8jKPq42g+YJmGEztZ6LgSkqwgLh+qyn+yDqGVr
	 /bAwTEgx5yYzg==
From: trondmy@kernel.org
To: linux-nfs@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 0/3] Initial NFS client support for RWF_DONTCACHE
Date: Wed, 23 Apr 2025 00:25:29 -0400
Message-ID: <cover.1745381692.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.49.0
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

Trond Myklebust (3):
  filemap: Add a helper for filesystems implementing dropbehind
  filemap: Mark folios as dropbehind in generic_perform_write()
  NFS: Enable the RWF_DONTCACHE flag for the NFS client

 fs/nfs/file.c            |  2 ++
 fs/nfs/nfs4file.c        |  2 ++
 fs/nfs/write.c           | 12 +++++++++++-
 include/linux/nfs_page.h |  1 +
 include/linux/pagemap.h  |  1 +
 mm/filemap.c             | 21 +++++++++++++++++++++
 6 files changed, 38 insertions(+), 1 deletion(-)

-- 
2.49.0


