Return-Path: <linux-fsdevel+bounces-58616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E3B2FD7C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 16:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A307F641C35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 14:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794352BDC38;
	Thu, 21 Aug 2025 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f3JEt5PO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5441813DBA0;
	Thu, 21 Aug 2025 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755787455; cv=none; b=ZyPsmDNPxRVpZx5cjFbe5j3lAlVTNb3rRNlkNxZdLuLRmu0VflV4AUkOqPOHzeOnihK9VyKvyBVgywn2AYMkvtJJG6pzK0rqwhIUzW2pvZQqAzupnk0vu1kgLWI7a1FC1gDjJms1kdnwDyd4DlIbaGuTSrpEuiblE3JUtkrTepk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755787455; c=relaxed/simple;
	bh=TkZEJFWOpYWxVTG+V4ASzQo0OD1beTBXr884BHRL6Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urzfwGIeGO9rT0bdG4X0jVr9AllPVcIe3qnQ/GYae+jdszBuj69vz5lR0HIytX3pdj3hQmhJofcFrrmBNqxzzzzoOwwUtvfEjhvBoJsQgqFEBF7xsdZv6VexueNGhbiDxw0c/hKmKOuaMdjXjIymRKq1AyQWiAtSdcwMtYNouC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=f3JEt5PO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vn5EfM5ucdzmgkOY3lxtDm/E+nNV9/3cp3KgM4gsJgE=; b=f3JEt5POQFCD51f7Mgsh5/uk6W
	2+B5UpSadrekunT/jN/5VK/Pjb5NG+F7I5h6rjEpRiPoj0daj4swxyEojPAZ8rcBREh/VCaWR6WQE
	WZfwTVHEK+EYIix18VxtQJrTgRja4B/4ltk+a952sBYgKlYau/gg+0PLAvs1+zDYSYKA96j7LkJW0
	uGLUblREuZezMH1iJKKw+/S9oUbNL4403vJthE/xKbwIS+EPkYVvH7RoGPflrLENtBvxWrc1ILR87
	O9tvv6I6RijGUlbvKf1crznw3/PNiQtzHNiKj999tH8t0f5zp4oqEnIMAH56v+tIPvl6Er4P/kPnF
	AY3Dx/Gg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up6WP-000000092jN-2Mb6;
	Thu, 21 Aug 2025 14:44:09 +0000
Date: Thu, 21 Aug 2025 15:44:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: ssranevjti@gmail.com
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, skhan@linuxfoundation.org,
	jack@suse.cz, masahiroy@kernel.org, nathan@kernel.org,
	nicolas.schier@linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Subject: Re: [PATCH] docs: fs: fix kernel-doc warning in name_contains_dotdot
Message-ID: <aKcwubMKrMr0rg4H@casper.infradead.org>
References: <20250821141811.41965-1-ssrane_b23@ee.vjti.ac.in>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821141811.41965-1-ssrane_b23@ee.vjti.ac.in>

On Thu, Aug 21, 2025 at 07:48:11PM +0530, ssranevjti@gmail.com wrote:
> From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
> 
> Add missing @name parameter documentation for name_contains_dotdot()
> to fix the following htmldocs warning:

Sixth.  https://lore.kernel.org/linux-fsdevel/aKXB7Ux8_C_IIrkB@casper.infradead.org/

