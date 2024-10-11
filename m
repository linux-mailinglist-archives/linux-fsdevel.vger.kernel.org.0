Return-Path: <linux-fsdevel+bounces-31717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F2A99A579
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 15:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D13C6B24351
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 13:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C300219C8F;
	Fri, 11 Oct 2024 13:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Cp7JfDQA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14AE21733D
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728654772; cv=none; b=Hqgt4QJXUaO79H+3P4dv0k5STrWiNmJRc0ZRGs5O5i8am9jJtmA66Q6mW3ZaO2PEyt7WXtrOaIdXViO7NDa9sDyArFCDm87ELuVWtg0910rFMNW7o3YnJoP/DpDzlT49d+i2rBeYbK4bvhZ2HVGAnT0pRenEE3/4wx0CaWQ0238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728654772; c=relaxed/simple;
	bh=x99+3/mw2lgv5lakwyUu14a5PNiOuCdFUD8GeV8InSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ox1OH8emXAtMuOG60ymglAqgHRWin7Y8LAKwE6kSn6nGSOSotKgGWUIyyxSH+2rABYLnTabAtSSo2W4OoH8o8SfO8Wc4x+eO88UJJXVV21f8O9kxzYpSwY2JjrJLWZF2cH6m9udVd4zJNrAW063qdgUpzKpsNsNjg+jTic2fvSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Cp7JfDQA; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XQ7Nt4TmDzFCR;
	Fri, 11 Oct 2024 15:52:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728654766;
	bh=EXR9kR6WpROFOCjAWOYclHB+KbKDOQb2/klwm/tP+Rg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cp7JfDQAbHtceZwYIeYdJw7ewG3T/g9q5fRgHAbaAXX03ryFznTr0O91CqH0k6VbV
	 FvKO0ahCmOwlkpX7lvppqh+J927Z0RHZhPvx6yCNQrAb8yVI0UD2vaWuG66xLBaB/G
	 HvSDTJXhFZyuzttHeBx0LnBQdysQBtrRcmtZtNS0=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4XQ7Ns5N3Kz77m;
	Fri, 11 Oct 2024 15:52:45 +0200 (CEST)
Date: Fri, 11 Oct 2024 15:52:42 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241011.aetou9haeCah@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net>
 <ZwkgDd1JO2kZBobc@infradead.org>
 <20241011.yai6KiDa7ieg@digikod.net>
 <Zwkm5HADvc5743di@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zwkm5HADvc5743di@infradead.org>
X-Infomaniak-Routing: alpha

On Fri, Oct 11, 2024 at 06:23:48AM -0700, Christoph Hellwig wrote:
> On Fri, Oct 11, 2024 at 03:20:30PM +0200, Mickaël Salaün wrote:
> > On Fri, Oct 11, 2024 at 05:54:37AM -0700, Christoph Hellwig wrote:
> > > On Fri, Oct 11, 2024 at 02:47:14PM +0200, Mickaël Salaün wrote:
> > > > How to get the inode number with ->getattr and only a struct inode?
> > > 
> > > You get a struct kstat and extract it from that.
> > 
> > Yes, but how do you call getattr() without a path?
> 
> You don't because inode numbers are irrelevant without the path.

They are for kernel messages and audit logs.  Please take a look at the
use cases with the other patches.

