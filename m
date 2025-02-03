Return-Path: <linux-fsdevel+bounces-40578-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13E7A25611
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 10:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71345165B64
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 09:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C391FFC54;
	Mon,  3 Feb 2025 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cybf6Fm0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2551D798E;
	Mon,  3 Feb 2025 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738575810; cv=none; b=JVYn0WLV9bzy3l8uLM5TkyKJ93pur1ebmO+cjuOWSMimNBvQCme8IxowU62N52tM7kTB4c1onZPrsBYmTZXxjLwB/bblzmiWy3O3V/xxoizF873cdabYjVUyRQXITC3ZSfg8hTAxPVw1LZfeLz8lI2cKLZkN7DIAAvYg+R2uUaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738575810; c=relaxed/simple;
	bh=d5dY980y6eK/R+y1YcCGzlDtYoeQoPLVt60LO6V+l3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X1AidsElPI/tBAS1IwhM6PJ7vgEgOYKPYXkzkygYMiHSc4reAUWjxdxu6f3AahT02oD4aoZxBP2s4ynitRgizXBMABgGSETcQ27/B/+ODiZPHsI2gd7OsIqK3RVeFhOiat5RHKr9sLjFSa0WK4/gloeSV5lWl2Ges9HQpcwivzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cybf6Fm0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dDdMPMOHiydJcOazDXKDrMW9Qwj8NeVaCW081hdBtCU=; b=cybf6Fm0kj5CvOgbKqUrlmVP/E
	x1TWrhU2SIkp4xBZhOgruEyVvlhvQ7kYjzx8o4ppRtSrOctb2HxswptO8HWC1ltPGRMWVNcVqDIbc
	Lg6lrKJZ2vZfUxDVSX1zg8BWkQTqGD1mUmR11dESx3s4NYDwgJTJWX7HUjzY6WmMacVs/kOLx+NY1
	u7Jis1+Wfoc+twhAEk1kyC6JATslIluHCEFvpTrXlVyufVOvOaFiM+8jQQwwPzDgpTSEXPdR6Sf/U
	mTPjGxHaImOE/0QUphAIwxgP07xEjYPCCRbnDjecuxKDGeQqCLH0JM+gm9eUdf9GFlnoY9aaHg64O
	smjFVhOA==;
Received: from 2a02-8389-2341-5b80-b79f-eb9e-0b40-3aae.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:b79f:eb9e:b40:3aae] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1teszF-0000000F1fJ-2TQc;
	Mon, 03 Feb 2025 09:43:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <wqu@suse.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: PI and data checksumming for XFS
Date: Mon,  3 Feb 2025 10:43:04 +0100
Message-ID: <20250203094322.1809766-1-hch@lst.de>
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

with all the PI and checksumming discussions I decided to dust of my old
XFS PI and data checksumming prototypes.  This is pre-alpha code so
handle it with care.  I tried to document most issues and limitations
in the patch, but I might have missed some.  It survives an xfstests
quick run with just three failures, one of which is a pre-existing
failure on a PI disable device when creating dm-thin.

As it depends on various other in-flight patch series anyone
daring to it should use the git branch here:

    git://git.infradead.org/users/hch/misc.git xfs-data-crc

instead.

