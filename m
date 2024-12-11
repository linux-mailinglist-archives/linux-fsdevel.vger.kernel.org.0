Return-Path: <linux-fsdevel+bounces-37027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4965A9EC7CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 09:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0B428647D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 08:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112001E9B2B;
	Wed, 11 Dec 2024 08:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3IBMD2k/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D1A1EC4D5;
	Wed, 11 Dec 2024 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733907266; cv=none; b=Vv6ixZ+g1/cpcyxj/QzAKpd/7TluD22ur8eAoabJGMqyh6PUpCW6tonmEQFVMqkJVKG1gefOtlJKMwBZ8Latz9F4fbTcSqm2FxATtx3k3Qsr9uT2qJ377wh9biQ6E2O76CdyXp0jrrn2Wsh5j+vdGrq2BEkXaL7/B4MBsryyENk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733907266; c=relaxed/simple;
	bh=BMh+w3/tg+tZirztubOJ5vNeflDrm3URcyPHz1fxtCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3PNG7IeHMMlgM9JI3tNJpb+9998oEER5lKT8aWCJ+XacqO4zv4kLJoaOp29Mw/Hm0wu1CM8oL9wYBA0ta5f5iF0R6m5CX+Motzdt3Do5EOOcD+iDX9IA8fKmuvRxv9/dt4BYXQDCsGeCcVdlJLYp4wZ9CwDoVmrXXwjGJDnu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3IBMD2k/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=7cLn+uTVrMCvUz2MJDIzkGr2CsvjHgFvgJGssfOzYfw=; b=3IBMD2k/2sMKcn5C61EDNp/MxT
	+9Hp1m/BPM61rFjpe6p1Q0WdsGP005Z50Z8SsHT6oUYAn8oup6/AUgrWKOX9yDaYtOBe0RiV8H4xD
	w2LkMV/m1jjbXFqZPq7HW7pDuEsI8b57J+a2/I3D+aGlalF7DDUSf1d0VQIM+Wdq4tguvoy/9hiIy
	HfBTo9CadSdWszI9HD2ShAyZuej2Z69bs9XLFxUi8MUO7dqaAam9BwwX3TX1k34J5L1ez/nQ88y2w
	IWy8WLODM7d+wMyDNJALWBWLLmGbWFH+OQMtUgehJr81buquyLXV16V7uhPYuyOZadgmmiHfpFTQ3
	9K9va/AA==;
Received: from [2001:4bb8:2ae:8817:935:3eb8:759c:c417] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLIUB-0000000EIJ6-39m8;
	Wed, 11 Dec 2024 08:54:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: RFC: iomap patches for zoned XFS
Date: Wed, 11 Dec 2024 09:53:40 +0100
Message-ID: <20241211085420.1380396-1-hch@lst.de>
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

this series contains the iomap prep work to support zoned XFS.

The biggest changes are:

 - an option to reuse the ioend code for direct writes in addition to the
   current use for buffered writeback, which allows the file system to
   track completions on a per-bio basis instead of the current end_io
   callback which operates on the entire I/O.
   Note that it might make sense to split the ioend code from
   buffered-io.c into its own file with this.  Let me know what you think
   of that and I can include it in the next version
 - change of the writeback_ops so that the submit_bio call can be done by
   the file system.  Note that btrfs will also need this eventually when
   it starts using iomap
 - helpers to split ioend to the zone append queue_limits that plug
   into the previous item above.
 - a bunch of changes for slightly different merge conditions when using
   zone append.  Note that btrfs wants something similar also for
   compressed I/O, which might be able to share some code.  For now
   the flags use zone append naming, but we can change that if it gets
   used elsewhere.
 - passing private data to a few more helper

The XFS changes to use this will be posted to the xfs list only to not
spam fsdevel too much.

