Return-Path: <linux-fsdevel+bounces-1886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3457DFBD3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 22:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8931C20FB4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 21:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8F8208D2;
	Thu,  2 Nov 2023 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D1rcG5Hq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983231D680
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 21:01:22 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88AE18E
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 14:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Lm1x3+I7cQJwpjf/mdhE+66HAAFI7hcP85J+ql/dfps=; b=D1rcG5HqXIA6CxCr6Wkl7M6P1w
	UenIGYEeRqsxNMkbMGIJFBjAE0y/nl4CoUk3UscPSuMePtfdBQgaVoXYS+MOMGFKPovYvKGjSWEHu
	3SBdiozKngy8bSIx9dbi7dFHIlZ3JhjbKMfNMuwmWuZoa/f6UwcEQ6wEdoE8yv36TCHUxUW8voDml
	7xAqnr372kqag9R30dlStFv/JO8i+2g57eDVQ9yRwg9/e/e+QFBdoPrnWSjjhTHA3FM4liofVJXvs
	N0IetPF+KTxkfjdKV5wcdgmihhUHrbLZVbMYMZiJ18qb7TB4eUJiZ469Z4/ECTWk9hWKzdB/ON/Td
	AlOg3HDw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qyeoU-001Rcn-Sa; Thu, 02 Nov 2023 21:01:14 +0000
Date: Thu, 2 Nov 2023 21:01:14 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] ida: Add kunit based tests for new IDA functions
Message-ID: <ZUQOGl/IQ3MHOkCr@casper.infradead.org>
References: <20231102153455.1252-1-michal.wajdeczko@intel.com>
 <20231102153455.1252-4-michal.wajdeczko@intel.com>
 <ZUPfzKMIToSe+X5q@casper.infradead.org>
 <e7637a99-ca4f-460a-8ee5-9583790be567@intel.com>
 <ZUP0mbMqtCaQIQGX@casper.infradead.org>
 <f6cd1d42-b901-40a9-9da6-004aaebfc4b9@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6cd1d42-b901-40a9-9da6-004aaebfc4b9@intel.com>

On Thu, Nov 02, 2023 at 09:58:07PM +0100, Michal Wajdeczko wrote:
> > Why would using kunit be superior to the existing test suite?
> 
> As said above IMO it's just a nice tool, that seems to be already used
> around.  If you look for examples where kunit could win over existing
> ida test suite, then maybe that kunit allows to run only specific test
> cases or parametrize test cases or provide ready to use nicer diagnostic
> messages on missed expectations.  It should also be easy (and can be
> done in unified way) to replace some external functions to trigger
> desired faults (like altering kzalloc() or xas_store() to force
> different code paths during our alloc).
> 
> But since I'm a guest here, knowing that there could be different
> opinions on competing test suites, we can either drop this patch or
> convert new test cases with 'group' variants to the old test_ida suite
> (if that's really desired).

AFAIK, kunit can't be used to extract the in-kernel IDA code and run it
in userspace like the current testsuite does (the current testsuite also
runs in-kernel, except for the multithreaded tests).  So unless it has
that functionality, it seems like a regression to convert the existing
test-suite to kunit.

