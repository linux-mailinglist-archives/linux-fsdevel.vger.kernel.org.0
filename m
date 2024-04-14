Return-Path: <linux-fsdevel+bounces-16879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 902038A3FE9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 04:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226571F21682
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Apr 2024 02:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F5814AA0;
	Sun, 14 Apr 2024 02:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ARI3Q+Sv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7031D2901;
	Sun, 14 Apr 2024 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713060965; cv=none; b=JhAv4pDs7Zkj5V+vNSYS8dkZ1Tw+mwHIZpQ/h8maf9fXcYhSaC3ZI71xjsGRDklzzVWdRvsAi7QCMM9d8pJc3baKpMIRHdzYf3Fx5D+vayeQCxptunoxRX/T/zA0DoTwMSqJRvRsAe3tF9vI8h3wsrxGx2+u0UiY6hcvorb9+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713060965; c=relaxed/simple;
	bh=RKv3vsToLCa2YjZhl5JpuLBfQUujma9u0MCR9555bBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EBgK/GzeZqmrOx0ewrD/3peaM1b676i9ElZh6eyrOADe1n8vezweu0alJEOrByyFXdzhJt4FeLWAfurkA/WJ5rsnRaZPke/+gqeTQP1N2D0i8AXI3m8XzJcmVnZ+behTScF5IUQRSuyZjgsa4CxySQtpBquske2JUkGxD4gPANc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ARI3Q+Sv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5V6xLcv+SsxTZP7oJclkFu6nQWt0ZpiIb5AqX82jvD8=; b=ARI3Q+SvOz6qC0vz7y43WZP8uU
	RNYEQPok23aMqE1n9XOIj6Dr5tMt4lfz4oQOoLXAlLYRTrqB52NJNs1Gkx4NLrjr8w5mrpVxzIpVx
	opoZFDLoGieAzjpayVi3Vki5mwyafXKzSb8xGXKiUNCH65n9LMWhwq1e4+PeyCGw1WBb1uEwh1AeX
	LZOg0mszXMxVLyuyTITFh4Xx23W2LpVPxyEt2gqJbUSLYNRQKZ5+F6XoNTAWX3Dm0WHDWcuLm4aou
	rQDRNQrZQgQhDi4byyeJ1PAXjoSAGkYmPMbCERWj48IB44PaDGnk4BJMy6LZ687QJ6/j3eJP9uvUO
	aeWH9f7g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rvpPP-00BsG6-0B;
	Sun, 14 Apr 2024 02:15:55 +0000
Date: Sun, 14 Apr 2024 03:15:55 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Nam Cao <namcao@linutronix.de>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-riscv@lists.infradead.org, Theodore Ts'o <tytso@mit.edu>,
	Ext4 Developers List <linux-ext4@vger.kernel.org>,
	Conor Dooley <conor@kernel.org>
Subject: Re: riscv32 EXT4 splat, 6.8 regression?
Message-ID: <20240414021555.GQ2118490@ZenIV>
References: <878r1ibpdn.fsf@all.your.base.are.belong.to.us>
 <20240413164318.7260c5ef@namcao>
 <22E65CA5-A2C0-44A3-AB01-7514916A18FC@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22E65CA5-A2C0-44A3-AB01-7514916A18FC@dilger.ca>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Apr 13, 2024 at 07:46:03PM -0600, Andreas Dilger wrote:

> As to whether the 0xfffff000 address itself is valid for riscv32 is
> outside my realm, but given that RAM is cheap it doesn't seem unlikely
> to have 4GB+ of RAM and want to use it all.  The riscv32 might consider
> reserving this page address from allocation to avoid similar issues in
> other parts of the code, as is done with the NULL/0 page address.

Not a chance.  *Any* page mapped there is a serious bug on any 32bit
box.  Recall what ERR_PTR() is...

On any architecture the virtual addresses in range (unsigned long)-512..
(unsigned long)-1 must never resolve to valid kernel objects.
In other words, any kind of wraparound here is asking for an oops on
attempts to access the elements of buffer - kernel dereference of
(char *)0xfffff000 on a 32bit box is already a bug.

It might be getting an invalid pointer, but arithmetical overflows
are irrelevant.

