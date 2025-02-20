Return-Path: <linux-fsdevel+bounces-42140-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C22AA3CECE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 02:36:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825D2189B1C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 01:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65DA18E025;
	Thu, 20 Feb 2025 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvOfCIKx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15E13DDD3;
	Thu, 20 Feb 2025 01:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740015402; cv=none; b=jMwJ2dY/ZMdXwCn96BM8bHcYzoLS5ISWfVByXSH6A16vlRrSClPP/mhsBRne/4Pt/yo6qKDAEDTCNA+TPwpANhxBDnEBY+/4gKKpXi0rfYVUAUtVWkB3DanJ8Tv+EEM2hi2xDIEzb2Sq7ooiPAIvbmaMl70UusNQ4amG+98Vhaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740015402; c=relaxed/simple;
	bh=G7y5fZLYoCEA0WNpfSVGiEZ6Ecj45M7vMtWV4gOanfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EChyGG4r6bbi5DzRIECjVwrJFirHx6BpP+9fuVoQa7R2ExGlQ5TEUlQIG1LgvfJTn/RSQJaK7lyiOaHRPk+JK4OGQPU8nXu5dtovnzpbDCaQUzh69xpL0MTP3rSc+utYnXWE8gbHJI3OUsorykZSeHCdNpYy9+1uH821/ehgWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvOfCIKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E22C4CED1;
	Thu, 20 Feb 2025 01:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740015401;
	bh=G7y5fZLYoCEA0WNpfSVGiEZ6Ecj45M7vMtWV4gOanfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mvOfCIKxl1lj+zRaUv8U9NLsUnIYAcyxAZOgLBlRinINl4IAPXAgCMAtvLO7mR3Ec
	 CwjdWKs6riRCSL1DMi7Zbo3udxyBt7UnFgjux3yCPiKfIzWRtiIgdJjZXSuIOu0pQc
	 xI9XY+tbsnDYFVgtLGEfuHtRnH+IcGQmyNgkn26RchIeXeucScLiggqQQHCqAB8kcz
	 UoWN2trQdGUoMq81xRTXE9JOHr40keD3qaiBMIh/zvrp9iGKkCN9MC33JoSfwfhnfz
	 8ZdAPNCIwsOoOVsKQ5JCa3TR2OlYgjuGf5WYA99Oa7TLaMqV5IQ1T2fTAQdxU7rwWO
	 9enxpPej/NULw==
Date: Wed, 19 Feb 2025 17:36:37 -0800
From: Kees Cook <kees@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jan Kara <jack@suse.cz>, Michael Stapelberg <michael@stapelberg.ch>,
	Brian Mak <makb@juniper.net>,
	Christian Brauner <brauner@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] binfmt_elf: Dump smaller VMAs first in ELF cores
Message-ID: <202502191731.16FBB1EB@keescook>
References: <036CD6AE-C560-4FC7-9B02-ADD08E380DC9@juniper.net>
 <20250218085407.61126-1-michael@stapelberg.de>
 <39FC2866-DFF3-43C9-9D40-E8FF30A218BD@juniper.net>
 <a3owf3zywbnntq4h4eytraeb6x7f77lpajszzmsy5d7zumg3tk@utzxmomx6iri>
 <202502191134.CC80931AC9@keescook>
 <CAHk-=wgiwRrrcJ_Nc95jL616z=Xqg4TWYXRWZ1t_GTLnvTWc7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgiwRrrcJ_Nc95jL616z=Xqg4TWYXRWZ1t_GTLnvTWc7w@mail.gmail.com>

On Wed, Feb 19, 2025 at 04:39:41PM -0800, Linus Torvalds wrote:
> On Wed, 19 Feb 2025 at 11:52, Kees Cook <kees@kernel.org> wrote:
> >
> > Yeah, I think we need to make this a tunable. Updating the kernel breaks
> > elftools, which isn't some weird custom corner case. :P
> 
> I wonder if we could also make the default be "no sorting" if the
> vma's are all fairly small...
> 
> IOW, only trigger the new behavior when nity actually *matters*.
> 
> We already have the code to count how big the core dump is, it's that
> 
>                 cprm->vma_data_size += m->dump_size;
> 
> in dump_vma_snapshot() thing, so I think this could all basically be a
> one-liner that does the sort() call only if that vma_data_size is
> larger than the core-dump limit, or something like that?
> 
> That way, the normal case could basically work for everybody, and the
> system tunable would be only for people who want to force a certain
> situation.
> 
> Something trivial like this (ENTIRELY UNTESTED) patch, perhaps:
> 
>   --- a/fs/coredump.c
>   +++ b/fs/coredump.c
>   @@ -1256,6 +1256,10 @@ static bool dump_vma_snapshot(struct
> coredump_params *cprm)
>                   cprm->vma_data_size += m->dump_size;
>           }
> 
>   +       /* Only sort the vmas by size if they don't all fit in the
> core dump */
>   +       if (cprm->vma_data_size < cprm->limit)
>   +               return true;
>   +
>           sort(cprm->vma_meta, cprm->vma_count, sizeof(*cprm->vma_meta),
>                   cmp_vma_size, NULL);
> 
> Hmm?

Oh! That's a good idea. In theory, a truncated dump is going to be
traditionally "unusable", so a sort shouldn't hurt tools that are
expecting a complete dump.

Brian, are you able to test this for your case?

-Kees

-- 
Kees Cook

