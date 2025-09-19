Return-Path: <linux-fsdevel+bounces-62237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C00DB8A506
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 17:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98151B6226D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 15:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00EE3168E6;
	Fri, 19 Sep 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nFgQA8nL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03FC23182D;
	Fri, 19 Sep 2025 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758295963; cv=none; b=f94a1qaCQEt35Oc7IkqUgeI922ykHWrZRi5DRjtzVgpF16ugLWU+hWYRG4CNEKcycVK3O3L8kA5WYhDv1zuUAMVg71cyLVPrtWHYORrO+kQYTao8YzjSG/Bmbb4UPNpzh2kamK0qI4UlwlbPcs3HVR91imbL+sgEB0yuw5lZDx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758295963; c=relaxed/simple;
	bh=C99O4ls4PTPo4vxHxEMUXdtACbgH4cFrME1yQYWKheo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSZtVdHKXB5tovCcz9U8rvo4yUvSyIF1vFyS4b9qUPF8eIl+khfnKBIWodTrb9HJtFOOEVPOuaRcvHUPlkLBSKe4OHU4vqkMt8woRmp99E1Ia9GyjCNoo+5h7hLu/VlIDgX7R6y9o3na1a8X8TAKcahWCS/h/0HaLBmjrmEF+2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nFgQA8nL; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HHdwDSnD5PcX9xrb6CZ8x3E5Svav04VAhr3uk49K4dk=; b=nFgQA8nLHeqdXRoQ24h+OvZczK
	kNx7ahX/75NRuAGG6OgfoK++HN2z9hLcXWkXydmDdI7quyxysEdGEwbUJHZCg6kty7kX8tjZ/V8YR
	ZCpwNLd6v8Z2nve/ulcn2i4SNeMpYMuvnYPi8aBW4FRLu0bgGHZztmtHwg83YeQCdCcaRjwWBAmDX
	iHABrAJ25tQAdpp0OJtA0TWoZIJGq3D2EmPhWOMosFM6qn3nwk6tu5suwPa/8A2J660W3o/hxRnir
	9doSG+iwx9W95QPYzvjJvkLEWQtXIK66Ou6lvqk6P52mj9ICyX4wfyVW9O1z+ai5Cn28yTvxapEOn
	oLcj8r9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzd6H-00000003LZn-07Qa;
	Fri, 19 Sep 2025 15:32:41 +0000
Date: Fri, 19 Sep 2025 08:32:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 11/15] iomap: move buffered io bio logic into new file
Message-ID: <aM13mbqfJQ6FNda5@infradead.org>
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-12-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916234425.1274735-12-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Sep 16, 2025 at 04:44:21PM -0700, Joanne Koong wrote:
> Move bio logic in the buffered io code into its own file and remove
> CONFIG_BLOCK gating for iomap read/readahead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

If you want to add my signoff as the first one it also needs me as
the From: line.  I don't really care either way, we just need to be
consistent.


