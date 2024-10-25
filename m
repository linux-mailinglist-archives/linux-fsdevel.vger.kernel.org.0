Return-Path: <linux-fsdevel+bounces-32923-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440009B0C50
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9855A285198
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 17:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A0A2022E9;
	Fri, 25 Oct 2024 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SStY8xNr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ABC18787C;
	Fri, 25 Oct 2024 17:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878987; cv=none; b=WdQcq3+wE7tIF4j2uIuH43U0cjhoik4RDURvo2VzjyNVNSU+dYSgEqcrG3+8yZcp96aWeKFknyyEV1j3JGttF3+9rdikdTRVeMiIejtmtrKMQ4rh7GvOKjpS8A7uTVa2LTipD1sb/w4EG10MdPhlYqf5GlRRMmS2+pqnefQT05U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878987; c=relaxed/simple;
	bh=6YN8cw1qEq7vJTkfKJ8Dh4UFkLWP5qFeZMEqGJuLvlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlNuwRrw/0UwLYNkF0TEuLNQlhmi0yC8gpexSdos+hbQc1edI5wUfSVXmNnjQdr/yblARZLWfS98tBUTDxXpDo+r+QGp/rJdhCwlPwuLHmTkI9ojLkz5/Gv8l+vhgnNrJrp+3Qe5OhRn6rZ+F44Vdz2dutAyB3KNPVHPWdQDSyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SStY8xNr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wTPBe/opk9UbaXvM9xpGp+OOxiX0rih6vgsbWt38byg=; b=SStY8xNrz15iiTsA9gOVb9lGBc
	iTze/AjkYJN3SYkl6a2TayQm1wRler+ZygIeMmD55ZVc3eP5C3W+r6Swazkhs7lcGueiDVE//FXKt
	i38FWhRKXoEtw0WiPF080uLh3DCP7FeHXbvM6dYzXOwCly5JR34BYLKsmR+io6dgC6cDW+x2oNdm+
	nuxJsAagdlDlUzdd+AaflGnRrmTthfdBsdXfBx/szozNgIVS4noRuKy2ToxODHLKpLQLq7XBxiuCc
	TNj6+0PmMCmlWp8gtB3x0j+Tcr3hBMWo7tEEaBG0cF/aicZ+p0TTU+qnCYbvA45vL7xM1yCKCQBfb
	LNCwCkrw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t4OXu-00000005TjA-1Tdr;
	Fri, 25 Oct 2024 17:56:22 +0000
Date: Fri, 25 Oct 2024 18:56:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/10] ecryptfs: Convert ecryptfs_writepage() to
 ecryptfs_writepages()
Message-ID: <Zxvbxu5_UYfwFbfc@casper.infradead.org>
References: <20241017151709.2713048-1-willy@infradead.org>
 <20241017151709.2713048-2-willy@infradead.org>
 <jcivwcsmvdckd36tfhxkmui5zc4gri2adq3szw7cibkyfxrdu7@y6n6g55qma4g>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jcivwcsmvdckd36tfhxkmui5zc4gri2adq3szw7cibkyfxrdu7@y6n6g55qma4g>

On Fri, Oct 18, 2024 at 11:53:41AM +0530, Pankaj Raghav (Samsung) wrote:
> On Thu, Oct 17, 2024 at 04:16:56PM +0100, Matthew Wilcox (Oracle) wrote:
> > By adding a ->migrate_folio implementation, theree is no need to keep
> > the ->writepage implementation.
> 
> Is this documented somewhere or is it common knowledge?

It's mentioned a few times in various other removals of ->writepage.
I don't think it's worth documenting, since the goal is to remove all
implementations of ->writepage (anon memory will continue to call
swap_writepage(), but it'll do it directly, not through ->writepage as
there will not be a ->writepage() any more).

