Return-Path: <linux-fsdevel+bounces-19204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 850D28C132B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 18:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256D41F22296
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 16:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C766FB1;
	Thu,  9 May 2024 16:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="pOwpAud7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36445BE5D
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272863; cv=none; b=cH1yJ9Bx6Jl5+dFzGHimjssmYnNrH5gaWpDxQFtYiHMVnN4tfADwwybiwKtz5xATyrleNSgjkQS1aOBt0Z3h9/gZbRc0KnJKvvcbwGuz0XnuTxOzA3YvzFSEZ+DTO7DzYEeSiJ1go8nk2RcWthnMwTIo9ORE+wLjMzbZI+SfcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272863; c=relaxed/simple;
	bh=f8t8eIDeydSwNSMhQRpvtz/+E2VzWPKam45G3zjfMkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgQMLHeMEiDGlScIuYf8uWKWLQPK7Uxp9e6LN8EG+2ypbTwFEsKyASXeu8NX1Khm74nf2LZ/PF3Y7VtpI7tsy5x2WtJf0+C3E5AaYrn1/OsvoBS7eBOYg9FkMifoGVk/HVjQSfx8byOwZ8TsM3qdo3xU73HclJ+Wbh580OIdnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=pOwpAud7; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 449GdrOL029481
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 12:39:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715272797; bh=vMIKuWYSq6W8VCcJbXYTnhjXEJwg1E/gV4Gfl9NNKDU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=pOwpAud74hdbMcBM1DcxtS9z6wpX6SIlAnGfEkVVdZdSTqp5o+nl2yfq1E0t50vpQ
	 jzrdEjCwAa51cW8jPODvFzXuSLxZ/0kxWQu7ZVgxycgnagtVvjuRAb56bxxfUkcixb
	 qiFX7XnVsxoyQrK5H51DzT3NqOxEeTt+FI5fS14HSrcQkFrMC8moBgtO28xnkOrOAy
	 GPJZLGSn8Qt8w+hJoO7NhMk1br1JWFI8WExAAVDnYqEP6ntjKOSf58Ed1GeX7Y/f0z
	 81IQKgTZPRzDwqx6YWbzGPA6VZ6zg5uAd5FOOEcPfqWf2/U9VpGG0pDHhfTX79LcIB
	 RfRz7GO3b9i5g==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 94F1115C026D; Thu, 09 May 2024 12:39:53 -0400 (EDT)
Date: Thu, 9 May 2024 12:39:53 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Luis Henriques <luis.henriques@linux.dev>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, hch@infradead.org, djwong@kernel.org,
        willy@infradead.org, zokeefe@google.com, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com,
        wangkefeng.wang@huawei.com
Subject: Re: [PATCH v3 03/26] ext4: correct the hole length returned by
 ext4_map_blocks()
Message-ID: <20240509163953.GI3620298@mit.edu>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
 <20240127015825.1608160-4-yi.zhang@huaweicloud.com>
 <87zfszuib1.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfszuib1.fsf@brahms.olymp>

On Thu, May 09, 2024 at 04:16:34PM +0100, Luis Henriques wrote:
> 
> It's looks like it's easy to trigger an infinite loop here using fstest
> generic/039.  If I understand it correctly (which doesn't happen as often
> as I'd like), this is due to an integer overflow in the 'if' condition,
> and should be fixed with the patch below.

Thanks for the report.  However, I can't reproduce the failure, and
looking at generic/039, I don't see how it could be relevant to the
code path in question.  Generic/039 creates a test symlink with two
hard links in the same directory, syncs the file system, and then
removes one of the hard links, and then drops access to the block
device using dmflakey.  So I don't see how the extent code would be
involved at all.  Are you sure that you have the correct test listed?

Looking at the code in question in fs/ext4/extents.c:

again:
	ext4_es_find_extent_range(inode, &ext4_es_is_delayed, hole_start,
				  hole_start + len - 1, &es);
	if (!es.es_len)
		goto insert_hole;

  	 * There's a delalloc extent in the hole, handle it if the delalloc
  	 * extent is in front of, behind and straddle the queried range.
  	 */
 -	if (lblk >= es.es_lblk + es.es_len) {
 +	if (lblk >= ((__u64) es.es_lblk) + es.es_len) {
  		/*
  		 * The delalloc extent is in front of the queried range,
  		 * find again from the queried start block.
		len -= lblk - hole_start;
		hole_start = lblk;
		goto again;

lblk and es.es_lblk are both __u32.  So the infinite loop is
presumably because es.es_lblk + es.es_len has overflowed.  This should
never happen(tm), and in fact we have a test for this case which
*should* have gotten tripped when ext4_es_find_extent_range() calls
__es_tree_search() in fs/ext4/extents_status.c:

static inline ext4_lblk_t ext4_es_end(struct extent_status *es)
{
	BUG_ON(es->es_lblk + es->es_len < es->es_lblk);
	return es->es_lblk + es->es_len - 1;
}

So the patch is harmless, and I can see how it might fix what you were
seeing --- but I'm a bit nervous that I can't reproduce it and the
commit description claims that it reproduces easily; and we should
have never allowed the entry to have gotten introduced into the
extents status tree in the first place, and if it had been introduced,
it should have been caught before it was returned by
ext4_es_find_extent_range().

Can you give more details about the reproducer; can you double check
the test id, and how easily you can trigger the failure, and what is
the hardware you used to run the test?

Many thanks,

					- Ted

