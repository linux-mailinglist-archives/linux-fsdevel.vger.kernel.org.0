Return-Path: <linux-fsdevel+bounces-38845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6523EA08CBA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 10:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93225188E5AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 09:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBFB209F31;
	Fri, 10 Jan 2025 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIFsE3fM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7120C00C
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502300; cv=none; b=WSk+riaLLemAKWnRsn67s1edR7ztMf/lMOKQSgoEAW4OC0V3ttSN8+u1djVoO45YHhPyUVJIoBlDhjop8Gzoz59TkErcDx4HxYx6u2PfxloYo0o+sWsEV60iISACJlGImKfKpBl/nyZRbqXqNNs1oCVJcSA79zlMnllylZq6DTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502300; c=relaxed/simple;
	bh=ENLLV/0PrVWHZJnSd10hwquS1U8BMVZB3K1bFjotxyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M/C6IkUg3drukrMLIGgeOXip5IjUxeVrKQqz2qbS1w75UEMtFbkF371D8s2apJgQMHwewskKxj0lMpEeR6R2KyBY8M6REaoM0hCUuhO8cBJEbRjcutT5ZZrmmtoQ6qreNeKKRBm+PHPCpV8paT2Sa5vzF6B8fAOcun0LtGUCqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIFsE3fM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736502295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4Kw1qoNYerqhNjh25Dgp7jdmE++mW9Fl3ZiJ8T3co8=;
	b=UIFsE3fM8ZpT28RgTD/VWrQgEAnTkGjPT7UbRMlcM0A3WZUp3DhNJ0v0QFBh450AL2dUF2
	1rk+agWGcGiZ9i74yLeJbYlEoWeR6NzBDaiJjp4lAMBOkt46WyA1BMrDxOCmGN/VpP3McP
	TQbg59XT+08yYB3kLiyn5GjAlHUungM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-xk-d25fUOvq6Dxcpv6WmJg-1; Fri, 10 Jan 2025 04:44:54 -0500
X-MC-Unique: xk-d25fUOvq6Dxcpv6WmJg-1
X-Mimecast-MFC-AGG-ID: xk-d25fUOvq6Dxcpv6WmJg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d51ba2f5so969367f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 01:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736502293; x=1737107093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4Kw1qoNYerqhNjh25Dgp7jdmE++mW9Fl3ZiJ8T3co8=;
        b=F6awzvbmk/4/gXI9a48vCTn3FiYi5pQVKDNOZBqQCJ7CSLx/g6SrpX3Mp8fqzFR5/x
         5+2kGOC5jcbSvIno8CpUeku72nJgGKKYMcQHUAAU6neG1DrOQyfcZ1GwJAIkkJEIae/W
         bcMLW4a0rIEDw3WjyLs66nf/Q+f1b9VbyEium0h2//klKro3QtDPfgCyGb0DUr5H3cNF
         lo95D6BlD3UCYj+38jsR0/jR60Iamtc+k/l84inC/tBnS4tMydDKlnck64TO7zFQ5BIb
         exEetU81+Fz5z8f/Dzyk+X8vm/eKQldSvTq99BaGmlQbIC9h7yiU6wvfZGRnhiq+wHa+
         8CPA==
X-Gm-Message-State: AOJu0YyMtgjFEtJiZGXr18bgzqzs1PQskeHn4ah8BRe6dTGZhyMzjMye
	I1bEZ93LNRqtUKDguIR7uA+a9Aphgg45lH8LFihu4Ne2xBBngMRtuSjSgvwCx+dJhQfkwkXXOST
	FwgZOTiWM97lVbv1A8ATJtRw0mGpM0Jz7+s3eLtJeHboPZ2xjfHoioeods64DpEnYqOQxj0kb
X-Gm-Gg: ASbGncv7sFRGIrjuv/PhUzlFl/BkjlCL0SAdIJB6cN95f8xU6fhu4c0Htm7ecO4fjxX
	q50znSyvZ3dkv2tJGUWksyFRHW7jeC1q2IZzLqoB3tqe+PAYA6Po0tI7WjBtjzjjVijXUoElLZQ
	bTpCRs5BHc0m0bGzjh/1wdTHBSTvOyO9SxHTyRVF0EaUwOq9xDrySCBVFfPS3a+Tncta039JJ8q
	8pqoq4DuIZKTGFlff5KBIiGJMgJtCT7PQaTZDNR2PUQBvN31c/JJMh1byqGRXWXCEO0zJKwDHG/
X-Received: by 2002:a05:6000:709:b0:386:3803:bbd5 with SMTP id ffacd0b85a97d-38a8733a1f9mr9910107f8f.45.1736502293469;
        Fri, 10 Jan 2025 01:44:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWMxVaNXeUTe+wjdV2pCbQXCctILb5vVg9f3+psJOjGS23Sr767uuQBsbyCemBlGukLyZjgw==
X-Received: by 2002:a05:6000:709:b0:386:3803:bbd5 with SMTP id ffacd0b85a97d-38a8733a1f9mr9910059f8f.45.1736502293124;
        Fri, 10 Jan 2025 01:44:53 -0800 (PST)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383965sm4140444f8f.31.2025.01.10.01.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:44:52 -0800 (PST)
Date: Fri, 10 Jan 2025 10:44:51 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	chris@zankel.net, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <4ad35w4mrxb4likkqijkivrkom5rpfdja6klb5uoufdjdyjioq@ksxubq4xb7ei>
References: <20250109174540.893098-1-aalbersh@kernel.org>
 <e7deabf6-8bba-45d7-a0f4-395bc8e5aabe@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7deabf6-8bba-45d7-a0f4-395bc8e5aabe@app.fastmail.com>

On 2025-01-09 20:59:45, Arnd Bergmann wrote:
> On Thu, Jan 9, 2025, at 18:45, Andrey Albershteyn wrote:
> >
> >  arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
> >  arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
> >  arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
> >  arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
> >  arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
> >  arch/s390/kernel/syscalls/syscall.tbl       |   2 +
> >  arch/sh/kernel/syscalls/syscall.tbl         |   2 +
> >  arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
> >  arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
> >  arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
> >  arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
> 
> You seem to be missing a couple of files here: 
> 
> arch/arm/tools/syscall.tbl
> arch/arm64/tools/syscall_32.tbl
> arch/mips/kernel/syscalls/syscall_n32.tbl
> arch/mips/kernel/syscalls/syscall_n64.tbl
> arch/mips/kernel/syscalls/syscall_o32.tbl
> 
>        Arnd
> 

Thanks! Added

-- 
- Andrey


