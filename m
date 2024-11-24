Return-Path: <linux-fsdevel+bounces-35657-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 430299D6C7E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 03:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD59E161749
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 02:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44DD1E53A;
	Sun, 24 Nov 2024 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="JdQxkdGv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08BC1FC8
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Nov 2024 02:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732415516; cv=none; b=F+ZD9Gq858zt0sTVbCFpzMtYImSROPz5QgPj3As37KkVOb22n2fxOgmN7ZBFZnFuLN6xUVqXzen7I3g3UYlR1/q1bZd09G1Jf2zXtyXy/0J4HoxO92oZ1XPITFOM8X53tyJSa3iqezK3CyBVMElxDukozqqRfe8eoUbJCiayhSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732415516; c=relaxed/simple;
	bh=JVPNQKi05pxv8edbI23zQiTDhszhaVeb5AStLzYC6VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7mbZkt/TzNPK9gUZXkbGdnJJTYZ5dZh17jkD025y1xCIpCEsh3FlO0ZWvIOwOhjiw2UWRrXEZArmgKmILkwMzit4uhKgoq7JRWF6bheQ0xjdUFQJC+MmZStzUbuV/GXeTk2sohaPynP/3PuiAchz+2Ho+29l1GxipWRSJLFXoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=JdQxkdGv; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org (syn-098-147-040-133.biz.spectrum.com [98.147.40.133])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4AO2UPXs009591
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 23 Nov 2024 21:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1732415429; bh=tMYA3FuEfBdwg4uY/IL9dl9TyQ4GzJOPWzyUfUCOSHA=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=JdQxkdGvV2bFkTsn7WTIo6NEBtphYwCkSJ6xu+YMGMQ0uBY+Uozz2K7D3i2KdFEom
	 pzzViQesUzyVmQn9UCBQzytLm2nClYskc9bgiTHJl0ioCVtoGXMjWtZSMeLp07Ik0i
	 pjedn6lKdiZFbEJGjjHyEJH+t4nNXjl2txuLwBF4gmqNIztqUwyAOeowEVy48OkVyz
	 jSE3u5TNS8P/MskfjAjhacYpyl07VaCEkZ3pN9w5XsxO2a3h32yrSQfpMudJwrSObJ
	 JZlkcN/7lStPMw/G3srGEuOjrMa5xI1vpprVldBTcFV5KDCh1gN4S4/dzbej7fX0iQ
	 vzXBFmfESkWVg==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id EA59E34125E; Sat, 23 Nov 2024 21:30:24 -0500 (EST)
Date: Sat, 23 Nov 2024 16:30:24 -1000
From: "Theodore Ts'o" <tytso@mit.edu>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jinliang Zheng <alexjlzheng@gmail.com>, brauner@kernel.org, jack@suse.cz,
        mcgrof@kernel.org, kees@kernel.org, joel.granados@kernel.org,
        adobriyan@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, flyingpeng@tencent.com,
        Jinliang Zheng <alexjlzheng@tencent.com>
Subject: Re: [PATCH 0/6] Maintain the relative size of fs.file-max and
 fs.nr_open
Message-ID: <20241124023024.GB3874922@mit.edu>
References: <20241123180901.181825-1-alexjlzheng@tencent.com>
 <20241123182730.GS3387508@ZenIV>
 <20241123193227.GT3387508@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241123193227.GT3387508@ZenIV>

On Sat, Nov 23, 2024 at 07:32:27PM +0000, Al Viro wrote:
> 
> 	You won't find the words 'IO channel' in POSIX, but I refuse
> to use the term they have chosen instead - 'file description'.	Yes,
> alongside with 'file descriptor', in the contexts where the distinction
> between these notions is quite important.

What I tend to do is use the term "struct file" instead.  The "file
descriptor" literally is an integer index into an array of "struct
file" pointers.

"struct file" is how things are actually implemented in Linux and most
Unix systems.  And while it's admittedly ugly to use an implementation
detail as an abstract term, it's infinitely less ugly than Posix's
"file description".  :-)

						- Ted

