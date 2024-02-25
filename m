Return-Path: <linux-fsdevel+bounces-12697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D602086291E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 06:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B184281FB2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 05:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B23F9450;
	Sun, 25 Feb 2024 05:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rFDRrDPf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C5F8BF7;
	Sun, 25 Feb 2024 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708837287; cv=none; b=lxUfIIvK0sI6/YZ8HWRO9wJXs5hkrEAJOO76zTvhAdUfb0VygLCIXMOEb83v3Qwnl7J9M+mezWK2+H1rZAi4XJVUwjhbu5uOVpCZQcI+syFO4uWzlmLRCYdAIcco6VfLMnfX7IQoHPDtR6hEOir8GjbL3IRFIyBXR/mQXLt46pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708837287; c=relaxed/simple;
	bh=fGZltGZNoJBL0qVbGmPCoIkPh0GK+3Eoei2TVfZIXgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6Yb3/FAX7waF5yK+tgKGcOTY+lcPrIZouUGPTWDkY3xXVHVmCGarSHmwbub89tp15x1ckiwewHeVTbDUn0HNV5MuCsAmZM/ulp2hOJXB0ff50lyYVGHWUkfg62V7COVW6oeio5o5hG8KOwC1YhJNPrXWBGCjoI5w/FXlgHju+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rFDRrDPf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s5ZqZD7A6lH7mWMZnVXwTZc0c5NMrcq/moxPl8tGVLs=; b=rFDRrDPf8tWfYxe+lK4UGzVEDL
	xGoCs8oYxMni+++XQVt4UltsjPu0WZMp8RJe/6YA9aYCak6FucCUSy4cfUFniup07o59MJccPJ/4Z
	BSdCt/BWIET2vV8cjvdujdTd5kNLenAeV09P/GhWOMIe6numy2xPzJiUkmY3PR6lbAP0TP0LrfU/a
	/MbKWjMgIbJPjiPr9sQVymuuKBa1VCnTpxY2ohh0hvN964qDY9+3/y7IYiDTrGAArbhrhm3MNhOWU
	AyqViMWne7YOY3o8h9uy90VlFWFdflh5HuK4syEpROrKEdRYpq5cvhCOhtbpMoLva2+2rstZ9jgBF
	KH5dEY9g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1re6db-0000000D1Ox-0Pfe;
	Sun, 25 Feb 2024 05:01:19 +0000
Date: Sun, 25 Feb 2024 05:01:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: David Laight <David.Laight@aculab.com>,
	'Herbert Xu' <herbert@gondor.apana.org.au>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Thomas Graf <tgraf@suug.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/1] Rosebush, a new hash table
Message-ID: <ZdrJn0lkFeYGuYIC@casper.infradead.org>
References: <20240222203726.1101861-1-willy@infradead.org>
 <Zdk2YgIoAGOEvcJi@gondor.apana.org.au>
 <4a1416fcb3c547eb9612ce07da6a77ed@AcuMS.aculab.com>
 <2s73sed5n6kxg42xqceenjtcwxys4j2r5dc5x4fdtwkmhkw3go@7viy7qli43wd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2s73sed5n6kxg42xqceenjtcwxys4j2r5dc5x4fdtwkmhkw3go@7viy7qli43wd>

On Sat, Feb 24, 2024 at 10:18:31PM -0500, Kent Overstreet wrote:
> On Sat, Feb 24, 2024 at 10:10:27PM +0000, David Laight wrote:
> > I remember playing around with the elf symbol table for a browser
> > and all its shared libraries.
> > While the hash function is pretty trivial, it really didn't matter
> > whether you divided 2^n, 2^n-1 or 'the prime below 2^n' some hash
> > chains were always long.
> 
> that's a pretty bad hash, even golden ratio hash would be better, but
> still bad; you really should be using at least jhash.

There's a "fun" effect; essentially the "biased observer" effect which
leads students to erroneously conclude that the majority of classes are
oversubscribed.  As somebody observed in this thread, for some usecases
you only look up hashes which actually exist.

Task a trivial example where you have four entries unevenly distributed
between two buckets, three in one bucket and one in the other.  Now 3/4
of your lookups hit in one bucket and 1/4 in the other bucket.
Obviously it's not as pronounced if you have 1000 buckets with 1000
entries randomly distributed between the buckets.  But that distribution
is not nearly as even as you might expect:

$ ./distrib
0: 362
1: 371
2: 193
3: 57
4: 13
5: 4

That's using lrand48() to decide which bucket to use, so not even a
"quality of hash" problem, just a "your mathematical intuition may not
be right here".

To put this data another way, 371 entries are in a bucket with a single
entry, 384 are in a bucket with two entries, 171 are in a 3-entry
bucket, 52 are in a 4-entry bucket and 20 are in a 5-entry bucket.

$ cat distrib.c
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>

int bucket[1000];
int freq[10];

int main(int argc, char **argv)
{
	int i;

	for (i = 0; i < 1000; i++)
		bucket[lrand48() % 1000]++;

	for (i = 0; i < 1000; i++)
		freq[bucket[i]]++;

	for (i = 0; i < 10; i++)
		printf("%d: %d\n", i, freq[i]);

	return 0;
}

(ok, quibble about "well, 1000 doesn't divide INT_MAX evenly so your
random number generation is biased", but i maintain that will not
materially affect these results due to it affecting only 0.00003% of
numbers generated)

