Return-Path: <linux-fsdevel+bounces-66018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFA8C17A2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3336C3B719A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 00:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73822D3EF6;
	Wed, 29 Oct 2025 00:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTobPJu/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D15A84039;
	Wed, 29 Oct 2025 00:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761698948; cv=none; b=ZiVT5AxmRH+oe4ZX1rwReuXF/PqRrnduYro2iP7BWdEe7DziF0fOi4y2kw3R5E5Ow8rSzYfHoGM1NUoxXeZ1H0wneQh8WEytOqZwuswMrHVu914vtQ6/crI1JQf2an2r83Un2s7LXYjawsrjzVhp+6NmcIH9oZTszyYOdkNrYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761698948; c=relaxed/simple;
	bh=yroGAch076/4DadTruRmU68b2kXiz7Ka7Qj6BVFx80c=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtaafWQoH/TyhwKQgerqNYiGkmGGN6usPS5Hg/ftwSfz7DDprOWvmc1V7CUuYG5K0/MhHZf4nP0K4w33p7X0Kq9cK8Zg6Gp4WI6FfdZQFvA1Q+lvi5AR56Jcyh5QVjyEjTNFwXWoR9Xk0zBjRYAfOlRUjmsJv/ixHQgVNEgDFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTobPJu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1322FC4CEE7;
	Wed, 29 Oct 2025 00:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761698948;
	bh=yroGAch076/4DadTruRmU68b2kXiz7Ka7Qj6BVFx80c=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RTobPJu/F1al12ZC67jEbOnNqOhmdO9yp6HwrEHRh6L6GRuViX7ssb+Kfd5KORLNA
	 PDZjKIobWN1nb6DzTjY4/4lP3+n4OLNkyAJrFCDXkJYGnD6xgKTj5seUYqOTwwtlbn
	 A2x3PA9CuRc2tIozRJa2s08r4h/Lxjuxmxl2K8hTEJcpam9yYlblF8nsE1W7MRsTiE
	 fiBxni3VePndhmYf3q3bk5uru1RijIxjqbmDB0PgZryGGkDEaZck0n925iRKQy4eEf
	 X0ItBJZKYcAEqpmbrMiYN9F9dvBFz4gvnmAromP5YHxVO5ktfV2Q0ZGG58HtRH1jYf
	 YymqP4jQk2ojQ==
Date: Tue, 28 Oct 2025 17:49:07 -0700
Subject: [PATCH 16/31] fuse: implement large folios for iomap pagecache files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, bernd@bsbernd.com, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <176169810700.1424854.5753715202341698632.stgit@frogsfrogsfrogs>
In-Reply-To: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Use large folios when we're using iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/file_iomap.c |    6 ++++++
 1 file changed, 6 insertions(+)


diff --git a/fs/fuse/file_iomap.c b/fs/fuse/file_iomap.c
index 897a07f197c797..0bae356045638b 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1380,12 +1380,18 @@ static const struct address_space_operations fuse_iomap_aops = {
 static inline void fuse_inode_set_iomap(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	unsigned int min_order = 0;
 
 	inode->i_data.a_ops = &fuse_iomap_aops;
 
 	INIT_WORK(&fi->ioend_work, fuse_iomap_end_io);
 	INIT_LIST_HEAD(&fi->ioend_list);
 	spin_lock_init(&fi->ioend_lock);
+
+	if (inode->i_blkbits > PAGE_SHIFT)
+		min_order = inode->i_blkbits - PAGE_SHIFT;
+
+	mapping_set_folio_min_order(inode->i_mapping, min_order);
 	set_bit(FUSE_I_IOMAP, &fi->state);
 }
 


