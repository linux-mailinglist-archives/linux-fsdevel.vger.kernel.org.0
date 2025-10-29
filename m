Return-Path: <linux-fsdevel+bounces-66187-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD2DC18A2D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 08:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1CF34032CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 07:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B907E225413;
	Wed, 29 Oct 2025 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="unOtjp34"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8BD2EAB6E;
	Wed, 29 Oct 2025 07:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761722148; cv=none; b=AaTZ0MG78HJG0hzpNZOjHp2c/+4OQC81M9ZwbExaxxQDdKHvjBglpO+mEevObLAJIZGdx52/i4rWFhxQZ8oD9V+f4bLRH7LXC963B/LYiGXrOY2hPyj6gXhbwF7a7np04STCjLIHlV460AAiCTfPmvFyOb4GdSLkP2aqrPZg+tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761722148; c=relaxed/simple;
	bh=yZKhiI7yW59VjaibrV8WlKczNrTXwgpVL1Hqfy0Ml6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fGwKRXQuCh7ocSItWjBPhGneN8HhcjnyMsqWlpMtwUmLTESyQWDUs/KBUDWFkHRxnXLQcYpzWVsXUSBCL5jMrLzBhWFf1G8WgrgpFuyOQBHfvTsNOe/TDi9RloizhVND6FjzrzQjVNATDJ705ErZbsk9ZYAaaLKt7z5M18IMUOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=unOtjp34; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=pGSdhEJSZvDrK3O/D2tpX+dSUnmxDXrzhVWJRnpdQbI=; b=unOtjp34uIMdQazWggIA/0P44g
	1X/NiBNImaua28Vln58j9HZMkWr0kD4Azw4124vEikj1/VIghjjLNq8xsRzO2c70F3ydlnwqBEZY0
	cA3bMQFuppHpoO2P9suKCMDDsOJ9wKsxShVJy1OsYrIr8s7C81+qNcVGkQuXh3Xyae10T9ExM0292
	OrHzIcAJ+Faj711UvqPM0kyPkyCwzYeT9KsUbYU5tUl5t7oOr0Be085bpa0Y3cPKsTcHJ4HHqRSvs
	8qxlBdrSn+HGHuCYiq/JwuJlmQvH+ZmlH5pGHcBsFkTFB1qsq/8mKJ3KnpEy5/womMC3nm/oIIBn/
	05Vl2C6A==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE0PG-000000002OV-3lCn;
	Wed, 29 Oct 2025 07:15:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: fall back from direct to buffered I/O when stable writes are required
Date: Wed, 29 Oct 2025 08:15:01 +0100
Message-ID: <20251029071537.1127397-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

we've had a long standing issue that direct I/O to and from devices that
require stable writes can corrupt data because the user memory can be
modified while in flight.  This series tries to address this by falling
back to uncached buffered I/O.  Given that this requires an extra copy it
is usually going to be a slow down, especially for very high bandwith
use cases, so I'm not exactly happy about.

I suspect we need a way to opt out of this for applications that know
what they are doing, and I can think of a few ways to do that:

1a) Allow a mount option to override the behavior

	This allows the sysadmin to get back to the previous state.
	This is fairly easy to implement, but the scope might be to wide.

1b) Sysfs attribute

	Same as above.  Slightly easier to modify, but a more unusual
	interface.

2) Have a per-inode attribute

	Allows to set it on a specific file.  Would require an on-disk
	format change for the usual attr options.

3) Have a fcntl or similar to allow an application to override it

	Fine granularity.  Requires application change.  We might not
	allow any application to force this as it could be used to inject
	corruption.

In other words, they are all kinda horrible.

Diffstat:
 fs/ext4/file.c      |    2 -
 fs/xfs/xfs_file.c   |   59 +++++++++++++++++++++++++++++++++++++++++++---------
 fs/xfs/xfs_iops.c   |    6 +++++
 include/linux/fs.h  |   11 +++++----
 io_uring/io_uring.c |    2 -
 5 files changed, 63 insertions(+), 17 deletions(-)

