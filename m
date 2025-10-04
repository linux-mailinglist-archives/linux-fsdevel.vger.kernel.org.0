Return-Path: <linux-fsdevel+bounces-63429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0405BB896E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 04 Oct 2025 06:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41CF19C358A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Oct 2025 04:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E6420298C;
	Sat,  4 Oct 2025 04:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V6Fhv3/P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BF1C2E0;
	Sat,  4 Oct 2025 04:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759552013; cv=none; b=EvPfTuUv2iZ24SpK7Pc9nuTj7Gce2nF0qzBrHPjzcYcw/kXebSsO1z4382iY13A4RL877ySX/IEY0Ri+1H7UjyU/lMZ7ibtKAH3nanax8SUroKAXioCABuzHRh8pDJDo3dAN6erKXCSv5bouHaQ+GDZ+vGzNQCXDPxGeZ2RF+qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759552013; c=relaxed/simple;
	bh=uILPRqJhMy7fWt3OsCdb6ZPe6JPwhZZa5v2gQXhmWiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hamC/ayb5X99MChVJmzGOt+5fXwaLX74IJLhNoNyfffp71YXL/TdjyHxHvrL05xNogODViRsBM2WPPfQFVtf2StLJls0lP0u9T77hYgHA+vLHlIkgY4W1Attt93xr9dHR/VaDK+Wkr2uaSY9f3DC5HOX0EnrPE/0DxHFxFAM0ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V6Fhv3/P; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h5jDZRPaN/sMtBt59YwcIKCH/2rUKbVLwKIWK3iryyw=; b=V6Fhv3/P8wMUzY3hBwpGNRmtw4
	SZuF3Dw6a6l2mBnGXKOqVoviIyYeCMuhMpbmbDrbVEly6K9LJK880SQjE7iZhrMD1pjfF4zh9tNSx
	APx41E+Joei4c7WFyeMB/RClpx7CW8fchT/rS55JwVGej0FQMmU33z0vcLGfohg3alnC337wF7Y8l
	XzxiBYg4sae3VAC8L9CD3gA9oMz2/4Jx/I7Ed0NYYNF9NiHPRE8YW9rY5X84nWstmle+vMBZLaC44
	CNeh2BVV9xctbuKHTzqIHHOLIDc6rHukiULDvjGtcjSZ3I9Fzi59SX+097lYlgo3WOPzI8Kj+iI0A
	kbw9McNg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4tr8-0000000DRu3-3PVu;
	Sat, 04 Oct 2025 04:26:50 +0000
Date: Fri, 3 Oct 2025 21:26:50 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Emelyanov <xemul@scylladb.com>
Cc: linux-fsdevel@vger.kernel.org,
	"Raphael S . Carvalho" <raphaelsc@scylladb.com>,
	linux-api@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing
 O_NOCMTIME
Message-ID: <aOCiCkFUOBWV_1yY@infradead.org>
References: <20251003093213.52624-1-xemul@scylladb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003093213.52624-1-xemul@scylladb.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 03, 2025 at 12:32:13PM +0300, Pavel Emelyanov wrote:
> The FMODE_NOCMTIME flag tells that ctime and mtime stamps are not
> updated on IO. The flag was introduced long ago by 4d4be482a4 ([XFS]
> add a FMODE flag to make XFS invisible I/O less hacky. Back then it
> was suggested that this flag is propagated to a O_NOCMTIME one.

skipping c/mtime is dangerous.  The XFS handle code allows it to
support HSM where data is migrated out to tape, and requires
CAP_SYS_ADMIN.  Allowing it for any file owner would expand the scope
for too much as now everyone could skip timestamp updates.

> It can be used by workloads that want to write a file but don't care
> much about the preciese timestamp on it and can update it later with
> utimens() call.

The workload might not care, the rest of the system does.  ctime can't
bet set to arbitrary values, so it is important for backups and as
an audit trail.

> There's another reason for having this patch. When performing AIO write,
> the file_modified_flags() function checks whether or not to update inode
> times. In case update is needed and iocb carries the RWF_NOWAIT flag,
> the check return EINTR error that quickly propagates into cb completion
> without doing any IO. This restriction effectively prevents doing AIO
> writes with nowait flag, as file modifications really imply time update.

Well, we'll need to look into that, including maybe non-blockin
timestamp updates.


