Return-Path: <linux-fsdevel+bounces-7610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF6F828756
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 14:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2218B23892
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 13:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFB438FAD;
	Tue,  9 Jan 2024 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCIkBZo5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5469238DD8
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 13:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B191C433C7;
	Tue,  9 Jan 2024 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704808018;
	bh=aQb0WI5noMVg+zgBFHge9L8wMvEq2R9bt6O2Quv6uYU=;
	h=From:To:Cc:Subject:Date:From;
	b=eCIkBZo50kqmRDZqvV8Q8u+CCUnq7wD5qOI+PPkw2iom14fNV2ARZN4u4gMpXkQC0
	 Elglz3VIhg+V6siQNtTBDze4pnBnoDhNv/hGTJnUDJdREVeVtKFuvdeoI9VR5nTsim
	 ENOTB3tnWijjqo38Qdcbl1wPooSZh/jorGjvs8Tkdk9VgMHe9HUY89Na3/HsVkTW8z
	 uURaWLNWmJpoKYVm98mB3Qs4/lj9ZJbA56C3tiguhI0c2b1P8OIDH1C2l48wWF8NQK
	 /9Nca1136IuzcqYdu+3jaeZpbAEBttYANUsZFpoKbez+Alt1NKBBX+mHn8NOH9Pt1R
	 /LM+WaZ5JPYaQ==
From: cem@kernel.org
To: jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH RFC 0/3] Enable tmpfs quotas 
Date: Tue,  9 Jan 2024 14:46:02 +0100
Message-ID: <20240109134651.869887-1-cem@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Carlos Maiolino <cem@kernel.org>

This series enable quota tools to manage tmpfs user/group quotas now the kernel
support is released in 6.6.

Honza, this is just a RFC as I'd like to know your input on the approach used
here.

This series add 2 new helpers, one named do_quotactl(), which switches between
quotactl() and quotactl_fd(), and the handle_quota() helper within quotaio,
which passes quota_handle data to do_quotactl() depending on the filesystem
associated with the mountpoint.

The first patch is just a cleanup.

So far I just did basic testing on this series, if you are fine with this
approach, I'll polish it and quote Lukas as he also worked on it and deserves
credit.

Thanks!

Carlos Maiolino (3):
  Rename searched_dir->sd_dir to sd_isdir
  Add quotactl_fd() support
  Enable support for tmpfs quotas

 Makefile.am       |  1 +
 mntopt.h          |  1 +
 quotacheck.c      | 12 +++----
 quotaio.c         | 19 +++++++++--
 quotaio.h         |  2 ++
 quotaio_generic.c | 11 +++----
 quotaio_meta.c    |  3 +-
 quotaio_v1.c      | 11 +++----
 quotaio_v2.c      | 11 +++----
 quotaio_xfs.c     | 21 ++++++------
 quotaon.c         |  8 ++---
 quotaon_xfs.c     |  9 +++---
 quotastats.c      |  4 +--
 quotasync.c       |  2 +-
 quotasys.c        | 81 ++++++++++++++++++++++++++++++++++++-----------
 quotasys.h        |  3 ++
 16 files changed, 133 insertions(+), 66 deletions(-)

-- 
2.43.0


