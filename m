Return-Path: <linux-fsdevel+bounces-20400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D15E18D2C69
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 07:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8419B1F22EB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 05:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD69915B99C;
	Wed, 29 May 2024 05:26:02 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32DA15B973;
	Wed, 29 May 2024 05:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716960362; cv=none; b=avWVLI6FBaOoopOvMd7q5JsWBplR6P+zAtpWOaklb1BQLjdpNQAsCjhCDZL5QHHzCGw7wsikEk0OaVkehH9HXviQ66r15pXd0uWR0KYuDSZ3a0aqg9Zr6r5TOH6oZQinUzk6ywQHfwd5SZDHoS5WQLVmKxqhoFtOqNR5bvGQGpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716960362; c=relaxed/simple;
	bh=+u2pWKNmsu+c/DGMHN/WdlFPb6p34o0sN/9vYl0T4bM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GG3hJu/yg2J1uHsCfUmBoQKY9j/Wpjuu1hO4Nuea5rQ1N561Zc0rbvX6vUqnzImC7H0HOKe0zNtsKUmleq4Jj8mzuF1Vxa9Mokq7SkI1kXzlwtgso1anP9kUHMWOZLiPpxZzeAZhNziDEibWb5aTuMyQVNb4e0VDCkXbzY7Afws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6D2A068AFE; Wed, 29 May 2024 07:25:57 +0200 (CEST)
Date: Wed, 29 May 2024 07:25:57 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Subject: Re: [PATCH 7/7] iomap: Return the folio from iomap_write_begin()
Message-ID: <20240529052557.GC15312@lst.de>
References: <20240528164829.2105447-1-willy@infradead.org> <20240528164829.2105447-8-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528164829.2105447-8-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 28, 2024 at 05:48:28PM +0100, Matthew Wilcox (Oracle) wrote:
> Use an ERR_PTR to return any error that may have occurred, otherwise
> return the folio directly instead of returning it by reference.  This
> mirrors changes which are going into the filemap ->write_begin callbacks.

Besides the mechanical errors pointed out by Dave I really like the
new calling convention.


