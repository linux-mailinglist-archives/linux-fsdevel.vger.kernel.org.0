Return-Path: <linux-fsdevel+bounces-39465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC0CA14A8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 08:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A26316B03D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 07:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD781F8680;
	Fri, 17 Jan 2025 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vJiz8AY3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC4A1F5619;
	Fri, 17 Jan 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100701; cv=none; b=WxLnd7WB2zrCFXccwBJRTXli4yhRA6OlxPqwvAR/9sWfgUUiDAbhboTHu9lOQ7xBKUXNuNYPyltXT23559ipZc9PWjMnfHGitP2/SdoIWxEQ5dgu1LFbpRGkqFfzGTH1E4NLQ8p4V4mbWDpQkYhFvXoiBjgKpSeD1ZWKjkBm/Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100701; c=relaxed/simple;
	bh=wgAhS86ukCZP5I1u9ln4lS/rgMNaudnTaX59WdkOVrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ms1f38Zt4rfvzI4EjKWvdZmDSpcVQZIDcXGkdxiiaZlz8zKrouVKkRxoyB4VczScENxIxvyH/P4Ov+Q4A9onbsDDsacYZFm7pbJ0VxKasCaMRcSyTqH1HydELE7c+L909cczba3MQs1M1MU5xa6v15FD9HrZ2SZBxVuvld1KR/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vJiz8AY3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LQ42ND+TX3qpDyiAWyJ76CfupWCuVxganJhxdwzevX0=; b=vJiz8AY34X+KOCo0spNITWZaj4
	nyqSeLwMHApV3IHW2rf1+oZmz4wulZukRDDfC57q4xe8ZAEdCPId6LmWtB5zHDCkM0zV3wja5zdZG
	3ulpxzRWjwvJ5EQ2GxsNiZO9j3q9F+bACioDK3njoL2Gq0wo7ZIvSepj0Y2BYx9Xdh7wm0+lhE6xi
	I58ckZ8qXgVy8KiD8VjwXqlOnKLvYY6a/T/5KT+RrrTQWDA38DQaXm3mis9s6BTUJUS7bPbRXxwyl
	6J6WRy/82HDyHmHVVYBlxqN0j/XgcxZgrv10iOMJkpBWgRdIyz4XpYwT4B0Wnu78TafHiQXKRDvdY
	V1FlrTIw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYhFE-0000000HGTr-04Lm;
	Fri, 17 Jan 2025 07:58:20 +0000
Date: Thu, 16 Jan 2025 23:58:19 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2 v5] add ioctl/sysfs to donate file-backed pages
Message-ID: <Z4oNmx2xPkdzvkUd@infradead.org>
References: <20250116172438.2143971-1-jaegeuk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116172438.2143971-1-jaegeuk@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Still NAC for sneaking in an almost undocumented MM feature into
a file system ioctl.  Especially while a discussion on that is still
ongoin.

And it's still bad that you don't even bother to Cc fsdevel on this,
nor linux-api or in this case the mm list.

On Thu, Jan 16, 2025 at 05:19:42PM +0000, Jaegeuk Kim wrote:
> If users clearly know which file-backed pages to reclaim in system view, they
> can use this ioctl() to register in advance and reclaim all at once later.
> 
> Change log from v4:
>  - fix range handling
> 
> Change log from v3:
>  - cover partial range
> 
> Change log from v2:
>  - add more boundary checks
>  - de-register the range, if len is zero
> 
> Jaegeuk Kim (1):
>   f2fs: add a sysfs entry to request donate file-backed pages
> 
> Yi Sun (1):
>   f2fs: Optimize f2fs_truncate_data_blocks_range()
> 
>  Documentation/ABI/testing/sysfs-fs-f2fs |  7 ++++++
>  fs/f2fs/f2fs.h                          |  2 ++
>  fs/f2fs/file.c                          | 29 +++++++++++++++++++++----
>  fs/f2fs/shrinker.c                      | 27 +++++++++++++++++++++++
>  fs/f2fs/sysfs.c                         |  8 +++++++
>  5 files changed, 69 insertions(+), 4 deletions(-)
> 
> -- 
> 2.48.0.rc2.279.g1de40edade-goog
> 
> 
---end quoted text---

