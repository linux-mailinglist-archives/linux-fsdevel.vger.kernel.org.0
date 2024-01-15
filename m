Return-Path: <linux-fsdevel+bounces-8023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25EC82E40A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 00:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD14C1C2237C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 23:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6B21B804;
	Mon, 15 Jan 2024 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="h8ix9tk6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB11B7E2
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R5ucLr/3IM+gB1p8F52Nb7v6+r4MpbFsAw5djm5e7lc=; b=h8ix9tk6mOZ/6fLiTx5+B1G3tK
	RB8yZJUaujZ5GswcwrNkM9ruSG0oj+GtWMSIQ6SvSJreR+tP6Xd7YQRoN5CnMJlgVOHSwreUbCSyd
	LJQVPfejdn3LV7goPMtcCSFWruMAqqpXL7N8hLkQ8KzRoNzQbjFBZmA4RwIJ0EoPIF0WOef0VgtTh
	QuwCI6m3TF2WO8KACsuWiroj50kwr7nM/VXf6Mf3QG14vnN8JBu5eIYekAMHhAJVP0vBV3kqTEbLL
	+WbeyqUSA/u1380xAHqjrMC1tdbpGHseOLXPDx0dluxHv8EQox6fGoyedReDOGKY0detQyZGRpRpW
	TjJ1xIlw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rPWVj-003aZq-1P;
	Mon, 15 Jan 2024 23:36:55 +0000
Date: Mon, 15 Jan 2024 23:36:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Bruno Haible <bruno@clisp.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Evgeniy Dushistov <dushistov@mail.ru>,
	linux-fsdevel@vger.kernel.org
Subject: Re: ufs filesystem cannot mount NetBSD/arm64 partition
Message-ID: <20240115233655.GK1674809@ZenIV>
References: <4014963.3daJWjYHZt@nimes>
 <20240115223300.GI1674809@ZenIV>
 <ZaW6/bFaN9HEANW+@casper.infradead.org>
 <2807230.6YUMPnJmAY@nimes>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2807230.6YUMPnJmAY@nimes>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jan 16, 2024 at 12:29:54AM +0100, Bruno Haible wrote:
> Matthew Wilcox wrote:
> > Wouldn't surprise me if netbsd/arm64 had decided to go with 64kB
> > PAGE_SIZE and 8kB fragments ...
> 
> getpagesize() on NetBSD 9.3/arm64 is 4096.

It's not impossible to do on Linux side; the main trouble is in the
Cthulhu-awful set of helpers that needs to be untangled before we
can realistically do any kind of massage in there.  What I want to
do one of those days is to do an iomap conversion and see how well
does that work.  ETOOMUCHOTHERSHITE...

