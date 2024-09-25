Return-Path: <linux-fsdevel+bounces-30126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247D098687B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 23:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E214E281F15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 21:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A504C91;
	Wed, 25 Sep 2024 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="cCJt1xVl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA001534FB;
	Wed, 25 Sep 2024 21:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727300796; cv=none; b=jNfW5HTiJErsSQ/yvtDoWhg5PxWhRNvc5jkHf9Eo/AnFkmvNOSG3bUx4rPUWNPq3SQLSyjZE+2BKEuuPJVWKhx4d9yq5VIiXX/dXUl3CmJrUhzNVA9LYojhWasWgMPpNWkpRUddJuF/jZrdQpKktmBi4E251gB54WHMdfcasZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727300796; c=relaxed/simple;
	bh=Kx2+4ZXFIWfwPwQqzWzCQt1Dr+Ll7UJtTbovdy752CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q6ElJNXdjVnOP9FBLdepFWpg2/VsxJKts9NcFkqAyJgnOjBDza/LlMBzYks/jTfwMChwkLwKfStqLQ1VxKMLzfjulyAevESdrF5zuLIWwfLK/p8+kuOIMd9T8B4UOmSLYLY9qEXniawr3cXoHps5E0FR7hi+Hpk7D4J3zIQvoik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=cCJt1xVl; arc=none smtp.client-ip=173.37.86.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5105; q=dns/txt; s=iport;
  t=1727300794; x=1728510394;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VckOAgRjdjkhJ0K9ZO4MPe4CiswPipPZEA7GbCxjh5M=;
  b=cCJt1xVlKcpZq1SXiYwfeNDNowxyck0wBWeYdi0Fi26mNCSCPyNg5DMi
   L75QA/8M9KzqmnzwEhlcGHNQeNCxFHA63iA76OowwTfmxzl6THEeZy0Xm
   kXRZZEwCxtnXwD4Wr7QxMMFL1PpTqfK/Qyfc3wX9Onclxin7vyWHk/ysD
   Q=;
X-CSE-ConnectionGUID: WQuQom6JQ06Xd3Zv61Pf8w==
X-CSE-MsgGUID: 8zLzPAsSQv2dNIE0WjRMNg==
X-IPAS-Result: =?us-ascii?q?A0ADAAC0g/RmmJxdJa1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYNAWUNIBIxuhzCCIgOeFYF+DwEBAQ0BATsJBAEBhEFGA?=
 =?us-ascii?q?ooEAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBBQEBBQEBAQIBBwUUAQEBAQEBA?=
 =?us-ascii?q?QE3BUmFdQ2GWwEBAQECATo0CwULCw4KLlYGExSCbQGCQSMDEQawF3iBNIEBg?=
 =?us-ascii?q?2IB2k+BZgaBSAGISgGFZhuEXCcbgUlEhD8+glUMAQECgUiGWgSGcIp+DQ6BJ?=
 =?us-ascii?q?4lLfCVNiHATkH1Se3ghAhEBVRMXCwkFiTgKgxwpgUUmgQqDC4Ezg3KBZwlhi?=
 =?us-ascii?q?EmBDYE+gVkBgzdKg0+BeQU4Cj+CUWtOOQINAjeCKIEOglqFAE0dQAMLbT01F?=
 =?us-ascii?q?BusOYFbSIMFRSgQBAEEDAsCLAINcBgkQS0DkkpLB4JnjmKBOZ9KhCGMFpUmT?=
 =?us-ascii?q?RMDg2+NAYZEOpJBmHaNe5VhhRcCBAYFAheBZzqBWzMaCBsVgyITDDMZD44tD?=
 =?us-ascii?q?QmDWIRZO7oFQzICATgCBwsBAQMJi1aBfAEB?=
IronPort-Data: A9a23:FvU1bqM2Hhuk3+bvrR29kMFynXyQoLVcMsEvi/4bfWQNrUol1zEHy
 2YfWW/SOPyMZDCkctgiaIyw8R9QuJ/WztYwSXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCdap1yFDmE/0fF3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WlvlV
 e/a+ZWFZAf0gWMsaAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj68pXEXgxONM6w74pMW0Vx
 +JGcQgDPg/W0opawJrjIgVtrt4oIM+uN4QFtzQ9izrYFv0hB5vERs0m5/cBg2x23Z8ITK2YP
 pdHAdZsREyojxlnM1IWA486lfyAjXjkeDoeo1WQzUYyyzKNklYsieWzb7I5fPTaV+FHpm+Dn
 VvYpWjfIzxCC96l7ByKpyfEaujnxn6jB9lIS9VU7MVCnFqJ2GUXBAY+UVq9vOn8hEmjXd5WN
 00T/Gwpt6da3EiqSMTtGhCip3CflhodQMZLVeoo7AiH0ezT+QnxLmwFSCNRLdI9uMIoSDgCy
 FCEhZXqCCZpvbnTTmiSnp+KrCm1EToYK24cIysFSxYVpd75r8cujXrnStdlDb7wjdDvHzz06
 y6FoTJ4hLgJi8MPkaKh8jjvjCihqZvJZgo04BjHUGW46A9weI+iYcqv81ezxexdN5rcQF6b+
 XwFndWOxP4BAIvLlyGXRugJWraz6J6tLDrbhVtmGYEJ6zCo4zioduh47zhkNW9mO9wVdiLuJ
 knepWt57pJVOnzsaahseIO3I9wwyrTnE5LgW5j8bsFPa55+dwaA1CVvY1OAmWnpkUIlm6h5M
 pCeGftAFl4AAqhhiTGxXepYjPkgxzs1wiXYQpWTIwmbPaS2W0eIcLAAbnm3Nr4J4Pi2vluMy
 9gPKJ7fo/lAa9HWbi7S+I8VCFkFK3knGJz7w/C7kMbdfmKK/0l/V5fsLaMdRmBzo0hCeg71E
 pyVQERUzh/0gmfKbFjMYXF4Y7SpVpF6xZ7aAcDOFQj0s5TASd/zhEv6S3fRVeJ6nACE5aUoJ
 8Tpg+3aXpxyps3volzxl6XVoo14bwiMjgmTJSejazVXV8c/HVOTooW6L1C2rnhm4s+LWS0W/
 eXIOuTzHMpreuieJJyKAB5S5wrr5CFGybgas7XgeYEKIRiEHHdWx9zZ1aJvfJpWdn0vNxOR1
 h2dBl8DtPLRroouuNjPjubskmtaO7UWI6auJEGCtezeHXCDpgKLmNYQOM7WJmq1fD2vp82fi
 RB9kquU3Asvxgga6uKR0t9DkMoD2jcYj+UHlV88QyuXPgvD53EJCiDu4PSjf5Zlntdx0TZak
 GrWkjWGEd1l4P/YLWM=
IronPort-HdrOrdr: A9a23:lRCHlqlZzZSEcjSRQa3F8T9TXMDpDfID3DAbv31ZSRFFG/FwWf
 rAoB0+726QtN9xYgBDpTnuAsO9qB/nmKKdpLNhWYtKPzOW21dATrsC0WKK+VSJcBEWtNQ86U
 4KScZD4bPLYWRSvILT/BS4H9E8wNOO7aykwdvFw2wFd3AMV0mlhD0Jczpy1SZNNW97OaY=
X-Talos-CUID: =?us-ascii?q?9a23=3AXp24JGsFh2/+uU3Er4puKZVJ6IsaS2Dky3KOAXb?=
 =?us-ascii?q?gV1ZlE4+LFwao9vN7xp8=3D?=
X-Talos-MUID: 9a23:w5wbjQrd+hl7jmlbCOUez2FwENVQyr+VMV5XnbMnlpG7NxZVHTjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,258,1719878400"; 
   d="scan'208";a="266251567"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 21:45:26 +0000
Received: from localhost ([10.239.198.28])
	(authenticated bits=0)
	by rcdn-core-5.cisco.com (8.15.2/8.15.2) with ESMTPSA id 48PLjMBV025421
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 25 Sep 2024 21:45:25 GMT
Date: Thu, 26 Sep 2024 00:45:18 +0300
From: Ariel Miculas <amiculas@cisco.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Gary Guo <gary@garyguo.net>,
        Yiyang Wu <toolmanp@tlmp.cc>, rust-for-linux@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 03/24] erofs: add Errno in Rust
Message-ID: <20240925214518.fvig2n6cop3sliqy@amiculas-l-PF3FCGJH>
References: <20240916135634.98554-1-toolmanp@tlmp.cc>
 <20240916135634.98554-4-toolmanp@tlmp.cc>
 <20240916210111.502e7d6d.gary@garyguo.net>
 <2b04937c-1359-4771-86c6-bf5820550c92@linux.alibaba.com>
 <ac871d1e-9e4e-4d1b-82be-7ae87b78d33e@proton.me>
 <9bbbac63-c05f-4f7b-91c2-141a93783cd3@linux.alibaba.com>
 <239b5d1d-64a7-4620-9075-dc645d2bab74@proton.me>
 <20240925154831.6fe4ig4dny2h7lpw@amiculas-l-PF3FCGJH>
 <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80cd0899-f14c-42f4-a0aa-3b8fa3717443@linux.alibaba.com>
X-Authenticated-User: amiculas@cisco.com
X-Outbound-SMTP-Client: 10.239.198.28, [10.239.198.28]
X-Outbound-Node: rcdn-core-5.cisco.com

On 24/09/26 12:35, Gao Xiang wrote:
> Hi Ariel,
> 
> On 2024/9/25 23:48, Ariel Miculas wrote:
> 
> ...
> 
> > I share the same opinions as Benno that we should try to use the
> > existing filesystem abstractions, even if they are not yet upstream.
> > Since erofs is a read-only filesystem and the Rust filesystem
> > abstractions are also used by other two read-only filesystems (TarFS and
> > PuzzleFS), it shouldn't be too difficult to adapt the erofs Rust code so
> > that it also uses the existing filesystem abstractions. And if there is
> > anything lacking, we can improve the existing generic APIs. This would
> > also increase the chances of upstreaming them.
> 
> I've expressed my ideas about "TarFS" [1] and PuzzleFS already: since
> I'm one of the EROFS authors, I should be responsible for this
> long-term project as my own promise to the Linux community and makes
> it serve for more Linux users (it has not been interrupted since 2017,
> even I sacrificed almost all my leisure time because the EROFS project
> isn't all my paid job, I need to maintain our internal kernel storage
> stack too).
> 
> [1] https://lore.kernel.org/r/3a6314fc-7956-47f3-8727-9dc026f3f50e@linux.alibaba.com
> 
> Basically there should be some good reasons to upstream a new stuff to
> Linux kernel, I believe it has no exception on the Rust side even it's
> somewhat premature: please help compare to the prior arts in details.
> 
> And there are all thoughts for reference [2][3][4][5]:
> [2] https://github.com/project-machine/puzzlefs/issues/114#issuecomment-2369872133
> [3] https://github.com/opencontainers/image-spec/issues/1190#issuecomment-2138572683
> [4] https://lore.kernel.org/linux-fsdevel/b9358e7c-8615-1b12-e35d-aae59bf6a467@linux.alibaba.com/
> [5] https://lore.kernel.org/linux-fsdevel/20230609-nachrangig-handwagen-375405d3b9f1@brauner/
> 
> Here still, I do really want to collaborate with you on your
> reasonable use cases.  But if you really want to do your upstream
> attempt without even any comparsion, please go ahead because I
> believe I can only express my own opinion, but I really don't
> decide if your work is acceptable for the kernel.
> 

Thanks for your thoughts on PuzzleFS, I would really like if we could
centralize the discussions on the latest patch series I sent to the
mailing lists back in May [1]. The reason I say this is because looking
at that thread, it seems there is no feedback for PuzzleFS. The feedback
exists, it's just scattered throughout different mediums. On top of
this, I would also like to engage in the discussions with Dave Chinner,
so I can better understand the limitations of PuzzleFS and the reasons
for which it might be rejected in the Linux Kernel. I do appreciate your
feedback and I need to take my time to respond to the technical issues
that you brought up in the github issue.

However, even if it's not upstream, PuzzleFS does use the latest Rust
filesystem abstractions and thus it stands as an example of how to use
them. And this thread is not about PuzzleFS, but about the Rust
filesystem abstractions and how one might start to use them. That's
where I offered to help, since I already went through the process of
having to use them.

[1] https://lore.kernel.org/all/20240516190345.957477-1-amiculas@cisco.com/

> > 
> > I'm happy to help you if you decide to go down this route.
> 
> Again, the current VFS abstraction is totally incomplete and broken
> [6].

If they're incomplete, we can work together to implement the missing
functionalities. Furthermore, we can work to fix the broken stuff. I
don't think these are good reasons to completely ignore the work that's
already been done on this topic.

By the way, what is it that's actually broken? You've linked to an LWN
article [2] (or at least I think your 6th link was supposed to link to
"Rust for filesystems" instead of the "Committing to Rust in the kernel"
one), but I'm interested in the specifics. What exactly doesn't work as
expected from the filesystem abstractions?

[2] https://lwn.net/Articles/978738/

> 
> I believe it should be driven by a full-featured read-write fs [7]
> (even like a simple minix fs in pre-Linux 1.0 era) and EROFS will

I do find it weird that you want a full-featured read-write fs
implemented in Rust, when erofs is a read-only filesystem.

> use Rust in "fs/erofs" as the experiment, but I will definitely
> polish the Rust version until it looks good before upstreaming.

I honestly don't see how it would look good if they're not using the
existing filesystem abstractions. And I'm not convinced that Rust in the
kernel would be useful in any way without the many subsystem
abstractions which were implemented by the Rust for Linux team for the
past few years.

Cheers,
Ariel

> 
> I really don't want to be a repeater again.
> 
> [6] https://lwn.net/SubscriberLink/991062/9de8e9a466a3faf5
> [7] https://lore.kernel.org/linux-fsdevel/ZZ3GeehAw%2F78gZJk@dread.disaster.area
> 
> Thanks,
> Gao Xiang
> 
> > 
> > Cheers,
> > Ariel
> 

