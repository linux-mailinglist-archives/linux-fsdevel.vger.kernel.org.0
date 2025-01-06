Return-Path: <linux-fsdevel+bounces-38422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEE2A02438
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 12:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF3C7A2CB7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 11:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333231DC9A3;
	Mon,  6 Jan 2025 11:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqytaXf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F58812BF24;
	Mon,  6 Jan 2025 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736162553; cv=none; b=GtnfbHIRAn+f4uqkiPC3m61aNbNHuOqfaEv1RpX6sO1ZITiRfyElo+iUqSBR1AEoPo2hFHPz47Nkbw+oQL8POCX7RFn6cNi8mlu3C0e2J2yjNi/NVxkB694UOEhYuFcecNpuHbebH4QLUJSARJ2YtfXOe1LGy3rPtJbm1Q6VlEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736162553; c=relaxed/simple;
	bh=YFa9n4kRGb7FoyqSu+bxpz+vwRWZ9zT3kNRGUT1JfBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBT1yzBoM0Dj2fwW5hyl9H7hvNi/uS49Y+6s2TNuQLlKIoAvbAM0uA6+kgHC08P0YtcfAJNMplBhNTDhDjGPogrWvU1P5tr967BCfGCCeJF4klWeWmnDu6bhXV7fUNVR1/xsgqDU1nojfRQ9pbyMnjrWeNdZ0rx3fQreop96qQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EqytaXf/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0F7C4CED2;
	Mon,  6 Jan 2025 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736162553;
	bh=YFa9n4kRGb7FoyqSu+bxpz+vwRWZ9zT3kNRGUT1JfBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EqytaXf/7ROrApNQc7+jdeEXSnG0XyB08a51lNqhal39rNrVGwnNgN+u/Z8hIhmce
	 d2yxLhvWHE7J1n1GOk/CTpKIHOHrGQLdUcpmORwyzHesjm2dJGzfoj2kRVelTG1MK/
	 GuV+fcIovomL/5xMd9TeNwkdviLgqUTGyQRwSokQuZImy34o/4wgB9eZJOa5q3YoyQ
	 zQRq6cyE9aOlPY+E1XL2LROe2WtvmgyA8HetkqILqy4ZfmOCIOrcqnvQmm0u9C11Tt
	 dEuIwGkTD9dQfEuPHY4KvFZfnIdzF5adD5QpmOAO6aC5I81zMi2mq+qter+pNgSLS0
	 p3RjUmiAeK7pQ==
Date: Mon, 6 Jan 2025 12:22:27 +0100
From: Joel Granados <joel.granados@kernel.org>
To: yukaixiong <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	kees@kernel.org, j.granados@samsung.com, willy@infradead.org, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, lorenzo.stoakes@oracle.com, trondmy@kernel.org, 
	anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	jmorris@namei.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, 
	haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com, shikemeng@huaweicloud.com, 
	dchinner@redhat.com, bfoster@redhat.com, souravpanda@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, pasha.tatashin@soleen.com, david@redhat.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, yang@os.amperecomputing.com, 
	zev@bewilderbeest.net, serge@hallyn.com, vegard.nossum@oracle.com, 
	wangkefeng.wang@huawei.com
Subject: Re: Re: [PATCH v4 -next 00/15] sysctl: move sysctls from vm_table
 into its own files
Message-ID: <3elcftj5bn5iqfdly4cgmzpz4kodqrdl6dnqyqvn5fxjgmoxw4@yactmy2fbdkm>
References: <20241223141550.638616-1-yukaixiong@huawei.com>
 <42tsyuvdvym6i3j4ppsluvx7kejxjzbma5z4jjgccni6kuwtj7@rhuklbyko7yf>
 <ceb3be0a-f035-aaec-286f-8ba95e62deba@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb3be0a-f035-aaec-286f-8ba95e62deba@huawei.com>

On Sat, Dec 28, 2024 at 09:40:50PM +0800, yukaixiong wrote:
> 
> 
> On 2024/12/28 20:15, Joel Granados wrote:
> > On Mon, Dec 23, 2024 at 10:15:19PM +0800, Kaixiong Yu wrote:
> >> This patch series moves sysctls of vm_table in kernel/sysctl.c to
> >> places where they actually belong, and do some related code clean-ups.
> >> After this patch series, all sysctls in vm_table have been moved into its
> >> own files, meanwhile, delete vm_table.
...
> >>    sysctl: remove unneeded include
> > This patchset looks strange. There seems to be 15 patches, but there are
> > 30 e-mails in the thread? You can also see this when you look at it in
> > lore [1]. And they are different repeated e-mails (mutt does not
> > de-duplicate them). Also `b4 shazam ...` does not work. What happened?
> > Did you send it twice with the same mail ID? Am I the only one seeing
> > this?
> >
> > I would suggest the following (hopefully you are using b4):
> > 1. Check to see how things will be sent with b4. `b4 send --resend -o OUTPUT_DIR`
> >     If you see 30 emails in that dir from your patchset then something is
> >     still wrong.
> > 2. After you make sure that everything is in order. Do the resend
> >     without bumping the version up (leave it at version 4)
> >
> > Best
> >
> > [1] : https://lore.kernel.org/all/20241223141550.638616-1-yukaixiong@huawei.com/
> 
> I'm very sorry, due to my mistake, 15 patches were sent twice.
No worries. I saw that you have re-sent the patchset and it seems that
this time there is only 15 mails. I see that you are only using my
j.granados@samsung.com ID; can you please add my kernel.org
(joel.granados@kernel.org) mail to the future mails that you send (no
need to re-send v4).

Thx

...

-- 

Joel Granados

