Return-Path: <linux-fsdevel+bounces-41265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA78A2D05F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 23:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DDEE3AB73F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 22:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CD81BC07E;
	Fri,  7 Feb 2025 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KAMIIOEp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF291ADFFB;
	Fri,  7 Feb 2025 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738966639; cv=none; b=oG0jniAGg/SvdLeSJuM4n9SjVmYRFzpoMIsaDJi02tQwYD5Av/XmsbgD73e0ly1ixD2/XuOkgOwpztpdHzHVC3fy3fw+o0QWyUpa20+EfM3h5k3ooiUFukGvOCNz2qHd3phlDP7KsVOThbjK/AWVThSZ1ENtyj2Gt/7TjSCKGek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738966639; c=relaxed/simple;
	bh=DCpuCIu3XplMRghWSJSuC0yuZ/pUa2j3hGTA0bNS/ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWyuO2rGU2K/agB5NVhdTUqNmMdKlR/jaAYtnWxBKTR2Uw6VYmArONZzO1w7xmk5/5LK2eSVvOyQj+/RYlN1aKzZMnonGsjETR9XeW4nZU7DF4e5Z6Xc2Bt0tOKEE0DYk8I0Q3UVxjUtLs3mqpr9aWqDdgXRWHlDXy1L4u8m0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KAMIIOEp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=arDjPbeH+8wdoxPVZaKDsqQlR9wvZZjYVMaqU8DIY64=; b=KAMIIOEprMhHIqvRihtdopqjjj
	TLBHzMPx8Km1ug8y7uJn0vvCZ1T3dt0zW92Yip5DoUe5FgGYj7u3kFqhQnrLP3oguIUKreifu7FXQ
	gqqdDsnwLeE4dNOd+uY2EDUnZcZGam48/UGuXlG+jeVoQiqEcNi3yajBqAF2Px2T5y8Ihz64lTucq
	avTwwGiAeIQnpdAaqW3Y0eaul636rdOsnO/wOIe1O+Ey+o7oWwfKnvyfyde46ow3+HXbqTKbU7JeD
	e/cYbOKX5PVuJznTbu4roM0cqzh1feLkDWLhuS1aCyP4PJO8pW7SssJieL0UJvHk1+O52Flsimsuh
	FvUTbmSA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgWev-00000008lBX-0wqY;
	Fri, 07 Feb 2025 22:17:13 +0000
Date: Fri, 7 Feb 2025 22:17:13 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: xfs/folio splat with v6.14-rc1
Message-ID: <Z6aGaYkeoveytgo_@casper.infradead.org>
References: <20250207-anbot-bankfilialen-acce9d79a2c7@brauner>
 <20250207-handel-unbehagen-fce1c4c0dd2a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-handel-unbehagen-fce1c4c0dd2a@brauner>

On Fri, Feb 07, 2025 at 04:29:36PM +0100, Christian Brauner wrote:
> while true; do ./xfs.run.sh "generic/437"; done
> 
> allows me to reproduce this fairly quickly.

on holiday, back monday


