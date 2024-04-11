Return-Path: <linux-fsdevel+bounces-16733-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECB78A1EB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4231F26950
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 18:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE94235894;
	Thu, 11 Apr 2024 18:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fu/Zlg3i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579391E49F
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 18:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859977; cv=none; b=TFrLCp1OYVWaGsoxLccma+XCxsAevd9s5/G9MGt9JZNtms3JprDhrUNe4uJLoTZa15JpmsYX4FRN+Fra9l+dK7lofZn69aJUkvS9flt2UgBCoSNlw+CyjGkbm6bUZ74x9ziRxE5Y8YxV5gYqh8zmQKmVmJ6A/gqpMb537N8mRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859977; c=relaxed/simple;
	bh=80S9f4FfYMyyJyilMoAbttlICvu2TIHopfQhoc6IYog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pWFPLDu+/McuAGiBDoMTf9zd7vxYG9rOU/HZrBzACoBXoT6DbflMfHFOTRUykGMErkrQ4QPcWHet/rT/w7A3hxha28VQKQJ7GEVhZ0eNw+XyHXPjwm/KnrJxjLoq87uHr6NYWYq6EVXzts1bh0OIpP9l2oJpZ9YPh2ssBBYQ7To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fu/Zlg3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6BAC072AA;
	Thu, 11 Apr 2024 18:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712859976;
	bh=80S9f4FfYMyyJyilMoAbttlICvu2TIHopfQhoc6IYog=;
	h=From:To:Cc:Subject:Date:From;
	b=fu/Zlg3irAML7aJYOlOfP1hgtWtgmv0OStgm14zHg8NG+BXCnwm0c5EdOkRo9nXsD
	 4l4lJjIZxK6g1tQKxCrwd3GY4KQyrwncvuHVuogNhBvJLFxGzOfD/hDolxfr4Q0hUd
	 gYR3P7OBaiB4xZqptb0c+3q+HiJEuoJSVJ7SS35/g1NxdYgv4mQyqE1OGLf5al4Kl/
	 vP1RaiYMxy9Dn0+sVCtg34yDWjoILE9MPBn+8lu4X0z+BKn7hEQQcpp7dtAcR2OkCA
	 YfiB4aDLMK+YYigdAxMOuFkfCyXP96g9zam4eF2ZMZ4Aiq9nIcTJDOURtCqj0TQMx9
	 YaGh/aAnlHBgQ==
From: cel@kernel.org
To: Christian Brauner <brauner@kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 0/2] Fix shmem_rename2 directory offset calculation
Date: Thu, 11 Apr 2024 14:26:09 -0400
Message-ID: <20240411182611.203328-1-cel@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

The existing code in shmem_rename2() allocates a fresh directory
offset value when renaming over an existing destination entry. User
space does not expect this behavior. In particular, applications
that rename while walking a directory can loop indefinitely because
they never reach the end of the directory.

The first patch in this series corrects that problem, which exists
in v6.6 - current. The second patch is a clean-up and can be deferred
until v6.10.

Chuck Lever (2):
  shmem: Fix shmem_rename2()
  libfs: Clean up the simple_offset API

 fs/libfs.c         | 89 ++++++++++++++++++++++++++++++++++------------
 include/linux/fs.h | 10 +++---
 mm/shmem.c         | 17 +++++----
 3 files changed, 81 insertions(+), 35 deletions(-)

-- 
2.44.0


