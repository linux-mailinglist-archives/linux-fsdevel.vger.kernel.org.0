Return-Path: <linux-fsdevel+bounces-27312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6E396025C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 08:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FC42856BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 06:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FD214F126;
	Tue, 27 Aug 2024 06:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wy7vG6Xq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC333A1C4;
	Tue, 27 Aug 2024 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741492; cv=none; b=rtM93CTwBAT2cftlMOVs0MBNfA1TP9v/ACmTYVzhJWjDZ169l7h8dWC3NhKFwJiGhtkQdHNS7UQ2c+xMtOn6YII6dOIckvQLkoc9gCrDq1oLtJMrJbOoJBjNYSLvRFIAFTj2tq96OeKNiSMVEVq/GvjvtWE/orpQaaUBD4POYV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741492; c=relaxed/simple;
	bh=D2TV5kBY7UZXY+Lwn+hOQcL9j6rqj76riA0ZNX5yNU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nelBf5mQW3f9SmLc/4q6dhDf1tm5H8fEe+Pqm1u1gHtIRJqDpXPXlbxN6eK5FsaPjwXNSdW+F/LvRYOW/R2rmxgmAGI0IKP8nJ9LiHx6yS0lKV26JW5u4rVbSOGDstO0HQj9Qv+2yrbMNnV4XiCy/QnVAjDHcrB3iOW/GSJgfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wy7vG6Xq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=D2TV5kBY7UZXY+Lwn+hOQcL9j6rqj76riA0ZNX5yNU0=; b=wy7vG6XqoqCg7oRND/piAuTP6Q
	CRgxtyhNB2Su+PN+jmXlwsjyEo6qKzy2KN4XJBHXi4wvJyxR6gE0gtV7f1s1oiv9z18rTXwY2Jtfd
	vsDNUAmCLwhOOuX/seEfcxVzZaV1bNWDh803ahb4QU5RbSmFFFzeZDhyabrRHc3YH7tk/oRTISNxu
	UOL4/6ujIO2ppcR5Oc10B6FnFyoHKAeEvp1F3wfM+A8VM9E+KB4KVP+v5A1jGEimv8F+n4wkwda2z
	/oEyAap1cmVLNfPP0q5E3BXuRxpZDHwrHeB7ZHooP+7D16TstLf2X5kB9nWxikiMp82IwH/6PTahD
	aUdcczjw==;
Received: from 2a02-8389-2341-5b80-0483-5781-2c2b-8fb4.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:483:5781:2c2b:8fb4] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siq35-0000000A68r-0GPh;
	Tue, 27 Aug 2024 06:51:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chandan Babu R <chandan.babu@oracle.com>
Cc: Brian Foster <bfoster@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: sort out the fallocate mode mess v2
Date: Tue, 27 Aug 2024 08:50:44 +0200
Message-ID: <20240827065123.1762168-1-hch@lst.de>
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

Changes since v1:
 - fix the IS_APPEND check
 - ensure space is allocated after unshare

