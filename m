Return-Path: <linux-fsdevel+bounces-33865-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016AD9BFF04
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 08:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338ED1C21339
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 07:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF3E197548;
	Thu,  7 Nov 2024 07:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iGoTxZp9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62973194A64
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964403; cv=none; b=kbD9qRtWzFPrbkgpUYK1PV8uz+0Ik8NGM1+ELcxelUJpLsT7PjwD9i9CkfjaIZIzUo67gjbLPb/rVJiqLUgoMkWgv59VRy3G8NUij6pef9nZXhkIMftDXRvYd8DzrwcIpiJtSpKP3wiHXOVnscD76E7hF2jSdCZMsv/YdP0Y8F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964403; c=relaxed/simple;
	bh=07zHo3VRmADL3zQ37CXVSuQ+I1EfLxfAWw+8OsgAbt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQ4fvxVn1ihXcDmOo41jkRMJq7+V7d6eILmQD+co5bsywuE3ZK+89npkQc5niE+NdPJxpeByV7dqZbiayk7Oy2Ax8vNdpd0QpgRZWzEzNj+MrEy2HCGt+j/YCCABjjhIzOE/pHhO6wYfkkcpO0P9LfHMLBKUOmbKFRexqK5ud6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iGoTxZp9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Uelp1QtvPDrYmzQlf4E3YnyfEnqoq8t8SUGDUjl7bgw=; b=iGoTxZp92s6yzQc9fRiwlI1f33
	AZxjtiuFjaqitEVfRUIWGmDCz55mI5NypoQX5h+DQpZWpBCa+M3w9whMaa/Dr0VPPcXmM3lDTIQG8
	pscRGaOWD7t3iwUBrUdFHrqULS/yJHNyXLpCfgyNTxLCVmEyHjzSXh55siamRrnixJC9/YU53XLkB
	PggYdBiS5QoY/II5WwMML+/pSrjaB9D+DAHpHNDKaCwJOitAh7SKOQEjjN7C0Q9oCzIztaxpt+dqc
	g6w3GrfSd3B33ZAOSokYgopMA8x7gpfCMHztHdC4j8Awg9nVnlyNCyVyzOJs47CLpOafRjdS+lKxw
	0fGgLvIw==;
Received: from 213-147-165-243.nat.highway.webapn.at ([213.147.165.243] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t8wub-00000005z76-0JSs;
	Thu, 07 Nov 2024 07:26:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
Subject: two little writeback cleanups,
Date: Thu,  7 Nov 2024 07:26:17 +0000
Message-ID: <20241107072632.672795-1-hch@lst.de>
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

Diffstat:
 fs/fs-writeback.c         |   32 ++++++++++++++++++++++++++++----
 include/linux/writeback.h |   28 ++--------------------------
 2 files changed, 30 insertions(+), 30 deletions(-)

