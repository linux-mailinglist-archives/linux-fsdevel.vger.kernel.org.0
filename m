Return-Path: <linux-fsdevel+bounces-35571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9299D5ED2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 13:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7025CB231F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9ADA1DE3AD;
	Fri, 22 Nov 2024 12:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3U62HNcr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE52AE96
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Nov 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732278579; cv=none; b=haE1gKDOj8krwUQLl85RrsA60wT/TRI7mAbMRtWXiRJvylWjx780b4YGccHmhf889MB3lGSllVTTLCDxqJRNSOdZ2nsjSrc8UEbumVukMZJdeiJ7T8Zk3ztb2f8Ni+1BDgQnTf1n+Ymb2lIhQHD+MB4c3cA3bsIXbkawS2lukEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732278579; c=relaxed/simple;
	bh=slACuBR9p7WOAAQHd0TnczDSYTj1aLZM+9+Cd8ulmfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0lYfR8t6g+7HTwc9m3/8iruEp7TuMt2IWyEDYWySFP0jBHRLhmdPU089cQTVB+IINgr3teYszTgckjhANl/58eSjEilEKMgtzF7ihHRVj6GlNaYW0hQHpMEY1mJnw6RcvaHZEYF1PCzH1CLmA2/vygF0VPr5KYLAsUbZRDnKXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3U62HNcr; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=XV3nHWXbZse+o85K9l1Dh301Ivr7IKD5f4jS2/wT/GQ=; b=3U62HNcrt6YUUXqm3MBOuAH2tV
	McSk3N8KzrcJMUXX9MZfJCYezmNbh9ZG9U0PCbg5lx/0R+FIzgn613iE0pF6leCFJs5XaXB5cEhpn
	DIBM3s4OJy1Tx3U2chmNbjvwVweCcuwYtuwWOklZCESOEejSMblB6OzVP9Kn4BQD/B9zaIoulcxU/
	mbS7aWEanDbkZo/JpVtUqFGT0UgDabboQMuCGeFOX8KkNOEzf5ZD2w3K3GQRi/3d9a80Ox5g6vTGL
	7K01jpJIIPUuU8pie8wcjmHtahZ6PqXFnVKvH+sS99w8nVtx/9mYFAHwIJVGzRnowpg7EDXuQTUX1
	wiRzL3Cw==;
Received: from 2a02-8389-2341-5b80-6215-0232-ff10-500c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:6215:232:ff10:500c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tESn1-00000002SEi-0wZv;
	Fri, 22 Nov 2024 12:29:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: 
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	linux-fsdevel@vger.kernel.org
Subject: permission checking for F_SET_RW_HINT
Date: Fri, 22 Nov 2024 13:29:23 +0100
Message-ID: <20241122122931.90408-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all

I've been expanding test coverage for F_SET_RW_HINT, and noticed that
right now there is no permission checking whatsoever.  Patch 1 fixes that
by requiring the owner or capable to set the write hint.  Patch 2 also
requires an fd open for write, which is a bit more arguable but still
feels right.

Diffstat:
 fcntl.c |    5 +++++
 1 file changed, 5 insertions(+)

