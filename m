Return-Path: <linux-fsdevel+bounces-25927-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2527A951ED5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 17:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5FD72878AB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 15:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649991B5808;
	Wed, 14 Aug 2024 15:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="uHkEEBJj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4CB2E62D;
	Wed, 14 Aug 2024 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723650263; cv=none; b=tHNbnHs9Kd3fvVLVvDzxjA2PzljoaAOOrw8CAie9R73ijlSWoN9iFPHoSgrCHPBtbiXZAIip8O1F3vnb2lUIaScXIZoqix1O7XOVUHFUa8j0N+Mo16WVR1Uu7MYnX5kfBxUFxxuEK2P2tPBjN+yHR2s6DSwHXIxM2SKkZq9nj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723650263; c=relaxed/simple;
	bh=GIJ9zOPnHLzaTwF8vHsK12pibqj4o2ked5+CTTr35cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leCJnj6wMHSbNpTy2Evg4iSL7X14otvXK1rfV/a5FO+zw+KMmmmUIgQlNxKwHTF9FJiS7uheIbhxkfak3KNtqZvnD8P2e8fF9HjycRnaIX3mPMuOHSpAKQBt/c6z1XO3DR0IeyOCZBrYMerS7k5E9sE6pNU9yCJVC5IFL+ur9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=uHkEEBJj; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O5siPism3hnlKEybU5JUKZDF33KhFALxm9RiaLMBk48=; b=uHkEEBJjdHd7Rt9VW0xBOcNO1K
	asN/RhU+qw+i0r7XnTl4+WRv8NZkj2walfMsCBVv16Xw/ta+u0EKjWWmjFTt1jlZMU8KHcMtBKzql
	voR3GjRNSDJk/x+YBobH+TTiA38j1QBmD5P1rZUGSZvOfxO5j7TFMw7AZRcJnX2V7X1tzw2Bb0elX
	QamJWE1ZyrfPbdDRwkgonntY3+SJqpRxPuf9ooN3L+CqhbbLqULpFjrfNdE98y0ZwiKjPmHtq/DEw
	AzJeY7+GT9YS8uv4Pw/WzYfedtGPgGt7FOlpOcLzYJ7T+/s0pkx0Am3TcyW50THbNSIqTJrhgwlJ2
	a4N7Ljng==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1seGAd-00000001eTY-0SYa;
	Wed, 14 Aug 2024 15:44:19 +0000
Date: Wed, 14 Aug 2024 16:44:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: try an opportunistic lookup for O_CREAT opens too
Message-ID: <20240814154419.GT13701@ZenIV>
References: <20240806-openfast-v2-1-42da45981811@kernel.org>
 <6e5bfb627a91f308a8c10a343fe918d511a2a1c1.camel@kernel.org>
 <20240814021817.GO13701@ZenIV>
 <20240814024057.GP13701@ZenIV>
 <df9ee1d9d34b07b9d72a3d8ee8d11c40cf07d193.camel@kernel.org>
 <20240814-visier-alpinsport-027f787afa2c@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-visier-alpinsport-027f787afa2c@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 14, 2024 at 02:40:23PM +0200, Christian Brauner wrote:
> > Christian took in my v3 patch which is a bit different from this one.
> > It seems to be doing fine in testing with NFS and otherwise.
> 
> Every branch gets tested with nfs fstests (in addition to the usual
> suspects):
> 
> Failures: generic/732
> Failed 1 of 600 tests
> 
> And that just fails because it's missing your 4fd042e0465c
> ("generic/732: don't run it on NFS")

connectathon would be more interesting...

