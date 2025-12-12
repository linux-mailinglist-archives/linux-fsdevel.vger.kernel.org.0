Return-Path: <linux-fsdevel+bounces-71216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4421FCB9E1E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 22:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 316093069C82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 21:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBFE42C2366;
	Fri, 12 Dec 2025 21:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="CYOfenLP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9B429D292
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765574676; cv=none; b=hciqpSQLxbmyltACXKJ3mSfFcb6oqVKSgzuUDEN2t+ZnmLD3JdCfGari+LpKPzfHsnrNjbQtplwKlKJTkN1fakSAbeiZG8GPnz1CGuXzlP8ywXYjhcF7z8moUW+lfha7qx65UE8oAhLwy7XqAG0WT7yiTEy/EqwEeFbnsMtfRkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765574676; c=relaxed/simple;
	bh=X/4Z7SrDuVXWWE62ndZmLPG3EeTgZBdcPp/qNqK+1RY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gg4hUqHrvCKHdZRbBkqAy6mxLGwfjgeJHoS5KYysmrZrZ609Ep5YEiId9JDEJ5iyQYf8x/vxXr/KARAJfsFtwKmEIVxdV/aWgn4PzdS+CsdgXTMZqBA2fThmqmYANisUPeF7Sba9RGsgr5PGUI3n5uNYpmHhMhaznp9sNt5Xut0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=CYOfenLP; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (fs96f9c61d.tkyc509.ap.nuro.jp [150.249.198.29])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5BCLNuWR014791
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Dec 2025 16:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1765574641; bh=qHLet6Tl+yPkw/ylxl3cL1yEvDFcpp5ou1YH4RSNVm8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=CYOfenLPVkZm2rBcGLhUDM1NJUZvmOGO1Vx6gG1fkCpSmD40VRP4qK7RXVy5M2Im9
	 Y1BO2zlsRf6PcSft6qPt6wumrWlg637b+ZMT5epch/H3YyaPfHVczFTl+rt10EeqcV
	 IUY8u8uN8fxKj7pj2dqVhk5UHt1evm5cSzF3vceqEExy3TyH5ynWc6kYn0iDnvcqeC
	 4C7sOD4lwFuf5+8S4Ppi4CQcvBwHoj7fvqE4CAMqyz7pOYVuHli4OBK6gvMlD1kE5Y
	 23uyKBfEwHnkvhNCiZJLVtlAzjVrFOA8Pty5/3+mWVt47WQr+FkEuPP+1kcjpBWSbL
	 LwgE0hQiuUg4Q==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id 0C0314FCD4B2; Sat, 13 Dec 2025 06:23:55 +0900 (JST)
Date: Sat, 13 Dec 2025 06:23:54 +0900
From: "Theodore Tso" <tytso@mit.edu>
To: Chuck Lever <cel@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp,
        almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
        Volker.Lendecke@sernet.de, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/6] fs: Add case sensitivity info to file_kattr
Message-ID: <20251212212354.GA88311@macsyma.local>
References: <20251211152116.480799-1-cel@kernel.org>
 <20251211152116.480799-2-cel@kernel.org>
 <20251211234152.GA460739@google.com>
 <9f30d902-2407-4388-805b-b3f928193269@app.fastmail.com>
 <20251212021834.GB65406@macsyma.local>
 <ed9d790a-fea8-4f3e-8118-d3a59d31107b@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed9d790a-fea8-4f3e-8118-d3a59d31107b@app.fastmail.com>

On Fri, Dec 12, 2025 at 10:08:18AM -0500, Chuck Lever wrote:
> The unicode v. ascii case folding information was included just as
> an example. I don't have any use case for that, and as I told Eric,
> those specifics can be removed from the API.
> 
> The case-insensitivity and case-preserving booleans can be consumed
> immediately by NFSD. These two booleans have been part of the NFSv3
> and NFSv4 protocols for decades, in order to support NFS clients on
> non-POSIX systems.

I was worried that some clients might be using this information so
they could do informed caching --- i,e., if they have "makefile"
cached locally because the user typed "more < makefile" into their
Windows Command.exe window, and then later on some program tries to
access "Makefile" the client OS might decide that they "know" that
"makefile" and "Makefile" are the same file.  But if that's the case,
then it needs to have more details about whether it's ASCII versus
Unicode 1.0 vs Unicode 17.0 case folding that be in use, or there
might be "interesting" corner cases.

Which is why I've gotten increasingly more sympathetic to Linus's
position that case folding is Hot Trash.  If it weren't for the fact
that I really wanted to get Android out of using wrapfs (which is an
even greater trash fire), I'd be regretting the fact that I helped to
add insensitive file name support to Linux...

						- Ted

