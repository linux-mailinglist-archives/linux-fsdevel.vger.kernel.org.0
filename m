Return-Path: <linux-fsdevel+bounces-42700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3412A46506
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 16:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5753D7A0319
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 15:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDA221CC49;
	Wed, 26 Feb 2025 15:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IlxGXyPo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EB61624E0
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584019; cv=none; b=aqA5ft41bsnXhgTDyc/gI5F0oShUBrAD81zzNkFKi1c/GPXrYyxGntiefduHJYpBX+tX07FblB9tNTsNQCJ8V5w2k8jZH2astfy9T5pngfK4+X2mz027yY4/553gvw+QZgjfs/py+QHbWJTV73vPHB6fdrFtLc0uJtorgi+Y60U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584019; c=relaxed/simple;
	bh=5cbzqsPl/lFiKOz8TmoLDPgOdDDDChka9NTNzNAnpBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2jnZUs6J+neAt2hcrGs8M5bn5zvBZWdK3CHMSLH1CDJtdN+7nuL8bzHus/SWQisR6MrclC1kWrkx6hohmhgVZF0S6+B7jhN5AgY4aiOFAKdRbZ7vT7NaB+4aJwSuyLY1vr+xnNb6znwDB/0mf/cQKIMgv0ayDENYidITV6kM/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IlxGXyPo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OOJG89Fe1l4Kvbgg7havE1GKXfJsV0fkJD7TAmwFKkI=; b=IlxGXyPoUlmpt+NpHH/ZKfdMLg
	Ubj+8MniRwKdkHs/ibqol7mcD0SAJn3G4uFgQFAg2rZ0nrb3Ht9ePrizhitulQvhfptv1DOA/KtpT
	DXnWskZAb+Kzd7Nmc+iWgzeoz0TCcELGeDUfCbGTYQjjhBJc2/QcuPvie7dskcP2+Uct6wIQhuAR6
	4WS4I7DtsUv1d8ZO2H3NyF+ruT2o7B5nhC6TAkBUqSYNoD0rMkW0SfRjoEBXTOL+7M470j9kY9ut0
	QT68GtjZxE43uqTbRB2v6lYPbU6moz6FRAYb/iVogA7API7PvPblk4W5LCUdhMnlzw4eKpsJGD1Tf
	YnpyQxKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tnJPi-0000000FppM-3jZh;
	Wed, 26 Feb 2025 15:33:35 +0000
Date: Wed, 26 Feb 2025 15:33:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vboxsf: Convert to writepages
Message-ID: <Z780TsepBGDVZOKL@casper.infradead.org>
References: <20241219225748.1436156-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219225748.1436156-1-willy@infradead.org>

On Thu, Dec 19, 2024 at 10:57:46PM +0000, Matthew Wilcox (Oracle) wrote:
> If we add a migrate_folio operation, we can convert the writepage
> operation to writepages.  Further, this lets us optimise by using
> the same write handle for multiple folios.  The large folio support here
> is illusory; we would need to kmap each page in turn for proper support.
> But we do remove a few hidden calls to compound_head().

ping

