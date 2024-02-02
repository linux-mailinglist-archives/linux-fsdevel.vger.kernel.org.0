Return-Path: <linux-fsdevel+bounces-10108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB7A847B49
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 22:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A57B61C213D2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63565138480;
	Fri,  2 Feb 2024 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lqFXIBkP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1907D1308CC;
	Fri,  2 Feb 2024 21:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907635; cv=none; b=NsPJEBvajfJSsWoS/zKrwsZOqpF0ZZJ04e3IiydeEY5VvEpPDZO6JZPphXPLv+EyP2D4RJIHutnAh15b73xoyd8p0wdjbGjCNh1RWtL37fvQ3hwPE2iu+eBB3jDtLDsnWei/HAyytpvBzh9l2MxZ60gxDVpPPpj9DgavYyIK77w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907635; c=relaxed/simple;
	bh=umcqlnyoni1L+YV9DQVqbsmdwpCSWY7IqX3VvZk7A10=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rbOtM6ATpw0iehzxJqnTKaGAIRqt6S89WEf/YoQ486IYxeiQ4v4PMdeBQinTO6IiTSNw6bu26J9sP+98a8Crkb1/Uk8EesEkTweG3GsL0SrCYqRYWfy4UItvyBChorVhrNNsUV2J/nD1+VjjGuHLkKmsVVC3NHWM33e0YXZj9Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=lqFXIBkP; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706907632;
	bh=umcqlnyoni1L+YV9DQVqbsmdwpCSWY7IqX3VvZk7A10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lqFXIBkPDeZLU45mjUmnm0q3K473FzSvhK0mnrXvhigDtwWMPffN/nvDG+HjmLhap
	 XrVKFSp8liCgJWM5Eg0tCRrj2fhEw2prPWKm1ioqpCgipg1igi1SaDbnkeKOm6XGCA
	 5TNwnhRSJ8qxzVcg2hGw3+/ggGMs07Oerum0TU9KO61RsOC0dkF05xsu1dTLTBbqhh
	 N/kWbUj5cfkrNfMI6UKWA0tHM87k+2eksxppdkVd2mkAhQ8jBpJZZiG1ADrMpVpvQM
	 jagnOvFu4AVyj7SZMGqU2NuRYa7LnjHCXrByox5plK8AOgTnfOaP/F8tHh2RJd0ft0
	 pwO0PxPGfxN1Q==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TRSpl58jJzX2N;
	Fri,  2 Feb 2024 16:00:31 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Dan Williams <dan.j.williams@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-xfs@vger.kernel.org,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: [RFC PATCH v4 12/12] virtio: Cleanup alloc_dax() error handling
Date: Fri,  2 Feb 2024 16:00:19 -0500
Message-Id: <20240202210019.88022-13-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202210019.88022-1-mathieu.desnoyers@efficios.com>
References: <20240202210019.88022-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that alloc_dax() returns ERR_PTR(-EOPNOTSUPP) rather than NULL,
the callers do not have to handle NULL return values anymore.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arch@vger.kernel.org
Cc: linux-cxl@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-xfs@vger.kernel.org
Cc: dm-devel@lists.linux.dev
Cc: nvdimm@lists.linux.dev
Cc: linux-s390@vger.kernel.org
---
 fs/fuse/virtio_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 621b1bca2d55..a28466c2da71 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -809,8 +809,8 @@ static int virtio_fs_setup_dax(struct virtio_device *vdev, struct virtio_fs *fs)
 		return 0;
 
 	dax_dev = alloc_dax(fs, &virtio_fs_dax_ops);
-	if (IS_ERR_OR_NULL(dax_dev)) {
-		int rc = IS_ERR(dax_dev) ? PTR_ERR(dax_dev) : -EOPNOTSUPP;
+	if (IS_ERR(dax_dev)) {
+		int rc = PTR_ERR(dax_dev);
 		return rc == -EOPNOTSUPP ? 0 : rc;
 	}
 
-- 
2.39.2


