Return-Path: <linux-fsdevel+bounces-39254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC6EA11E6D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD4E3A3265
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 09:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E22207DE7;
	Wed, 15 Jan 2025 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CL29udPt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D081E7C22;
	Wed, 15 Jan 2025 09:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934430; cv=none; b=IMOQJWwEwLcq9Utapm+F+f/Jawjnwh278+00A9SiKIz7QWHd2bLpeXG6sz8F8gFk8bo6Cd5OMIgBFn4vRNcdVmhBjPK7fzdP5TzTTz5cqpUGH8AVlgaUKGRLgZRi/O2lHZ1EiOy02M0nAznXitpmOlt657jmR7sHy5hEFbb7w4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934430; c=relaxed/simple;
	bh=wy+HWcPAIZ7m7ezduvV28i9TBdTDNzw0ADB5CFEEGTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V94CVH7ocwzY+E8TrUOn93whuOlCjQN6H8MxdXLwyIYO2Y4R6kQXWYRuT24gXH0cjaEf3NTEhDYH4mb6FAnpCxvRe8JTq7ZdFdb3dfAvc+DK0LoQ6muqzwyeXU9vtHwx++tP47zcNbOa7QTILLkavQ2v5IPrRue2p5fsIYjuwF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CL29udPt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jLQVkcSbqBBJ/uTGQd84Plp3t7x5dzC33gGhCpomRHo=; b=CL29udPt1/lIP4m0NjByfsQWZd
	bU3ta/e6R7VHcbH1UhF/H/q46vy2HYnBQxYDONpIrA3Lo8eLZ2Z2rTZW7gZBFjjmdFTl9Eu+T4J0a
	EtUh4FOKP9mw5+pIrIHRHOgnBN7H/wIiQcEKdSKEeoD9zqlkpwXAnDwAJhpHAswn9zI+sRValfnUQ
	AwWirdaHv3WEZsl0avZ4FWUWcY8OrvhgRHxMeeE50SVKpC6wW+8LmCjo0oCzFwxqQxGureXp04hww
	XCx7SOzY8vn989mxolOM7qh0utfkM6LjpEUneJ0OBgS0r4N3IcHroytPpvz7mth8c97BIMteQXsJx
	ln0GX48Q==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzN-0000000BOZp-30xr;
	Wed, 15 Jan 2025 09:47:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org,
	gfs2@lists.linux.dev
Subject: lockref cleanups
Date: Wed, 15 Jan 2025 10:46:36 +0100
Message-ID: <20250115094702.504610-1-hch@lst.de>
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

this series has a bunch of cosmetic cleanups for the lockref code I came up
with when reading the code in preparation of adding a new user of it.

Diffstat:
 fs/dcache.c             |    3 --
 fs/erofs/zdata.c        |    3 --
 fs/gfs2/quota.c         |    3 --
 include/linux/lockref.h |   26 ++++++++++++++------
 lib/lockref.c           |   60 ++++++++++++------------------------------------
 5 files changed, 36 insertions(+), 59 deletions(-)

