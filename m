Return-Path: <linux-fsdevel+bounces-58900-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7192B33354
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 01:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25B6F17A823
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Aug 2025 23:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1D525291B;
	Sun, 24 Aug 2025 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GHZmqsLW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704BA163;
	Sun, 24 Aug 2025 23:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756078831; cv=none; b=gsR4A20/PxiV/1DNxjJl8L5FbYHAp19MRgiZwNMZPMTexO8DZqdCB0F/uGe2tCsyTteXAPnJqLpJxIjNDJOsmN6saOae9IVwy75LmZREj0q1utCeYdrUd/4NYuFBx3/myw8UlO84qL85D2iDzciRaOeGr9ef+ZI5IJEsirytn2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756078831; c=relaxed/simple;
	bh=sEcGM/jZeRPtQpYYLqS5XmGgHrcWKcSNQEejr4wAGsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ll+Yj0dzd3oja50uU9xHjxceTvL37J9ksTAGx6zy4MOXZRIYAg0o8Em5Cv/OY53t0+HTPLaHt1gBc13xp/vt/1n0WdbCMLtncBIDjIyAQGxcjpLgmcZjodmzB9WNtZHJkqdkHjKbbaNBfNoig3+cvWUstrTFa5KlPLpqWhUp+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GHZmqsLW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oCLlzBPkpeVi0vqq3OHL7zA+MsRdFDKGKeZXZFCdHF4=; b=GHZmqsLWMDu/NSZsLxBgoh85Qh
	MQ8J5WWTT41cXGnyGuaBDikDRgkn3Ix7P9pwdX5wwYaq7QN/tWISx3tnMARf2BjN0Kdx/tMl/BrmV
	Xq+b2vw8lYe7eCPsewr6YoIcnpUhlCoMzA5E8BH65rBfMuAg2GcHmJPNqQqEymaFNG/VLLE8KfFcB
	o3+pwypuCZbjl8JCRUqvAiuCUoCqjS3bOzDXQeaDa6NRaTEX2aKjaXTgjNQgtbfFCCCy54b8/G8Z4
	0E7WnAZh/19AT59Hmh77l38bCLq4S8f1Cavu2Ug437KHM1L7dZ9ZlMohM354qimCkD21tmIUEP2M1
	AzMw26Aw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqK1c-0000000FKmh-3uyC;
	Sun, 24 Aug 2025 23:21:25 +0000
Date: Mon, 25 Aug 2025 00:21:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] uapi/fcntl: conditionally define AT_RENAME* macros
Message-ID: <aKuedOXEIapocQ8l@casper.infradead.org>
References: <20250824221055.86110-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250824221055.86110-1-rdunlap@infradead.org>

On Sun, Aug 24, 2025 at 03:10:55PM -0700, Randy Dunlap wrote:
> Don't define the AT_RENAME_* macros when __USE_GNU is defined since
> /usr/include/stdio.h defines them in that case (i.e. when _GNU_SOURCE
> is defined, which causes __USE_GNU to be defined).
> 
> Having them defined in 2 places causes build warnings (duplicate
> definitions) in both samples/watch_queue/watch_test.c and
> samples/vfs/test-statx.c.

It does?  What flags?

#define AT_RENAME_NOREPLACE     0x0001
#define AT_RENAME_NOREPLACE     0x0001

int main(void)
{
	return AT_RENAME_NOREPLACE;
}

gcc -W -Wall testA.c -o testA

(no warnings)

I'm pretty sure C says that duplicate definitions are fine as long
as they're identical.

