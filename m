Return-Path: <linux-fsdevel+bounces-58788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08C3B31747
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 14:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D84BB62D12
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 12:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7512FB62B;
	Fri, 22 Aug 2025 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wn6OWavu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E582FAC12;
	Fri, 22 Aug 2025 12:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864854; cv=none; b=Xi6Hv4ra2W/MNsdDGEdHJgGZa7XR3lPuSwKTsc5YSH5ewKjrmQuqc/o+9jYuplIKbcUq3+8mLMC5KgqiFRSv9QK6kmJL0YPbuELWQ9Sww9h0264SbOpqC7Qv+j17inRA1niYhFa3CKwRThLZx/evyrBSvhuYSAlpJs/eLfS07rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864854; c=relaxed/simple;
	bh=XebrtUmoMkJk2ywQK0G1KR8BcZhBHmQQQZC6S0DWuAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLroZGPnTWWqCRaR29LRtSfTym4cg7ifdK3xLs8FtYtTVjUpOUKDaDxp+cMi7/+4g1ytBjKG7mSYjPoqj9sebWeXgky9P956mC7RMCc5lpfp7OFHo8ZKqTaMwB73+eRTfg7v2x69vQH4axhmgRtn5HL6HI8E7FDy8RjpmTtGa4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wn6OWavu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5421AC4CEED;
	Fri, 22 Aug 2025 12:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755864853;
	bh=XebrtUmoMkJk2ywQK0G1KR8BcZhBHmQQQZC6S0DWuAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wn6OWavu9Zhmk0yyzgBKNH3ykhrK9F24bTidvvcy1hUyZqXSYfj5wI7QlJDeg6jSE
	 k9DOJopRPjyw4EXB7CoY3RM4WdhCCeHdUMsaHeIehRuAhi2XqkLdMdJDJ61x5bd4VJ
	 AV9yLKKykf1rkz3yjpCI/BhO3NmqX8LZtFhDt0wk=
Date: Fri, 22 Aug 2025 14:14:10 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Zhang Yi <yi.zhang@huaweicloud.com>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, Joseph Qi <jiangqi903@gmail.com>,
	Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	Anders Roxell <anders.roxell@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Ben Copeland <benjamin.copeland@linaro.org>
Subject: Re: [PATCH 6.16 000/564] 6.16.2-rc2 review
Message-ID: <2025082242-skyward-mascot-f992@gregkh>
References: <20250819122844.483737955@linuxfoundation.org>
 <CA+G9fYsjac=SLhzVCZqVHnHGADv1KmTAnTdfcrnhnhcLuko+SQ@mail.gmail.com>
 <aKg41GMffk9t1p56@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKg41GMffk9t1p56@stanley.mountain>

On Fri, Aug 22, 2025 at 12:31:00PM +0300, Dan Carpenter wrote:
> On Wed, Aug 20, 2025 at 08:06:01PM +0530, Naresh Kamboju wrote:
> > On Tue, 19 Aug 2025 at 18:02, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.16.2 release.
> > > There are 564 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Thu, 21 Aug 2025 12:27:23 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.2-rc2.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > As I have reported last week on 6.16.1-rc1 as regression is
> > still noticed on 6.16.2-rc2.
> > 
> > WARNING: CPU: 0 PID: 7012 at fs/jbd2/transaction.c:334 start_this_handle
> > 
> > Full test log:
> > ------------[ cut here ]------------
> > [  153.965287] WARNING: CPU: 0 PID: 7012 at fs/jbd2/transaction.c:334
> > start_this_handle+0x4df/0x500
> 
> The problem is that we only applied the last two patches in:
> https://lore.kernel.org/linux-ext4/20250707140814.542883-1-yi.zhang@huaweicloud.com/
> 
> Naresh is on vacation until Monday, but he tested the patchset on
> linux-next and it fixed the issues.  So we need to cherry-pick the
> following commits.
> 
> 1bfe6354e097 ext4: process folios writeback in bytes
> f922c8c2461b ext4: move the calculation of wbc->nr_to_write to mpage_folio_done()
> ded2d726a304 ext4: fix stale data if it bail out of the extents mapping loop
> 2bddafea3d0d ext4: refactor the block allocation process of ext4_page_mkwrite()
> e2c4c49dee64 ext4: restart handle if credits are insufficient during allocating blocks
> 6b132759b0fe ext4: enhance tracepoints during the folios writeback
> 95ad8ee45cdb ext4: correct the reserved credits for extent conversion
> bbbf150f3f85 ext4: reserved credits for one extent during the folio writeback
> 57661f28756c ext4: replace ext4_writepage_trans_blocks()
> 
> They all apply cleanly to 6.16.3-rc1.

Ugh.  Ok, let me go push out a -rc for JUST this issue now so that
people can test and I can get it released for those that are tripped up
by it.  Thanks for the information, much appreciated.

greg k-h

