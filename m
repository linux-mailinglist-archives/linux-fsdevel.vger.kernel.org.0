Return-Path: <linux-fsdevel+bounces-50573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8EEACD68A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 05:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C393A657B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 03:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43916238C25;
	Wed,  4 Jun 2025 03:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Usv5xFx1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1304429A2;
	Wed,  4 Jun 2025 03:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749007628; cv=none; b=o8tYLUpqRLuc/XGS5VXI+OPADkGbGRqGwlrrbTg8mDMFoUyZNgrWJ8k1Yuvpfdkx3GP1KXXTy/dR+LEd59ziysgJdn8rHBomM7FSqD/NpbBSgUNxl7F6LN8cJZzxr/0MDFvAIWRZwbwmSpwPAEPXmKjPDlHJxT8teD8H19SF+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749007628; c=relaxed/simple;
	bh=6nK4UI+rfEwQrrPlJbASJnM+/ETWUIhZsX797PL5+Dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C5pCtdjuCjkM7KUuq9ZenKVJKPmOBvVOFcs6eS3I/z92CixlkWOPwfCT20XXEjLbTLfouXsNo+dXBoGJcdFO4OjWy9PN1Zg7DOcLTm9tAmez7uy12j8ljxj8ChkZUiJZnopnamkAy2z7qerlz12awuiyX4egcMayHAvGNR2EPOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Usv5xFx1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R9BSVQ3bOfkR1CxKAYmpHqWwWy4CcNGdJn7y05g5hkI=; b=Usv5xFx11aYHrRsnIzga314HZe
	GdglkANuACY1d1gboesrT4gZL61GuTDb6DeyUOttxsdxYibHdR4Wg1/hCRyqnVkWZpi/dfc/Uh/9+
	32pO6UPQEGo2VTZJOeqopS3btYYOQcmxK951S6vQ1LkZGWBvBsjtv/rfrpkvqduRUosE8Yh8Q96vQ
	ShBPiRaVBsREAlYCEY/ZIw/WdY9BRoSC468G6LKjJStIfMY2y09OsqejaAPYZoXM/ifMsKO0p2a9v
	HgGxHWr1z0KMBvz78GRzqN5cnnMyInflNwjbkDxELHl/xw3ym9JQ0fX3NMLTv8MjP55Z0B8M7cVLE
	bCZAVf8A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMemO-00000002hsa-1lCu;
	Wed, 04 Jun 2025 03:27:04 +0000
Date: Wed, 4 Jun 2025 04:27:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luka <luka.2016.cs@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Bug] unable to handle kernel access to user memory in step_into
 in Linux v6.12
Message-ID: <aD-9CGebRbqhu6_w@casper.infradead.org>
References: <CALm_T+11u3jn-OPi_TPogwsUYE_iRdgZY=pjG8-OzTa4uR3dkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALm_T+11u3jn-OPi_TPogwsUYE_iRdgZY=pjG8-OzTa4uR3dkw@mail.gmail.com>

On Wed, Jun 04, 2025 at 11:05:45AM +0800, Luka wrote:
> Bug Report: https://hastebin.com/share/yatanasoxe.css
> 
> Entire Log: https://hastebin.com/share/qaluketepi.perl

Uh, nice try.  I'm not clicking on anything with an extension like that.

