Return-Path: <linux-fsdevel+bounces-19356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD18C3859
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 22:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700A71F21D6C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 20:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A663537E9;
	Sun, 12 May 2024 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fChSPcYi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5510949;
	Sun, 12 May 2024 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715545214; cv=none; b=NDqUhssaqV0ybIP+q88JCHpt9W8zYLcjvl4gHwPd0gdITSOopBFM8xVshmOjIn1NnsCv4DK/CEXSsSu/Tyr+OFydwRkxMsE3XExSCVftHEzLMJSv+7F0Ztag/mrzcdkJszIVhrMByM6XJjhShm8BX3z+9po4CMU+tuoJO/wqvZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715545214; c=relaxed/simple;
	bh=lPELNgbhGwSVRuDhodKqmPBqUVaZ8iha52M89DSyFM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odhcasAwz1QxpbA0JQMoctL8eidRA0zEFKNbKDGpy9K8XbZ/rIslf7U0rQ8MjcshEmRF46xIYAGaqsiMnf9xft69TYSSdWICM79QMjGI3+aZLCtASEWdwbIu2sLaie8GiJo1j5/eKHZm4ollzZZIYGmsGbWWIx8sw3BSy27HjhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fChSPcYi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=+7g3F+helJJcn5pjYF5PEHb/D+StZeBk57kcYCoFLFE=; b=fChSPcYiTY/qj0ED3CUwT4LdOn
	wFHQ6302DMMO9f0vuE3BA2Novq2UpKnsfqoy1Xgm/6AEHQ5uDrXRM70t/EJbnXIOrUPP10TAOMQcU
	RC/y7WmzsszUGeGD71QCYk3ZjAXxC5szRxyMC/GckYkpgKMM9wHjmZwkJTyKcCvy2/vPk1elcLqlm
	Dwd3LYb809fdXWqOVOWNw1otk3Bu6e2KoEFRL5120ORoDkEyZMAJ4jWJxtRwLx3NfdsYuo9Z5bQnR
	kmtW80ESDvtFe6KpQyaDCiqxywYOpuao6sL6bMqZG7Zdhe0/8xSueARwKMAR3aiPzZP+0V+oN7ECv
	aYUTw3sQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6Ffz-0000000AkKX-116I;
	Sun, 12 May 2024 20:20:07 +0000
Date: Sun, 12 May 2024 13:20:07 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: Steve French <smfrench@gmail.com>, Amir Goldstein <amir73il@gmail.com>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"kdevops@lists.linux.dev" <kdevops@lists.linux.dev>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: kdevops BoF at LSFMM
Message-ID: <ZkEkdz1ccfjtZ3LS@bombadil.infradead.org>
References: <CAB=NE6XyLS1TaAcgzSWa=1pgezRjFoy8nuVtSWSfB8Qsdsx_xQ@mail.gmail.com>
 <CAOQ4uxigKrtZwS4Y0CFow0YWEbusecv2ub=Zm2uqsvdCpDRu1w@mail.gmail.com>
 <CAH2r5mt=CRQXdVHiXMCEwtyEXt-r-oENdESwF5k+vEww-JkWCg@mail.gmail.com>
 <E2589F86-7582-488C-9DBB-8022D481AFB3@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E2589F86-7582-488C-9DBB-8022D481AFB3@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, May 08, 2024 at 05:54:50PM +0000, Chuck Lever III wrote:
> 
> 
> > On May 8, 2024, at 1:45 PM, Steve French <smfrench@gmail.com> wrote:
> > 
> > I would be very happy if there were an easy way to do three things
> > faster/easier:
> > 1) make it easier to run a reasonably large set of fs tests automatically
> > on checkin of a commit or set of commits (e.g. to an externally visible
> > github branch) before it goes in linux-next, and a larger set
> > of test automation that is automatically run on P/Rs (I kick these tests
> > off semi-manually for cifs.ko and ksmbd.ko today)
> > 2) make it easier as a maintainer to get reports of automated testing of
> > stable-rc (or automate running of tests against stable-rc by filesystem type
> > and send failures to the specific fs's mailing list).  Make the tests run
> > for a particular fs more visible, so maintainers/contributors can note
> > where important tests are left out against a particular fs
> 
> In my experience, these require the addition of a CI
> apparatus like BuildBot or Jenkins -- they are not
> directly part of kdevops' mission.

Song Liu and Paul E Luse will have a talk on Wednesday about using a
CI framework for md/raid. The holy grail I think here is that they
have used their experience with eBPF patchwork CI integration, and
I think everyone likely wants something similar:

https://patchwork.kernel.org/project/netdevbpf/list/

The S / W / F is Success / warning/ fail.

I'd like to see how we can do that for kdevops. The work is already
put in place to ramp up complex workflows, now we just have to launch
them and collect information.

> Scott Mayhew and
> I have been playing with BuildBot, and there are some
> areas where integration between kdevops and BuildBot
> could be improved (and could be discussed next week).

Neat!

> > 3) make it easier to auto-bisect what commit regressed when a failing test
> > is spotted
> 
> Jeff Layton has mentioned this as well. I don't think
> it would be impossible to get kdevops to orchestrate
> a bisect, as long as it has an automatic way to decide
> when to use "git bisect {good|bad}"

Kent alreeady seems to have this working too, we should try to see what
we can leverage.

  Luis

