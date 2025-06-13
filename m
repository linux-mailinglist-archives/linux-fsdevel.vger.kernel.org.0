Return-Path: <linux-fsdevel+bounces-51536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2058AD8094
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 03:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6891E09B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 01:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAF01DFD96;
	Fri, 13 Jun 2025 01:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KoKJfTsv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF52F4317;
	Fri, 13 Jun 2025 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749779665; cv=none; b=BJDAcPOY+uBfYPPMWUdQnIJg1ZJwtYxzt6JbzTjIPC3sWSfILKfVl7Mwav+ShFnLg9lV8HGV5o1OZqePtD0gO4ppDU2EhjcGIGfWqQhtIdOaQ+EJFGaxui6C64HWX6+yhdOLMLmb/gchGAesvQ3FKpU8RRra7WyJ0Q3sGDVUdaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749779665; c=relaxed/simple;
	bh=BqjIpdginw9NC7ExbOtPr97LIc8KfK4HJH29cdXKdiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy26vdWoDo2Db7su7smMsuxqPfFw2mKsXYeUAqJekQgjJmpD3pFF14eTUEqqMaQL83eJ9N5QYTDPHWIOofY1qqNbEAnXm8ZgOam6wUm9ZRwixAwWTeiH+Q02bNpUI+hfPshfQTVpl/oRkzduoB3PROnor6sLXPX4sLHxf2k74Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KoKJfTsv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nitBGWC5QXGVNWEJB7UYqmTPWWJE9Kq229DjqjXCLDk=; b=KoKJfTsvGREwu86gPNpsXQ+v0m
	AyprPavaHCJP04R4ddTmcmK611o+o2nsGbU+2qp5Iwp4swoTBnL0in/NhqkFHEDGSqGFFkEZKxdaR
	B+9dt/QBPyvdt6u7WFiNxhLiVtXUyi0tSCUDFSKOCuCb9hf4DhKOjLB036M4Q+v44oaKdAw2mtBU4
	QQc9f63h+tm8otuNefOpUHfIktRIIwSKNUCJKpT6VZi9GZm06Ut3PGVkmyysrQNJpxDDo2GLwsNIs
	O1ExxsQdsFJQyqIBk7Qkdo7R5t6X6VSqpw/7pDgxgP/i28+9xxzI/+0MVidjvktBmKbea6wwZeOin
	fxH1JcoQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPtcb-00000004cII-0FNJ;
	Fri, 13 Jun 2025 01:54:21 +0000
Date: Fri, 13 Jun 2025 02:54:21 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neil@brown.name>
Cc: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] proc_sysctl: Fix up ->is_seen() handling
Message-ID: <20250613015421.GD1647736@ZenIV>
References: <174977507817.608730.3467596162021780258@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174977507817.608730.3467596162021780258@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jun 13, 2025 at 10:37:58AM +1000, NeilBrown wrote:
> 
> Some sysctl tables can provide an is_seen() function which reports if
> the sysctl should be visible to the current process.  This is currently
> used to cause d_compare to fail for invisible sysctls.
> 
> This technique might have worked in 2.6.26 when it was implemented, but
> it cannot work now.  In particular if ->d_compare always fails for a
> particular name, then d_alloc_parallel() will always create a new dentry
> and pass it to lookup() resulting in a new inode for every lookup.  I
> tested this by changing sysctl_is_seen() to always return 0.  When
> all sysctls were still visible and repeated lookups (ls -li) reported
> different inode numbers.

What do you mean, "name"?

