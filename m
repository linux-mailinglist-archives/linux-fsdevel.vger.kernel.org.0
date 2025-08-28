Return-Path: <linux-fsdevel+bounces-59510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF79B3A651
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 18:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D8FB98738F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 16:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5B432C321;
	Thu, 28 Aug 2025 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="MWpOeMJI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D967D22FDE8;
	Thu, 28 Aug 2025 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756398610; cv=none; b=SfGSSEb416ko/iV3+A7Qk/oiT0e/c57JQL2NUk0bZWeBgrOPXQi5SUOvLrkI5XosDo20yB/qQa2f1jIMrpyMQj6BNL+Gs7ZMrpdyvWeKNpjMGt7NiuyDmeOkV2iYd++NT9DT9Q2QMYPoYWWZ56X7XptO6P+hAxsooDdUdTlOr6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756398610; c=relaxed/simple;
	bh=GsjyM/kTzBg4QIBjjTAqtTIBsrzAmwfdLbZWamiPf1U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kwIufSCgdqG9ZWAYUO19AFiRCFZe60UlWJzsGtha1cMkqBGwt04bdlZamkkJdNcK8VSzbLLEPkIB4KN+yZnNPau+kJvNBgyDksCEhVyaPhkKAodtWkRJ1efu2MjvtJY5FCA1UbD6QpX6KYZgF1dBwIZVmm1uGY5cmyaShFW5oZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=MWpOeMJI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=kTrXXLtJq+/AXlMz1CDddMGfk3QSiSb4WMCpIcCiABs=; b=MWpOeMJIVvmsbV4pGyRPddsoPZ
	p0EIZFfW7iXOGbTUfsqhOSBxbLGth/uAIteRPbqJefvoZU67AAg2Rg0eqdkV/YCrrY4Ha0WpWb/pl
	/XlbhFH6CkW9CvezxTTXMv4udvAAxB42LeDfu7WgCYf6ASoLlgw31g0JSyIxchq+cxoj9kJx3VUbn
	M22++PBvyABERJD9TCJzpEhhaT/O/CGjRgOAnyrPbd66VqH8XO8MOs0WKT4tQ0RMQyxATaG0hqDD5
	mWMpUKL417lmORmbnOG5kwqQWXmuVAdLSV+CZWDddaio+o2JaOEGE+QNul0f9k+OIp8qNnG0JWpSY
	NO1T3kVA==;
Received: from bl23-10-177.dsl.telepac.pt ([144.64.10.177] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1urfVe-0031Ti-Rp; Thu, 28 Aug 2025 18:29:58 +0200
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
Subject: [RFC PATCH v5 0/2] fuse: work queues to invalided dentries
Date: Thu, 28 Aug 2025 17:29:49 +0100
Message-ID: <20250828162951.60437-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Miklos,

Since there are huge changes in v5, I decided to send an early version of
this patch(set).  I'm sure there are bugs and stupid mistakes, but I'd
love to get some early feedback before further testing it.  And that's why
I also decided to add back the RFC tag to the subject.

One annoying effect of making the dentries trees global data structures is
that it makes things more complicated to handle epoch changes (2nd patch).
It forces the work queue to walk through *all* the dentries in *all* the
trees.

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



Luis Henriques (2):
  fuse: new work queue to periodically invalidate expired dentries
  fuse: new work queue to invalidate dentries from old epochs

 fs/fuse/dev.c    |   7 +-
 fs/fuse/dir.c    | 251 +++++++++++++++++++++++++++++++++++++++++++----
 fs/fuse/fuse_i.h |  13 +++
 fs/fuse/inode.c  |  48 +++++----
 4 files changed, 276 insertions(+), 43 deletions(-)


