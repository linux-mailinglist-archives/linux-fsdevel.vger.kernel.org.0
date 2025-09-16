Return-Path: <linux-fsdevel+bounces-61735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F298BB59841
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 15:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865064E4C6D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 13:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7C732779D;
	Tue, 16 Sep 2025 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MQQx/Q1b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFA331DDBC;
	Tue, 16 Sep 2025 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030813; cv=none; b=txv0W5ocvBQRWZgXtvBT61ZBTR3Aew1NKN2KKXcL5JoVKBBzNywE2Cbo3nKf53J0GFCDLd38Ab2gOrDuRQ2F8I0GYnjL9E5k3CmJP7bBEmJemZgXLGm9hNenAr4c5OMCN/57bCgPV5h/fyjB7BtBu50RO2+W0arqjnJ3n/Jj818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030813; c=relaxed/simple;
	bh=trezP0UU3b59VsavJ8DxZlX4bgvjLNK6GY622X7Ce3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F8r9FuhuQ9HxJ8U7fTXwVXZnpJyuaigcdbrnxUy2dDnSsOYOcIzu8pIEQ8Ue9w7IKbxnxqi++FtQqU4TZwTACFndb6dZxc0KZ7sfdEtaYx1dBoe81twB1GsI82C8I5ldJWDUern2CIf4Y3fI9wKACzN0Xqjh1odsiH7D+e7XIcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MQQx/Q1b; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=dRivKGbqX8Ck0pSd7S8JXZq2IVPS9OaLEtzmhjUJT88=; b=MQQx/Q1bmmN9lDTg72QqGmUgf5
	jdmcXRocuBnGJsB6+VedkkrIxduRSzKDKiSmUjbfgnxsEMK5nIV+YcZjLy+IYk4GA776PWk9JF6yO
	V2NfQRsEuVX+ea3eRnUgvdyuDlp49EUp6t/aGeo0U+CPbYCwTpc3TCFnfvveLUumgzescXMu7BxN4
	FSB24Yd0LRU3WbaJLhRcI7hyu3n2ldlu2wAvg114qV4e9yQ1veoLHceLn6uDauCgOMe+hnz9Rj4ns
	pasRayXPUYrRhyshFfhKOBBWtoww/Dw44QQRXknlhVpSNbwivtDUUc0jdcQTzX6IbZ8w6ZMFQ5E6Q
	L8OKQBhA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyW7R-00CH0m-Mj; Tue, 16 Sep 2025 15:53:17 +0200
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd@bsbernd.com>,
	Laura Promberger <laura.promberger@cern.ch>,
	Dave Chinner <david@fromorbit.com>,
	Matt Harvey <mharvey@jumptrading.com>,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Luis Henriques <luis@igalia.com>
Subject: [RFC PATCH v6 0/4] fuse: work queues to invalided dentries
Date: Tue, 16 Sep 2025 14:53:06 +0100
Message-ID: <20250916135310.51177-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Miklos,

Here's a new version of the patchset to invalidate expired dentries.  Most
of the changes (and there are a lot of them!) result from the v5 review.
See below for details.

Changes since v5:

- Changes to dcache: export shrink_dentry_list() and add new helper
  d_dispose_if_unused()
- Reduced hash lock array size
- Set 'inval_wq' max value to USHRT_MAX to prevent a potential overflow in
  secs_to_jiffies()
- Updated 'inval_wq' parameter description and comment
- Removed useless check in fuse_dentry_tree_del_node()
- Make fuse_dentry_tree_work() use dcache helpers d_dispose_if_unused() and
  shrink_dentry_list()
- Fix usage of need_resched() (replaced with cond_resched())
- fuse_dentry_tree_cleanup() now simply does a WARN_ON() if there are
  non-empty trees
- Removed TODO comment in fuse_conn_destroy() -- no need to prune trees
- Have fuse_epoch_work() use of shrink_dcache_sb() instead of going through
  all the trees
- Refactor fuse_conn_put() in a separate patch
- Fix bug in fuse_dentry_tree_add_node() for cases where dentries have the
  same timeout
- Reword some of the commits text

Changes since v4:
 
- Dropped extra check in fuse_dentry_tree_add_node() (Chunsheng)
- Make the dentries trees global instead of per fuse_conn (Miklos)
- Protect trees with hashed locking instead of a single lock (Miklos)
- Added new work queue (2nd patch) specifically to handle epoch (Miklos)
 
Changes since v3:
 
- Use of need_resched() instead of limiting the work queue to run for 5
  seconds
- Restore usage of union with rcu_head, in struct fuse_dentry
- Minor changes in comments (e.g. s/workqueue/work queue/)
 
Changes since v2:
 
- Major rework, the dentries tree nodes are now in fuse_dentry and they are
  tied to the actual dentry lifetime
- Mount option is now a module parameter
- workqueue now runs for at most 5 seconds before rescheduling

Luis Henriques (4):
  dcache: export shrink_dentry_list() and new helper
    d_dispose_if_unused()
  fuse: new work queue to periodically invalidate expired dentries
  fuse: new work queue to invalidate dentries from old epochs
  fuse: refactor fuse_conn_put() to remove negative logic.

 fs/dcache.c            |  18 ++--
 fs/fuse/dev.c          |   7 +-
 fs/fuse/dir.c          | 237 +++++++++++++++++++++++++++++++++++++----
 fs/fuse/fuse_i.h       |  14 +++
 fs/fuse/inode.c        |  44 ++++----
 include/linux/dcache.h |   2 +
 6 files changed, 273 insertions(+), 49 deletions(-)


