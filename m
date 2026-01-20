Return-Path: <linux-fsdevel+bounces-74576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5C2D3BFEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 08:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A18A44FCCCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 06:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52EC3793C9;
	Tue, 20 Jan 2026 06:53:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812F4392B66;
	Tue, 20 Jan 2026 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768891975; cv=none; b=X+5uak0LcW/8YhjEUKdrve87SKBqjMILOeisTIVcsHRWmLoMWSmtFsTuoZ2G59yBwqz5DbwRQ5Rkie82P3E6dqacbQmHtNcIJDSMPlUTwUxZwyi3E1zFon/TUJubPtRjZPh2OpsKxjC7XkpAuJmoyxqwxGI//5vwE/B30rIpyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768891975; c=relaxed/simple;
	bh=Nc69iexLYt/6/d0XZNS3PCsjD7wOH3NlkWEJfwAeJ8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHbhZblp0sdINgia5jcSes8vd9sMGe52ZrXkbYM/uMVUvbxTOdJo079URJ3fVOeDhtbFJRJOIAkiOslKvsa5eF2EIToBwdmSyyd57fXJBPE87SsPseOVRRYZ9TpLY61+/0+j3HArN6X9tTOx40iMUc3yuSs4bp1iTmnrzPFohfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C97CF227AA8; Tue, 20 Jan 2026 07:52:42 +0100 (CET)
Date: Tue, 20 Jan 2026 07:52:42 +0100
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
Message-ID: <20260120065242.GA3436@lst.de>
References: <20260116095550.627082-6-lihongbo22@huawei.com> <20260116154623.GC21174@lst.de> <af1f3ff6-a163-4515-92bf-44c9cf6c92f3@linux.alibaba.com> <20260119072932.GB2562@lst.de> <8e30bc4b-c97f-4ab2-a7ce-27f399ae7462@linux.alibaba.com> <20260119083251.GA5257@lst.de> <b29b112e-5fe1-414b-9912-06dcd7d7d204@linux.alibaba.com> <20260119092220.GA9140@lst.de> <73f2c243-e029-4f95-aa8e-285c7affacac@linux.alibaba.com> <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50db56b8-4cf9-4d62-b242-c982a260a330@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 20, 2026 at 11:07:48AM +0800, Gao Xiang wrote:
>
> Hi Christoph,
>
> Sorry I didn't phrase things clearly earlier, but I'd still
> like to explain the whole idea, as this feature is clearly
> useful for containerization. I hope we can reach agreement
> on the page cache sharing feature: Christian agreed on this
> feature (and I hope still):
>
> https://lore.kernel.org/linux-fsdevel/20260112-begreifbar-hasten-da396ac2759b@brauner

He has to ultimatively decide.  I do have an uneasy feeling about this.
It's not super informed as I can keep up, and I'm not the one in charge,
but I hope it is helpful to share my perspective.

> First, let's separate this feature from mounting in user
> namespaces (i.e., unprivileged mounts), because this feature
> is designed specifically for privileged mounts.

Ok.

> The EROFS page cache sharing feature stems from a current
> limitation in the page cache: a file-based folio cannot be
> shared across different inode mappings (or the different
> page index within the same mapping; If this limitation
> were resolved, we could implement a finer-grained page
> cache sharing mechanism at the folio level). As you may
> know, this patchset dates back to 2023,

I didn't..

> and as of 2026; I
> still see no indication that the page cache infra will
> change.

It will be very hard to change unless we move to physical indexing of
the page cache, which has all kinds of downside.s

> So that let's face the reality: this feature introduces
> on-disk xattrs called "fingerprints." --- Since they're
> just xattrs, the EROFS on-disk format remains unchanged.

I think the concept of using a backing file of some sort for the shared
pagecache (which I have no problem with at all), vs the imprecise
selection through a free form fingerprint are quite different aspects,
that could be easily separated.  I.e. one could easily imagine using
the data path approach based purely on exact file system metadata.
But that would of course not work with multiple images, which I think
is a key feature here if I'm reading between the lines correctly.

>  - Let's not focusing entirely on the random human bugs,
>    because I think every practical subsystem should have bugs,
>    the whole threat model focuses on the system design, and
>    less code doesn't mean anything (buggy or even has system
>    design flaw)

Yes, threats through malicious actors are much more intereating
here.

>  - EROFS only accesses the (meta)data from the source blobs
>    specified at mount time, even with multi-device support:
>
>     mount -t erofs -odevice=[blob],device=[blob],... [source]

That is an important part that wasn't fully clear to me.


