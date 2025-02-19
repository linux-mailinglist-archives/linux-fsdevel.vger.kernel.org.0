Return-Path: <linux-fsdevel+bounces-42063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5588A3BDD5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 13:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4133A99B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2025 12:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A857F1DFE32;
	Wed, 19 Feb 2025 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sdwpvn88"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72631BD4E4;
	Wed, 19 Feb 2025 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967216; cv=none; b=idRTBhOupZUklHxxhh1pvv4lAreBtgqFjhm7p2tRnHL4B6EHgL61O766gIWFpUQKnn5I6HDxcSxydlEdacb55fB02Ot6WD/WKpLpapFgKN4uJutdf+SAxjVe71fmK9ciZYcqQzVpux/HimR25P/DiJs/s5tm8K5Cr0uKsj4x4TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967216; c=relaxed/simple;
	bh=VwZvAjw6hrQKHNmoh6jgmw70TBaConXEcu8BQE9Ymbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkbiNzRHXlNQMNSpHTpgvzAZVOiMoXPI5xV5403kfuN8EqBK4mRochLkW0luPo8nhqiSzPkjVXflpdKcVC2XESsJXjvqzc6RPky+CZtn5K/7DL3a1ThuDyB1Sba2TBZvrl2cTNf+hk25RVAnY0NFlmykXyD0SDmwrbETeSOg7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sdwpvn88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37CFC4CED1;
	Wed, 19 Feb 2025 12:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739967215;
	bh=VwZvAjw6hrQKHNmoh6jgmw70TBaConXEcu8BQE9Ymbs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdwpvn88YqYn+PFnG/VmA6j5cmCZfbkJa0i5Cs+LZQt5dXQSGcZTxEL/0KeLMYYl/
	 UFxkcA4dBqGez51nO+VC+/fspD6+etar/FDZKN0IvjV/7KupJYA+oWu2Cbd7JK6JBs
	 TDEWnQPHp2pGaXO3fkphVMRt0Bpql3vyOC8gjEig=
Date: Wed, 19 Feb 2025 13:13:32 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Herbert Xu <herbert@gondor.apana.org.au>, willy@infradead.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Yang Shi <yang@os.amperecomputing.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 6.6 000/389] 6.6.76-rc2 review
Message-ID: <2025021901-silenced-phonebook-9b81@gregkh>
References: <20250206155234.095034647@linuxfoundation.org>
 <CA+G9fYvKzV=jo9AmKH2tJeLr0W8xyjxuVO-P+ZEBdou6C=mKUw@mail.gmail.com>
 <CA+G9fYtqBxt+JwSLCcVBchh94GVRhbo9rTP26ceJ=sf4MDo61Q@mail.gmail.com>
 <2025021739-jackpot-lip-09f9@gregkh>
 <CA+G9fYtJzD8+BkyBZEss9Vvv2f=8tJUcSyWDGjyOshj1D5hMyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtJzD8+BkyBZEss9Vvv2f=8tJUcSyWDGjyOshj1D5hMyA@mail.gmail.com>

On Wed, Feb 19, 2025 at 05:16:19PM +0530, Naresh Kamboju wrote:
> On Mon, 17 Feb 2025 at 17:07, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Feb 17, 2025 at 05:00:43PM +0530, Naresh Kamboju wrote:
> > > On Sat, 8 Feb 2025 at 16:54, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> > > >
> > > > On Thu, 6 Feb 2025 at 21:36, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > This is the start of the stable review cycle for the 6.6.76 release.
> > > > > There are 389 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > >
> > > > > Responses should be made by Sat, 08 Feb 2025 15:51:12 +0000.
> > > > > Anything received after that time might be too late.
> > > > >
> > > > > The whole patch series can be found in one patch at:
> > > > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.76-rc2.gz
> > > > > or in the git tree and branch at:
> > > > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> > > > > and the diffstat can be found below.
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > >
> > > > There are three different regressions found and reporting here,
> > > > We are working on bisecting and investigating these issues,
> > >
> > > We observed a kernel warning on QEMU-ARM64 and FVP while running the
> > > newly added selftest: arm64: check_hugetlb_options. This issue appears
> > > on 6.6.76 onward and 6.12.13 onward, as reported in the stable review [1].
> > > However, the test case passes successfully on stable 6.13.
> > >
> > > The selftests: arm64: check_hugetlb_options test was introduced following
> > > the recent upgrade of kselftest test sources to the stable 6.13 branch.
> > > As you are aware, LKFT runs the latest kselftest sources (from stable
> > > 6.13.x) on 6.12.x, 6.6.x, and older kernels for validation purposes.
> > >
> > > >From Anders' bisection results, we identified that the missing patch on
> > > 6.12 is likely causing this regression:
> > >
> > > First fixed commit:
> > > [25c17c4b55def92a01e3eecc9c775a6ee25ca20f]
> > > hugetlb: arm64: add MTE support
> > >
> > > Could you confirm whether this patch is eligible for backporting to
> > > 6.12 and 6.6 kernels?
> > > If backporting is not an option, we will need to skip running this
> > > test case on older kernels.
> >
> > The test case itself should properly "skip" if the feature is not
> > present in the kernel.  Why not fix that up instead?
> 
> The reported test gets PASS at the end, but generates kernel warning
> while running the test case (always reproducible) on 6.12 and 6.6.
> 
> The reported warning was not seen on stable 6.13.

So this implies that userspace can cause a kernel warning?  That means
it can cause a DoS, that's not good at all.

So the commit you mention actually fixes a bug then?  Otherwise this
feels really odd, as that means that any kernel without that change can
crash this way.  What changed to cause this to happen?

thanks,

greg k-h

