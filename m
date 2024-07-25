Return-Path: <linux-fsdevel+bounces-24222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B655A93BBDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 06:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43306B2287C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 04:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9651C6A3;
	Thu, 25 Jul 2024 04:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="AW56FVoi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388E417565;
	Thu, 25 Jul 2024 04:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721883307; cv=none; b=f15Zd8SzOUsE6sCw+pJ+LqMqEgaMDR9Et0OevTiOIIrZsQ6D6WiqoMf6TCPZFQeRzJD2/45sgf84sx2gtD2+0hr+sOb+ZazqARmYsm93ATocXYcVOZsL5272wzpVzBba65GP57Rxvzk9TLc3XGITxKlAmvA5msvQ4RfDqtdZNgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721883307; c=relaxed/simple;
	bh=1b7IngO0nwhRuFvE2bz2TnqMfK9MlvsriuEpIKDmME8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAiH4z6Ad09mGv/baMS3qfW+7Ar5B9XEMXCtPu7zowLb+O8EOafxkSqRVJCUrWv4djbVKAPN2768VJjXvqM49FEHkTxeD/mBkGhVn2LTWMXIHziex/zBBzK+lcYFAwHbK1VDIyOUfEeN9ftxyT6Anq27OrK4AgP79Y2xdhWFInY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=AW56FVoi; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1721882893; bh=1b7IngO0nwhRuFvE2bz2TnqMfK9MlvsriuEpIKDmME8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AW56FVoiMFQI7NZdf7NyRNjl+svP8U6sDkonqHDyckp40y+jNf+ErPhSkMwy8AEel
	 DzdirLTXqEHdYScRuQqAOpn4j1SYdktfTRtkCPy7VnIr0D+iQz0JhH4Dv2bS07a4Fj
	 G2OrkmwuKeS80xHT17GSZscBPHdsEWvYVZ/L14x0=
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 25 Jul 2024 06:48:12 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 0325480023;
	Thu, 25 Jul 2024 06:48:13 +0200 (CEST)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id E8A5F181BCF; Thu, 25 Jul 2024 06:48:12 +0200 (CEST)
Date: Thu, 25 Jul 2024 06:48:12 +0200
From: Nicolas Schier <n.schier@avm.de>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, brauner@kernel.org,
	viro@zeniv.linux.org.uk, masahiroy@kernel.org, ojeda@kernel.org,
	djwong@kernel.org, kvalo@kernel.org
Subject: Re: [PATCH] scripts: add macro_checker script to check unused
 parameters in macros
Message-ID: <20240725-interesting-annoying-mammoth-6bb3ef@buildd>
References: <20240723091154.52458-1-sunjunchao2870@gmail.com>
 <20240723150931.42f206f9cd86bc391b48c790@linux-foundation.org>
 <CAHB1NagAwSpPzLOa6s9PMPPdJL5dpLUuq=W3t4CWkfLyzgGJxA@mail.gmail.com>
 <20240724194313.01cfc493b253cbe1626ec563@linux-foundation.org>
 <CAHB1NagB0-N777xzODLe19YBV1UJn4YGuUo67-O9cgKKgc-CLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB1NagB0-N777xzODLe19YBV1UJn4YGuUo67-O9cgKKgc-CLg@mail.gmail.com>
X-purgate-ID: 149429::1721882892-97E5D4D6-E06623CF/0/0
X-purgate-type: clean
X-purgate-size: 1070
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Wed, Jul 24, 2024 at 11:05:43PM -0400, Julian Sun wrote:
> Andrew Morton <akpm@linux-foundation.org> 于2024年7月24日周三 22:43写道：
> >
> > On Wed, 24 Jul 2024 22:30:49 -0400 Julian Sun <sunjunchao2870@gmail.com> wrote:
> >
> > > I noticed that you have already merged this patch into the
> > > mm-nonmm-unstable branch.
> >
> > Yup.  If a patch looks desirable (and reasonably close to ready) I'll
> > grab it to give it some exposure and testing while it's under
> > development, To help things along and to hopefully arrive at a batter
> > end result.
> >
> > > If I want to continue refining this script,
> > > should I send a new v2 version or make modifications based on the
> > > current version?
> >
> >
> > > Either is OK - whatever makes most sense for the reviewers.  Reissuing
> > > a large patch series for a single line change is counterproductive ;)
> Thanks for your clarification. I will send a new patch based on the
> current version.

Hi Julian,

can you please Cc linux-kbuild in v2?

Kind regards,
Nicolas

