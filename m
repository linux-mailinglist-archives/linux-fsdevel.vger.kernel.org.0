Return-Path: <linux-fsdevel+bounces-66611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 394BAC263CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 17:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75226189C79E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 16:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847D52FC870;
	Fri, 31 Oct 2025 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sJxjaknC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B936323D2A1;
	Fri, 31 Oct 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761929528; cv=none; b=EaLFw7IPfxsD95YGhPB3oeHyBq+czkWVVHS94pkpSQhM3Hd1C3fzf5bfgQid3xWQx6Ebm12bAWLAxXz7CheeIIJg6sgu2L/V0s+Y6O1o08Nx7R4MKaLVKGDAXJty/fb6sCRx0XOoWDU9RIh8L2fc50m8F3h7EEhnIA48P8/WCuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761929528; c=relaxed/simple;
	bh=P2fL0tlCq+Gm4StEB4fMxtJZxlI1iIRtU6CN8tCiFwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw/Rr1NBxaWMwDA4B1bkUQ891C3gniTSfFQnYq1iByWs0Z8Av1MAiXJ+I8jpQwf5yfBnQoKTO/hfH3Afv1QEby9SP+JAHRjTLQ3p9i61Z9C/hRib++ntda2oB7QGKb7vSwuoCZmJAJA+DpzNm4JGdDbFCElr5awKCg+hwqVnLB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sJxjaknC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dqKSZW0oujz8RZcOKmf/njsg4AHDVEGRDvlBryxPGXw=; b=sJxjaknCh7j3mEJyq3QFCPyJRs
	ffx+LJ8iQH0LMsRq1Bk6s23UxWS5LzhDfj1ut3Hgq2yAcWH6/mR5Fz6/XJv1gLS56e+8P2cowpbUr
	smYyNYuDAYNGW2JYAfsp8tHt4lg/cbWrflDZCIJdQe1TpZXaPJLzy1sVNsUCDa8Yf/rCGak7EZvyV
	AHkebnFxH2JmDtbPex0Bs4Y5qZcDc3afsZeQ4OccI/FHOKsBG4MI33AvoJXQDnJOa8IwV04WEsKIv
	EAXqSNEDpwVg1zwr4rTqO+L+mznHDAEL+xNunWoRUa+4x2PV/FBNgY3bSRKBMyghrgTlz8ZbGMS3J
	XWdrTy3A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEsM1-00000002y8u-0dEL;
	Fri, 31 Oct 2025 16:51:57 +0000
Date: Fri, 31 Oct 2025 16:51:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Yongpeng Yang <yangyongpeng.storage@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [PATCH] fix missing sb_min_blocksize() return value checks in
 some filesystems
Message-ID: <aQTpLEHURCmkpU3K@casper.infradead.org>
References: <20251031141528.1084112-1-yangyongpeng.storage@gmail.com>
 <20251031152324.GN6174@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031152324.GN6174@frogsfrogsfrogs>

On Fri, Oct 31, 2025 at 08:23:24AM -0700, Darrick J. Wong wrote:
> Hrmm... sb_min_blocksize clamps its argument (512) up to the bdev lba
> size, which could fail.  That's unlikely given that XFS sets FS_LBS and
> there shouldn't be a file->private_data; but this function is fallible
> so let's not just ignore the return value.

Should sb_min_blocksize() be marked __must_check ?

