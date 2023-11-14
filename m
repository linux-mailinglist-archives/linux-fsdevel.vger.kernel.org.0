Return-Path: <linux-fsdevel+bounces-2847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3F57EB51C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 17:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 441D5281278
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526D33FB1E;
	Tue, 14 Nov 2023 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A70E3FB1C
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 16:46:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06216E8
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 08:46:45 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BEA8C15;
	Tue, 14 Nov 2023 08:47:29 -0800 (PST)
Received: from [10.1.27.144] (XHFQ2J9959.cambridge.arm.com [10.1.27.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B799C3F641;
	Tue, 14 Nov 2023 08:46:43 -0800 (PST)
Message-ID: <1628606f-a396-448d-91ec-6c4ce85b5358@arm.com>
Date: Tue, 14 Nov 2023 16:46:42 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] mm: More ptep_get() conversion
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
References: <20231114154945.490401-1-ryan.roberts@arm.com>
 <ZVOguexQ2rGhnwN7@casper.infradead.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZVOguexQ2rGhnwN7@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/11/2023 16:30, Matthew Wilcox wrote:
> On Tue, Nov 14, 2023 at 03:49:45PM +0000, Ryan Roberts wrote:
>> Commit c33c794828f2 ("mm: ptep_get() conversion") converted all
>> (non-arch) call sites to use ptep_get() instead of doing a direct
>> dereference of the pte. Full rationale can be found in that commit's
>> log.
>>
>> Since then, three new call sites have snuck in, which directly
>> dereference the pte, so let's fix those up.
>>
>> Unfortunately there is no reliable automated mechanism to catch these;
>> I'm relying on a combination of Coccinelle (which throws up a lot of
>> false positives) and some compiler magic to force a compiler error on
>> dereference (While this approach finds dereferences, it also yields a
>> non-booting kernel so can't be committed).
> 
> Well ... let's see what we can come up with.
> 
> struct raw_pte {
> 	pte_t pte;
> };

pte_t is already a wrapper around the real value, at least on arm64:

typedef struct { pteval_t pte; } pte_t;

So doesn't adding extra wrapper just suggest that next year we will end up
adding a third, then a fourth...?

Fundamentally people can still just do pte->pte to dereference.


The approach I took with the compiler magic I describe above was to pass around:

typedef void* pte_handle_t;

which is just a pointer to pte_t, but you can't deref without an explcit cast.
So then I insert the explicit casts in the 5 or 6 places in the arm64 arch code
that they are required and it mostly just works. (I have the core patch which is
pretty small, then do find/replace on "pte_t *" -> "pte_handle_t" and it just
works).

But its a LOT of churn in the non-arch code, and leaves the other arches broken,
many of which are dereferencing all over the place  - it would be a huge effort
to fix them all up.

> 
> static inline pte_t ptep_get(struct raw_pte *rpte)
> {
> 	return rpte.pte;
> }
> 
> Probably quite a lot of churn to put that into place, but better than
> a never-ending treadmill of fixing the places that people overlooked?

Yes and no... agree it would be nice to automatically guard against it, but I
didn't want to spend the next 6 months of my life fixing up all the other arches...


