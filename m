Return-Path: <linux-fsdevel+bounces-42605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98230A44C00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 21:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9668717631C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 20:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CF820E31F;
	Tue, 25 Feb 2025 20:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STCzDmCL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CB639ACC;
	Tue, 25 Feb 2025 20:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514072; cv=none; b=MGE+55QEX89WwZBCudHXjfeWxDshToOKH4H8sfp1g+BhmimSTXVbtcquCoSdKoSP13zte5yg4Qa5ixPNJtJrGD3a6piwKCSsf5L4/t8aDkkS6G4Nbk1dEI6fOLSjtO6/X2G8FrDKMlr7BLwZMt4aRVOjBORgNZI1XQJTRdP/ZhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514072; c=relaxed/simple;
	bh=lCzQd9QWZ4PnLOFHOKL7btYHSTjc2fdUQXfsPH4Jv8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYn3IdATll5AEdAbJB7dLcqRRWJMO4Yz5lLQBrtJVGsI6w+GGu/w/vzWprZT9QFj5Qrs6KNlG/QZdGkav1Ph+GQ/RA+bgu8YrShuZY3+jGwjfC5TkjzixYMMl7HsGQpo/tTeganrjKeAzVjGwYCJ5EKaEUfVImm+pq8ta20BnJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STCzDmCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AE2C4CEDD;
	Tue, 25 Feb 2025 20:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740514072;
	bh=lCzQd9QWZ4PnLOFHOKL7btYHSTjc2fdUQXfsPH4Jv8Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=STCzDmCLaQW6uTIfXgZILD0Vf9NdcJ6zZxBEFKTxMZCFOZRrn34aa57oI1TwxqJjA
	 g6+h+hZIjAOGqNmX0SFyJ274R1bsQAkkItt8E8YF0u+r/9RhIFFGbCEFXtN7CdigiO
	 KJDuvF8p00OOIbRgbOAG7ZnOR9YuCDUSgZgXdWB03TH0xKlX1Z4mtdvzmLQE85wkuL
	 oGa0ffXE3Df1Rk1A/riKRtzANZ6sY7J53wN2CFkYCfjQNmp92Wqnl/zIwEubTiFoul
	 gdFZUCquiAIA8SEXWTvJ02uIfwto5xcXcd3llC8Bk8el8tmgxn/FgHEclPJ+jc1dH2
	 02QAripYLz5lQ==
Received: by pali.im (Postfix)
	id D1F3C89B; Tue, 25 Feb 2025 21:07:38 +0100 (CET)
Date: Tue, 25 Feb 2025 21:07:38 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] fs: Implement support for fsx_xflags_mask,
 fsx_xflags2 and fsx_xflags2_mask into vfs
Message-ID: <20250225200738.gtgc3rdfpe5d4esm@pali>
References: <20250216164029.20673-1-pali@kernel.org>
 <20250216164029.20673-4-pali@kernel.org>
 <20250221182416.GA2252164@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250221182416.GA2252164@mit.edu>
User-Agent: NeoMutt/20180716

On Friday 21 February 2025 13:24:16 Theodore Ts'o wrote:
> On Sun, Feb 16, 2025 at 05:40:28PM +0100, Pali Rohár wrote:
> > This change adds support for new struct fileattr fields fsx_xflags_mask,
> > fsx_xflags2 and fsx_xflags2_mask into FS_IOC_FSGETXATTR and
> > FS_IOC_FSSETXATTR ioctls.
> 
> I don't think I saw an answer to this question (but the discussions of
> the mail thread have really sprawled a bit and so it's hard to review
> all of the messages in the thread) --- so.... what's your reason for
> creating this new fsx_xflags2 field as opposed to just defining new
> flags bits for fsx_xflags field?  There are plenty of unused bits in
> the FS_XFLAG_* space.
> 
> Cheers,
> 
> 					- Ted
> 					

If all bits which I currently defined in fsx_xflags2 should be instead
defined in fsx_xflags then in fsx_xflags would be only 2 or 3 free bits.

And it is possible that I forgot to include some bits in this RFC
series, or that Windows starts (or already started) using some reserved
bits. And that would mean that we are out of the fsx_xflags space.

Also there are 4-5 Windows get-only bits which are not covered by this
RFC series. It is questionable if they should or should not be.

So IMHO, we do not have enough space in fsx_xflags to cover everything.

