Return-Path: <linux-fsdevel+bounces-43859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AA3A5EA96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 05:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019D73B937E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 04:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE3E142E83;
	Thu, 13 Mar 2025 04:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="r66vlrB3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4762A142E6F
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 04:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741840175; cv=none; b=Wia1km0g7imxmXpP+nD+VAP5yR0xWMbSYHrvu5mYlpunhWM4WKnrnrau0GF1yLet/SiTItwnwBxENtHwO7Ru4/1XcqACC9+WgCh1zHqDPZYiMjE/vwVKkZ/eKdue50EEZKtD73JVQwnEURtrKFWPnKSfx12sd5fDT7y7ntSvess=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741840175; c=relaxed/simple;
	bh=Xg8T94qtVgcjSHuagINa4IMdgoNsud//IQbvINSO5OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNvCDS6OEcBAHLQtJg9gP0XJ+9+BlyXkIHlx/1NaNYgGvYWV2V4J2mY7IP/W/t5BCB/cKiWDq5JlE9N/uzu9r/gZo+kjmJuN0ydRY9JVFjAmUeCA0J3tP6GvBWtpxZ9dIbdMxSR0daTvHdtLCofZaGISl3R7y/+FxTEk0j+ZkXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=r66vlrB3; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r3XimgkWh+v3Pk6WwqVJOIdff7gbdmDD9MXU+Y8RHIs=; b=r66vlrB3EhAsHruV5Zd43iQCcZ
	MqLOiTBQvehkbnlCsfWJ5O80Y+lHqwklIM5oSDOIualrvlmxEdvpMe4WHwQfbk6jk3t1tkqlQKnFC
	Neqjp6kEvHVCBkeRkfwJDGIe60gs81mUFxGMiLL5IgS3Bni5+vHEqffJs9gSbIfiMQP4HoGWlzUNg
	UBtWl+4le960Fnory0ZqWz0bprxxfG0+bF2digYEXVaXgYqM0I/gdcBeHWuixivzc0LdXnYrerGTc
	2hccnJHRj8dpJZFNeiRtLhZ4SV8l5YNkYzuaoQhHvxkCDg3nw3sMzS11F+9jOZlHHWnHsAHJpWR8/
	SvRQoCwg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tsaCK-00000008uor-2Ufy;
	Thu, 13 Mar 2025 04:29:32 +0000
Date: Thu, 13 Mar 2025 04:29:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] spufs: fix a leak in spufs_create_context()
Message-ID: <20250313042932.GC2123707@ZenIV>
References: <20250313042702.GU2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313042702.GU2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

Leak fixes back in 2008 missed one case - if we are trying to set affinity
and spufs_mkdir() fails, we need to drop the reference to neighbor.

Fixes: 58119068cb27 "[POWERPC] spufs: Fix memory leak on SPU affinity"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index c566e7997f2c..9f9e4b871627 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -460,8 +460,11 @@ spufs_create_context(struct inode *inode, struct dentry *dentry,
 	}
 
 	ret = spufs_mkdir(inode, dentry, flags, mode & 0777);
-	if (ret)
+	if (ret) {
+		if (neighbor)
+			put_spu_context(neighbor);
 		goto out_aff_unlock;
+	}
 
 	if (affinity) {
 		spufs_set_affinity(flags, SPUFS_I(d_inode(dentry))->i_ctx,
-- 
2.39.5


