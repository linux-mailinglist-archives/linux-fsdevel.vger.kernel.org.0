Return-Path: <linux-fsdevel+bounces-16880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 450728A3FEE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 04:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710911C20ECA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 02:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5444E14AA0;
	Sun, 14 Apr 2024 02:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ZAuWqp0S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FCF10949;
	Sun, 14 Apr 2024 02:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713061116; cv=none; b=oc+BmuHnPrI55/aRqeslGBPP/DlYXNjkdbaospb5/SzUuaA+b/yRLedppga4aojAHv9bwY17yFMyHX0GfYrx5Wxe8MXy7CR/ogy0yFZ4GppoC/D9UIemicTkjWNkIHoNwF34M/Akkw3t02VFI+Ou2Y35qpK2ilZP3q5QA1R/90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713061116; c=relaxed/simple;
	bh=a3KGmXQE4lv1e8niZFsC9XFOe027BlNJdClPnuqHzDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ms9fI59XAE3GqJakIUJAalL5Ag7NcQcx6FBzx8vsdMErQoP4RDpe8Vhu2v0sYlNLXkl43LmsOTOsiX3sUv2MfFCahw7GHaI1yfXcFM+7WHy/KLyOGFkRiLbOMp4jpjRbMjkLe6usadkyGZ+dZj5qcHZaAXM343eH8HsZvqGx9ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ZAuWqp0S; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VtmRWnTbSF8zyylcv2eQAlIdRqRLmriocN3/YMLG42Y=; b=ZAuWqp0SSfSLdc0ZxyFILpkcjC
	/DrlmN/lPTqj1wnrvNYcnxq0l2uyVWZOKh6rTLuLAv6YYwWQJONgLYqEwNsgdZh1W+LiX48gmpXpd
	aXO2fYJen7+XAIaS2Xvt2bxljoWIFURSkuW+MCfVcYH042puYbMSDXv1XV10UH/Sheaxc4VVdHfGf
	67D0liqroLTEN8CVGbFs9j/RUQwjvEoz/e39UbHWx9DOpt4PzjAzDzrWN52CL2RbPyG46SpQaKbM1
	JaFq+5mCrdW6ByOcnKg7k35958mA0qUH9edFuI/FgHUzvsJuHlxjXh1d/mAhFdjttzMGnHF2Orvwr
	aiO+3oNw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rvpRu-00BsJU-2c;
	Sun, 14 Apr 2024 02:18:31 +0000
Date: Sun, 14 Apr 2024 03:18:30 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger@dilger.ca>, Nam Cao <namcao@linutronix.de>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-riscv@lists.infradead.org,
	Ext4 Developers List <linux-ext4@vger.kernel.org>,
	Conor Dooley <conor@kernel.org>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240414021830.GR2118490@ZenIV>
References: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
 <20240413164318.7260c5ef@namcao>
 <22E65CA5-A2C0-44A3-AB01-7514916A18FC@dilger.ca>
 <20240414020457.GI187181@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240414020457.GI187181@mit.edu>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 13, 2024 at 10:04:57PM -0400, Theodore Ts'o wrote:
> On Sat, Apr 13, 2024 at 07:46:03PM -0600, Andreas Dilger wrote:
> > This looks like a straight-forward mathematical substitution of "dlimit"
> > with "search_buf + buf_size" and rearranging of the terms to make the
> > while loop offset "zero based" rather than "address based" and would
> > avoid overflow if "search_buf" was within one 4kB block of overflow:
> > 
> >    dlimit = search_buf + buf_size = 0xfffff000 + 0x1000 = 0x00000000
> 
> Umm... maybe, but does riscv32 actually have a memory map where a
> kernel page would actually have an address in high memory like that?
> That seems.... unusual.

Would instanty break IS_ERR() and friends.  And those are arch-independent.

