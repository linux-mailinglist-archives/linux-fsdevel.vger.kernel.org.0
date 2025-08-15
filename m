Return-Path: <linux-fsdevel+bounces-57976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4252DB274DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 03:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6E6726CA3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 01:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5393292B36;
	Fri, 15 Aug 2025 01:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Mx7tjzwd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D3B286436;
	Fri, 15 Aug 2025 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222618; cv=none; b=ccAH+IpyXGC4CJrXunU/STCBUXlzGZ+UEhB6L0w992TBlDDhowskoY+5V+NkEzQaDQMmNKiZ6LgT92aHolUdofp3fYUr2lFpuDJIlcoaG7/eYpHKgZvJQhvROS4xfD18ggea2HVWXpiS+1ocLkU2SJgTeLVm5Vw29vTDHf6g/p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222618; c=relaxed/simple;
	bh=9STSGVzQphpj6dFmAksTJ1kJlaYQgdw0RQrDoY9RmQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+q29Y0wXXaEH7LizcnF9mGBxS8sQkuonQT81hu/bQU8QD2nxU/db1kxDbCsP3exg+It2QKApm7GscucfvxQQ7Vd8/zYn9lJTnoRyOCaM4kzQMmUheKm2dObfGYkvQAgtOR5SJ7qc9tSOGQCLMnfTbDdHVmxkRGibsYtlXCn7Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Mx7tjzwd; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 7C86F14C2D3;
	Fri, 15 Aug 2025 03:50:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1755222608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=s0fx5fxYEfcNExsKt98qeu7O41VdbcAfsk/i6vcUeUs=;
	b=Mx7tjzwdU96GCGBMQRvmlmLFqzgfqqC251QPZohxkdtoh3SaCvGknV0jqwj3hj7BN4ufBy
	NR6POnZk4nSdS16SQU28GLQU8Vv7Wtc36MnMj0PrLxGp6kToP+LZ1g5BJ7bECPJN7DGZcC
	kw6Eo07BKmoD1wRyiR/AyBEvqCWZgSX9JzfmjDEhjTGhmj3zelwRQyub7HlnVQ+aJNhrxU
	ewsAWEutXPJIbRsfDKu/eAFeMbiShWqjtWKny4TqB7iCIrjNYMFBEH7obmQ+bET/KInLZd
	xJWYtZXV1n1YKNX6HhX6QvvyplQFw4CbDXxV+LAIxkglnBf5KhizqqYoit0fyA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 178574c4;
	Fri, 15 Aug 2025 01:50:03 +0000 (UTC)
Date: Fri, 15 Aug 2025 10:49:48 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	dhowells@redhat.com, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH V2 0/4] 9p: convert to the new mount API
Message-ID: <aJ6SPLaYUEtkTFWc@codewreck.org>
References: <20250730192511.2161333-1-sandeen@redhat.com>
 <aIqa3cdv3whfNhfP@codewreck.org>
 <6e965060-7b1b-4bbf-b99b-fc0f79b860f8@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e965060-7b1b-4bbf-b99b-fc0f79b860f8@sandeen.net>

Eric Sandeen wrote on Thu, Aug 14, 2025 at 11:55:20AM -0500:
> >> I was able to test this to some degree, but I am not sure how to test
> >> all transports; there may well be bugs here. It would be great to get
> >> some feedback on whether this approach seems reasonable, and of course
> >> any further review or testing would be most welcome.
> > 
> > I still want to de-dust my test setup with rdma over siw for lack of
> > supported hardware, so I'll try to give it a try, but don't necessarily
> > wait for me as I don't know when that'll be..
> 
> Any news on testing? :)

Thanks for the prompting, that's the kind of things I never get around
to if not reminded...

I got this to run with a fedora-based host (unlike debian siw is
built-in):

- host side
```
$ sudo modprobe siw
$ sudo rdma link add siw0 type siw netdev br0
(sanity check)
$ ibv_devices
    device          	  node GUID
    ------          	----------------
    siw0            	020000fffe000001
( https://github.com/chaos/diod build)
$ ./configure --enable-rdma --disable-auth && make -j
(diod run, it runs rdma by default; not squashing as root fails with
  rdma because of the ib_safe_file_access check:
  [611503.258375] uverbs_write: process 1490213 (diod) changed security contexts after opening file descriptor, this is not allowed.
)
$ sudo ./diod -f -e /tmp/linux-test/ --no-auth -U root -S 
```
- guest side (with -net user)
```
# modprobe siw
# rdma link add siw0 type siw netdev eth0
# mount -t 9p -o trans=rdma,aname=/tmp/linux-test <hostip> /mnt
```

I've tested both the new and old mount api (with util-linux mount and
busybox mount) and it all seems in order to me;
as discussed in the other part of the thread we're now failing on
unknown options but I think that's a feature and we can change that if
someone complains.

> As for "waiting for you," I assume that's more for your maintainer peers
> than for me? I'm not sure if this would go through Christian (cc'd) or
> through you?

Sorry, I wasn't paying attention and confused you with another Eric
(Van Hensbergen) who is a 9p maintainer, so I was thinking you'd take
the patches, but that wasn't correct.
And that's after seeing your name all the time in #xfs, I'm sorry..

Christian is "just" a reviewer (for now!), and none of the other
maintainers pick much up lately, so I'll give this a second look and
take the patches.
Linus just closed up 6.17-rc1 so I guess this will get in 6.18 in the
next cycle, unless there'd be a reason to hurry?

Thanks,
-- 
Dominique Martinet | Asmadeus

