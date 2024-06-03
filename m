Return-Path: <linux-fsdevel+bounces-20775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE0E8D7A98
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 05:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD33C1F218C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 03:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D0118622;
	Mon,  3 Jun 2024 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DNV473ru"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F8DFBED;
	Mon,  3 Jun 2024 03:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717387016; cv=none; b=P6i5VHiLCGV4Ir2+L609F3Kp06QzAsKqHT0PWXA3uoYK6DffxmxF4FEIrlByrxzN6ZZ5qVM5Aha2h4GslpP9Bea/O4YMo/iWA7e+giws2Q74yMJfwjWFTS965JqH+LsqrOn9FsPT7R1GaqPNBrDAOuMBdBccdBC3iRE3H4Bsnyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717387016; c=relaxed/simple;
	bh=8r5fwBt3++hnnoj3YMZmhKb28KYEQyUrYUNe9qaSlp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvrCRXjoZsr/zwFqAcqWE8+PaWQREfYD/ZOp9BRy3ZGkOG23j06H2XVl4ffOnmTq/ewrh8YNbf5lwWNhQP37FFsApwuZmc9zJt9UXLsWVBruroNsxuZVQ1alp8putcbm2SnfaICJtHn6CLWIsNwzbgsCUpm9epV7/fHGASm4dt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DNV473ru; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8r5fwBt3++hnnoj3YMZmhKb28KYEQyUrYUNe9qaSlp0=; b=DNV473ruSeCUkApRNGLTSvy+9s
	Gwc+cznETQLhxOFl61AGEc505jjbbVvPv20+HLxfq4wvBwbtuwYm821lnkrlWP5pHUzfYWV/5al1P
	3FgwPtu2wO8RtFX/3wr5O/z8+zgKB97Fw3dJb82ECCaH2TgiwSmJ3ifeLzNT5vUHtsIpu1u3m5aAg
	otXQNGffHF4W/esGmYESzcmKdAIaC6MhNzgh/Rbil3ALaunG0ZZD/1KEijpTMIq8qI4AMXXcf6w+G
	xcE7HVYr7EdTpqcxeCqHxCJe5+yo1f/DGvlLx+nIVb/jbKZp/PVxcZDfdXRy42fdt9GcisUPi99yj
	R9FiUWyg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sDyoT-00BMDb-2e;
	Mon, 03 Jun 2024 03:56:49 +0000
Date: Mon, 3 Jun 2024 04:56:49 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: syzbot <syzbot+42986aeeddfd7ed93c8b@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] INFO: task hung in vfs_rmdir (2)
Message-ID: <20240603035649.GK1629371@ZenIV>
References: <00000000000054d8540619f43b86@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000054d8540619f43b86@google.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jun 02, 2024 at 08:50:18PM -0700, syzbot wrote:

> If you want syzbot to run the reproducer, reply with:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6 v6.9

