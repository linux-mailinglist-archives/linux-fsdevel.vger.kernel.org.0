Return-Path: <linux-fsdevel+bounces-31299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4E8994475
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 11:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316F11F25894
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 09:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A3D18C00D;
	Tue,  8 Oct 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="buvISG00"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB55F42A9F;
	Tue,  8 Oct 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728380349; cv=none; b=izwxUKZ9tpAVaU7MDw+PRI7VQpuJoMGzQw9nai/c/IXjBFz8W5QtAPT6GzSNF5FaqrCFdgfSjObrT8O8xzLQyafjnJcjBBixy0GkdTbssbUlgBu1xzc2D5FePV1nNxSlGKqFFJ2bXPR/ub5OMAULg6oKMLf5h48iR7xfNj0n7Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728380349; c=relaxed/simple;
	bh=Wz8kTljSILuTYZOl5bM/xW/73KrGlZD7xjnmRVvn0S4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li6yI4sRUkp6XsVtaUkqi6YwYTkLYc/ODcixb70DaPEW3/I7FOjmPuLxyn7X7oEke/D+u5/67M7Yp2WaU5REc4A8XmtD/CvVfvEn1O8+qKeXeWm/Abjw1VFU2sb2DmTsXGjDRZlIz6rCEg8rKWwWbe8AelolmTtLZfN1xaEvyfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=buvISG00; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Wz8kTljSILuTYZOl5bM/xW/73KrGlZD7xjnmRVvn0S4=; b=buvISG00YXgIanP2As416hs6G0
	L5NRfu8a9vc1c/LG6gM3X7Zg5xfW3FONiXGyf+pBwE5UOxcv6I8inJ3TZrc8yhanIDXgE0HkM01ND
	bIpxboEAVEq3ms68Ob47ujrRN0hmjfR3Xia1n5AhFxPBsEUREa0qGDOV2VlXkOEAiENTBlKCfATsZ
	U5jpZwxORc2J0YKGZ3hOIWXCBAeNhrvR9zO27xKl/gSumD3FSswwYCBFAfUKXOk45lKutQGY0fgTi
	3sGUOfaaWnCQ3lkBm+poWv7nEGK5cvm33IveyQPSBoWOhikQHcoc//Waz7HLQ8J56tByCRcZb6Pm0
	+U+RoFmw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sy6gN-00000005KuZ-2Tk8;
	Tue, 08 Oct 2024 09:39:07 +0000
Date: Tue, 8 Oct 2024 02:39:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 00/12] btrfs reads through iomap
Message-ID: <ZwT9u9Aox11sny_-@infradead.org>
References: <cover.1728071257.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728071257.git.rgoldwyn@suse.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Please also add the linux-xfs list per the MAINTAINERS file,
I only noticed this now because I'm a little behind on my fsdevel
mailbox.


