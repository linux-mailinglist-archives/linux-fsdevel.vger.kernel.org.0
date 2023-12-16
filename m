Return-Path: <linux-fsdevel+bounces-6242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DFC8155D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 02:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231051C23387
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 01:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D323D1100;
	Sat, 16 Dec 2023 01:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uftjT5jG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D845187B
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Dec 2023 01:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=JRzv9TUa+PNLva3DsR7EBE5y5Uie+bx4+iivXY7GV6k=; b=uftjT5jGU43CQOr3Y8HMh0uR6L
	KTuTi7L2r5sbTOk4xoAuJZ0N5qOZx8QBzJjXTPAT46uWnbvOSb+UCzPTStScuQLquhlpYvhvH68n3
	a4ZlTjatb8p3p/HxlX1bXMG0iFXmPy7185iN5UsCGbh6eyxcL8z3wy/LtPSSFIAX4AV/k8Q1WLhvR
	KFnin9GYPq8qndlnoy9WQf0N9biNMAPAjRHEWhcxxV3TCJWDcTcgZE+hHfNIqHlblo+exLFe2NmGE
	trUyEUJFwwpCUerKNPV2ihtayQn5e8e2We9XMEeoEP9BRzbhOsiqlMusfH5CfpHT4Sko2e0QMMST3
	g7Sbnl2A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rEJ7u-0054wM-No; Sat, 16 Dec 2023 01:05:58 +0000
Date: Sat, 16 Dec 2023 01:05:58 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org
Subject: Why doesn't FUSE use stable writes?
Message-ID: <ZXz39r4SR39DmPcW@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


I'm looking at fuse_writepage_locked() and it allocates a new page, then
copies from the page cache into that page before sending that page to
userspace.  I imagine you want to prevent torn writes, so why not set
SB_I_STABLE_WRITES instead of having this memcpy?

