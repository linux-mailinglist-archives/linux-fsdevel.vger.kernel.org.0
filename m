Return-Path: <linux-fsdevel+bounces-27521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A533961DF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 07:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA2B1B22EF9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 05:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C30814B956;
	Wed, 28 Aug 2024 05:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X3HxUN3G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC8314A630;
	Wed, 28 Aug 2024 05:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724821920; cv=none; b=lDG7iCGQrhKZwAixlgg9r4ocT3ViVB7JUbn1Trq9FRr6g/Gtdf6RiIz0ZfTKjJQGJwQLdslEx4X77b+zyErJbx9K3WK4aqR7d2h3tAD0T3p/7ZdkHadEMLNHPF8GwjTF/QJ6fqeBTwe8Nncii4P9E2rhT/JKOYlEZAq4fwkOnfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724821920; c=relaxed/simple;
	bh=bdm0aOLyAz81WxxOGs3gd2CNrQr7fVLHYghOaVv/kJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itRyZkmJ6kUaYrPuCtF44ykiup2D2fL0ucfUWyMtSMLavoldq0f4mJigRi0E5r0AJSGSc223ELZk8ZJk3ThBK82dSA9eC5WGmwQAqq/OxFtPojvQYOzrUmCPnEkI3mp+pZrrVK3kmu6Nt6ZA23+zQTN8vy2LxyQua3Uv00Sylac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X3HxUN3G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=qSrOGe9vJINzdxtkitGbypmH6rCj1S+W6yy7xPpVUoU=; b=X3HxUN3G5AQjNd4nruMAMvMJoV
	QVcBtF1VxfYhH2aCiOyzjGwmKI3MB6O9yfeATurSVzgs6siJEU9RKbXJG8eYVPLKdTIaT8TG8W8UU
	0EPjbk52n7fZIjattgXlSkWQ834pUD5JaC7W6552Vq4WdhCrlTWvJrK4WJljGvd3b3gl2fxWYZ5Mz
	f7hRxeNwu5XK7Yi02li2+uMqKoQtx0ioB17f2aZj23D8NbZjQoGY9AYmANwym8LmX27bfJMm8JakZ
	vMLoJbvTEH0h8wvQpdLJRdFyu24i67SAj9qrESC+MnnH8wyCeTpCDTKgU7EHKTgfrlMFGOwIgI1Uq
	6/yocsEw==;
Received: from ppp-2-84-49-240.home.otenet.gr ([2.84.49.240] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjAyK-0000000DsCP-08Ei;
	Wed, 28 Aug 2024 05:11:56 +0000
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
Subject: RFC: add STATX_DIO_READ_ALIGN
Date: Wed, 28 Aug 2024 08:11:00 +0300
Message-ID: <20240828051149.1897291-1-hch@lst.de>
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

file systems that write out of place usually require different alignment
for direct I/O writes than what they can do for reads.  This series tries
to address this by yet another statx field.

Note that the code is completely untested - I wrote it and got preempted
and only sent this out because Hongbo Li brought the issue up in the
nilfs2 context.  I've just started a vacation so I'm unlikely to get
back to it any time soon, but if someone wants to take the work over
go for it.  I'll probably answer to email at least every other day or
so.

Diffstat:
 fs/stat.c                 |    1 
 fs/xfs/xfs_iops.c         |   37 +++++++++++++----
 include/linux/stat.h      |    1 
 include/uapi/linux/stat.h |   99 ++++++++++++++++++++++++++++++++++------------
 4 files changed, 106 insertions(+), 32 deletions(-)

