Return-Path: <linux-fsdevel+bounces-59325-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5059B374B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 00:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B706220803D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 22:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480E62820B7;
	Tue, 26 Aug 2025 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BTelWHQl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43141DB127;
	Tue, 26 Aug 2025 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756245638; cv=none; b=OeLsBDJay5YO4uYNFpgRg2BvRANINwT5tI+qOVlTzHNF6VCCi8pNSBtke6gpSR+jrSKhXejJgcRgRNKS4VdXt+Ue9Buy6HTq1DRS8srPsUCVpWbfeOhwDxAYqB9Y4gilyqvyUtpilSmkY99xjUEx12nmReUAWUiGHEGkv15G03E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756245638; c=relaxed/simple;
	bh=nlAddIeElMyrZvjWgtWAT8j83cDwciEuvI0QuQmbjsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exgeIHuz+mEB9PrJaCi847+VWgAWlMoITbg4Rp9EK5kCNpkrPXTVmTu1Svc7WA1qlwoSmRZo6/LWX3QqnpURobGGZk4aqnp1Cl1746aWVxG2QT8vB87kxAJPUcSrVpFzaqkuVqg/rk1FK8n2+2yJGISAEb87KzaGJ2rxq4et9Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BTelWHQl; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Xq6ECnNUFHb2ro/LDs33wQ192q1812d2cTnWy54SPqs=; b=BTelWHQlw8A9q+HpPNkE3W9cPv
	LFF+M5pw0iZ3F1m4/a2luu5vqVIO0A57WOi6+ZlivXoASkKE8bjtOMeH/OTikJDBKf+2WwZ5DsQIN
	sFLNJaKPG6MCyLvjh5d0amCFpf2x5D9pHR6nJAJITDOkfpqPl0kkmXIfhukSdWoMuOqbi6npFfdkb
	CRfa6sGORge5TnyeU/myiy7L6lgmKmalaUspdfJGIT9ij/lX4LhsRRu5EpvIz0qNvVavPs6bXOCpN
	jkC34h+q2062yq9lUzjoikphbX+4bx/4Z0J/OJ0fIxCswX4Y0PBVNiD5Y5LSSNoYi2TnDbfvRSBPH
	WGqIMe4g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur1iT-00000007qDV-43gA;
	Tue, 26 Aug 2025 22:00:34 +0000
Date: Tue, 26 Aug 2025 23:00:33 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: ETXTBSY window in __fput
Message-ID: <20250826220033.GW39973@ZenIV>
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 27, 2025 at 12:05:38AM +0300, Alexander Monakov wrote:
> Dear fs hackers,
> 
> I suspect there's an unfortunate race window in __fput where file locks are
> dropped (locks_remove_file) prior to decreasing writer refcount
> (put_file_access). If I'm not mistaken, this window is observable and it
> breaks a solution to ETXTBSY problem on exec'ing a just-written file, explained
> in more detail below.
> 
> The program demonstrating the problem is attached (a slightly modified version
> of the demo given by Russ Cox on the Go issue tracker, see URL in first line).
> It makes 20 threads, each executing an infinite loop doing the following:
> 
> 1) open an fd for writing with O_CLOEXEC
> 2) write executable code into it
> 3) close it
> 4) fork
> 5) in the child, attempt to execve the just-written file
> 
> If you compile it with -DNOWAIT, you'll see that execve often fails with
> ETXTBSY. This happens if another thread forked while we were holding an open fd
> between steps 1 and 3, our fd "leaked" in that child, and then we reached our
> step 5 before that child did execve (at which point the leaked fd would be
> closed thanks to O_CLOEXEC).

Egads...  Let me get it straight - you have a bunch of threads sharing descriptor
tables and some of them are forking (or cloning without shared descriptor tables)
while that is going on?

Frankly, in such situation I would spawn a thread for that, did unshare(CLONE_FILES)
in it, replaced the binary and buggered off, with parent waiting for it to complete.

