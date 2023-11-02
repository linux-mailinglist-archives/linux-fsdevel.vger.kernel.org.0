Return-Path: <linux-fsdevel+bounces-1869-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B697DF915
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 18:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D0A281A67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94D8208C2;
	Thu,  2 Nov 2023 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rrjtBvn/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2A208A4
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 17:46:24 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3C3131
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 10:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nn9XfcQnvQ9EeBScujaYOzpgTkUcnl3rxhx76Sa21Xs=; b=rrjtBvn/dcGRgL1X628iNQtDaT
	v/m5JMkKYNDZDkrL2BuyYqKK/ZgsE0awnWGQ0Nn75KOaimm4Bge7/1gyzAL23kk2qiheCahtpvdsh
	4GmixxpjB3RHJpk4KYG3b4n9ZVqygwqd6+EPgklYBq2zKCmyhy4UQMuu4oWT3nkZr5IvszIvfpOzN
	c/KpXAuGcrrrx9ILB6fCHsdjUtxH1rLopL6DmfXaasAT8v2nHFtK/ltWSJFw3Ao+9zOjwYgk2Z8mm
	Dsf3pguhFczoux6BJfPbMD5ksmU8nsiuSA4eyK8d7itD1s9cfmRnF80MeeuIaWcjXKWqdvwP1h/+O
	Zlor1T5A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qyblo-000egW-Qu; Thu, 02 Nov 2023 17:46:17 +0000
Date: Thu, 2 Nov 2023 17:46:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] ida: Introduce ida_weight()
Message-ID: <ZUPgaAN71ERvQ5/F@casper.infradead.org>
References: <20231102153455.1252-1-michal.wajdeczko@intel.com>
 <20231102153455.1252-2-michal.wajdeczko@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102153455.1252-2-michal.wajdeczko@intel.com>

On Thu, Nov 02, 2023 at 04:34:53PM +0100, Michal Wajdeczko wrote:
> Add helper function that will calculate number of allocated IDs
> in the IDA.  This might be helpful both for drivers to estimate
> saturation of used IDs and for testing the IDA implementation.

Since you take & release the lock, the value is already somewhat racy.
So why use the lock at all?  Wouldn't the RCU read lock be a better
approach?

Also, does it make sense to specify it over a particular range rather
than over the whole IDA?

