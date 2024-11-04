Return-Path: <linux-fsdevel+bounces-33630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE059BC035
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 22:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976CB1F22850
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 21:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1101FCF54;
	Mon,  4 Nov 2024 21:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Co2uEtQt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F3A1CDFBE;
	Mon,  4 Nov 2024 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730756316; cv=none; b=FQXYbKuW6btAWukxhiU1QjWoelnQr1crrdyN55jc5iCso5RXjRbf31TgVsA7wRcZLSJ+cVoqo9RzYAaaTMaDW10dY6jhpW6gGnPxUKhfiWb4uuh1c/McFcPKOJPhrW7w7UpZK9u+J1PE4atlzaDrLVIg9FfryosV45Mei7N3XSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730756316; c=relaxed/simple;
	bh=WwBZK0JB5bJHyGasmcj/L8/Envcc8v3532gInv1sJ/I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pwDzTdWbcC1d5iXanz8NpdgCWp0D/+75Lnt3HxI4dtXpMf//MxKg7ZODlguMMOt0fz3ePIlEE2m2O5kXOrRYg/c1yIhrgURL5wPQ64Mi1jhZY0R3LbvQjnpn7A84KPQ6Kr7kAwsUsF0yV+7XrrFuVV5XoPoH/340aUDmJEAigKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Co2uEtQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10236C4CECE;
	Mon,  4 Nov 2024 21:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730756315;
	bh=WwBZK0JB5bJHyGasmcj/L8/Envcc8v3532gInv1sJ/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Co2uEtQt0SYWN/uVQ8wieRC7EHb2o4A0t5p5W8viVE7GGxZJMu4laOwivRh0DqQnk
	 gewQq4bFlkQa/k+pWap14rQjNpT3cK2mzTskebMAZswHXL5zsbOTylRg7rDJO9DoSu
	 ve1ju0QIq0U2PPofuCoqgwp5qdylE8rnkPFuEewY=
Date: Mon, 4 Nov 2024 13:38:34 -0800
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
Message-Id: <20241104133834.e0e138038a111c2b0d20bdde@linux-foundation.org>
In-Reply-To: <ZykEtcHrQRq-KrBC@google.com>
References: <20241025012304.2473312-1-shakeel.butt@linux.dev>
	<20241025012304.2473312-6-shakeel.butt@linux.dev>
	<iwmabnye3nl4merealrawt3bdvfii2pwavwrddrqpraoveet7h@ezrsdhjwwej7>
	<CAOUHufZexpg-m5rqJXUvkCh5nS6RqJYcaS9b=xra--pVnHctPA@mail.gmail.com>
	<ZykEtcHrQRq-KrBC@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 4 Nov 2024 10:30:29 -0700 Yu Zhao <yuzhao@google.com> wrote:

> On Sat, Oct 26, 2024 at 09:26:04AM -0600, Yu Zhao wrote:
> > On Sat, Oct 26, 2024 at 12:34 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > >
> > > On Thu, Oct 24, 2024 at 06:23:02PM GMT, Shakeel Butt wrote:
> > > > While updating the generation of the folios, MGLRU requires that the
> > > > folio's memcg association remains stable. With the charge migration
> > > > deprecated, there is no need for MGLRU to acquire locks to keep the
> > > > folio and memcg association stable.
> > > >
> > > > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> > >
> > > Andrew, can you please apply the following fix to this patch after your
> > > unused fixup?
> > 
> > Thanks!
> 
> syzbot caught the following:
> 
>   WARNING: CPU: 0 PID: 85 at mm/vmscan.c:3140 folio_update_gen+0x23d/0x250 mm/vmscan.c:3140
>   ...
> 
> Andrew, can you please fix this in place?

OK, but...

> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3138,7 +3138,6 @@ static int folio_update_gen(struct folio *folio, int gen)
>  	unsigned long new_flags, old_flags = READ_ONCE(folio->flags);
>  
>  	VM_WARN_ON_ONCE(gen >= MAX_NR_GENS);
> -	VM_WARN_ON_ONCE(!rcu_read_lock_held());
>  
>  	do {
>  		/* lru_gen_del_folio() has isolated this page? */

it would be good to know why this assertion is considered incorrect? 
And a link to the sysbot report?

Thanks.

