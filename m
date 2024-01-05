Return-Path: <linux-fsdevel+bounces-7472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FB682556D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 15:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7CCD1F22401
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jan 2024 14:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371B12DF8E;
	Fri,  5 Jan 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI0he0u8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968BD2C692;
	Fri,  5 Jan 2024 14:35:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615E9C433C7;
	Fri,  5 Jan 2024 14:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704465350;
	bh=ka/VGduA+g6Ty/g3PfHmE31VPABF7sH+61l2Ri2RP4o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bI0he0u8LKjbDenWOurPtUTqPAzUOVcvLAiYQsGGX90tL1LB0LDVS7AldIDXfwAc5
	 7U3D8ZlRMEJuCNyxzjngrw38wEr5a/RJNRnDNjK/FiJUoYDwxYRFfCUUf/FWho3Gb9
	 byllmAj9Ne3+l4ZJew0i2E2Ys01gyRewS0x3jK/FOxrGdSyM8GdaDDFTXMyV6ogJok
	 xx59KLJkZGFiduu/qBxu5lpsDYmWpWAaoi50CRZZXKWzDwXK1pXFNC5PulrGfhmkR3
	 hbkCXdBCwNkGyNpL6hPhpw2prTOAJjXPpxhp06Vuo6kLceMRmEfXjF0bCXtxbgghQL
	 6HSg2DNX3ux7w==
Message-ID: <4101c577-91f9-40c2-9244-5a08dec4523a@kernel.org>
Date: Fri, 5 Jan 2024 15:35:45 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Content-Language: en-US
To: Viacheslav Dubeyko <slava@dubeyko.com>,
 Matthew Wilcox <willy@infradead.org>
Cc: lsf-pc@lists.linux-foundation.org,
 Linux FS Devel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
References: <ZZcgXI46AinlcBDP@casper.infradead.org>
 <2EEB5F76-1D68-4B17-82B6-4A459D91E4BF@dubeyko.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <2EEB5F76-1D68-4B17-82B6-4A459D91E4BF@dubeyko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/5/24 11:13, Viacheslav Dubeyko wrote:
> 
>> On Jan 5, 2024, at 12:17 AM, Matthew Wilcox <willy@infradead.org> wrote:
>> 
>> The memalloc_nofs APIs were introduced in May 2017, but we still have
>> over 1000 uses of GFP_NOFS in fs/ today (and 200 outside fs/, which is
>> really sad).  This session is for filesystem developers to talk about
>> what they need to do to fix up their own filesystem, or share stories
>> about how they made their filesystem better by adopting the new APIs.
>> 
> 
> Many file systems are still heavily using GFP_NOFS for kmalloc and
> kmem_cache_alloc family methods even if  memalloc_nofs_save() and
> memalloc_nofs_restore() pair is used too. But I can see that GFP_NOFS

Yes it should be enough to rely on memalloc_nofs_save() for
kmalloc/kmem_cache_alloc. The kmalloc layer doesnt't care about it, and once
it's run out of available slab folios and calls into the page allocator for
a new one, it evaluates the effect of memalloc_nofs_save() as expected.

> is used in radix_tree_preload(), bio_alloc(), posix_acl_clone(),
> sb_issue_zeroout, sb_issue_discard(), alloc_inode_sb(), blkdev_issue_zeroout(),
> blkdev_issue_secure_erase(), blkdev_zone_mgmt(), etc.
> 
> Would it be safe to switch on memalloc_nofs_save()/memalloc_nofs_restore() for
> all possible cases? Any potential issues or downsides?
> 
> Thanks,
> Slava.
> 
> 


