Return-Path: <linux-fsdevel+bounces-16740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6238A1F74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 21:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE88D1C23254
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 19:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382CB175A6;
	Thu, 11 Apr 2024 19:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UuT0npXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743391756A
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 19:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712863475; cv=none; b=JbFPZ4DMN6Su8iN2Hd6iYDtHahy92exjfjhRs/t46gE0/dWOhH/EZKVefInDLE56rLeSISBoXXCg6Pudf8XHje4xgyXd6kHzPoOvak6MYCOw21fByoK0dw1+oTkonrSTZu4HFuIP4qCy/tgrz1AFAXYjbXyx0j+rcQ00ZuHOvoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712863475; c=relaxed/simple;
	bh=DzLnX9XsQiartOGOi9eoGYyN8RsdHsWoqQTIIKeZbk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW0ZXUgW8PkZDRwi7H1S5Yqpy9l89UH5JnZVBLuagpggU4XMX9TnA0FDBtLS0yPYrPHmo3zxTz3W7EoACGDiDXhXNLrhmcMiS7a3MssKQ5KVvqHCZWEbiAUiInATdb7x0EaqwwyTCwMb+VHKfU8D053RZiT88QwMHALm7g2DfgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UuT0npXS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zcd3JbmGh0UbQSyR0oz9b076V96dHCA3CnyHpKlr+pk=; b=UuT0npXS+rRO7p8tKXAdcYEI/l
	rqSypCun03HIPGcqBlCCl2yUj0aNFXj3PaQ8sL4wEMk/KrxV1MMofFMRq1eILq+V3n8mB3QZAw48H
	Du/JDoLMmFOoeHKThqSHKrIG7AV2GgTuBaS4cG8t0Y9vVxr2VZawXIAKZblAgpojE3my7+zYfY+ZB
	mzxzGHOFIx07P1QZX1miXEITEqyFc4jRYdIMop54avJVeq6JmJb8g23UhOIdfhzdlm/VVD2ygHv4G
	bwxNf7QgUG67tfy9yiCWV7pzj11GLEKxTxtexDjMG9EYUM5euZGRmpYNalWLocP80m/QVo3XP1gQg
	JWjg01aQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv02D-0000000Dstu-1ZNc;
	Thu, 11 Apr 2024 19:24:33 +0000
Date: Thu, 11 Apr 2024 12:24:33 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Leah Rumancik <leah.rumancik@gmail.com>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem testing
Message-ID: <Zhg48VVXfQiFTAJq@bombadil.infradead.org>
References: <87h6h4sopf.fsf@doe.com>
 <87cyrre5po.fsf@mailhost.krisman.be>
 <Zfi62v5FWDeajwLq@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfi62v5FWDeajwLq@dread.disaster.area>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Tue, Mar 19, 2024 at 09:06:18AM +1100, Dave Chinner wrote:
> On Mon, Mar 18, 2024 at 02:48:51PM -0400, Gabriel Krisman Bertazi wrote:
> > +1 for the idea of having this in fstests.  Even if we
> > lack the infrastructure to do anything useful with it in ./check,
> > having them in fstests will improve collaboration throughout
> > different fstests wrappers (kernelci, xfstests-bld, etc.)
> 
> Except that this places the maintenance burden on fstests, in
> an environment where we can do -nothing- to validate the correctness
> of these lists, nor have any idea of when tests should or
> shouldn't be placed in these lists.
> 
> i.e. If your test runner needs to expunge tests for some reason,
> either keep the expunge lists with the test runner, or add detection
> to the test that automatically _notrun()s the test in enviroments
> where it shouldn't be run....
> 
> I'd much prefer the improvement of _notrun detection over spreading
> the expunge file mess further into fstests. THis helps remove the
> technical debt (lack of proper checking in the test) rather than
> kicking it down the road for someone else to have to deal with in
> future.
> 
> Centralisation of third party expunge file management is not the
> answer.  We should be trying to reduce our reliance on expunges and
> the maintenance overhead they require, not driving that expunge file
> maintaintenance overhead into fstests itself...

kdevops has been using expunges since day 1 and shared them. We have one
per filesystem test section and parallelize each test section. While
useful for a baseline, over time I have to agree that a desirable goal
is to not rely on them. But that just means your test runner can deal
with crashes automatically. That is work we've been doing for kdevops
and hope to get there.

That does not preclude the value of a baseline for a kernel too though
test section section. While I agree that it will depend on your
version of fstests and userspace too, its worthwile asking if a generic
kernel baseline is desirable. The answer to this really is about scaling
and doing the work.

An example of a baseline of known critical failures for v6.6:

https://github.com/linux-kdevops/kdevops/blob/main/docs/xfs-bugs.md

Is something like this useful? If so, should we collaborate on a central
one? How?

   Luis

