Return-Path: <linux-fsdevel+bounces-28706-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B5C96D2D2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 11:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15379B2597C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2A11974FE;
	Thu,  5 Sep 2024 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih5G5kbe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB598F66;
	Thu,  5 Sep 2024 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527421; cv=none; b=mJGoNiA4YR7d1m5Hs6IRdrLGgXYVwfLiFErjOSXmJzPIEhn+BslGRsqseiXkgmzRuqISuOO05LNlPNU4we4To2NiW1Mg/CdrzmiZ0AYRbkflDrubvwAQTjs50Hp9TA5hOqjG48Pj1MJdjeKnxVmJmuY8St/m9B3UFhGJYXzlOL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527421; c=relaxed/simple;
	bh=JGZhXJsR6XfTFowF4ULW2XRND6LFrLq1GdhXRAd6tCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXuSv46Jmx1Nr37fXTRLNxJspA0YMmOL9JmkkDS7BGdzNGIBgrYuDKgm8q8jxTnFCsKo3+xtORgX0PbvPCKXYobnb0KmH8dw0B0VvfAqYY8sXgy2kBujo8XhCXw4cRCxFRnTqCqS+dWV8Z1Zurx8+AKwKA8Z8rdZ0b2XT55CjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih5G5kbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41141C4CEC3;
	Thu,  5 Sep 2024 09:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725527420;
	bh=JGZhXJsR6XfTFowF4ULW2XRND6LFrLq1GdhXRAd6tCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ih5G5kbeFCoOUyhHe1H4pEUmmI+4QcqOwEIs6KgPVUU/v+eeEEletrP5rOU6JBAum
	 Pb2HHR/EEzjr0u1HpyJlbQkdZBFNev7kbwUpNl5/ezULJ3D+7gG70Pp/hTan/IMN7h
	 BeW4fYXF+Op3yLT4fBZsRwnbNvNO/qXSdFqtiYIPZ+aMR1mfy/AaGJRfS/5MYpUsKI
	 9e+eTRThGbzIJEeMBzdlYg8XriP0JKGZpnDNR//c8tCremSWzMfBDPa6qQTr6GXH6Y
	 8v3XzhbnApfkIeyF0Imuy7116zWpyNbYykHR8E8LXOHsC74yaCt22hINxJsG5ybDo4
	 3v3AHwpVOpQ9Q==
Date: Thu, 5 Sep 2024 11:10:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, 
	Christian Brauner <christianvanbrauner@gmail.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [brauner-vfs:work.f_version.wip.v1] [proc] e85c0d9e72:
 WARNING:lock_held_when_returning_to_user_space
Message-ID: <20240905-wegschauen-intellektuell-c180f82feafe@brauner>
References: <202409032134.c262dced-lkp@intel.com>
 <20240903-lehrgang-gepfercht-7fe83a53f87d@brauner>
 <ZtkSVZ47t9+KjHGK@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtkSVZ47t9+KjHGK@xsang-OptiPlex-9020>

On Thu, Sep 05, 2024 at 10:07:17AM GMT, Oliver Sang wrote:
> hi, Christian Brauner,
> 
> On Tue, Sep 03, 2024 at 03:59:19PM +0200, Christian Brauner wrote:
> > On Tue, Sep 03, 2024 at 09:53:05PM GMT, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed "WARNING:lock_held_when_returning_to_user_space" on:
> > > 
> > > commit: e85c0d9e725529a5ed68ad0b6abc62b332654156 ("proc: wean of off f_version")
> > > https://git.kernel.org/cgit/linux/kernel/git/vfs/vfs.git work.f_version.wip.v1
> > 
> > This is once again an old branch that's dead and was never sent.
> > Can you please exclude anything that has a *.v<nr> suffix? I thought I
> > already added a commit to this effect to the repository.
> 
> got it. seems previous deny pattern has a small problem.
> 
> Philip just pushed a fix [1]
> 
> at the same time, we noticed for v<nr>, there are two different styles in 3
> repos owned by your that we are monitoring.
> style #1: _v<nr>
> style #2: .v<nr>
> 
> should we deny both or handle them differently for different repo?

I think only using the .v<nr> style is fine.

Thank you! :)

