Return-Path: <linux-fsdevel+bounces-50457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087D4ACC738
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E261169D0B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629AE230BC6;
	Tue,  3 Jun 2025 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IPmsxnFJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C439130100;
	Tue,  3 Jun 2025 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748955659; cv=none; b=c8m3+icGzDnIYmZhXIEbzzluyF4d4gr3gamGj6/pFB2W4Kxi16A5CwPfURQatHsI5EVDejor3LaP+4BNBlos0CNIpN7m5bzCHndfPveG4wAYouUDY5JvyWZiG+SMZn08td5u/6AjnTITpCgg54fHSpVadkNqrHCF72mryPVvP9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748955659; c=relaxed/simple;
	bh=jCb8MjzKqnSSvBISyPEr68pWSxze6cYxQdDQYeMGOwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDK28Rz5h9NVXg//jqCaxfOBqosDV9CAyX7Dhns5RhtBRYxQiYh2H31a82mXkESUnTjoKvG4u2+wS1Tr6EpAUzGj3fYw3VzOL63X0+xIO7fe/PBho20t+mSHpDzxCbhjxbg8Cu5HxyciUqx0RUwn0a6huwT3QsP9zL4mN7xiXqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IPmsxnFJ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k1XPNptp9fZRgF5DPHVBqQdEmjS4I5KaqBv2b545vMo=; b=IPmsxnFJvpQV/07pXtCij5n7+B
	dFvjHtMPi4nMCn+YxfA9D4q9Mo8YX4qbhw9zesK8Ye1oTQFfXOQZ/IA9OTm0ofT2D1sgqFw43T4hL
	t8XZQGHRymH3mU/lN+Upl0Igc/rCnrDLMNshOBwuZUtJ1LHLchLQtozjfj5mzVUeg8cD6mSy5Nh0p
	zbvkyHiVp/2iCP4XT81nCh1MtbWZzZ4rqlF4c2CZyQIU/QqowJP/EvfXW0UDpU8D3v8iVKN1pCE5A
	IYie6a2i83wKfvsj7leN7vjLIHruu6zzcxDvLTGGBgxgEYC3HBCEueUdJ/FNW7uw9voCx/Tgzd17j
	emTU48WA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMRG1-0000000Aypb-1Zk1;
	Tue, 03 Jun 2025 13:00:45 +0000
Date: Tue, 3 Jun 2025 06:00:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: wangtao <tao.wangtao@honor.com>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, kraxel@redhat.com,
	vivek.kasireddy@intel.com, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hughd@google.com, akpm@linux-foundation.org,
	amir73il@gmail.com, benjamin.gaignard@collabora.com,
	Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
	jack@suse.cz, baolin.wang@linux.alibaba.com,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	bintian.wang@honor.com, yipengxiang@honor.com, liulu.liu@honor.com,
	feng.han@honor.com
Subject: Re: [PATCH v4 0/4] Implement dmabuf direct I/O via copy_file_range
Message-ID: <aD7x_b0hVyvZDUsl@infradead.org>
References: <20250603095245.17478-1-tao.wangtao@honor.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603095245.17478-1-tao.wangtao@honor.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

This is a really weird interface.  No one has yet to explain why dmabuf
is so special that we can't support direct I/O to it when we can support
it to otherwise exotic mappings like PCI P2P ones.


