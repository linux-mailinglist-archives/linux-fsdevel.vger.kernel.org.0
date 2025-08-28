Return-Path: <linux-fsdevel+bounces-59531-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D842B3ADF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF8075801EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B0F2D249A;
	Thu, 28 Aug 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZbOC51F+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743962BE653
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422490; cv=none; b=QfB9Fz+5MebBtGKoB7bW+1frDp23gPv48m2ZL7HEi5rV5SNS1LLJcGKOH0nMCSAq9aR7wAPD8QYV20geW+W0AKOBtuYAdhI5JcrKUifXK1T5E/URQzXnd2OdA562GqlnpIUOuP8/4tZcwyK6SC0ZzThMcbq7LO43FWsyXhyWXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422490; c=relaxed/simple;
	bh=CzQrmpEbELJgaSqw2DsqlBJbXpOsr0TrnJEUbT4u66U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZVvW9dMEKUXCSMgDFtrfqw/rlbwm9nB2JOZXiBLDuW2rdiXN86GN0iIS6lIJLx0d5Y4x6YcvV3QJyDrCGW/30jNaOtWyssTAK733iu/FTzjHLe/orzud0rXsEjOydWM3QHosF60TZo4G6FbekSNFoTOBoOGzLoBmlCSmDlt5Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZbOC51F+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=N4gJ4l8FdaRiUW/HlyTUwYAWphPSBZ/HZ8suRgfc8YQ=; b=ZbOC51F+k4jZubN0aXl1sADjQg
	EFKDwCckdv5GY3uq9cajS6C8PGI01x2IVLfsJbpEzTz56L3X4ptBdpXX8xEpBRf4ZZFz+8jy+wDmX
	bYGLUs56U7gSMuM/m6LhcDK2EzY+qx8pmgJjt3SUx96gzKH4cHrwa9apU7GuTeHFBt7FlIj6qFvtu
	ISlqrNTHyTsyBjyild8USQz4Cni0CYkp5VnCKrtW8DY5ebIsUve6USEQEXqV+RiLY6Ta8Cc8bOU6A
	A2l8a+TFLyGtMrYIZtnx2SB12VMxz0OrJY0bJZldSsXOvWkSaAi6lHEb5tb7zfSoc0LxOmkM4sf3y
	jQoMXAbA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliw-0000000F209-3Zx8;
	Thu, 28 Aug 2025 23:08:06 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 02/63] introduced guards for mount_lock
Date: Fri, 29 Aug 2025 00:07:05 +0100
Message-ID: <20250828230806.3582485-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

mount_writer: write_seqlock; that's an equivalent of {un,}lock_mount_hash()
mount_locked_reader: read_seqlock_excl; these tend to be open-coded.

No bulk conversions, please - if nothing else, quite a few places take
use mount_writer form when mount_locked_reader is sufficent.  It needs
to be dealt with carefully.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/mount.h b/fs/mount.h
index 97737051a8b9..ed8c83ba836a 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -154,6 +154,11 @@ static inline void get_mnt_ns(struct mnt_namespace *ns)
 
 extern seqlock_t mount_lock;
 
+DEFINE_LOCK_GUARD_0(mount_writer, write_seqlock(&mount_lock),
+		    write_sequnlock(&mount_lock))
+DEFINE_LOCK_GUARD_0(mount_locked_reader, read_seqlock_excl(&mount_lock),
+		    read_sequnlock_excl(&mount_lock))
+
 struct proc_mounts {
 	struct mnt_namespace *ns;
 	struct path root;
-- 
2.47.2


