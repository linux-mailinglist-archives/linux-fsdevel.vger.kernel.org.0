Return-Path: <linux-fsdevel+bounces-37172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7999EE886
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 15:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CB0165E3F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 14:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C982153FA;
	Thu, 12 Dec 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="OaCIR3CD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430E32153EF
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734012755; cv=none; b=p04FSl071d9MNU6dxi95mhWMFf+W8CR9nNlnVgPYBwQQCKfX1iTxgM1Psj6+qUmKm372LUDSyveQqW5zTOZxbvLGf82m6CvJSsPTUhWn/1SyMdrsaOrTic8Kn9Dt+yPxIqnuO/nY8ae384+CklIiuziQNalqqW5gKZI11iJgNhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734012755; c=relaxed/simple;
	bh=fMIPUSjAwwy+axFu6NySo4r9+/ptfI/0mV99yxA0usE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAHgP3jMR8XTd/kyTFlV9ML5NggYwgBzNMT07koEAEVtMQKnRr6cFKN/x9F4nHoU+tctajx7UBTjJkvUz1Gk9TpxOjxR6YCyUpZQXIBj8bzSFGSO3SOt1NQPm0hOWS9QXMwewR8SeX4vZQEQLOea8VXM7AAcVXBxBT6k8LqSSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=OaCIR3CD; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-226.bstnma.fios.verizon.net [173.48.82.226])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4BCECKkE024517
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 09:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1734012742; bh=7Jxb65opHWfpZ7IWV0B2Mylwq9EqJlQLaqwzBAA8q1Q=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=OaCIR3CDtaIGUNRmh2V0lZ4i7ZItG9YYU0YJ0n0KhAFW9mDpJRfK7tfxtMkpOYk4A
	 mw23T99m1mseHjtUMvu4LZ5y4JrsGcZTuz/TdbAos6tEMstKcGFuOYRpGbMNwTpi4W
	 qDC1Cy5DHLMLV4IlpT43E2f+UbhMD3A2axH7kG1SZZpfmYu4FIzlnX2ov++0+s36Lt
	 qVnvwco1L9+b1VcQaUlM7zMz7YqV39Zv6nsJd4K2IXXw6ztbssmIBfxqwqe0qwS837
	 VGSRVHW9vT/cToQUzxC6Pi0u5Z/EZAm7yHQ1REm7UuZy2Erz70ymAZG6Hq6uUjmkaH
	 fH+Sk1C+Mt8NA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4B66515C028A; Thu, 12 Dec 2024 09:12:20 -0500 (EST)
Date: Thu, 12 Dec 2024 09:12:20 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, caiqingfu <baicaiaichibaicai@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [bugzilla:219548] the kernel crashes when storing an EXT4 file
 system in a ZRAM device
Message-ID: <20241212141220.GE1265540@mit.edu>
References: <20241212035826.GH2091455@google.com>
 <20241212053739.GC1265540@mit.edu>
 <Z1qSTM_Eibvw0bM5@infradead.org>
 <20241212140437.GD1265540@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212140437.GD1265540@mit.edu>

On Thu, Dec 12, 2024 at 09:04:37AM -0500, Theodore Ts'o wrote:
> For this particular use case, which is running VM's on
> Chromium/ChromeOS, I suspect we do need to have some kind of solution
> other than triggering a WARN_ON.

Sorry, I didn't complete my thought here.  We could just say, "don't
use ext4 without a journal in a Chrome VM."  But if the are going to
allow the VM's access to external USB storage, then ext4 in no-journal
mode will be the least of their problems.  People trying to access USB
thumbdrives or sdcards from their digital cameras using FAT file
sytems will be trigerring ZBLK buffer overflow kernel crashes left,
right, and center.  Especially if they are on a low-cost ChromeOS
device with a tiny amount of meory, such that memory pressure should
be considered a foregone conclusion.  :-)

						- Ted

