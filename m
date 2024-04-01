Return-Path: <linux-fsdevel+bounces-15819-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE40893901
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 10:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C61421F217F5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 08:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0C8D2FF;
	Mon,  1 Apr 2024 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="Za5NdLbp";
	dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b="ywT6y1xD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77DFFBE9
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Apr 2024 08:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.207.88.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711960040; cv=none; b=VYlwXhwWSQUYtXVW9DFIQICQgvTsyrcFSH4qN3mAbSfDDO6tNp21XMJkNyBiqODqlYgTXoEpMDP7Jvug5C3fVkau9ay7NaTc6rSmC3KxkFbE9FvOJhfdeXuzzPHrPpCXq1CuDN0I5JvHAIotFy0EVjgtm0zbTkSkLbwRsLDecBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711960040; c=relaxed/simple;
	bh=42yS/Hl8DhVicMh3Mx7wIqtrQUL6cKQ2G3/Ih7s6GlU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CcQWAP+P/TRxakNBIxvVf6YRhb9eB1nG9Y4LBKt45fx54FkRnI9AZ6wwV3yKmUSAb/z24yyiLhrgGbZM+OgZdqRTDupcxsRyvKijYm86afpL/pejUz6N7b+wmtF8lhMBjVljoo3wEcjh9xATkvfYRMDj33GDypMHNwKTvlXeXy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com; spf=pass smtp.mailfrom=yadro.com; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=Za5NdLbp; dkim=pass (2048-bit key) header.d=yadro.com header.i=@yadro.com header.b=ywT6y1xD; arc=none smtp.client-ip=89.207.88.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadro.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com C8066C0002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1711960027; bh=iFloVsCl7+YRZmthwdB9aAbgO3cpKXH2CwYhLKWiIBs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Za5NdLbp8mEplznf/2y1ktjNQ/noRKYJWpxgUTdNpp6epeP27Raf9FdppxNfp4L/e
	 2Rle8EwHkKyj95VfwE8dsTYinbHBC3BjOvcjC+25JsDxCmO521PJdxblq+2Lo/H26E
	 OKTmDTrcgoTpdU5O/8xEQncxQjBi1yorYwefcIiIVw1YJ6vuIlF3/otk5w4xSWYy1u
	 bcI8QXg46m9tJ/RynikMbzcperpX77o5H8y1xTusyf4bvV89QfSAtFqoiLmDIVl2ub
	 ex4FxWlLr4urf7/jAcyyRDguD/+VLsaWrO3PNs8jWvYmUDz6Uyn5qqeOmcIlr+5Px2
	 sRbbjuT7nDOfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1711960027; bh=iFloVsCl7+YRZmthwdB9aAbgO3cpKXH2CwYhLKWiIBs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ywT6y1xDUWlpmP0ml328hZO4rNy7aTvH0FJYwvcNDt7jDg8th+u4Q6z5DCvlP/FJC
	 EFk1J8xYds3vg+cKlLRbwLrtxg6OpvP7NdXDjkDzqeTw+NQz6QYuFi/uOsLS+1vYTz
	 Zzla22tAd3uR+HWjXZvsduwiwtpeDKuskWUGAWtmLb42uEz0/oV2SbCxjXYXqUZdH3
	 KmLYQIjOTwfHl7osSJzvXxeMVMKs5IUJ31wwGP1CdTLIxSd4/hWARcN9orIEtbmgkI
	 Uzfzy9LsB51NIBqV3sJFMx2CUO6IJaHBqH6ClIBDTvTIeabdF6bCWcwP+4BjF0LQSi
	 TxjMfdOwKfdWg==
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>
CC: <linux-fsdevel@vger.kernel.org>, <linux@yadro.com>, Dmitry Bogdanov
	<d.bogdanov@yadro.com>
Subject: [PATCH 0/2] configfs: reduce memory consumption by symlinks
Date: Mon, 1 Apr 2024 11:26:53 +0300
Message-ID: <20240401082655.31613-1-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)

A SCSI target configuration of 2 ports, 650 backstores, 1200 ACLs consumes
170 GB RAM.
As it turned out that is because configfs allocates PAGE_SIZE for symlink
path. In PowerPC architecture a page is of 64 KB size and millions of
symlinks become hundreds of used GB.

This patch series reduses the usage of memory by symlinks in configfs to a
minimal possible amount - from of 64KB down to ~20 Bytes.


Dmitry Bogdanov (2):
  configfs: reduce memory consumption by symlinks
  configfs: make a minimal path of symlink

 fs/configfs/symlink.c | 75 ++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 29 deletions(-)

-- 
2.25.1


