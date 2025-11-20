Return-Path: <linux-fsdevel+bounces-69257-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A67C75BC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 18:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 2168A3057D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 17:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A9C28853A;
	Thu, 20 Nov 2025 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F9aCAIht"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C048239E81;
	Thu, 20 Nov 2025 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763660099; cv=none; b=YIp/XZbKS0Pp0wl4miMbNkE+U6h+8qyE+QbRvo/GI+gOU06zQPaUzOgdP4M3Psjoo/OZvVq4p9Q3aR+psI9/MgkeLLdQPOOmFz9NoGa+m12wtluJUbEMsTFueU90tiDbjGnRK8fGHYtex9K0AWuIC2qW6kXYJ4ktbBPkLNSq/YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763660099; c=relaxed/simple;
	bh=hqrNf7dmmWT4g1NaBhL+WJNs7T/lG4p4aL+Gr4WqKoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSnYiBtU+tcpnz+EVgf48WPs8rfYsn0EfR6KOo8lJ1SVLts1lJP7Lkm0UwLaJQpETFUimzsLF5+Go04QEs3+oul3qwhsLqPL4g4lh5ARLAG7l/2dXSQ+TxGCWD78PmqmDziMuwCXNvQpXkgzpporR9z2vTGv8EadCyMc+sTUiZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F9aCAIht; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HX9xi/yoIE/W74opRpTiKXls6YMQxbjPjnK1RM1Hcn0=; b=F9aCAIhtemYWdcGj2h3daTqrHn
	umBOun42GP2HP8+tR3nhqs7SF9LxVD8L/7Tfper/34MZVVp8MdTn4aV/A2Qut/1L04Ba6QEDFCpns
	c6QchbnD9I/uKeAcTuVa0XYT53yTrbVpsNhjMISBL3YSQ8aKiby/phgCudFwOcxTOhCS+Fkn8EfcD
	Tntr6XuK1kCVp4UbN/6OVMo61JGHKe7AeQ1Kbj/MZydrpqIlk55feM3EH1PIp3JORNjVbH6u+HM/X
	1RDkThuagELUitA1j9WI2PaM+8rkr4A0pLro03LM5yyk86bdnGesi1tg5WuS0M/uKD+H8SPmY8OSC
	1f9BDecQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vM8YX-00000001Z5M-3KuG;
	Thu, 20 Nov 2025 17:34:53 +0000
Date: Thu, 20 Nov 2025 17:34:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: ssrane_b23@ee.vjti.ac.in
Cc: slava@dubeyko.com, glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	syzbot+905d785c4923bea2c1db@syzkaller.appspotmail.com
Subject: Re: [PATCH] hfsplus: fix uninit-value in hfsplus_cat_build_record
Message-ID: <aR9RPSD8XSCDqkeF@casper.infradead.org>
References: <20251120171740.19537-1-ssranevjti@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120171740.19537-1-ssranevjti@gmail.com>

On Thu, Nov 20, 2025 at 10:47:40PM +0530, ssrane_b23@ee.vjti.ac.in wrote:
> Reported-by: syzbot+905d785c4923bea2c1db@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
> Fixes: 1da177e4c3f4
> 
> Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

This is not the correct format for the Fixes: tag.  Here's the easy way
to do it: add this to your ~/.gitconfig

[pretty]
	fixes=Fixes: %h ("%s")

Now you can type 'git show --pretty=fixes 1da177e4c3f4 |head -1 and it
will give you:

Fixes: 1da177e4c3f4 (Linux-2.6.12-rc2)


Also, don't put a blank line before your S-o-b line.

