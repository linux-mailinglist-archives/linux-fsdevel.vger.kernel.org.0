Return-Path: <linux-fsdevel+bounces-34554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34BA9C6390
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 22:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD681F23E24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8187421A4D5;
	Tue, 12 Nov 2024 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AGPiyToN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DBA21A4B9
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 21:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731447526; cv=none; b=rbcG1a8NDKUXExW7n5kG0fQFXCVvvXInSUqJPR1uPXsCTaODHzb7sUV5ccE+LKCm0kaqKw8BCFHtbJigwbQAVyGHMFAhwD4hgwtMeJ39r8rnZEc0SQh+LRG/u7XdUv4GqVAcls6J7QLpIcgriPmlxlILUHoCig44jyq1FcjX1Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731447526; c=relaxed/simple;
	bh=BkYmk68FDJkMiNtVjp6CsnGilU89i2aDpjmBk9eq+8o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YIK5WqqPWxuNYaq/FGeq+scaYqaPT/NsGfouv6toXOuUk/YbQkvoTmHiIuHWYcO4ii35WqJWpg5XRe8g5Ru69Imow8SO4CekxwU0Tezz8D3I27k90EiR9ZO321T8mBaZVOi9QvHa7GWpAvPEb5ZztQTzp+fgOYRQQ9oN977AHEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AGPiyToN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=lMzu9wnVNKo70R1sotoHURlUovKeY9/vMXv22iLaXvU=; b=AGPiyToNrK4TocuoRMX8pyP9sj
	fR5cPtDM+rIp/b61d0Jw5HWzw9geRLWjyhIXvIHLm47cWE6+pYypVl/ArbkxYi1bRwcpBaq8CEW0R
	+x5b4kqtB15x6n/mZhdo3dZpmRQn4VudgFzj35TQb0RTStjsVCxG6k8wMGxh5dfkZi53fyOofSfHF
	siAoFW/ZvLhTKuRgV8Jnv6V0WUJJB1lgdMt/d58AXhoOgMrypO9u1XSYSYyrTzzsPJrvtAO2hl1W+
	guent0YU6M83rcVlDgISjtORvW+dpS5QVhv8jhFcR3ekhMbzzCoamHpHuUdVIZWhrDmKInIQy47p2
	fJcTycrA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAyaw-0000000EFhk-30FL;
	Tue, 12 Nov 2024 21:38:42 +0000
Date: Tue, 12 Nov 2024 21:38:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.com>
Subject: [PATCH] dquot.c: get rid of include ../internal.h
Message-ID: <20241112213842.GC3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Ugh, indeed - and not needed nearly a decade.  It had been
added for the sake of inode_sb_list_lock and that spinlock had become
a per-superblock (->s_inode_list_lock) in March 2015...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/quota/dquot.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index b40410cd39af..3dd8d6f27725 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -80,7 +80,6 @@
 #include <linux/quotaops.h>
 #include <linux/blkdev.h>
 #include <linux/sched/mm.h>
-#include "../internal.h" /* ugh */
 
 #include <linux/uaccess.h>
 
-- 
2.39.5


