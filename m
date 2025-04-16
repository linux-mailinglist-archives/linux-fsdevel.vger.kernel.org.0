Return-Path: <linux-fsdevel+bounces-46588-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D28FCA90D03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 22:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B6D1888909
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 20:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C9722A4D2;
	Wed, 16 Apr 2025 20:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgwVajUe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D5722A4D1;
	Wed, 16 Apr 2025 20:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744834887; cv=none; b=N1S4yJsjHxyRzGY5jpk8e7c05YL2uv22N1atomnjjjYk/x1OfYm9BoNueNCKWbVW3nJvP6TEwo6zeOvRNJ+sC57m38IXLDnIpmutg6l/I6tQ9AXUiBiJX8bWS7lZ5sWTfMXbSd0549ioKjKaqldD8Dclt5/SlBc3mgl7LdziqNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744834887; c=relaxed/simple;
	bh=2pwdTdGUVqO+3caA4XFoEWkTS0gmoFVvxmcAWb43xrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xde65meryVuk6bakUvBtFsfs3wAPiCPdAlby3QK1jrfqIb3McC/wnWrfzGCZUTcDLITTJpw7JYtq2bAJM1phWo7TtVhouyLNPBXvZWHxmKUXeAjo/DYSc/ihUa9S1VDwwDwxoy7SI13nEjAlWJcfKSt+JKIORb6LqyWQ3vWGH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgwVajUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13E2C4CEE2;
	Wed, 16 Apr 2025 20:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744834886;
	bh=2pwdTdGUVqO+3caA4XFoEWkTS0gmoFVvxmcAWb43xrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZgwVajUe2Zz2EyLSIlP23UoGfxbkhPh9D5fVnhLgfOuzDzP2I7ga4+rg0N6lRnCEV
	 LWvDS2G9MCA/1c31xu86gGBe+RJIYObWaE0KO9llWLa6OKZHENsrIQh1jki5M3i2yO
	 d1BSNZGRdCYQ0hbmL1H5XrLGbBWswna9bTkF8Kceq9gaGn2G5bnyvMZ68mfi8myLRE
	 XihymzNWXcvV9W/lfF/SDPF/T4QylayWSdsuHgI9G0mU4xbmPd5atpRNUSs5/3poo2
	 OBfMBjA65u+vFGo6BQHnQ5jtx84ROQeHwdnN51HjGkK4H1n06NfBoGmnjyyN+Bsr6M
	 1OdolcrRk8jgA==
Date: Wed, 16 Apr 2025 13:21:26 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-xfs@vger.kernel.org
Subject: Re: [6.15-rc2 regression] iomap: null pointer in a bio completion
Message-ID: <20250416202126.GD25659@frogsfrogsfrogs>
References: <20250416180837.GN25675@frogsfrogsfrogs>
 <Z__5LOpee2-5rIaE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z__5LOpee2-5rIaE@casper.infradead.org>

On Wed, Apr 16, 2025 at 07:38:36PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 16, 2025 at 11:08:37AM -0700, Darrick J. Wong wrote:
> > Hi folks,
> > 
> > I upgraded my arm64 kernel to 6.15-rc2, and I also see this splat in
> > generic/363.  The fstets config is as follows:
> > 
> > MKFS_OPTIONS="-m metadir=1,autofsck=1,uquota,gquota,pquota, -b size=65536,"
> > MOUNT_OPTIONS=""
> > 
> > The VM is arm64 with 64k base pages.  I've disabled LBS to work around
> > a fair number of other strange bugs.  Does this ring a bell for anyone?
> > 
> > --D
> > 
> > list_add double add: new=ffffffff40538c88, prev=fffffc03febf8148, next=ffffffff40538c88.
> 
> Not a bell, but it's weird.  We're trying to add ffffffff40538c88 to
> the list, but next already has that value.  So this is a double-free of
> the folio?  Do you have VM_BUG_ON_FOLIO enabled with CONFIG_VM_DEBUG?

Nope, but I can go re-add it to my kconfig and see what happens.

--D

