Return-Path: <linux-fsdevel+bounces-11591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF985855095
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 18:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C60B1F2AF18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 17:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED0B127B6D;
	Wed, 14 Feb 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZZE+mQ5S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7F0127B61;
	Wed, 14 Feb 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932533; cv=none; b=ojQrl7/a9k3HI7hYDakYFd3NyBN/p0OV7WmqQRjUP0pJjCJ2rRibum4Q+CLFz86W/RSBG8FqWEGGshOagpac2A6wUxWbIhbD3NcLtJdnNaXptvc6HZiFYYHHwtupyftHBB8RVGKkCbVtv2NpSrE9UiNsE3O9xW9qWk1HTUbZzwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932533; c=relaxed/simple;
	bh=9HAt1wH13l4e0td53MGTulRzGQf3ZC8x9JSGKEjhRPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3FNgccesC7WdPbhtOBxFepTDZubR8x/1ZMzGcooNhUWgVClBkPBzqJphfG2MHFJz2J3j2/vxj3Y9J4zuHLoF84Y2vsfWmw+OM3eZydS2G9LNSSDzA7aVx8eP1OXHx2380iyADoP00s1RIqpWsbJZ8yXSxscTMgT3uXkCP/Cnuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZZE+mQ5S; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rCqjAOgUyt+KMQLgmOWKy4Rs0nGvE2mK6EC5NStgV8w=; b=ZZE+mQ5See51z9iONY/ajauZMI
	LG1Qhb8X+IG7BISS8BakhilYQMPpTfsVxD2LWepJLQBUKOtFLhiglbuurDPppkrMxWRaZL+Og1Y6L
	wZuLU+GYHsQqrCgGucwWqX1DfOrAns/gfmVKEUzgrEtnSkWXbutxgEKVFFZJjAShiazMNX+QMtuVl
	MHx8+l8TFookK3bmI6LB3nsJOKVJ0MYZlo2h15peXjSoOnVhyTN3/+vTSlTtlth+ZeGFnP84B7bLF
	DTBHK6nvo3lMdxNsj9X3Cl1xtrOBQMuEs+XX2AD7hh1pFAkXipPHlFUO4iz1s0vtORhBHWw5wAYd2
	gYspOO3g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raJGt-0000000DmZm-1rQf;
	Wed, 14 Feb 2024 17:42:11 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: fstests@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	patches@lists.linux.dev,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH fstests] common/config: fix CANON_DEVS=yes when file does not exist
Date: Wed, 14 Feb 2024 09:42:08 -0800
Message-ID: <20240214174209.3284958-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

CANON_DEVS=yes allows you to use symlinks for devices, so fstests
resolves them back to the real backind device. The iteration for
resolving the backind device works obviously if you have the file
present, but if one was not present there is a parsing error. Fix
this parsing error introduced by a0c36009103b8 ("fstests: add helper
to canonicalize devices used to enable persistent disks").

Fixes: a0c36009103b8 ("fstests: add helper to canonicalize devices used to enable persistent disks"
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 common/config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/config b/common/config
index a3b15b96f336..2a1434bb11b9 100644
--- a/common/config
+++ b/common/config
@@ -679,7 +679,7 @@ _canonicalize_devices()
 			if [ -L $i ]; then
 				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $(readlink -e $i)"
 			else
-				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $i)"
+				NEW_SCRATCH_POOL="$NEW_SCRATCH_POOL $i"
 			fi
 		done
 		SCRATCH_DEV_POOL="$NEW_SCRATCH_POOL"
-- 
2.42.0


