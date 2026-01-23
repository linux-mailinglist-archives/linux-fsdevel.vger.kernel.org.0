Return-Path: <linux-fsdevel+bounces-75207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eApHHcEJc2mWrwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:40:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F1A707EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 06:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64C6B301497E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 05:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2447E38BDAE;
	Fri, 23 Jan 2026 05:39:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0422F39C629;
	Fri, 23 Jan 2026 05:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769146787; cv=none; b=im1e1QSgwhDrl7kEn3ycu+JQcF4waAZnlnmHl89k7J1R0wrikBVfOgkZ6ClKj5rBtFRPYxzDPsxo0qa2XszPwV+4Iul2YyfSn86KwD7QY0XnsJasrBMt8dCvSKqqKngb6IsXz+haXnFbR/EuOyWFSZmX3nMxPagc06nTAnP+dcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769146787; c=relaxed/simple;
	bh=3lMO1Ow1om63NpUZZUZZq6UXF5gjD12GpzKN2vc+d/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYGGIf9UlUv4bFafrpUFOWhM4MZdSrC4ipCXXWThQPYZCWtN8q01BeMdH0qmr5mQXTbcSjzQRpV8IHc4EsxCRlWDRqIiz0baGVV3+XELfZIrBIzJO/sZzsT7pXvYq2Iyxulsmk6p/w/1IcSR4CY8eM1dsuV6s9r9gC/7Me00K0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 02EAE227AAE; Fri, 23 Jan 2026 06:39:36 +0100 (CET)
Date: Fri, 23 Jan 2026 06:39:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>,
	chao@kernel.org, djwong@kernel.org, amir73il@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH v15 5/9] erofs: introduce the page cache share feature
Message-ID: <20260123053936.GA24828@lst.de>
References: <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com> <20260119083251.GA5257@lst.de> <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com> <20260119092220.GA9140@lst.de> <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com> <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com> <20260120065242.GA3436@lst.de> <5892c7bb-f06e-45d7-ad84-99837788e5ab@linux.alibaba.com> <20260122083310.GA27928@lst.de> <abb1f8f4-c5cd-416b-b346-046d3fa8408c@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abb1f8f4-c5cd-416b-b346-046d3fa8408c@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-fsdevel@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_CC(0.00)[lst.de,huawei.com,kernel.org,gmail.com,vger.kernel.org,lists.ozlabs.org,linux-foundation.org,linux.alibaba.com];
	TAGGED_FROM(0.00)[bounces-75207-lists,linux-fsdevel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: E5F1A707EA
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 04:40:56PM +0800, Gao Xiang wrote:
>> Having multiple folios for the same piece of memory can't work,
>> at we'd have unsynchronized state.
>
> Why not just left unsynchronized state in a unique way,
> but just left mapping + indexing seperated.

That would not just require allocating the folios dynamically, but most
importantly splitting it up.  We'd then also need to find a way to chain
the folio_link structures from the main folio.  I'm not going to see this
might not happen, but it feels very far out there and might have all
kinds of issues.

>>>> I think the concept of using a backing file of some sort for the shared
>>>> pagecache (which I have no problem with at all), vs the imprecise
>>>
>>> In that way (actually Jingbo worked that approach in 2023),
>>> we have to keep the shared data physically contiguous and
>>> even uncompressed, which cannot work for most cases.
>>
>> Why does that matter?
>
> Sorry then, I think I don't get the point, but we really
> need this for the complete page cache sharing on the
> single physical machine.

Why do you need physically contigous space to share it that way?

>>
>>> On the other side, I do think `fingerprint` from design
>>> is much like persistent NFS file handles in some aspect
>>> (but I don't want to equal to that concept, but very
>>> similar) for a single trusted domain, we should have to
>>> deal with multiple filesystem sources and mark in a
>>> unique way in a domain.
>>
>> I don't really thing they are similar in any way.
>
> Why they are not similiar, you still need persistent IDs
> in inodes for multiple fses, if there are a
> content-addressable immutable filesystems working in
> inodes, they could just use inode hashs as file handles
> instead of inode numbers + generations.

Sure, if they are well defined, cryptographically secure hashes.  But
that's different from file handles, which don't address content at all,
but are just a handle to given file that bypasses the path lookup.

>
> Thanks,
> Gao Xiang
---end quoted text---

