Return-Path: <linux-fsdevel+bounces-36013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624779DAABB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 16:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C1B166C42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 15:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35421FF7D6;
	Wed, 27 Nov 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2FL051Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ACB1E51D
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 15:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721299; cv=none; b=W4GDPBPkTRh4M6IHHEPH+hnUmspJFuZdYsEtFnj9s1dx8nisxDCxWYAdgVTGjHTU4pD+yWED6QedCjj6490CurJtU8rnyysWfSZ9pi6hQxXyuMlYeajQPbE6XDjo5AFdkbY8RHCDWx+TautyCnEG5dcFHbZsOUwEj43g6nTaeLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721299; c=relaxed/simple;
	bh=vXhuu8rWP5D+ziEau8olQkqdACNIZwl52zw9hI088Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9nNBkpVAMgLDqkKPs5Rji7LIoNHdAylfxW8iyEBkI8byQl9N1z+D5oCqlfccKQB0g2XOBjnwH2v1w9mfQeBSxh647Q8MFFO89PxxyP99SqPa4EBdOrkuNoqOT+RlXu59O+JmYvI7HtwpPtJAzvogxDujQxld3mO6EBaPTIm/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2FL051Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BBEC4CECC;
	Wed, 27 Nov 2024 15:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732721298;
	bh=vXhuu8rWP5D+ziEau8olQkqdACNIZwl52zw9hI088Vc=;
	h=From:To:Cc:Subject:Date:From;
	b=Z2FL051YCIyRNmn27VcXND5Be/mAo5STigC1vMG9m02EQh4xkRM7QuvszoifZYSia
	 beMo/tzLVEvGtVbwp+YJQ9jNvooZu7pRvqfYvETf8Sj9S3jPI8s5JW0J50uWU/wavf
	 MidUt+hrJBk1GKJRDRcatricXEFQ/zaD54tD5waD+iZU2JmI7NmGRs0QtChnu9GdU8
	 Rmwrug/8aCE2UameeOEQf0p72t7dGvV9rDiejyzQehcFEd3pESoSFn1TiN+MuoHNR5
	 HZLZBfVHoVCprtg0E1GK/Ufi8qeof51OCekhY4FHgYIAuNccyvDD5JULpBhV8Oa0NH
	 iQb5MKTsWDnWg==
From: cel@kernel.org
To: Hugh Dickens <hughd@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>,
	<linux-mm@kvack.org>,
	yukuai3@huawei.com,
	yangerkun@huaweicloud.com,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH v3 0/5] Improve simple directory offset wrap behavior
Date: Wed, 27 Nov 2024 10:28:10 -0500
Message-ID: <20241127152815.151781-1-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The purpose of this series is construct a set of upstream fixes that
can be backported to v6.6 to address CVE-2024-46701.

The v3 series updates yesterday's v2. Some bugs and review comments
have been addressed, and the rationale for reverting 64a7ce76fb90
("libfs: fix infinite directory reads for offset dir") has been
clarified.

v3 passes xfstests except for generic/637.

The series has been pushed to:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=tmpfs-fixes

Chuck Lever (5):
  libfs: Return ENOSPC when the directory offset range is exhausted
  libfs: Remove unnecessary locking from simple_offset_empty()
  Revert "libfs: fix infinite directory reads for offset dir"
  libfs: Refactor end-of-directory detection for simple_offset
    directories
  libfs: Refactor offset_iterate_dir()

 fs/libfs.c | 145 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 107 insertions(+), 38 deletions(-)

-- 
2.47.0


