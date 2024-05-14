Return-Path: <linux-fsdevel+bounces-19411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A3D8C54FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 13:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8102B22079
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E0C1292FC;
	Tue, 14 May 2024 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xr3iG3WN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6035E1CFB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 11:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687569; cv=none; b=kcxK4FaIc5IpnmZNtHThAIULDjo6n8C3Rqke0h8TBRQ5z8TtLTaG3/fcyTpxHralKwLw9Xoni7XX4slPUAixr0VoI2p68ZeL9lUyYJ4GBV4/C+UpUrkk8YQZwjNHN0e93tmdKd9ojLkWJRFjAa3YP2zm+ByiaCCzna80stbya54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687569; c=relaxed/simple;
	bh=HiXwcTk6UFYBZRAuzSGxUc9qpaTdD3aCKv3Rx9j/tAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQ3bvxaYGrEGEb2tZPxOXoQxDXtg0iLhzQc0nxXaF+u3Rrzrl8O6S8+o9I9gKPpnDTPOs0qXu4uiMkxglaYb9kHm0y1cJhSHJlVHVjwJOUSAagDFZBPJEXxFsu1laKxl7UpAuUMQpk9axmW4OAi9HwW6pKbAzs19OWnq6JGo6gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xr3iG3WN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4MxgHTaCvCMljpk7HMjhLlTKEMZ68z6Aw8VilYkQYs0=; b=xr3iG3WNTrU/FWXOfM/UctFmoI
	Au/LGMzyvwr4V5pMNi6Ud2wG5JHcVj9vXCg79JL+wOewgDV6str72/oFYIJ4tLfy0mxZ9pFLWt9DW
	QctpNOcAYCBv3rDOHCq660jGgptgkaUAmG2Ny2Bf+CUe1dlOD6wFs3cpnKERNaoGOTiZ9J2KAn6XX
	TzRIXLBNfU2f06byL0yJO/rvVlKsEONtzLyfcWcchG6nym7JQsLipKumAIBf8oqauU7/SF/sp7DN9
	Hme6IgCc+Izjy03HdACFMGaTVVSN/KzaCwhZWtldA5yKNSaFtPfT4RQqSzUk30m3aV0B77GedJyuB
	GKJFF3Eg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6qi1-0000000FmIp-2E7x;
	Tue, 14 May 2024 11:52:41 +0000
Date: Tue, 14 May 2024 04:52:41 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <ZkNQiWpTOZDMp3kS@bombadil.infradead.org>
References: <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org>
 <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
 <Zduto30LUEqIHg4h@casper.infradead.org>
 <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home>
 <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Feb 26, 2024 at 02:46:56PM -0800, Linus Torvalds wrote:
> I really haven't tested this AT ALL. I'm much too scared. But I don't
> actually hate how the code looks nearly as much as I *thought* I'd
> hate it.

Thanks for this, obviously those interested in this will have to test
this and fix the below issues. I've tested for regressions just against
xfs on 4k reflink profile and detected only two failures, generic/095
fails with a failure rate of about 1/2 or so:

  * generic/095
  * generic/741

For details refer to the test result archive [0]. To reproduce with
kdevops:

make defconfig-xfs_reflink_4k KDEVOPS_HOSTS_PREFIX=hacks B4_MESSAGE_ID=20240514084221.3664475-1-mcgrof@kernel.org
make -j $(nproc)
make bringup
make fstests
make linux
make fstests-baseline TESTS=generic/095 COUNT=10

[0] https://github.com/linux-kdevops/kdevops-results-archive/commit/27186b2782af4af559524539a2f6058d12361e10

  Luis

