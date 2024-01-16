Return-Path: <linux-fsdevel+bounces-8069-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F3982F1F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 16:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B4E1C23537
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9F51C69C;
	Tue, 16 Jan 2024 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="r4PQ/eOP";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="r4PQ/eOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803CB1BF3A;
	Tue, 16 Jan 2024 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705420491;
	bh=pjY2k+YByejaq83dLC4A1kRHxj3IpcdeBea5o5eMGtc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=r4PQ/eOPY10cMMN0Ex+dLgBhMtXUhoGRNDRlToKsA1pvZRbbNBT7JE0/0OR5YRjZK
	 IErSnnYepaPT2S5umKKMfWW5hCsGj5GjZOEpNSCPtI8XXvx9dDsBcFrXLRBFhMhbrI
	 cDEWC0o7VASAF32fW76AiHo1dmaN7bIdKSLoOlBg=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id BD42112801D1;
	Tue, 16 Jan 2024 10:54:51 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id xjhfFOwDRbQ8; Tue, 16 Jan 2024 10:54:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705420491;
	bh=pjY2k+YByejaq83dLC4A1kRHxj3IpcdeBea5o5eMGtc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=r4PQ/eOPY10cMMN0Ex+dLgBhMtXUhoGRNDRlToKsA1pvZRbbNBT7JE0/0OR5YRjZK
	 IErSnnYepaPT2S5umKKMfWW5hCsGj5GjZOEpNSCPtI8XXvx9dDsBcFrXLRBFhMhbrI
	 cDEWC0o7VASAF32fW76AiHo1dmaN7bIdKSLoOlBg=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AF76D12801C7;
	Tue, 16 Jan 2024 10:54:50 -0500 (EST)
Message-ID: <9283ad6dd8e911fa9861b0f31a47aa82474d9fd2.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
 lsf-pc@lists.linux-foundation.org,  linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-btrfs@vger.kernel.org, 
 linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>, Christoph Hellwig
 <hch@infradead.org>
Date: Tue, 16 Jan 2024 10:54:48 -0500
In-Reply-To: <ZaajUn0Idp90hLir@casper.infradead.org>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
	 <458822c2889a4fce54a07ce80d001e998ca56b48.camel@HansenPartnership.com>
	 <ZaajUn0Idp90hLir@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 2024-01-16 at 15:40 +0000, Matthew Wilcox wrote:
> On Tue, Jan 16, 2024 at 10:25:20AM -0500, James Bottomley wrote:
> > On Tue, 2024-01-16 at 11:50 +0100, Christian Brauner wrote:
> > > So when we say luksSuspend we really mean block layer initiated
> > > freeze. The overall goal or expectation of userspace is that
> > > after a luksSuspend call all sensitive material has been evicted
> > > from relevant caches to harden against various attacks. And
> > > luksSuspend does wipe the encryption key and suspend the block
> > > device. However, the encryption key can still be available clear-
> > > text in the page cache. To illustrate this problem more simply:
> > > 
> > > truncate -s 500M /tmp/img
> > > echo password | cryptsetup luksFormat /tmp/img --force-password
> > > echo password | cryptsetup open /tmp/img test
> > > mkfs.xfs /dev/mapper/test
> > > mount /dev/mapper/test /mnt
> > > echo "secrets" > /mnt/data
> > > cryptsetup luksSuspend test
> > > cat /mnt/data
> > 
> > Not really anything to do with the drop caches problem, but luks
> > can use the kernel keyring API for this.  That should ensure the
> > key itself can be shredded on suspend without replication anywhere
> > in memory.  Of course the real problem is likely that the key has
> > or is derived from a password and that password is in the user
> > space gnome-keyring, which will be much harder to purge ...
> > although if the keyring were using secret memory it would be way
> > easier ...
> 
> I think you've misunderstood the problem.  Let's try it again.
> 
> add-password-to-kernel-keyring
> create-encrypted-volume-using-password
> write-detailed-confession-to-encrypted-volume
> suspend-volume
> delete-password-from-kernel-keyring
> cat-volume reveals the detailed confession
> 
> ie the page cache contains the decrypted data, even though what's on
> disc is encrypted.  Nothing to do with key management.

No I didn't; you cut the bit where I referred to that in the second
half of my email you don't quote.

But my point is that caching key material is by far the biggest
security problem because if that happens and it can be recovered, every
secret on the disk is toast.  Caching clear pages from the disk is a
problem, but it's way less severe than caching key material, so making
sure the former is solved should be priority number one (because in
security you start with the biggest exposure first).

I then went on to say that for the second problem, I think making drop
all caches actually do that has the best security properties rather
than segmented cache dropping.

James


