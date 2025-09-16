Return-Path: <linux-fsdevel+bounces-61523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A62A7B58988
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA281AA2182
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE4919EEC2;
	Tue, 16 Sep 2025 00:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5RdJpl9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A737D2032D;
	Tue, 16 Sep 2025 00:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982729; cv=none; b=TmMa/b7QJs6M5e+E9N+w7+ktqqUwoddEQnfYOYhw2v6RARjNT1U7Ko0ujX4yBhfV+adlIcgLt3h3FdQbqR/jAomXm0N0DD5Y30ND1w1fwHf1mkxNV9/4CgeM9az1lnq6qTjk9EmnhiNOnkZD6SsbYApMCp3bxwY+FdZsz5CDVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982729; c=relaxed/simple;
	bh=AYdzvbor/h2PXQd9zTrNYILP+NUbPlaeEG9oKDfW0dk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TNWaYi4cvuBic1tAmgo2TMdSUUU/47zsGYwUfLguaFUCzjzz6+ZVcNmZJj4GNfRY7h0c2gTg/QViUEPFcIWtpPOuSqEfu+C/8pXbH5bOH40eL2/KgBIRIDFELypxL9YqabGNCg7YUoWzrPIMEVbbvvJs7lIfUsKrial7kXmgRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5RdJpl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C57C4CEF1;
	Tue, 16 Sep 2025 00:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757982729;
	bh=AYdzvbor/h2PXQd9zTrNYILP+NUbPlaeEG9oKDfW0dk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=C5RdJpl9CVnjZjuG9LMN0fZObeP+HNDk5ejXywQSxRjytQOcf8c9rB8O1eW1Kk+c5
	 2fAqsrmwIDkqTl0ZshEMTbT77IsRUAO7CVntaHczYn1o5ve7gX27r34a/CCpSXysk9
	 ZOIrs3qFpDRmetu/1nbEzcU/6CmWs9uQ+N44jgV1ZBxZICC2w66WMPgKAC85ntLd3r
	 f/5wsWUFgqoEPhIVLoZObeRqjMADObcp4v4vtTLZoqq8ef2e9SCGeLZI2JOIz7WYnz
	 xyxZgpi2FlIKCsQ38TESxwWiy1DSrNfANw0kIQ2EelSfUbniASfJyuQtcHZ4N2dUZh
	 cgt1uP5/b9ZTw==
Date: Mon, 15 Sep 2025 17:32:08 -0700
Subject: [PATCH 16/28] fuse: implement large folios for iomap pagecache files
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: bernd@bsbernd.com, linux-xfs@vger.kernel.org, John@groves.net,
 linux-fsdevel@vger.kernel.org, neal@gompa.dev, joannelkoong@gmail.com
Message-ID: <175798151609.382724.17825179078141335126.stgit@frogsfrogsfrogs>
In-Reply-To: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
References: <175798151087.382724.2707973706304359333.stgit@frogsfrogsfrogs>
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
index d771b1068fb912..c09e00c7de2694 100644
--- a/fs/fuse/file_iomap.c
+++ b/fs/fuse/file_iomap.c
@@ -1357,6 +1357,7 @@ static const struct address_space_operations fuse_iomap_aops = {
 static inline void fuse_inode_set_iomap(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	unsigned int min_order = 0;
 
 	ASSERT(fuse_has_iomap(inode));
 
@@ -1365,6 +1366,11 @@ static inline void fuse_inode_set_iomap(struct inode *inode)
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
 


