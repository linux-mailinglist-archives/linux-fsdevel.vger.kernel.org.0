Return-Path: <linux-fsdevel+bounces-20606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032478D5C7C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 10:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D40A1F2987B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 08:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB0781754;
	Fri, 31 May 2024 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hsfv1nU3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACCB78276;
	Fri, 31 May 2024 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717143260; cv=none; b=ngNXqkjmuGzpwGy6u4bUyeKInPMGh3GADVgzDnIvkQr5c+/dJ9N1SZXPJYlv4Ij6lfmt3iCliec34ES04rMTkzOHtEg1QYgWgK4okekW1K6fXf0508cVyAXKgdqO1GU2F4GPj2fNcOvMIS0Eym7DhURQ9Qg0rZMCz28STeOyTcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717143260; c=relaxed/simple;
	bh=L2wsg+UyGOMk0Z8wJlmeo08VtpIEFKjlqtaUhQDmXUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qghIkjK7OE9rd4mQaqHX6lNK+Uwh9Vlon/8RKuRtsKeGZvDcfmP9HpfaAp691rpoFEg4kzBHufwbahMoi1ict8RKTvIDR2Zgcwm7Rs7mv2N1ZV0HOQAxxljkLoxYOmTbrJxz+njwl8pBTFV7sV1GgFV9J4LMSHUgZVNaEl57nK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hsfv1nU3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zCPwI73R4MJQqX+IZ9CDgIEhpJs+l0IYh+oqHsV7kBQ=; b=hsfv1nU3pxWAGTPmsBQnTuh8pp
	WHIwLFYZ1Hink6MH2uwDexSiqz9mOEU9Lqw5reCTaPE/vnkTsYkew/6XnRbbePMnqHLsqIriKOsqO
	nN0RqaREbXpipEsSuBdZ1UySx6WgPstFPDbZ+Sc9FA8oTpCc4rzouziREPQRDdzUmAUy06Y6LrqYG
	tjfEXez5qeTV8T96lmsU9b9EIZrn7nmMOKgKT4JSmLY5HwuO+V61UwEv+7ycyAjFkRbkZBbeXMdj9
	peQXyRbt/oasf4aZQLN7clcZ32eWRKMTT96iIIMsigVQJ6Bol2cO6fIWy02vi487cdMjL4tei3J15
	4+GB8cCg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCxOv-00000009aJO-42ve;
	Fri, 31 May 2024 08:14:13 +0000
Date: Fri, 31 May 2024 01:14:13 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <ZlmG1Rss6gTgbSVT@infradead.org>
References: <ZlRy7EBaV04F2UaI@infradead.org>
 <20240527133430.ifjo2kksoehtuwrn@quack3>
 <ZlSzotIrVPGrC6vt@infradead.org>
 <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
 <ZlWVkJwwJ0-B-Zyl@infradead.org>
 <20240528-gesell-evakuieren-899c08cbfa06@brauner>
 <ZlW4IWMYxtwbeI7I@infradead.org>
 <20240528-gipfel-dilemma-948a590a36fd@brauner>
 <ZlXaj9Qv0bm9PAjX@infradead.org>
 <20240529-marzipan-verspannungen-48b760c2f66b@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-marzipan-verspannungen-48b760c2f66b@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 29, 2024 at 09:40:01AM +0200, Christian Brauner wrote:
> Yeah, that's exactly what I figured and no that's not something we
> should do.
> 
> Not just can have a really large number of superblocks if you have mount
> namespaces and large container workloads that interface also needs to be
> highly privileged.

Again, that would be the most trivial POC.  We can easily do hash.

> Plus, you do have filesystems like btrfs that can be mounted multiple
> times with the same uuid.

Which doesn't matter.  Just like for NFS file handles the fs identifier
identifier plus the file part of the file handle need to be unique.

> And in general users will still need to be able to legitimately use a
> mount fd and not care about the handle type used with it.

I don't understand what you mean.  If we hand out file handles with
fsid that of course needs to be keyed off a new flag for both
name_to_handle and open_by_hnalde that makes them not interchangable
to handles generated without that flag.


