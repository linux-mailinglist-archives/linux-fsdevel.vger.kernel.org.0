Return-Path: <linux-fsdevel+bounces-515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2F07CC0AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 12:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2957EB21162
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Oct 2023 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522A541754;
	Tue, 17 Oct 2023 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C084123D;
	Tue, 17 Oct 2023 10:26:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20331C433C8;
	Tue, 17 Oct 2023 10:26:38 +0000 (UTC)
Date: Tue, 17 Oct 2023 11:26:36 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Hyesoo Yu <hyesoo.yu@samsung.com>, will@kernel.org,
	oliver.upton@linux.dev, maz@kernel.org, james.morse@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, arnd@arndb.de,
	akpm@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	mhiramat@kernel.org, rppt@kernel.org, hughd@google.com,
	pcc@google.com, steven.price@arm.com, anshuman.khandual@arm.com,
	vincenzo.frascino@arm.com, david@redhat.com, eugenis@google.com,
	kcc@google.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 06/37] mm: page_alloc: Allocate from movable pcp
 lists only if ALLOC_FROM_METADATA
Message-ID: <ZS5hXFHs08zQOboi@arm.com>
References: <20230823131350.114942-1-alexandru.elisei@arm.com>
 <20230823131350.114942-7-alexandru.elisei@arm.com>
 <CGME20231012013524epcas2p4b50f306e3e4d0b937b31f978022844e5@epcas2p4.samsung.com>
 <20231010074823.GA2536665@tiffany>
 <ZS0va9nICZo8bF03@monolith>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS0va9nICZo8bF03@monolith>

On Mon, Oct 16, 2023 at 01:41:15PM +0100, Alexandru Elisei wrote:
> On Thu, Oct 12, 2023 at 10:25:11AM +0900, Hyesoo Yu wrote:
> > I don't think it would be effcient when the majority of movable pages
> > do not use GFP_TAGGED.
> > 
> > Metadata pages have a low probability of being in the pcp list
> > because metadata pages is bypassed when freeing pages.
> > 
> > The allocation performance of most movable pages is likely to decrease
> > if only the request with ALLOC_FROM_METADATA could be allocated.
> 
> You're right, I hadn't considered that.
> 
> > 
> > How about not including metadata pages in the pcp list at all ?
> 
> Sounds reasonable, I will keep it in mind for the next iteration of the
> series.

BTW, I suggest for the next iteration we drop MIGRATE_METADATA, only use
CMA and assume that the tag storage itself supports tagging. Hopefully
it makes the patches a bit simpler.

-- 
Catalin

