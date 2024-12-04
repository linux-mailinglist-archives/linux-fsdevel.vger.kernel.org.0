Return-Path: <linux-fsdevel+bounces-36481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58819E3F61
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 17:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01D74B344F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6BB20CCCD;
	Wed,  4 Dec 2024 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYwsUeQK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC84B20CCC7
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327582; cv=none; b=iVUxiDyCUYw9X0mGR3RfSHFHwPxDY0PW3Pz+zGPxpv3Fu5GfkH9twuIIzk/qK/Zznhub0MyE1h3VofDNCe4W05x4VnDGcU9BO1Pj6CaGRAiJgl7MZCX/aTWNAush3uGrWIxcgKnC5uRHzV5q/+hEsNcunjwGSiymHJ91lAh69Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327582; c=relaxed/simple;
	bh=ZU7Nssg8iB+meP4HAiNWJezwZvfDo+ne6ZypdoYaqwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f3/U6l8dsE37C29caFSpNymGx2wdghjTleLAgqOLK/F7U7UZ40hEILn9AVGKDoGa7wOkgOc6E52nK70jeWH1cIsDUhmEt8LKtKEESBpwBPZSvEx6B1K3BjRXO7LtTwCnQz4g0ko/1bpFSOwCEt6TajJ+uTvyF2MIAz1p31GDjOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYwsUeQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28C0C4CECD;
	Wed,  4 Dec 2024 15:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733327582;
	bh=ZU7Nssg8iB+meP4HAiNWJezwZvfDo+ne6ZypdoYaqwg=;
	h=From:To:Cc:Subject:Date:From;
	b=DYwsUeQKxcLpZgO0celx1C91UYQa0hbIMraV873fjVYDcaBJ3JsHbJY73O1NjAYIm
	 IUxCmqsP36TjLZHRPbgWcdrH6P+/SgrnzzmqRaD8ikbhHlvMHnOn4M7C9lqAexDdDf
	 9gUl01TeHOdyBgyADPbuC7Lb8iS+N9PNwpO8m96lAHLQvTJCGOiJhCXu6rBHXzI00p
	 15NKAS/+/PYdiaL163BFqueuwouNLMlDXVtVGDhq9I24dkYtE1AuUYas4dP792DWWy
	 98fH9cObdpy51zG7VPK78Rgzgfo5yh7NFQd55wM17o977cHP107ckeVVSWHLLWEQqb
	 TS28UD4x2guqg==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 0/5] Improve simple directory offset wrap behavior
Date: Wed,  4 Dec 2024 10:52:51 -0500
Message-ID: <20241204155257.1110338-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The purpose of this series is to construct a set of upstream fixes
that can be backported to v6.6 to address CVE-2024-46701.

My original plan was to add a cursor dentry. However, I've found a
solution that does not need one. In fact, most or all of the
reported issues are gone with 4/5. Thus I'm not sure 5/5 is
necessary, but it seems like a robust improvement.

Changes since v3:
- Series is no longer RFC
- Series passes xfstests locally and via NFS export
- Patch 2/5 was replaced; it now removes simple_offset_empty()
- 4/5 and 5/5 were rewritten based on test results
- Patch descriptions have been clarified

This series (still against v6.12) has been pushed to:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=tmpfs-fixes

Next step is to try backporting these to v6.6 to see if anything
else is needed.

Chuck Lever (5):
  libfs: Return ENOSPC when the directory offset range is exhausted
  Revert "libfs: Add simple_offset_empty()"
  Revert "libfs: fix infinite directory reads for offset dir"
  libfs: Replace simple_offset end-of-directory detection
  libfs: Use d_children list to iterate simple_offset directories

 fs/libfs.c         | 158 ++++++++++++++++++++++-----------------------
 include/linux/fs.h |   1 -
 mm/shmem.c         |   4 +-
 3 files changed, 81 insertions(+), 82 deletions(-)

-- 
2.47.0


