Return-Path: <linux-fsdevel+bounces-8067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3778982F1B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 16:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F9A1C23670
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA41F1C2BD;
	Tue, 16 Jan 2024 15:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nRnVOlNl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B558A1C294;
	Tue, 16 Jan 2024 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UOSFk0nvbcxntL/e+i9swjB3N8ugf671tA7ZAfcaVpQ=; b=nRnVOlNlqU0wzY0eiRwHd6EoDE
	G0DXHIiF0yPgG2E26wxU70erTT984qSaoilmnEIpKpaywZ/oSnRDXhBiNLh+q6a4qMJbWobmUN569
	2AnaQp3vv5CMTAeTwmAQ3Y8GyBQBctlWiGzEkfQ+FanpCZP1CpoTkNzHLgJqa9oZTRLyrkxYWXQB+
	Zb+az/e6WwVObx/QgZht1ZY27IukrD12ia5yaWSxdBBsebYjqlGlB2dP3vsGQ/k72yHhUlRDyFOvr
	eRAG+eeu5RFzJU6Dv04nn4So8z1h/laLyeAZByuILfKNv2voWmvzV++x+ca0sTBa4TYEeszmrcfI1
	jSJFOvAg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPlXm-00DQxa-TK; Tue, 16 Jan 2024 15:40:02 +0000
Date: Tue, 16 Jan 2024 15:40:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Christian Brauner <brauner@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-btrfs@vger.kernel.org,
	linux-block@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Dropping page cache of individual fs
Message-ID: <ZaajUn0Idp90hLir@casper.infradead.org>
References: <20240116-tagelang-zugnummer-349edd1b5792@brauner>
 <458822c2889a4fce54a07ce80d001e998ca56b48.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <458822c2889a4fce54a07ce80d001e998ca56b48.camel@HansenPartnership.com>

On Tue, Jan 16, 2024 at 10:25:20AM -0500, James Bottomley wrote:
> On Tue, 2024-01-16 at 11:50 +0100, Christian Brauner wrote:
> > So when we say luksSuspend we really mean block layer initiated
> > freeze. The overall goal or expectation of userspace is that after a
> > luksSuspend call all sensitive material has been evicted from
> > relevant caches to harden against various attacks. And luksSuspend
> > does wipe the encryption key and suspend the block device. However,
> > the encryption key can still be available clear-text in the page
> > cache. To illustrate this problem more simply:
> > 
> > truncate -s 500M /tmp/img
> > echo password | cryptsetup luksFormat /tmp/img --force-password
> > echo password | cryptsetup open /tmp/img test
> > mkfs.xfs /dev/mapper/test
> > mount /dev/mapper/test /mnt
> > echo "secrets" > /mnt/data
> > cryptsetup luksSuspend test
> > cat /mnt/data
> 
> Not really anything to do with the drop caches problem, but luks can
> use the kernel keyring API for this.  That should ensure the key itself
> can be shredded on suspend without replication anywhere in memory.  Of
> course the real problem is likely that the key has or is derived from a
> password and that password is in the user space gnome-keyring, which
> will be much harder to purge ... although if the keyring were using
> secret memory it would be way easier ...

I think you've misunderstood the problem.  Let's try it again.

add-password-to-kernel-keyring
create-encrypted-volume-using-password
write-detailed-confession-to-encrypted-volume
suspend-volume
delete-password-from-kernel-keyring
cat-volume reveals the detailed confession

ie the page cache contains the decrypted data, even though what's on
disc is encrypted.  Nothing to do with key management.

Yes, there are various things we can do that will prevent the page
cache from being dropped, but I strongly suggest _not_ registering your
detailed confession with an RDMA card.  A 99% solution is better than
a 0% solution.

The tricky part, I think, is that the page cache is not indexed physically
but virtually.  We need each inode on the suspended volume to drop
its cache.  Dropping the cache of just the bdev is going to hide the
direectory structure, inode tables, etc, but the real privacy gains are
to be had from dropping file contents.

