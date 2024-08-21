Return-Path: <linux-fsdevel+bounces-26431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58434959492
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 08:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDE93B22C79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 06:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C216DECB;
	Wed, 21 Aug 2024 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tBk5FUge"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75516B736;
	Wed, 21 Aug 2024 06:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724221878; cv=none; b=YojmwhoisCX9DbWJDBIBGAMKesD6Y26qTdpuSOhdl0dKv8NGMKu8y+P5oRRw7V2sUYxr6+xtautVxlYtRnCk3hj8EZIs9Jl2WSWjiLPweg9FH1noBeZ9hn5GT5iB64rD5yw5INOOcQgNWkSS6CbxMwMUG+P5dxOnfbQ8Gqf7Qes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724221878; c=relaxed/simple;
	bh=06V7rd2D4Dm/UhzUdirZ8DKOH4I39WA+O45KB0SbMrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2zZLzcEiVOskJ+3xzTmuCoObv7GtX9rbDa23R27EmNkKrnT/WeWAtVDspz03Cfaq8k0yHLAm4tfbWTpxdxs/8xCjEZWQhO8QNXULv8AksrhWA8jNKY4l9WR2FudKqKZlJfKmY54vr/ZqtfmuUPZHtpCMAMGTWS8ODz0ZEudnGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tBk5FUge; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=06V7rd2D4Dm/UhzUdirZ8DKOH4I39WA+O45KB0SbMrw=; b=tBk5FUgeFo4IIagJ7peLi4moza
	yKayf9XsFAh3GiuOLYgFPlTB9FinkzNPvP/eUNGtk7ACHKRfjv1cxSGdT5pWYDYa7uydpcvb7b5Eq
	a+LKXZZ6di6s/YwSHObhHgz4FEaaT7d8wA2QbRqVAn9dXkUoMpDRH/lvj3VR5pa7iM45HJhyy3dN/
	/DdGQgWTkzXxdBEeFo8SvwE8LXBi+M6Ui5OWWQldZH0tV6jvgQ/OfTP60SfvIm/QeOihfIye/hXWR
	4NqKPGRPXHVAS6ntleQJ5pM/OxbpO4MnG7EXOf0/+PvnBcg9EZxKCGgVgKn3g/8DGkSmWkiQUp9QW
	oMpOL7nw==;
Received: from 2a02-8389-2341-5b80-94d5-b2c4-989b-ff6e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:94d5:b2c4:989b:ff6e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgesB-00000007iQ7-1SVL;
	Wed, 21 Aug 2024 06:31:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: sort out the fallocate mode mess
Date: Wed, 21 Aug 2024 08:30:26 +0200
Message-ID: <20240821063108.650126-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

I've recently been looking at the XFS fallocate implementation and got
upset about the messing parsing of the mode argument, which mixes modes
and an optional flag in a really confusing way.

This series tries to clean this up by better defining what is the
operation mode and what is an optional flag, so that both the core
code and file systems can use switch statements to switch on the mode.

