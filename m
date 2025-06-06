Return-Path: <linux-fsdevel+bounces-50804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4895ACFBC7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 05:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EA4C7A1862
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 03:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7891DE892;
	Fri,  6 Jun 2025 03:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="K6sfMvpF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD531D0F5A
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Jun 2025 03:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749182320; cv=none; b=gn3xCw1eSJwTtM0MWEGJpGQVJWKjNycZqH44QrbrMyyYZ4xX9ReBVlbcUc0TXBL+56qMZg6a4czyYMCLxCWG83OTixKL6QnVfZyvTcJamRWK99/CKYqo11tNUMXboJmx7rGDuIFEhcVZcXtvb1Kn6kZeU4EoDjGxKl8u162n+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749182320; c=relaxed/simple;
	bh=9aAgIUvKhymwQ25VFWcpzwUlQXLQoXiA5LIItLQk96s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZooTz9WzDvor77n08PvBWAI4COgm34856SlBejy+Ol3qeY7ynB2jmADpEfsBvJNN/arjiv3TOMXglG437/zhONRWKGpK/mpGzTIQQ6WTK3wh8IN5FWcIoD3sH94zC1TafPdJP65Pv4mNJGXC+Ooef0GzHYaDTV7c37Z4I+BNz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=K6sfMvpF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9aAgIUvKhymwQ25VFWcpzwUlQXLQoXiA5LIItLQk96s=; b=K6sfMvpFFsY2p8Q5VV6dNH7j8A
	4JohMRTKf5T4yiaeYM+Ly1Xb/623YnUo6p6bHqvYmq9VjLisTEFBYwRA1ubnLgajPeIabVTKDZ1M+
	XmIS18cDIhIhabA58+cCvAPF7ZGHIphJG6WLvkpMUQ84chu3Mmvq5gBHP698+Eq80K+3o1VrHm2uz
	55ygKtc1YYpszdmMihZHWrdxVtiLzTF9gkG33SpU8OHRyH7mCZmTVyROmPsoJGtYv2pITdteuPLWo
	/PGECDqfXWIP45tI5i9TmbbWxaXOglJ4PrE9KK2GUnKYGGy8duunjbiUIdPb7v1THMlwCyzyg4Ebv
	tFHX6R3A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNODy-0000000BRaX-0cJC;
	Fri, 06 Jun 2025 03:58:34 +0000
Date: Fri, 6 Jun 2025 04:58:34 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: wangzijie <wangzijie1@honor.com>, rick.p.edgecombe@intel.com,
	ast@kernel.org, adobriyan@gmail.com,
	kirill.shutemov@linux.intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: clear FMODE_LSEEK flag correctly for permanent pde
Message-ID: <20250606035834.GQ299672@ZenIV>
References: <20250605065252.900317-1-wangzijie1@honor.com>
 <20250605144415.943b53ed88a4e0ba01bc5a56@linux-foundation.org>
 <20250606015621.GO299672@ZenIV>
 <20250605204442.4a2e98b8feb6fc3603375b66@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605204442.4a2e98b8feb6fc3603375b66@linux-foundation.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jun 05, 2025 at 08:44:42PM -0700, Andrew Morton wrote:

> It's a fix against the very recently merged
> https://lkml.kernel.org/r/20250528034756.4069180-1-wangzijie1@honor.com.

IMO it's a wrong way to handle that - see upthread for a simpler
approach...

