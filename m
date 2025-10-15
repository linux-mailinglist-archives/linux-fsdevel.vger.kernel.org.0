Return-Path: <linux-fsdevel+bounces-64175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A4EBDBF9F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 03:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9EB0234D2C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 01:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499E42F8BC1;
	Wed, 15 Oct 2025 01:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0TcGRxhC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E9141C71;
	Wed, 15 Oct 2025 01:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760491371; cv=none; b=GUi9Qy38Unry4uS2IX6A6oNla0byvO4acbynjIdFKDWj0BA8HDlIa2APZ7VnK9j0a9+1y3B1d6x+hq6JM9g0gkAVwNfmpcPgtqDBjgRpC4kkBHtCfBRWa7MMj8BTMfoT9vSgabeFzR1ZaNrrC+hS8RFzm7WqP9/X+tR1+0w2Pl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760491371; c=relaxed/simple;
	bh=Yc5XGXuuN+qN0hyc0ljp9Q9Ff4KoJTRT8Q/X5IibrHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMLa6/BvKnWrLNYwU+nLb0riJf6EU9syqBE1lbrv0+iVL9BpAMRtFfMBw8OSh1oNlrcD8B+pmxvPKnTX2Z0ReY5gHGBZ+09nmiXDlDhbP1phYlkR7ZE+UE/r9QpOIWbrQEpPSpkgHUVWDsXZGnXX8KSvXyf/zFvVvcIfl7ZfZh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0TcGRxhC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=THZdcb8DllowJHnhCUQvYqJQSPdZJPLsVnMT6SOtwf4=; b=0TcGRxhCKoq89Ni7iOr5qY1ewO
	grLd3vPzNtuEDYvS+35V9FbmaHJHb6TWqqNIcofOHjvn2F6Ph3JwHXbzEAWRMh8NlqANhOkwqOKnk
	Ttazm8vEYz7pkvcpBe7aPkr833cz09ATTZkNHXg655xNpjnaCRZd7b8x1hGHx1Q0S+fOUtphQJmbT
	UoG9EQeFBgk3mBJN9Lnwab1zy3SjBIvRsjpDPvrW5p1zDVMxnUoqs/e6ztSPBrTYcCBcl8P1xI49z
	yPzx+evc8byqhj5Sn6kXUZhl4/pG0/Qbj79COwo1tBVuaVTLzjvID8ze9iJhuKkZz+Z7gzg8HdSQl
	aazYgT0Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8qDy-000000009Qi-01Ha;
	Wed, 15 Oct 2025 01:22:42 +0000
Date: Tue, 14 Oct 2025 18:22:41 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anand Jain <anajain.sg@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com, Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: Re: [RFC PATCH 1/1] ovl: Use fsid as unique identifier for trusted
 origin
Message-ID: <aO73YTmDIhHkg3XB@infradead.org>
References: <20251014015707.129013-1-andrealmeid@igalia.com>
 <20251014015707.129013-2-andrealmeid@igalia.com>
 <aO3T8BGM6djYFyrz@infradead.org>
 <5137ce36-c3b4-4a0a-83af-e00892feaf43@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5137ce36-c3b4-4a0a-83af-e00892feaf43@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Oct 15, 2025 at 07:46:34AM +0800, Anand Jain wrote:
> We needed cloned device mount support for an A/B testing
> use case, but changing the on-disk UUID defeats the purpose.
> 
> Right now, ext4 and Btrfs can mount identical devices,
> but XFS can't. How about extending this to the common
> VFS layer and adding a parameter to tell apart a cloned
> device from the same device accessed through multiple
> paths? I haven't looked into the details yet, but I can
> dig it further.

If you clone a device you need to change the user visible uuid/fsid,
and you need to do that explicitly to a known either saved or user
controlled value.  Assigning a random ID is highly dangerous as seen
here.

