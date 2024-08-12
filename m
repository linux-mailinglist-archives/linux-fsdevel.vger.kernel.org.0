Return-Path: <linux-fsdevel+bounces-25682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5071B94EDF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 15:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1CA1F228D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 13:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C54117C219;
	Mon, 12 Aug 2024 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PKyggy+8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CF01D699;
	Mon, 12 Aug 2024 13:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723468780; cv=none; b=gw3FRpjcJwAkPqExKhgBiJj3aGr+hYlRZVOFDcct5rOkF2FdA0l60latPV5iYUiX81t+YGVjXFK+Voiy2e3luA71qLB8BuD/YsSyhWohdfHy6lZUGoxJ6p3AHrie0qViWCFO/uxdlP3h3NPiidIpWjyEeSYCCyt0oFzefUgDspw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723468780; c=relaxed/simple;
	bh=tAYfad6m/QeYh9wozED8pIbFdS8uv/7ktFfHPVd044k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IS9+QD/oYCv/H6HPyx1I1Nt0k+zSGZwGkJrH4j1WjomZhTh8+XyjZyX68xF1YjlwfudMhFiui6wv4FSo+gIa/lPXTwPfzjcWzyDuQe+VpcJBikA6mXPxQhQchnjuXHZgmDYhQL08lfUJtiE4wB28A4Ei+woekc9Hoh2LmdYAwnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PKyggy+8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QtzF86IieQVZ4A3zDxLwj+KhIu3XfMiZ65Q7/sKZtkU=; b=PKyggy+8sSN9+J+Ar2V75ZlCd7
	RnYjItWwTid5ou3LVSEXYYedsgt9wRjnGSI7LppwGYsOkZk272wVukB1iDseGxBEuouilBlESCQFO
	ntXsQZ+MdpWcHCkSjxNUgG2MYqs0mAZLx/Dfp7iACbnhT4NDGMZiJvkVrazNMjrPl810lWVwD/1PA
	hAw5tqDGs7xqdWMH9NOsOWfc0Dmyr3KGWb3GuRXtkL21QN35s10Rg++rkPVXIHBh0xrtIPkgQdMg0
	Rpd3dFhyGRKpsQwqPo4MmlMmC+sKRgnJ4ElFwYd0KH8eULJRL0tklONUnsH9JWPRh1h96tOap0S+l
	ydN9dwew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdUxT-00000000O9f-3sC7;
	Mon, 12 Aug 2024 13:19:35 +0000
Date: Mon, 12 Aug 2024 06:19:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 4/5] eventpoll: Trigger napi_busy_loop, if
 prefer_busy_poll is set
Message-ID: <ZroL54bAzdR-Vr4d@infradead.org>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <20240812125717.413108-5-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812125717.413108-5-jdamato@fastly.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Aug 12, 2024 at 12:57:07PM +0000, Joe Damato wrote:
> From: Martin Karsten <mkarsten@uwaterloo.ca>
> 
> Setting prefer_busy_poll now leads to an effectively nonblocking
> iteration though napi_busy_loop, even when busy_poll_usecs is 0.

Hardcoding calls to the networking code from VFS code seems like
a bad idea.   Not that I disagree with the concept of disabling
interrupts during busy polling, but this needs a proper abstraction
through file_operations.


