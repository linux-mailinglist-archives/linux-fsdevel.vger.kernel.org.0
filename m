Return-Path: <linux-fsdevel+bounces-70041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D659C8EFFE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 16:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D63435287E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 14:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87B433439C;
	Thu, 27 Nov 2025 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gzGRz7nQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5759733345D;
	Thu, 27 Nov 2025 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255520; cv=none; b=J71FrZbD5jCxwXaEcuF1UaqfCKZ5n/h2oR/AI/DXJi1pCWyfRzwKU3OhRKQRqpoIvjMElubVX+3Gm4VaR0HXCc4qWq1I8ZJXxD5rzoD5MKLlZabixgK9rmGP1w9pAHFsqXhC/xI2Tr9DGsfDrJwP1qzgqeP+dLHtv+HJghuZCjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255520; c=relaxed/simple;
	bh=5ek7TxH/+G95acio5NNlq3dy1bIajU0CfXiWIWWkIrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9UrMxklQ+jXBBH6Ad93E8tyaSGERbAgRFgOr+AIf1qSueNskXed5Andt9a4T4uSeF7bXcSaL/tSXwoRBjqu2JyDQwG9RaSzExpBP3MQAR5+D8EJosNwvkW8M5N2PiclGWLgmEBE3drhYzOidpLsznCIVtd1mgufVfPPFK/QltQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gzGRz7nQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=v4mZULo7WgpYkCYkWTL1i6nQBYL06FBy/2XHswFKhCo=; b=gzGRz7nQ40m6HkPauwf21V/69x
	qFda+R2HuHNeRtI87pXQYsqp8C5YBoleTi3ZmkXDRTMbIsvDf3FPzGvp4qVtFdfBZVy+pKg/dCrvP
	SMxPYx7wdr4R5Z3DfnziTKn6fjvhS84ukJ3vyP7PCQM71L/7vkAHll5pwoXIciXivrtHjRLFIo56Z
	BNED3wsqkYEegps1oECFvcbFjQl+DHsXp0dT6eyOP1vgnidkzo256AIAwASEyR3q55PvbpdADGdMM
	E6AWiTBZarDlGENdMvMBcRPt41FEgCDWC28DGYoTNEmZjRTCj4yDIXYxvZeu1Z8fO0xN0monVDevA
	d9C/bDRA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOdS1-0000000Bt0X-3P5j;
	Thu, 27 Nov 2025 14:58:29 +0000
Date: Thu, 27 Nov 2025 14:58:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, hch@infradead.org, hch@lst.de, tytso@mit.edu,
	jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com,
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org,
	dsterba@suse.com, pali@kernel.org, ebiggers@kernel.org,
	neil@brown.name, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com
Subject: Re: [PATCH v2 00/11] ntfsplus: ntfs filesystem remake
Message-ID: <aShnFRVYMJBnh4OM@casper.infradead.org>
References: <20251127045944.26009-1-linkinjeon@kernel.org>
 <CAOQ4uxhfxeUJnatFJxuXgSdqkMykOw+q7KZTpWXb8K2tNZCPGg@mail.gmail.com>
 <CAKYAXd98388-=qOwa++aNuggKrJbOf24BMQZrvm6Gnjp_7qOTQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd98388-=qOwa++aNuggKrJbOf24BMQZrvm6Gnjp_7qOTQ@mail.gmail.com>

On Thu, Nov 27, 2025 at 09:17:54PM +0900, Namjae Jeon wrote:
> > Why is the rebranding to ntfsplus useful then?
> >
> > I can understand that you want a new name for a new ntfsprogs-plus project
> > which is a fork of ntfs-3g, but I don't think that the new name for the kernel
> > driver is useful or welcome.
> Right, I wanted to rebrand ntfsprogs-plus and ntfsplus into a paired
> set of names. Also, ntfs3 was already used as an alias for ntfs, so I
> couldn't touch ntfs3 driver without consensus from the fs maintainers.

I think you're adding more confusion than you're removing with the name
change.  Please, just call it ntfs.  We have hfs and hfsplus already,
and those refer to different filesystems.  We should just call this ntfs.

