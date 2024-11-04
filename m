Return-Path: <linux-fsdevel+bounces-33640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207EB9BC0C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 23:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C531C220BB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 22:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461081FDFBC;
	Mon,  4 Nov 2024 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cTVpqxqx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7721A1FDF9B;
	Mon,  4 Nov 2024 22:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758715; cv=none; b=XrPlFkiKQhkM2y9N3svjUhx3hUBbbEYRzhp0n5P5dyz88L/gKyaM4XWnb1ElQWDtXO2jOnwUgRB2GtTf1ECZW230XvO+wqSTXF98JlfBpcnrMs13A1sTHLkv1iQZph+08/JiJ2OMUEL5r44HFnQGOIqFtzLw2Pi/Fj4RHTt5mf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758715; c=relaxed/simple;
	bh=bZVCcEDLTWFLC6Yv2DcTeKjA09yueP5Uek2v1WAoKK8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XNI6cHMLytvGMAcAdddMZV/8b8jWsCpugvlN2eDai0pKGg7bOr/rPyxBxI4mCCxwsVi96VrRl3vSXmcWV123GR4UJgTlwlpWYXANDB3yuIRjqWzHsYafYYXbge55r2dGDcthocL1XLlJ5p9kVlZ34wmUAKTYlcL4v+0rWQXYZy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cTVpqxqx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B596C4CECE;
	Mon,  4 Nov 2024 22:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730758715;
	bh=bZVCcEDLTWFLC6Yv2DcTeKjA09yueP5Uek2v1WAoKK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cTVpqxqx/q3YShRhLM9GTA7g+G5oQJJqAFH5cmmF351bScmptSfdAzmnQu0Eviefp
	 ZWIlpcocv68SUxF+DKJnxcDcbEHCr3t2FO33ROeT32VbFbxmEs9QOCUItO1mi4PnDG
	 Ddjm2AgM/XPSqQzttet1pSi0ATh3sY0mzoNaC5zU=
Date: Mon, 4 Nov 2024 14:18:34 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner
 <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman Gushchin
 <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, Hugh
 Dickins <hughd@google.com>, Yosry Ahmed <yosryahmed@google.com>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, Meta kernel team
 <kernel-team@meta.com>
Subject: Re: [PATCH v1 5/6] memcg-v1: no need for memcg locking for MGLRU
Message-Id: <20241104141834.fc30ea90bbc80446d0fcf1f0@linux-foundation.org>
In-Reply-To: <CAOUHufZ=SMN=GWMjvpDxiXxyMAvDDc4eEzYvAWP4=7atT7SX7g@mail.gmail.com>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
	<20241025012304.2473312-6-shakeel.butt@linux.dev>
	<iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
	<CAOUHufZexpg-m5rqJXUvkCh5nS6RqJYcaS9b=xra--pVnHctPA@mail.gmail.com>
	<ZykEtcHrQRq-KrBC@google.com>
	<20241104133834.e0e138038a111c2b0d20bdde@linux-foundation.org>
	<CAOUHufbA6GN=k3baYdvLN_xSQvX0UgA7OCeqT8TsWLEW7o=y9w@mail.gmail.com>
	<CAOUHufZ=SMN=GWMjvpDxiXxyMAvDDc4eEzYvAWP4=7atT7SX7g@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Nov 2024 15:08:09 -0700 Yu Zhao <yuzhao@google.com> wrote:

> > The assertion was caused by the patch in this thread. It used to
> > assert that a folio must be protected from charge migration. Charge
> > migration is removed by this series, and as part of the effort, this
> > patch removes the RCU lock.
> >
> > > And a link to the sysbot report?
> >
> > https://syzkaller.appspot.com/bug?extid=24f45b8beab9788e467e
> 
> Or this link would work better:
> 
> https://lore.kernel.org/lkml/67294349.050a0220.701a.0010.GAE@google.com/

Thanks, I pasted everyone's everything in there, so it will all be
accessible by the sufficiently patient.


