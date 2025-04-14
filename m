Return-Path: <linux-fsdevel+bounces-46338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A596A87788
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 07:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB631890487
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 05:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A9F1A2387;
	Mon, 14 Apr 2025 05:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TFLkexAK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357A7E9;
	Mon, 14 Apr 2025 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744609828; cv=none; b=aJR8BNfgZEWKh8hJ9U6WSf/SxB+G9OjBcf1+yFIKw1tBOrd8RJ/HAyuSUcV1IZEW1t+nMxF1tWiOqV3dBzNz52xzHkVV/YvGi511hziQKAtJpUuVGjTPYqHxqxfi8GJNekiyo0pHTzbdcJN8mVPrebgFq8bS16KFdP0JW16xB/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744609828; c=relaxed/simple;
	bh=881fi5n6EjpFIfi0/uwh+BWCbmaHpVW5SERdmpINOcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGBfYp1ZL3zXNs7gIuZLWBxKW8YhJH9IFIj9NJl67Zz6XQuzhVPVDraTqQN97AKi9zK3JhubFD8nPfx+jqsIFtr0UMimxShrmNdFfksgpOYQu2kv7WPRVwx3qOjxskJKFSNjQAZwVuD3HgjyTv+Bt9lPVdnTkGTagUYVCpRfwa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TFLkexAK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tDxqy4p3pRGq8t3Xh+ei9Nkz/gDs3KqrzXyGdV44/Xw=; b=TFLkexAKJq+DgVSB0g1NTFgHVP
	p14DfcBFwRBbxcE9OPrz8Hac95rqiEx9ZaXTOiMZl5L11l2YzngddGsLxVsvYzHHakg0MiNe1PDGj
	h/5hkKWk+6ft6Dywo2MnEOQl9kpwtVtMb/8XEJG70xOMTW0/CxuI/EDWxsgnV2VuyVywuRnd3b7o9
	YEhlpCh9FBYl70gQuMZJIr0xKHI8Zv2YK0HaMexawz2CbvEqoZqZuMzhSPVseaLjryoGm0tuLxymP
	brXgcHwevep0vXlYYPISRpFlbC8ncdqprFGUBYg34rtHHGsBT1HO2oRASPAjYm6a1WqgoAJJmDthC
	awR/g3TA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Ci9-00000000jmk-0mgF;
	Mon, 14 Apr 2025 05:50:25 +0000
Date: Sun, 13 Apr 2025 22:50:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	syzbot+5d8e79d323a13aa0b248@syzkaller.appspotmail.com,
	stable@vger.kernel.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH 1/9] anon_inode: use a proper mode internally
Message-ID: <Z_yiITQbTzPY28Ig@infradead.org>
References: <20250407-work-anon_inode-v1-0-53a44c20d44e@kernel.org>
 <20250407-work-anon_inode-v1-1-53a44c20d44e@kernel.org>
 <7a1a7076-ff6b-4cb0-94e7-7218a0a44028@sirena.org.uk>
 <20250411-feigling-mutlos-2a6603ccebb3@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-feigling-mutlos-2a6603ccebb3@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Apr 11, 2025 at 05:03:55PM +0200, Christian Brauner wrote:
> On Fri, Apr 11, 2025 at 11:31:24AM +0100, Mark Brown wrote:
> > On Mon, Apr 07, 2025 at 11:54:15AM +0200, Christian Brauner wrote:
> > > This allows the VFS to not trip over anonymous inodes and we can add
> > > asserts based on the mode into the vfs. When we report it to userspace
> > > we can simply hide the mode to avoid regressions. I've audited all
> > > direct callers of alloc_anon_inode() and only secretmen overrides i_mode
> > > and i_op inode operations but it already uses a regular file.
> > 
> > We've been seeing failures in LTP's readadead01 in -next on arm64
> > platforms:
> 
> This fscking readhead garbage is driving me insane.
> Ok, readahead skipped anonymous inodes because it's checking whether it
> is a regular file or not. We now make them regular files internally.
> Should be fixed in -next tomorrow.

Is this the readahead syscall?  Yeah that random check in the high level
code looks odd if that's what is being triggered here.


