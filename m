Return-Path: <linux-fsdevel+bounces-61429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C5B581A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 18:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6C913BCE43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 16:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FEE23E354;
	Mon, 15 Sep 2025 16:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MM82k24O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7E5236457;
	Mon, 15 Sep 2025 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952322; cv=none; b=sXdvHwM5NWfmDAPzk6+ge88/hLFwzGzWZ09BYzCMmNmPPGMTW7AEtJSAhXGyZs8tlYhpNWXrV6ldZy1MWWKUNiAFsvzQwS6ue9NW8/4bM+NB4l4JaFhuVaOGOb7Ns7dtQa6g3itLe7fKJjhGR9jNHxd0YdP5UK9shtUL9f2fmZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952322; c=relaxed/simple;
	bh=lh+A2uC5baBTdfsKEwA9RHUSK9bZrIqABMvtzleJQAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pniA2ssAHp3KAMGXcJMGurmP6qMt5mqlvv30hSYToAjJToQ47M0T8FxUB6/iZJld2gd8uWU5nxeKA9LVhjlk0u3/fDs5C00PDIF3DI5ijXeXqg3O57hQxVWfC0vIvaOo4APtG6cUUH0zzBSdAvYaZ01jql/AWtLDMlUxS4ZjMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MM82k24O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NHJlgt/7WEGea+bBx0aICsKkZy53NaDlU69o7eoYh5Y=; b=MM82k24OY6Ssx56rmv9ma0vdmF
	9jsLBsxeeSl6lXpyUj5DWnDt67itDtOVxJodvKCmr9Ad8khCFmuYXUYkXi1Z7+kdhbMrxXH2wqI5K
	ny4u1Q3R2RNKrw+c7EtxVhI93m13Fe4MAVmJlYFtHiBTlLgXeHaWfzKYN1lLaPV+rSyw0nU88wXI4
	0/fnse8AhqcwQe6QUpPMKUohJedS4hwwaoonEEZp+WrRc+nNV68tM0vsJsvN8BJjmARLddbMUFCCa
	/ty6GKyFXV1nRHRG0br5YOyWgzatCbQXotKJac8EFogt66nwUVuD1BHx7l064x7vEGM6kpKdRgY23
	hjisokWg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyBhe-0000000539n-0h0N;
	Mon, 15 Sep 2025 16:05:18 +0000
Date: Mon, 15 Sep 2025 09:05:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	miklos@szeredi.hu, djwong@kernel.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 05/16] iomap: propagate iomap_read_folio() error to
 caller
Message-ID: <aMg5Pgj9L-ajiAev@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-6-joannelkoong@gmail.com>
 <aMKuxZq_MK4KWgRc@infradead.org>
 <CAJnrk1b8+ojpK3Zr18jGkUxEo9SiFw8NgDCO9crg8jDavBS3ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1b8+ojpK3Zr18jGkUxEo9SiFw8NgDCO9crg8jDavBS3ag@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 12, 2025 at 12:28:02PM -0400, Joanne Koong wrote:
> I'll drop this. I interpreted Matthew's comment to mean the error
> return isn't useful for ->readahead but is for ->read_folio.
> 
> If iomap_read_folio() doesn't do error returns and always just returns
> 0, then maybe we should just make it `void iomap_read_folio(...)`
> instead of `int iomap_read_folio(...)` then.

Yes, more void returns also really help to simplify the code flow.


