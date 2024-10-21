Return-Path: <linux-fsdevel+bounces-32451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC199A58C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 04:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287981C20C48
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 02:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157A71E4A4;
	Mon, 21 Oct 2024 02:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J9niu46o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7C914263;
	Mon, 21 Oct 2024 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729476525; cv=none; b=Tr5XJLLqZ4dncUOcCdpLU+A0t/cvLON+qEfOYScTAI5gQ9lRdzm4VV5nSqQcluPC2YKsTLdxlH2h7Hd9W1fbJSitsO4TBii92YdNKTtK+mzJZ3JPxmwmr+Z+mF+SOjD4YbjSAu1ovDyUdR5oX75NaPCvaBZgQT4ucyqzL43EUCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729476525; c=relaxed/simple;
	bh=Hlc4liwYrk+UmiuCwdlnGLI6VyqnqF83G+hi0FTq28k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Up5zCkOp4bA3XuIsbue90OqkAxFrMgw2RwEn4+RpZkpGEYJRp4KyVwjsM5/bfaaMkwrNsjxuyBbQ3E74IuZmumUWX1xOhdbZH94kdle5E01P0gnylqYKkireu0Kp8f3KYr8pBNd1f/pCwjvdwpxWghMh9LJrJNIOOXLitp9i+xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J9niu46o; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ck5fafN+3Mv78VP8udS4ZuOds55gNWU1JNihTpmcC6Q=; b=J9niu46o7JAvOQGXRLWvEEv9fe
	Av1dWRuYXdxTg8lbvfbNmptlW3m6yBG0pqUCnHtZnP6KuQthMRY1m/YbwtGi2yKFPfTOYqhPBcBdI
	CzbFPXGfV3mgf5+doR+nC7Uvj8YTfQ03ozB4UR1/1V2wesDyztyHvIYcfQR86B2pdT1FP6ypzanvN
	aaUyaPlg3hEcFv1t3E01kWh4mNDNNNQHAyXF7XiC85C46dkXntEVrsgd51YdgJybsKamhdz1/w/Yn
	KjBZYS4WfXdTkAFUmniThDKbm0vMA3iK98CN5do4pjaUx7I9iOVkUwDI6JoCXHFMWXDklGQicMfyV
	aSEa0srw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t2hqZ-0000000FmHe-2x8x;
	Mon, 21 Oct 2024 02:08:39 +0000
Date: Mon, 21 Oct 2024 03:08:39 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Benjamin LaHaise <bcrl@kvack.org>, linux-fsdevel@vger.kernel.org,
	linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: aio: Transition from Linked List to Hash Table for
 Active Request Management in AIO
Message-ID: <ZxW3pyyfXWc6Uaqn@casper.infradead.org>
References: <20241020150458.50762-1-pvmohammedanees2003@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241020150458.50762-1-pvmohammedanees2003@gmail.com>

On Sun, Oct 20, 2024 at 08:34:58PM +0530, Mohammed Anees wrote:
> Currently, a linked list is used to manage active requests, as the
> number of requests increases, the time complexity for these operations
> leads to performance degradation. Switching to a hash table
> significantly improves access speed and overall efficiency.

Benchmarks, please.  Look at what operations are done on this list.
It's not at all obvious to me that what you've done here will improve
performance of any operation.


