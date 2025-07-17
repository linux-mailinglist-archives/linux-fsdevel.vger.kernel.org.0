Return-Path: <linux-fsdevel+bounces-55267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6C9B0911A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 17:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60D41C42CEE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 15:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C02B2FE334;
	Thu, 17 Jul 2025 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAqZq/Yh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C7B2FE300
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767758; cv=none; b=dl1+eSiGHx51CFrCiL0xnC+M7v76VOCJ48FhoJT9rvGI3wAyqNfmmXU7y+WtnaAcMOebZ3JOkIhgg60TzZkjsljTnuvHHTqtrYFufIgqJPpUTkP9WZSyXthcFIlLiXBq1nOkDr/Fipi+lfL9dB0yrohV9AJYShxDVRjFrJ9GECA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767758; c=relaxed/simple;
	bh=73KR7+UVa7LWn9yXG1yU352YsEdSp6LEF0xHgApDvgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyzJrc9AjbgPl7J9LLD/tsTkSBmOX3qL3UBC6z15wXiw1qMs6w5SXUuegLTd9gwCLl96pJOFUQrBTIDhwzwZlX26CfuvgecMdSkRjx+93NpF4j9pGEvDPnRbxmlqiD0aaV9a2HzrlUT8nTckZ74Vc0cHlUm0Q3ToNXMSvzKx+kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAqZq/Yh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DDAC4CEF4;
	Thu, 17 Jul 2025 15:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752767757;
	bh=73KR7+UVa7LWn9yXG1yU352YsEdSp6LEF0xHgApDvgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dAqZq/Yh2F8c2ZidT1YkIL7FcC2qtM6J4Kgo7I7Xli5BENaTGpFR+/7WcQUOgza+5
	 ncNpaKBkxtnPzqWDZyxYhVlPlJzDelz1Yjn9QvKmF9fohmqS+k8YRSY8jxIvyGjgPs
	 p7GmTjk/EK7nr3pG28Y3fUG1NO+m6Wrm3L88ZIyGDyDEn5QBwwqQdq+OxgF5sOTWAu
	 dqmrOUBkcogGg1RhASx24BjBgIuNZWM2nOG+vouefxtgpBFzA3KUuPsoMUZUi1CrQv
	 eE0gl06bcM9xB+kyYn1LrsWJ4zwaEqT1SwxyLNabSxf1XB6UKJWh2kdhWUSgbmwYpy
	 llcpyvwZXodfg==
Date: Thu, 17 Jul 2025 08:55:57 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
	Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250717155557.GP2672029@frogsfrogsfrogs>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
 <aHZ9H_3FPnPzPZrg@casper.infradead.org>
 <20250716130200.GA5553@lst.de>
 <20250717-studien-tomaten-d9d1d7b5e6e8@brauner>
 <20250717075123.GA1356@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717075123.GA1356@lst.de>

On Thu, Jul 17, 2025 at 09:51:23AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 17, 2025 at 09:48:49AM +0200, Christian Brauner wrote:
> > On Wed, Jul 16, 2025 at 03:02:00PM +0200, Christoph Hellwig wrote:
> > > On Tue, Jul 15, 2025 at 05:09:03PM +0100, Matthew Wilcox wrote:
> > > > will be harder, we have to get to 604 bytes.  Although for my system if
> > > > we could get xfs_inode down from 1024 bytes to 992, that'd save me much
> > > > more memory ;-)
> > > 
> > > There's some relatively low hanging fruit there.
> > > 
> > > One would be to make the VFS inode i_ino a u64 finally so that XFS
> > > and other modern files systems an stop having their own duplicate of
> > 
> > That's already on my TODO since we discussed this with Jeff last year.
> 
> Cool!
> 
> Btw, I remember anothing I've been wanting to look at, which is
> killing the u/g/p quota pointers.  If we used a rhashtable with
> proper sizing for them, doing a hash lookup instead of the caching
> should be efficient enough to be noise compared to the actual quota
> operations.  That would free three pointers per inode, or in case
> of XFS six without the optimization in this thread.

That would be really nice. :)

--D

