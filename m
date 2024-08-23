Return-Path: <linux-fsdevel+bounces-26878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 009FD95C5EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 08:59:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 930E5B24781
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 06:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A5913AA27;
	Fri, 23 Aug 2024 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="S1xqNR7r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E6F748A
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724396345; cv=none; b=HlKrLTViRdOM02LjYMp7IKjg7cJmzMAsILpS8Ow0/yvCWr5pBxdm+d+Mps/L7ORNBQsdeLuA22kQCnFeIywDRxqfzzB10fMQBuZH+OIIi1avUuLRByqwptNjCHKep57NpBtNZCbhzLBhPW6eyGHf1OcA+9hapFMigLDxZoW3YCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724396345; c=relaxed/simple;
	bh=QPbGBMPwRRkgkK17IU9mdVJ1zVycxAKYrs7PRBWj8yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKEnPnmC9nlwEWjrYrHCqpYxFztlwrnu56mjb1gnJ8eP1aT1aX3vsunidLWIehPWRksCER2EliNtZj3p17I7AOjP7BR22iREhaBGsKgqGEru91VgnufHNXd/HG/qbnKUyYkz0afaG2g2qnvtfzozvH6UaLSJxM50O+UT/K8323Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=S1xqNR7r; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QFQWfllHa6r6Xo8mtY1eDmUbnqRxbffYaVZgIv7/xdo=; b=S1xqNR7rYWYNxXJv9k6UJasye8
	bKttJbXl8lGzKAccZZomrAh0nCt9+qYs5CptM1Iodo6JIstoRvIexcr4p/15LpJ5GPqlRPQQZFWGH
	eb5JNt2MqQ7NdSKA6UHuwLTgJISAKk1Bxz8Ss+0ABcvH9eiLmwNe3/5q1fbrWnGHYIPdCzjH5KrZX
	tCekVEXLp+7ahhbPaYeKVYpoD9mL3QmY217oHKmzgqc+tMVpxoVzFuIaEzi+vWSUunW/suOvzlfLg
	1Eml8zxqixUxP6qFzfEo7zmW1lGCMxOqydublsnXnyty3oq5ZutQJ0rZ1esBCM8n4vllYR5XgyubL
	EbDOWiaA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1shOGD-00000004Qyj-0r4F;
	Fri, 23 Aug 2024 06:59:01 +0000
Date: Fri, 23 Aug 2024 07:59:01 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs: switch f_iocb_flags and f_version
Message-ID: <20240823065901.GC1049718@ZenIV>
References: <20240822-mutig-kurznachrichten-68d154f25f41@brauner>
 <ZsgrKxvTko9sLCXD@infradead.org>
 <20240823063411.GB1049718@ZenIV>
 <ZsgxucX2leSUcbUT@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsgxucX2leSUcbUT@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 22, 2024 at 11:52:41PM -0700, Christoph Hellwig wrote:
> On Fri, Aug 23, 2024 at 07:34:11AM +0100, Al Viro wrote:
> > On Thu, Aug 22, 2024 at 11:24:43PM -0700, Christoph Hellwig wrote:
> > > Given that f_version only has about a dozen users maybe just kill
> > > it and make them use the private data instead?  Many of the users
> > > looks pretty bogus to start with as they either only set or only
> > > compare the value as well.
> > 
> > Take a look at the uses in fs/pipe.c
> 
> I did not say "all", but "many" (and maybe should have said "a few").

Not the point...  From my (admittedly cursory) reading of that code,
we might want different instances of struct file that share the same
pipe_inode_info (pointed to by ->private_data) to have different values
in ->f_version.  If that is true, there's no hope of pushing it into
->private_data - we definitely do not what an extra level of indirection
for getting to pipe_inode_info for those..

