Return-Path: <linux-fsdevel+bounces-34389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AF89C4E61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 06:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13F112847F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 05:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95926204932;
	Tue, 12 Nov 2024 05:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ws8W/DmQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D045234
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 05:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731390251; cv=none; b=doW0mal4EmIGobgpMtrsxL4qmZf/cBN5ikeqICL3IVZ0eZu4jMT+7yRKgkGBOxkQjtKYLI/JcUwHCaDKmaL1TYDGjjW7MPNwsusNe89Ju9gQY618RnAX/vWzHDiCuxtH89/nYAuKFF3Hs5D6NFB7IM0IER0pfvBiZVEFBnwsjrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731390251; c=relaxed/simple;
	bh=1RyGJAa6oi8xpQGGHSLtufYmfxGl+nVF2XoMezjTH6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IX8ox6Iwd7WQUChce8gVXnjj/1Duyy9Fc+whRuK+/hVjlR2HqVLndKEliakQmAdL6EZZ6bVLZiLnM0WRqTuQ+VWKmUWXsKaFaLejk8KnsemdV3djg0Z4pVp8/DH2ztGiFvqSy6mnxKvPBHjQ6A25kBBxEppgxyPlpYsP9dycxGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ws8W/DmQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=CSHixcKlfhOaYDyrMDnAXE4Pn2c/io/0gyuEslGX5rw=; b=ws8W/DmQLmyz4/KwUIY6CwgIA3
	q9SjM6RVQ2IGNAJdRnAEyuq0s2BAI6BzJ/yPinA+s6nFbXsoU6lw31p707lC/70lXf0ZXDzaSRHJY
	COMD+Lo2XuA0PJxcs+N4j4q5cAqsXqHvOeLw6zAez65laGRmCdJ8ggzj5rwQkRCPv7ufn3h7FwhTX
	gCXQeqA8FmI9IOasxdAq7YgI0J7/F0Rd1fs+qABTdmZNjFMyE9sxu/w6ZydPem3Xbg787V33wtQRb
	5AQk9CF5RAS7HhNnpfrptCdPg68mBZyOOI8WijoqpfB8yk/ydPS9JvXul1iCoVi9+Yxrvz/VmDd1l
	UX/u6IqA==;
Received: from 2a02-8389-2341-5b80-9a3d-4734-1162-bba0.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9a3d:4734:1162:bba0] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tAjh8-00000002HQY-453b;
	Tue, 12 Nov 2024 05:44:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: two little writeback cleanups v2
Date: Tue, 12 Nov 2024 06:43:53 +0100
Message-ID: <20241112054403.1470586-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this fixes one (of multiple) sparse warnings in fs-writeback.c, and
then reshuffles the code a bit that only the proper high level API
instead of low-level helpers is exported.

Changes since v1:
 - mention the correct function in the patch 2 subject

Diffstat:
 fs/fs-writeback.c         |   32 ++++++++++++++++++++++++++++----
 include/linux/writeback.h |   28 ++--------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

