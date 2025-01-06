Return-Path: <linux-fsdevel+bounces-38435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FD3A028E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 16:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4BD01885416
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04FC158853;
	Mon,  6 Jan 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GQUA4Usw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768E4136326;
	Mon,  6 Jan 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176578; cv=none; b=jxiFF5gIQ40Yckl0UArXW3YHNIuwsXwY3UKJrFDLxpt9IMbEFmpl2+V/INiczI2EOu5Rqj0moVLEZ7yHiL+WCo/3BAVHB5c3/Gd2P75VbcnfV3+rLBD+ArirIwgSTvz/OvAvu66OslqoSpHcvXyNCep7aJ3NCJLlMwdWplYOW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176578; c=relaxed/simple;
	bh=HOnizWLZAhy/wkB+o9qiK1H9iSrRkEDBHT7WZlAI8S8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1R+2ajvoylMQzRiSPKJxcSmZovKaL1G60SLMwg2ZEwGPUcwPNf9eoH19Tnl3LqmscuzYWwENHRal/3qxO6HHeoPDqjq32MMCKn5Q8XI5eNBolhJsfalqtfNSByWbgZAFFdUbyBOpprLRbc7Xn5a/ivqIhzl9prG/bDxeMLA3Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GQUA4Usw; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jy8o97NScLsr8D+JTV/npG7c5ZKkdETvzkEgkO/6CGw=; b=GQUA4Usw7tyLD3rYsWTB6BuU0X
	PpzDBYo19qJJm8A9KnBxAWW3kb0tu9cP+o4TOiJ29Rf6Npa0JZKolRWwiYbLC459eu0uQnzEb3Nro
	a8YyP+pVAL+xUCN52UK5pg4oLlnU9zO/yjzCADLvL37jwwuLuSPwlnwdU4udjRsui3CCdWtSCXJUq
	Hy8bRAjUHrt7VpLvt0bB30K8QBktlC6g3lMLnTImlKAmWVoNEBKSV4yVRilBT/YjQfnoieMG8YXwX
	GBlZWiYMmfSCGldu1l6Ep1iHoDbbtT2gQL8aL6iQkRvrM9TyDeEtSZ2TNaEu4HULwbavonuHM1iGz
	zbVGGKgg==;
Received: from 2a02-8389-2341-5b80-db6b-99e8-3feb-3b4e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:db6b:99e8:3feb:3b4e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tUopv-00000001isR-2vPZ;
	Mon, 06 Jan 2025 15:16:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hongbo Li <lihongbo22@huawei.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: add STATX_DIO_READ_ALIGN
Date: Mon,  6 Jan 2025 16:15:53 +0100
Message-ID: <20250106151607.954940-1-hch@lst.de>
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

file systems that write out of place usually require different alignment
for direct I/O writes than what they can do for reads.  This series tries
to address this by yet another statx field.

Note that the code is completely untested - I wrote it and got preempted
and only sent this out because Hongbo Li brought the issue up in the
nilfs2 context.  I've just started a vacation so I'm unlikely to get
back to it any time soon, but if someone wants to take the work over
go for it.  I'll probably answer to email at least every other day or
so.

Changes from RFC:
 - add a cleanup patch for xfs_vn_getattr
 - use xfs_inode_alloc_unitsize in xfs_vn_getattr
 - improve a comment in XFS

Diffstat:
 fs/stat.c                 |    1 
 fs/xfs/xfs_iops.c         |   65 +++++++++++++++++++-----------
 include/linux/stat.h      |    1 
 include/uapi/linux/stat.h |   99 ++++++++++++++++++++++++++++++++++------------
 4 files changed, 118 insertions(+), 48 deletions(-)

