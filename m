Return-Path: <linux-fsdevel+bounces-29268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5AE9775F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 02:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0ACAB230C4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2024 00:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E80139D;
	Fri, 13 Sep 2024 00:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="APGBleqb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39997E6;
	Fri, 13 Sep 2024 00:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726186722; cv=none; b=axXI3Bo3Ce8ny0Qp2ako9Ox4/rOqp1zCH3Hy/bQZml/vQTp4Kqv34CcT/4zpanqpPtRp+YRapX+tb/xHHS2anrAxxtcOllgOWHEchXn//spvC45Rafqw/fhfz90pZpQLOW/5Ia3KBo7DWh9xuRALwNijrjwWdnt92y2vWlh3usk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726186722; c=relaxed/simple;
	bh=ta9UGHqsKIT/CmwWwUupJscP6n4DdkOjUD4jjj8Sfhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ylslaj+oFuv3WPorGAyFQlk7dSO3QpGqn/M7kc00BA9V5El/5bT9JEtWjdmSV94HYYmhw7NOAP0sGQoKZOgqEZFwAEnqd06OoVyeHP95TYeOyheyoLPlBA43tMbJf5SRIFqLRcMLp7MtJJ2ZNP+KbnjcFPJVwQrekjNZ9p3WwBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=APGBleqb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=I3f0tKoE21HkuJlvVi1WDV1pzooCugULc3vdTAczGWM=; b=APGBleqb+CYEYKeA0FLWrjb27p
	xpCvJObDASkMHo8SzENu7/M8vtyoXD7RjklhmyAHusDznQw69ZJFZgTZ9TcNfxwX1+16dz9i0Q2xg
	MgAmMwLpBYIfacuJWr0qGZJL9UMoQdfdTKxSu/MrKgFp0t33KaENTN/Z3WCP8sjyJyRyZKW2RXdJm
	rsXJpVURCa31Ubphtd8ltCvZe/AcqsY51Q+zdSZruxgganSui3J1//Mn1r4vJv74xUGpE0l1agKhO
	xmNM5n7F0rwmwWgPk+BNzkLWefLrutXl8Ew2WkgW4kO3TesfcPnk99EPW+OAbDOVhAr3+C02VdqUw
	ncVbsG8Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sou1F-0000000BoYh-2RFu;
	Fri, 13 Sep 2024 00:18:37 +0000
Date: Fri, 13 Sep 2024 01:18:37 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: viro@kernel.org, brauner@kernel.org, bpf@vger.kernel.org,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 0/8] BPF follow ups to struct fd refactorings
Message-ID: <20240913001837.GO1049718@ZenIV>
References: <20240813230300.915127-1-andrii@kernel.org>
 <CAEf4BzY4v6D9gusa+fkY1qg4m-yT8VVFg2Y-++BdrheQMp+j6Q@mail.gmail.com>
 <20240912235756.GN1049718@ZenIV>
 <CAEf4BzZpkZfkpHozso8myJ=2kOxto0fXPew=XVLu=wXi8bi4iw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZpkZfkpHozso8myJ=2kOxto0fXPew=XVLu=wXi8bi4iw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Sep 12, 2024 at 05:10:57PM -0700, Andrii Nakryiko wrote:
> On Thu, Sep 12, 2024 at 4:57 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Tue, Aug 27, 2024 at 03:55:28PM -0700, Andrii Nakryiko wrote:
> > > > They were also merged into bpf-next/for-next so they can get early testing in
> > > > linux-next.
> >
> > Umm...  I see that stuff in bpf-next/struct_fd, but not in your for-next.
> 
> We have a new process with for-next and my merge was probably
> accidentally dropped at some point... But there was definitely a
> period of time when these patches were in for-next, so they got some
> compile-testing already and should be good to go.

I should've pushed the base branch into #for-next; mea culpa...

