Return-Path: <linux-fsdevel+bounces-45889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B21A7E27C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A9117C571
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB171EB5C7;
	Mon,  7 Apr 2025 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MAAdWa+k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E211DE89D;
	Mon,  7 Apr 2025 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036592; cv=none; b=Ul8XmbIARLlX4KgsOfmzG6h3yxZ7aeo+e1ZyuzAnju8OfqSo08oUG0l7PyCO21VO1JTq48R0RnRqrRE/n517/jR8s3oHt3ekkAD7OwgxWM/26EI8HJz4T15CXqJID9jZmcSdcrDjhCgXEzPeXp5ZP9ZSR6FAXgjFZHnQhC1RBEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036592; c=relaxed/simple;
	bh=7xiJTEweFLfoUOH3n0QuucL/lSawmEY7i03g6M6p1I8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWqUs4WP6HqIEMpdeqj5uvrhFozRUWvun57YvhtwA3ag8l8aC5jrGMd2ZXZvSzISlzhQpkJ311llINJksM/cudPiN9d4KNLiisVBRadPoCFWSuofp1ki2DziPd7VTL4bfQXDQ2i4Nk35UobJxVLrVhCH/ZcyNNMFl7QjNd6a2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MAAdWa+k; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7xiJTEweFLfoUOH3n0QuucL/lSawmEY7i03g6M6p1I8=; b=MAAdWa+kdI3bGjwT/oLdVUEfrZ
	xXu4XYtmeBbHxZRVdAgiTgm5V6QBsYEFjq/NXoTzYzr4Z05Oo40VbgU2lTWql0VeHftOBScwLi9Fn
	GrNCnWH20L2CZ5LMJO0sjcHqkSXVYyOaJLV+IwiN0mJSCyn25AAgcao+kWMg7CrcQjDMOJg5jqXbC
	ltatyEnPj3noF47KP7XutcTSY3G/rEXCpU4cy08RQUKjPX3DCXrfZiUr/e8YiSiQtKXRStgWs6qNR
	Q6quDO7u+Z6V7utTSxmDSY2WfkpCHgdfhFqXUZYuzG3u0jGg2V308X3Vra8gDrvlGG8UKi7tJIGqW
	spoF61qA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1naP-00000000l42-3JJg;
	Mon, 07 Apr 2025 14:36:29 +0000
Date: Mon, 7 Apr 2025 07:36:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3 v3] fs: make generic_fillattr() tail-callable and
 utilize it in ext2/ext4
Message-ID: <Z_Pi7er_OV0auZ2d@infradead.org>
References: <20250406235806.1637000-1-mjguzik@gmail.com>
 <20250406235806.1637000-3-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250406235806.1637000-3-mjguzik@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Apr 07, 2025 at 01:58:06AM +0200, Mateusz Guzik wrote:
> Unfortunately the other filesystems I checked make adjustments after
> their own call to generic_fillattr() and consequently can't benefit.

Still a bad idea for all the reason state in reply to v2, and still
lacks any justification in the commit log.


