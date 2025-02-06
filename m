Return-Path: <linux-fsdevel+bounces-41025-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF790A2A10C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 07:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81A41886DCE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D4D224AE3;
	Thu,  6 Feb 2025 06:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ibRLd+kh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB92248AC;
	Thu,  6 Feb 2025 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738824039; cv=none; b=te1RPEDX37tdoRzJc4m3agEZumGK2+5vnGpNywpmDPQEJ4Tz0vv4LyWy8k4kZfX7VGbpUP9iSshOBr/ilskkheYcpMn5SzmEc2dY1l7PkkvYURwMdOINSco5xfFjIUv3drrso4e3NENMnarGQWlm+ArNKr3UuZdjMln8wzPHtO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738824039; c=relaxed/simple;
	bh=74Rr1oIplbU83LZA9Gcg1xAxDysea7bcy/RWYMqaDg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LWtoTMV3dANutESg2mlVtYRDTkNP9nKW2faNxwedRjPXwsC6P8k6dCo7k9UgIgu+AKVfwH0skM2gQ5AnMOKGn4C2z/yMaq9j13QEGJ9nTTU0rzzt6pyAQUnRYvIV/To/tdiXfeic78ILU3vYL1yd1yJmqgDqhRh0dxFFKb/HwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ibRLd+kh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Vc1Hsp20/DNUIs8LVaLM65OyL1rzwo8WSVa1uKHS9wM=; b=ibRLd+kh53UDd5dDdsmC/v3a5h
	fxIMYPio74r6i1EbkVSJRXRxC9X1Z0lkfhvdGM3+2HIcIoc1+lL3h1uZsn56s99uiW8LAi3AIjmvV
	H7bYJZDWYSEiFBDe2sWQtAXcpSRtokKNbH4L+Ro+BLfRaAEY/bKqsY9sqbXlZO7uN7PtCb6vDYk6s
	ftmFrJGKo0xpF/Zar/4bTx/90QrqSN9fTKshm0cTiP17hMEMY5JqPiUTOIFAoOLVMVuILkiOFCyPh
	5S3gY5qq6mSIsc3/mJnIBvivGMuhir774gHQQBHw9Wg1X9AZIIAF/eumDeOalLsjF+lRoKR7XSyA/
	v+m41VcQ==;
Received: from 2a02-8389-2341-5b80-9d5d-e9d2-4927-2bd6.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9d5d:e9d2:4927:2bd6] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tfvYz-00000005PRD-0lu9;
	Thu, 06 Feb 2025 06:40:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: iomap patches for zoned XFS v2
Date: Thu,  6 Feb 2025 07:39:58 +0100
Message-ID: <20250206064035.2323428-1-hch@lst.de>
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
 - a new ANON_WRITE flags for writes that don't have a block number
   assigned to them at the iomap level, leaving the file system to do
   that work in the submission handler.  Note that btrfs wants something
   similar also for compressed I/O, which should be able to reuse this,
   maybe with minor tweaks.
 - passing private data to a few more helper

The XFS changes to use this will be posted to the xfs list only to not
spam fsdevel too much.

Changes since v1:
 - spelling fixes
 - more comments
 - add a new io_private member to struct iomap_ioend

Changes since RFC:
 - update Documentation/filesystems/iomap/
 - improve comments
 - make the iomap_split_ioend calling convention simpler and hopefully
   more cleasr
 - propagate bio_split errors
 - rename the flags argument to iomap_init_ioend
 - move more code to fs/iomap/ioend.c
 - refactor the ioend completion code a bit
 - replace the ZONE_APPEND flag with an ANON_WRITE flag

