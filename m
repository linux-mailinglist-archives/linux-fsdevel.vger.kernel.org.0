Return-Path: <linux-fsdevel+bounces-22690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1492891B132
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 23:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45F9A1C22581
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 21:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD4D1A0719;
	Thu, 27 Jun 2024 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="graBvNMx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A127347F;
	Thu, 27 Jun 2024 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719522688; cv=none; b=uJTd4joqrTNPMf4XrgiNPtjPp18JmfoHIQLbww687+tsNheiAbyqQyrrQPYwJki8CB3q4SswJuGeRcLezXsKwYd1iVGiT/NiL58Qbob44kiQBwdQKZzBi0LiMIdgTJgNE0krkr0XngiuK/JR/RmvYWF8/bTxTocoOlGF0VyqF9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719522688; c=relaxed/simple;
	bh=h4fznHZ9EntuAr9QS1NNKb31QjCnz8JZ/U98Q+re5wM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Nao8o0XvWPI2VW4/XYSysqB/FB5VfhDAbo8D7pGncIl9ntqfsRCWp4LJJ5ZPdgySeJQRRafBCE4g3PAFb65YpKRlzpLEEdHSJjozPYJUlNPuF/UJB5/lSGAiGnahVrUe/cROKf1Pmmk88bBbncsd9lF8cpMl/1DezpyYkl4Ybuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=graBvNMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B704C2BBFC;
	Thu, 27 Jun 2024 21:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719522687;
	bh=h4fznHZ9EntuAr9QS1NNKb31QjCnz8JZ/U98Q+re5wM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=graBvNMx8coJNsHdTjJ9iXpx8DFJ5PLgHyiN9wF+ufjij7NYD/yQDRoACOewsLcGV
	 xwoS4wT25CwQWUBbJJ+gQYG7OtHo1pMdoCj6eu8SC6kXfVppzh+qrQgmuBhEWx4QsG
	 WWuKX0xXfO1kQ40CfL4zAVQ8ZfBWIibD5SZlogXo=
Date: Thu, 27 Jun 2024 14:11:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
 brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org,
 liam.howlett@oracle.com, surenb@google.com, rppt@kernel.org,
 adobriyan@gmail.com
Subject: Re: [PATCH v6 0/6] ioctl()-based API to query VMAs from
 /proc/<pid>/maps
Message-Id: <20240627141126.2ce3b4981e4f580713e31be0@linux-foundation.org>
In-Reply-To: <CAEf4BzaNOrMWB=nimR-UD8-MrC37kHQi6fh1hBv+aPWvoiSm5A@mail.gmail.com>
References: <20240627170900.1672542-1-andrii@kernel.org>
	<20240627125938.da3541c6babfe046f955df7a@linux-foundation.org>
	<CAEf4BzaNOrMWB=nimR-UD8-MrC37kHQi6fh1hBv+aPWvoiSm5A@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 27 Jun 2024 13:50:22 -0700 Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Thu, Jun 27, 2024 at 12:59 PM Andrew Morton
> > Is it possible/sensible to make this feature Kconfigurable so that people who
> > don't need it can omit it?
> 
> It's just a matter of #ifdef/#endif, so not hard, technically
> speaking. But I'm wondering what's the concern? This is mostly newly
> added code (except factoring out get_vma_name logic, which won't be
> #ifdef'ed anyways), so if no one is using this new API, then it should
> cause no issue.
> 
> Generally speaking, I'd say if we don't *have to* add the Kconfig
> option, I'd prefer that. But if you feel strongly, it's not hard for
> me to do, of course.
> 
> Or are you concerned with the vmlinux code size increase? It doesn't
> seem to be large enough to warrant a Kconfig, IMO (from
> bloat-o-meter):
> 
> do_procmap_query                               -    1308   +1308
> get_vma_name                                   -     283    +283
> procfs_procmap_ioctl                           -      47     +47
> show_map_vma                                 444     274    -170
> 
> But again, do let me know if you insist.

Yes, I'm thinking about being nice to small systems ("make
tinyconfig"!).  The kernel just gets bigger and bigger over time,
little bit by little bit.

It's a judgment call - if making it configurable is ugly and/or adds
maintenance overhead then no.


