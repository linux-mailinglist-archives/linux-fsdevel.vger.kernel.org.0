Return-Path: <linux-fsdevel+bounces-30714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B8C98DE2B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 17:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7E01C208F8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80EAD1EEE6;
	Wed,  2 Oct 2024 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOuc1o9i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B4C10E9;
	Wed,  2 Oct 2024 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881240; cv=none; b=basKsrr+6ZKurDnF15lnVLEuxBw3uOUx7+Jg3Y+eMmGu9fBL2ySeAbE02D6V3yBJcx6k5nyVWeK1xoxDT736TOSJyIL71NLeDbkuji/wBOjPlg3m9J0G2+TEwp1V2G5PP9AyM5SzETrre9vIAXFqoZbODhbPVfgrzg3fXIl5nJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881240; c=relaxed/simple;
	bh=tXnFgNCaLBW8SJWvyMBianXDwLFKOg09fZTo/9GFZ10=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RJ91F9rjeJcAV3zrhSUh0mzyNj5ndeGFVpDTFeeI7JVZHgkPWpWtK8SNkLJtA+rLBE0Gp4bhIIAe3tyX+Baa+DG7mlaLtYCo2xWLM3haRifPIdt0b9QGg8zuPuXcTwsDrzSHcgqhTIlQz7F0Q1gMOWS7XBXDttGESO8RU0NRi28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOuc1o9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B098FC4CEC2;
	Wed,  2 Oct 2024 15:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727881240;
	bh=tXnFgNCaLBW8SJWvyMBianXDwLFKOg09fZTo/9GFZ10=;
	h=Date:From:To:Cc:Subject:From;
	b=mOuc1o9iDPjOe2rihsONpiBJ/yfWC3hlENrHd6bpNCLGNKdgQOXIhESj4oz5fbnnW
	 ZPdy+QNVNBtb+WSGJBxT2WjScC5C3fw3bKxW1Frvtir49JR4z930EVJkT+X8V43WFW
	 8fnvyDBI2Y6QZxFBwjxymgrlXGwKgdnWV1COziw4mb6QWmLuRUjDhQlUBPgzb1tmVH
	 llcUVbYu/Xz00YE7fny5C+/4CYaAjvU11N0klnthSJI/kSMWr+lqq1+Cx2020NWK/D
	 GHp7/kGh16WEiSst1v4jl+q6R4jBsL3jsLs9lCnjcsDBhB6HzTISWR33Cl/q7HV29N
	 5fQgMSGfVNF0g==
Date: Wed, 2 Oct 2024 08:00:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 1/2] iomap: don't bother unsharing delalloc extents
Message-ID: <20241002150040.GB21853@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Darrick J. Wong <djwong@kernel.org>

If unshare encounters a delalloc reservation in the srcmap, that means
that the file range isn't shared because delalloc reservations cannot be
reflinked.  Therefore, don't try to unshare them.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 11ea747228aee..c1c559e0cc07c 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1321,7 +1321,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 		return length;
 
 	/*
-	 * Don't bother with holes or unwritten extents.
+	 * Don't bother with delalloc reservations, holes or unwritten extents.
 	 *
 	 * Note that we use srcmap directly instead of iomap_iter_srcmap as
 	 * unsharing requires providing a separate source map, and the presence
@@ -1330,6 +1330,7 @@ static loff_t iomap_unshare_iter(struct iomap_iter *iter)
 	 * fork for XFS.
 	 */
 	if (iter->srcmap.type == IOMAP_HOLE ||
+	    iter->srcmap.type == IOMAP_DELALLOC ||
 	    iter->srcmap.type == IOMAP_UNWRITTEN)
 		return length;
 

