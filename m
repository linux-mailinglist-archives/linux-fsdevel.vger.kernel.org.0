Return-Path: <linux-fsdevel+bounces-39463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4D1A148EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 05:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A5897A3CB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 04:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F661F6690;
	Fri, 17 Jan 2025 04:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnBhtfKo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E301F63C6;
	Fri, 17 Jan 2025 04:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737088634; cv=none; b=XmUGbSmupmwA9ara011hSJIiKWGlN8dhVS9wbv9SvkRkJvu2WZ5DpQjyfsTaT9uBE/cPh/zU2kNEjJv99McayOBZKWcMQtyZh/nzGELLghKl7SbjtlqId2LDwpa0guTUhZSLv8ek36LDeaHYAZ15Tg7qy5uoamw+MtzAuGhnkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737088634; c=relaxed/simple;
	bh=KVR2Fo1vempKV6r8+IgQZEmdoggjc5heNIzuYrjHh5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GVgSG5edT4X+u7b/57zGEq1IPmPeW0rvlHjECrdFwjo15mgWwmybm5gpJzx4M91brh7PYdO3q+0NO/BiMuOkY5sw+egMzLu5LmrBZl80jKZOEeZUoDVt5AuLc7fnbV/E+VRSdnWsZmnnzblwTNyXJQrpraGxflyw95GYryzykX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnBhtfKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E237C4CEE0;
	Fri, 17 Jan 2025 04:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737088633;
	bh=KVR2Fo1vempKV6r8+IgQZEmdoggjc5heNIzuYrjHh5Y=;
	h=From:To:Cc:Subject:Date:From;
	b=EnBhtfKowH+yMvyHAA83M+ZaH0+sl5M4dT/F5TrTaFruB65Ne5h9hURL+6KGv5X6o
	 0/weoGQyU0eaGJ0AAQ31OxXtISF6UyUC+uKtk7N8VO+KaffA96hlXSDpaDnEWdX8f8
	 GxTUmvuBfo9PFovJAN2+rveszkBx92rX3cSJ0I32FxlOIZhdI1ZIZ7s52uxIxk35+6
	 NNbnxxbciaCG8WTafWVQ1bU9xv6Oo2VEMCtv1kXomqXtSvXFJQZ0MwwQ+NT6KWNLUk
	 Mb/0klY5Fqf7tKP6JJP6ur9RSMdKPEoLQTqkgXZDrA9BNH7cL1DbgjuvlUqNXMWm04
	 W+kE2vlr9H+Wg==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH] fstests: workaround for gcc-15
Date: Fri, 17 Jan 2025 12:37:09 +0800
Message-ID: <20250117043709.2941857-1-zlang@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC-15 does a big change, it changes the default language version for
C compilation from -std=gnu17 to -std=gnu23. That cause lots of "old
style" C codes hit build errors. On the other word, current xfstests
can't be used with GCC-15. So -std=gnu17 can help that.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---

Hi,

I send this patch just for talking about this issue. The upcoming gcc-15
does lots of changes, a big change is using C23 by default:

  https://gcc.gnu.org/gcc-15/porting_to.html

xfstests has many old style C codes, they hard to be built with gcc-15.
So we have to either add -std=$old_version (likes this patch), or port
the code to C23.

This patch is just a workaround (and a reminder for someone might hit
this issue with gcc-15 too). If you have any good suggestions or experience
(for this kind of issue) to share, feel free to reply.

Thanks,
Zorro

 include/builddefs.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/builddefs.in b/include/builddefs.in
index 5b5864278..ef124bb87 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -75,7 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
 NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
 HAVE_FICLONE = @have_ficlone@
 
-GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
+GCCFLAGS = -funsigned-char -fno-strict-aliasing -std=gnu17 -Wall
 SANITIZER_CFLAGS += @autovar_init_cflags@
 
 ifeq ($(PKG_PLATFORM),linux)
-- 
2.47.1


