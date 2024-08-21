Return-Path: <linux-fsdevel+bounces-26472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE47959CA4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 14:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08616B22FDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 12:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42914199254;
	Wed, 21 Aug 2024 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m6kOdOBD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1954816C685
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724245071; cv=none; b=kr9VuZX0XcHvTuaMZgfUu29Tw0R0LpnTwE0br4YB8D6eiQVzoIYmLkHjaxZqFzZkRVjjKY+AabmvA8WmtzmWxWYQAYlM7umpTgWcsWDkC8cReLBdkHGAUX912elS7F80SCM3h+93YW1l3wv/Nldwd+OwTVmJKVExW3ltXq/qFaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724245071; c=relaxed/simple;
	bh=xzwAjAvPx3w/jam48mJ/94xhJQ3XrYfVNqsdPjkHG3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAaIxsbZ+f+uEu6PrCtSaxmBlnhCkYsaYD9yCfCivvoGJm4cyoOun4ltFwYhTeY+zTGGFjUxzzXTBQHQBtH+CLpP4JiczpNonoq9I4zxR+SqBXRu3lCqJanV83ZgO15yEIaBSdp1sVe4gSpt+8/UGKDmSbpLYqotr7wWerMZjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m6kOdOBD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xzwAjAvPx3w/jam48mJ/94xhJQ3XrYfVNqsdPjkHG3U=; b=m6kOdOBD3vNeCWWY3QWy/yCVbI
	HnZ2XrQZyhddwHyRaiISedamTOrGPicLnYSIBjRVozGEXGL9zpiV0GWpTel/p1jZqpei5C1KSfjeV
	BU32WasYAeALM0b2cPwfNXprfpRHcKJ28GTaGdvaxOXVfrDHVqc5ROAd1v+icVV3oG10K39nAd0Cf
	nX9HPbZT7vpKVsilxd7/kqAv/HLIa9TowUpisU9HuiEyU6H0/tADLP3YSeqn1BSw2HoV14biwYRb5
	CvwDF0tP9TgQuGmPGeVk/HOKDKxoRKJmo6PZZV1AsiJ8Y8WDi1xHmad5JckM5NhcNfESrEtvb5rY1
	XxaF6CDw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgkuG-00000009DlI-2TRg;
	Wed, 21 Aug 2024 12:57:44 +0000
Date: Wed, 21 Aug 2024 13:57:44 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH -next] radix tree test suite: Remove usage of the
 deprecated ida_simple_xx() API
Message-ID: <ZsXkSG_jFPCyCTLi@casper.infradead.org>
References: <20240821065927.2298383-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821065927.2298383-1-lihongbo22@huawei.com>

On Wed, Aug 21, 2024 at 02:59:27PM +0800, Hongbo Li wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().

Already sent by Christopher JAILLET.
https://lore.kernel.org/linux-fsdevel/cover.1722853349.git.christophe.jaillet@wanadoo.fr/

