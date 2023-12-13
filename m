Return-Path: <linux-fsdevel+bounces-5812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 074AF810AA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 07:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C511F217FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 06:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C8811718;
	Wed, 13 Dec 2023 06:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uAQoscHU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAAFAD
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 22:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iyTfmEfMb8ETxO+V3m8JJLVNN90C+GRLzHjKoOmHvw0=; b=uAQoscHU/vnHyNs0+i9lnVnccD
	E3CoReKVSf7W+VPj+QUFkU2QtBQrMWe0u7rSis1UhD4bfeWILMkw0ivMv1GoJvGM2mnRHTDQWj9zj
	vPegC8Hxr1iLKdG8p5Mqdj9GRV4MCYK3UZ2eWSbve+k+pVLYa+lLpSLZhIZHw7ARngH4AHuoYU/2G
	fZcKj1JJL6ktM201V0E0XlUKmXH8V3/DMvD2Ba5DIQqSlye75yHW8OrYnQ6DaAqx4MvU1qvPzQY1L
	PU6ebb290AShr0HH5hr57tFh/HufnbCqY9NQa313Zg17af2JCeGwC5ZgqMM57osMkjvmae9uBcjWY
	DLyF34gg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rDJ7M-00BgWG-35;
	Wed, 13 Dec 2023 06:53:17 +0000
Date: Wed, 13 Dec 2023 06:53:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Evgeniy Dushistov <dushistov@mail.ru>,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [patches][cft] ufs stuff
Message-ID: <20231213065316.GK1674809@ZenIV>
References: <20231213031639.GJ1674809@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213031639.GJ1674809@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Dec 13, 2023 at 03:16:39AM +0000, Al Viro wrote:
> 	More old stuff, this time UFS one.  Part of that is
> yet another kmap_local_page() conversion, part - assorted
> cleanups.
> 	It seems to survive local beating, but it needs
> more review and testing.

Sigh...  That it does - especially since a bit more testing
has caught this (in mainline):

[PATCH] fix ufs_get_locked_folio() breakage

filemap_lock_folio() returns ERR_PTR(-ENOENT) if the thing is not
in cache - not NULL like find_lock_page() used to.

Fixes: 5fb7bd50b351 "ufs: add ufs_get_locked_folio and ufs_put_locked_folio"
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/fs/ufs/util.c b/fs/ufs/util.c
index 535c7ee80a10..f0e906ab4ddd 100644
--- a/fs/ufs/util.c
+++ b/fs/ufs/util.c
@@ -199,7 +199,7 @@ struct folio *ufs_get_locked_folio(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct folio *folio = filemap_lock_folio(mapping, index);
-	if (!folio) {
+	if (IS_ERR(folio)) {
 		folio = read_mapping_folio(mapping, index, NULL);
 
 		if (IS_ERR(folio)) {

