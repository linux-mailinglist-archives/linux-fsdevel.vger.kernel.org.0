Return-Path: <linux-fsdevel+bounces-12744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0769866853
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 03:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916051F21FB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Feb 2024 02:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAAA11737;
	Mon, 26 Feb 2024 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJW9ARe4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808B6101C3
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Feb 2024 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708915757; cv=none; b=VDz/tuE6Q7J5RtNxU/6I6x/nqSEUicWZ9ygtKkOCbDehu700riFU/D0h1/cs4kZgTDDh0CBfheajwnCgI7+t85T+TjgUmyQLMOM0JqXM5/OzMnqdB6tgSRAvmEcd+cNtNCa112r/xTql0oJM0IjkWZX8i3j+abMP7R4LG+Slrf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708915757; c=relaxed/simple;
	bh=uUBa+zzsC4Xh3vcsj8p3fV70UMZPHj7ryhlu+PEAL+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVEIVBHPGSMZnwa5lTGHAGrNFV128QD75D1vDwh9MsO/NfDuQeaBDsXNo8nojFiAQx+5m6vVH5xB3iIQYV2OnyeuwIR/etUpjPm9PzRFaVYhhStQkVWtgSO3Sd7EyzebrV05yEKxaOfniJ2eVa0fK+eczveJpG+8nVvgdz2MF6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJW9ARe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE332C433F1;
	Mon, 26 Feb 2024 02:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708915757;
	bh=uUBa+zzsC4Xh3vcsj8p3fV70UMZPHj7ryhlu+PEAL+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJW9ARe4+Ypc2ChSzh8mz+TprpwYAZj5zGT+0miopyp0ySvTq18CVxdDIU+BsRCDV
	 //K1GVsbt86tjLcH96Ou+iIn5iR4wLzECocuYwg81tMQTIy69bQcDldHudVaCSSxZ6
	 4sFkrxYYf4xS3+pUt7lrlxW/EDwgXKQ5JKbKNU2/EsTK6kfZcW8wkOqp7qXoOu1N5K
	 uTKJ5tKd82lMUKNg8JiKnUx8tgCSNKR55xE5sQ0xXtKPltvTF2MaTPn2AW1f5hDH19
	 Kv17nUpiXa7NrKkjEnG/6ptPBxUxhxq2vfjhGoJSCbv5h00vl+Fi5qd9grt9Lo1fvI
	 XDUnKDXc2BUZg==
Date: Sun, 25 Feb 2024 21:50:30 -0500
From: Al Viro <viro@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zdv8dujdOg0dD53k@duke.home>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org>
 <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org>
 <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>

On Sun, Feb 25, 2024 at 05:32:14PM -0800, Linus Torvalds wrote:

> But to take a different example, ext2 just calls
> generic_file_write_iter() *without* taking the inode lock, and does
> locking one page at a time. As far as I know, nobody ever really
> complained.

Uh?  __generic_file_write_iter() doesn't take inode lock, but
generic_file_write_iter() does.  O_APPEND handling aside, there's
also file_remove_privs() in there and it does need that lock.

